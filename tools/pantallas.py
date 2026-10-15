#!/usr/bin/env python3
"""Las pantallas del Game Master 2, dibujadas desde la ROM con codigo nuestro.

Cada pantalla repite los pasos de su rutina (citada al lado) con las piezas del
cartucho rehechas aqui: el descompresor de p01:733A, el texto de p01:738F, las
filas de p09:8457... La VRAM resultante se pinta con tools/screen2.py y se
coteja con tools/coteja.py contra la que deja el cartucho ejecutado en
tools/corre.py (y, si se puede, contra un volcado de openMSX).

Uso: pantallas.py <nombre|todas> <carpeta de salida>
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import screen2  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ROM = open(os.path.join(RAIZ, "gamemaster2.rom"), "rb").read()


# Los repartos de bancos con que corre cada parte: 0x4000 es siempre el 0.
# p01:672D pone el 9 en 0x8000 y el 10 en 0xA000 para la presentacion.
PRESENTACION = {0x6000: 1, 0x8000: 9, 0xA000: 10}


def rom(bancos, dir_, n=1):
    """n bytes desde la direccion de CPU dir_, como los lee la CPU: cada
    ventana de 8 KB con su banco (un bloque puede pasar de una a otra).
    `bancos` es un reparto {ventana: banco} o un banco suelto."""
    if isinstance(bancos, int):
        bancos = {dir_ & 0xE000: bancos}
    out = bytearray()
    for d in range(dir_, dir_ + n):
        ventana = d & 0xE000
        b = 0 if ventana == 0x4000 else bancos[ventana]
        out.append(ROM[b * 0x2000 + (d & 0x1FFF)])
    return bytes(out)


class Vram:
    def __init__(self):
        self.v = bytearray(0x4000)
        self.borde = 1

    def llena(self, dest, n, valor):                 # FILVRM
        for i in range(n):
            self.v[(dest + i) & 0x3FFF] = valor

    def copia(self, banco, origen, dest, n):         # LDIRVM
        self.v[dest:dest + n] = rom(banco, origen, n)

    def descomprime(self, banco, hl, de):
        """p01:733A. Cuenta n = byte & 0x7F: bit 7 a cero repite el byte de
        detras n veces; puesto, copia los n de detras; 0x00 acaba y 0x80 trae
        otra direccion de VRAM (p01:7336). Devuelve donde acabo la lectura."""
        d = de
        while True:
            c = rom(banco, hl)[0]
            hl += 1
            n = c & 0x7F
            if n == 0:
                if c == 0:
                    return hl
                d = rom(banco, hl)[0] | rom(banco, hl + 1)[0] << 8
                hl += 2
                continue
            if c & 0x80:
                for i in range(n):
                    self.v[(d + i) & 0x3FFF] = rom(banco, hl + i)[0]
                hl += n
            else:
                b = rom(banco, hl)[0]
                hl += 1
                for i in range(n):
                    self.v[(d + i) & 0x3FFF] = b
            d += n

    def descomprime_tercios(self, banco, hl, de):    # p01:7323
        for t in range(3):
            self.descomprime(banco, hl, de + 0x800 * t)

    def texto(self, banco, hl):
        """p01:738F: [direccion de VRAM] letras; 0xFE otra direccion, 0xFF acaba."""
        while True:
            d = rom(banco, hl)[0] | rom(banco, hl + 1)[0] << 8
            hl += 2
            while True:
                c = rom(banco, hl)[0]
                hl += 1
                if c == 0xFF:
                    return
                if c == 0xFE:
                    break
                self.v[d & 0x3FFF] = c
                d += 1

    def filas(self, banco, hl, de, b, c):
        """p09:8457: B filas de C bytes, cada fila 32 mas abajo en los nombres."""
        for f in range(b):
            self.copia(banco, hl + f * c, de + f * 32, c)


def modo_presentacion(v):
    """p09:8060: SCREEN 2, la VRAM a cero, los registros de p01:72E2, la tabla
    de sprites a 0xE0 y R#7 = 4 (borde azul)."""
    v.llena(0x0000, 0x4000, 0)
    v.llena(0x3B00, 0x80, 0xE0)
    v.borde = 4


def logo_konami(v):
    """p09:8135 (titulo_msx1) y el final de su animacion (p09:8254).

    p09:9988 se descomprime donde dice su primera palabra; 0x0B00-0x0EEF (los
    colores de las letras 0x60-0xDD del tercio central) a cero, y en 0x3907
    seis filas de 21 letras desde la 0x60. La animacion pone luego, cuadro a
    cuadro, la linea E001 (0-7) de las 21 letras de la fila E002 (0-5) a 0xF0:
    la letra de la fila es (0xEB + 0x15 * (fila + 1)) & 0xFF = 0x15 * fila,
    desde 0x0B00. Aqui se pinta el final, con las 6 filas descubiertas.
    """
    modo_presentacion(v)
    d = rom(9, 0x9988)[0] | rom(9, 0x9989)[0] << 8    # p01:7336
    v.descomprime(9, 0x998A, d)
    v.llena(0x0B00, 0x3F0, 0)                         # p09:8141
    letra = 0x60                                      # p09:814B
    for fila in range(6):
        for k in range(21):
            v.v[0x3907 + fila * 32 + k] = letra
            letra += 1
    for fila in range(6):                             # p09:825A
        for linea in range(8):
            hl = 0x0B00 + ((0x15 * fila) & 0xFF) * 8 + linea
            for k in range(21):
                v.v[hl + 8 * k] = 0xF0


def presentacion_japonesa(v):
    """p09:8846 (titulo_rotulo), con el juego de caracteres japones de la BIOS
    (0x002B & 0x0F = 0) en MSX1: el rotulo "Konami no Shin 10-bai Cartridge"
    hasta que se pulsa el espacio (p09:8891). Viene detras del logo de Konami,
    y lo que este dejo en la VRAM se queda donde el rotulo no escribe."""
    logo_konami(v)
    v.llena(0x3B00, 0x80, 0xE0)                       # p09:8852
    v.llena(0x3800, 0x300, 0)                         # p01:72EA
    v.v[0x3B00] = 0xD0
    v.descomprime_tercios(9, 0x9048, 0x2008)          # p09:8858
    v.descomprime_tercios(9, 0x953A, 0x0008)          # p09:8861
    v.descomprime(9, 0x9D2D, 0x1800)                  # p09:886A
    v.copia(9, 0x8900, 0x3800, 0x220)                 # p09:8873
    v.copia(9, 0x88C0, 0x3B00, 0x40)                  # p09:887F
    v.texto(9, 0x88A0)                                # p09:888B
    # tras el espacio (p09:8891) sigue de corrido en esconde_sprites (p09:8894)


def tras_el_espacio(v):
    """p09:8894: al volver de espera_espacio la rutina cae en esconde_sprites."""
    v.llena(0x3B00, 0x80, 0xE0)


def menu_principal(v):
    """p09:82CA (titulo_dibuja) en MSX1, tras el espacio del rotulo: el
    pinguino en su sillon y la tele con SELECT / GAME / MODIFY / SELF, tal
    como queda al entrar en el bucle del menu (p09:8477), antes del primer
    cuadro de su animacion. Banco 10 en 0xA000 (p01:672D pone 9 y 10)."""
    presentacion_japonesa(v)
    tras_el_espacio(v)
    v.llena(0x3800, 0x300, 0)                         # p01:72EA
    v.v[0x3B00] = 0xD0
    P = PRESENTACION
    v.descomprime_tercios(P, 0x9DE3, 0x2300)          # p09:82D4
    v.descomprime_tercios(P, 0xA1E3, 0x0300)          # p09:82DD
    v.descomprime(P, 0xA32E, 0x1800)                  # p09:82E6
    v.filas(9, 0x8337, 0x38C2, 12, 10)                # p09:82F6
    v.filas(9, 0x83AF, 0x38CF, 12, 14)                # p09:8302
    v.copia(9, 0x831B, 0x3B00, 0x1C)                  # p09:830E


PANTALLAS = {
    "logo_konami": logo_konami,
    "presentacion_japonesa": presentacion_japonesa,
    "menu_principal": menu_principal,
}


def monta(nombre):
    v = Vram()
    PANTALLAS[nombre](v)
    return v


def main(argv):
    nombres = list(PANTALLAS) if argv[1] == "todas" else [argv[1]]
    os.makedirs(argv[2], exist_ok=True)
    for n in nombres:
        v = monta(n)
        screen2.png(256, 192, screen2.pinta(v.v, v.borde), os.path.join(argv[2], n + ".png"))
        open(os.path.join(argv[2], n + ".vram"), "wb").write(v.v)
        print(n)


if __name__ == "__main__":
    main(sys.argv)
