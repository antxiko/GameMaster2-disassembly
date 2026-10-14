#!/usr/bin/env python3
"""Lo que se ha MEDIDO del cartucho, clavado para que no se deshaga solo.

Estas comprobaciones necesitan la ROM, y si no esta **fallan**: no se saltan.
Cada una lee el binario: ninguna compara una constante contra si misma.
"""
import hashlib
import os
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOLS = os.path.join(RAIZ, "tools")
sys.path.insert(0, TOOLS)

from paginas import ORG, TAM_PAGINA  # noqa: E402

ROM = os.path.join(RAIZ, "gamemaster2.rom")
SHA = "2054636a6ca292d56106e13d7fb1a94899c712d2ed0dde3f929a2dd162cd85ef"

FALTA = ("falta gamemaster2.rom en la raiz del repo. Son los 131.072 bytes de "
         "Konami's Game Master 2 (Konami, RC-755, 1987, MSX), y no se "
         "distribuyen aqui: pon tu copia. El sha256 tiene que ser %s" % SHA)


def desplazamiento(banco, direccion):
    return banco * TAM_PAGINA + (direccion - ORG[banco])


class Cartucho(unittest.TestCase):

    @classmethod
    def setUpClass(cls):
        if not os.path.exists(ROM):
            raise AssertionError(FALTA)
        with open(ROM, "rb") as f:
            cls.rom = f.read()

    def lee(self, banco, direccion, n):
        o = desplazamiento(banco, direccion)
        return self.rom[o:o + n]

    def test_es_la_misma_rom(self):
        self.assertEqual(len(self.rom), 131072)
        self.assertEqual(hashlib.sha256(self.rom).hexdigest(), SHA)

    def test_cabecera_ab(self):
        """0x4000 'AB', INIT 0x5583 y los otros tres vectores a cero."""
        self.assertEqual(self.rom[0:2], b"AB")
        self.assertEqual(self.rom[2] | (self.rom[3] << 8), 0x5583)
        self.assertEqual(self.rom[4:10], b"\x00" * 6)

    def test_segunda_cabecera_yz(self):
        """0x4010 'YZ' y en 0x4018 un `jp 0x56E5`: lo que busca Shalom
        (Knightmare III, p01:611F) en la otra ranura."""
        self.assertEqual(self.rom[0x10:0x12], b"YZ")
        self.assertEqual(self.rom[0x18:0x1B], bytes([0xC3, 0xE5, 0x56]))

    def test_los_bancos_12_a_15_son_relleno(self):
        for b in range(12, 16):
            self.assertEqual(set(self.rom[b * TAM_PAGINA:(b + 1) * TAM_PAGINA]),
                             {0xFF}, "banco %d" % b)

    def test_reparto_de_bancos(self):
        """tools/reconocimiento.py: la regla banco -> org la cumplen todas."""
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "reconocimiento.py"), ROM],
                           capture_output=True, text=True, cwd=TOOLS)
        self.assertIn("OK: la regla banco -> org", r.stdout.strip().splitlines()[-1])

    def test_rutinas_que_cambian_de_banco(self):
        """Las de PONE_BANCOS de tools/bancos.py, leidas byte a byte."""
        # p00:40D6  ld a,1 / ld (6000),a / ld a,9 / ld (8000),a / inc a / ld (A000),a / ret
        self.assertEqual(self.lee(0, 0x40D6, 15), bytes.fromhex(
            "3e01320060" "3e09320080" "3c3200a0c9"))
        # p00:40E5  ld a,2 / ld (8000),a / inc a / ld (A000),a / ret
        self.assertEqual(self.lee(0, 0x40E5, 10), bytes.fromhex("3e02320080" "3c3200a0c9"))
        # p01:6735  ld a,9 / ld (8000),a / inc a / ld (A000),a / ret
        self.assertEqual(self.lee(1, 0x6735, 10), bytes.fromhex("3e09320080" "3c3200a0c9"))
        # p01:673F  ld a,2 / ld (8000),a / inc a / ld (A000),a
        self.assertEqual(self.lee(1, 0x673F, 9), bytes.fromhex("3e02320080" "3c3200a0"))

    def test_la_sram_se_pone_con_el_bit_4(self):
        """p00:4033: `ld a,0x10 / ld (0xA000),a` antes de llamar al banco 4."""
        self.assertEqual(self.lee(0, 0x402E, 10), bytes.fromhex("3e04320080" "3e103200a0"))

    def test_los_despachadores(self):
        """Cada banco de codigo lleva el suyo: pop hl / add a,a / hl+=a /
        ld e,(hl) / inc hl / ld d,(hl) / ex de,hl / jp (hl)."""
        from bancos import DESPACHADORES
        for b, d in DESPACHADORES:
            trozo = self.lee(b, d, 12)
            self.assertEqual(trozo[:2], bytes([0xE1, 0x87]), "p%02d:%04X" % (b, d))
            self.assertIn(bytes([0x5E, 0x23, 0x56, 0xEB, 0xE9]), trozo, "p%02d:%04X" % (b, d))

    def test_reubica_sale_de_su_ldir(self):
        """Cada trozo de src/reubica.txt: el LDIR que cita copia ese origen, a
        ese destino y esa longitud (ld hl / ld de / ld bc delante)."""
        import re
        n = 0
        with open(os.path.join(RAIZ, "src", "reubica.txt"), encoding="utf-8") as f:
            filas = f.read().splitlines()
        for ln in filas:
            m = re.match(r"p(\d\d) (0x\w+) (0x\w+) (0x\w+)\s+# p(\d\d):(\w{4}) ldir", ln)
            if not m:
                continue
            b, ini, fin, ejec = int(m.group(1)), int(m.group(2), 0), int(m.group(3), 0), int(m.group(4), 0)
            bl, pc = int(m.group(5)), int(m.group(6), 16)
            antes = self.lee(bl, pc - 9, 11)
            self.assertEqual(antes[-2:], bytes([0xED, 0xB0]), ln)
            regs = {antes[i]: antes[i + 1] | (antes[i + 2] << 8) for i in (0, 3, 6)}
            self.assertEqual(regs.get(0x21), ini, ln)
            self.assertEqual(regs.get(0x11), ejec, ln)
            self.assertEqual(regs.get(0x01), fin - ini, ln)
            n += 1
        self.assertEqual(n, 18)

    def test_calslt_con_ix(self):
        """Las semillas por CALSLT: `ld ix,nnnn` y CALSLT (0x001C) detras."""
        for b, pc, ix, salto in ((0, 0x41A8, 0x4020, 4), (3, 0xA5BE, 0x409D, 8),
                                 (1, 0x640E, 0x651F, 4), (1, 0x642C, 0x6789, 4),
                                 (1, 0x64C7, 0x64DC, 8)):
            t = self.lee(b, pc, salto + 3)
            self.assertEqual(t[:4], bytes([0xDD, 0x21, ix & 0xFF, ix >> 8]))
            self.assertIn(t[salto], (0xCD, 0xC3))
            self.assertEqual(t[salto + 1:salto + 3], bytes([0x1C, 0x00]))


if __name__ == "__main__":
    unittest.main()
