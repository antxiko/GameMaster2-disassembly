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
