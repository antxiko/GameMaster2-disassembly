# Hallazgos

## Entra también en los cartuchos de MSX2

Para colarse en el juego busca en su arranque la dirección de un gancho de
interrupción: primero H.TIMI, la de los seis cartuchos de MSX2 de Konami, y
luego H.KEYI, la de los de MSX1 (`p00:588C`). El Game Master 1 solo buscaba la
segunda. Comprobado con las ROM: los seis de MSX2 escriben en H.TIMI y ninguno
en H.KEYI.

## Seis firmas nuevas

La tabla de firmas (`p00:44BE`) es la del Game Master 1 más cinco de Vampire
Killer y una de Hinotori: 68 para 30 juegos.

## Una máquina no japonesa ve la presentación de MSX1

Si el juego de caracteres de la BIOS no es el japonés, el cartucho se olvida
de que es un MSX2 y pone la presentación de MSX1 sin el rótulo
(`p09:8024`).

## En MSX1 llama a una rutina que solo existe en MSX2

Para borrar la VRAM usa BIGFIL (`0x016B`) también en MSX1, donde esa entrada
de la BIOS no existe (en la C-BIOS son ceros hasta `0x0200`): la VRAM no se
borra entera. No se ve porque los restos caen en letras que la pantalla no usa.
Cotejado con openMSX: en el menú SELF quedan 8.322 bytes distintos en las
tablas y ningún punto distinto en la pantalla.

## Cinco pistas para tres voces

El motor de Tennis and Hockey lleva tres pistas de música y dos de efectos; un
efecto se queda la voz C o la B del PSG si su prioridad no es menor que la de
la música, y se la devuelve al acabar (`p08:A291`).

## El tenis sin iguales

Del 40 se pasa a juego con el siguiente tanto, gane quien gane antes
(`p07:9290`), y el set se cierra a 6 juegos sin necesidad de dos de ventaja.

## Las curvas del biorritmo se encienden

En MSX2 los colores de las curvas suben un poco cada día de la animación
hasta quedar en amarillo, cian y magenta (`p06:A2B7`).

## Una G dentro de la M

El rótulo «GAME MASTER II» de las máquinas no japonesas reutiliza letras entre
palabras (`p09:8D99`). En la columna de en medio de la M de MASTER, abajo
(`p09:8DD5`), pone la letra 0x21, que es la esquina de la G, donde la M de GAME
lleva la 0x26: por eso esa M sale con un trozo raro. openMSX la pinta igual.
