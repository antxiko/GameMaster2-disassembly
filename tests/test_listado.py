#!/usr/bin/env python3
"""Lo que se afirma del listado.

Necesita los trazados de work/ (los hace `make trace`, que a su vez necesita
la ROM); sin ellos falla diciendo que falta, no se salta.
"""
import os
import subprocess
import sys
import unittest

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
TOOLS = os.path.join(RAIZ, "tools")
sys.path.insert(0, TOOLS)


class Listado(unittest.TestCase):

    def test_el_makefile_y_paginas_py_dicen_lo_mismo(self):
        from paginas import ORG
        mk = open(os.path.join(RAIZ, "Makefile"), encoding="utf-8").read()
        for p, o in ORG.items():
            self.assertIn("ORG_%02d = %#06x" % (p, o), mk)

    def test_los_dos_trazados_coinciden(self):
        """tools/check_bancos.py: el de cartucho entero y el de cada banco."""
        if not os.path.exists(os.path.join(RAIZ, "work", "p00.trace.json")):
            raise AssertionError("faltan los trazados de work/: haz `make trace`")
        r = subprocess.run([sys.executable, os.path.join(TOOLS, "check_bancos.py"),
                            os.path.join(RAIZ, "gamemaster2.rom"),
                            os.path.join(RAIZ, "work"), os.path.join(RAIZ, "src")],
                           capture_output=True, text=True, cwd=TOOLS)
        self.assertIn("OK: los dos trazados", r.stdout)


if __name__ == "__main__":
    unittest.main()
