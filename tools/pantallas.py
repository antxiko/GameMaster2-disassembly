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
# Lo de los menus del cartucho solo: p00 y p01 seguidos en 0x4000-0x7FFF.
MENUS = {0x6000: 1}
# La ventana en que corre cada banco (tools/paginas.py).
VENTANA = {0: 0x4000, 1: 0x6000, 2: 0x8000, 4: 0x8000, 5: 0x8000, 7: 0x8000,
           9: 0x8000, 3: 0xA000, 6: 0xA000, 8: 0xA000, 10: 0xA000, 11: 0xA000}


def rom(bancos, dir_, n=1):
    """n bytes desde la direccion de CPU dir_, como los lee la CPU: cada
    ventana de 8 KB con su banco (un bloque puede pasar de una a otra).
    `bancos` es un reparto {ventana: banco} o un banco suelto."""
    if isinstance(bancos, int):
        bancos = {VENTANA[bancos]: bancos}
    out = bytearray()
    for d in range(dir_, dir_ + n):
        ventana = d & 0xE000
        b = 0 if ventana == 0x4000 else bancos[ventana]   # KeyError: fuera del reparto
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


def tercios_llena(v, dest, n, valor):                 # p01:72FC
    for t in range(3):
        v.llena(dest + 0x800 * t, n, valor)


def tercios_copia(v, bancos, origen, dest, n):        # p01:730D
    for t in range(3):
        v.copia(bancos, origen, dest + 0x800 * t, n)


def pantalla_de_menu(v):
    """p00:5EC2 (pantalla_del_menu) en MSX1 y p09:8191 (titulo_graficos).

    La VRAM entera a cero (p00:5EEA) y los registros de p01:72E2; luego los
    dibujos de la presentacion que usan los menus: p09:81DB da a las letras
    0x00-0x0F los colores 0x00, 0x11 ... 0xFF (las casillas de color), las
    0x80-0x85 son trozos de marco (p09:819B) y la fuente del cartucho
    (p00:483F) va a las letras 0x30-0x5A con tinta blanca (p09:823D)."""
    v.llena(0x0000, 0x4000, 0)
    v.borde = 1                                       # R#7 = 0xE1 (p01:72E2)
    v.llena(0x3800, 0x300, 0)                         # p01:6691 (p01:72EA)
    v.v[0x3B00] = 0xD0
    P = PRESENTACION
    v.descomprime_tercios(P, 0x81DB, 0x0000)          # p09:81D2
    tercios_llena(v, 0x2400, 0x20, 0x3F)              # p09:819B
    tercios_llena(v, 0x2420, 0x20, 0xFC)              # p09:81A6
    v.descomprime_tercios(P, 0x81FC, 0x0400)          # p09:81B1
    tercios_copia(v, P, 0x820D, 0x2440, 0x30)         # p09:81BA
    tercios_llena(v, 0x0440, 0x30, 0xF0)              # p09:81C6
    tercios_copia(v, P, 0x483F, 0x2180, 0x158)        # p09:823D
    tercios_llena(v, 0x0180, 0x158, 0xF0)             # p09:8249


def casillas_de_color(v):
    """p01:6762: cuatro filas de las 16 casillas (letras 1-15 y 0, dos veces
    cada una) arriba (0x3800) y abajo (0x3A80)."""
    for base in (0x3800, 0x3A80):
        d = base
        for _ in range(4):
            a = 1
            for _ in range(16):
                v.v[d] = v.v[d + 1] = a
                d += 2
                a = (a + 1) & 0x0F


def menu_self(v):
    """p00:5DEE: el SELF MODE MENU, esperando tecla (p01:767C) con el cursor
    (la letra 0x3A, una flecha en esta fuente) en la primera opcion."""
    pantalla_de_menu(v)
    v.borde = 1                                       # p01:66F6: R#7 = 0x01
    v.llena(0x3800, 0x300, 0)                         # p01:66FC
    v.v[0x3B00] = 0xD0
    casillas_de_color(v)                              # p00:5DF1
    v.llena(0x3880, 0x200, 0)                         # p00:5DF4 (p01:62D3)
    v.texto(MENUS, 0x5FCF)                            # p00:5DF7
    lista = rom(1, 0x6030, 2)                         # p00:5DFD: las 5 posiciones
    v.v[lista[0] | lista[1] << 8] = 0x3A              # p01:76AF -> p01:7633


BIOS = open(os.path.join(RAIZ, "cbios_main_msx1_jp.rom"), "rb").read()


def fuente_de_la_bios():
    """CGTABL (la palabra de 0x0004): la fuente de la maquina. Aqui la de la
    C-BIOS MSX1 japonesa, la de los cotejos de la serie en openMSX; en otra
    maquina las letras cambian de dibujo."""
    cg = BIOS[4] | BIOS[5] << 8
    return BIOS[cg:cg + 0x800]


def sram_utilidad(v):
    """p01:7973: SRAM DISK UTILITY, esperando tecla en su menu (p01:7696).

    Viene del menu SELF (opcion 1). Borra los nombres (p00:448D), pone la
    fuente de la BIOS en los dibujos y tinta blanca en los colores (0x7F0
    bytes por tercio), el texto de p00:4123 y el menu de 4 opciones de
    p00:4175, con el cursor en la letra 0x10 (0xF2E6 = 1, p01:79B4)."""
    menu_self(v)
    v.llena(0x3800, 0x300, 0)                         # p01:7987
    f = fuente_de_la_bios()
    for t in range(3):                                # p01:7997
        v.v[0x2000 + 0x800 * t:0x2000 + 0x800 * t + 0x7F0] = f[:0x7F0]
    tercios_llena(v, 0x0000, 0x7F0, 0xF0)             # p01:79A3
    v.texto(0, 0x4123)                                # p01:79B9
    lista = rom(0, 0x4175, 2)                         # p01:79C1
    v.v[lista[0] | lista[1] << 8] = 0x10              # p01:76AF -> p01:7633
    tercios_copia(v, 1, 0x762B, 0x2080, 8)            # p01:7693 -> p01:760A: la flecha


TENIS = {0x6000: 1, 0x8000: 7, 0xA000: 8}             # Tennis and Hockey: p07 y p08


def th_tercios(v, dest, hl_, pasos=3):
    """p07:8616: el descompresor de p07:8647 (el mismo formato que p01:733A)
    en los tres tercios."""
    for t in range(pasos):
        v.descomprime(TENIS, hl_, dest + 0x800 * t)


def th_sprites(v, copia):
    """p07:866C: la copia de 0xE500 (32 sprites) a 0x3B00, cada Y - 1. El
    cartucho empieza cada cuadro por una pareja distinta (0xE40B, contra el
    parpadeo); aqui van en el orden de la copia y el cotejo los mira como
    conjunto."""
    for i in range(32):
        y, x, p, c = copia[i * 4:i * 4 + 4]
        v.v[0x3B00 + i * 4:0x3B04 + i * 4] = bytes([(y - 1) & 0xFF, x, p, c])


def th_pantalla_base(v):
    """El primer cuadro de Tennis and Hockey (p07:8000 -> estado 0): la VRAM a
    cero y los registros de p07:86D5 (R#7 = 0xE0: borde negro), sprites
    escondidos (0xE0 en 0xE500-0xE52F, p07:8495), nombres a cero, la fuente
    (p07:8823), los dibujos de la pista (p07:9386), sus colores (p07:951D y
    p07:9535)."""
    v.llena(0x0000, 0x4000, 0)                        # p07:86BA
    v.borde = 0
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30              # p07:8495
    th_sprites(v, copia)
    v.llena(0x3800, 0x300, 0)                         # p07:85D8
    tercios_llena(v, 0x2000, 0x80, 0)                 # p07:883A: dibujos 0x00-0x0F vacios
    for k in range(16):                               # p07:8844: la letra k, color k
        tercios_llena(v, 8 * k, 8, k)
    th_tercios(v, 0x2080, 0x885B)                     # p07:8826: la fuente desde la letra 0x10
    tercios_llena(v, 0x0080, 0x158, 0xF0)             # p07:882F
    th_tercios(v, 0x2300, 0x9386)                     # p07:9082
    th_tercios(v, 0x0300, 0x951D)                     # p07:908B
    d = rom(TENIS, 0x9535, 2)                         # p07:9094 -> p07:8641
    v.descomprime(TENIS, 0x9537, d[0] | d[1] << 8)


def tenis_menu(v):
    """GAME SELECT (p07:909A) y, en el cuadro siguiente, la flecha (la letra
    0x8D) en TENNIS (p07:90D0, posiciones de p07:90FA)."""
    th_pantalla_base(v)
    v.texto(TENIS, 0x876E)                            # p07:909A (p07:8626)
    for d in (0x394D, 0x398D, 0x39CD):                # p07:90D0
        v.v[d] = 0
    p = rom(TENIS, 0x90FA, 2)
    v.v[p[0] | p[1] << 8] = 0x8D


def tenis_modify(v, valores=(0, 0, 0, 0)):
    """GAME MODIFY (p07:80F7 -> p07:9100), tras el espacio en GAME SELECT, y
    su primer cuadro (p07:9136 -> p07:9199): la flecha en LENGTH (0x8D en la
    primera de p07:920C) y los cuatro recuadros rojos, que son los sprites
    de p07:9126 (patron 0x24, color 8) llevados a la Y, X del valor de cada
    opcion (tablas de p07:9214, 921C, 9226, 922C). Los valores de 0xE461...
    estan a cero (p07:8045 borra 0xE200-0xE8FF): 1, 1, A y N."""
    tenis_menu(v)
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30              # p07:85D5 -> p07:8495
    v.llena(0x3800, 0x300, 0)
    v.texto(TENIS, 0x87A5)                            # p07:9100
    copia[0:0x10] = rom(TENIS, 0x9126, 0x10)          # p07:9106
    for d in (0x38CF, 0x390F, 0x394F, 0x398F):        # p07:9199
        v.v[d] = 0
    p = rom(TENIS, 0x920C, 2)                         # p07:91B5
    v.v[p[0] | p[1] << 8] = 0x8D
    for k, tabla in enumerate((0x9214, 0x921C, 0x9226, 0x922C)):   # p07:91C8
        yx = rom(TENIS, tabla + 2 * valores[k], 2)
        copia[4 * k:4 * k + 2] = yx
    th_sprites(v, copia)


def tenis_set(v):
    """1ST SET START (p07:8141, estado 0x0200), cuando acaba la melodia que
    suena tras el espacio en GAME MODIFY: nombres y sprites borrados
    (p07:85D5), "SET START" (p07:8186) y delante, en 0x3909, las tres letras
    del set que se juega (0xE40C = 0) de la tabla de p07:8176."""
    tenis_modify(v)
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30              # p07:8495
    copia[0x30:0x80] = bytes(0x50)
    th_sprites(v, copia)
    v.llena(0x3800, 0x300, 0)                         # p07:85D8
    v.texto(TENIS, 0x8186)                            # p07:815A
    v.v[0x3909:0x390C] = rom(TENIS, 0x8176, 3)        # p07:8160


def th_cifra(v, dest, n):
    """p07:8596: la cifra n con las dos letras de p07:85AD, una encima de otra."""
    p = rom(TENIS, 0x85AD + 2 * n, 2)
    v.v[dest], v.v[dest + 32] = p[0], p[1]


def th_raqueta(copia, i, y, x, largo, patrones, color):
    """p07:8C17: una raqueta en los sprites i, i+1 de la copia. Con 0xE427 = 1
    (LENGTH 1) el segundo sprite se esconde (los cuatro bytes a 0xE0)."""
    copia[4 * i:4 * i + 4] = bytes([y, x, patrones[0], color])
    if largo == 1:
        copia[4 * i + 4:4 * i + 8] = bytes([0xE0] * 4)
    else:
        copia[4 * i + 4:4 * i + 8] = bytes([(y + 16) & 0xFF, x, patrones[1], color])


def tenis_pista(v, length=0, type_=0):
    """La pista de tenis preparada (p07:81A2: th_pinta_marcadores y
    th_partido), antes del primer cuadro de juego; con las opciones de salida
    (LENGTH 1, SPEED 1, TYPE A, BAR N) y saca el 1P (0xE41A = 1, p07:9266).

    Marcador (p07:84A5): la cabecera de p07:84C6 en las dos primeras filas, los
    tantos (0xE410, 0xE411) en cifras grandes y los juegos (0xE417, 0xE41B).
    La pista: p07:95BC (0x2C0 bytes) en 0x3840 (p07:89A7). Sprites: la copia
    borrada (p07:8495), la pelota en (0x60, 0xDA) (p07:8CE6 y p07:8CEE), la
    raqueta del 1P en la columna 0xE0 con color 0x0A y la del 2P en 0x10 con
    color 7 (p07:8A41, p07:8A9F), a la altura de p07:8A51 segun LENGTH y con
    los patrones de p07:8AD9."""
    tenis_set(v)
    v.v[0x3800:0x3840] = rom(TENIS, 0x84C6, 0x40)    # p07:84B1
    for d in (0x3814, 0x3815, 0x380D, 0x380E):        # p07:8551: 00 y 00
        th_cifra(v, d, 0)
    th_cifra(v, 0x381C, 0)                            # p07:8574: los juegos
    th_cifra(v, 0x3808, 0)
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30              # p07:898C
    v.v[0x3B00:0x3B80] = copia                        # p07:898F: la copia tal cual
    v.v[0x3840:0x3B00] = rom(TENIS, 0x95BC, 0x2C0)   # p07:89A7
    y = rom(TENIS, 0x8A51 + length)[0]                # p07:8A0A
    largo = 1 if length < 2 else 2                    # p07:8A1A
    pat = rom(TENIS, 0x8AD9 + 2 * length, 2)          # p07:8AAF
    th_raqueta(copia, 1, y, 0xE0, largo, pat, 0x0A)   # p07:8BD7: el 1P
    th_raqueta(copia, 5, y, 0x10, largo, pat, 0x07)   # p07:8BF9: el 2P
    copia[0:4] = bytes([0x60, 0xDA, 0x00, 0x0F])      # p07:902C: la pelota
    th_sprites(v, copia)                              # p07:89D0


def hockey_start(v):
    """Lo mismo que tenis_set para el hockey (0xE412 = 2): p07:8154 salta el
    SET y pinta solo "START" (p07:817F, el texto de p07:8192). Antes, en
    GAME SELECT, la flecha baja a HOCKEY (p07:90C1); GAME MODIFY es igual."""
    tenis_modify(v)
    v.v[0x394D] = 0                                   # p07:90D0 (la flecha ya no esta en TENNIS)
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30
    th_sprites(v, copia)
    v.llena(0x3800, 0x300, 0)                         # p07:85D8
    v.texto(TENIS, 0x8192)                            # p07:817F


def hockey_pista(v, length=0):
    """La pista de hockey preparada (p07:81A2), como tenis_pista: la cabecera
    de p07:8506, los goles en cifras grandes y el reloj (0xE419 = 0x90,
    p07:8147) en 0x381C; la pista de p07:987C; las raquetas en las columnas
    0xB8 (1P) y 0x38 (2P) (p07:8A47, p07:8AA5) y la pelota en (0x60, 0xB3)
    (p07:8CEF: saca el 1P)."""
    hockey_start(v)
    v.v[0x3800:0x3840] = rom(TENIS, 0x8506, 0x40)    # p07:84BD
    for d in (0x3814, 0x3815, 0x380D, 0x380E):        # p07:8551
        th_cifra(v, d, 0)
    th_cifra(v, 0x381C, 9)                            # p07:8562: el reloj, 90
    th_cifra(v, 0x381D, 0)
    copia = bytearray(0x80)
    copia[0:0x30] = bytes([0xE0]) * 0x30              # p07:898C
    v.v[0x3B00:0x3B80] = copia
    v.v[0x3840:0x3B00] = rom(TENIS, 0x987C, 0x2C0)   # p07:89A4
    y = rom(TENIS, 0x8A51 + length)[0]
    largo = 1 if length < 2 else 2
    pat = rom(TENIS, 0x8AD9 + 2 * length, 2)
    th_raqueta(copia, 1, y, 0xB8, largo, pat, 0x0A)
    th_raqueta(copia, 5, y, 0x38, largo, pat, 0x07)
    copia[0:4] = bytes([0x60, 0xB3, 0x00, 0x0F])
    th_sprites(v, copia)


BIO = {0x6000: 1, 0x8000: 5, 0xA000: 6}               # el biorritmo: p05 y p06 seguidos


def bio_texto(copia, hl_):
    """p05:80D4 (pinta_texto_bio_b): [direccion] y letras a la copia de
    nombres de 0xE300; 0x81 trae otra direccion y 0x80 acaba."""
    while True:
        d = rom(BIO, hl_, 2)
        d = d[0] | d[1] << 8
        hl_ += 2
        while True:
            c = rom(BIO, hl_)[0]
            hl_ += 1
            if c == 0x80:
                return
            if c == 0x81:
                break
            copia[d - 0xE300] = c
            d += 1


def bio_entrada(v, cursor=0x0F):
    """El biorritmo de MSX1 pidiendo las fechas (p05:9674).

    p05:873D: la VRAM a cero y los registros de p05:8758; p05:8C73: borde 0,
    la fuente de p05:8808 desde la letra 0x10 con color 0xF4 (blanco sobre
    azul), las cifras grandes de p05:8951 en 0x2500, los dibujos de las letras
    0x40-0xFF vacios (0x2A00) y su color 0xF4, los sprites de p05:8DCC. La
    copia de la tabla de nombres (0xE300, 0x300 bytes): las filas 0-9 con la
    letra 4 (azul) y las 10-23 con una letra distinta cada casilla (de 0x40
    a 0xFF y de 0x00 a 0xFF, p05:8CB7): un lienzo para la grafica. Encima, el
    recuadro y los rotulos de p05:9E50, las cifras vacias (0xF4 + 0x10 = 4)
    y el cursor en la primera cifra del ano de nacimiento (p05:96AD): el
    cuadro blanco (0x0F) cuando el bit 2 del parpadeo (0xE00D) esta a cero;
    con el bit a uno, la cifra que haya (4: vacia)."""
    v.llena(0x0000, 0x4000, 0)                        # p05:873D
    v.borde = 0                                       # p05:8C73
    tercios_llena(v, 0x2000, 0x80, 0)                 # p05:87BA -> th_patrones
    for k in range(16):
        tercios_llena(v, 8 * k, 8, k)
    for t in range(3):                                # p05:87BD
        v.descomprime(BIO, 0x8808, 0x2080 + 0x800 * t)
    tercios_llena(v, 0x0080, 0x780, 0xF4)             # p05:87C6
    v.descomprime(BIO, 0x8951, 0x2500)                # p05:87F3
    tercios_llena(v, 0x0500, 0xC0, 0xF4)              # p05:87FC
    v.llena(0x2A00, 0xDFF, 0)                         # p05:8CA1
    v.llena(0x0A00, 0x11FF, 0xF4)
    v.descomprime(BIO, 0x8DCC, 0x1800)                # p05:8CD1
    copia = bytearray(0x300)
    copia[0x100:0x300] = bytes(range(256)) * 2        # p05:8CB7 (0xE400-0xE5FF)
    copia[0x100:0x140] = bytes(0x40)
    copia[0:0x140] = bytes([4]) * 0x140               # p05:8C92
    bio_texto(copia, 0x9E50)                          # p05:9DDA
    for d, n in ((0x4F, 4), (0x56, 2), (0x5B, 2), (0xAF, 4), (0xB6, 2), (0xBB, 2)):   # p05:9628
        copia[d:d + n] = bytes([4]) * n
    p = rom(BIO, 0x96D2, 2)                           # p05:96B8: la cifra 0
    copia[(p[0] | p[1] << 8) - 0xE300] = cursor
    v.v[0x3800:0x3B00] = copia                        # p05:8D07


def bio_dias(y, m, d):
    """p05:8E34-8F46: el dia de la fecha: ano x 365 + (ano-1)/4 - (ano-1)/100
    + (ano-1)/400 + los dias hasta el mes (p05:959E) + el dia, y uno mas desde
    marzo en ano bisiesto."""
    hasta = rom(BIO, 0x959E, 24)
    n = y * 365 + (y - 1) // 4 - (y - 1) // 100 + (y - 1) // 400
    n += (hasta[2 * (m - 1)] << 8 | hasta[2 * (m - 1) + 1]) + d
    if (y % 4 == 0 and y % 100 != 0) or y % 400 == 0:
        if m > 2:
            n += 1
    return n


def bio_seno(angulo):
    """p05:932F: la altura del angulo (0-359) con la tabla de p05:94E8 (un
    byte util de cada dos); negativa arriba (la pantalla crece hacia abajo)."""
    t = lambda k: rom(BIO, 0x94E8 + ((2 * k) & 0xFF))[0]
    if angulo >= 270:
        return t(360 - angulo)
    if angulo >= 180:
        return t(angulo - 180)
    if angulo >= 90:
        return (-t(180 - angulo)) & 0xFF
    return (-t(angulo)) & 0xFF


def bio_grafica(v, nacimiento=(1970, 1, 1), dia=(1988, 1, 1)):
    """La grafica del biorritmo de MSX1 (estados 1-5 de la tabla de p05:8B1B),
    con las dos fechas de ejemplo tecleadas en bio_entrada.

    1 (p05:8E34): dias vividos, el resto entre 23, 28 y 33, a grados
      (x 360 / ciclo) y menos el retraso de p05:9043 (235, 193, 164: los 15
      dias de antes de hoy).
    2 (p05:8B78): textos de p05:9EDC; las guias (p05:9F97: bits OR en los
      dibujos de la zona de la grafica, filas 10-21, columnas 3-28) y esa zona
      con color 0xF0 (p05:9F7F); las letras P, S, I ordenadas por la altura
      del primer dia (p06:A33D) en 0xE441/61/81 y el texto de p05:9EF9.
    3 (p05:8B8D): 192 columnas. Cada una suma 4, 3 y 2 grados a los angulos,
      saca la altura (seno + 0x88) y pinta el punto (p05:90DF: solo si la
      casilla tiene el color 0xF0, OR del bit en el dibujo); luego la
      correccion de p05:9179 (contadores de 4, 6 y 20 columnas).
    4 (p05:8BBD): textos de p05:9F0A y 9F29, los angulos de hoy, la fecha y
      el nivel de cada ciclo (umbrales 0xA0, 0x90, 0x80, 0x70; textos de
      p05:9DC2) en 0xE36A, 0xE38A, 0xE3AA.
    5 (p05:8BDB): vuelca los nombres y los 6 sprites de p05:8CE2 (la raya del
      dia 0) mas 6 bytes de la copia (0xE0)."""
    bio_entrada(v)
    copia = bytearray(v.v[0x3800:0x3B00])
    cifras = [int(c) for c in "%04d%02d%02d%04d%02d%02d" % (nacimiento + dia)]
    for (d, n), k in zip(((0x4F, 4), (0x56, 2), (0x5B, 2), (0xAF, 4), (0xB6, 2), (0xBB, 2)),
                         (0, 4, 6, 8, 12, 14)):
        copia[d:d + n] = bytes(c + 0x10 for c in cifras[k:k + n])
    # el cursor esta en la ultima cifra: no se pinta (p05:96B0)
    # --- 1: el calculo
    dias = bio_dias(*dia) - bio_dias(*nacimiento)
    ciclos = (23, 28, 33)
    retraso = rom(BIO, 0x9043, 6)
    ang = [(dias % c) * 360 // c - (retraso[2 * k] | retraso[2 * k + 1] << 8)
           for k, c in enumerate(ciclos)]
    hoy = list(ang)                                   # p05:9049 (0xE033)
    col = 0                                           # 0xE03F
    alt = [(bio_seno(a % 360) + 0x88) & 0xFF for a in ang]
    ang[0] %= 360                                     # p05:9055: solo el fisico se guarda
    # --- 2: el marco
    bio_texto(copia, 0x9EDC)
    for hl_, b, a in ((0x0A18, 0x1A, 0xFF), (0x1018, 0x1A, 0xCC), (0x1618, 0x1A, 0xFF),
                      (0x0919, 0x1A, 0xFF), (0x1619, 0x1A, 0xFF)):        # p05:9F97
        for k in range(b):
            v.v[hl_ + 0x2000 + 8 * k] |= a
    for hl_, a in ((0x0A18, 0xC0), (0x0A58, 0x10), (0x0AE0, 0x03)):         # p05:9FC9
        for f in range(12):
            for k in range(8):
                v.v[hl_ + 0x2000 + 0x100 * f + k] |= a
    for f in range(12):                               # p05:9F7F
        v.llena(0x0A18 + 0x100 * f, 0xD0, 0xF0)
    sprites = bytearray([0xE0]) * 0x80                # p05:8D14
    sprites[0:0x18] = rom(BIO, 0x8CE2, 0x18)          # p05:8CDB
    h, l = alt[0], 0x1B                               # p06:A33D: H >= D >= B
    d_, e = alt[1], 0x1C
    b_, c = alt[2], 0x1D
    if h < d_:
        h, l, d_, e = d_, e, h, l
    if h < b_:
        h, l, b_, c = b_, c, h, l
    if d_ < b_:
        d_, e, b_, c = b_, c, d_, e
    copia[0x141], copia[0x161], copia[0x181] = c, e, l
    bio_texto(copia, 0x9EF9)
    # --- 3: las 192 columnas
    cont = [0, 0, 0]                                  # 0xE06B, 0xE06C, 0xE06D
    for _ in range(192):
        alt = []
        for k, desp in enumerate((4, 3, 2)):          # p05:9265
            ang[k] = (ang[k] + desp) % 360
            alt.append(((bio_seno(ang[k]) + 0x88) & 0xFF, (col + 0x20) & 0xFF))
        for y, x in alt:                              # p05:90C3
            yy = (y - 8) & 0xFF
            dirc = (yy // 8) * 0x100 + yy % 8 + (x // 8) * 8
            if v.v[dirc] == 0xF0:
                v.v[dirc] = 0xF0
                v.v[dirc + 0x2000] |= 0x80 >> (x % 8)
        col += 1
        cont[1] = (cont[1] + 1) % 6                   # p05:9183
        if cont[1] == 0:
            ang[1] += 1
        cont[0] = (cont[0] + 1) % 4                   # p05:9197
        if cont[0] == 0:
            cont[2] = (cont[2] + 1) % 20
            if cont[2] == 0:
                ang[0] -= 1
        if cont[0]:                                   # p05:91B7
            ang[2] += 1
    # --- 4: el dia
    bio_texto(copia, 0x9F0A)
    bio_texto(copia, 0x9F29)
    hoy = [(a + (retraso[2 * k] | retraso[2 * k + 1] << 8)) % 360 for k, a in enumerate(hoy)]
    alt = [(bio_seno(a) + 0x88) & 0xFF for a in hoy]
    fecha = cifras[8:]
    copia[0x4F:0x53] = bytes(c + 0x10 for c in fecha[0:4])   # p05:9D21
    copia[0x56:0x58] = bytes(c + 0x10 for c in fecha[4:6])
    copia[0x5B:0x5D] = bytes(c + 0x10 for c in fecha[6:8])
    for a, dest in zip(alt, (0x6A, 0x8A, 0xAA)):      # p05:9D55
        nivel = sum(1 for u in (0xA0, 0x90, 0x80, 0x70) if a < u)
        t = rom(BIO, 0x9DC2 + 2 * nivel, 2)
        t = t[0] | t[1] << 8
        copia[dest + 3:dest + 8] = bytes([4]) * 5
        k = 0
        while rom(BIO, t + k)[0] != 0x80:
            copia[dest + k] = rom(BIO, t + k)[0]
            k += 1
    # --- 5: lo que vuelca el bucle de la grafica
    v.v[0x3800:0x3B00] = copia                        # p05:8D07
    v.v[0x3B00:0x3B1E] = sprites[0:0x1E]              # p05:8CFA


def menu_principal_internacional(v):
    """El menu principal con una BIOS no japonesa (0x002B & 0x0F distinto de 0,
    p09:8024): sin el rotulo grande (p09:8846 vuelve en seguida) y, dentro de
    titulo_dibuja, p09:8D27 (titulo_msx1_b): la fuente, el dibujo de p09:8DE6
    (la (C)) en la letra 0x10 del tercio de abajo, colores 0xF0, los dibujos
    de p10:B460 en 0x2080 y el rotulo GAME MASTER II (p09:8D99, 3 x 25 en
    0x3844; p09:8DE4, la TM, en 0x38BC) y el texto de p09:8D74."""
    logo_konami(v)
    P = PRESENTACION
    v.llena(0x3800, 0x300, 0)                         # p09:82D1 (p01:72EA)
    v.v[0x3B00] = 0xD0
    v.descomprime_tercios(P, 0x9DE3, 0x2300)          # p09:82D4
    v.descomprime_tercios(P, 0xA1E3, 0x0300)          # p09:82DD
    v.descomprime(P, 0xA32E, 0x1800)                  # p09:82E6
    tercios_copia(v, P, 0x483F, 0x2180, 0x158)        # p09:8D27 -> p09:823D
    tercios_llena(v, 0x0180, 0x158, 0xF0)
    v.copia(P, 0x8DE6, 0x3080, 8)                     # p09:8D2A
    v.llena(0x1080, 8, 0xF0)                          # p09:8D36
    v.llena(0x0080, 0x200, 0xF0)                      # p09:8D41
    v.descomprime(P, 0xB460, 0x2080)                  # p09:8D4C
    v.filas(P, 0x8D99, 0x3844, 3, 0x19)               # p09:8D55
    v.filas(P, 0x8DE4, 0x38BC, 1, 2)                  # p09:8D61
    v.texto(P, 0x8D74)                                # p09:8D6D
    v.filas(9, 0x8337, 0x38C2, 12, 10)                # p09:82F6
    v.filas(9, 0x83AF, 0x38CF, 12, 14)                # p09:8302
    v.copia(9, 0x831B, 0x3B00, 0x1C)                  # p09:830E


def sram_directorio(v):
    """DIRECTORY (p00:417D) con la SRAM sin formatear, de vuelta en el menu.

    Al elegir: borra 0x3AC0 (p01:79C8), 0x3A80 y 0x38A0 (p00:417D), pinta
    'DIRECTORY' (p00:41EC) y pide el directorio a la SRAM (orden 5, por CALSLT
    a p00:4020 -> p04:8000); sin marca de formato (p04:84FB) no hay lista y
    sale 'NO FILE' (p00:41E2). Vuelve al menu (p01:79B9): su texto y el cursor
    en la primera opcion."""
    sram_utilidad(v)
    v.v[0x3AC0:0x3AE0] = bytes(0x20)                  # p01:79C8
    v.v[0x3A80:0x3AC0] = bytes(0x40)                  # p00:417D
    v.v[0x38A0:0x39A0] = bytes(0x100)                 # p00:4180
    v.texto(0, 0x41EC)                                # p00:4193
    v.texto(0, 0x41E2)                                # p00:41D1
    v.texto(0, 0x4123)                                # p01:79B9
    lista = rom(0, 0x4175, 2)
    v.v[lista[0] | lista[1] << 8] = 0x10              # p01:7690


def sram_formatear(v):
    """FORMAT (p00:4333): la pregunta, esperando Y o N. Al elegir se borra
    0x3AC0 (p01:79C8); luego toda la tabla de nombres (p00:448D) y el texto
    de p00:4387 (FORMAT RAM DISK / OK PUSH Y / NO PUSH N)."""
    sram_utilidad(v)
    v.v[0x3AC0:0x3AE0] = bytes(0x20)                  # p01:79C8
    v.llena(0x3800, 0x300, 0)                         # p00:4333
    v.texto(0, 0x4387)                                # p00:4336


def sram_formateada(v):
    """Tras la Y: las ordenes 0x0C y 0x0D a la SRAM (p00:4373: borrarla y
    escribir la marca de formato), 'FORMAT COMPLETED' (p00:43B3, fila 22),
    borrado de las filas 5-12, 14-18 y 20-21 (p00:4369) y de vuelta al menu
    (p01:79B9) con el mensaje todavia abajo."""
    sram_formatear(v)
    v.texto(0, 0x43B3)                                # p00:435B
    v.v[0x38A0:0x39A0] = bytes(0x100)                 # p00:4369
    v.v[0x39C0:0x3A60] = bytes(0xA0)                  # p00:436C
    v.v[0x3A80:0x3AC0] = bytes(0x40)                  # p00:436F
    v.texto(0, 0x4123)                                # p01:79B9
    lista = rom(0, 0x4175, 2)
    v.v[lista[0] | lista[1] << 8] = 0x10              # p01:7690


def sram_borrar(v):
    """FILE DELETE (p00:4209, menu_borrar), esperando el nombre de 5 letras:
    borra 0x3AC0 (p01:79C8), 0x39C0 y 0x3A80 y pinta el texto de p00:42D3
    (DELETE FILE / FILE NAME -----)."""
    sram_utilidad(v)
    v.v[0x3AC0:0x3AE0] = bytes(0x20)                  # p01:79C8
    v.v[0x39C0:0x3A60] = bytes(0xA0)                  # p00:4209
    v.v[0x3A80:0x3AC0] = bytes(0x40)                  # p00:420C
    v.texto(0, 0x42D3)                                # p00:420F


PANTALLAS = {
    "logo_konami": logo_konami,
    "presentacion_japonesa": presentacion_japonesa,
    "menu_principal": menu_principal,
    "menu_self": menu_self,
    "sram_utilidad": sram_utilidad,
    "tenis_menu": tenis_menu,
    "tenis_modify": tenis_modify,
    "tenis_set": tenis_set,
    "tenis_pista": tenis_pista,
    "hockey_start": hockey_start,
    "hockey_pista": hockey_pista,
    "bio_entrada": bio_entrada,
    "bio_grafica": bio_grafica,
    "menu_principal_internacional": menu_principal_internacional,
    "sram_directorio": sram_directorio,
    "sram_formatear": sram_formatear,
    "sram_formateada": sram_formateada,
    "sram_borrar": sram_borrar,
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
