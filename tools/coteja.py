#!/usr/bin/env python3
"""Coteja cada pantalla de tools/pantallas.py con el cartucho ejecutado.

Arranca el Game Master 2 en tools/corre.py desde su INIT (0x5583), lo lleva
hasta el instante de la pantalla (una direccion de un banco, con las teclas
que hagan falta por el camino) y compara los 16 KB de VRAM, byte a byte, con
los que monta pantallas.py. Lo que se exige es 0.

Uso: coteja.py [nombre ...]
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from corre import cartucho  # noqa: E402
import pantallas  # noqa: E402

# nombre: (banco, direccion en la que se para, teclas por el camino)
# Las teclas son (cuando, lo que devuelve CHGET): el arranque de la
# presentacion se para en CHGET esperando el espacio.
PUNTOS = {
    "logo_konami": (9, 0x8846, []),            # titulo_rotulo: la animacion ya acabo
    "presentacion_japonesa": (9, 0x8B35, []),  # espera_espacio: el rotulo pintado
    "menu_principal": (9, 0x8477, [0x20]),     # el bucle del menu, antes del primer cuadro
}


def ejecuta(nombre, tope=3_000_000):
    banco, parada, teclas = PUNTOS[nombre]
    z = cartucho()
    z.teclas = list(teclas)
    z.sp = 0xF380
    z.pc = 0x5583
    z.pasos = 0
    while True:
        if z.pc == parada and z.bancos.get(parada & 0xE000, 0) & 0x0F == banco:
            return z.vdp.vram
        z.pasos += 1
        if z.pasos > tope:
            raise RuntimeError("%s: no se llego a p%02d:%04X" % (nombre, banco, parada))
        z._una()


def main(argv):
    nombres = argv[1:] or list(PUNTOS)
    mal = 0
    for n in nombres:
        a = pantallas.monta(n).v
        b = ejecuta(n)
        d = [i for i in range(0x4000) if a[i] != b[i]]
        print("%-24s %5d bytes distintos%s" % (n, len(d), (" desde 0x%04X" % d[0]) if d else ""))
        mal += bool(d)
    return 1 if mal else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
