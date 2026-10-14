#!/usr/bin/env python3
"""La VRAM de SCREEN 5 montada desde la ROM con los lectores del cartucho.

SCREEN 5 (CHGMOD 5 en p00:4FB2): 4 bits por punto, 128 bytes por linea, el
punto par en el nibble alto. La pagina 0 es 0x0000-0x7FFF y la pagina 1
0x8000-0xFFFF; L_48EA mete en R#14 los dos bits altos de la direccion, asi
que el cartucho trabaja con direcciones de 16 bits sobre las dos paginas.

LAS LISTAS DE FICHAS (L_529C). [n] y n fichas de 6 bytes:

    [c][destino lo][destino hi][cuantas][origen lo][origen hi]

  - c & 0x0F es el formato (L_52D6): 0/1 un bit por punto (8 bytes por
    ficha, L_4E75), 2/3 dos bits (16 bytes, L_4ECE: el primer byte es el
    bit 0), 4/5 tres bits (24 bytes, L_4F2F: el primero es el bit 0). Los
    impares se escriben VOLTEADOS (L_4F92 / L_4F6C: cada fila de derecha a
    izquierda, con los nibbles cambiados).
  - c >> 4 es el indice en la tabla de colores que se le pasa en DE: la
    palabra apunta a 2, 4 u 8 bytes (segun el formato: (c & 6) * 2, o 2) que
    van a 0xDF00, y el indice de 1-3 bits de cada punto se cambia por
    DF00[indice] (el color de la paleta, 0-15).
  - el destino es una direccion de VRAM; cada ficha ocupa 4 bytes de 8
    lineas y la siguiente va 4 bytes a la derecha; al llegar a 0x80 baja
    una fila de fichas (+0x400) (L_4D0F).

LA PALETA (L_4A9D): ternas [registro][0RRR0BBB][00000GGG] hasta 0xFF.
"""
import os
import sys

AQUI = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, AQUI)
from rom import leer, palabra, bytes_de, tabla   # noqa: E402

FORMATOS = {0: 1, 1: 1, 2: 2, 3: 2, 4: 3, 5: 3}


class VRAM:
    def __init__(self):
        self.m = bytearray(0x10000)
        self.pal = [(0, 0, 0)] * 16
        self.escrituras = []        # (lista, ficha, destino, cuantas, origen, formato)

    # ------------------------------------------------------------- puntos
    def punto(self, pagina, x, y):
        b = self.m[(pagina * 0x8000 + y * 128 + x // 2) & 0xFFFF]
        return (b >> 4) if x % 2 == 0 else (b & 0x0F)

    def pon_punto(self, pagina, x, y, c):
        o = (pagina * 0x8000 + y * 128 + x // 2) & 0xFFFF
        if x % 2 == 0:
            self.m[o] = (self.m[o] & 0x0F) | (c << 4)
        else:
            self.m[o] = (self.m[o] & 0xF0) | c

    def hmmm(self, sx, sy, spag, dx, dy, dpag, ancho, alto):
        """L_4BDE: copia de un rectangulo de una pagina a otra (HMMM)."""
        tmp = [[self.punto(spag, sx + i, sy + j) for i in range(ancho)]
               for j in range(alto)]
        for j in range(alto):
            for i in range(ancho):
                self.pon_punto(dpag, dx + i, dy + j, tmp[j][i])

    def timp(self, sx, sy, spag, dx, dy, dpag, ancho, alto):
        """L_4C73 con A = 0x48: LMMM con TIMP (el color 0 no se copia)."""
        for j in range(alto):
            for i in range(ancho):
                c = self.punto(spag, sx + i, sy + j)
                if c:
                    self.pon_punto(dpag, dx + i, dy + j, c)

    def ficha(self, t, dx, dy, dpag):
        """L_4DB4: la ficha t de la pagina 1 (L_4E2B) a (dx, dy) de dpag."""
        self.hmmm((t & 31) * 8, (t >> 5) * 8, 1, dx, dy, dpag, 8, 8)

    # ------------------------------------------------------------- fichas
    def lista(self, trio, base, colores):
        """L_529C: la lista de fichas de base, con la tabla de colores."""
        n = leer(trio, base)
        a = base + 1
        for k in range(n):
            c, dlo, dhi, cuantas, olo, ohi = bytes_de(trio, a, 6)
            fmt = c & 0x0F
            bits = FORMATOS[fmt]
            ncol = (c & 6) * 2 or 2
            tabla_col = tabla(trio, colores, c >> 4)
            df00 = list(bytes_de(trio, tabla_col, ncol))
            destino = dlo | (dhi << 8)
            origen = olo | (ohi << 8)
            self.fichas(trio, origen, destino, cuantas, bits, df00, fmt & 1)
            self.escrituras.append((base, k, destino, cuantas, origen, fmt))
            a += 6
        return a

    def fichas(self, trio, origen, destino, cuantas, bits, df00, volteada):
        por_ficha = 8 * bits
        de = destino
        for f in range(cuantas):
            src = origen + f * por_ficha
            for fila in range(8):
                planos = [leer(trio, src + fila * bits + p) for p in range(bits)]
                pix = []
                for x in range(8):
                    i = 0
                    for p in range(bits):
                        i |= ((planos[p] >> (7 - x)) & 1) << p
                    pix.append(df00[i] & 0x0F)
                if volteada:
                    pix = pix[::-1]
                for x in range(4):
                    self.m[(de + fila * 0x80 + x) & 0xFFFF] = (pix[2 * x] << 4) | pix[2 * x + 1]
            e = (de & 0xFF) + 4
            d = de >> 8
            if e == 0x80:
                e = 0
                d += 4
            de = ((d & 0xFF) << 8) | (e & 0xFF)

    def fichas_2bits(self, trio, origen, destino, cuantas, df00):
        """L_4EA2 a secas (sin lista): 16 bytes por ficha."""
        self.fichas(trio, origen, destino, cuantas, 2, df00, 0)

    # ------------------------------------------------------------- paleta
    def paleta(self, trio, a):
        """L_4A9D: ternas [registro][RB][G] hasta 0xFF."""
        while True:
            r = leer(trio, a)
            if r == 0xFF:
                return a + 1
            rb, g = leer(trio, a + 1), leer(trio, a + 2)
            self.pal[r & 0x0F] = ((rb >> 4) & 7, g & 7, rb & 7)
            a += 3

    def rgb(self, c):
        return tuple(v * 255 // 7 for v in self.pal[c])
