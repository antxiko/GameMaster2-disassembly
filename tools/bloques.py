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

Los lectores del banco 0:

  L_5A2A   graficos a la VRAM HL desde DE: [n] n == 0 acaba; n < 0x80 repite
           el byte siguiente n veces; n > 0x80 copia n & 0x7F bytes; 0x80
           trae otra direccion de VRAM y sigue (p00:5A0F salta a p00:59FB).
           L_5A32 lo mismo con cada byte al reves (espejo, p00:5A63).
  L_5972 / L_5976 / L_5986 / L_598C   L_5A2A o L_5A32 dos o tres veces con
           el MISMO DE, una por tercio de la pantalla (HL + 0x800).
  L_59FB   lo mismo, con la direccion de VRAM en las dos primeras palabras.
  L_59C2   [direccion de VRAM] y bytes que escribe uno a uno (WRTVRM);
           0xFE trae otra direccion, 0xFF acaba. L_59D9 lo mismo con C = 0.

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
    0x5A2A: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x5A32: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x5A03: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x5972: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x5976: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x5986: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x598C: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L),
    0x59FB: lambda s, de, L: graficos(s, de, "graficos_%04X" % de, "", L, True),
    0x59C2: lambda s, de, L: bytes_vram(s, de, "vram_%04X" % de, L),
    0x59D9: lambda s, de, L: bytes_vram(s, de, "vram_%04X" % de, L),
}


LECTORES_HL = {
    0x44B8: lambda s, hl, L: dibujo(s, hl, "dibujo_%04X" % hl, "", L),
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


# ---------------------------------------------------------------- el juego

N_SALAS = 567       # p21:64BA tiene una palabra por sala y acaba en p21:6928


def fin_mensaje(trio, a):
    """p00:4EDF: hasta 0xFF; 0xFA acaba tambien, con un byte detras que
    p00:4F9A guarda en 0xE88A."""
    while True:
        c = leer(trio, a)
        a += 1
        if c == 0xFF:
            return a
        if c == 0xFA:
            return a + 1


def tabla_hasta_el_primero(trio, a, tope=64):
    """Palabras desde a hasta la primera direccion a la que apuntan (el
    mensaje va detras de su tabla) o la primera que no es del cartucho."""
    ps = []
    lim = 0xC000
    while a + 2 * len(ps) + 1 < lim and len(ps) < tope:
        p = palabra(trio, a + 2 * len(ps))
        if not 0x6000 <= p < 0xC000:
            break
        if a < p < lim:
            lim = p
        ps.append(p)
    return ps


GRUPO = {0: (21, 22, 23), 1: (24, 25, 26), 2: (21, 27, 28)}


def mensajes(trio, tabla, ps, nom, que, lector, vistos):
    tabla_de_palabras(trio, tabla, len(ps), nom, que, lector)
    for p in ps:
        if (banco(trio, p), p) in vistos:
            continue
        vistos.add((banco(trio, p), p))
        declara(trio, p, fin_mensaje(trio, p), "mensaje_%02d_%04X" % (banco(trio, p), p),
                "mensaje (p00:4EDF): caracteres; 0xFE linea, 0xFD espera una tecla, "
                "0xFC/0xFB/0xF9/0xF8 un nombre, 0xF7 y 0xF6 cambian la letra, 0xFA "
                "acaba con un byte detras, 0xFF acaba", lector, F=16)


def textos():
    """Los mensajes (p00:4DFD-p00:5140)."""
    T = (21, 22, 23)
    L = "p00:4E76"
    declara(T, 0x639E, 0x639E + (N_SALAS + 1) // 2, "grupo_de_mensajes",
            "un nibble por sala (L_43BB con 0xEB40): 0 = bancos 21-22-23, 1 = "
            "24-25-26, 2 = 27-28 (p00:4E6A)", L, F=16)
    tabla_de_palabras(T, 0x64BA, N_SALAS, "mensajes_por_sala",
                      "la tabla de mensajes de cada sala (p00:4EA5: 0x64BA + sala x 2)", L)
    vistos = set()
    for n, a in ((1, 0x6928), (2, 0x6DAC), (3, 0x7080), (4, 0x6DA6)):
        ps = tabla_hasta_el_primero(T, a)
        if n == 4:
            ps = ps[:3]          # despues sigue la tabla 2 (0x6DAC)
        mensajes(T, a, ps, "mensajes_fijos_%d" % n,
                 "los mensajes de 0xE889 = %d (p00:4E83-4E95)" % n, L, vistos)
    nib = [(leer(T, 0x639E + i // 2) >> (0 if i & 1 else 4)) & 15 for i in range(N_SALAS)]
    hechas = set()
    for r in range(N_SALAS):
        w = palabra(T, 0x64BA + 2 * r)
        g = nib[r]
        if (g, w) in hechas or (g == 0 and w in (0x6928, 0x6DAC, 0x7080, 0x6DA6)):
            continue
        hechas.add((g, w))
        S = GRUPO[g]
        ps = tabla_hasta_el_primero(S, w)
        mensajes(S, w, ps, "mensajes_%d_%04X" % (banco(S, w), w),
                 "los mensajes de la sala %d (y de las que apuntan aqui); el tamano, "
                 "hasta el primer mensaje" % r, L, vistos)


def fichas_de_sala():
    """Los juegos de fichas de las salas (p00:47C6, p00:482F, p00:4856)."""
    T = (12, 13, 14)
    L = "p00:47C6"
    declara(T, 0x6000, 0x6120, "juego_de_cada_sala",
            "un nibble por sala (L_43BB con 0xEB40, el alto la sala par): el juego "
            "de fichas 0-13; 576 nibbles, las salas pasan de 0x236 y el resto es 0",
            L, F=16)
    tabla_de_palabras(T, 0x6120, 16, "juegos_de_fichas",
                      "el descriptor de cada juego (L_43A4); los 14 primeros se usan "
                      "y los dos ultimos apuntan al final, 0x64CE", L)
    for k in range(14):
        d = palabra(T, 0x6120 + 2 * k)
        declara(T, d, d + 0x41, "juego_%d" % k,
                "juego de fichas %d: [0xE361, la primera ficha que no se pisa] y las "
                "64 fichas del juego (indices de 0x64CE/0x6C06) que p00:47E8 copia "
                "a la VRAM 0x2080/0x0080" % k, L, F=16)
    declara(T, 0x64CE, 0x6C06, "fichas_patrones",
            "231 fichas de 8 x 8, los patrones (8 bytes cada una: p00:47F5)", L, F=8)
    declara(T, 0x6C06, 0x733E, "fichas_colores",
            "231 fichas de 8 x 8, los colores (8 bytes cada una: p00:480D)", L, F=8)
    L = "p00:4856"
    tabla_de_palabras(T, 0x733E, 17, "graficos_p4856",
                      "graficos que p00:4856 (A - 1) pone en la VRAM 0x2D80; la tabla "
                      "acaba donde empiezan los de p00:4875 (0x7360)", L)
    for k in range(17):
        a = palabra(T, 0x733E + 2 * k)
        graficos(T, a, "graficos_%04X" % a, "entrada %d de la tabla 0x733E" % k, L)
    L = "p00:482F"
    declara(T, 0x7750, 0x7990, "graficos_de_cada_sala",
            "un byte por sala (0x7750 + 0xEB40): la entrada de 0x7990; 576 bytes, las "
            "salas pasan de 0x236 y el resto es 0", L, F=16)
    tabla_de_palabras(T, 0x7990, 16, "graficos_de_sala",
                      "8 x [colores][patrones]: p00:4845 los pone en la VRAM 0x2280 y "
                      "p00:4850 en la 0x0280, en dos tercios (L_5972)", L)
    for k in range(16):
        a = palabra(T, 0x7990 + 2 * k)
        graficos(T, a, "graficos_%04X" % a, "%s de la entrada %d de 0x7990"
                 % ("colores" if k % 2 == 0 else "patrones", k // 2), L)


def fin_lista_sprites(trio, a):
    """p00:4AB1: registros de 4 bytes hasta 0xFF."""
    while leer(trio, a) != 0xFF:
        a += 4
    return a + 1


def banco18():
    """Los graficos de sprites del banco 18 (p00:43DB, 43E9, 4AA0, 4AF9)."""
    T = (18, 19, 20)
    for base, n, L, que in ((0x6000, 9, "p00:43E9", "0xE3C3"),
                            (0x627C, 10, "p00:43DB", "0xE3A1"),
                            (0x65DC, 8, "p00:4AF9", "0xE3C3 o (0xEB74 & 7) x 2 - 2")):
        tabla_de_palabras(T, base, n, "sprites_%04X" % base,
                          "graficos de sprites que %s pone en la VRAM 0x1800 (o "
                          "0x1860) segun %s; el tamano, hasta el primero" % (L, que), L)
        for k in range(n):
            a = palabra(T, base + 2 * k)
            if a:
                graficos(T, a, "graficos_%04X" % a, "sprites, entrada %d de 0x%04X"
                         % (k, base), L)
    L = "p00:4AA0"
    declara(T, 0x67F1, 0x67F1 + N_SALAS, "sprites_de_cada_sala",
            "un byte por sala (0x67F1 + 0xEB40): la lista de 0x6A28 (0-20)", L, F=16)
    tabla_de_palabras(T, 0x6A28, 21, "listas_de_sprites",
                      "21 listas de registros de 4 bytes (p00:4AB1)", L)
    for k in range(21):
        a = palabra(T, 0x6A28 + 2 * k)
        declara(T, a, fin_lista_sprites(T, a), "lista_sprites_%d" % k,
                "registros [c][n][dir lo][dir hi] hasta 0xFF: c bit 0 = 0, graficos "
                "de dir al patron de sprite n (VRAM 0x1800 + 8n, L_5A2A); c bit 0 = "
                "1, copia de patrones de sprite girados (p00:4AD7, L_5A36)", L, F=4)
        b = a
        while leer(T, b) != 0xFF:
            if not leer(T, b) & 1:
                g = palabra(T, b + 2)
                graficos(T, g, "graficos_%04X" % g, "sprite de la lista %d" % k, L)
            b += 4


def fin_opciones(trio, a):
    """p00:5401: [m1][m2], una palabra por bit de m2 y, por cada bit de m1
    que no esta en m2, [n] y n mensajes."""
    m1, m2 = leer(trio, a), leer(trio, a + 1)
    e = a + 2 + 2 * bin(m2).count("1")
    for _ in range(bin(m1 & ~m2 & 0xFF).count("1")):
        e += 1 + leer(trio, e)
    return e


def banco7():
    """Lo que leen p07:82A4 (actores de cada sala), p07:8673 (cuadros) y
    p00:5401 (lo que ofrece cada personaje)."""
    T = (1, 7, 8)
    L = "p07:82A4"
    tabla_de_palabras(T, 0x8BC2, 568, "actores_por_sala",
                      "la lista de actores de cada sala (0x8BC2 + 0xEB40 x 2)", L)
    listas = sorted({palabra(T, 0x8BC2 + 2 * i) for i in range(568)} | {0x9032, 0x904C})
    for a in listas:
        n = leer(T, a)
        declara(T, a, a + 1 + 5 * n, "actores_%04X" % a,
                "[n] y n actores de 5 bytes [c][b, bit 7 aparte][e][d][l] que "
                "p07:82B6 pasa a p07:82FE" + (" (la lista de la sala 0xB0/0xD0 "
                "cuando 0xEB5D tiene el bit 0, p07:8295)" if a in (0x9032, 0x904C) else ""),
                L, F=5)
    L = "p07:8673"
    tabla_de_palabras(T, 0x97E8, 40, "cuadros_de_actor",
                      "el cuadro de cada actor segun (ix+8) (L_43A4)", L)
    declara(T, 0x9838, 0x988E, "cuadros", "los cuadros de 0x97E8: dos sprites "
            "(p07:86C2, p07:86D5) o cuatro fichas (p07:8715-8733); dos o cuatro "
            "bytes cada uno, el ultimo acaba donde empieza 0x988E", L, F=2)
    L = "p00:5401"
    ps = tabla_hasta_el_primero(T, 0x988E, 1000)
    tabla_de_palabras(T, 0x988E, len(ps), "opciones_de_personaje",
                      "lo que ofrece cada personaje (0x988E + (0xE363 - 1) x 2)", L)
    regs = sorted(set(ps))
    subs = set()
    for a in regs:
        f = fin_opciones(T, a)
        declara(T, a, f, "opciones_%04X" % a,
                "[m1][m2], un puntero por bit de m2 (p00:5532) y, por cada bit de m1 "
                "que no esta en m2, [n] y n numeros de mensaje (p00:5466-547E)", L, F=16)
        m2 = leer(T, a + 1)
        for k in range(bin(m2).count("1")):
            subs.add(palabra(T, a + 2 + 2 * k))
    subs = sorted(s for s in subs if 0x8000 <= s)
    todos = sorted(set(regs) | set(subs) | {0xA063})
    for s in subs:
        sig = min(x for x in todos if x > s)
        declara(T, s, sig, "subopciones_%04X" % s,
                "[0xE8A3][n] y la lista que recorren p00:5567 y p00:5574; la apunta "
                "un registro de 0x988E y acaba donde empieza el siguiente", L, F=16)


def musica():
    """El motor de sonido del banco 29 y sus datos (29-30-31).

    El final de las pistas no sale de recorrerlas (tienen saltos, bucles y
    llamadas), sino de EJECUTAR el motor: `tools/musica.py lecturas 0x01
    0x61` apunta cada byte que lee al tocar cada numero 120 segundos."""
    T = (29, 30, 31)
    L = "p29:6048"
    declara(T, 0x60E0, 0x60EC, "canal_al_arrancar", "12 bytes que p29:60D7 copia "
            "a cada canal cuando arranca una pista", "p29:60D7", F=12)
    tabla_de_palabras(T, 0x6131, 0x61, "sonidos",
                      "la cabecera de los sonidos 0x01-0x61 (p29:604C: 0x612F + "
                      "numero x 2; el 0 no se pide y su palabra es el final de "
                      "p29:612D)", L)
    cab = sorted({palabra(T, 0x612F + 2 * n) for n in range(1, 0x62)})
    for i, h in enumerate(cab):
        m = leer(T, h)
        declara(T, h, h + 2 + 2 * bin(m & 0xF8).count("1"), "cabecera_%04X" % h,
                "[canales: bits 7-3][prioridad] y la pista de cada canal (p29:6061-"
                "60BD; el motor copia 12 bytes, p29:605C)", L, F=16)
    declara(T, 0x6537, 0x6543, "periodos", "12 bytes: el periodo de cada nota de "
            "la octava (p29:6501), que p29:6513 dobla por octava", "p29:6501", F=12)
    declara(T, 0x6C51, 0x6C5D, "mezclador_por_modo", "3 x 4 bytes: los bits del "
            "registro 7 de cada canal segun su modo (p29:6C0B, 6C21, 6C37)",
            "p29:6C07", F=4)
    declara(T, 0x6C5D, 0x6F3A, "percusiones", "las ocho tablas de palabras de "
            "p29:65F4 (0x6C5D, 0x6C71, 0x6CD4, 0x6D97, 0x6E21, 0x6E73, 0x6E8C, "
            "0x6F0D, segun el modo del canal y (ix+0x16)) y las secuencias a las "
            "que apuntan, que p29:65D3 toca como notas; los huecos que ninguna "
            "pieza lee son entradas sin usar", "p29:65BD", F=16)
    declara(T, 0x6F3A, 0xBFBA, "pistas", "las 177 pistas de los sonidos 0x01-0x61: "
            "notas (< 0xD0), ordenes 0xD0-0xFE (p29:68B7: octava, volumen, "
            "envolvente, saltos, bucles, llamadas) y 0xFF fin; medido ejecutando el "
            "motor, ninguna pieza lee 4 trozos: p31:AFF4 (un 0xFF tras un salto), "
            "p31:B652-B660 (una secuencia que nadie apunta), p31:BF52-BF53 (la "
            "direccion de un bucle que no vuelve) y la cola de 0xFF", "p29:64B3",
            F=16)


def fin_hasta_ff(trio, a):
    while leer(trio, a) != 0xFF:
        a += 1
    return a + 1


def banco4():
    """La fuente, los objetos y sus nombres (banco 4 con 4-5-6)."""
    T = (4, 5, 6)
    declara(T, 0x6F39, 0x76E9, "fuente", "la fuente: 246 caracteres de 8 x 8 "
            "(1 bit por punto) que p04:64BB copia con LDIRVM (0x7B0 bytes) a los "
            "patrones de la VRAM 0x2000, 0x2800 y 0x3000; p06:AEDA saca uno a uno "
            "(0x6F39 + caracter x 8)", "p04:64BB", F=8)
    declara(T, 0x76E9, 0x7761, "fuente_extra", "15 caracteres mas que p04:64AF "
            "copia (0x78 bytes) a la VRAM 0x2808", "p04:64AF", F=8)
    tabla_de_palabras(T, 0x65B8, 6, "pantallas_a_ram", "6 RLE que p04:659D "
                      "descomprime a 0xED00 (p04:65D4, el formato de los graficos)",
                      "p04:659D")
    tabla_de_palabras(T, 0x65C4, 6, "direcciones_vram", "6 direcciones de VRAM "
                      "(0x0A00-0x0D48) que da p04:65AE", "p04:65AE")
    graficos(T, 0x78C3, "rle_78C3", "SIN LECTOR A LA VISTA: una RLE como las de "
             "0x65B8 que ninguna tabla apunta", "nadie")
    for a in (0x78E0, 0x78E5, 0x78EA, 0x78F1, 0x78F8, 0x78FD):
        graficos(T, a, "rle_%04X" % a, "a 0xED00 (p04:65D4), de la tabla 0x65B8",
                 "p04:659D")
    L = "p00:5694"
    ps = tabla_hasta_el_primero(T, 0x7902, 300)
    tabla_de_palabras(T, 0x7902, len(ps), "listas_de_objetos",
                      "una lista de objetos por numero (L_43A4 con A)", L)
    for a in sorted(set(ps)):
        declara(T, a, fin_hasta_ff(T, a + 1), "objetos_%04X" % a,
                "[0xE8A1] y numeros de objeto hasta 0xFF, que p00:56A6 copia a "
                "0xE8B8", L, F=16)
    L = "p00:5700"
    ps = tabla_hasta_el_primero(T, 0x7A15, 300)
    tabla_de_palabras(T, 0x7A15, len(ps), "nombres_de_objeto",
                      "el nombre de cada objeto (0x7A15 + objeto x 2)", L)
    for a in sorted(set(ps)):
        declara(T, a, fin_hasta_ff(T, a), "nombre_%04X" % a,
                "nombre de objeto: caracteres hasta 0xFF; 3 y 4 son las marcas "
                "que van encima del caracter anterior (p00:59DD)", L, F=16)
    L = "p04:6DEC"
    tabla_de_palabras(T, 0x7C71, 10, "animaciones_e34c",
                      "lo que p04:6DEC pone en 0xE34C segun 0xE351", L)
    declara(T, 0x7C85, 0x7CB6, "animaciones", "registros de 4 bytes [graficos "
            "lo][hi][..][..] que recorre p04:65F0 desde 0xE34C; los graficos, con "
            "su direccion de VRAM (L_59FB), estan en el banco 5", L, F=4)
    for a in range(0x7C85, 0x7CB6, 4):
        g = palabra(T, a)
        if 0x8000 <= g < 0xA000:
            graficos(T, g, "graficos_%04X" % g, "de la animacion de 0x%04X" % a,
                     "p04:6604", True)
    L = "p04:6EE4"
    declara(T, 0x94A9, 0x94BD, "filas_animadas", "4 x [origen][cuantas][VRAM]: "
            "p04:6EF7 copia esas fichas a la VRAM cambiando la 0x60 por la del "
            "cuadro (0x6F1E)", L, F=5)
    declara(T, 0x9506, 0x96BD, "fichas_9506", "fichas sueltas entre dos graficos; "
            "p04:6EF7 copia de aqui los cuatro trozos de 0x94A9 (0x957D, 0x95AD, "
            "0x95BD, 0x95E5); el resto no lo apunta nadie con el banco puesto",
            L, F=16)


def dibujo(trio, a, nom, que, lector):
    """L_44B8: [filas][columnas] y 4 fichas por celda (2 x 2)."""
    r, c = leer(trio, a), leer(trio, a + 1)
    declara(trio, a, a + 2 + 4 * r * c, nom, "dibujo (L_44B8): [filas][columnas] y "
            "4 fichas por celda de 2 x 2" + (": " + que if que else ""), lector, F=4)
    return a + 2 + 4 * r * c


def salas_y_listas(T, salas, punteros, nom, que, L):
    """Salas (palabras hasta 0xFFFF), una lista por sala hasta 0xFF."""
    a = salas
    while palabra(T, a) != 0xFFFF:
        a += 2
    n = (a - salas) // 2
    declara(T, salas, a + 2, nom + "_salas", "%d salas (palabras) y 0xFFFF: %s "
            "busca 0xEB40 en ellas y se queda con el orden" % (n, L), L, F=2)
    tabla_de_palabras(T, punteros, n, nom + "_listas", "la lista de cada sala de "
                      "0x%04X" % salas, L)
    ps = sorted({palabra(T, punteros + 2 * i) for i in range(n)})
    for x in ps:
        declara(T, x, fin_hasta_ff(T, x), "%s_%04X" % (nom, x), que, L, F=16)


def banco9():
    T = (9, 10, 11)
    salas_y_listas(T, 0x613C, 0x6162, "cofres_9", "registros hasta 0xFF que "
                   "recorre p09:610B", "p09:60CC")
    salas_y_listas(T, 0x6291, 0x63A5, "cosas_9", "registros hasta 0xFF que "
                   "recorre p09:626A", "p09:622B")
    tabla_de_palabras(T, 0x6713, 17, "dibujos_p443D", "el dibujo de 0xE368 - 1 "
                      "(p00:444C); todas apuntan a 0x6735", "p00:443D")
    a = 0x6735
    while a < 0x6B35:
        a = dibujo(T, a, "dibujo_%04X" % a, "uno de los 52 que van seguidos de "
                   "0x6735 a 0x6B35 (el ultimo acaba justo donde empieza el codigo)",
                   "p00:44B8")


def salas():
    """Los mapas: 12 x 8 bloques a nibbles por sala (p00:514B)."""
    L = "p00:514B"
    declara((15, 16, 17), 0x6000, 0xC000, "salas_000_1FF",
            "las salas 0x000-0x1FF, 48 bytes cada una: 8 filas de 12 bloques a "
            "nibbles, el de la izquierda en el nibble alto (p00:5191: 0x6000 + "
            "sala x 48)", L, F=24)
    n = 0x235 - 0x200
    declara((18, 19, 20), 0xB606, 0xB606 + 48 * n, "salas_200_234",
            "las salas 0x200-0x234, 48 bytes cada una (p00:5168: 0xB606 + "
            "(sala - 0x200) x 48)", L, F=24)


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
                                texto=q[2].strip(), lectores=["L_40AB"], F=2))


def relleno():
    """La cola de 0xFF de cada banco."""
    for p in range(N_PAGINAS):
        fin = ORG[p] + TAM_PAGINA
        a = fin
        while a > ORG[p] and ROM[p * TAM_PAGINA + (a - 1 - ORG[p])] == 0xFF:
            a -= 1
        if fin - a >= 16:
            BLOQUES.append(dict(p=p, ini=a, fin=fin, nombre="relleno_ff",
                                texto="%d bytes a 0xFF hasta el final del banco: "
                                "relleno" % (fin - a), lectores=["nadie"], F=16))


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
    """La instruccion que cruza del banco 1 al 2 (p01:7FFE)."""
    declara((1, 2, 3), 0x7FFE, 0x8000, "partida_7FFE", "los dos primeros bytes de "
            "`ld a,(0xE3F3)` (3A F3 E3), que sigue en el banco 2: el trazador de "
            "un solo banco no puede verla entera (tools/bancos.py)", "p01:7FFE", F=2)
    declara((1, 2, 3), 0x8000, 0x8001, "partida_8000", "el ultimo byte de "
            "`ld a,(0xE3F3)` de p01:7FFE, que empieza en el banco 1", "p01:7FFE", F=1)


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
    textos()
    fichas_de_sala()
    banco18()
    banco7()
    musica()
    banco4()
    banco9()
    partidas()
    salas()
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
