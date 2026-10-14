#!/usr/bin/env python3
"""Declara los bloques de datos que el codigo LEE, recorriendolos como el cartucho.

Un rango de datos no se declara porque sobre: se declara porque hay una
instruccion que lo lee. Cada bloque sale de un LECTOR del listado (la
rutina que recorre el formato y la llamada que le pasa el puntero), y su
final sale de RECORRER el formato como lo recorre esa rutina.

La mayor parte sale sola: el trazador de cartucho entero (tools/bancos.py)
apunta cada llamada con el reparto de bancos y lo que llevan HL y DE en ese
momento. Si una llamada va a un lector de LECTORES con el puntero conocido,
el bloque se declara con el reparto de esa llamada.

Los lectores (las rutinas que recorren cada formato) se van anadiendo a
LECTORES_DE / LECTORES_HL segun se leen en el listado.

Lo que sale se escribe, banco a banco, en una seccion delimitada de
src/pNN.notes que esta herramienta reescribe entera; lo de fuera no lo toca.
Un bloque que pise codigo trazado o una D escrita a mano NO se escribe: se
avisa, porque algo esta mal y hay que mirarlo.

Uso: bloques.py              informa de lo que encontraria
     bloques.py --escribe    y lo escribe en las notas
"""
import json
import os
import sys
from collections import defaultdict

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
sys.path.insert(0, AQUI)
from paginas import ORG, TAM_PAGINA, N_PAGINAS, nombre             # noqa: E402
from rom import ROM, leer, palabra, banco                          # noqa: E402

CAB = "# --- BLOQUES QUE LEE EL CODIGO (seccion que reescribe tools/bloques.py; no editar a mano) ---"
FIN = "# --- fin de los bloques de bloques.py ---"

BLOQUES = []       # dict(p, ini, fin, nombre, texto, lectores, F)
AVISOS = []


def declara(trio, ini, fin, nom, texto, lectores, F=None):
    """Un bloque [ini, fin) de la ventana con el reparto puesto; si cruza de
    banco se parte y cada trozo dice de donde viene y a donde sigue."""
    if fin <= ini:
        AVISOS.append("bloque vacio %s en %04X" % (nom, ini))
        return
    if isinstance(lectores, str):
        lectores = [lectores]
    if fin > 0xC000 or ini < 0x4000:
        AVISOS.append("bloque %s %04X-%04X se sale de la ventana: no se declara" % (nom, ini, fin))
        return
    a = ini
    while a < fin:
        b = banco(trio, a)
        tope = ORG[b] + TAM_PAGINA if b else 0x6000
        z = min(fin, tope)
        t = texto
        if a > ini:
            t += " (sigue del banco %d)" % banco(trio, a - 1)
        if z < fin:
            t += " (sigue en el banco %d, en 0x%04X)" % (banco(trio, z), z)
        BLOQUES.append(dict(p=b, ini=a, fin=z, nombre=nom if a == ini else nom + "_cola",
                            texto=t, lectores=list(lectores), F=F))
        a = z


# ---------------------------------------------------------------- formatos

def fin_graficos(trio, a, con_direccion=False):
    """L_5A03: hasta el 0; 0x80 trae dos bytes de direccion de VRAM."""
    if con_direccion:
        a += 2
    while True:
        n = leer(trio, a)
        a += 1
        if n == 0:
            return a
        if n == 0x80:
            a += 2
        elif n < 0x80:
            a += 1
        else:
            a += n & 0x7F


def fin_bytes_vram(trio, a):
    """L_59C2: [direccion] y bytes; 0xFE [direccion]; 0xFF acaba."""
    a += 2
    while True:
        c = leer(trio, a)
        a += 1
        if c == 0xFF:
            return a
        if c == 0xFE:
            a += 2


def graficos(trio, a, nom, que, lector, con_direccion=False):
    declara(trio, a, fin_graficos(trio, a, con_direccion), nom,
            ("graficos (L_59FB): [direccion de VRAM] y " if con_direccion else
             "graficos (L_5A2A): ") + "[n] n < 0x80 repite el siguiente, n > 0x80 "
            "copia n & 0x7F, 0x80 otra direccion, 0 acaba" + (": " + que if que else ""),
            lector, F=16)


def bytes_vram(trio, a, nom, lector):
    declara(trio, a, fin_bytes_vram(trio, a), nom,
            "bytes a la VRAM (L_59C2): [direccion] y bytes; 0xFE otra direccion, "
            "0xFF acaba", lector, F=16)


def tabla_de_palabras(trio, a, n, nom, que, lector):
    declara(trio, a, a + 2 * n, nom, "%d palabras: %s" % (n, que), lector, F=2)


# Lectores que reciben el puntero en DE: direccion -> (que hace, funcion)
LECTORES_DE = {
}


LECTORES_HL = {
}


TRAZADOR = []


def automaticos():
    """Las llamadas a un lector con el puntero conocido (tools/bancos.py)."""
    import bancos
    t, _ = bancos.traza_completa(ROM, os.path.join(RAIZ, "src"))
    TRAZADOR.append(t)
    vistos = set()
    for dest, b, pc, s, hl, de in t.llamadas:
        g = LECTORES_HL.get(dest)
        if g is not None and hl is not None and 0x4000 <= hl < 0xC000                 and (dest, banco(s, hl), hl) not in vistos:
            vistos.add((dest, banco(s, hl), hl))
            g(s, hl, "%s:%04X" % (nombre(b), pc))
        f = LECTORES_DE.get(dest)
        if f is None or de is None or not 0x4000 <= de < 0xC000:
            continue
        clave = (dest, banco(s, de), de)
        if clave in vistos:
            continue
        vistos.add(clave)
        f(s, de, "%s:%04X" % (nombre(b), pc))
    return t


# ---------------------------------------------------------------- el cartucho

def despachadores():
    """Las tablas de los despachadores y de los `jp (hl)`, tal como las mide
    el trazador de cartucho entero (src/pNN.nocode, tools/bancos.py)."""
    for p in range(N_PAGINAS):
        ruta = os.path.join(RAIZ, "src", nombre(p) + ".nocode")
        if not os.path.exists(ruta):
            continue
        for ln in open(ruta, encoding="utf-8"):
            if not ln.startswith("0x"):
                continue
            q = ln.split(None, 2)
            ini, fin = int(q[0], 0), int(q[1], 0)
            BLOQUES.append(dict(p=p, ini=ini, fin=fin, nombre="saltos_%04X" % ini,
                                texto=q[2].strip(), lectores=["el despachador"], F=2))


def relleno():
    """La cola de 0xFF de cada banco, y las tiras de 0xFF de 32 bytes o mas
    que hay entre codigo en mitad de un banco (fuera de lo trazado, y sin
    ninguna instruccion que apunte dentro: lectores.apuntadores)."""
    import lectores
    ap = lectores.apuntadores(TRAZADOR[0])
    for p in range(N_PAGINAS):
        fin = ORG[p] + TAM_PAGINA
        a = fin
        while a > ORG[p] and ROM[p * TAM_PAGINA + (a - 1 - ORG[p])] == 0xFF:
            a -= 1
        if fin - a >= 16:
            BLOQUES.append(dict(p=p, ini=a, fin=fin, nombre="relleno_ff",
                                texto="%d bytes a 0xFF hasta el final del banco: "
                                "relleno" % (fin - a), lectores=["nadie"], F=16))
        cod = codigo_trazado(p)
        i = 0
        while i < a - ORG[p]:
            if ROM[p * TAM_PAGINA + i] != 0xFF or cod[i]:
                i += 1
                continue
            j = i
            while j < a - ORG[p] and ROM[p * TAM_PAGINA + j] == 0xFF and not cod[j]:
                j += 1
            ini, z = ORG[p] + i, ORG[p] + j
            dentro = [w for (d, w) in ap if d == p and ini <= w < z]
            if j - i >= 32 and not dentro:
                BLOQUES.append(dict(p=p, ini=ini, fin=z, nombre="relleno_%04X" % ini,
                                    texto="%d bytes a 0xFF en mitad del banco, sin "
                                    "ninguna instruccion que apunte dentro: relleno"
                                    % (z - ini), lectores=["nadie"], F=16))
            i = j


# ------------------------------------------------------------- escritura

def codigo_trazado(p):
    m = bytearray(TAM_PAGINA)
    ruta = os.path.join(RAIZ, "work", nombre(p) + ".trace.json")
    if os.path.exists(ruta):
        for k, a, b in json.load(open(ruta))["blocks"]:
            if k == "c":
                for i in range(a - ORG[p], b - ORG[p]):
                    m[i] = 1
    return m


def a_mano(p):
    out = []
    ruta = os.path.join(RAIZ, "src", nombre(p) + ".notes")
    if not os.path.exists(ruta):
        return out
    dentro = False
    for ln in open(ruta, encoding="utf-8"):
        if ln.startswith(CAB):
            dentro = True
        elif ln.startswith(FIN):
            dentro = False
        elif not dentro and ln.startswith("D "):
            q = ln.split(None, 3)
            out.append((int(q[1], 0), int(q[2], 0)))
    return out


def junta(bloques):
    """Funde los que se solapan en uno, diciendo cuantos eran."""
    bloques.sort(key=lambda b: (b["ini"], b["fin"]))
    out = []
    for b in bloques:
        if out and b["ini"] < out[-1]["fin"]:
            u = out[-1]
            if (b["ini"], b["fin"]) == (u["ini"], u["fin"]) and b["nombre"] == u["nombre"]:
                for l in b["lectores"]:
                    if l not in u["lectores"]:
                        u["lectores"].append(l)
                continue
            u.setdefault("n", 1)
            u["n"] += 1
            u["fin"] = max(u["fin"], b["fin"])
            for l in b["lectores"]:
                if l not in u["lectores"]:
                    u["lectores"].append(l)
            u["solapa"] = u.get("solapa", "") + " (%s %04X-%04X)" % (b["nombre"], b["ini"], b["fin"])
        else:
            out.append(dict(b, lectores=list(b["lectores"])))
    return out


def partidas():
    """Las instrucciones que empiezan al final de un banco y acaban en el
    siguiente (tools/bancos.py las mide): el trazador de un solo banco no las
    ve enteras, asi que sus dos trozos van como datos con su explicacion."""
    t = TRAZADOR[0]
    for b, pc, n in sorted(t.partidas):
        trio = sorted(t.config_de[(b, pc)])[0]
        bs = bytes(leer(trio, pc + i) for i in range(n))
        fin_banco = (pc & 0xE000) + TAM_PAGINA
        sig = banco(trio, fin_banco)
        declara(trio, pc, fin_banco, "partida_%04X" % pc,
                "los %d primeros bytes de una instruccion de %d (%s) que sigue en el "
                "banco %d: el trazador de un solo banco no puede verla entera "
                "(tools/bancos.py)" % (fin_banco - pc, n, bs.hex(" ").upper(), sig),
                "%s:%04X" % (nombre(b), pc), F=fin_banco - pc)
        declara(trio, fin_banco, pc + n, "partida_%04X" % fin_banco,
                "los %d ultimos bytes de la instruccion de %s:%04X (%s), que empieza "
                "en el banco %d" % (pc + n - fin_banco, nombre(b), pc, bs.hex(" ").upper(), b),
                "%s:%04X" % (nombre(b), pc), F=pc + n - fin_banco)


def restos(p, mascara, lineas):
    """Lo que nadie ha declarado: se dice quien lo apunta con su banco puesto
    (tools/lectores.py), y el tamano es lo que hay hasta lo siguiente."""
    import lectores
    if not hasattr(restos, "ap"):
        restos.ap = lectores.apuntadores(TRAZADOR[0])
    i = 0
    while i < TAM_PAGINA:
        if mascara[i]:
            i += 1
            continue
        j = i
        while j < TAM_PAGINA and not mascara[j]:
            j += 1
        ini, fin = ORG[p] + i, ORG[p] + j
        ls = sorted({(w, b, pc) for (d, w), xs in restos.ap.items() if d == p and ini <= w < fin
                     for b, pc, _ in xs})
        if ls:
            txt = ("lo apuntan con el banco puesto %s; el tamano es lo que hay hasta lo "
                   "siguiente, no sale de recorrerlo" % ", ".join(
                       "%s:%04X (0x%04X)" % (nombre(b), pc, w) for w, b, pc in ls[:6]))
            lect = ["%s:%04X" % (nombre(b), pc) for w, b, pc in ls[:6]]
        else:
            txt = "SIN LECTOR A LA VISTA: ninguna instruccion lo apunta con su banco puesto"
            lect = ["nadie"]
        lineas.append((ini, "D 0x%04X 0x%04X resto_%04X  %s; lo leen %s (%d bytes)"
                       % (ini, fin, ini, txt, ", ".join(lect), fin - ini)))
        lineas.append((ini + 0.5, "F 0x%04X 16" % ini))
        i = j


def main(argv):
    escribe = "--escribe" in argv
    automaticos()
    partidas()
    despachadores()
    relleno()
    por = defaultdict(list)
    for b in BLOQUES:
        por[b["p"]].append(b)
    total = 0
    for p in range(N_PAGINAS):
        cod = codigo_trazado(p)
        mano = a_mano(p)
        lineas = []
        buenos = []
        for b in por.get(p, []):
            pisa = sum(cod[i - ORG[p]] for i in range(b["ini"], b["fin"]))
            if pisa:
                AVISOS.append("%s %04X-%04X %s PISA CODIGO (%d bytes): no se escribe"
                              % (nombre(p), b["ini"], b["fin"], b["nombre"], pisa))
                continue
            if any(b["ini"] < f and i < b["fin"] for i, f in mano):
                AVISOS.append("%s %04X-%04X %s pisa una D a mano: no se escribe"
                              % (nombre(p), b["ini"], b["fin"], b["nombre"]))
                continue
            buenos.append(b)
        mascara = bytearray(cod)
        for i, f in mano:
            for x in range(i, f):
                mascara[x - ORG[p]] = 1
        for b in buenos:
            for x in range(b["ini"], b["fin"]):
                mascara[x - ORG[p]] = 1
        for b in junta(buenos):
            txt = b["texto"]
            if b.get("n"):
                txt += "; se solapan %d bloques:%s" % (b["n"], b["solapa"])
            txt += "; lo leen %s (%d bytes)" % (", ".join(b["lectores"][:8]), b["fin"] - b["ini"])
            lineas.append("D 0x%04X 0x%04X %s  %s" % (b["ini"], b["fin"], b["nombre"], txt))
            if b["F"]:
                lineas.append("F 0x%04X %s" % (b["ini"], b["F"]))
            total += b["fin"] - b["ini"]
        extra = []
        if "--sin-restos" not in argv:
            restos(p, mascara, extra)
        if extra:
            for _, ln in extra:
                if ln.startswith("D "):
                    total += int(ln.split()[2], 0) - int(ln.split()[1], 0)
            lineas = [ln for _, ln in sorted(
                [(int(l.split()[1], 0) + (0.5 if l.startswith("F") else 0), l) for l in lineas] + extra)]
        if lineas:
            print("%s: %d bloques, %d bytes" % (nombre(p), len([l for l in lineas if l.startswith("D ")]),
                                                sum(int(l.split()[2], 0) - int(l.split()[1], 0)
                                                    for l in lineas if l.startswith("D "))))
        if escribe:
            ruta = os.path.join(RAIZ, "src", nombre(p) + ".notes")
            filas = open(ruta, encoding="utf-8").read().split("\n") if os.path.exists(ruta) else ["# Notas del banco %02d" % p, ""]
            if CAB in filas:
                i, f = filas.index(CAB), filas.index(FIN)
                filas[i:f + 1] = [CAB] + lineas + [FIN]
            else:
                while filas and filas[-1] == "":
                    filas.pop()
                filas += ["", CAB] + lineas + [FIN, ""]
            open(ruta, "w", encoding="utf-8", newline="\n").write("\n".join(filas))
    print("total %d bytes" % total)
    for a in AVISOS:
        print("AVISO:", a)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
