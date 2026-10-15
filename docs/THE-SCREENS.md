# The screens

All 24 are drawn with our own code (`tools/pantallas.py` for MSX1,
`tools/pantallas2.py` for MSX2) following the steps of the routine that paints
them, quoted with each one. None is a capture. Each is compared byte for byte
(`tools/coteja.py`, `tools/coteja2.py`) with the cartridge running on a Python
Z80 or with the openMSX VRAM, and they all match completely. On MSX1 the BIOS
letters are those of the Japanese C-BIOS.

## The title sequence

![The Konami logo](imagenes/logo_konami.png)

The Konami logo (`p09:8135`), at the end of its animation: one line per frame,
six rows of 21 characters.

![The title](imagenes/presentacion_japonesa.png)

The "Konami no Shin 10-bai Cartridge" title, waiting for space (`p09:8846`).
It only appears with a Japanese BIOS.

![The main menu](imagenes/menu_principal.png)

The main menu (`p09:82CA`): GAME, MODIFY and SELF. GAME and MODIFY need a game
next to it.

![The menu on a non-Japanese machine](imagenes/menu_principal_internacional.png)

With a non-Japanese BIOS there is no title, and the menu carries "GAME MASTER
II" and the date (`p09:8D27`).

## The cartridge on its own

![The SELF menu](imagenes/menu_self.png)

The SELF MODE MENU (`p00:5DEE`), with the 16 colour squares above and below.

![SRAM DISK UTILITY](imagenes/sram_utilidad.png)

SRAM DISK UTILITY (`p01:7973`), with the BIOS font.

![DIRECTORY](imagenes/sram_directorio.png)
![FORMAT](imagenes/sram_formatear.png)
![FORMAT COMPLETED](imagenes/sram_formateada.png)
![FILE DELETE](imagenes/sram_borrar.png)

DIRECTORY with the SRAM unformatted (`p00:417D`), the FORMAT question
(`p00:4333`), its result and FILE DELETE asking for the name (`p00:4209`).

## Tennis and Hockey

![GAME SELECT](imagenes/tenis_menu.png)
![GAME MODIFY](imagenes/tenis_modify.png)

GAME SELECT (`p07:909A`) and GAME MODIFY (`p07:9100`); the red boxes are
sprites.

![1ST SET START](imagenes/tenis_set.png)
![The tennis court](imagenes/tenis_pista.png)

"1ST SET START" (`p07:8141`) and the tennis court ready to serve
(`p07:81A2`).

![START](imagenes/hockey_start.png)
![The hockey rink](imagenes/hockey_pista.png)

The same for hockey, with the clock at 90.

## The biorhythm

![The dates](imagenes/bio_entrada.png)
![The chart](imagenes/bio_grafica.png)

On MSX1, asking for the dates (`p05:9674`) and the chart with the example
dates 1970-01-01 and 1988-01-01.

## On MSX2

![The logo on MSX2](imagenes/logo_konami_msx2.png)
![The title on MSX2](imagenes/rotulo_msx2.png)
![The menu on MSX2](imagenes/menu_msx2.png)
![The SELF menu on MSX2](imagenes/menu_self_msx2.png)
![The dates on MSX2](imagenes/bio_entrada_msx2.png)
![The chart on MSX2](imagenes/bio_grafica_msx2.png)

On an MSX2 with a Japanese BIOS the title sequence is different: SCREEN 5,
with the pictures put together with VDP commands (`p09:80DC`, `p09:8B20`,
`p09:8692`). The SELF menu is the same with the MSX2 palette, and the
biorhythm changes completely (`p05:8D22`, `p06:A006`).
