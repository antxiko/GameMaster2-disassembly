# Konami's Game Master 2 (RC-755) — desensamblado comentado

*(Also available [in English](README.md).)*

**[→ Leerlo en la web](https://antxiko.github.io/GameMaster2-disassembly/es/)**

Desensamblado completo y comentado de Konami's Game Master 2 para MSX (1987),
en Japón *Konami no Shin 10-bai Cartridge*: RC-755, 128 KB con SRAM.

Es el **cartucho de trucos** de Konami: se enchufa junto a un juego, lo
reconoce, se cuela en su interrupción y deja cambiar fase y vidas, guardar
pantallas y partidas en disco o en su SRAM y llevar un ranking. Solo, trae su
propio menú: la utilidad de la SRAM, un Tennis and Hockey para dos y un
biorritmo.

| | |
|---|---|
| binario explicado | **100 %**, 131.072 de 131.072 bytes |
| código trazado | 36.633 bytes |
| datos identificados | 94.439 bytes |
| rutinas | 2.338, **ninguna floja** |
| densidad de comentario | **40,1 %** |
| juegos que reconoce | 30 (68 firmas) |
| pantallas dibujadas | 24, cotejadas a 0 |
| músicas | 9, cotejadas con openMSX |
| tests | 14 |

## Cómo se cuela

Busca en los 256 primeros bytes del arranque del juego la dirección de un
gancho de interrupción: primero H.TIMI (la de los cartuchos de MSX2 de Konami) y
luego H.KEYI (la de los de MSX1). Así entra también en Vampire Killer y en
Hinotori, cosa que el Game Master 1 no hacía.

## Reproducirlo

El cartucho no se distribuye. Pon tu copia en la raíz como `gamemaster2.rom`
(sha256 `2054636a6ca2…`) y:

    make verify    # reensambla los 16 bancos y los compara byte a byte
    make sanity    # comprueba el trazado
    make web       # genera la web

## Las imágenes y la música

Ninguna imagen es una captura: se dibujan leyendo las tablas del cartucho y
están cotejadas byte a byte contra el cartucho ejecutado o contra la VRAM de
openMSX. Las músicas salen de ejecutar su propio motor de sonido y coinciden
con openMSX cuadro a cuadro.

Ver [AVISO-LEGAL.md](AVISO-LEGAL.md) y [LICENSE](LICENSE).
