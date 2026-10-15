# Konami's Game Master 2 (RC-755)

El *Konami's Game Master 2* (1987), en Japón *Konami no Shin 10-bai
Cartridge*, es un cartucho de trucos para MSX. Se enchufa junto a un juego de
Konami, lo reconoce y deja cambiar la fase y las vidas, guardar pantallas y
partidas en disco o en su propia SRAM y llevar un ranking. Solo, sin juego al
lado, trae su propio menú: la utilidad de la SRAM, un minijuego de tenis y
hockey y un biorritmo.

![El rótulo de la presentación](../imagenes/presentacion_japonesa.png)

Aquí está su código entero: los 131.072 bytes, en 16 bancos de 8 KB, se
vuelven a montar byte a byte, y el 40 % de las instrucciones va comentado.

## Qué hay en esta web

- [El cartucho](EL-CARTUCHO.html): los bancos, cómo se cuela en el juego, la
  tabla de 30 juegos, los trucos, la SRAM y el disco.
- [Las pantallas](LAS-PANTALLAS.html): 24 pantallas dibujadas desde la ROM,
  en MSX1 y en MSX2.
- [Tennis and Hockey](TENNIS-Y-HOCKEY.html): el minijuego, sus reglas y sus
  opciones.
- [El biorritmo](EL-BIORRITMO.html): cómo cuenta los días y cómo dibuja las
  curvas.
- [La música](LA-MUSICA.html): las nueve piezas, sacadas de su propio motor.
- [Los textos](LOS-TEXTOS.html): todo lo que escribe en pantalla.
- [El código](EL-CODIGO.html): cómo está hecho el desensamblado y cómo se
  vuelve a montar.
- [Hallazgos](HALLAZGOS.html) y [Preguntas abiertas](PREGUNTAS-ABIERTAS.html).

## Aquí no hay capturas

Todas las imágenes están dibujadas con código propio leyendo las tablas del
cartucho, y cada una se ha comparado byte a byte con el cartucho ejecutado o
con la VRAM de openMSX: coinciden enteras. Las de MSX1 llevan la fuente de la
BIOS de la C-BIOS japonesa, la máquina con la que se coteja; en otra máquina
cambiarían las letras de la BIOS.

## Montarlo

Hace falta la imagen del cartucho, que no se distribuye: `gamemaster2.rom`,
el volcado GoodMSX (sha1 `5c00f9e3...`, 131.072 bytes), en la raíz.
`make verify` vuelve a montar los 16 bancos y comprueba que salen idénticos.
