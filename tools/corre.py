#!/usr/bin/env python3
"""El Game Master 2 corriendo en tools/z80run.py, SOLO para cotejar dibujos.

Las imagenes se dibujan con tools/pantallas.py leyendo las tablas del cartucho;
esto ejecuta las rutinas de verdad para comparar la VRAM que dejan contra la
que monta aquel, byte a byte (ver la norma "ejecutar no es dibujar").

Lo que pone alrededor del Z80:

  - el mapper GameMaster2: 0x4000 fijo al banco 0; una escritura en
    0x6000-0x6FFF, 0x8000-0x8FFF o 0xA000-0xAFFF elige el banco de esa ventana;
    en 0xA000 un valor con el bit 4 pone la SRAM (dos mitades de 4 KB en
    0xA000-0xAFFF y 0xB000-0xBFFF, la de 0xB000 se puede escribir);
  - los slots justos: el Game Master en el slot 1, la RAM en el 3 y ningun
    cartucho mas. ENASLT en la pagina 2 cambia entre el cartucho y la RAM;
  - la BIOS de MSX1 atrapada por su direccion (las que el cartucho llama);
    una que no este aqui REVIENTA, no se salta.
"""
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from z80run import Z80, ParadaZ80  # noqa: E402

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SLOT_GM, SLOT_RAM = 0x01, 0x03


class GameMaster2(Z80):
    def __init__(self, rom, msx2=False):
        super().__init__()
        self.rom = rom
        self.sram = bytearray(0x2000)
        self.ram2 = bytearray(0x4000)          # la RAM de la pagina 2
        self.pagina2_ram = False
        self.bancos = {}
        self.msx2 = msx2
        self.llamadas = []                     # las llamadas a la BIOS, en orden
        self.teclas = []                       # lo que devolvera CHGET, en orden
        self.chsns_ve_teclas = False           # CHSNS: si dice que hay tecla cuando la cola tiene
        for v, b in ((0x4000, 0), (0x6000, 1), (0x8000, 2), (0xA000, 3)):
            self.pon_banco(v, b)
        m = self.mem
        m[0x0006] = m[0x0007] = 0x98           # VDP.DR y VDP.DW
        m[0x002B] = 0x00                       # japones, 60 Hz
        m[0x002D] = 1 if msx2 else 0
        for s in range(4):
            m[0xFCC1 + s] = 0x00               # EXPTBL: nada expandido
        m[0xF3E0] = 0xE2                       # RG1SAV
        m[0xFD9A:0xFFCA] = bytes([0xC9]) * (0xFFCA - 0xFD9A)   # los ganchos, a `ret`
        self.ei = False
        self.cuadros = 0
        self.dentro = False
        self.por_cuadro = 10_000               # instrucciones entre interrupciones
        self._hasta = self.por_cuadro

    # ------------------------------------------------------------ memoria

    def pon_banco(self, ventana, banco):
        self.bancos[ventana] = banco
        if ventana >= 0x8000 and self.pagina2_ram:
            return
        if ventana == 0xA000 and banco & 0x10:
            self.mem[0xA000:0xC000] = self.sram
        else:
            b = banco & 0x0F
            self.mem[ventana:ventana + 0x2000] = self.rom[b * 0x2000:(b + 1) * 0x2000]

    def pagina2(self, ram):
        if ram == self.pagina2_ram:
            return
        if self.pagina2_ram:
            self.ram2[:] = self.mem[0x8000:0xC000]
        self.pagina2_ram = ram
        if ram:
            self.mem[0x8000:0xC000] = self.ram2
        else:
            self.pon_banco(0x8000, self.bancos[0x8000])
            self.pon_banco(0xA000, self.bancos[0xA000])

    def _escribir(self, d, v):
        d &= 0xFFFF
        v &= 0xFF
        if d < 0x4000:
            return
        if d < 0xC000 and not (d >= 0x8000 and self.pagina2_ram):
            if (d & 0x1000) == 0 and d >= 0x6000:
                self.pon_banco(d & 0xE000, v)
            elif d >= 0xB000 and self.bancos.get(0xA000, 0) & 0x10:
                self.sram[d - 0xA000] = v
                self.mem[d] = v
            return
        self.mem[d] = v

    # ------------------------------------------------------------ la BIOS

    def _bios(self, pc):
        v, a = self.vdp, self.a
        hl, de, bc = self._get_hl(), self._get_de(), self._get_bc()
        if pc == 0x0024:                       # ENASLT
            if (self.h & 0xC0) == 0x80:
                self.pagina2(a == SLOT_RAM)
        elif pc == 0x0020:                     # DCOMPR (rst 20h): Z si HL = DE, C si HL < DE
            self.f = (self.f & ~0x41) | (0x40 if hl == de else 0) | (0x01 if hl < de else 0)
        elif pc == 0x009C:                     # CHSNS: Z si no hay tecla en la cola
            hay = self.teclas and self.chsns_ve_teclas
            self.f = (self.f & ~0x40) | (0 if hay else 0x40)
        elif pc == 0x009F:                     # CHGET: la siguiente de la cola
            if not self.teclas:
                raise ParadaZ80("CHGET sin teclas (vuelve a 0x%04X)" % self._leer16(self.sp))
            self.a = self.teclas.pop(0)
        elif pc == 0x0138:                     # RSLREG: BIOS 0, el GM 1, pagina 2, RAM 3
            self.a = (SLOT_RAM << 6) | ((SLOT_RAM if self.pagina2_ram else SLOT_GM) << 4) | (SLOT_GM << 2)
        elif pc == 0x000C:                     # RDSLT: no hay mas cartuchos
            self.a = self._leer(hl) if a == SLOT_GM else 0xFF
        elif pc == 0x0047:                     # WRTVDP
            v.regs[self.c & 7] = self.b
        elif pc in (0x0041, 0x0044):           # DISSCR / ENASCR
            v.regs[1] = (v.regs[1] & ~0x40) | (0x40 if pc == 0x0044 else 0)
        elif pc == 0x004A:                     # RDVRM
            self.a = v.vram[hl & 0x3FFF]
        elif pc == 0x004D:                     # WRTVRM
            v.vram[hl & 0x3FFF] = a
        elif pc in (0x0053, 0x0171):           # SETWRT / NSTWRT
            v.dir = hl & 0x3FFF
        elif pc == 0x0050:                     # SETRD
            v.dir = hl & 0x3FFF
        elif pc in (0x0056, 0x016B):           # FILVRM / BIGFIL
            for i in range(bc):
                v.vram[(hl + i) & 0x3FFF] = a
        elif pc == 0x0059:                     # LDIRMV
            for i in range(bc):
                self._escribir(de + i, v.vram[(hl + i) & 0x3FFF])
        elif pc == 0x005C:                     # LDIRVM
            for i in range(bc):
                v.vram[(de + i) & 0x3FFF] = self._leer(hl + i)
        elif pc == 0x005F:                     # CHGMOD
            self.mem[0xFCAF] = a
        elif pc == 0x0062:                     # CHGCLR
            pass
        elif pc == 0x0141:                     # SNSMAT
            self.a = self.maq.teclado[a] if a < 12 else 0xFF
        elif pc in (0x0156, 0x0132, 0x0090):   # KILBUF / CHGCAP / GICINI
            pass
        elif pc == 0x0093:                     # WRTPSG
            self.maq.psg[a & 0x0F] = self.e
        elif pc == 0x0096:                     # RDPSG
            self.a = self.maq.psg[a & 0x0F]
        else:
            raise ParadaZ80("BIOS 0x%04X sin atrapar (vuelve a 0x%04X)"
                            % (pc, self._leer16(self.sp)))
        self.llamadas.append(pc)
        self.pc = self._leer16(self.sp)
        self.sp = (self.sp + 2) & 0xFFFF

    def _una(self):
        if self.pc < 0x4000:
            return self._bios(self.pc)
        op = self.mem[self.pc]
        if op == 0xF3:
            self.ei = False
        elif op == 0xFB:
            self.ei = True
        super()._una()
        if not self.dentro:
            self._hasta -= 1
            if self._hasta <= 0 and self.ei:
                self._hasta = self.por_cuadro
                self.interrupcion()

    def interrupcion(self):
        """Lo que hace la BIOS en cada cuadro: H.KEYI, H.TIMI y JIFFY.

        Se guardan los registros como la BIOS (push de todos) y se ejecutan los
        dos ganchos hasta su `ret`, con las interrupciones cerradas.
        """
        guardado = (self.a, self.f, self.b, self.c, self.d, self.e, self.h,
                    self.l, self.ix, self.iy, self.af_, self.bc_, self.de_,
                    self.hl_, self.pc, self.sp, self.pasos)
        self.dentro, self.ei = True, False
        self.cuadros += 1
        j = (self._leer16(0xFC9E) + 1) & 0xFFFF
        self.mem[0xFC9E], self.mem[0xFC9F] = j & 0xFF, j >> 8
        self.corre(0xFD9A)
        self.corre(0xFD9F)
        (self.a, self.f, self.b, self.c, self.d, self.e, self.h, self.l,
         self.ix, self.iy, self.af_, self.bc_, self.de_, self.hl_, self.pc,
         self.sp, self.pasos) = guardado
        self.dentro, self.ei = False, True

    def llama(self, dir_, tope=5_000_000):
        """Ejecuta una rutina hasta su `ret` (el centinela de z80run)."""
        self.corre(dir_, tope)


def cartucho(msx2=False):
    rom = open(os.path.join(RAIZ, "gamemaster2.rom"), "rb").read()
    return GameMaster2(rom, msx2)
