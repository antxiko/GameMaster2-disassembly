#!/usr/bin/env python3
"""Leer la ROM de Shalom como la lee el cartucho: con el mapper.

Una direccion de 0x6000-0xBFFF no dice nada sin el reparto de bancos puesto
(tools/paginas.py): con 12-13-14 (p00:412B), 0x6000 es el banco 12, 0x8000
el 13 y 0xA000 el 14. 0x4000-0x5FFF es siempre el banco 0.

El formato de graficos que usa casi todo (p00:5A03, ver tools/bloques.py):
  [n] n == 0 acaba; n < 0x80 repite el byte siguiente n veces; n > 0x80
  copia n & 0x7F bytes tal cual; 0x80 trae otra direccion de VRAM (p00:59FB,
  dos bytes) y sigue.
"""
import os

AQUI = os.path.dirname(os.path.abspath(__file__))
RAIZ = os.path.dirname(AQUI)
RUTA_ROM = os.environ.get("SHALOM_ROM", os.path.join(RAIZ, "shalom.rom"))
ROM = open(RUTA_ROM, "rb").read()

# Los repartos que ponen las rutinas del banco 0 (tools/paginas.py). Los de
# dos bancos (p00:411B y p00:4149) dejan 0x6000 como estuviera: aqui se
# escribe el 1, que es lo que hay en el juego (p00:40F9 al final de cada
# pasarela).
T123 = (1, 2, 3)        # p00:40F9
T456 = (4, 5, 6)        # p00:40FF
T178 = (1, 7, 8)        # p00:411B
T91011 = (9, 10, 11)    # p00:4125
T121314 = (12, 13, 14)  # p00:412B
T151617 = (15, 16, 17)  # p00:4131
T181920 = (18, 19, 20)  # p00:4137
T212223 = (21, 22, 23)  # p00:413D
T242526 = (24, 25, 26)  # p00:4143
T12728 = (1, 27, 28)    # p00:4149
T293031 = (29, 30, 31)  # p00:416C (la musica)


def banco(trio, a):
    """El banco que hay en la direccion a con el reparto puesto."""
    if 0x4000 <= a < 0x6000:
        return 0
    return trio[(a - 0x6000) >> 13]


def desplazamiento(trio, a):
    """La posicion en el fichero de la ROM del byte a."""
    return banco(trio, a) * 0x2000 + (a & 0x1FFF)


def leer(trio, a):
    return ROM[desplazamiento(trio, a)]


def palabra(trio, a):
    return leer(trio, a) | (leer(trio, a + 1) << 8)


def bytes_de(trio, a, n):
    return bytes(leer(trio, a + i) for i in range(n))
