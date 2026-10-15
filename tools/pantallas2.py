#!/usr/bin/env python3
"""Las pantallas de MSX2 del Game Master 2, dibujadas desde la ROM.

Como tools/pantallas.py, pero sobre la VRAM de 128 KB del V9938: los comandos
del VDP que lanza el cartucho (HMMV, HMMM...) se rehacen aqui con sus mismos
parametros. El arnes de cotejo (tools/corre.py) no tiene V9938: estas se
cotejan por puntos con los volcados de openMSX de tools/omsx_msx2.tcl.

Uso: pantallas2.py <nombre|todas> <carpeta de salida>
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import screen2  # noqa: E402
from pantallas import rom, PRESENTACION  # noqa: E402


def color_msx2(rb, g):
    """[0RRR0BBB][00000GGG] a RGB (cada componente de 0 a 7)."""
    r, b, g = (rb >> 4) & 7, rb & 7, g & 7
    return tuple((c * 255 + 3) // 7 for c in (r, g, b))


class Vram2:
    """128 KB de VRAM, la paleta de 16 colores y lo que haga falta de SCREEN 5
    (256 x 212, 4 bits por punto, 128 bytes por linea, el punto par en el
    nibble alto; la pagina p empieza en p * 0x8000)."""

    def __init__(self):
        self.v = bytearray(0x20000)
        self.paleta = [(0, 0, 0)] * 16
        self.borde = 0
        self.pagina = 0

    def paleta_tabla(self, bancos, dir_):
        """p01:7275: los 16 colores de una tabla de 2 bytes por color."""
        d = rom(bancos, dir_, 32)
        self.paleta = [color_msx2(d[2 * i], d[2 * i + 1]) for i in range(16)]

    def paleta_lista(self, bancos, dir_):
        """p01:72AE: [color, rb, g] hasta 0xFF."""
        while True:
            c = rom(bancos, dir_)[0]
            if c == 0xFF:
                return
            rb, g = rom(bancos, dir_ + 1, 2)
            self.paleta[c] = color_msx2(rb, g)
            dir_ += 3

    # SCREEN 5: coordenadas de pagina (x, y) -> direccion y nibble
    def punto(self, x, y, pagina):
        a = pagina * 0x8000 + y * 128 + x // 2
        return (self.v[a] >> 4) if x % 2 == 0 else (self.v[a] & 0x0F)

    def pon(self, x, y, pagina, c):
        a = pagina * 0x8000 + y * 128 + x // 2
        if x % 2 == 0:
            self.v[a] = (self.v[a] & 0x0F) | (c << 4)
        else:
            self.v[a] = (self.v[a] & 0xF0) | c

    def hmmv(self, dx, dy, nx, ny, pagina, color):
        """HMMV (p09:8F41): rellena bytes enteros (2 puntos) con el byte color."""
        for y in range(ny or 256):
            for x in range(0, nx or 256, 2):
                self.v[pagina * 0x8000 + (dy + y) * 128 + (dx + x) // 2] = color

    def hmmm(self, sx, sy, dx, dy, nx, ny, origen, destino):
        """HMMM (p09 vdp_hmmm): copia bytes enteros de una pagina a otra."""
        for y in range(ny or 256):
            for x in range(0, nx or 256, 2):
                self.v[destino * 0x8000 + (dy + y) * 128 + (dx + x) // 2] = \
                    self.v[origen * 0x8000 + (sy + y) * 128 + (sx + x) // 2]

    def pinta5(self):
        """La pagina que se ve, en 256 x 212; el color 0 deja ver el borde."""
        px = []
        for y in range(212):
            fila = []
            for x in range(256):
                c = self.punto(x, y, self.pagina)
                fila.append(self.paleta[c] if c else self.paleta[self.borde])
            px.append(fila)
        return px


def letra_4bit(v, bancos, hl_, x, y, color):
    """p09:8EEB: los 8 bytes de una letra de 1 bit a 4 bits (cada punto, el
    color o 0; p09:8F1B) en la pagina 1, en (x, y)."""
    for f in range(8):
        b = rom(bancos, hl_ + f)[0]
        for k in range(8):
            v.pon(x + k, y + f, 1, color if b & (0x80 >> k) else 0)


def logo_konami_msx2(v):
    """El logo de Konami en MSX2 (p09:8089 -> p09:80DC), al acabar su
    animacion (p09:828F).

    SCREEN 5 (p09:8091) con los registros de p09:80CA, la paleta de p01:728E
    y la VRAM a cero. Con la pantalla apagada: la lista de colores de p09:8107
    (1 naranja, 2 rojo, 3 gris, 15 blanco), el borde blanco (R#7 = 15), un
    rectangulo vacio en la pagina 1 (HMMV en (0x28, 0x40), 0xA8 x 0x48) y la
    hoja de letras de 8 x 8 en la fila de arriba de la pagina 1: 13 letras de
    p09:9B6A desde x = 8 con el color 1, 13 de p09:9BD2 desde x = 0x70 con el
    2 y 26 de p09:9C3A desde x = 0xD8 con el 3 (p09:8163). El logo se compone
    en (0x40, 0x40) de la pagina 1 copiando letras de la hoja (HMMM de 8 x 8,
    p09:82AA, lista de p09:9B29). La animacion lo copia a la pagina 0, que es
    la que se ve, cada cuadro una linea mas: al final, 0xA8 x 0x30 desde
    (0x28, 0x40)."""
    P = PRESENTACION
    v.paleta_tabla(1, 0x728E)                         # p09:80A8
    v.v[0xF600:0xF680] = bytes([0xE0]) * 0x80         # p09:80BB: sprites escondidos
    v.paleta_lista(P, 0x8107)                         # p09:80DF
    v.borde = 15                                      # p09:80E5
    v.hmmv(0x28, 0x40, 0xA8, 0x48, 1, 0)              # p09:80EC
    for hl_, x, n, color in ((0x9B6A, 0x08, 13, 1), (0x9BD2, 0x70, 13, 2), (0x9C3A, 0xD8, 26, 3)):
        y = 0
        for k in range(n):                            # p09:8EE2
            letra_4bit(v, P, hl_ + 8 * k, x, y, color)
            x = (x + 8) & 0xFF                        # p09:903E
            if x == 0:
                y += 8
    d, e = 0x40, 0x40                                 # p09:8187
    a = 0x9B29
    inicio = d
    while True:                                       # p09:82AA
        c = rom(P, a)[0]
        a += 1
        if c == 0xFF:
            break
        if c == 0xFE:                                 # otra fila: desde el principio de esta
            d = (inicio + rom(P, a)[0]) & 0xFF
            a += 1
            e = (e + 8) & 0xFF
            inicio = d
            continue
        sx, sy = (c & 0x1F) * 8, (c & 0xE0) >> 2      # p09:8EA8: la letra en la hoja
        v.hmmm(sx, sy, d, e, 8, 8, 1, 1)              # p09:8E96
        d = (d + 8) & 0xFF                            # p09:903E
        if d == 0:
            e = (e + 8) & 0xFF
    v.hmmm(0x28, 0x40, 0x28, 0x40, 0xA8, 0x30, 1, 0)  # p09:829D, el ultimo paso


def descomprime_casillas(v, bancos, de_, hl_):
    """p09:8744 (descomprime_128k): el descompresor de siempre (n & 0x7F, bit 7
    copia, si no repite; 0 acaba) escribiendo en casillas de 8 x 8 de SCREEN 5:
    4 bytes por linea; cada 4 bytes, la linea siguiente (+0x80); cada 32, la
    casilla siguiente (-0x37C) y, al llegar al borde, la fila de casillas de
    abajo (+0x380) (p09:8775)."""
    c = 0
    d = hl_

    def sale(b):
        nonlocal c, d, hl_
        v.v[d & 0x1FFFF] = b
        d += 1
        c = (c + 1) & 0xFF
        if c & 0x1F == 0:
            hl_ = (hl_ - 0x37C) & 0xFFFF
            if hl_ & 0xFF == 0x80:
                hl_ = (hl_ + 0x380) & 0xFFFF
            d = hl_
        elif c & 3 == 0:
            hl_ = (hl_ + 0x80) & 0xFFFF
            d = hl_
    while True:
        n = rom(bancos, de_)[0]
        if n & 0x7F == 0:
            return
        de_ += 1
        if n & 0x80:
            for _ in range(n & 0x7F):
                sale(rom(bancos, de_)[0])
                de_ += 1
        else:
            b = rom(bancos, de_)[0]
            de_ += 1
            for _ in range(n):
                sale(b)


def descomprime_lineal(v, bancos, hl_, de_):
    """p01:733A en MSX2 (NSTWRT): n & 0x7F; bit 7 copia, si no repite; 0x00
    acaba y 0x80 trae otra direccion; seguido, sin casillas."""
    d = de_
    while True:
        c = rom(bancos, hl_)[0]
        hl_ += 1
        n = c & 0x7F
        if n == 0:
            if c == 0:
                return
            d = rom(bancos, hl_)[0] | rom(bancos, hl_ + 1)[0] << 8
            hl_ += 2
            continue
        if c & 0x80:
            for i in range(n):
                v.v[(d + i) & 0x1FFFF] = rom(bancos, hl_ + i)[0]
            hl_ += n
        else:
            b = rom(bancos, hl_)[0]
            hl_ += 1
            for i in range(n):
                v.v[(d + i) & 0x1FFFF] = b
        d += n


def letras_8x8(v, bancos, hl_, x, y, b, c):
    """p09:86E1: C filas de B letras de la hoja (pagina 1) a la pagina 0
    (HMMM de 8 x 8, p09:8F7D)."""
    for _ in range(c):
        d = x
        for _ in range(b):
            letra = rom(bancos, hl_)[0]
            hl_ += 1
            v.hmmm((letra & 0x1F) * 8, (letra & 0xE0) >> 2, d, y, 8, 8, 1, 0)
            d = (d + 8) & 0xFF
        y = (y + 8) & 0xFF


def rotulo_msx2(v):
    """El rotulo en MSX2 (p09:8846 -> p09:8B20), esperando el espacio: tras
    el logo, la pagina 0 a cero (p09:86A8), el borde 4 y la lista de colores
    de p09:8B9C, el dibujo de p11:A000 descomprimido por casillas en la pagina
    1 desde 0x8004 (p09:8B3D) y la pagina 0 compuesta con casillas de esa
    hoja segun cinco listas (p09:8B51)."""
    logo_konami_msx2(v)
    v.v[0:0x8000] = bytes(0x8000)                     # p09:8B23
    v.borde = 4                                       # p09:8B8E
    v.paleta_lista(PRESENTACION, 0x8B9C)
    descomprime_casillas(v, {0xA000: 11}, 0xA000, 0x8004)   # p09:8B3D
    P = PRESENTACION
    for hl_, x, y, b, c in ((0x8BCD, 0x60, 0x08, 8, 4), (0x8BED, 0x00, 0x28, 0x20, 8),
                            (0x8CED, 0x60, 0x68, 8, 4), (0x8D0D, 0x50, 0x88, 0x0C, 1),
                            (0x8D19, 0x48, 0xA0, 0x0E, 1)):            # p09:8B51
        letras_8x8(v, P, hl_, x, y, b, c)


def menu_msx2(v):
    """El menu principal en MSX2 (p09:82CA -> p09:8692), antes del primer
    cuadro de su animacion: tras el espacio, la pagina 0 a cero, el borde 13 y
    la lista de colores de p09:8706, dos dibujos mas a la hoja (p10:A580 en
    0x8C00 y p10:A390 en 0x8800, p09:8731), los dibujos de sprite de p09:9D0A
    en 0xF800 y su color 0x0B en 0xF400 (p09:86B3) y dos rotulos de casillas:
    p09:9828 en x = 0x10, y = 0x30 (10 x 12 casillas: el pinguino) y p09:98A0
    en x = 0x78, y = 0x30 (14 x 12: la tele) (p09:86C8)."""
    rotulo_msx2(v)
    v.v[0x3B00:0x3B80] = bytes([0xE0]) * 0x80         # p09:8894 (cae en la pagina 0)
    v.v[0:0x8000] = bytes(0x8000)                     # p09:8695
    v.borde = 13                                      # p09:86F8
    v.paleta_lista(PRESENTACION, 0x8706)
    P10 = {0xA000: 10}
    descomprime_casillas(v, P10, 0xA580, 0x8C00)      # p09:8731
    descomprime_casillas(v, P10, 0xA390, 0x8800)      # p09:873A
    descomprime_lineal(v, PRESENTACION, 0x9D0A, 0xF800)    # p09:86B3 (p01:733A)
    v.v[0xF400:0xF430] = bytes([0x0B]) * 0x30         # p09:86BC
    letras_8x8(v, PRESENTACION, 0x9828, 0x10, 0x30, 0x0A, 0x0C)   # p09:86C8
    letras_8x8(v, PRESENTACION, 0x98A0, 0x78, 0x30, 0x0E, 0x0C)   # p09:86D4


class Vram4(Vram2):
    """Los menus en MSX2: p00:5EC2 pone SCREEN 4 con la BIOS, pero luego los
    registros de p01:72E2 dejan R#0 = 2 (SCREEN 2) con la paleta del MSX2."""

    def pinta4(self):
        return screen2.pinta(bytes(self.v[0:0x4000]), self.borde, True, self.paleta)


def menu_self_msx2(v):
    """El SELF MODE MENU en MSX2: p00:5EC2 borra 64 KB (p00:5EEA), pone
    SCREEN 4 (CHGMOD), los registros de p01:72E2 y la paleta de p01:728E;
    lo demas, como en MSX1 (tools/pantallas.py, menu_self)."""
    import pantallas
    m = pantallas.Vram()
    pantallas.menu_self(m)
    v.v[0:0x10000] = bytes(0x10000)
    v.v[0:0x4000] = m.v
    v.paleta_tabla(1, 0x728E)
    v.borde = m.borde


BIO = {0x6000: 1, 0x8000: 5, 0xA000: 6}


def linea(v, x, y, largo, color, vertical=False, pagina=0):
    """LINE (p05:832F / p05:8365) recta: el lado largo NX = largo, el corto 0."""
    for k in range(largo + 1):
        if vertical:
            v.pon(x, (y + k) & 0xFF, pagina, color & 0x0F)
        else:
            v.pon((x + k) & 0xFF, y, pagina, color & 0x0F)


def rectangulo(v, x, y, ancho, alto, color):
    """p05:839C: el marco con cuatro lineas (izquierda, arriba, abajo, derecha)."""
    linea(v, x, y, alto, color, True)
    linea(v, x, y, ancho, color)
    linea(v, x, y + alto, ancho, color)
    linea(v, x + ancho, y, alto, color, True)


def letra_hoja(c):
    """p05:8720: la letra c en la hoja de la pagina 1: c - 0x20 (salvo el 0),
    32 por fila de 8 puntos."""
    i = (c - 0x20) & 0xFF if c else 0
    return (i & 0x1F) * 8, (i & 0xE0) >> 2


def lmmm_timp(v, sx, sy, dx, dy, nx, ny, origen, destino):
    """LMMM con TIMP (p05:86FC, A = 0x48): punto a punto, menos el color 0."""
    for y in range(ny):
        for x in range(nx):
            c = v.punto(sx + x, sy + y, origen)
            if c:
                v.pon(dx + x, dy + y, destino, c)


def texto_8x8(v, bancos, hl_):
    """p05:86AF: [x, y] y letras (LMMM TIMP desde la hoja); 0xFE otra
    posicion, 0xFF acaba."""
    while True:
        x, y = rom(bancos, hl_, 2)
        hl_ += 2
        while True:
            c = rom(bancos, hl_)[0]
            hl_ += 1
            if c == 0xFF:
                return
            if c == 0xFE:
                break
            sx, sy = letra_hoja(c)
            lmmm_timp(v, sx, sy, x, y, 8, 8, 1, 0)
            x = (x + 8) & 0xFF


def bio_pantalla_msx2(v):
    """El biorritmo en MSX2 (p05:8768 y p05:8D22): SCREEN 5 (CHGMOD), los
    registros de p05:87B2, el borde 0 (R#7), sin sprites; 0xD8 en 0xF600, la
    paleta de p05:8D77, tres casillas de color 1 en la pagina 1 (p05:8D38) y la
    hoja de letras de la pagina 1 (p05:896E): 16 veces la letra de p05:8B0C
    con los colores 0-15, la fuente de la BIOS desde el espacio (0x60 letras)
    en la fila 1, las 0x2B letras de p05:89B4 desde x = 0x80 de la fila 0 (que
    siguen en la fila 1 tapando la BIOS: la fuente gorda) y las 2 de p05:8E06
    en la fila 3."""
    import pantallas
    # p05:8787: CHGMOD 5. Lo que hace la BIOS (aqui la C-BIOS de los cotejos):
    # borra las 212 lineas de la pagina 0 con el color de fondo (BAKCLR = 4) y
    # deja los sprites en Y = 0xD9 con patrones 0, 4, 8... (0x7600)
    v.v[0:0x6A00] = bytes([0x44]) * 0x6A00
    for k in range(32):
        v.v[0x7600 + 4 * k:0x7604 + 4 * k] = bytes([0xD9, 0, 4 * k, 0x0F])
    v.v[0xF680:0xF6A0] = rom(BIO, 0x82D7, 32)         # p05:82C3: la paleta, tambien en VRAM (p05:82B0)
    v.v[0xF600] = 0xD8                                # p05:827B
    v.paleta_tabla(BIO, 0x8D77)                       # p05:8D70
    v.v[0xF680:0xF6A0] = rom(BIO, 0x8D77, 32)
    v.borde = 0                                       # p05:87A9
    for y in (0x00, 0x40, 0x80):                      # p05:8D38
        v.hmmv(0, y, 8, 8, 1, 0x01)
    x = y = 0
    for color in range(16):                           # p05:8973
        letra_4bit(v, BIO, 0x8B0C, x, y, color)
        x = (x + 8) & 0xFF
        if x == 0:
            y += 8

    def letras(hl_, x, y, n, color):                  # p05:8628
        for k in range(n):
            letra_4bit(v, None, hl_ + 8 * k, x, y, color)
            x = (x + 8) & 0xFF
            if x == 0:
                y += 8
    bios = pantallas.BIOS
    cg = bios[4] | bios[5] << 8
    fuente = bios[cg + 0x20 * 8:cg + 0x80 * 8]
    x, y = 0, 8                                       # p05:8989
    for k in range(0x60):
        for f in range(8):
            b = fuente[8 * k + f]
            for p in range(8):
                v.pon(x + p, y + f, 1, 0x0F if b & (0x80 >> p) else 0)
        x = (x + 8) & 0xFF
        if x == 0:
            y += 8
    for hl_, x, y, n in ((0x89B4, 0x80, 0x00, 0x2B), (0x8E06, 0x00, 0x18, 0x02)):   # p05:8997, 8DF9
        for k in range(n):
            letra_4bit(v, BIO, hl_ + 8 * k, x, y, 0x0F)
            x = (x + 8) & 0xFF
            if x == 0:
                y += 8


def bio_entrada_msx2(v):
    """La primera pregunta (p05:9717 y p05:974D -> p06:A066): la caja de la
    fecha de nacimiento con su sombra (HMMV 0x99 en (0x1E, 0x16) y la caja 0x55
    en (0x1A, 0x12), 0x8C x 0x1C), su marco blanco (p05:839C) y el texto de
    p06:A15E; las cifras vacias (p05:9ACC: cada casilla borrada con 0x55 y la
    letra 0xD4 + 0x30, que en la hoja esta vacia)."""
    bio_pantalla_msx2(v)
    v.hmmv(0x1E, 0x16, 0x8C, 0x1C, 0, 0x99)           # p06:A066
    v.hmmv(0x1A, 0x12, 0x8C, 0x1C, 0, 0x55)           # p06:A073
    rectangulo(v, 0x1A, 0x12, 0x8C, 0x1C, 0x0F)       # p06:A080
    texto_8x8(v, BIO, 0xA15E)                         # p06:A08B
    for x, n in ((0x30, 4), (0x68, 2), (0x90, 2)):    # p05:9ACC
        for k in range(n):
            v.hmmv(x + 8 * k, 0x20, 8, 8, 0, 0x55)    # p05:9B25
            sx, sy = letra_hoja((0xD4 + 0x30) & 0xFF)
            lmmm_timp(v, sx, sy, x + 8 * k, 0x20, 8, 8, 1, 0)


PANTALLAS = {
    "logo_konami_msx2": logo_konami_msx2,
    "rotulo_msx2": rotulo_msx2,
    "menu_msx2": menu_msx2,
    "menu_self_msx2": menu_self_msx2,
    "bio_entrada_msx2": bio_entrada_msx2,
}
CLASE = {"menu_self_msx2": Vram4}             # las de SCREEN 2 con paleta


def monta(nombre):
    v = CLASE.get(nombre, Vram2)()
    PANTALLAS[nombre](v)
    return v


def main(argv):
    nombres = list(PANTALLAS) if argv[1] == "todas" else [argv[1]]
    os.makedirs(argv[2], exist_ok=True)
    for n in nombres:
        v = monta(n)
        if isinstance(v, Vram4):
            screen2.png(256, 192, v.pinta4(), os.path.join(argv[2], n + ".png"))
        else:
            screen2.png(256, 212, v.pinta5(), os.path.join(argv[2], n + ".png"))
        open(os.path.join(argv[2], n + ".vram"), "wb").write(v.v)
        print(n)


if __name__ == "__main__":
    main(sys.argv)
