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

# nombre: dict con
#   para    (banco, direccion): donde se para la primera vez que pasa
#   cuadros n: en vez de pararse alli, deja correr n cuadros mas y se para
#           fuera de la interrupcion (lo que corre en la interrupcion)
#   teclas  lo que devolvera CHGET, en orden
#   ve      (banco, direccion) desde la que CHSNS ve esas teclas (antes no,
#           para no cortar la animacion de la presentacion)
#   pulsa   {cuadro: [(fila, bit), ...]}: teclas de la matriz (SNSMAT)
#           pulsadas en ese cuadro, contado desde la parada
#   sprites_conjunto: la tabla de sprites se compara sin el orden
MENU = [0x20]
SELF = [0x20, 0x1F, 0x1F, 0x20]
VE = (9, 0x8477)
PUNTOS = {
    "logo_konami": dict(para=(9, 0x8846)),               # titulo_rotulo: la animacion ya acabo
    "presentacion_japonesa": dict(para=(9, 0x8B35)),     # espera_espacio: el rotulo pintado
    "menu_principal": dict(para=(9, 0x8477), teclas=MENU),  # antes del primer cuadro
    "menu_self": dict(para=(1, 0x767C), teclas=SELF, ve=VE),
    "sram_utilidad": dict(para=(1, 0x7696), teclas=SELF + [0x1F, 0x20], ve=VE),
    "tenis_menu": dict(para=(7, 0x909A), cuadros=1, teclas=SELF + [0x1F, 0x1F, 0x20],
                       ve=VE, sprites_conjunto=True),
}


def ejecuta(nombre, tope=40_000_000):
    c = PUNTOS[nombre]
    banco, parada = c["para"]
    ve = c.get("ve")
    z = cartucho()
    z.teclas = list(c.get("teclas", []))
    pulsa = c.get("pulsa", {})
    llegada = [None]
    inter = z.interrupcion

    def interrupcion():
        if llegada[0] is not None:
            z.maq.teclado[:] = bytes([0xFF] * 12)
            for f, b in pulsa.get(z.cuadros - llegada[0], []):
                z.maq.teclado[f] &= ~(1 << b)
        inter()
    z.interrupcion = interrupcion
    una = z._una
    estado = {"visto": False, "ve": False}

    def mira():
        if not estado["visto"] and z.pc == parada and                 z.bancos.get(parada & 0xE000, 0) & 0x0F == banco:
            estado["visto"] = True
            llegada[0] = z.cuadros
            if "cuadros" not in c:
                raise Llegada()              # antes de ejecutar la instruccion de la parada
        if ve and z.pc == ve[1] and z.bancos.get(ve[1] & 0xE000, 0) & 0x0F == ve[0]:
            z.chsns_ve_teclas = True
        una()
    z._una = mira
    z.sp = 0xF380
    z.pc = 0x5583
    n = 0
    while True:
        if estado["visto"]:
            if not z.dentro and z.cuadros >= llegada[0] + c["cuadros"]:
                return z.vdp.vram
        n += 1
        if n > tope:
            raise RuntimeError("%s: no se llego a p%02d:%04X" % (nombre, banco, parada))
        try:
            z._una()
        except Llegada:
            return z.vdp.vram


class Llegada(Exception):
    pass


def sprites(v):
    return sorted(bytes(v[0x3B00 + i * 4:0x3B04 + i * 4]) for i in range(32))


def main(argv):
    nombres = argv[1:] or list(PUNTOS)
    mal = 0
    for n in nombres:
        a = pantallas.monta(n).v
        b = ejecuta(n)
        d = [i for i in range(0x4000) if a[i] != b[i]]
        if PUNTOS[n].get("sprites_conjunto"):
            d = [i for i in d if not 0x3B00 <= i < 0x3B80]
            if sprites(a) != sprites(b):
                d.append(0x3B00)
        print("%-24s %5d bytes distintos%s" % (n, len(d), (" desde 0x%04X" % d[0]) if d else ""))
        mal += bool(d)
    return 1 if mal else 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
