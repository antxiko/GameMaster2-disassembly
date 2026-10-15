# El biorritmo

Bancos 5 y 6. Pide dos fechas, la de nacimiento y la del día que se quiere
mirar, y dibuja los tres ciclos clásicos: físico (23 días), sensibilidad (28)
e intelecto (33).

![La gráfica en MSX](../imagenes/bio_grafica.png)

## La cuenta

Cada fecha se pasa a días con el calendario gregoriano (`p05:8E34`): el año
por 365, más los bisiestos ((año-1)/4 - (año-1)/100 + (año-1)/400), más los
días hasta el mes (`p05:959E`) y uno más desde marzo en año bisiesto. La resta
son los días vividos; su resto entre 23, 28 y 33 se pasa a grados
(resto x 360 / ciclo, `p05:8FFB`) y se retrasa 15 días (235, 193 y 164 grados,
`p05:9043`) para que la gráfica empiece antes de hoy.

La altura de cada punto sale de una tabla de seno de 0 a 90 grados
(`p05:94E8`, `p05:932F`). Cada columna avanza 4, 3 y 2 grados, con una
corrección cada 4, 6 y 20 columnas para que cada día valga lo que debe
(`p05:9179`). Son 192 columnas: de 15 días antes a 30 después.

El nivel de hoy sale de la altura: WORST, BAD, CAUTION, NORMAL o GOOD
(`p05:9DA5`).

## En MSX

La pantalla es SCREEN 2, pero las filas 10 a 23 llevan una letra distinta en
cada casilla: un lienzo donde cada punto se pinta en el dibujo de su letra
(`p05:90DF`). Las letras S, P, I de la izquierda dicen en qué orden empiezan
las curvas (`p06:A33D`).

## En MSX2

![La gráfica en MSX2](../imagenes/bio_grafica_msx2.png)

SCREEN 5 con cajas con sombra hechas con comandos del VDP, letras copiadas de
una hoja en la página 1 y las curvas en color: en cada columna, una línea de
dos puntos por ciclo (`p05:9249`). Los colores de las tres curvas se encienden
poco a poco mientras se mira la gráfica hasta quedar en amarillo, cian y
magenta (`p06:A2B7`).

Las fechas de las imágenes son de ejemplo: 1970-01-01 y 1988-01-01.
