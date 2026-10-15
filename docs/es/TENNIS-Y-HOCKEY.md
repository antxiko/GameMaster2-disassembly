# Tennis and Hockey

Un Pong para dos personas (bancos 7 y 8): no hay rival de la máquina. Todo
corre dentro de la interrupción (`p07:8004`).

![La pista de tenis](../imagenes/tenis_pista.png)

## Los mandos

| jugador | lado | mando | teclado |
|---|---|---|---|
| 1 | derecha | puerto 1 | flechas, espacio (A), SELECT (B) |
| 2 | izquierda | puerto 2 | E S F C, SHIFT (A), CTRL (B) |

CTRL y C a la vez vuelven al principio (`p07:806E`).

## GAME MODIFY

| opción | valores | qué hace |
|---|---|---|
| LENGTH | 1-4 | el largo de la raqueta (`p07:8A0A`) |
| SPEED | 1-5 | la velocidad (`p07:8D4C`) |
| TYPE | A, B, C | con B o C cada jugador tiene una segunda raqueta: B en su campo, C en el contrario (`p07:8A25`) |
| BAR | N, Y | una barra que sube y baja en el centro (`p07:8C4D`) |

## El tenis

Cuenta 15, 30, 40 y juego, **sin iguales ni ventaja** (`p07:9277`). El set es a
6 juegos sin necesidad de dos de diferencia y el partido a dos sets. El saque
cambia en cada juego.

## El hockey

![La pista de hockey](../imagenes/hockey_pista.png)

Gana quien más goles mete (el marcador llega a 99). El reloj empieza en 90 y
baja uno cada 64 cuadros (`p07:931A`); a los 10 suena un aviso y hay un
descanso, HALF TIME (`p07:8367`). Al acabar, gana el que va por delante o sale
DRAW.

Al final del partido parpadea 1P WIN, 2P WIN o DRAW (`p07:831B`).

*Leído en el código.* La música de cada momento está en [La música](LA-MUSICA.html).
