; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 07 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x8094  (148 bytes)
; ======================================================================


th_arranca:		; Tennis and Hockey: engancha H.KEYI (p07:8004) y prepara la pantalla
	di			;8000
	jp L_803A		;8001
L_8004:
	call 0013eh		;8004   ; BIOS RDVDP - Reads VDP status register
	di			;8007
	call sonido_cuadro		;8008   ; sonido_cuadro: el motor de sonido: un cuadro de los cinco canales
	ld hl,0e404h		;800b   ; apunta a el cuadro esta en marcha
	bit 0,(hl)		;800e
	jr nz,L_801F		;8010
	inc (hl)			;8012
	ei			;8013
	call th_lee_mandos		;8014   ; th_lee_mandos: lee los dos mandos y el teclado (0xE405-0xE408)
	call th_sale_con_teclas		;8017   ; th_sale_con_teclas: si se pulsan a la vez las teclas de salida (SNSMAT 6 y 3), acaba el juego
	ld a,000h		;801a
	ld (0e404h),a		;801c   ; guarda el cuadro esta en marcha
L_801F:
	call 0013eh		;801f   ; BIOS RDVDP - Reads VDP status register
	ei			;8022
	ret			;8023
hl_mas_a:		; HL = HL + A (gemela de p01:7251)
	add a,l			;8024
	ld l,a			;8025
	ret nc			;8026
	inc h			;8027
	ret			;8028
de_mas_a:		; DE = DE + A (gemela de p01:7256)
	add a,e			;8029
	ld e,a			;802a
	ret nc			;802b
	inc d			;802c
	ret			;802d
despacha:		; salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)
	pop hl			;802e   ; la direccion de la tabla, que va pegada al `call`
	add a,a			;802f   ; A x 2: cada destino es una palabra
	add a,l			;8030
	ld l,a			;8031
	jr nc,L_8035		;8032
	inc h			;8034
L_8035:
	ld e,(hl)			;8035
	inc hl			;8036
	ld d,(hl)			;8037
	ex de,hl			;8038
	jp (hl)			;8039
L_803A:
	ld a,0c3h		;803a
	ld (0fd9ah),a		;803c   ; guarda el gancho H.KEYI
	ld hl,L_8004		;803f
	ld (0fd9bh),hl		;8042   ; guarda la direccion del gancho H.KEYI y el byte siguiente (16 bits)
	ld hl,0e200h		;8045   ; apunta a los canales del motor de sonido (0x2C bytes cada uno)
	ld de,0e201h		;8048
	ld bc,006ffh		;804b
	ld (hl),000h		;804e
	ldir		;8050
	ld a,001h		;8052
	ld (0e404h),a		;8054   ; guarda el cuadro esta en marcha
	call th_inicia		;8057   ; th_inicia: silencio, sonido 1, borra la VRAM y pone los 8 registros del VDP
	xor a			;805a
	ld (0e404h),a		;805b   ; guarda el cuadro esta en marcha
	call 0013eh		;805e   ; BIOS RDVDP - Reads VDP status register
	ei			;8061
L_8062:
	ld a,(0e40eh)		;8062
	and a			;8065
	jr z,L_8062		;8066
	ld a,0c9h		;8068
	ld (0fd9ah),a		;806a   ; guarda el gancho H.KEYI
	ret			;806d
th_sale_con_teclas:		; si se pulsan a la vez las teclas de salida (SNSMAT 6 y 3), acaba el juego
	ld a,006h		;806e
	call 00141h		;8070   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;8073
	jr nz,L_8088		;8075
	ld a,003h		;8077
	call 00141h		;8079   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;807c
	jr c,L_8088		;807d
	ld hl,00100h		;807f
	ld (0e400h),hl		;8082
	jp L_80DB		;8085
L_8088:
	ld hl,0e402h		;8088
	inc (hl)			;808b
	ld bc,(0e400h)		;808c
	ld a,c			;8090
	call despacha		;8091   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8094: tabla de 8 palabras del despachador (call 0x408D en
;   0x8091); lo leen el despachador (16 bytes)
;   0x8094..0x80a4  (16 bytes)
DATA_saltos_8094:
	defb 0a4h,080h	; 8094
	defb 0f1h,080h	; 8096
	defb 033h,081h	; 8098
	defb 0c6h,081h	; 809a
	defb 0e4h,081h	; 809c
	defb 039h,082h	; 809e
	defb 039h,083h	; 80a0
	defb 067h,083h	; 80a2

; ======================================================================
; CODIGO 0x80a4..0x8139  (149 bytes)
; ======================================================================


L_80A4:
	dec b			;80a4
	jr z,L_80C3		;80a5
	dec b			;80a7
	jr z,L_80E3		;80a8
	ld a,00dh		;80aa
	call pide_sonido		;80ac   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_borra_pantalla		;80af   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	call th_fuente		;80b2   ; th_fuente: la fuente del minijuego (p07:885B en 0x2080) y su color
	call th_campo_tenis		;80b5   ; th_campo_tenis: descomprime p07:9386 en 0x2300
	call th_campo_hockey		;80b8   ; th_campo_hockey: descomprime p07:951D en 0x0300
	call th_campo_colores		;80bb   ; th_campo_colores: descomprime p07:9535
	call th_menu_juego		;80be   ; th_menu_juego: GAME SELECT: TENNIS / HOCKEY / END
	jr L_80EC		;80c1
L_80C3:
	call th_elige_juego		;80c3   ; th_elige_juego: mueve la eleccion de juego (0xE412) con el mando
	ld a,(0e405h)		;80c6   ; lee el mando del jugador 1
	and 010h		;80c9
	ret z			;80cb
	ld a,(0e412h)		;80cc   ; lee el juego: 1 tenis, 2 hockey
	cp 003h		;80cf
	jr z,L_80DB		;80d1
	ld a,004h		;80d3
	call pide_sonido		;80d5   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_81BD		;80d8
L_80DB:
	ld a,001h		;80db
	call pide_sonido		;80dd   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_80EC		;80e0
L_80E3:
	ld a,001h		;80e3
	ld (0e40eh),a		;80e5
	ret			;80e8
L_80E9:
	ld (0e403h),a		;80e9
L_80EC:
	ld hl,0e401h		;80ec
	inc (hl)			;80ef
	ret			;80f0
L_80F1:
	dec b			;80f1
	jr z,L_8103		;80f2
	dec b			;80f4
	jr z,L_811E		;80f5
	call th_borra_pantalla		;80f7   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	xor a			;80fa
	ld (0e460h),a		;80fb   ; guarda la opcion elegida del GAME MODIFY
	call th_menu_modify		;80fe   ; th_menu_modify: GAME MODIFY: LENGTH / SPEED / TYPE / BAR
	jr L_80EC		;8101
L_8103:
	call th_cambia_opcion		;8103   ; th_cambia_opcion: cambia la opcion elegida del GAME MODIFY (0xE460)
	ld a,(0e405h)		;8106   ; lee el mando del jugador 1
	and 010h		;8109
	ret z			;810b
	ld a,004h		;810c
	call pide_sonido		;810e   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_aplica_opciones		;8111   ; th_aplica_opciones: copia LENGTH, SPEED, TYPE y BAR (0xE461...) a 0xE413...
	xor a			;8114
	ld (0e40ch),a		;8115
	ld (0e41fh),a		;8118
	jp L_80EC		;811b
L_811E:
	ld a,(0e200h)		;811e   ; lee los canales del motor de sonido (0x2C bytes cada uno)
	and a			;8121
	ret nz			;8122
	ld a,(0e412h)		;8123   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8126
	ld a,00bh		;8127
	jr z,L_812D		;8129
	ld a,00ch		;812b
L_812D:
	call pide_sonido		;812d   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_81BD		;8130
L_8133:
	ld a,(0e401h)		;8133
	call despacha		;8136   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8139: tabla de 4 palabras del despachador (call 0x408D en
;   0x8136); lo leen el despachador (8 bytes)
;   0x8139..0x8141  (8 bytes)
DATA_saltos_8139:
	defb 041h,081h	; 8139
	defb 09ah,081h	; 813b
	defb 0a2h,081h	; 813d
	defb 0b2h,081h	; 813f

; ======================================================================
; CODIGO 0x8141..0x8176  (53 bytes)
; ======================================================================


L_8141:
	call th_borra_pantalla		;8141   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	call th_marcador_set		;8144   ; th_marcador_set: pinta el SET y el 1ST/2ND/3RD (tenis: 0xE412 = 1)
	ld a,090h		;8147
	ld (0e419h),a		;8149   ; guarda el tiempo del hockey (BCD)
	ld a,05ah		;814c
	ld (0e403h),a		;814e
	jp L_80EC		;8151
th_marcador_set:		; pinta el SET y el 1ST/2ND/3RD (tenis: 0xE412 = 1)
	ld a,(0e412h)		;8154   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8157   ; solo el tenis
	jr nz,$+39		;8158
	ld de,08186h		;815a   ; el texto de p07:8186 (SET)
	call th_pinta_texto		;815d   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld hl,0e40ch		;8160   ; el set que se juega...
	ld a,(hl)			;8163
	add a,a			;8164   ; ...x 3...
	add a,(hl)			;8165
	ld hl,08176h		;8166   ; ...su texto en la tabla de p07:8176 (1ST, 2ND, 3RD)...
	call hl_mas_a		;8169   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld de,03909h		;816c   ; ...3 letras en 0x3909
	ld bc,00003h		;816f
	call 0005ch		;8172   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ret			;8175

; ----------------------------------------------------------------------
; DATOS resto_8176: lo apuntan con el banco puesto p07:8166 (0x8176); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8166 (9 bytes)
;   0x8176..0x817f  (9 bytes)
DATA_resto_8176:
	defb 011h,033h,034h,012h,02eh,024h,013h,032h,024h	; 8176  .34..$.2$

; ======================================================================
; CODIGO 0x817f..0x8186  (7 bytes)
; ======================================================================


L_817F:
	ld de,08192h		;817f
	call th_pinta_texto		;8182   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ret			;8185

; ----------------------------------------------------------------------
; DATOS resto_8186: lo apuntan con el banco puesto p07:815A (0x8186), p07:817F
;   (0x8192); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:815A, p07:817F (20 bytes)
;   0x8186..0x819a  (20 bytes)
DATA_resto_8186:
	defb 00dh,039h,033h,025h,034h,000h,033h,034h,021h,032h,034h,0ffh,00dh,039h,033h,034h	; 8186  .93%4.34!24..934
	defb 021h,032h,034h,0ffh	; 8196

; ======================================================================
; CODIGO 0x819a..0x827e  (228 bytes)
; ======================================================================


L_819A:
	ld hl,0e403h		;819a
	dec (hl)			;819d
	ret nz			;819e
	jp L_80EC		;819f
L_81A2:
	call th_pinta_marcadores		;81a2   ; th_pinta_marcadores: pinta el marcador entero
	call th_partido		;81a5   ; th_partido: prepara el partido: tenis (p07:95BC) o hockey (p07:987C)
	ld hl,0e40ah		;81a8
	ld (hl),001h		;81ab
	ld a,030h		;81ad
	jp L_80E9		;81af
L_81B2:
	call th_vuelca_sprites		;81b2   ; th_vuelca_sprites: vuelca a la tabla de sprites la copia de 0xE500
	ld hl,0e403h		;81b5
	dec (hl)			;81b8
	ret nz			;81b9
	ld (0e403h),a		;81ba
L_81BD:
	ld hl,0e400h		;81bd
	inc (hl)			;81c0
	xor a			;81c1
	ld (0e401h),a		;81c2
	ret			;81c5
L_81C6:
	call th_cuadro		;81c6   ; th_cuadro: un cuadro del partido: jugadores, pelota, marcador y sprites
	ld a,(0e409h)		;81c9
	and a			;81cc
	jp nz,L_81BD		;81cd
	ld a,(0e40ah)		;81d0
	and a			;81d3
	ret nz			;81d4
	jp L_81BD		;81d5
L_81D8:
	ld a,001h		;81d8
	call pide_sonido		;81da   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ld hl,00000h		;81dd
	ld (0e400h),hl		;81e0
	ret			;81e3
L_81E4:
	call th_esconde_sprites		;81e4   ; esconde los sprites
	ld a,(0e409h)		;81e7   ; 0xE409: alguien hizo un tanto
	and a			;81ea
	call nz,th_tanto		;81eb   ; si: lo suma
	xor a			;81ee   ; ya esta contado
	ld (0e409h),a		;81ef
	ld a,(0e40ah)		;81f2   ; 0xE40A: el partido sigue
	and a			;81f5
	jp z,L_8214		;81f6
	xor a			;81f9   ; sigue: borra el tanto
	ld (0e409h),a		;81fa
	ld hl,0e41fh		;81fd   ; 0xE41F: acaba de terminar un set
	ld a,(hl)			;8200
	ld (hl),000h		;8201
	and a			;8203
	jr z,L_820D		;8204
	ld hl,00006h		;8206   ; si: una espera de 6 cuadros (0xE400)
	ld (0e400h),hl		;8209
	ret			;820c
L_820D:
	ld hl,00202h		;820d
	ld (0e400h),hl		;8210
	ret			;8213
L_8214:
	ld a,(0e412h)		;8214   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8217   ; el tenis no tiene esto
	jp z,L_81BD		;8218
	ld a,(0e41eh)		;821b   ; 0xE41E: ya esta hecho
	and a			;821e
	jp nz,L_81BD		;821f
	inc a			;8222   ; lo apunta
	ld (0e41eh),a		;8223
	ld hl,00007h		;8226   ; y una espera de 7 cuadros (0xE400)
	ld (0e400h),hl		;8229
	ret			;822c
th_esconde_sprites:		; pone 0xE0 en la tabla de sprites (0x3B00)
	ld hl,03b00h		;822d
	ld bc,00080h		;8230
	ld a,0e0h		;8233
	call 00056h		;8235   ; BIOS FILVRM - Fills VRAM with value
	ret			;8238
L_8239:
	ld a,(0e412h)		;8239   ; lee el juego: 1 tenis, 2 hockey
	dec a			;823c   ; el tenis cuenta los tantos en p07:82CC
	jp z,L_82CC		;823d
	dec b			;8240   ; B = quien gano: 1...
	jr z,$+112		;8241
	dec b			;8243   ; ...2...
	jr z,$+126		;8244
	ld hl,0e2f7h		;8246   ; 0xE2F7: se acabo el partido
	ld a,(hl)			;8249
	and a			;824a
	ret z			;824b
	ld (hl),000h		;824c   ; lo apaga
	ld a,011h		;824e   ; la musica 0x11: fin del partido
	call pide_sonido		;8250   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_borra_pantalla		;8253   ; pantalla limpia
	ld de,08294h		;8256   ; el texto de p07:8294 (GAME)...
	call th_pinta_texto		;8259   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld de,0827eh		;825c   ; ...y el de p07:827E
	call th_pinta_texto		;825f   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld hl,03971h		;8262   ; los tantos del jugador 1...
	ld de,0e410h		;8265   ; apunta a los tantos del jugador 1
	call th_pinta_bcd		;8268   ; th_pinta_bcd: pinta el byte BCD de DE en dos cifras grandes
	ld hl,0396dh		;826b   ; ...y los del 2, en cifras grandes
	ld de,0e411h		;826e   ; apunta a los tantos del jugador 2
	call th_pinta_bcd		;8271   ; th_pinta_bcd: pinta el byte BCD de DE en dos cifras grandes
	xor a			;8274   ; 0xE41E y 0xE403 a cero
	ld (0e41eh),a		;8275
	ld (0e403h),a		;8278
	jp L_80EC		;827b   ; y vuelve al menu

; ----------------------------------------------------------------------
; DATOS resto_827E: lo apuntan con el banco puesto p07:825C (0x827E), p07:8256
;   (0x8294), p07:82B9 (0x82A0), p07:82F7 (0x82A0); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p07:825C, p07:8256,
;   p07:82B9, p07:82F7 (51 bytes)
;   0x827e..0x82b1  (51 bytes)
DATA_resto_827E:
	defb 06ah,039h,074h,084h,0feh,074h,039h,072h,084h,0feh,08ah,039h,075h,085h,08ch,0feh	; 827e  j9t..t9r...9u...
	defb 093h,039h,08ch,073h,085h,0ffh,00ch,039h,027h,021h,02dh,025h,000h,033h,025h,034h	; 828e  .9.s...9'!-%.3%4
	defb 0a1h,0ffh,049h,03ah,030h,035h,033h,028h,000h,033h,030h,021h,023h,025h,000h,02bh	; 829e  ..I:053(.30!#%.+
	defb 025h,039h,0ffh	; 82ae

; ======================================================================
; CODIGO 0x82b1..0x8399  (232 bytes)
; ======================================================================


L_82B1:
	call th_texto_saque		;82b1   ; th_texto_saque: pinta el texto del saque segun 0xE41D
	ld a,(0e200h)		;82b4   ; lee los canales del motor de sonido (0x2C bytes cada uno)
	and a			;82b7
	ret nz			;82b8
	ld de,082a0h		;82b9
	call th_pinta_texto		;82bc   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	jp L_80EC		;82bf
L_82C2:
	ld a,008h		;82c2
	call 00141h		;82c4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;82c7
	jr c,th_texto_saque		;82c8
	jr L_8308		;82ca
L_82CC:
	dec b			;82cc   ; B = quien gano: 1...
	jr z,L_82EF		;82cd
	dec b			;82cf   ; ...2...
	jr z,L_8300		;82d0
	ld hl,0e2f7h		;82d2   ; 0xE2F7: se acabo el partido
	ld a,(hl)			;82d5
	and a			;82d6
	ret z			;82d7
	ld (hl),000h		;82d8   ; lo apaga
	ld a,010h		;82da   ; la musica 0x10
	call pide_sonido		;82dc   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_pantalla_campo		;82df   ; el campo...
	call th_pinta_campo		;82e2   ; ...y sus piezas
	xor a			;82e5   ; 0xE41E y 0xE403 a cero
	ld (0e41eh),a		;82e6
	ld (0e403h),a		;82e9
	jp L_80EC		;82ec   ; y vuelve al menu
L_82EF:
	call th_texto_saque		;82ef   ; th_texto_saque: pinta el texto del saque segun 0xE41D
	ld a,(0e200h)		;82f2   ; lee los canales del motor de sonido (0x2C bytes cada uno)
	and a			;82f5
	ret nz			;82f6
	ld de,082a0h		;82f7
	call th_pinta_texto		;82fa   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	jp L_80EC		;82fd
L_8300:
	ld a,008h		;8300
	call 00141h		;8302   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;8305
	jr c,th_texto_saque		;8306
L_8308:
	ld a,001h		;8308
	call pide_sonido		;830a   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	xor a			;830d
	ld (0e41eh),a		;830e
	call th_borra_pantalla		;8311   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	ld hl,00000h		;8314
	ld (0e400h),hl		;8317
	ret			;831a
th_texto_saque:		; pinta el texto del saque segun 0xE41D
	ld a,(0e41dh)		;831b   ; quien saca (0xE41D): 0...
	and a			;831e
	ld de,0881ch		;831f   ; ...el texto de p07:881C
	jr z,L_832D		;8322
	dec a			;8324   ; 1: el de p07:8808
	ld de,08808h		;8325
	jr z,L_832D		;8328
	ld de,08812h		;832a   ; 2: el de p07:8812
L_832D:
	ld hl,0e40dh		;832d
	dec (hl)			;8330
	bit 3,(hl)		;8331
	jp z,th_pinta_texto		;8333   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	jp L_863D		;8336
L_8339:
	dec b			;8339   ; B = quien gano el partido
	jr z,L_8356		;833a
	ld hl,0e2f7h		;833c   ; 0xE2F7: se acabo
	ld a,(hl)			;833f
	and a			;8340
	ret z			;8341
	ld (hl),000h		;8342
	ld a,012h		;8344   ; la musica 0x12
	call pide_sonido		;8346   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_pantalla_campo		;8349   ; el campo...
	call th_pinta_campo		;834c   ; ...y sus piezas
	xor a			;834f   ; 0xE403 a cero
	ld (0e403h),a		;8350
	jp L_80EC		;8353   ; y vuelve al menu
L_8356:
	ld a,(0e200h)		;8356   ; lee los canales del motor de sonido (0x2C bytes cada uno)
	and a			;8359
	ret nz			;835a
	ld a,00bh		;835b
	call pide_sonido		;835d   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ld hl,00002h		;8360
	ld (0e400h),hl		;8363
	ret			;8366
L_8367:
	dec b			;8367
	jr z,L_8388		;8368
	ld hl,0e2f7h		;836a
	ld a,(hl)			;836d
	and a			;836e
	ret z			;836f
	ld (hl),000h		;8370
	ld a,013h		;8372
	call pide_sonido		;8374   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	call th_borra_pantalla		;8377   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	ld de,08399h		;837a
	call th_pinta_texto		;837d   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld a,05ah		;8380
	ld (0e403h),a		;8382
	jp L_80EC		;8385
L_8388:
	ld a,(0e200h)		;8388   ; lee los canales del motor de sonido (0x2C bytes cada uno)
	and a			;838b
	ret nz			;838c
	ld a,00ch		;838d
	call pide_sonido		;838f   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ld hl,00002h		;8392
	ld (0e400h),hl		;8395
	ret			;8398

; ----------------------------------------------------------------------
; DATOS resto_8399: lo apuntan con el banco puesto p07:837A (0x8399); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:837A (12 bytes)
;   0x8399..0x83a5  (12 bytes)
DATA_resto_8399:
	defb 00ch,039h,028h,021h,02ch,026h,000h,034h,029h,02dh,025h,0ffh	; 8399  .9(!,&.4)-%.

; ======================================================================
; CODIGO 0x83a5..0x83c6  (33 bytes)
; ======================================================================


th_pinta_campo:		; pinta las piezas del campo de la tabla de p07:83C6
	ld a,(0e40ch)		;83a5
	add a,a			;83a8
	ld b,a			;83a9
	ld hl,083c6h		;83aa
	ld c,000h		;83ad
L_83AF:
	push bc			;83af   ; la direccion de VRAM de la cifra
	ld e,(hl)			;83b0
	inc hl			;83b1
	ld d,(hl)			;83b2
	inc hl			;83b3
	push hl			;83b4
	ex de,hl			;83b5
	ld a,c			;83b6   ; el set C...
	ld de,0e580h		;83b7   ; ...en la tabla de juegos por set (0xE580)
	call de_mas_a		;83ba   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	call th_cifra_baja		;83bd   ; pinta su cifra
	pop hl			;83c0
	pop bc			;83c1
	inc c			;83c2   ; el set siguiente
	djnz L_83AF		;83c3   ; los B sets
	ret			;83c5

; ----------------------------------------------------------------------
; DATOS resto_83C6: lo apuntan con el banco puesto p07:83AA (0x83C6); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:83AA (12 bytes)
;   0x83c6..0x83d2  (12 bytes)
DATA_resto_83C6:
	defb 06dh,039h,0cdh,039h,071h,039h,0d1h,039h,075h,039h,0d5h,039h	; 83c6  m9.9q9.9u9.9

; ======================================================================
; CODIGO 0x83d2..0x83f5  (35 bytes)
; ======================================================================


th_pantalla_campo:		; borra y pinta el campo (p07:83F5 en 0x38E8)
	call th_borra_pantalla		;83d2   ; th_borra_pantalla: borra los sprites y la tabla de nombres
	ld hl,083f5h		;83d5
	ld de,038e8h		;83d8
	ld bc,00a10h		;83db
L_83DE:
	push bc			;83de   ; una fila de C bytes...
	push hl			;83df
	push de			;83e0
	ld b,000h		;83e1
	call 0005ch		;83e3   ; BIOS LDIRVM - Block transfers to VRAM from memory | ...a la VRAM
	pop de			;83e6
	ld a,020h		;83e7   ; la fila siguiente (32)
	call de_mas_a		;83e9   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	pop hl			;83ec
	pop bc			;83ed
	ld a,c			;83ee   ; el origen avanza C
	call hl_mas_a		;83ef   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	djnz L_83DE		;83f2   ; las B filas
	ret			;83f4

; ----------------------------------------------------------------------
; DATOS resto_83F5: lo apuntan con el banco puesto p07:83D5 (0x83F5); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:83D5 (160 bytes)
;   0x83f5..0x8495  (160 bytes)
DATA_resto_83F5:
	defb 094h,095h,095h,096h,095h,095h,095h,096h,095h,095h,095h,096h,095h,095h,095h,097h	; 83f5  ................
	defb 098h,0a0h,043h,098h,000h,072h,000h,098h,000h,074h,000h,098h,000h,076h,000h,098h	; 8405  ..C..r...t...v..
	defb 098h,040h,0a0h,098h,000h,073h,000h,098h,000h,075h,000h,098h,000h,077h,000h,098h	; 8415  .@...s...u...w..
	defb 099h,095h,095h,09ah,095h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09ch	; 8425  ................
	defb 098h,072h,084h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8435  .r..............
	defb 098h,073h,085h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8445  .s..............
	defb 099h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09bh,095h,095h,095h,09ch	; 8455  ................
	defb 098h,074h,084h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8465  .t..............
	defb 098h,075h,085h,098h,000h,000h,000h,098h,000h,000h,000h,098h,000h,000h,000h,098h	; 8475  .u..............
	defb 09dh,095h,095h,09eh,095h,095h,095h,09eh,095h,095h,095h,09eh,095h,095h,095h,09fh	; 8485  ................

; ======================================================================
; CODIGO 0x8495..0x84c6  (49 bytes)
; ======================================================================


th_borra_sprites:		; pone 0xE0 en la copia de sprites (0xE500) y la vuelca
	ld hl,0e500h		;8495   ; apunta a la copia de la tabla de sprites
	ld de,0e501h		;8498
	ld bc,0002fh		;849b
	ld (hl),0e0h		;849e
	ldir		;84a0
	jp th_vuelca_sprites		;84a2   ; th_vuelca_sprites: vuelca a la tabla de sprites la copia de 0xE500
th_pinta_marcadores:		; pinta el marcador entero
	call th_cabecera		;84a5   ; th_cabecera: la cabecera del marcador: tenis (p07:84C6) o hockey (p07:8506)
	call th_tanteo		;84a8   ; th_tanteo: pinta los dos tanteos (0xE410 y 0xE411)
	call th_tiempo		;84ab   ; th_tiempo: en hockey, pinta el tiempo (0xE419)
	jp L_856F		;84ae
th_cabecera:		; la cabecera del marcador: tenis (p07:84C6) o hockey (p07:8506)
	ld hl,03800h		;84b1
	ld a,(0e412h)		;84b4   ; lee el juego: 1 tenis, 2 hockey
	dec a			;84b7
	ld de,084c6h		;84b8
	jr z,L_84C0		;84bb
	ld de,08506h		;84bd
L_84C0:
	ld bc,00040h		;84c0
	jp th_copia_a_vram		;84c3   ; th_copia_a_vram: LDIRVM de DE a HL

; ----------------------------------------------------------------------
; DATOS resto_84C6: lo apuntan con el banco puesto p07:84B8 (0x84C6), p07:84BD
;   (0x8506); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:84B8, p07:84BD (139 bytes)
;   0x84c6..0x8551  (139 bytes)
DATA_resto_84C6:
	defb 000h,000h,000h,088h,070h,08eh,090h,000h,000h,000h,074h,084h,000h,000h,000h,000h	; 84c6  ....p.....t.....
	defb 000h,072h,084h,000h,000h,000h,000h,088h,070h,08eh,090h,000h,000h,000h,000h,000h	; 84d6  .r......p.......
	defb 000h,000h,000h,089h,0a2h,08fh,091h,08ch,000h,000h,075h,085h,08ch,000h,000h,000h	; 84e6  ..........u.....
	defb 000h,073h,085h,08ch,000h,000h,000h,089h,0a2h,08fh,091h,08ch,000h,000h,000h,000h	; 84f6  .s..............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,074h,084h,000h,000h,000h,000h	; 8506  ..........t.....
	defb 000h,072h,084h,000h,000h,000h,000h,08ah,092h,08eh,090h,000h,000h,000h,000h,000h	; 8516  .r..............
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,075h,085h,08ch,000h,000h,000h	; 8526  ..........u.....
	defb 000h,073h,085h,08ch,000h,000h,000h,08bh,093h,08fh,091h,08ch,000h,000h,000h,000h	; 8536  .s..............
	defb 021h,010h,0e4h,018h,003h,021h,011h,0e4h,086h,027h,077h	; 8546  !....!...'w

; ======================================================================
; CODIGO 0x8551..0x85ad  (92 bytes)
; ======================================================================


th_tanteo:		; pinta los dos tanteos (0xE410 y 0xE411)
	ld hl,03814h		;8551
	ld de,0e410h		;8554   ; apunta a los tantos del jugador 1
	call th_pinta_bcd		;8557   ; th_pinta_bcd: pinta el byte BCD de DE en dos cifras grandes
	ld hl,0380dh		;855a
	ld de,0e411h		;855d   ; apunta a los tantos del jugador 2
	jr th_pinta_bcd		;8560
th_tiempo:		; en hockey, pinta el tiempo (0xE419)
	ld a,(0e412h)		;8562   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8565
	ret z			;8566
	ld hl,0381ch		;8567
	ld de,0e419h		;856a   ; apunta a el tiempo del hockey (BCD)
	jr th_pinta_bcd		;856d
L_856F:
	ld a,(0e412h)		;856f   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8572
	ret nz			;8573
	ld hl,0381ch		;8574
	ld de,0e417h		;8577
	call th_cifra_baja		;857a   ; th_cifra_baja: pinta la cifra baja del BCD de DE
	ld hl,03808h		;857d
	ld de,0e41bh		;8580
	jp th_cifra_baja		;8583   ; th_cifra_baja: pinta la cifra baja del BCD de DE
th_pinta_bcd:		; pinta el byte BCD de DE en dos cifras grandes
	ld a,(de)			;8586
	rra			;8587
	rra			;8588
	rra			;8589
	rra			;858a
	and 00fh		;858b
	push de			;858d
	call th_cifra		;858e   ; th_cifra: pinta la cifra A con las dos letras de p07:85AD
	pop de			;8591
	inc hl			;8592
th_cifra_baja:		; pinta la cifra baja del BCD de DE
	ld a,(de)			;8593
	and 00fh		;8594
th_cifra:		; pinta la cifra A con las dos letras de p07:85AD
	push hl			;8596
	ld de,085adh		;8597
	call palabra_de_tabla		;859a   ; palabra_de_tabla: DE = la palabra A de la tabla de DE
	pop hl			;859d
	ld a,e			;859e
	call 0004dh		;859f   ; BIOS WRTVRM - Writes data in VRAM
	push hl			;85a2
	ld bc,00020h		;85a3
	add hl,bc			;85a6
	ld a,d			;85a7
	call 0004dh		;85a8   ; BIOS WRTVRM - Writes data in VRAM
	pop hl			;85ab
	ret			;85ac

; ----------------------------------------------------------------------
; DATOS resto_85AD: lo apuntan con el banco puesto p07:8597 (0x85AD); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8597 (20 bytes)
;   0x85ad..0x85c1  (20 bytes)
DATA_resto_85AD:
	defb 070h,071h,072h,073h,074h,075h,076h,077h,078h,079h,07ah,07bh,07ch,07dh,07eh,07fh	; 85ad  pqrstuvwxyz{|}~.
	defb 080h,081h,082h,083h	; 85bd

; ======================================================================
; CODIGO 0x85c1..0x86d5  (276 bytes)
; ======================================================================


th_divide:		; desplaza HL y A: la posicion entre 8
	ld a,l			;85c1   ; la posicion en pixeles: L / 8...
	rra			;85c2
	rra			;85c3
	rra			;85c4
	rra			;85c5
	rr h		;85c6   ; ...pasando los bits bajos de H...
	rra			;85c8
	rr h		;85c9
	rra			;85cb
	rr h		;85cc
	ld l,h			;85ce   ; ...L = la columna
	and 003h		;85cf   ; la fila...
	add a,0e6h		;85d1   ; ...en la tabla de nombres (0x3800 = 0xE6 + 0x52...)
	ld h,a			;85d3
	ret			;85d4
th_borra_pantalla:		; borra los sprites y la tabla de nombres
	call th_borra_sprites		;85d5   ; th_borra_sprites: pone 0xE0 en la copia de sprites (0xE500) y la vuelca
	ld hl,03800h		;85d8
	ld bc,00300h		;85db
	xor a			;85de
	jp 00056h		;85df   ; BIOS FILVRM - Fills VRAM with value
th_vram_escribe:		; SETWRT en HL y C = el puerto de datos del VDP
	ex af,af'			;85e2
	call 00053h		;85e3   ; BIOS SETWRT - Enables VDP to write
	exx			;85e6
	ld a,(00007h)		;85e7   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;85ea
	exx			;85eb
	ex af,af'			;85ec
	ret			;85ed
th_copia_a_vram:		; LDIRVM de DE a HL
	ex de,hl			;85ee
	jp 0005ch		;85ef   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_85F2:
	exx			;85f2
	ld b,003h		;85f3
L_85F5:
	exx			;85f5   ; B tercios: copia a la VRAM
	push bc			;85f6
	push de			;85f7
	call th_copia_a_vram		;85f8   ; th_copia_a_vram: LDIRVM de DE a HL
	ld de,00800h		;85fb   ; el tercio siguiente esta 0x800 mas alla
	add hl,de			;85fe
	pop de			;85ff
	pop bc			;8600
	exx			;8601
	djnz L_85F5		;8602   ; los B tercios
	ret			;8604
th_rellena_tercios:		; FILVRM en los tres tercios
	ld d,003h		;8605
L_8607:
	push bc			;8607
	push de			;8608
	call 00056h		;8609   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;860c
	add hl,de			;860f
	pop de			;8610
	pop bc			;8611
	dec d			;8612
	jr nz,L_8607		;8613
	ret			;8615
th_descomprime_tercios:		; descomprime DE en los tres tercios
	ld b,003h		;8616
L_8618:
	push bc			;8618
	push de			;8619
	call th_descomprime		;861a   ; th_descomprime: descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba
	ld de,00800h		;861d
	add hl,de			;8620
	pop de			;8621
	pop bc			;8622
	djnz L_8618		;8623
	ret			;8625
th_pinta_texto:		; pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld c,0ffh		;8626
L_8628:
	ex de,hl			;8628   ; HL = la direccion de VRAM que viene en el texto
	ld e,(hl)			;8629
	inc hl			;862a
	ld d,(hl)			;862b
	ex de,hl			;862c
	inc de			;862d
L_862E:
	ld a,(de)			;862e   ; una letra
	inc de			;862f
	ld b,a			;8630   ; 0xFF acaba
	inc b			;8631
	ret z			;8632
	inc b			;8633   ; 0xFE: otra direccion
	jr z,L_8628		;8634
	and c			;8636   ; con la mascara C
	call 0004dh		;8637   ; BIOS WRTVRM - Writes data in VRAM | a la VRAM
	inc hl			;863a   ; la columna siguiente
	jr L_862E		;863b
L_863D:
	ld c,000h		;863d
	jr L_8628		;863f
L_8641:
	ex de,hl			;8641   ; HL = la direccion de VRAM que viene en el bloque
	ld e,(hl)			;8642
	inc hl			;8643
	ld d,(hl)			;8644
	ex de,hl			;8645
	inc de			;8646
th_descomprime:		; descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba
	call th_vram_escribe		;8647   ; th_vram_escribe: SETWRT en HL y C = el puerto de datos del VDP
L_864A:
	ld a,(de)			;864a   ; el byte de cuenta
	and a			;864b
	ret z			;864c   ; 0 acaba
	inc de			;864d
	ld b,a			;864e
	and 07fh		;864f   ; n & 0x7F...
	cp b			;8651   ; ...si es el mismo, bit 7 a 0: repetir
	jr z,L_8662		;8652
	and a			;8654   ; 0x80: otra direccion de VRAM
	jr z,L_8641		;8655
	ld b,a			;8657   ; bit 7 a 1: copiar n bytes
L_8658:
	ld a,(de)			;8658   ; un byte...
	inc de			;8659
	exx			;865a
	out (c),a		;865b   ; ...a la VRAM
	exx			;865d
	djnz L_8658		;865e   ; los n bytes
	jr L_864A		;8660
L_8662:
	ld a,(de)			;8662
	inc de			;8663
L_8664:
	exx			;8664
	out (c),a		;8665
	exx			;8667
	djnz L_8664		;8668
	jr L_864A		;866a
th_vuelca_sprites:		; vuelca a la tabla de sprites la copia de 0xE500
	ld hl,03b00h		;866c
	call 00053h		;866f   ; BIOS SETWRT - Enables VDP to write
	ld a,(00007h)		;8672   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;8675
	ld hl,0e40bh		;8676
	ld a,(hl)			;8679
	add a,068h		;867a
	and 078h		;867c
	ld (hl),a			;867e
	ld e,(hl)			;867f
	ld b,010h		;8680
	ld h,0e5h		;8682
L_8684:
	ld l,e			;8684   ; un sprite de la copia: Y - 1 (el VDP pinta una linea mas abajo)
	ld a,(hl)			;8685   ; Y
	inc hl			;8686
	dec a			;8687
	out (c),a		;8688   ; al VDP
	ld a,(hl)			;868a   ; X
	inc hl			;868b
	out (c),a		;868c   ; al VDP
	ld a,(hl)			;868e   ; el patron
	inc hl			;868f
	out (c),a		;8690   ; al VDP
	ld a,(hl)			;8692   ; el color
	inc hl			;8693
	out (c),a		;8694   ; al VDP
	ld a,(hl)			;8696   ; el segundo sprite: Y - 1
	inc hl			;8697
	dec a			;8698
	out (c),a		;8699   ; al VDP
	ld a,(hl)			;869b   ; X
	inc hl			;869c
	out (c),a		;869d
	ld a,(hl)			;869f   ; el patron
	inc hl			;86a0
	out (c),a		;86a1
	ld a,(hl)			;86a3   ; el color
	inc hl			;86a4
	out (c),a		;86a5
	ld a,e			;86a7   ; la pareja siguiente, 0x48 bytes mas alla (dando la vuelta a 0x78)
	add a,048h		;86a8
	and 078h		;86aa
	ld e,a			;86ac
	djnz L_8684		;86ad   ; las B parejas
	ret			;86af
th_inicia:		; silencio, sonido 1, borra la VRAM y pone los 8 registros del VDP
	ld a,0bfh		;86b0
	call 0a3bdh		;86b2   ; pon_mezclador: escribe A en R#7 del PSG y en 0xE2EE
	ld a,001h		;86b5
	call pide_sonido		;86b7   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ld hl,00000h		;86ba
	ld bc,04000h		;86bd
	xor a			;86c0
	call 00056h		;86c1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,086d5h		;86c4
	ld d,008h		;86c7
	ld c,000h		;86c9
L_86CB:
	ld b,(hl)			;86cb
	call 00047h		;86cc   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;86cf
	inc c			;86d0
	dec d			;86d1
	jr nz,L_86CB		;86d2
	ret			;86d4

; ----------------------------------------------------------------------
; DATOS resto_86D5: lo apuntan con el banco puesto p07:86C4 (0x86D5); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:86C4 (13 bytes)
;   0x86d5..0x86e2  (13 bytes)
DATA_resto_86D5:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e0h,00eh,007h,0c3h,047h,000h	; 86d5  .....v.....G.

; ======================================================================
; CODIGO 0x86e2..0x876e  (140 bytes)
; ======================================================================


th_lee_mandos:		; lee los dos mandos y el teclado (0xE405-0xE408)
	ld e,08fh		;86e2
	call th_lee_puerto		;86e4   ; th_lee_puerto: lee el puerto de mandos E (R#15 del PSG y R#14)
	call th_teclas_1		;86e7   ; th_teclas_1: las teclas del jugador 1 (SNSMAT 7 y 8)
	ld hl,0e406h		;86ea
	call th_recien_pulsado		;86ed   ; th_recien_pulsado: guarda lo pulsado y deja en A lo que se acaba de pulsar
	ld e,0cfh		;86f0
	call th_lee_puerto		;86f2   ; th_lee_puerto: lee el puerto de mandos E (R#15 del PSG y R#14)
	call th_teclas_2		;86f5   ; th_teclas_2: las teclas del jugador 2 (SNSMAT 3...)
	ld hl,0e408h		;86f8
th_recien_pulsado:		; guarda lo pulsado y deja en A lo que se acaba de pulsar
	ld c,(hl)			;86fb   ; lo que habia
	ld (hl),a			;86fc   ; lo que hay ahora
	xor c			;86fd   ; lo que cambio...
	and (hl)			;86fe   ; ...y esta pulsado: lo recien pulsado
	dec hl			;86ff
	ld (hl),a			;8700   ; en el byte anterior
	ret			;8701
th_lee_puerto:		; lee el puerto de mandos E (R#15 del PSG y R#14)
	ld a,00fh		;8702
	call 00093h		;8704   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,00eh		;8707
	di			;8709
	call 00096h		;870a   ; BIOS RDPSG - Reads value from PSG-register
	ei			;870d
	cpl			;870e
	and 03fh		;870f
	ret			;8711
th_teclas_1:		; las teclas del jugador 1 (SNSMAT 7 y 8)
	push af			;8712
	ld a,007h		;8713   ; la fila 7 del teclado...
	call 00141h		;8715   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8718   ; ...a nivel alto
	rrca			;8719   ; ESC al bit 5? (bit 2 de la fila 7, rotado)
	and 020h		;871a
	ld e,a			;871c
	ld a,008h		;871d   ; la fila 8 (espacio y flechas)
	call 00141h		;871f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8722   ; a nivel alto
	rrca			;8723   ; la fila de nuevo...
	rrca			;8724
	ld b,a			;8725   ; B = la fila rotada
	and 004h		;8726   ; el espacio, al bit 2
	or e			;8728
	ld c,a			;8729
	ld a,b			;872a
	rrca			;872b
	rrca			;872c
	ld b,a			;872d
	and 018h		;872e   ; las flechas arriba/abajo, a los bits 3 y 4
	or c			;8730
	ld c,a			;8731
	ld a,b			;8732
	rrca			;8733
	and 003h		;8734   ; izquierda/derecha, a los bits 0 y 1
	or c			;8736
	pop bc			;8737   ; lo que traia el mando...
	or b			;8738   ; junto con lo del mando
	ret			;8739
th_teclas_2:		; las teclas del jugador 2 (SNSMAT 3...)
	push af			;873a   ; guarda lo del mando
	ld a,003h		;873b   ; la fila 3 del teclado
	call 00141h		;873d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8740   ; a nivel alto (1 = pulsada)
	ld c,a			;8741   ; C = la fila
	and 008h		;8742   ; una tecla al bit 3
	ld e,a			;8744   ; E = las teclas juntas
	ld a,c			;8745   ; la fila otra vez
	rrca			;8746   ; otra al bit 0
	rrca			;8747
	and 001h		;8748
	or e			;874a
	ld e,a			;874b   ; E = las teclas juntas
	ld a,c			;874c   ; la fila otra vez
	rlca			;874d   ; otra al bit 1
	and 002h		;874e
	or e			;8750
	ld e,a			;8751   ; E = las teclas juntas
	ld a,005h		;8752   ; la fila 5
	call 00141h		;8754   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8757   ; a nivel alto
	rlca			;8758   ; una tecla al bit 2
	rlca			;8759
	and 004h		;875a
	or e			;875c
	ld e,a			;875d   ; E = las teclas juntas
	ld a,006h		;875e   ; la fila 6
	call 00141h		;8760   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8763   ; a nivel alto
	rlca			;8764   ; dos teclas a los bits 4 y 5
	rlca			;8765
	rlca			;8766
	rlca			;8767
	and 030h		;8768
	or e			;876a
	pop bc			;876b   ; lo que trae el mando
	or b			;876c   ; junto con lo del mando
	ret			;876d

; ----------------------------------------------------------------------
; DATOS resto_876E: lo apuntan con el banco puesto p07:909A (0x876E), p07:9100
;   (0x87A5), p07:8325 (0x8808), p07:832A (0x8812), p07:831F (0x881C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:909A, p07:9100, p07:8325, p07:832A, p07:831F (181 bytes)
;   0x876e..0x8823  (181 bytes)
DATA_resto_876E:
	defb 0ebh,038h,027h,021h,02dh,025h,000h,033h,025h,02ch,025h,023h,034h,0feh,04eh,039h	; 876e  .8'!-%.3%,%#4.N9
	defb 034h,025h,02eh,02eh,029h,033h,0feh,08eh,039h,028h,02fh,023h,02bh,025h,039h,0feh	; 877e  4%..)3..9(/#+%9.
	defb 0ceh,039h,025h,02eh,024h,0feh,029h,03ah,030h,035h,033h,028h,000h,033h,030h,021h	; 878e  .9%.$.):053(.30!
	defb 023h,025h,000h,02bh,025h,039h,0ffh,06bh,038h,027h,021h,02dh,025h,000h,02dh,02fh	; 879e  #%.+%9.k8'!-%.-/
	defb 024h,029h,026h,039h,0feh,0c8h,038h,02ch,025h,02eh,027h,034h,028h,000h,000h,011h	; 87ae  $)&9..8,%.'4(...
	defb 000h,012h,000h,013h,000h,014h,0feh,008h,039h,033h,030h,025h,025h,024h,000h,000h	; 87be  ........930%%$..
	defb 000h,011h,000h,012h,000h,013h,000h,014h,000h,015h,0feh,048h,039h,034h,039h,030h	; 87ce  ...........H9490
	defb 025h,000h,000h,000h,000h,021h,000h,022h,000h,023h,0feh,088h,039h,022h,021h,032h	; 87de  %....!.".#..9"!2
	defb 000h,000h,000h,000h,000h,02eh,000h,039h,0feh,029h,03ah,030h,035h,033h,028h,000h	; 87ee  .......9.):053(.
	defb 033h,030h,021h,023h,025h,000h,02bh,025h,039h,0ffh,0adh,038h,011h,030h,000h,037h	; 87fe  30!#%.+%9..8.0.7
	defb 029h,02eh,0a1h,0ffh,0adh,038h,012h,030h,000h,037h,029h,02eh,0a1h,0ffh,0aeh,038h	; 880e  )....8.0.7)....8
	defb 024h,032h,021h,037h,0ffh	; 881e

; ======================================================================
; CODIGO 0x8823..0x885b  (56 bytes)
; ======================================================================


th_fuente:		; la fuente del minijuego (p07:885B en 0x2080) y su color
	call th_patrones		;8823   ; th_patrones: los patrones del campo
	ld de,0885bh		;8826
	ld hl,02080h		;8829
	call th_descomprime_tercios		;882c   ; th_descomprime_tercios: descomprime DE en los tres tercios
	ld a,0f0h		;882f
	ld hl,00080h		;8831
	ld bc,00158h		;8834
	jp th_rellena_tercios		;8837   ; th_rellena_tercios: FILVRM en los tres tercios
th_patrones:		; los patrones del campo
	ld hl,02000h		;883a
	ld bc,00080h		;883d
	xor a			;8840
	call th_rellena_tercios		;8841   ; th_rellena_tercios: FILVRM en los tres tercios
	ld hl,00000h		;8844
	ld de,00008h		;8847
	ld b,010h		;884a
L_884C:
	push bc			;884c
	ld bc,00008h		;884d
	push hl			;8850
	call th_rellena_tercios		;8851   ; th_rellena_tercios: FILVRM en los tres tercios
	pop hl			;8854
	add hl,de			;8855
	inc a			;8856
	pop bc			;8857
	djnz L_884C		;8858
	ret			;885a

; ----------------------------------------------------------------------
; DATOS resto_885B: lo apuntan con el banco puesto p07:8826 (0x885B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8826 (305 bytes)
;   0x885b..0x898c  (305 bytes)
DATA_resto_885B:
	defb 08bh,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,004h,018h,0cch,07eh	; 885b  ..."ccc"...8...~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 886b  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 887b  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 888b  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 889b  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,000h,00fh,01fh,004h,0ffh,089h,00fh,000h	; 88ab  <B....B<........
	defb 000h,0feh,0e0h,0e0h,0c0h,0c0h,080h,018h,000h,004h,000h,001h,07eh,004h,000h,0c1h	; 88bb  ............~...
	defb 01ch,036h,063h,063h,07fh,063h,063h,000h,07eh,063h,063h,07eh,063h,063h,07eh,000h	; 88cb  .6cc.cc.~cc~cc~.
	defb 03eh,063h,060h,060h,060h,063h,03eh,000h,07ch,066h,063h,063h,063h,066h,07ch,000h	; 88db  >c```c>.|fcccf|.
	defb 07fh,060h,060h,07eh,060h,060h,07fh,000h,07fh,060h,060h,07eh,060h,060h,060h,000h	; 88eb  .``~``...``~```.
	defb 03eh,063h,060h,067h,063h,063h,03fh,000h,063h,063h,063h,07fh,063h,063h,063h,000h	; 88fb  >c`gcc?.ccc.ccc.
	defb 03ch,005h,018h,083h,03ch,000h,01fh,004h,006h,08bh,066h,03ch,000h,063h,066h,06ch	; 890b  <...<.....f<.cfl
	defb 078h,07ch,06eh,067h,000h,006h,060h,093h,07fh,000h,063h,077h,07fh,07fh,06bh,063h	; 891b  x|ng..`...cw..kc
	defb 063h,000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,005h,063h,0a3h,03eh,000h	; 892b  c.cs{.ogc.>.c.>.
	defb 07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h,03dh,000h	; 893b  ~ccc~``.>cccof=.
	defb 07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h,03eh,000h	; 894b  ~ccb|fc.>c`>.c>.
	defb 07eh,006h,018h,001h,000h,006h,063h,082h,03eh,000h,004h,063h,0a3h,036h,01ch,008h	; 895b  ~.....c.>..c.6..
	defb 000h,063h,063h,06bh,06bh,07fh,077h,022h,000h,063h,076h,03ch,01ch,01eh,037h,063h	; 896b  .cckk.w".cv<..7c
	defb 000h,066h,066h,07eh,03ch,018h,018h,018h,000h,07fh,007h,00eh,01ch,038h,070h,07fh	; 897b  .ff~<........8p.
	defb 000h	; 898b

; ======================================================================
; CODIGO 0x898c..0x8a41  (181 bytes)
; ======================================================================


th_partido:		; prepara el partido: tenis (p07:95BC) o hockey (p07:987C)
	call th_borra_sprites		;898c   ; th_borra_sprites: pone 0xE0 en la copia de sprites (0xE500) y la vuelca
	ld hl,03b00h		;898f
	ld de,0e500h		;8992   ; apunta a la copia de la tabla de sprites
	ld bc,00080h		;8995
	call th_copia_a_vram		;8998   ; th_copia_a_vram: LDIRVM de DE a HL
	ld a,(0e412h)		;899b   ; lee el juego: 1 tenis, 2 hockey
	dec a			;899e
	ld hl,095bch		;899f
	jr z,L_89A7		;89a2
	ld hl,0987ch		;89a4
L_89A7:
	ld de,0e640h		;89a7
	ld bc,002c0h		;89aa
	ldir		;89ad
	ld hl,03840h		;89af
	ld de,0e640h		;89b2
	ld bc,002c0h		;89b5
	call th_copia_a_vram		;89b8   ; th_copia_a_vram: LDIRVM de DE a HL
	call th_jugador_1		;89bb   ; th_jugador_1: prepara al jugador 1 (0xE421)
	call th_jugador_2		;89be   ; th_jugador_2: prepara al jugador 2 (0xE431)
	call th_prepara_pelota		;89c1   ; th_prepara_pelota: la pelota al centro (0xE440)
	call th_prepara_barra		;89c4   ; th_prepara_barra: con BAR (0xE416), prepara la barra del centro (0xE450)
	call th_sprites_jugadores		;89c7   ; th_sprites_jugadores: los sprites de los dos jugadores a la copia de 0xE500
	call th_sprite_pelota		;89ca   ; th_sprite_pelota: el sprite de la pelota a la copia de 0xE500
	call th_sprite_barra		;89cd   ; th_sprite_barra: con BAR, los tres sprites de la barra del centro
	jp th_vuelca_sprites		;89d0   ; th_vuelca_sprites: vuelca a la tabla de sprites la copia de 0xE500
th_cuadro:		; un cuadro del partido: jugadores, pelota, marcador y sprites
	call th_vuelca_sprites		;89d3   ; th_vuelca_sprites: vuelca a la tabla de sprites la copia de 0xE500
	ld a,(0e412h)		;89d6   ; lee el juego: 1 tenis, 2 hockey
	dec a			;89d9
	call nz,th_reloj		;89da   ; th_reloj: en hockey, baja el tiempo (0xE419, BCD) cada 64 cuadros
	call th_mueve_jugador_1		;89dd   ; th_mueve_jugador_1: mueve al jugador 1 segun su mando
	call th_mueve_jugador_2		;89e0   ; th_mueve_jugador_2: mueve al jugador 2 segun su mando
	call th_mueve_pelota		;89e3   ; th_mueve_pelota: mueve la pelota y mira los choques
	call th_mueve_barra		;89e6   ; th_mueve_barra: con BAR, sube y baja la barra del centro
	call th_sprites_jugadores		;89e9   ; th_sprites_jugadores: los sprites de los dos jugadores a la copia de 0xE500
	call th_sprite_pelota		;89ec   ; th_sprite_pelota: el sprite de la pelota a la copia de 0xE500
	call th_sprite_barra		;89ef   ; th_sprite_barra: con BAR, los tres sprites de la barra del centro
	call th_gol		;89f2   ; th_gol: mira si la pelota sale por un lado y de quien es el tanto
	ret			;89f5
th_jugador_1:		; prepara al jugador 1 (0xE421)
	ld bc,00008h		;89f6
	ld de,0e421h		;89f9   ; apunta a el jugador 1
	ld hl,08a41h		;89fc
	ld a,(0e412h)		;89ff   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8a02
	jr z,L_8A08		;8a03
	ld hl,08a47h		;8a05
L_8A08:
	ldir		;8a08
	ld a,(0e413h)		;8a0a   ; lee LENGTH, el largo de la raqueta
	ld hl,08a51h		;8a0d
	call hl_mas_a		;8a10   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8a13
	ld (0e422h),a		;8a14
	ld hl,0e427h		;8a17
	ld a,(0e413h)		;8a1a   ; lee LENGTH, el largo de la raqueta
	cp 002h		;8a1d
	ld a,001h		;8a1f
	jr c,L_8A24		;8a21
	inc a			;8a23
L_8A24:
	ld (hl),a			;8a24
	ld a,(0e415h)		;8a25   ; lee TYPE
	or a			;8a28   ; TYPE 0: el color de siempre (p07:8AAF)
	jp z,L_8AAF		;8a29
	dec a			;8a2c   ; TYPE 1-2...
	ld b,a			;8a2d
	ld a,(0e412h)		;8a2e   ; lee el juego: 1 tenis, 2 hockey
	and 002h		;8a31   ; ...+ 2 en el hockey
	add a,b			;8a33
	ld hl,08a4dh		;8a34   ; el color de la raqueta en la tabla de p07:8A4D
	call hl_mas_a		;8a37   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8a3a
	ld de,0e426h		;8a3b   ; al jugador 1 (0xE426)
	ld (de),a			;8a3e
	jr $+112		;8a3f

; ----------------------------------------------------------------------
; DATOS resto_8A41: lo apuntan con el banco puesto p07:89FC (0x8A41), p07:8A05
;   (0x8A47), p07:8A34 (0x8A4D), p07:8A0D (0x8A51), p07:8A6C (0x8A51); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:89FC, p07:8A05, p07:8A34, p07:8A0D, p07:8A6C (20 bytes)
;   0x8a41..0x8a55  (20 bytes)
DATA_resto_8A41:
	defb 000h,000h,0e0h,000h,000h,0ffh,000h,000h,0b8h,000h,000h,0ffh,0a8h,050h,098h,060h	; 8a41  .............P.`
	defb 060h,060h,054h,058h	; 8a51

; ======================================================================
; CODIGO 0x8a55..0x8a9f  (74 bytes)
; ======================================================================


th_jugador_2:		; prepara al jugador 2 (0xE431)
	ld bc,00008h		;8a55
	ld de,0e431h		;8a58   ; apunta a el jugador 2
	ld hl,08a9fh		;8a5b
	ld a,(0e412h)		;8a5e   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8a61
	jr z,L_8A67		;8a62
	ld hl,08aa5h		;8a64
L_8A67:
	ldir		;8a67
	ld a,(0e413h)		;8a69   ; lee LENGTH, el largo de la raqueta
	ld hl,08a51h		;8a6c
	call hl_mas_a		;8a6f   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8a72
	ld (0e432h),a		;8a73
	ld hl,0e437h		;8a76
	ld a,(0e413h)		;8a79   ; lee LENGTH, el largo de la raqueta
	cp 002h		;8a7c
	ld a,001h		;8a7e
	jr c,L_8A83		;8a80
	inc a			;8a82
L_8A83:
	ld (hl),a			;8a83
	ld a,(0e415h)		;8a84   ; lee TYPE
	or a			;8a87   ; TYPE 0: el color de siempre
	jr z,$+60		;8a88
	dec a			;8a8a   ; TYPE 1-2...
	ld b,a			;8a8b
	ld a,(0e412h)		;8a8c   ; lee el juego: 1 tenis, 2 hockey
	and 002h		;8a8f   ; ...+ 2 en el hockey
	add a,b			;8a91
	ld hl,08aabh		;8a92   ; el color de la raqueta en la tabla de p07:8AAB
	call hl_mas_a		;8a95   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8a98
	ld de,0e436h		;8a99   ; al jugador 2 (0xE436)
	ld (de),a			;8a9c
	jr $+39		;8a9d

; ----------------------------------------------------------------------
; DATOS resto_8A9F: lo apuntan con el banco puesto p07:8A5B (0x8A9F), p07:8A64
;   (0x8AA5), p07:8A92 (0x8AAB); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p07:8A5B, p07:8A64, p07:8A92 (16 bytes)
;   0x8a9f..0x8aaf  (16 bytes)
DATA_resto_8A9F:
	defb 000h,000h,010h,000h,000h,0ffh,000h,000h,038h,000h,000h,0ffh,048h,0a0h,058h,090h	; 8a9f  ........8...H.X.

; ======================================================================
; CODIGO 0x8aaf..0x8ad9  (42 bytes)
; ======================================================================


L_8AAF:
	ld a,(0e413h)		;8aaf   ; LENGTH...
	add a,a			;8ab2   ; ...elige dos bytes de la tabla de p07:8AD9...
	ld e,a			;8ab3
	ld d,000h		;8ab4
	ld hl,08ad9h		;8ab6
	add hl,de			;8ab9
	ld a,(hl)			;8aba
	ld de,0e428h		;8abb   ; ...para el jugador 1 (0xE428)
	ld (de),a			;8abe
	inc e			;8abf
	inc hl			;8ac0
	ld a,(hl)			;8ac1
	ld (de),a			;8ac2
	ret			;8ac3
L_8AC4:
	ld a,(0e413h)		;8ac4   ; LENGTH...
	add a,a			;8ac7   ; ...elige dos bytes de la tabla de p07:8AD9...
	ld e,a			;8ac8
	ld d,000h		;8ac9
	ld hl,08ad9h		;8acb
	add hl,de			;8ace
	ld a,(hl)			;8acf
	ld de,0e438h		;8ad0   ; ...para el jugador 2 (0xE438)
	ld (de),a			;8ad3
	inc e			;8ad4
	inc hl			;8ad5
	ld a,(hl)			;8ad6
	ld (de),a			;8ad7
	ret			;8ad8

; ----------------------------------------------------------------------
; DATOS resto_8AD9: lo apuntan con el banco puesto p07:8AB6 (0x8AD9), p07:8ACB
;   (0x8AD9); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:8AB6, p07:8ACB (8 bytes)
;   0x8ad9..0x8ae1  (8 bytes)
DATA_resto_8AD9:
	defb 004h,0ffh,008h,0ffh,00ch,010h,014h,010h	; 8ad9  ........

; ======================================================================
; CODIGO 0x8ae1..0x8aee  (13 bytes)
; ======================================================================


th_mueve_jugador_1:		; mueve al jugador 1 segun su mando
	call th_direccion_1		;8ae1   ; th_direccion_1: la direccion del mando del jugador 1
	ld a,(0e42fh)		;8ae4
	and 003h		;8ae7
	ret z			;8ae9
	dec a			;8aea
	call despacha		;8aeb   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8AEE: tabla de 3 palabras del despachador (call 0x408D en
;   0x8AEB); lo leen el despachador (6 bytes)
;   0x8aee..0x8af4  (6 bytes)
DATA_saltos_8AEE:
	defb 0f4h,08ah	; 8aee
	defb 00eh,08bh	; 8af0
	defb 02bh,08bh	; 8af2

; ======================================================================
; CODIGO 0x8af4..0x8b65  (113 bytes)
; ======================================================================


L_8AF4:
	ld a,(0e413h)		;8af4   ; el largo de la raqueta segun LENGTH (tabla p07:8BCF)
	ld hl,08bcfh		;8af7
	call hl_mas_a		;8afa   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8afd
	ld d,a			;8afe   ; D = el largo
	ld h,d			;8aff   ; la velocidad hacia arriba: -1 linea
	dec h			;8b00
	ld l,000h		;8b01
	ld a,(0e422h)		;8b03   ; la raqueta del jugador 1...
	cp d			;8b06   ; ...si esta arriba del todo, no sube
	jr c,L_8B28		;8b07
	ld de,0fc00h		;8b09   ; sube 4 lineas (0xFC00)
	jr L_8B24		;8b0c
L_8B0E:
	ld a,(0e413h)		;8b0e   ; lee LENGTH, el largo de la raqueta
	ld hl,08bd3h		;8b11
	call hl_mas_a		;8b14   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8b17
	ld h,a			;8b18
	ld l,000h		;8b19
	ld a,(0e422h)		;8b1b
	cp h			;8b1e
	jr nc,L_8B28		;8b1f
	ld de,00400h		;8b21
L_8B24:
	ld hl,(0e421h)		;8b24   ; lee el jugador 1 y el byte siguiente (16 bits)
	add hl,de			;8b27
L_8B28:
	ld (0e421h),hl		;8b28   ; guarda el jugador 1 y el byte siguiente (16 bits)
L_8B2B:
	ret			;8b2b
th_direccion_1:		; la direccion del mando del jugador 1
	ld a,(0e406h)		;8b2c   ; lo recien pulsado del jugador 1 (arriba y abajo)
	and 003h		;8b2f
	ld b,a			;8b31
	ld c,000h		;8b32   ; C = 0: quieto
	jr z,L_8B53		;8b34
	ld a,(0e405h)		;8b36   ; lo que mantiene pulsado
	and 003h		;8b39
	cp 003h		;8b3b   ; los dos a la vez: nada
	ret z			;8b3d
	rra			;8b3e   ; arriba: C = 1
	ld c,001h		;8b3f
	jr c,L_8B53		;8b41
	rra			;8b43   ; abajo: C = 2
	ld c,002h		;8b44
	jr c,L_8B53		;8b46
	ld a,b			;8b48   ; lo recien pulsado
	cp 003h		;8b49
	ret z			;8b4b
	rra			;8b4c
	ld c,001h		;8b4d
	jr c,L_8B53		;8b4f
	ld c,002h		;8b51
L_8B53:
	ld a,c			;8b53
	ld (0e42fh),a		;8b54
	ret			;8b57
th_mueve_jugador_2:		; mueve al jugador 2 segun su mando
	call th_direccion_2		;8b58   ; th_direccion_2: la direccion del mando del jugador 2
	ld a,(0e43fh)		;8b5b
	and 003h		;8b5e
	ret z			;8b60
	dec a			;8b61
	call despacha		;8b62   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8B65: tabla de 3 palabras del despachador (call 0x408D en
;   0x8B62); lo leen el despachador (6 bytes)
;   0x8b65..0x8b6b  (6 bytes)
DATA_saltos_8B65:
	defb 06bh,08bh	; 8b65
	defb 085h,08bh	; 8b67
	defb 02bh,08bh	; 8b69

; ======================================================================
; CODIGO 0x8b6b..0x8bcf  (100 bytes)
; ======================================================================


L_8B6B:
	ld a,(0e413h)		;8b6b   ; lee LENGTH, el largo de la raqueta
	ld hl,08bcfh		;8b6e
	call hl_mas_a		;8b71   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8b74
	ld d,a			;8b75
	ld h,d			;8b76
	dec h			;8b77
	ld l,000h		;8b78
	ld a,(0e432h)		;8b7a
	cp d			;8b7d
	jr c,L_8B9F		;8b7e
	ld de,0fc00h		;8b80
	jr L_8B9B		;8b83
L_8B85:
	ld a,(0e413h)		;8b85   ; lee LENGTH, el largo de la raqueta
	ld hl,08bd3h		;8b88
	call hl_mas_a		;8b8b   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8b8e
	ld h,a			;8b8f
	ld l,000h		;8b90
	ld a,(0e432h)		;8b92
	cp h			;8b95
	jr nc,L_8B9F		;8b96
	ld de,00400h		;8b98
L_8B9B:
	ld hl,(0e431h)		;8b9b   ; lee el jugador 2 y el byte siguiente (16 bits)
	add hl,de			;8b9e
L_8B9F:
	ld (0e431h),hl		;8b9f   ; guarda el jugador 2 y el byte siguiente (16 bits)
	ret			;8ba2
th_direccion_2:		; la direccion del mando del jugador 2
	ld a,(0e408h)		;8ba3   ; lo recien pulsado del jugador 2 (arriba y abajo)
	and 003h		;8ba6
	ld b,a			;8ba8
	ld c,000h		;8ba9   ; C = 0: quieto
	jr z,L_8BCA		;8bab
	ld a,(0e407h)		;8bad   ; lo que mantiene pulsado
	and 003h		;8bb0
	cp 003h		;8bb2   ; los dos a la vez: nada
	ret z			;8bb4
	rra			;8bb5   ; arriba: C = 1
	ld c,001h		;8bb6
	jr c,L_8BCA		;8bb8
	rra			;8bba   ; abajo: C = 2
	ld c,002h		;8bbb
	jr c,L_8BCA		;8bbd
	ld a,b			;8bbf   ; lo recien pulsado
	cp 003h		;8bc0
	ret z			;8bc2
	rra			;8bc3
	ld c,001h		;8bc4
	jr c,L_8BCA		;8bc6
	ld c,002h		;8bc8
L_8BCA:
	ld a,c			;8bca
	ld (0e43fh),a		;8bcb
	ret			;8bce

; ----------------------------------------------------------------------
; DATOS resto_8BCF: lo apuntan con el banco puesto p07:8AF7 (0x8BCF), p07:8B6E
;   (0x8BCF), p07:8B11 (0x8BD3), p07:8B88 (0x8BD3); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p07:8AF7, p07:8B6E,
;   p07:8B11, p07:8B88 (8 bytes)
;   0x8bcf..0x8bd7  (8 bytes)
DATA_resto_8BCF:
	defb 015h,019h,011h,019h,0ach,0a8h,098h,098h	; 8bcf  ........

; ======================================================================
; CODIGO 0x8bd7..0x8c5e  (135 bytes)
; ======================================================================


th_sprites_jugadores:		; los sprites de los dos jugadores a la copia de 0xE500
	ld de,0e422h		;8bd7
	ld hl,0e504h		;8bda
	ld c,00ah		;8bdd
	ld a,(0e423h)		;8bdf
	call th_sprite_raqueta		;8be2   ; th_sprite_raqueta: escribe los sprites de una raqueta (C de alto)
	ld a,(0e415h)		;8be5   ; lee TYPE
	or a			;8be8
	jr z,L_8BF9		;8be9
	ld de,0e422h		;8beb
	ld hl,0e50ch		;8bee
	ld c,00ah		;8bf1
	ld a,(0e426h)		;8bf3
	call th_sprite_raqueta		;8bf6   ; th_sprite_raqueta: escribe los sprites de una raqueta (C de alto)
L_8BF9:
	ld de,0e432h		;8bf9
	ld hl,0e514h		;8bfc
	ld c,007h		;8bff
	ld a,(0e433h)		;8c01
	call th_sprite_raqueta		;8c04   ; th_sprite_raqueta: escribe los sprites de una raqueta (C de alto)
	ld a,(0e415h)		;8c07   ; lee TYPE
	or a			;8c0a
	ret z			;8c0b
	ld de,0e432h		;8c0c
	ld hl,0e51ch		;8c0f
	ld c,007h		;8c12
	ld a,(0e436h)		;8c14
th_sprite_raqueta:		; escribe los sprites de una raqueta (C de alto)
	push af			;8c17   ; guarda la columna
	ld a,(de)			;8c18   ; Y del primer sprite
	ld b,a			;8c19   ; B = Y para el segundo sprite
	ld (hl),a			;8c1a   ; Y a la copia
	inc l			;8c1b   ; el byte siguiente
	pop af			;8c1c   ; recupera la columna
	exx			;8c1d   ; X
	ld b,a			;8c1e   ; B' = X para el segundo sprite
	exx			;8c1f
	ld (hl),a			;8c20   ; X a la copia
	inc e			;8c21   ; el patron, 6 bytes mas alla en la ficha
	inc e			;8c22
	inc e			;8c23
	inc e			;8c24
	inc e			;8c25
	inc e			;8c26
	inc l			;8c27   ; el patron
	ld a,(de)			;8c28   ; el patron de la raqueta...
	ld (hl),a			;8c29   ; ...a la copia
	inc l			;8c2a
	ld (hl),c			;8c2b   ; el color (C)
	inc l			;8c2c   ; el segundo sprite
	dec e			;8c2d   ; la raqueta corta (LENGTH = 1)...
	ld a,(de)			;8c2e   ; LENGTH...
	dec a			;8c2f   ; ...es 1?
	jr nz,L_8C3C		;8c30
	ld a,0e0h		;8c32   ; ...esconde el segundo sprite (Y = 0xE0)
	ld (hl),a			;8c34   ; Y, X, patron y color del segundo sprite, todos a 0xE0
	inc l			;8c35   ; X
	ld (hl),a			;8c36
	inc l			;8c37   ; el patron
	ld (hl),a			;8c38
	inc l			;8c39   ; el color
	ld (hl),a			;8c3a
	ret			;8c3b
L_8C3C:
	ld a,b			;8c3c   ; el segundo sprite, 16 lineas mas abajo
	add a,010h		;8c3d
	ld (hl),a			;8c3f   ; Y
	inc l			;8c40
	exx			;8c41   ; la misma X
	ld a,b			;8c42
	exx			;8c43
	ld (hl),a			;8c44   ; X
	inc e			;8c45   ; dos bytes mas alla en la ficha
	inc e			;8c46
	inc l			;8c47
	ld a,(de)			;8c48   ; su patron
	ld (hl),a			;8c49
	inc l			;8c4a
	ld (hl),c			;8c4b   ; el color
	ret			;8c4c
th_prepara_barra:		; con BAR (0xE416), prepara la barra del centro (0xE450)
	ld a,(0e416h)		;8c4d   ; lee hay barra en el centro
	or a			;8c50
	ret z			;8c51
	ld hl,08c5eh		;8c52
	ld de,0e450h		;8c55   ; apunta a la barra del centro (BAR)
	ld bc,00004h		;8c58
	ldir		;8c5b
	ret			;8c5d

; ----------------------------------------------------------------------
; DATOS resto_8C5E: lo apuntan con el banco puesto p07:8C52 (0x8C5E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8C52 (4 bytes)
;   0x8c5e..0x8c62  (4 bytes)
DATA_resto_8C5E:
	defb 000h,000h,018h,078h	; 8c5e

; ======================================================================
; CODIGO 0x8c62..0x8ce6  (132 bytes)
; ======================================================================


th_mueve_barra:		; con BAR, sube y baja la barra del centro
	ld a,(0e416h)		;8c62   ; sin barra, nada
	or a			;8c65
	ret z			;8c66
	ld a,(0e450h)		;8c67   ; la direccion de la barra
	or a			;8c6a
	ld hl,0e452h		;8c6b   ; su altura (0xE452)
	ld a,(hl)			;8c6e
	jr nz,L_8C77		;8c6f
	cp 088h		;8c71   ; bajando, hasta 0x88...
	jr nc,L_8C7D		;8c73
	inc (hl)			;8c75   ; ...una linea por cuadro
	ret			;8c76
L_8C77:
	cp 019h		;8c77
	jr c,L_8C7D		;8c79
	dec (hl)			;8c7b
	ret			;8c7c
L_8C7D:
	ld a,(0e450h)		;8c7d   ; lee la barra del centro (BAR)
	xor 001h		;8c80
	ld (0e450h),a		;8c82   ; guarda la barra del centro (BAR)
	ret			;8c85
th_sprite_barra:		; con BAR, los tres sprites de la barra del centro
	ld a,(0e416h)		;8c86   ; sin barra, nada
	or a			;8c89   ; 0: sin barra
	ret z			;8c8a
	ld hl,0e524h		;8c8b   ; los sprites 9-11 de la copia (0xE524)
	ld de,0e452h		;8c8e   ; la altura y la columna de la barra
	ld a,(de)			;8c91
	ld b,a			;8c92   ; B = la altura
	ld (hl),a			;8c93   ; Y del primer sprite
	inc l			;8c94   ; X, en el byte siguiente
	inc e			;8c95
	ld a,(de)			;8c96
	ld c,a			;8c97   ; C = la columna
	ld (hl),a			;8c98   ; X
	inc l			;8c99   ; el patron
	ld (hl),018h		;8c9a   ; patron 0x18
	inc l			;8c9c   ; el color
	ld (hl),00dh		;8c9d   ; color 0x0D
	inc l			;8c9f   ; el segundo sprite
	ld a,b			;8ca0   ; el segundo, 16 lineas mas abajo
	add a,010h		;8ca1
	ld (hl),a			;8ca3
	inc l			;8ca4   ; X
	ld (hl),c			;8ca5   ; la misma X
	inc l			;8ca6   ; el patron
	ld (hl),01ch		;8ca7   ; patron 0x1C
	inc l			;8ca9   ; el color
	ld (hl),00dh		;8caa   ; el mismo color
	inc l			;8cac   ; el tercer sprite
	add a,010h		;8cad   ; el tercero, 16 mas
	ld (hl),a			;8caf
	inc l			;8cb0   ; X
	ld (hl),c			;8cb1   ; la misma X
	inc l			;8cb2   ; el patron
	ld (hl),020h		;8cb3   ; patron 0x20
	inc l			;8cb5   ; el color
	ld (hl),00dh		;8cb6   ; el mismo color
	ret			;8cb8
th_prepara_pelota:		; la pelota al centro (0xE440)
	ld hl,0e448h		;8cb9   ; 0xE448 = 0
	ld (hl),000h		;8cbc
	ld hl,0e449h		;8cbe   ; 0xE449 = 0x50
	ld (hl),050h		;8cc1
	ld de,0e440h		;8cc3   ; la posicion de partida de p07:8CE6 (8 bytes)
	ld hl,08ce6h		;8cc6
	ld bc,00008h		;8cc9
	ldir		;8ccc
	ld hl,08ceeh		;8cce   ; la velocidad de saque: hacia un lado...
	ld a,(0e41ah)		;8cd1   ; ...segun quien saca (0xE41A)...
	or a			;8cd4
	jr nz,L_8CDA		;8cd5
	ld hl,08cf0h		;8cd7   ; ...o hacia el otro
L_8CDA:
	ld a,(0e412h)		;8cda   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8cdd
	call hl_mas_a		;8cde   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8ce1
	ld (0e443h),a		;8ce2   ; guarda la columna de la pelota (0x78 es el centro)
	ret			;8ce5

; ----------------------------------------------------------------------
; DATOS resto_8CE6: lo apuntan con el banco puesto p07:8CC6 (0x8CE6), p07:8CCE
;   (0x8CEE), p07:8CD7 (0x8CF0); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p07:8CC6, p07:8CCE, p07:8CD7 (12 bytes)
;   0x8ce6..0x8cf2  (12 bytes)
DATA_resto_8CE6:
	defb 000h,060h,000h,000h,000h,000h,000h,000h,0dah,0b3h,015h,03dh	; 8ce6  .`.........=

; ======================================================================
; CODIGO 0x8cf2..0x8d5f  (109 bytes)
; ======================================================================


th_mueve_pelota:		; mueve la pelota y mira los choques
	ld a,(0e448h)		;8cf2
	dec a			;8cf5
	jr z,L_8D4C		;8cf6
	call th_pelota_en_raqueta		;8cf8   ; th_pelota_en_raqueta: pone la pelota (0xE441) a la altura de la raqueta del lado que saca, centrada segun LENGTH (tabla p07:8D80)
	ld a,(0e443h)		;8cfb   ; lee la columna de la pelota (0x78 es el centro)
	cp 078h		;8cfe
	ld a,(0e405h)		;8d00   ; lee el mando del jugador 1
	jr nc,L_8D08		;8d03
	ld a,(0e407h)		;8d05   ; lee el mando del jugador 2
L_8D08:
	and 010h		;8d08
	jr nz,L_8D16		;8d0a
	ld a,(0e412h)		;8d0c   ; lee el juego: 1 tenis, 2 hockey
	dec a			;8d0f
	ret z			;8d10
	ld hl,0e449h		;8d11
	dec (hl)			;8d14
	ret nz			;8d15
L_8D16:
	ld a,005h		;8d16
	call pide_sonido		;8d18   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ld hl,0e448h		;8d1b
	inc (hl)			;8d1e
	ld hl,08d5fh		;8d1f
	ld a,(0e443h)		;8d22   ; lee la columna de la pelota (0x78 es el centro)
	cp 078h		;8d25
	jr c,L_8D2C		;8d27
	ld hl,08d61h		;8d29
L_8D2C:
	ld a,r		;8d2c
	and 001h		;8d2e
	or a			;8d30
	jr z,L_8D34		;8d31
	inc hl			;8d33
L_8D34:
	ld a,(hl)			;8d34
	ld (0e44ah),a		;8d35
th_avanza_pelota:		; suma la velocidad a la posicion de la pelota (0xE440, 0xE442)
	call th_velocidades		;8d38   ; th_velocidades: las dos velocidades de las tablas de p07:9051 y p07:9059
	push hl			;8d3b
	ld hl,(0e440h)		;8d3c   ; lee la altura de la pelota (16 bits; la parte entera en 0xE441) y el byte siguiente (16 bits)
	add hl,de			;8d3f
	ld (0e440h),hl		;8d40   ; guarda la altura de la pelota (16 bits; la parte entera en 0xE441) y el byte siguiente (16 bits)
	pop de			;8d43
	ld hl,(0e442h)		;8d44   ; lee la posicion horizontal de la pelota (16 bits; la parte entera en 0xE443) y el byte siguiente (16 bits)
	add hl,de			;8d47
	ld (0e442h),hl		;8d48   ; guarda la posicion horizontal de la pelota (16 bits; la parte entera en 0xE443) y el byte siguiente (16 bits)
	ret			;8d4b
L_8D4C:
	ld a,(0e414h)		;8d4c   ; lee SPEED
	inc a			;8d4f
	ld b,a			;8d50
L_8D51:
	push bc			;8d51
	ld a,(0e44ah)		;8d52
	call th_avanza_pelota		;8d55   ; th_avanza_pelota: suma la velocidad a la posicion de la pelota (0xE440, 0xE442)
	call th_choques		;8d58   ; th_choques: los choques de la pelota con las raquetas
	pop bc			;8d5b
	djnz L_8D51		;8d5c
	ret			;8d5e

; ----------------------------------------------------------------------
; DATOS resto_8D5F: lo apuntan con el banco puesto p07:8D1F (0x8D5F), p07:8D29
;   (0x8D61); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:8D1F, p07:8D29 (4 bytes)
;   0x8d5f..0x8d63  (4 bytes)
DATA_resto_8D5F:
	defb 002h,00eh,006h,00ah	; 8d5f

; ======================================================================
; CODIGO 0x8d63..0x8d80  (29 bytes)
; ======================================================================


th_pelota_en_raqueta:		; pone la pelota (0xE441) a la altura de la raqueta del lado que saca, centrada segun LENGTH (tabla p07:8D80)
	ld a,(0e443h)		;8d63   ; lee la columna de la pelota (0x78 es el centro)
	cp 078h		;8d66
	ld a,(0e422h)		;8d68
	jr nc,L_8D70		;8d6b
	ld a,(0e432h)		;8d6d
L_8D70:
	ld b,a			;8d70
	ld a,(0e413h)		;8d71   ; lee LENGTH, el largo de la raqueta
	ld hl,08d80h		;8d74
	call hl_mas_a		;8d77   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8d7a
	add a,b			;8d7b
	ld (0e441h),a		;8d7c   ; guarda la altura de la pelota
	ret			;8d7f

; ----------------------------------------------------------------------
; DATOS resto_8D80: lo apuntan con el banco puesto p07:8D74 (0x8D80); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8D74 (4 bytes)
;   0x8d80..0x8d84  (4 bytes)
DATA_resto_8D80:
	defb 000h,000h,00ch,008h	; 8d80

; ======================================================================
; CODIGO 0x8d84..0x8dd3  (79 bytes)
; ======================================================================


th_choques:		; los choques de la pelota con las raquetas
	ld hl,0e44bh		;8d84   ; 0xE44B: la pelota ha tocado algo
	ld (hl),000h		;8d87
	ex af,af'			;8d89   ; A' = 0: las raquetas
	xor a			;8d8a
	ex af,af'			;8d8b
	exx			;8d8c
	ld c,006h		;8d8d   ; C' = 6: el ancho que se mira
	exx			;8d8f
	call th_choque		;8d90   ; th_choque: comprueba un choque de la pelota
	ex af,af'			;8d93   ; A' = 1: los bordes
	ld a,001h		;8d94
	ex af,af'			;8d96
	call th_choque		;8d97   ; th_choque: comprueba un choque de la pelota
	ld a,(0e416h)		;8d9a   ; sin barra, ya esta
	or a			;8d9d
	ret z			;8d9e
	ex af,af'			;8d9f   ; A' = 2: la barra...
	ld a,002h		;8da0
	ex af,af'			;8da2
	exx			;8da3
	ld c,00ah		;8da4   ; ...con C' = 10
	exx			;8da6
	jp th_choque		;8da7   ; th_choque: comprueba un choque de la pelota
L_8DAA:
	ld a,(0e44ah)		;8daa   ; el angulo de la pelota (0-15)
	ld b,a			;8dad
	ld a,010h		;8dae   ; rebota en horizontal: 16 - angulo
	sub b			;8db0
	and 00fh		;8db1
	ld (0e44ah),a		;8db3
	jr $+66		;8db6
L_8DB8:
	ld a,(0e44bh)		;8db8
	or a			;8dbb
	jr z,L_8DC3		;8dbc
	call th_efecto		;8dbe   ; th_efecto: el efecto que da la raqueta a la pelota
	jr nz,$+55		;8dc1
L_8DC3:
	ld d,000h		;8dc3   ; el angulo
	ld a,(0e44ah)		;8dc5
	ld e,a			;8dc8
	ld hl,08dd3h		;8dc9   ; rebota en vertical: la tabla de p07:8DD3
	add hl,de			;8dcc
	ld a,(hl)			;8dcd
	ld (0e44ah),a		;8dce
	jr $+39		;8dd1

; ----------------------------------------------------------------------
; DATOS resto_8DD3: lo apuntan con el banco puesto p07:8DC9 (0x8DD3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8DC9 (16 bytes)
;   0x8dd3..0x8de3  (16 bytes)
DATA_resto_8DD3:
	defb 008h,007h,006h,005h,00ch,003h,002h,001h,000h,00fh,00eh,00dh,004h,00bh,00ah,009h	; 8dd3  ................

; ======================================================================
; CODIGO 0x8de3..0x8e24  (65 bytes)
; ======================================================================


L_8DE3:
	ld a,(0e44bh)		;8de3
	or a			;8de6
	jr z,L_8DEE		;8de7
	call th_efecto		;8de9   ; th_efecto: el efecto que da la raqueta a la pelota
	jr nz,L_8DF8		;8dec
L_8DEE:
	ld a,(0e44ah)		;8dee
	add a,008h		;8df1
	and 00fh		;8df3
	ld (0e44ah),a		;8df5
L_8DF8:
	exx			;8df8
	ld a,c			;8df9
	exx			;8dfa
	jp pide_sonido		;8dfb   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
th_efecto:		; el efecto que da la raqueta a la pelota
	ld a,(0e44ch)		;8dfe
	or a			;8e01
	ld a,(0e42fh)		;8e02
	jr z,L_8E0A		;8e05
	ld a,(0e43fh)		;8e07
L_8E0A:
	and 003h		;8e0a   ; el mando: arriba o abajo
	ret z			;8e0c
	cp 003h		;8e0d   ; los dos a la vez: nada
	ret z			;8e0f
	rra			;8e10   ; arriba: la tabla de p07:8E24
	ld hl,08e24h		;8e11
	jr c,L_8E19		;8e14
	ld hl,08e34h		;8e16   ; abajo: la de p07:8E34
L_8E19:
	ld a,(0e44ah)		;8e19
	call hl_mas_a		;8e1c   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8e1f
	ld (0e44ah),a		;8e20
	ret			;8e23

; ----------------------------------------------------------------------
; DATOS resto_8E24: lo apuntan con el banco puesto p07:8E11 (0x8E24), p07:8E16
;   (0x8E34); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:8E11, p07:8E16 (32 bytes)
;   0x8e24..0x8e44  (32 bytes)
DATA_resto_8E24:
	defb 005h,005h,006h,007h,005h,001h,002h,003h,001h,002h,003h,003h,003h,005h,005h,006h	; 8e24  ................
	defb 009h,00ah,00bh,00bh,00bh,00dh,00dh,00eh,00fh,00dh,00dh,00eh,00eh,00ah,00bh,00bh	; 8e34  ................

; ======================================================================
; CODIGO 0x8e44..0x8e4a  (6 bytes)
; ======================================================================


th_choque:		; comprueba un choque de la pelota
	ld a,(0e44ah)		;8e44
	call despacha		;8e47   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8E4A: tabla de 16 palabras del despachador (call 0x408D en
;   0x8E47); lo leen el despachador (32 bytes)
;   0x8e4a..0x8e6a  (32 bytes)
DATA_saltos_8E4A:
	defb 06ah,08eh	; 8e4a
	defb 07dh,08eh	; 8e4c
	defb 07dh,08eh	; 8e4e
	defb 07dh,08eh	; 8e50
	defb 0ach,08eh	; 8e52
	defb 0bfh,08eh	; 8e54
	defb 0bfh,08eh	; 8e56
	defb 0bfh,08eh	; 8e58
	defb 0eeh,08eh	; 8e5a
	defb 001h,08fh	; 8e5c
	defb 001h,08fh	; 8e5e
	defb 001h,08fh	; 8e60
	defb 030h,08fh	; 8e62
	defb 043h,08fh	; 8e64
	defb 043h,08fh	; 8e66
	defb 043h,08fh	; 8e68

; ======================================================================
; CODIGO 0x8e6a..0x9024  (442 bytes)
; ======================================================================


L_8E6A:
	ld a,(0e443h)		;8e6a   ; lee la columna de la pelota (0x78 es el centro)
	add a,00bh		;8e6d
	ld h,a			;8e6f
	ld a,(0e441h)		;8e70   ; lee la altura de la pelota
	add a,008h		;8e73
	ld l,a			;8e75
	call th_choca_raqueta		;8e76   ; th_choca_raqueta: mira si la pelota toca una raqueta
	jp z,L_8DB8		;8e79
	ret			;8e7c
L_8E7D:
	ld a,(0e443h)		;8e7d   ; lee la columna de la pelota (0x78 es el centro)
	add a,00bh		;8e80   ; la columna de la pelota mas 11...
	ld h,a			;8e82
	ld a,(0e441h)		;8e83   ; lee la altura de la pelota
	add a,008h		;8e86   ; ...y su altura mas 8: el centro
	ld l,a			;8e88
	push hl			;8e89
	call th_choca_raqueta		;8e8a   ; toca una raqueta?
	pop hl			;8e8d
	jp z,L_8DB8		;8e8e   ; si: rebota
	ld a,l			;8e91   ; tres pixeles arriba...
	sub 003h		;8e92
	ld l,a			;8e94
	ld a,h			;8e95   ; ...y tres a la izquierda
	sub 003h		;8e96
	ld h,a			;8e98
	push hl			;8e99
	call th_choca_raqueta		;8e9a   ; toca?
	pop hl			;8e9d
	jp z,L_8DAA		;8e9e   ; si: rebota de otra manera
	ld a,h			;8ea1   ; tres a la derecha
	add a,003h		;8ea2
	ld h,a			;8ea4
	call th_choca_raqueta		;8ea5   ; toca?
	jp z,L_8DE3		;8ea8   ; si: rebota de la tercera
	ret			;8eab
L_8EAC:
	ld a,(0e443h)		;8eac   ; lee la columna de la pelota (0x78 es el centro)
	add a,008h		;8eaf
	ld h,a			;8eb1
	ld a,(0e441h)		;8eb2   ; lee la altura de la pelota
	add a,005h		;8eb5
	ld l,a			;8eb7
	call th_choca_raqueta		;8eb8   ; th_choca_raqueta: mira si la pelota toca una raqueta
	jp z,L_8DAA		;8ebb
	ret			;8ebe
L_8EBF:
	ld a,(0e443h)		;8ebf   ; lee la columna de la pelota (0x78 es el centro)
	add a,008h		;8ec2   ; la columna de la pelota mas 8...
	ld h,a			;8ec4
	ld a,(0e441h)		;8ec5   ; lee la altura de la pelota
	add a,005h		;8ec8   ; ...y su altura mas 5: el borde de arriba
	ld l,a			;8eca
	push hl			;8ecb
	call th_choca_raqueta		;8ecc   ; toca una raqueta?
	pop hl			;8ecf
	jp z,L_8DAA		;8ed0   ; si: rebota en horizontal
	ld a,l			;8ed3   ; tres pixeles abajo...
	add a,003h		;8ed4
	ld l,a			;8ed6
	ld a,h			;8ed7   ; ...y tres a la izquierda
	sub 003h		;8ed8
	ld h,a			;8eda
	push hl			;8edb
	call th_choca_raqueta		;8edc   ; toca?
	pop hl			;8edf
	jp z,L_8DB8		;8ee0   ; si: rebota en vertical
	ld a,l			;8ee3   ; tres arriba
	sub 003h		;8ee4
	ld l,a			;8ee6
	call th_choca_raqueta		;8ee7   ; toca?
	jp z,L_8DE3		;8eea   ; si: rebota en diagonal
	ret			;8eed
L_8EEE:
	ld a,(0e443h)		;8eee   ; lee la columna de la pelota (0x78 es el centro)
	add a,005h		;8ef1
	ld h,a			;8ef3
	ld a,(0e441h)		;8ef4   ; lee la altura de la pelota
	add a,008h		;8ef7
	ld l,a			;8ef9
	call th_choca_raqueta		;8efa   ; th_choca_raqueta: mira si la pelota toca una raqueta
	jp z,L_8DB8		;8efd
	ret			;8f00
L_8F01:
	ld a,(0e443h)		;8f01   ; lee la columna de la pelota (0x78 es el centro)
	add a,005h		;8f04   ; la columna de la pelota mas 5...
	ld h,a			;8f06
	ld a,(0e441h)		;8f07   ; lee la altura de la pelota
	add a,008h		;8f0a   ; ...y su altura mas 8: el borde de la izquierda
	ld l,a			;8f0c
	push hl			;8f0d
	call th_choca_raqueta		;8f0e   ; toca una raqueta?
	pop hl			;8f11
	jp z,L_8DB8		;8f12   ; si: rebota en vertical
	ld a,l			;8f15   ; tres pixeles abajo...
	add a,003h		;8f16
	ld l,a			;8f18
	ld a,h			;8f19   ; ...y tres a la derecha
	add a,003h		;8f1a
	ld h,a			;8f1c
	push hl			;8f1d
	call th_choca_raqueta		;8f1e   ; toca?
	pop hl			;8f21
	jp z,L_8DAA		;8f22   ; si: rebota en horizontal
	ld a,h			;8f25   ; tres a la izquierda
	sub 003h		;8f26
	ld h,a			;8f28
	call th_choca_raqueta		;8f29   ; toca?
	jp z,L_8DE3		;8f2c   ; si: rebota en diagonal
	ret			;8f2f
L_8F30:
	ld a,(0e443h)		;8f30   ; lee la columna de la pelota (0x78 es el centro)
	add a,008h		;8f33
	ld h,a			;8f35
	ld a,(0e441h)		;8f36   ; lee la altura de la pelota
	add a,00bh		;8f39
	ld l,a			;8f3b
	call th_choca_raqueta		;8f3c   ; th_choca_raqueta: mira si la pelota toca una raqueta
	jp z,L_8DAA		;8f3f
	ret			;8f42
L_8F43:
	ld a,(0e443h)		;8f43   ; lee la columna de la pelota (0x78 es el centro)
	add a,008h		;8f46   ; la columna de la pelota mas 8...
	ld h,a			;8f48
	ld a,(0e441h)		;8f49   ; lee la altura de la pelota
	add a,00bh		;8f4c   ; ...y su altura mas 11: el borde de abajo
	ld l,a			;8f4e
	push hl			;8f4f
	call th_choca_raqueta		;8f50   ; toca una raqueta?
	pop hl			;8f53
	jp z,L_8DAA		;8f54   ; si: rebota en horizontal
	ld a,l			;8f57   ; tres pixeles arriba...
	sub 003h		;8f58
	ld l,a			;8f5a
	ld a,h			;8f5b   ; ...y tres a la derecha
	add a,003h		;8f5c
	ld h,a			;8f5e
	push hl			;8f5f
	call th_choca_raqueta		;8f60   ; toca?
	pop hl			;8f63
	jp z,L_8DB8		;8f64   ; si: rebota en vertical
	ld a,l			;8f67   ; tres abajo
	add a,003h		;8f68
	ld l,a			;8f6a
	call th_choca_raqueta		;8f6b   ; toca?
	jp z,L_8DE3		;8f6e   ; si: rebota en diagonal
	ret			;8f71
th_choca_raqueta:		; mira si la pelota toca una raqueta
	ex af,af'			;8f72   ; en que fase del choque va (A')
	ld b,a			;8f73
	ex af,af'			;8f74
	dec b			;8f75   ; la 1: las raquetas; la 2: los bordes y la barra
	jp nz,L_8FFE		;8f76
	xor a			;8f79   ; el jugador 1
	ld b,a			;8f7a
	ld (0e44ch),a		;8f7b
	push hl			;8f7e
	ex de,hl			;8f7f   ; DE = la posicion de la pelota
	ld hl,(0e422h)		;8f80   ; HL = la raqueta del jugador 1
	call th_choca_borde		;8f83   ; th_choca_borde: mira si la pelota toca el borde de la raqueta
	pop de			;8f86
	dec b			;8f87   ; la toca: sale
	ret z			;8f88
	ld b,000h		;8f89
	ld a,001h		;8f8b   ; el jugador 2
	ld (0e44ch),a		;8f8d
	push de			;8f90
	ld hl,(0e432h)		;8f91   ; HL = la raqueta del jugador 2
	call th_choca_borde		;8f94   ; th_choca_borde: mira si la pelota toca el borde de la raqueta
	pop de			;8f97
	dec b			;8f98   ; la toca: sale
	ret z			;8f99
	ld a,(0e415h)		;8f9a   ; lee TYPE
	or a			;8f9d   ; con TYPE 0...
	jr nz,L_8FA2		;8f9e
	inc a			;8fa0   ; ...NZ: no rebota en los bordes
	ret			;8fa1
L_8FA2:
	xor a			;8fa2   ; la raqueta del jugador 1
	ld b,a			;8fa3
	ld (0e44ch),a		;8fa4
	push de			;8fa7
	ld a,(0e422h)		;8fa8   ; su altura
	ld l,a			;8fab
	ld a,(0e426h)		;8fac   ; y su columna
	ld h,a			;8faf
	call th_choca_borde		;8fb0   ; la toca?
	pop de			;8fb3
	dec b			;8fb4
	ret z			;8fb5   ; si: sale
	ld b,000h		;8fb6
	ld a,001h		;8fb8   ; la raqueta del jugador 2
	ld (0e44ch),a		;8fba
	ld a,(0e432h)		;8fbd
	ld l,a			;8fc0
	ld a,(0e436h)		;8fc1
	ld h,a			;8fc4
	call th_choca_borde		;8fc5   ; la toca?
	dec b			;8fc8
	ret			;8fc9
th_choca_borde:		; mira si la pelota toca el borde de la raqueta
	exx			;8fca   ; el largo de la raqueta...
	ld hl,09024h		;8fcb   ; ...segun LENGTH (tabla p07:9024)
	ld a,(0e413h)		;8fce   ; lee LENGTH, el largo de la raqueta
	add a,a			;8fd1   ; x 2: dos bytes por largo
	call hl_mas_a		;8fd2   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8fd5   ; A = el borde de arriba
	exx			;8fd6
	add a,l			;8fd7   ; la parte de arriba de la raqueta...
	cp e			;8fd8   ; ...por debajo de la pelota: no
	ret nc			;8fd9
	ld l,a			;8fda   ; L = la parte de arriba
	exx			;8fdb
	inc hl			;8fdc   ; el borde de abajo
	ld a,(hl)			;8fdd
	exx			;8fde
	add a,l			;8fdf   ; la de abajo...
	cp e			;8fe0   ; ...por encima: no
	ret c			;8fe1
	ld a,005h		;8fe2   ; la columna de la raqueta, mas 5...
	add a,h			;8fe4
	cp d			;8fe5
	ret nc			;8fe6
	add a,004h		;8fe7   ; ...y 4 de ancho
	cp d			;8fe9
	ret c			;8fea
	ld a,001h		;8feb   ; toca: 0xE44B = 1
	ld (0e44bh),a		;8fed
	exx			;8ff0   ; vuelve a los registros de la pelota
	ld a,(0e44ch)		;8ff1   ; el lado (0xE44C)...
	ld c,008h		;8ff4   ; ...decide el sonido: 8 o 7
	or a			;8ff6   ; lado 0: el 8
	jr z,L_8FFB		;8ff7
	ld c,007h		;8ff9   ; si no, el 7
L_8FFB:
	exx			;8ffb
	inc b			;8ffc
	ret			;8ffd
L_8FFE:
	djnz L_901B		;8ffe
	ld b,000h		;9000
	call th_choca_barra		;9002   ; th_choca_barra: mira si la pelota toca la barra del centro: B + 1
	dec b			;9005
	ret			;9006
th_choca_barra:		; mira si la pelota toca la barra del centro: B + 1
	ld a,(0e452h)		;9007   ; la parte de arriba de la barra
	dec a			;900a
	cp l			;900b   ; por debajo de la pelota: no
	ret nc			;900c
	add a,030h		;900d   ; la de abajo (0x30 de alto)
	cp l			;900f
	ret c			;9010
	ld a,07ch		;9011   ; la columna de la barra (0x7C)...
	cp h			;9013
	ret nc			;9014
	add a,006h		;9015   ; ...y 6 de ancho
	cp h			;9017
	ret c			;9018
	inc b			;9019   ; toca: B + 1
	ret			;901a
L_901B:
	call th_divide		;901b   ; th_divide: desplaza HL y A: la posicion entre 8
	ld a,(hl)			;901e
	sub 060h		;901f
	ret z			;9021
	dec a			;9022
	ret			;9023

; ----------------------------------------------------------------------
; DATOS resto_9024: lo apuntan con el banco puesto p07:8FCB (0x9024); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:8FCB (8 bytes)
;   0x9024..0x902c  (8 bytes)
DATA_resto_9024:
	defb 003h,008h,0ffh,010h,007h,018h,0ffh,020h	; 9024  .......

; ======================================================================
; CODIGO 0x902c..0x9051  (37 bytes)
; ======================================================================


th_sprite_pelota:		; el sprite de la pelota a la copia de 0xE500
	ld hl,0e500h		;902c   ; apunta a la copia de la tabla de sprites
	ld de,0e441h		;902f   ; apunta a la altura de la pelota
	ld a,(de)			;9032   ; Y del sprite 0 = la altura de la pelota
	ld (hl),a			;9033
	inc l			;9034
	inc e			;9035   ; la columna de la pelota (0xE443)...
	inc e			;9036
	ld a,(de)			;9037
	ld (hl),a			;9038   ; ...X
	inc l			;9039
	ld (hl),000h		;903a   ; patron 0
	inc l			;903c
	ld (hl),00fh		;903d   ; color 0x0F (blanco)
	ret			;903f
th_velocidades:		; las dos velocidades de las tablas de p07:9051 y p07:9059
	push af			;9040
	ld de,09051h		;9041
	call palabra_de_tabla		;9044   ; palabra_de_tabla: DE = la palabra A de la tabla de DE
	pop af			;9047
	push de			;9048
	ld de,09059h		;9049
	call palabra_de_tabla		;904c   ; palabra_de_tabla: DE = la palabra A de la tabla de DE
	pop hl			;904f
	ret			;9050

; ----------------------------------------------------------------------
; DATOS resto_9051: lo apuntan con el banco puesto p07:9041 (0x9051), p07:9049
;   (0x9059); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:9041, p07:9049 (40 bytes)
;   0x9051..0x9079  (40 bytes)
DATA_resto_9051:
	defb 000h,001h,0ddh,000h,0b5h,000h,080h,000h,000h,000h,080h,0ffh,04bh,0ffh,023h,0ffh	; 9051  ............K.#.
	defb 000h,0ffh,023h,0ffh,04bh,0ffh,080h,0ffh,000h,000h,080h,000h,0b5h,000h,0ddh,000h	; 9061  ..#.K...........
	defb 000h,001h,0ddh,000h,0b5h,000h,080h,000h	; 9071  ........

; ======================================================================
; CODIGO 0x9079..0x90fa  (129 bytes)
; ======================================================================


palabra_de_tabla:		; DE = la palabra A de la tabla de DE
	ld l,a			;9079   ; HL = A x 2...
	ld h,000h		;907a
	add hl,hl			;907c
	add hl,de			;907d   ; ...en la tabla de DE
	ld e,(hl)			;907e   ; DE = la palabra
	inc hl			;907f
	ld d,(hl)			;9080
	ret			;9081
th_campo_tenis:		; descomprime p07:9386 en 0x2300
	ld hl,02300h		;9082
	ld de,09386h		;9085
	jp th_descomprime_tercios		;9088   ; th_descomprime_tercios: descomprime DE en los tres tercios
th_campo_hockey:		; descomprime p07:951D en 0x0300
	ld hl,00300h		;908b
	ld de,0951dh		;908e
	jp th_descomprime_tercios		;9091   ; th_descomprime_tercios: descomprime DE en los tres tercios
th_campo_colores:		; descomprime p07:9535
	ld de,09535h		;9094
	jp L_8641		;9097
th_menu_juego:		; GAME SELECT: TENNIS / HOCKEY / END
	ld de,0876eh		;909a
	call th_pinta_texto		;909d   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld a,001h		;90a0
	ld (0e412h),a		;90a2   ; guarda el juego: 1 tenis, 2 hockey
	ret			;90a5
th_elige_juego:		; mueve la eleccion de juego (0xE412) con el mando
	ld a,(0e405h)		;90a6   ; lee el mando del jugador 1
	and 003h		;90a9
	jr z,L_90D0		;90ab
	ld hl,0e412h		;90ad   ; apunta a el juego: 1 tenis, 2 hockey
	rra			;90b0
	jr nc,L_90C1		;90b1
	ld a,(hl)			;90b3
	dec a			;90b4
	jp z,L_90D0		;90b5
	dec (hl)			;90b8
	ld a,002h		;90b9
	call pide_sonido		;90bb   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_90D0		;90be
L_90C1:
	ld a,(hl)			;90c1
	sub 003h		;90c2
	jp z,L_90D0		;90c4
	inc (hl)			;90c7
	ld a,002h		;90c8
	call pide_sonido		;90ca   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_90D0		;90cd
L_90D0:
	xor a			;90d0   ; borra las tres flechas del menu GAME SELECT
	ld hl,0394dh		;90d1
	call 0004dh		;90d4   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;90d7
	ld hl,0398dh		;90d8
	call 0004dh		;90db   ; BIOS WRTVRM - Writes data in VRAM
	xor a			;90de
	ld hl,039cdh		;90df
	call 0004dh		;90e2   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0e412h)		;90e5   ; el juego elegido...
	dec a			;90e8
	ld hl,090fah		;90e9   ; ...su posicion (tabla de p07:90FA)...
	add a,a			;90ec
	call hl_mas_a		;90ed   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;90f0
	inc hl			;90f1
	ld d,(hl)			;90f2
	ex de,hl			;90f3
	ld a,08dh		;90f4   ; ...con la flecha (0x8D)
	call 0004dh		;90f6   ; BIOS WRTVRM - Writes data in VRAM
	ret			;90f9

; ----------------------------------------------------------------------
; DATOS resto_90FA: lo apuntan con el banco puesto p07:90E9 (0x90FA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:90E9 (6 bytes)
;   0x90fa..0x9100  (6 bytes)
DATA_resto_90FA:
	defb 04dh,039h,08dh,039h,0cdh,039h	; 90fa

; ======================================================================
; CODIGO 0x9100..0x9126  (38 bytes)
; ======================================================================


th_menu_modify:		; GAME MODIFY: LENGTH / SPEED / TYPE / BAR
	ld de,087a5h		;9100
	call th_pinta_texto		;9103   ; th_pinta_texto: pinta un texto: [direccion de VRAM][n][letras], letras + 0x20
	ld hl,09126h		;9106
	ld de,0e500h		;9109   ; apunta a la copia de la tabla de sprites
	ld bc,00010h		;910c
	ldir		;910f
	ld a,003h		;9111
	ld (0e462h),a		;9113
	ld a,004h		;9116
	ld (0e464h),a		;9118
	ld a,002h		;911b
	ld (0e466h),a		;911d
	ld a,001h		;9120
	ld (0e468h),a		;9122
	ret			;9125

; ----------------------------------------------------------------------
; DATOS resto_9126: lo apuntan con el banco puesto p07:9106 (0x9126); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:9106 (16 bytes)
;   0x9126..0x9136  (16 bytes)
DATA_resto_9126:
	defb 0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h,0e0h,0e0h,024h,008h	; 9126  ..$...$...$...$.

; ======================================================================
; CODIGO 0x9136..0x9204  (206 bytes)
; ======================================================================


th_cambia_opcion:		; cambia la opcion elegida del GAME MODIFY (0xE460)
	ld a,(0e405h)		;9136   ; lee el mando del jugador 1
	ld c,a			;9139   ; C = el mando
	and 00ch		;913a   ; izquierda o derecha: cambia el valor
	jr nz,L_9167		;913c
	ld a,c			;913e   ; arriba o abajo: cambia de opcion
	and 003h		;913f
	jp z,L_9199		;9141
	ld hl,0e460h		;9144   ; apunta a la opcion elegida del GAME MODIFY
	rra			;9147   ; arriba
	jr nc,L_9158		;9148
	ld a,(hl)			;914a   ; ya en la primera, nada
	and a			;914b
	jp z,L_9199		;914c
	dec (hl)			;914f   ; la anterior
	ld a,002h		;9150   ; con el sonido 2
	call pide_sonido		;9152   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_9199		;9155
L_9158:
	ld a,(hl)			;9158
	cp 003h		;9159
	jp z,L_9199		;915b
	inc (hl)			;915e
	ld a,002h		;915f
	call pide_sonido		;9161   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_9199		;9164
L_9167:
	ld c,a			;9167   ; C = el mando
	ld a,(0e460h)		;9168   ; la opcion elegida...
	ld hl,09204h		;916b   ; ...su valor (tabla de p07:9204)
	add a,a			;916e
	call hl_mas_a		;916f   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;9172
	inc hl			;9173
	ld d,(hl)			;9174
	ex de,hl			;9175
	bit 2,c		;9176   ; bit 2: izquierda
	jr z,L_9188		;9178
	ld a,(hl)			;917a   ; ya en 0, nada
	and a			;917b
	jp z,L_9199		;917c
	dec (hl)			;917f   ; baja uno
	ld a,003h		;9180   ; con el sonido 3
	call pide_sonido		;9182   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_9199		;9185
L_9188:
	inc hl			;9188
	ld c,(hl)			;9189
	dec hl			;918a
	ld a,(hl)			;918b
	cp c			;918c
	jp z,L_9199		;918d
	inc (hl)			;9190
	ld a,003h		;9191
	call pide_sonido		;9193   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	jp L_9199		;9196
L_9199:
	xor a			;9199   ; borra las cuatro marcas del menu GAME MODIFY
	ld hl,038cfh		;919a
	call 0004dh		;919d   ; BIOS WRTVRM - Writes data in VRAM | la marca de 0x38CF
	xor a			;91a0   ; a cero
	ld hl,0390fh		;91a1
	call 0004dh		;91a4   ; BIOS WRTVRM - Writes data in VRAM | la de 0x390F
	xor a			;91a7   ; a cero
	ld hl,0394fh		;91a8
	call 0004dh		;91ab   ; BIOS WRTVRM - Writes data in VRAM | la de 0x394F
	xor a			;91ae   ; a cero
	ld hl,0398fh		;91af
	call 0004dh		;91b2   ; BIOS WRTVRM - Writes data in VRAM | y la de 0x398F
	ld a,(0e460h)		;91b5   ; lee la opcion elegida del GAME MODIFY
	ld hl,0920ch		;91b8   ; la posicion de la opcion elegida (tabla de p07:920C)...
	add a,a			;91bb
	call hl_mas_a		;91bc   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;91bf
	inc hl			;91c0
	ld d,(hl)			;91c1
	ex de,hl			;91c2
	ld a,08dh		;91c3   ; ...pinta la flecha (0x8D)
	call 0004dh		;91c5   ; BIOS WRTVRM - Writes data in VRAM
	ld a,(0e461h)		;91c8   ; el valor de LENGTH...
	ld bc,0e500h		;91cb   ; ...en el primer sprite de la copia...
	ld hl,09214h		;91ce   ; ...con la tabla de p07:9214
	call th_pon_palabra		;91d1   ; th_pon_palabra: escribe en HL la palabra A de la tabla y vuelca los sprites
	ld a,(0e463h)		;91d4   ; SPEED, en el segundo sprite (tabla de p07:921C)
	ld bc,0e504h		;91d7
	ld hl,0921ch		;91da
	call th_pon_palabra		;91dd   ; th_pon_palabra: escribe en HL la palabra A de la tabla y vuelca los sprites
	ld a,(0e465h)		;91e0   ; TYPE, en el tercero (tabla de p07:9226)
	ld bc,0e508h		;91e3
	ld hl,09226h		;91e6
	call th_pon_palabra		;91e9   ; th_pon_palabra: escribe en HL la palabra A de la tabla y vuelca los sprites
	ld a,(0e467h)		;91ec   ; BAR, en el cuarto (tabla de p07:922C)
	ld bc,0e50ch		;91ef
	ld hl,0922ch		;91f2
th_pon_palabra:		; escribe en HL la palabra A de la tabla y vuelca los sprites
	push bc			;91f5
	add a,a			;91f6
	call hl_mas_a		;91f7   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;91fa
	inc hl			;91fb
	ld d,(hl)			;91fc
	pop hl			;91fd
	ld (hl),e			;91fe
	inc hl			;91ff
	ld (hl),d			;9200
	jp th_vuelca_sprites		;9201   ; th_vuelca_sprites: vuelca a la tabla de sprites la copia de 0xE500

; ----------------------------------------------------------------------
; DATOS resto_9204: lo apuntan con el banco puesto p07:916B (0x9204), p07:91B8
;   (0x920C), p07:91CE (0x9214), p07:91DA (0x921C), p07:91E6 (0x9226),
;   p07:91F2 (0x922C); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:916B, p07:91B8, p07:91CE, p07:91DA, p07:91E6,
;   p07:91F2 (44 bytes)
;   0x9204..0x9230  (44 bytes)
DATA_resto_9204:
	defb 061h,0e4h,063h,0e4h,065h,0e4h,067h,0e4h,0cfh,038h,00fh,039h,04fh,039h,08fh,039h	; 9204  a.c.e.g..8.9O9.9
	defb 02fh,07fh,02fh,08fh,02fh,09fh,02fh,0afh,03fh,07fh,03fh,08fh,03fh,09fh,03fh,0afh	; 9214  /./././.?.?.?.?.
	defb 03fh,0bfh,04fh,07fh,04fh,08fh,04fh,09fh,05fh,07fh,05fh,08fh	; 9224  ?.O.O.O._._.

; ======================================================================
; CODIGO 0x9230..0x9386  (342 bytes)
; ======================================================================


th_aplica_opciones:		; copia LENGTH, SPEED, TYPE y BAR (0xE461...) a 0xE413...
	ld hl,0e461h		;9230   ; apunta a LENGTH, SPEED, TYPE y BAR (de dos en dos bytes: valor y tope)
	ld a,(hl)			;9233   ; LENGTH
	ld (0e413h),a		;9234   ; guarda LENGTH, el largo de la raqueta
	inc hl			;9237
	inc hl			;9238
	ld a,(hl)			;9239   ; SPEED
	ld (0e414h),a		;923a   ; guarda SPEED
	inc hl			;923d
	inc hl			;923e
	ld a,(hl)			;923f   ; TYPE
	ld (0e415h),a		;9240   ; guarda TYPE
	inc hl			;9243
	inc hl			;9244
	ld a,(hl)			;9245   ; BAR
	ld (0e416h),a		;9246   ; guarda hay barra en el centro
	xor a			;9249   ; el marcador a cero...
	ld (0e410h),a		;924a   ; guarda los tantos del jugador 1
	ld (0e411h),a		;924d   ; guarda los tantos del jugador 2
	ld (0e417h),a		;9250   ; ...los juegos, los sets...
	ld (0e418h),a		;9253
	ld (0e41bh),a		;9256
	ld (0e41ch),a		;9259
	ld (0e419h),a		;925c   ; guarda el tiempo del hockey (BCD)
	ld (0e41dh),a		;925f   ; ...quien saca...
	ld (0e41eh),a		;9262
	inc a			;9265   ; ...y el primero en sacar, el jugador 1
	ld (0e41ah),a		;9266
	ld a,(0e412h)		;9269   ; lee el juego: 1 tenis, 2 hockey
	dec a			;926c
	ld c,00eh		;926d   ; la musica del tenis (0x0E)...
	jr z,L_9273		;926f
	ld c,00fh		;9271   ; ...o la del hockey (0x0F)
L_9273:
	ld a,c			;9273
	jp pide_sonido		;9274   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
th_tanto:		; suma el tanto al jugador que toca
	ld a,(0e412h)		;9277   ; lee el juego: 1 tenis, 2 hockey
	dec a			;927a
	jp nz,L_92F7		;927b
	ld a,(0e409h)		;927e
	dec a			;9281
	ld hl,0e410h		;9282   ; apunta a los tantos del jugador 1
	ld de,0e417h		;9285
	jr z,L_9290		;9288
	ld hl,0e411h		;928a   ; apunta a los tantos del jugador 2
	ld de,0e41bh		;928d
L_9290:
	ld a,(hl)			;9290   ; el tanteo del juego (0x40 en el tenis: juego)
	cp 040h		;9291
	jr z,L_92A6		;9293
	and a			;9295   ; 0: 15
	ld c,015h		;9296
	jr z,L_92A2		;9298
	cp 015h		;929a   ; 0x15: 30
	ld c,015h		;929c
	jr z,L_92A2		;929e
	ld c,010h		;92a0   ; si no, 10 mas (0x30 -> 0x40)
L_92A2:
	add a,c			;92a2
	daa			;92a3
	ld (hl),a			;92a4
	ret			;92a5
L_92A6:
	ld a,(0e41ah)		;92a6   ; cambia el que saca
	xor 001h		;92a9
	ld (0e41ah),a		;92ab
	xor a			;92ae   ; los dos tantos a cero
	ld (0e410h),a		;92af   ; guarda los tantos del jugador 1
	ld (0e411h),a		;92b2   ; guarda los tantos del jugador 2
	ld a,(de)			;92b5   ; un juego mas al ganador (BCD)
	add a,001h		;92b6   ; BCD: un juego mas
	daa			;92b8
	ld (de),a			;92b9   ; guarda los juegos
	cp 006h		;92ba   ; hasta 6 juegos...
	ret c			;92bc
	push de			;92bd   ; ...el set: guarda los juegos de cada uno en 0xE580
	ld hl,0e417h		;92be   ; los juegos del jugador 1 (0xE417)...
	ld de,0e580h		;92c1   ; ...a la tabla de 0xE580, dos bytes por set
	ld a,(0e40ch)		;92c4   ; el set que se juega (0xE40C) x 2
	add a,a			;92c7
	call de_mas_a		;92c8   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	ldi		;92cb   ; los juegos del jugador 1
	ld hl,0e41bh		;92cd   ; los juegos del jugador 2 (0xE41B)
	ldi		;92d0   ; y los del 2
	xor a			;92d2   ; vuelven a cero
	ld (0e417h),a		;92d3
	ld (0e41bh),a		;92d6   ; los del jugador 2 tambien
	inc a			;92d9   ; 0xE41F = 1
	ld (0e41fh),a		;92da
	ld hl,0e40ch		;92dd   ; el set siguiente
	inc (hl)			;92e0
	pop de			;92e1   ; recupera los juegos del ganador
	inc de			;92e2   ; los sets ganados
	ld a,(de)			;92e3   ; sus sets
	cp 001h		;92e4   ; con uno, el partido
	jp z,L_92EC		;92e6
	inc a			;92e9   ; un set mas
	ld (de),a			;92ea
	ret			;92eb
L_92EC:
	ld a,(0e409h)		;92ec
	ld (0e41dh),a		;92ef
	xor a			;92f2
	ld (0e40ah),a		;92f3
	ret			;92f6
L_92F7:
	ld a,(0e409h)		;92f7
	dec a			;92fa
	ld hl,0e410h		;92fb   ; apunta a los tantos del jugador 1
	ld de,0e417h		;92fe
	jr z,L_9309		;9301
	ld hl,0e411h		;9303   ; apunta a los tantos del jugador 2
	ld de,0e41bh		;9306
L_9309:
	ld a,(hl)			;9309   ; el tanto en BCD, con tope 99
	cp 099h		;930a
	ret z			;930c
	add a,001h		;930d   ; uno mas
	daa			;930f
	ld (hl),a			;9310
	ld a,(0e41ah)		;9311   ; y cambia el que saca
	xor 001h		;9314
	ld (0e41ah),a		;9316
	ret			;9319
th_reloj:		; en hockey, baja el tiempo (0xE419, BCD) cada 64 cuadros
	ld a,(0e402h)		;931a   ; cada 64 cuadros (0xE402)
	and 03fh		;931d
	ret nz			;931f
	ld a,(0e419h)		;9320   ; el tiempo...
	sub 001h		;9323   ; ...baja un segundo (BCD)
	daa			;9325
	ld (0e419h),a		;9326   ; guarda el tiempo del hockey (BCD)
	push af			;9329
	cp 010h		;932a   ; a los 10...
	ld a,014h		;932c   ; ...el sonido 0x14, el aviso
	call z,pide_sonido		;932e   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	pop af			;9331
	push af			;9332
	and a			;9333   ; a 0...
	jr nz,L_933C		;9334
	ld a,01fh		;9336   ; ...el canal 2 del sonido a 0x1F
	ld hl,0e28ah		;9338
	ld (hl),a			;933b
L_933C:
	pop af			;933c
	push af			;933d
	call th_tiempo		;933e   ; th_tiempo: en hockey, pinta el tiempo (0xE419)
	pop af			;9341
	and a			;9342
	ret nz			;9343
	ld c,000h		;9344
	ld a,(0e410h)		;9346   ; lee los tantos del jugador 1
	ld hl,0e411h		;9349   ; apunta a los tantos del jugador 2
	cp (hl)			;934c
	jr z,L_9354		;934d
	ld c,001h		;934f
	jr nc,L_9354		;9351
	inc c			;9353
L_9354:
	ld a,c			;9354
	ld (0e41dh),a		;9355
	xor a			;9358
	ld (0e40ah),a		;9359
	ret			;935c
th_gol:		; mira si la pelota sale por un lado y de quien es el tanto
	ld a,(0e412h)		;935d   ; lee el juego: 1 tenis, 2 hockey
	dec a			;9360
	jp nz,L_937B		;9361
L_9364:
	ld a,(0e443h)		;9364   ; lee la columna de la pelota (0x78 es el centro)
	cp 006h		;9367
	ld c,001h		;9369
	jr c,L_9371		;936b
	inc c			;936d
	cp 0ech		;936e
	ret c			;9370
L_9371:
	ld a,c			;9371
	ld (0e409h),a		;9372
	ld a,009h		;9375
	call pide_sonido		;9377   ; pide_sonido: pide el sonido A al motor (con las interrupciones cerradas)
	ret			;937a
L_937B:
	ld a,(0e441h)		;937b   ; lee la altura de la pelota
	cp 04ah		;937e
	ret c			;9380
	cp 076h		;9381
	ret nc			;9383
	jr L_9364		;9384

; ----------------------------------------------------------------------
; DATOS resto_9386: lo apuntan con el banco puesto p07:9085 (0x9386), p07:908E
;   (0x951D), p07:9094 (0x9535), p07:899F (0x95BC), p07:89A4 (0x987C); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:9085, p07:908E, p07:9094, p07:899F, p07:89A4 (1974 bytes)
;   0x9386..0x9b3c  (1974 bytes)
DATA_resto_9386:
	defb 010h,07fh,0a0h,050h,0a7h,05ch,0b3h,02fh,069h,054h,056h,00ah,0e5h,03ah,0cdh,0f4h	; 9386  ...P.\./iTV..:..
	defb 096h,02ah,06ah,056h,054h,069h,02fh,0b3h,05ch,0a7h,050h,06ah,02ah,096h,0f4h,0cdh	; 9396  .*jVTi/.\.Pj*...
	defb 03ah,0e5h,00ah,006h,000h,082h,0a7h,050h,006h,000h,082h,0e5h,00ah,006h,000h,082h	; 93a6  :......P........
	defb 054h,056h,006h,000h,0a2h,02ah,06ah,035h,052h,085h,0c8h,017h,0a8h,049h,0abh,0ach	; 93b6  TV...*j5R....I..
	defb 04ah,0a1h,013h,0e8h,015h,092h,0d5h,0abh,049h,0a8h,017h,0c8h,085h,052h,035h,0d5h	; 93c6  J.......I....R5.
	defb 092h,015h,0e8h,013h,0a1h,04ah,0ach,006h,000h,082h,052h,035h,006h,000h,086h,04ah	; 93d6  .....J....R5...J
	defb 0ach,000h,000h,03eh,07fh,008h,063h,082h,07fh,03eh,004h,000h,002h,00ch,002h,01ch	; 93e6  ...>..c..>......
	defb 006h,00ch,002h,01eh,004h,000h,08ch,03eh,07fh,063h,063h,003h,00fh,03eh,078h,060h	; 93f6  .......>.cc..>x`
	defb 063h,07fh,07fh,004h,000h,08ch,03eh,07fh,063h,063h,003h,00eh,00eh,003h,063h,063h	; 9406  c.....>.cc....cc
	defb 07fh,03eh,004h,000h,08ch,006h,00eh,00eh,01eh,01eh,03eh,036h,07fh,07fh,006h,00fh	; 9416  .>........>6....
	defb 00fh,004h,000h,002h,07fh,002h,060h,088h,07eh,07fh,003h,003h,063h,063h,07fh,03eh	; 9426  ......`.~...cc.>
	defb 004h,000h,087h,03eh,07fh,063h,063h,060h,07eh,07fh,003h,063h,082h,07fh,03eh,004h	; 9436  ...>.cc`~..c..>.
	defb 000h,002h,07fh,002h,063h,083h,007h,00eh,01ch,005h,018h,004h,000h,082h,03eh,07fh	; 9446  ....c.........>.
	defb 003h,063h,002h,03eh,003h,063h,082h,07fh,03eh,004h,000h,082h,03eh,07fh,003h,063h	; 9456  .c.>.c..>...>..c
	defb 087h,07fh,03fh,003h,063h,063h,07fh,03eh,004h,000h,082h,07eh,07fh,003h,063h,082h	; 9466  ..?.cc.>...~..c.
	defb 07fh,07eh,005h,060h,004h,000h,08ch,03eh,07fh,063h,063h,060h,07eh,03fh,003h,063h	; 9476  .~.`...>.cc`~?.c
	defb 063h,07fh,03eh,004h,000h,087h,03eh,07fh,063h,063h,060h,06fh,06fh,003h,063h,082h	; 9486  c.>...>.cc`oo.c.
	defb 07fh,03eh,004h,000h,002h,07eh,00ah,018h,002h,000h,003h,03eh,006h,000h,08bh,020h	; 9496  .>...~.....>...
	defb 030h,038h,03ch,038h,030h,020h,000h,000h,063h,077h,003h,07fh,081h,06bh,006h,063h	; 94a6  08<80 ..cw...k.c
	defb 004h,000h,002h,07fh,003h,060h,002h,07eh,003h,060h,002h,07fh,004h,000h,002h,03ch	; 94b6  .....`.~.`.....<
	defb 008h,018h,002h,03ch,005h,000h,085h,01fh,018h,014h,012h,011h,003h,000h,081h,0ffh	; 94c6  ...<............
	defb 007h,000h,081h,0ffh,004h,010h,003h,000h,081h,0f0h,00fh,010h,081h,01fh,004h,010h	; 94d6  ................
	defb 084h,090h,050h,030h,0ffh,007h,010h,081h,0ffh,007h,010h,081h,0f0h,007h,010h,081h	; 94e6  ..P0............
	defb 01fh,004h,000h,003h,010h,081h,0ffh,004h,000h,003h,010h,081h,0f0h,004h,000h,089h	; 94f6  ................
	defb 080h,040h,020h,010h,008h,004h,002h,001h,000h,004h,018h,002h,000h,084h,018h,063h	; 9506  .@ ............c
	defb 07fh,07fh,003h,063h,002h,000h,000h,081h,0f5h,006h,075h,082h,040h,0fah,006h,0bah	; 9516  ...c......u.@...
	defb 081h,090h,040h,040h,030h,060h,07fh,0f0h,07fh,0f0h,07fh,0f0h,01bh,0f0h,000h,000h	; 9526  ..@@0`..........
	defb 018h,005h,000h,081h,003h,004h,007h,081h,003h,00ah,000h,086h,0c0h,060h,0a0h,0a0h	; 9536  .............`..
	defb 0e0h,0c0h,009h,000h,082h,003h,001h,004h,003h,082h,001h,003h,008h,000h,082h,0c0h	; 9546  ................
	defb 080h,004h,0c0h,082h,080h,0c0h,004h,000h,082h,003h,001h,00ch,003h,084h,001h,003h	; 9556  ................
	defb 0c0h,080h,00ch,0c0h,082h,080h,0c0h,008h,000h,082h,003h,001h,006h,003h,008h,000h	; 9566  ................
	defb 082h,0c0h,080h,006h,0c0h,00eh,003h,082h,001h,003h,00eh,0c0h,084h,080h,0c0h,003h	; 9576  ................
	defb 001h,00eh,003h,082h,0c0h,080h,00eh,0c0h,002h,007h,082h,000h,007h,00ch,005h,002h	; 9586  ................
	defb 0e0h,081h,000h,00dh,0e0h,010h,005h,010h,0e0h,00ch,005h,084h,007h,000h,007h,007h	; 9596  ................
	defb 00dh,0e0h,084h,000h,0e0h,0e0h,0ffh,00ah,080h,081h,0ffh,004h,000h,081h,0f0h,00ah	; 95a6  ................
	defb 010h,081h,0f0h,004h,000h,000h,000h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 95b6  .......aaaaaaaaa
	defb 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 95c6  aaaaaaaaaaaaaaaa
	defb 061h,061h,061h,061h,061h,000h,000h,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh	; 95d6  aaaaa..onononono
	defb 06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh,06eh,06fh	; 95e6  nononononononono
	defb 06eh,06fh,06eh,06fh,06eh,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 95f6  nonon..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9606  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9616  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9626  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9636  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9646  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9656  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9666  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9676  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9686  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9696  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96a6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96b6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96c6  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96d6  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 96e6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 96f6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9706  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9716  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9726  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9736  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9746  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9756  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9766  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9776  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9786  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9796  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97a6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97b6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97c6  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97d6  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 97e6  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 97f6  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9806  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9816  jkjkj..mlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh,06ch,06dh	; 9826  lmlmlmlmlmlmlmlm
	defb 06ch,06dh,06ch,06dh,06ch,000h,000h,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9836  lmlml..kjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh,06ah,06bh	; 9846  jkjkjkjkjkjkjkjk
	defb 06ah,06bh,06ah,06bh,06ah,000h,000h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 9856  jkjkj..aaaaaaaaa
	defb 061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h,061h	; 9866  aaaaaaaaaaaaaaaa
	defb 061h,061h,061h,061h,061h,000h,000h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9876  aaaaa..`````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9886  ````````````````
	defb 060h,060h,060h,060h,060h,000h,000h,060h,066h,067h,066h,067h,066h,067h,066h,067h	; 9896  `````..`fgfgfgfg
	defb 066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h,066h,067h	; 98a6  fgfgfgfgfgfgfgfg
	defb 066h,067h,066h,067h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 98b6  fgfg`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 98c6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 98d6  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 98e6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 98f6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9906  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9916  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9926  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9936  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9946  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,060h,060h,060h,060h,064h,065h,064h,065h	; 9956  bcbc`..`````dede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9966  dededededededede
	defb 060h,060h,060h,060h,060h,000h,000h,069h,068h,069h,068h,069h,062h,063h,062h,063h	; 9976  `````..ihihibcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9986  bcbcbcbcbcbcbcbc
	defb 069h,068h,069h,068h,069h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9996  ihihi..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99a6  dededededededede
	defb 064h,065h,064h,065h,064h,000h,000h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99b6  deded..cbcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99c6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,062h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99d6  bcbcb..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 99e6  dededededededede
	defb 064h,065h,064h,065h,064h,000h,000h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 99f6  deded..cbcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a06  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,062h,000h,000h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a16  bcbcb..edededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a26  dededededededede
	defb 064h,065h,064h,065h,065h,000h,000h,060h,060h,060h,060h,060h,062h,063h,062h,063h	; 9a36  dedee..`````bcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a46  bcbcbcbcbcbcbcbc
	defb 060h,060h,060h,060h,060h,000h,000h,060h,066h,067h,066h,067h,064h,065h,064h,065h	; 9a56  `````..`fgfgdede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a66  dededededededede
	defb 067h,066h,067h,066h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a76  gfgf`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9a86  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9a96  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9aa6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9ab6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9ac6  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,064h,065h,064h,065h,064h,065h,064h,065h	; 9ad6  bcbc`..`dededede
	defb 064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h,064h,065h	; 9ae6  dededededededede
	defb 064h,065h,064h,065h,060h,000h,000h,060h,062h,063h,062h,063h,062h,063h,062h,063h	; 9af6  dede`..`bcbcbcbc
	defb 062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h,062h,063h	; 9b06  bcbcbcbcbcbcbcbc
	defb 062h,063h,062h,063h,060h,000h,000h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9b16  bcbc`..`````````
	defb 060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h,060h	; 9b26  ````````````````
	defb 060h,060h,060h,060h,060h,000h	; 9b36

; ======================================================================
; CODIGO 0x9b3c..0x9beb  (175 bytes)
; ======================================================================


pide_sonido:		; pide el sonido A al motor (con las interrupciones cerradas)
	di			;9b3c   ; sin interrupciones, guardando todos los registros
	push ix		;9b3d
	push iy		;9b3f
	push hl			;9b41
	push de			;9b42
	push bc			;9b43
	push af			;9b44
	call pide_sonido_b		;9b45   ; pide el sonido
	pop af			;9b48
	pop bc			;9b49
	pop de			;9b4a
	pop hl			;9b4b
	pop iy		;9b4c
	pop ix		;9b4e
	ei			;9b50   ; y las vuelve a abrir
	ret			;9b51
pide_sonido_b:		; pone en sus canales las pistas del sonido A (tabla de p07:9BF5)
	ld c,a			;9b52   ; C = el sonido
	ld hl,0e2ddh		;9b53   ; apunta a el sonido pedido
	ld (hl),c			;9b56
	ld hl,09bf5h		;9b57   ; su ficha, en la tabla de p07:9BF5
	ld a,c			;9b5a
	add a,c			;9b5b
	ld e,a			;9b5c
	ld d,000h		;9b5d
	add hl,de			;9b5f
	ld e,(hl)			;9b60
	inc hl			;9b61
	ld d,(hl)			;9b62
	ex de,hl			;9b63
	ld de,0e2deh		;9b64   ; copia sus 12 bytes a 0xE2DE: los canales que usa y sus pistas
	ld bc,0000ch		;9b67
	ldir		;9b6a
	ld ix,0e2e0h		;9b6c   ; IX = las pistas
	ld hl,0e2deh		;9b70   ; bit 7: usa el canal 1
	bit 7,(hl)		;9b73
	jp z,L_9B84		;9b75
	inc hl			;9b78
	ld a,(hl)			;9b79   ; la prioridad
	ld hl,0e201h		;9b7a   ; el canal 1 (0xE201)
	call canal_libre		;9b7d   ; se pone si puede
	inc ix		;9b80   ; la pista siguiente
	inc ix		;9b82
L_9B84:
	ld hl,0e2deh		;9b84
	bit 6,(hl)		;9b87
	jp z,L_9B98		;9b89
	inc hl			;9b8c
	ld a,(hl)			;9b8d
	ld hl,0e22dh		;9b8e
	call canal_libre		;9b91   ; canal_libre: pone la pista en el canal si su prioridad no es menor
	inc ix		;9b94
	inc ix		;9b96
L_9B98:
	ld hl,0e2deh		;9b98
	bit 5,(hl)		;9b9b
	jp z,L_9BAC		;9b9d
	inc hl			;9ba0
	ld a,(hl)			;9ba1
	ld hl,0e259h		;9ba2
	call canal_libre		;9ba5   ; canal_libre: pone la pista en el canal si su prioridad no es menor
	inc ix		;9ba8
	inc ix		;9baa
L_9BAC:
	ld hl,0e2deh		;9bac
	bit 4,(hl)		;9baf
	jp z,L_9BC0		;9bb1
	inc hl			;9bb4
	ld a,(hl)			;9bb5
	ld hl,0e285h		;9bb6
	call canal_libre		;9bb9   ; canal_libre: pone la pista en el canal si su prioridad no es menor
	inc ix		;9bbc
	inc ix		;9bbe
L_9BC0:
	ld hl,0e2deh		;9bc0   ; bit 3: usa el canal 5
	bit 3,(hl)		;9bc3
	ret z			;9bc5
	inc hl			;9bc6   ; la prioridad
	ld a,(hl)			;9bc7
	ld hl,0e2b1h		;9bc8   ; el canal 5 (0xE2B1)
canal_libre:		; pone la pista en el canal si su prioridad no es menor
	ld b,(hl)			;9bcb   ; la prioridad del canal
	cp b			;9bcc   ; si la del sonido es menor, no entra
	ret c			;9bcd
	ex de,hl			;9bce
	ld (de),a			;9bcf   ; la nueva prioridad
	dec de			;9bd0
	ld hl,0e2ddh		;9bd1   ; apunta a el sonido pedido
	ld a,(hl)			;9bd4   ; el sonido
	ld (de),a			;9bd5
	inc de			;9bd6
	inc de			;9bd7
	ld a,(ix+000h)		;9bd8   ; la direccion de la pista...
	ld (de),a			;9bdb
	inc de			;9bdc
	ld a,(ix+001h)		;9bdd   ; ...que trae IX
	ld (de),a			;9be0
	inc de			;9be1
	ld hl,09bebh		;9be2   ; y el resto del canal desde p07:9BEB (12 bytes)
	ld bc,0000ch		;9be5
	ldir		;9be8
	ret			;9bea

; ----------------------------------------------------------------------
; DATOS resto_9BEB: lo apuntan con el banco puesto p07:9BE2 (0x9BEB), p07:9B57
;   (0x9BF5); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p07:9BE2, p07:9B57 (186 bytes)
;   0x9beb..0x9ca5  (186 bytes)
DATA_resto_9BEB:
	defb 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,01fh,09ch,029h,09ch	; 9beb  ..............).
	defb 02dh,09ch,031h,09ch,035h,09ch,039h,09ch,03dh,09ch,041h,09ch,045h,09ch,049h,09ch	; 9bfb  -.1.5.9.=.A.E.I.
	defb 04dh,09ch,055h,09ch,05dh,09ch,065h,09ch,06fh,09ch,079h,09ch,083h,09ch,08dh,09ch	; 9c0b  M.U.].e.o.y.....
	defb 097h,09ch,0a1h,09ch,0f0h,080h,057h,0a4h,057h,0a4h,057h,0a4h,057h,0a4h,010h,040h	; 9c1b  ......W.W.W.W..@
	defb 02eh,0adh,010h,040h,047h,0adh,010h,040h,064h,0adh,010h,040h,0abh,0adh,010h,030h	; 9c2b  ...@G..@d..@...0
	defb 0eah,0adh,010h,040h,02dh,0aeh,010h,040h,060h,0aeh,010h,050h,093h,0aeh,010h,040h	; 9c3b  ...@-..@`..P...@
	defb 0a6h,0aeh,0e0h,020h,058h,0a4h,026h,0a5h,091h,0a5h,0e0h,020h,008h,0a6h,0a1h,0a6h	; 9c4b  ... X.&.... ....
	defb 08dh,0a7h,0e0h,020h,042h,0a8h,070h,0a8h,0a5h,0a8h,0f0h,070h,0d0h,0a8h,021h,0a9h	; 9c5b  ... B.p....p..!.
	defb 051h,0a9h,057h,0a4h,0f0h,070h,089h,0a9h,0c0h,0a9h,00ah,0aah,057h,0a4h,0f0h,070h	; 9c6b  Q.W..p......W..p
	defb 052h,0aah,099h,0aah,0e1h,0aah,057h,0a4h,0f0h,070h,029h,0abh,069h,0abh,097h,0abh	; 9c7b  R.....W..p).i...
	defb 057h,0a4h,0f0h,070h,0d8h,0abh,006h,0ach,034h,0ach,057h,0a4h,0f0h,070h,061h,0ach	; 9c8b  W..p....4.W..pa.
	defb 0a4h,0ach,0e1h,0ach,057h,0a4h,010h,060h,0dbh,0aeh	; 9c9b  ....W..`..

; ======================================================================
; CODIGO 0x9ca5..0x9d6f  (202 bytes)
; ======================================================================


sonido_cuadro:		; el motor de sonido: un cuadro de los cinco canales
	ld a,(0e2eeh)		;9ca5
	call 0a3bdh		;9ca8   ; pon_mezclador: escribe A en R#7 del PSG y en 0xE2EE
	ld a,001h		;9cab
	ld (0e2efh),a		;9cad   ; guarda el canal que se esta tocando
	ld ix,0e200h		;9cb0   ; apunta a los canales del motor de sonido (0x2C bytes cada uno)
	call canal_cuadro		;9cb4   ; canal_cuadro: un cuadro del canal IX si esta activo
	ld a,002h		;9cb7
	ld (0e2efh),a		;9cb9   ; guarda el canal que se esta tocando
	ld ix,0e22ch		;9cbc
	call canal_cuadro		;9cc0   ; canal_cuadro: un cuadro del canal IX si esta activo
	ld a,004h		;9cc3
	ld (0e2efh),a		;9cc5   ; guarda el canal que se esta tocando
	ld ix,0e258h		;9cc8
	call canal_cuadro		;9ccc   ; canal_cuadro: un cuadro del canal IX si esta activo
	ld a,008h		;9ccf
	ld (0e2efh),a		;9cd1   ; guarda el canal que se esta tocando
	ld ix,0e284h		;9cd4
	call canal_cuadro		;9cd8   ; canal_cuadro: un cuadro del canal IX si esta activo
	call 0a291h		;9cdb   ; sonido_mezcla: decide que canales van al PSG segun sus prioridades
	ret			;9cde
canal_cuadro:		; un cuadro del canal IX si esta activo
	ld a,(ix+000h)		;9cdf
	or a			;9ce2
	call nz,canal_nota		;9ce3   ; canal_nota: baja la duracion; si acaba, lee la orden siguiente de la pista
	ret			;9ce6
canal_nota:		; baja la duracion; si acaba, lee la orden siguiente de la pista
	dec (ix+004h)		;9ce7
	jp nz,L_9E6D		;9cea
	ld l,(ix+002h)		;9ced
	ld h,(ix+003h)		;9cf0
canal_ordenes:		; lee las ordenes de la pista (0xD0-0xFE) hasta una nota; 0xFF acaba
	ld a,(hl)			;9cf3
	cp 0ffh		;9cf4
	jp z,L_9FC1		;9cf6
	cp 0d0h		;9cf9
	jp c,L_9D05		;9cfb
	call 0a029h		;9cfe   ; canal_orden: una orden de la pista (0xE0-0xFF) por la tabla de p08:A03E, o una nota
	inc hl			;9d01
	jp canal_ordenes		;9d02   ; canal_ordenes: lee las ordenes de la pista (0xD0-0xFE) hasta una nota; 0xFF acaba
L_9D05:
	bit 0,(ix+009h)		;9d05
	jp nz,canal_duracion		;9d09   ; canal_duracion: la duracion de la nota: la parte baja por el tempo (ix+0x14)
	bit 1,(ix+009h)		;9d0c
	jp nz,L_9D7B		;9d10
	ld a,(ix+009h)		;9d13
	and 03ch		;9d16
	jp nz,L_9DED		;9d18
	ret			;9d1b
canal_duracion:		; la duracion de la nota: la parte baja por el tempo (ix+0x14)
	ld a,(hl)			;9d1c   ; la duracion: la parte baja de la nota...
	and 00fh		;9d1d
	ld b,a			;9d1f
	ld a,(ix+014h)		;9d20   ; ...por el tempo (ix+0x14)
	jp z,L_9D2A		;9d23
	ld e,a			;9d26
L_9D27:
	add a,e			;9d27
	djnz L_9D27		;9d28
L_9D2A:
	ld (ix+004h),a		;9d2a   ; la duracion del canal (ix+0x04)
	ld a,(hl)			;9d2d   ; la nota: la parte alta
	and 0f0h		;9d2e   ; la parte alta: la nota
	rrca			;9d30
	rrca			;9d31
	rrca			;9d32
	rrca			;9d33
	call canal_avanza		;9d34   ; la pista avanza
	bit 7,(ix+009h)		;9d37   ; bit 7: silencio
	ret nz			;9d3b
	cp 00ch		;9d3c   ; 0x0C y mas: no es una nota
	jp nc,L_9D6A		;9d3e
	ld hl,09d6fh		;9d41   ; la frecuencia de la nota en la tabla de p07:9D6F
	ld e,a			;9d44   ; E = la nota
	ld d,000h		;9d45
	add hl,de			;9d47
	ld l,(hl)			;9d48   ; HL = la frecuencia base
	ld h,000h		;9d49
	ld a,(ix+016h)		;9d4b   ; la octava (ix+0x16)...
	or a			;9d4e
	jp z,L_9D56		;9d4f
	ld b,a			;9d52   ; ...divide la frecuencia
L_9D53:
	add hl,hl			;9d53
	djnz L_9D53		;9d54
L_9D56:
	ld (ix+010h),l		;9d56
	ld (ix+011h),h		;9d59
	ld e,(ix+015h)		;9d5c
	ld (ix+012h),e		;9d5f
	ld (ix+00dh),002h		;9d62
	call canal_empieza_nota		;9d66   ; canal_empieza_nota: empieza la nota: frecuencia y envolvente a cero
	ret			;9d69
L_9D6A:
	ld (ix+00dh),000h		;9d6a
	ret			;9d6e

; ----------------------------------------------------------------------
; DATOS resto_9D6F: lo apuntan con el banco puesto p07:9D41 (0x9D6F); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p07:9D41 (12 bytes)
;   0x9d6f..0x9d7b  (12 bytes)
DATA_resto_9D6F:
	defb 06ah,064h,05eh,059h,054h,04fh,04ah,046h,042h,03fh,03bh,038h	; 9d6f  jd^YTOJFB?.8

; ======================================================================
; CODIGO 0x9d7b..0x9ffe  (643 bytes)
; ======================================================================


L_9D7B:
	ld a,(ix+00dh)		;9d7b   ; el modo del canal (ix+0x0D)
	and 003h		;9d7e
	jp z,L_9DDE		;9d80   ; 0: tono
	cp 001h		;9d83   ; 1: ...
	jp z,L_9DC3		;9d85   ; 1: ruido
	ld a,(hl)			;9d88   ; el byte de la orden
	bit 6,(ix+00eh)		;9d89   ; bit 6...
	jp nz,L_9DAD		;9d8d
	bit 5,(ix+00eh)		;9d90   ; ...o bit 5 del estado
	jp nz,L_9DB3		;9d94
	and 0f0h		;9d97   ; la parte alta del byte
	ld b,a			;9d99   ; la baja con lo que quede: la parte alta de la frecuencia
	xor (hl)			;9d9a   ; la baja
	ld d,a			;9d9b
	inc hl			;9d9c   ; el byte siguiente...
	ld a,(hl)			;9d9d
	ld (ix+010h),a		;9d9e   ; ...la parte baja de la frecuencia
	ld (ix+011h),d		;9da1
	ld a,b			;9da4   ; la octava
	rrca			;9da5   ; a los 4 bits bajos
	rrca			;9da6
	rrca			;9da7
	rrca			;9da8
	ld b,a			;9da9
	jp L_9DC7		;9daa
L_9DAD:
	ld (ix+010h),a		;9dad
	jp L_9DD5		;9db0
L_9DB3:
	and 0f0h		;9db3   ; la parte alta del byte...
	rrca			;9db5
	rrca			;9db6
	rrca			;9db7
	rrca			;9db8
	ld b,a			;9db9   ; ...la octava
	ld a,(hl)			;9dba   ; la baja...
	and 00fh		;9dbb
	ld (ix+011h),a		;9dbd   ; ...la parte alta de la frecuencia
	jp L_9DC7		;9dc0
L_9DC3:
	ld a,(hl)			;9dc3
	and 00fh		;9dc4
	ld b,a			;9dc6
L_9DC7:
	bit 2,(ix+00dh)		;9dc7
	jp z,L_9DD0		;9dcb
	ld b,010h		;9dce
L_9DD0:
	inc b			;9dd0
	inc b			;9dd1
	ld (ix+012h),b		;9dd2
L_9DD5:
	ld e,(ix+012h)		;9dd5
	ld (ix+012h),e		;9dd8
	call canal_empieza_nota		;9ddb   ; canal_empieza_nota: empieza la nota: frecuencia y envolvente a cero
L_9DDE:
	bit 7,(ix+009h)		;9dde
	ret nz			;9de2
	call canal_avanza		;9de3   ; canal_avanza: avanza el puntero de la pista (ix+0x02)
	ld a,(ix+013h)		;9de6
	ld (ix+004h),a		;9de9
	ret			;9dec
L_9DED:
	set 7,(ix+009h)		;9ded   ; silencio
	call canal_duracion		;9df1   ; su duracion
	ld hl,0a3dah		;9df4   ; el sonido de ruido de la tabla de p08:A3DA
	add a,a			;9df7
	ld e,a			;9df8
	ld d,000h		;9df9
	add hl,de			;9dfb
	ld e,(hl)			;9dfc
	inc hl			;9dfd
	ld d,(hl)			;9dfe
	ex de,hl			;9dff
	ld a,(hl)			;9e00
canal_bucle:		; repeticion: guarda donde vuelve (ix+0x17)
	set 1,(ix+009h)		;9e01   ; apunta que se lee la repeticion
	call canal_ordenes		;9e05   ; las ordenes que la abren
	res 1,(ix+009h)		;9e08   ; y vuelve al modo normal
	res 7,(ix+009h)		;9e0c
	ld a,(ix+013h)		;9e10   ; el contador de la repeticion
	ld (ix+019h),a		;9e13
	inc hl			;9e16   ; donde empieza...
	ld (ix+017h),l		;9e17   ; ...a (ix+0x17)
	ld (ix+018h),h		;9e1a
	set 0,(ix+00eh)		;9e1d   ; y la enciende
	ret			;9e21
canal_empieza_nota:		; empieza la nota: frecuencia y envolvente a cero
	call canal_frecuencia		;9e22   ; canal_frecuencia: la frecuencia de la nota (ix+0x10) con el desplazamiento (ix+0x26) a (ix+0x0A)
	res 4,(ix+00eh)		;9e25   ; sin vibrato aun
	ld a,(ix+00fh)		;9e29   ; la envolvente empieza...
	and 0d7h		;9e2c
	ld (ix+00fh),a		;9e2e
	xor a			;9e31   ; ...los contadores a cero
	ld (ix+01dh),a		;9e32
	ld (ix+01eh),a		;9e35
	ld (ix+01fh),a		;9e38
	ld (ix+020h),a		;9e3b
	set 2,(ix+00fh)		;9e3e   ; fase sostenida
	ld a,(ix+012h)		;9e42   ; el volumen maximo
	bit 7,(ix+00eh)		;9e45   ; bit 7: con atenuacion...
	jp z,L_9E53		;9e49
	ld e,(ix+015h)		;9e4c   ; ...resta (ix+0x15)
	sub e			;9e4f
	call m,a_cero		;9e50   ; sin bajar de 0
L_9E53:
	ld (ix+00ch),a		;9e53   ; el volumen del canal (ix+0x0C)
	bit 2,(ix+00dh)		;9e56   ; bit 2 del modo: sin envolvente
	ret nz			;9e5a
	bit 1,(ix+00fh)		;9e5b   ; bit 1 de (ix+0x0F): el volumen fijo
	ret z			;9e5f
	ld a,(ix+025h)		;9e60   ; de (ix+0x25)
	ld (ix+00ch),a		;9e63
	res 2,(ix+00fh)		;9e66
	ret			;9e6a
a_cero:		; A = 0 y Z
	xor a			;9e6b
	ret			;9e6c
L_9E6D:
	bit 0,(ix+00eh)		;9e6d
	jp nz,L_9E8D		;9e71
	bit 2,(ix+00eh)		;9e74
	call nz,canal_vibrato		;9e78   ; canal_vibrato: el contador del vibrato (ix+0x1E) segun los bits de (ix+0x0E)
	bit 0,(ix+00fh)		;9e7b
	call nz,canal_volumen_si		;9e7f   ; canal_volumen_si: el volumen del canal salvo si (ix+0x0D) lleva el bit 2
	ld a,(0e2efh)		;9e82   ; lee el canal que se esta tocando
	cp 004h		;9e85
	ret nz			;9e87
	xor a			;9e88
	ld (0e2f7h),a		;9e89
	ret			;9e8c
L_9E8D:
	dec (ix+019h)		;9e8d
	ret nz			;9e90
	ld l,(ix+017h)		;9e91
	ld h,(ix+018h)		;9e94
	ld a,(hl)			;9e97
	cp 0ffh		;9e98
	jp z,L_9EA5		;9e9a
	set 7,(ix+009h)		;9e9d
	call canal_bucle		;9ea1   ; canal_bucle: repeticion: guarda donde vuelve (ix+0x17)
	ret			;9ea4
L_9EA5:
	res 0,(ix+00eh)		;9ea5
	xor a			;9ea9
	ld (ix+00ch),a		;9eaa
	ld (ix+00dh),a		;9ead
	ret			;9eb0
canal_frecuencia:		; la frecuencia de la nota (ix+0x10) con el desplazamiento (ix+0x26) a (ix+0x0A)
	ld e,(ix+010h)		;9eb1   ; la frecuencia de la nota
	ld d,(ix+011h)		;9eb4
	bit 1,(ix+00eh)		;9eb7   ; si hay desplazamiento (bit 1)...
	jp z,L_9EC7		;9ebb
	ld a,(ix+026h)		;9ebe   ; ...se suma (ix+0x26)
	add a,e			;9ec1
	ld e,a			;9ec2
	jp nc,L_9EC7		;9ec3
	inc d			;9ec6
L_9EC7:
	ld (ix+00ah),e		;9ec7
	ld (ix+00bh),d		;9eca
	ret			;9ecd
canal_vibrato:		; el contador del vibrato (ix+0x1E) segun los bits de (ix+0x0E)
	inc (ix+01eh)		;9ece   ; el contador del vibrato
	ld a,(ix+01eh)		;9ed1
	ld b,(ix+00eh)		;9ed4
	bit 4,b		;9ed7   ; bit 4: ya esta vibrando
	jp nz,L_9EF0		;9ed9
	bit 3,b		;9edc   ; bit 3: hay vibrato
	jp z,L_9EF0		;9ede
	cp (ix+01ah)		;9ee1   ; hasta que llega su retraso (ix+0x1A)
	ret nz			;9ee4
	ld (ix+01eh),000h		;9ee5   ; entonces empieza
	set 4,(ix+00eh)		;9ee9
	jp L_9EF4		;9eed
L_9EF0:
	cp (ix+01bh)		;9ef0
	ret nz			;9ef3
L_9EF4:
	ld e,(ix+00ah)		;9ef4   ; la frecuencia que suena
	ld d,(ix+00bh)		;9ef7
	ld b,(ix+01ch)		;9efa   ; la amplitud del vibrato
	ld a,(ix+01dh)		;9efd   ; el sentido (ix+0x1D)...
	cpl			;9f00   ; ...cambia en cada cuadro
	ld (ix+01dh),a		;9f01
	and a			;9f04
	ld a,e			;9f05
	jp nz,L_9F12		;9f06
	add a,b			;9f09   ; arriba: suma la amplitud
	ld e,a			;9f0a
	jp nc,L_9F18		;9f0b
	inc d			;9f0e
	jp L_9F18		;9f0f
L_9F12:
	sub b			;9f12
	ld e,a			;9f13
	jp nc,L_9F18		;9f14
	dec d			;9f17
L_9F18:
	ld (ix+00ah),e		;9f18
	ld (ix+00bh),d		;9f1b
	ld (ix+01eh),000h		;9f1e
	ret			;9f22
canal_volumen_si:		; el volumen del canal salvo si (ix+0x0D) lleva el bit 2
	bit 2,(ix+00dh)		;9f23
	ret nz			;9f27
	call canal_volumen		;9f28   ; canal_volumen: el volumen del canal segun la envolvente de (ix+0x0F)
	ld (ix+00ch),e		;9f2b
	ret			;9f2e
canal_volumen:		; el volumen del canal segun la envolvente de (ix+0x0F)
	ld e,(ix+00ch)		;9f2f   ; el volumen
	inc (ix+01fh)		;9f32   ; el contador de la envolvente
	ld b,(ix+01fh)		;9f35
	bit 5,(ix+00fh)		;9f38   ; bit 5: fase de caida final
	jp nz,L_9FAD		;9f3c
	bit 3,(ix+00fh)		;9f3f   ; bit 3: fase de caida
	jp nz,L_9F74		;9f43
	bit 2,(ix+00fh)		;9f46   ; bit 2: fase sostenida
	jp nz,L_9F60		;9f4a
	ld a,e			;9f4d   ; subida: uno mas...
	inc a			;9f4e
	ld e,a			;9f4f
	cp (ix+012h)		;9f50   ; ...hasta el volumen maximo (ix+0x12)
	ret c			;9f53
	set 2,(ix+00fh)		;9f54   ; entonces pasa a sostenido
	ld e,(ix+012h)		;9f58
	ld (ix+01fh),000h		;9f5b
	ret			;9f5f
L_9F60:
	ld a,e			;9f60
	dec a			;9f61
	jp m,L_9F66		;9f62
	ld e,a			;9f65
L_9F66:
	ld a,b			;9f66   ; sostenido durante (ix+0x21) cuadros
	cp (ix+021h)		;9f67
	ret c			;9f6a
	ld (ix+01fh),000h		;9f6b   ; y pasa a caida
	set 3,(ix+00fh)		;9f6f
	ret			;9f73
L_9F74:
	bit 4,(ix+00fh)		;9f74   ; bit 4: caida rapida
	jp nz,L_9F97		;9f78
	ld a,b			;9f7b   ; cada (ix+0x22) cuadros...
	cp (ix+022h)		;9f7c
	ret nz			;9f7f
	ld a,e			;9f80   ; ...baja uno
	dec a			;9f81
	ret m			;9f82
	ld e,a			;9f83
	inc (ix+020h)		;9f84   ; las veces que baja
	ld a,(ix+020h)		;9f87
	cp (ix+023h)		;9f8a   ; hasta (ix+0x23)
	ld (ix+01fh),000h		;9f8d
	ret nz			;9f91
	set 5,(ix+00fh)		;9f92   ; entonces la caida final
	ret			;9f96
L_9F97:
	ld a,(ix+022h)		;9f97   ; caida rapida: resta (ix+0x22)
	ld d,a			;9f9a
	ld a,e			;9f9b
	sub d			;9f9c
	ld e,000h		;9f9d   ; sin bajar de 0
	jp m,L_9FA3		;9f9f
	ld e,a			;9fa2
L_9FA3:
	ld a,b			;9fa3
	cp (ix+023h)		;9fa4
	ret nz			;9fa7
	set 5,(ix+00fh)		;9fa8
	ret			;9fac
L_9FAD:
	ld a,(ix+004h)		;9fad   ; caida final: cuando quedan (ix+0x24) cuadros de la nota...
	cp (ix+024h)		;9fb0
	ret nc			;9fb3
	ld a,e			;9fb4   ; ...baja uno
	dec a			;9fb5
	ret m			;9fb6
	ld e,a			;9fb7
	ret			;9fb8
canal_avanza:		; avanza el puntero de la pista (ix+0x02)
	inc hl			;9fb9
	ld (ix+002h),l		;9fba
	ld (ix+003h),h		;9fbd
	ret			;9fc0
L_9FC1:
	xor a			;9fc1   ; la pista acabo: apaga el canal
	ld (ix+000h),a		;9fc2   ; la pista (ix+0x00)...
	ld (ix+001h),a		;9fc5
	ld (ix+005h),a		;9fc8   ; ...la repeticion...
	ld (ix+006h),a		;9fcb
	ld (ix+00ah),a		;9fce   ; ...la frecuencia, el volumen y los modos, todo a cero
	ld (ix+00bh),a		;9fd1
	ld (ix+00ch),a		;9fd4
	ld (ix+00dh),a		;9fd7
	ld (ix+00eh),a		;9fda
	ld (ix+00fh),a		;9fdd
	call th_9ffb		;9fe0   ; HL = 0xE2F6 (sigue en p08)
	ld hl,0e2f2h		;9fe3   ; lo que hay que mandar al PSG
	ld a,(0e2efh)		;9fe6   ; si era el canal del ruido (8)...
	cp 008h		;9fe9
	jp nz,L_9FF8		;9feb
	res 1,(hl)		;9fee   ; ...ya no hay ruido que mandar
	bit 3,(hl)		;9ff0   ; bit 3: el ruido estaba mandado...
	ret z			;9ff2
	res 3,(hl)		;9ff3   ; ...lo apaga...
	set 2,(hl)		;9ff5   ; ...y apunta que hay que mandarlo de nuevo
	ret			;9ff7
L_9FF8:
	res 3,(hl)		;9ff8
	ret			;9ffa
th_9ffb:		; HL = 0xE2F6 y sigue en p08
	ld hl,0e2f6h		;9ffb

; ----------------------------------------------------------------------
; DATOS partida_9FFE: los 2 primeros bytes de una instruccion de 3 (3A EF E2)
;   que sigue en el banco 8: el trazador de un solo banco no puede verla
;   entera (tools/bancos.py); lo leen p07:9FFE (2 bytes)
;   0x9ffe..0xa000  (2 bytes)
DATA_partida_9FFE:
	defb 03ah,0efh	; 9ffe
