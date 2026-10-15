# El cartucho

## Los bancos

128 KB en 16 bancos de 8 KB, con el mapper propio del Game Master 2. El banco 0
está fijo en `0x4000`; los demás se ponen escribiendo su número en `0x6000`,
`0x8000` o `0xA000`. Un valor con el bit 4 en `0xA000` pone la SRAM en su
lugar: dos mitades de 4 KB. Los bancos 12 a 15 están vacíos (`0xFF`).

| bancos | qué hay |
|---|---|
| p00-p01 | el menú del cartucho solo (su RAM, en `0xF2xx` y en la página 2) |
| p02-p03 | la copia que corre con el juego al lado (su RAM, en `0xD1xx`-`0xD3xx`) |
| p04 | el sistema de ficheros de la SRAM |
| p05-p06 | el biorritmo, en MSX y en MSX2 |
| p07-p08 | Tennis and Hockey y su motor de sonido |
| p09 | la presentación y la biblioteca del VDP |
| p10-p11 | dibujos |

## Cómo se cuela en el juego

Al encender busca un cartucho de Konami en las otras ranuras y lee los 256
primeros bytes de su arranque buscando la dirección de un gancho de
interrupción (`p00:5878`): primero la de H.TIMI (`9F FD`), donde se cuelgan los
seis cartuchos de MSX2 de Konami, y luego la de H.KEYI (`9A FD`), la de los de
MSX (`p00:588C`). El Game Master 1 solo buscaba la segunda: por eso este
entra también en Vampire Killer y en Hinotori.

Si al encender se mantiene pulsado el espacio o GRAPH, el cartucho no arranca.

## La tabla de juegos

Para saber qué juego tiene al lado, lee la segunda cabecera de `0x4010` si el
juego la trae (`AB`, `CD` o `EF` y su número de catálogo). Si no, suma los 256
bytes de `0x5000`-`0x50FF` y busca esa suma en la tabla de `p00:44BE`: 68
firmas que apuntan a 31 fichas para 30 juegos. Cada ficha empieza por el número
de catálogo en BCD (`07 01` es RC-701) y sigue con las direcciones de las
variables del juego.

Son las 62 firmas del Game Master 1 más seis nuevas: cinco de Vampire Killer
(RC-744) y una de Hinotori (RC-747). 35 están comprobadas sumando las ROM de
verdad, y cada uno de los 30 juegos tiene al menos una.

## Los trucos

MODIFY STAGE NUMBER y MODIFY PLAYER NUMBER pasan por dos tablas de entradas de
tres bytes, número de catálogo y rutina: las vidas (`p01:6CA6`, 16 juegos) y la
fase (`p01:6CD7`, 21 juegos). La rutina de vidas de casi todos (`p01:6D27`)
escribe las vidas pedidas (`0xF299`) en la variable que dice la ficha del
juego (`0xF288`); la de fase hace su cuenta para cada juego: la fase pedida
entre el número de fases, en BCD, o repartida en varias variables.

| RC | juego | vidas | fase |
|---|---|---|---|
| RC-700 | Athletic Land | `p01:6D27` | `p01:6DD8` |
| RC-701 | Antarctic Adventure | - | `p01:6DFD` |
| RC-702 | Monkey Academy | `p01:6D27` | - |
| RC-703 | Time Pilot | `p01:6D27` | - |
| RC-704 | Frogger | `p01:6D27` | - |
| RC-705 | Super Cobra | `p01:6D27` | - |
| RC-706 | Konami's Billiards | `p01:6D27` | - |
| RC-710 | Hyper Olympic 1 | - | `p01:6E38` |
| RC-711 | Hyper Olympic 2 | - | `p01:6E38` |
| RC-712 | Circus Charlie | `p01:6D27` | `p01:6E81` |
| RC-713 | Magical Tree | `p01:6D27` | `p01:6E97` |
| RC-714 | Comic Bakery | `p01:6D27` | `p01:6EE9` |
| RC-715 | Hyper Sports 1 | - | `p01:6EEC` |
| RC-716 | Cabbage Patch Kids | `p01:6D27` | `p01:6DD8` |
| RC-717 | Hyper Sports 2 | - | `p01:6EF3` |
| RC-718 | Hyper Rally | - | `p01:6EFF` |
| RC-721 | Sky Jaguar | `p01:6D27` | `p01:6F37` |
| RC-725 | Yie Ar Kung-Fu | `p01:6D17` | `p01:6F48` |
| RC-727 | King's Valley | `p01:6D27` | `p01:6F78` |
| RC-728 | Mopi Ranger | `p01:6D34` | `p01:6FC9` |
| RC-729 | Pippols | `p01:6D2F` | `p01:6FE4` |
| RC-730 | Road Fighter | - | `p01:6FF7` |
| RC-732 | Konami's Soccer / Football | - | `p01:7016` |
| RC-733 | Hyper Sports 3 | - | `p01:701F` |
| RC-736 | Konami's Boxing | - | `p01:7028` |
| RC-737 | Yie Ar Kung-Fu II | `p01:6D2F` | `p01:704E` |

## La SRAM

*Leído en el código, sin ejecutar.* El banco 4 lleva un sistema de ficheros
para la SRAM: un directorio en `0xB000` (64 entradas de 8 bytes), la tabla de
bloques en `0xB200`, nombres de 5 letras que admiten los comodines `*` y `?` y
un CRC-16 (`0xA001`) por cada bloque de 128 bytes. Todas las órdenes pasan por
una sola puerta: `p00:4020` pone la SRAM y salta a `p04:8000` con el número de
orden en C (5 es el directorio; 0x0C y 0x0D, borrar y marcar como formateada).
Desde el menú SELF se llega con SRAM DISK UTILITY: DIRECTORY, FILE DELETE y
FORMAT.

## El disco

LOAD SCREEN DATA y las grabaciones de pantallas, partidas y ranking necesitan
disco: sin él (`p00:5F1A` mira si el gancho H.PHYD es un `ret`), el cartucho
vuelve al menú.
