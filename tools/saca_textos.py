"""Saca los textos del Game Master 2 de la ROM.

Formato de pinta_texto (p01:738F, y su copia p02/p03): [direccion de VRAM, 2 bytes]
y letras ASCII (0x00 = espacio); 0xFE trae otra direccion, 0xFF acaba.
Tennis and Hockey (p07) usa el mismo formato con las letras 0x20 por debajo
del ASCII (0x21 = 'A').

El biorritmo de MSX1 (p05, pinta_texto_bio) lleva las letras 0x20 por debajo del
ASCII y acaba en 0x80 (0x81 trae otra direccion, que va a una copia de la tabla
de nombres en RAM): de ese se dan las tiras de letras, sin posicion.

El de MSX2 (p06) pinta en SCREEN 5/7 con pinta_texto_8x8: [x, y] y letras
ASCII; 0xFE otra posicion, 0xFF acaba.

Delante de algunos textos va la lista de posiciones del cursor de su menu
(palabras de VRAM): se quita.

Busca en cada banco los bloques que se leen enteros en ese formato y marca los
que tienen un `ld hl,` que los apunte en el listado (src/gamemaster2_pNN.asm).
"""
import os, re, sys

AQUI = os.path.dirname(os.path.abspath(__file__))
ROM = open(os.path.join(AQUI, "..", "gamemaster2.rom"), "rb").read()
BASE = {0: 0x4000, 1: 0x6000, 2: 0x8000, 3: 0xA000, 4: 0x8000, 5: 0x8000,
        6: 0xA000, 7: 0x8000, 8: 0xA000, 9: 0x8000}


# Los signos de la fuente del Game Master (p00:483F, desde el 0x30), mirados
# letra a letra: no son los del ASCII.
FUENTE = {0x3A: ">", 0x3B: ":", 0x3C: ".", 0x3D: '"', 0x3E: "=", 0x3F: "?", 0x40: "-",
          0x10: "(C)"}    # el 0x10 lo carga la presentacion occidental: p09:8DE6 es una (C)


def letra(c, menos20):
    if c == 0:
        return " "
    c = c + 0x20 if menos20 else c
    if not menos20 and c in FUENTE:
        return FUENTE[c]
    if c == 0x2D and not menos20:
        return "-"
    return chr(c) if 0x20 <= c < 0x7F else None


def lee(d, i, menos20):
    """Lee un bloque desde i; devuelve (lineas, fin) o None si no es texto."""
    lineas, n = [], 0
    while True:
        if i + 2 > len(d):
            return None
        vram = d[i] | d[i + 1] << 8
        if not (0x1800 <= vram < 0x1B00 or 0x3800 <= vram < 0x3B00 or 0x8000 <= vram < 0x8100):
            # 0x80xx: la tabla del ranking (p01:6C50) se escribe en un bufer de 0x8000
            return None
        i += 2
        while (not lineas and i + 1 < len(d) and 0x38 <= d[i + 1] < 0x3B
               and d[i] not in (0, 0xFE, 0xFF) and not (0x41 <= d[i] <= 0x5A and 0x41 <= d[i + 1] <= 0x5A)):
            vram = d[i] | d[i + 1] << 8      # era una posicion del cursor
            i += 2
        s = ""
        while True:
            if i >= len(d):
                return None
            c = d[i]; i += 1
            if c in (0xFE, 0xFF):
                break
            ch = letra(c, menos20)
            if ch is None:
                return None
            s += ch
        raya = lineas and s.strip() and set(s.strip()) <= set("-=")
        if not raya and (not s.strip() or sum(ch.isalpha() for ch in s) < 2):
            return None
        lineas.append((vram, s))
        n += 1
        if c == 0xFF:
            return lineas, i


def lee_xy(d, i):
    lineas = []
    while True:
        if i + 2 > len(d):
            return None
        x, y = d[i], d[i + 1]
        if y > 0xD3:
            return None
        i += 2
        s = ""
        while True:
            if i >= len(d):
                return None
            c = d[i]; i += 1
            if c in (0xFE, 0xFF):
                break
            if not 0x20 <= c < 0x7F:
                return None
            s += chr(c)
        if sum(ch.isalpha() for ch in s) < 3 or x > 0xF0 or not re.fullmatch(r"[A-Z0-9 <;]+", s):
            return None
        lineas.append(((x, y), s))
        if c == 0xFF:
            return lineas, i


def tiras_bio(d, base):
    """Tiras de letras (0x20 por debajo) que acaban en 0x80 o 0x81.

    0x04 es el espacio, 0x1F la flecha (la '<' del de MSX2) y 0xA0-0xA7 los
    trozos del marco, que no se escriben.
    """
    def ch(x):
        if 0xA0 <= x <= 0xA7:
            return ""
        return {0: " ", 4: " ", 0x1F: "<"}.get(x, chr(x + 0x20))
    out, ini = [], None
    for i, c in enumerate(d):
        if c <= 0x3F or 0xA0 <= c <= 0xA7:
            if ini is None:
                ini = i
            continue
        if c in (0x80, 0x81) and ini is not None:
            s = "".join(ch(x) for x in d[ini:i])
            if sum(k.isalpha() for k in s) >= 3 and sum(k.isalnum() or k in " <" for k in s) >= len(s) - 2:
                out.append((base + ini, " ".join(s.split())))
        ini = None
    return out


def apuntados(banco):
    f = os.path.join(AQUI, "..", "src", "gamemaster2_p%02d.asm" % banco)
    if not os.path.exists(f):
        return set()
    return {int(m, 16) for m in re.findall(r"ld (?:hl|de|ix),0([0-9a-f]{4})h", open(f, encoding="latin1").read())}


def main():
    print("# Los textos del Game Master 2, sacados de la ROM\n")
    print("Los saca `tools/saca_textos.py`. Fila y columna salen de la direccion de VRAM")
    print("(32 columnas). `*` = un `ld` del listado apunta al bloque.\n")
    print("- Los signos van con la fuente del cartucho (p00:483F), no con el ASCII: 0x3A flecha,")
    print("  0x3D comillas, 0x3E igual, 0x40 guion. p07 y p05 llevan las letras 0x20 por debajo.")
    print("- p02/p03 repiten los menus de p00/p01 (la copia que corre con el juego puesto).")
    print("  La cabecera del ranking de p02 (p02:9E8C) lleva delante 0xD9B1 en vez de 0x8000 (sin cotejar).")
    print("- Erratas de la ROM, tal cual: FORAMT (tres veces, una con FORMAT bien al lado),")
    print("  UNFORMATED, BIORYTHM.")
    print("- La presentacion occidental (p09:8D74) firma (C) KONAMI 1988.\n")
    for b in sorted(BASE):
        if b == 1:
            continue                 # p00 y p01 van seguidos (0x4000-0x7FFF): se leen juntos
        n = 2 if b == 0 else 1
        d = ROM[b * 0x2000:(b + n) * 0x2000]
        if b == 5:
            print("## p05 (biorritmo de MSX1)\n\n```")
            ap = apuntados(5)
            for dir_, s in tiras_bio(d, BASE[b]):
                print("p05:%04X%s  %s" % (dir_, "*" if dir_ in ap else " ", s.rstrip()))
            print("```\n")
            continue
        xy = b == 6
        menos20 = (b in (7, 8))
        ap = apuntados(b) | (apuntados(1) if b == 0 else set())
        i, salida = 0, []
        while i < len(d):
            r = lee_xy(d, i) if xy else lee(d, i, menos20)
            if r and xy and BASE[b] + i not in ap:
                r = None             # en p06 solo valen los bloques que apunta un ld
            if r:
                lineas, fin = r
                salida.append((BASE[b] + i, lineas))
                i = fin
            else:
                i += 1
        if b in (0, 2, 6):
            # tiras sueltas que acaban en 0xFF, sin direccion: las pinta pinta_texto_en
            # con la VRAM en DE (errores del disco, rotulos del ranking), los niveles del
            # biorritmo de MSX2 (p06:A21D, por su tabla) y la cabecera del ranking
            dentro = set()
            for dir_, lineas in salida:
                dentro.update(range(dir_ - BASE[b], dir_ - BASE[b] + sum(len(s) + 3 for _, s in lineas)))
            for m in re.finditer(rb"[\x00 -~]{3,}(?=\xff)", d):
                for k in range(m.start(), m.end() - 2):
                    s = "".join(letra(c, False) for c in d[k:m.end()])
                    if (0x41 <= d[k] <= 0x5A or d[k] in (0x3D, 0x40)) and \
                            sum(x.isupper() for x in s) >= 3 and re.fullmatch(r'[A-Z0-9 .:"=?>-]+', s)                             and not re.search(r"[A-Z][0-9][A-Z]", s):
                        if '"' in s and not s.startswith('"'):
                            continue
                        if k not in dentro:
                            salida.append((BASE[b] + k, [(None, s)]))
                        break
            salida.sort()
        if not salida:
            continue
        print("## p%02d\n" % b)
        print("```")
        for dir_, lineas in salida:
            for k, (vram, s) in enumerate(lineas):
                bb = 1 if dir_ >= 0x6000 and b == 0 else b
                cab = ("p%02d:%04X%s" % (bb, dir_, "*" if dir_ in ap else " ")) if k == 0 else " " * 10
                if vram is None:
                    print("%s  (suelto)      %s" % (cab, s.rstrip()))
                elif xy:
                    print("%s  x %3d y %3d  %s" % (cab, vram[0], vram[1], s.rstrip()))
                else:
                    pos = (vram & 0x3FF)
                    if vram >= 0x8000:
                        print("%s  bufer 0x%04X  %s" % (cab, vram, s.rstrip()))
                        continue
                    print("%s  fila %2d col %2d  %s" % (cab, pos // 32, pos % 32, s.rstrip()))
        print("```\n")


if __name__ == "__main__":
    main()
