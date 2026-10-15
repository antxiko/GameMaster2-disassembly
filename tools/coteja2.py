#!/usr/bin/env python3
"""Coteja las pantallas de MSX2 de tools/pantallas2.py con openMSX.

Los volcados los saca tools/omsx_msx2.tcl (C-BIOS_MSX2_JP) en work/omsx2.
Se comparan los 64 KB que el cartucho borra al empezar (p09:80AE, BIGFIL de
0x0000 con BC = 0): lo de mas arriba es lo que dejo la BIOS al arrancar.

Uso: coteja2.py [nombre ...]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import pantallas2  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
VOLCADO = {
    "logo_konami_msx2": "logo",
    "rotulo_msx2": "rotulo",
    "menu_msx2": "menu",
    "menu_self_msx2": "self",
    "bio_entrada_msx2": "bio",
}


def main(argv):
    nombres = argv[1:] or list(VOLCADO)
    mal = 0
    for n in nombres:
        m = pantallas2.monta(n)
        a = m.v
        b = open(os.path.join(RAIZ, "work", "omsx2", "vram-%s.bin" % VOLCADO[n]), "rb").read()
        if isinstance(m, pantallas2.Vram4):
            # SCREEN 2 con paleta: CHGMOD 4 de la BIOS deja restos en tablas que
            # luego no se ven (p00:5EDF); se comparan los puntos y los nombres
            o = pantallas2.Vram4()
            o.v, o.paleta, o.borde = bytearray(b), m.paleta, m.borde
            pa, pb = m.pinta4(), o.pinta4()
            d = [(x, y) for y in range(192) for x in range(256) if pa[y][x] != pb[y][x]]
            d += [i for i in range(0x3800, 0x3B00) if a[i] != b[i]]
            print("%-24s %5d puntos o nombres distintos" % (n, len(d)))
            mal += bool(d)
            continue
        d = [i for i in range(0x10000) if a[i] != b[i]]
        print("%-24s %5d bytes distintos%s" % (n, len(d), (" desde 0x%05X" % d[0]) if d else ""))
        mal += bool(d)
    return 1 if mal else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
