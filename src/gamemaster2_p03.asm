; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 03 (se ejecuta en 0xa000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0a000


; ----------------------------------------------------------------------
; DATOS partida_A000: los 2 ultimos bytes de la instruccion de p02:9FFF (21 23
;   A0), que empieza en el banco 2; lo leen p02:9FFF (2 bytes)
;   0xa000..0xa002  (2 bytes)
DATA_partida_A000:
	defb 023h,0a0h	; a000

; ======================================================================
; CODIGO 0xa002..0xa023  (33 bytes)
; ======================================================================


L_A002:
	ld a,(0d301h)		;a002
	cp 010h		;a005
	jr z,L_A00C		;a007
	ld hl,0a02bh		;a009
L_A00C:
	ld a,b			;a00c
	call hl_mas_a		;a00d   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ex de,hl			;a010
	pop af			;a011
	ld b,a			;a012
	add a,a			;a013
	add a,b			;a014
	ld hl,0e050h		;a015
	call hl_mas_a		;a018   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ex de,hl			;a01b
	inc de			;a01c
	ld bc,00002h		;a01d
	ldir		;a020
	ret			;a022

; ----------------------------------------------------------------------
; DATOS resto_A023: lo apuntan con el banco puesto p03:A009 (0xA02B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A009 (16 bytes)
;   0xa023..0xa033  (16 bytes)
DATA_resto_A023:
	defb 014h,000h,006h,000h,080h,000h,055h,000h,015h,000h,075h,000h,002h,030h,004h,030h	; a023  ......U...u..0.0

; ======================================================================
; CODIGO 0xa033..0xa080  (77 bytes)
; ======================================================================


L_A033:
	call pon_valor		;a033   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d31ah)		;a036
	ld l,a			;a039
	sub 005h		;a03a
	jr c,L_A044		;a03c
	inc a			;a03e
	ld c,005h		;a03f
	call multiplica		;a041   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
L_A044:
	ld a,l			;a044
	ld (0e052h),a		;a045
	ret			;a048
L_A049:
	call pon_valor		;a049   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d31ah)		;a04c
	ld b,a			;a04f
	dec a			;a050
	ld (0e05ch),a		;a051
	cp 008h		;a054
	jr c,L_A05A		;a056
	ld a,008h		;a058
L_A05A:
	ld hl,0a080h		;a05a
	call hl_mas_a		;a05d   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;a060
	ld (0e05dh),a		;a061
	ld a,08ah		;a064
	ld (0e056h),a		;a066
	ld a,b			;a069
	ld c,009h		;a06a
	call multiplica		;a06c   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a06f
	add a,a			;a070
	ld hl,0a089h		;a071
	call hl_mas_a		;a074   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld de,0e054h		;a077
	ld bc,00002h		;a07a
	ldir		;a07d
	ret			;a07f

; ----------------------------------------------------------------------
; DATOS resto_A080: lo apuntan con el banco puesto p03:A05A (0xA080), p03:A071
;   (0xA089); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p03:A05A, p03:A071 (27 bytes)
;   0xa080..0xa09b  (27 bytes)
DATA_resto_A080:
	defb 077h,033h,0bbh,0eeh,011h,0bbh,0eeh,011h,011h,000h,000h,070h,00ch,020h,01ah,050h	; a080  w3.........p. .P
	defb 028h,030h,036h,0e0h,043h,040h,052h,0c0h,061h,0d0h,06eh	; a090  (06.C@R.a.n

; ======================================================================
; CODIGO 0xa09b..0xa0cf  (52 bytes)
; ======================================================================


L_A09B:
	jp pon_valor		;a09b   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
L_A09E:
	ld a,(0d31ah)		;a09e
	dec a			;a0a1
	jp L_A125		;a0a2
L_A0A5:
	ld a,(0d31ah)		;a0a5
	ld c,003h		;a0a8
	call multiplica		;a0aa   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a0ad
	jp L_A125		;a0ae
L_A0B1:
	ld a,(0d31ah)		;a0b1
	ld c,00dh		;a0b4
	call multiplica		;a0b6   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a0b9
	inc a			;a0ba
	ld (0e060h),a		;a0bb
	dec a			;a0be
	add a,a			;a0bf
	ld hl,0a0cfh		;a0c0
	call hl_mas_a		;a0c3   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld de,0e05bh		;a0c6
	ld bc,00002h		;a0c9
	ldir		;a0cc
	ret			;a0ce

; ----------------------------------------------------------------------
; DATOS resto_A0CF: lo apuntan con el banco puesto p03:A0C0 (0xA0CF); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A0C0 (26 bytes)
;   0xa0cf..0xa0e9  (26 bytes)
DATA_resto_A0CF:
	defb 006h,080h,006h,070h,006h,070h,006h,070h,006h,060h,006h,050h,006h,050h,006h,050h	; a0cf  ...p.p.p.`.P.P.P
	defb 006h,060h,006h,060h,006h,050h,006h,050h,000h,080h	; a0df  .`.`.P.P..

; ======================================================================
; CODIGO 0xa0e9..0xa15b  (114 bytes)
; ======================================================================


L_A0E9:
	ld a,(0d31ah)		;a0e9
	ld c,008h		;a0ec
	call multiplica		;a0ee   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld h,l			;a0f1
	ld l,000h		;a0f2
	ld (0e1b8h),hl		;a0f4
	jp pon_valor		;a0f7   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
L_A0FA:
	call pon_valor		;a0fa   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d31ah)		;a0fd
	push af			;a100
	ld c,005h		;a101
	call multiplica		;a103   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a106
	ld (0e054h),a		;a107
	pop af			;a10a
	cp 006h		;a10b
	ret c			;a10d
	ld b,a			;a10e
	sub 005h		;a10f
	cp 004h		;a111
	jr c,L_A117		;a113
	ld a,003h		;a115
L_A117:
	ld (0e056h),a		;a117
	ld a,b			;a11a
	dec a			;a11b
	and 003h		;a11c
	ld (0e059h),a		;a11e
	ret			;a121
pon_valor:		; escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d31bh)		;a122
L_A125:
	ld hl,(0d30ah)		;a125
	ld (hl),a			;a128
	ret			;a129
L_A12A:
	ld a,(0d31ah)		;a12a
	ld c,00fh		;a12d
	call multiplica		;a12f   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,e			;a132
	ld (0e058h),a		;a133
	ld a,l			;a136
	inc a			;a137
	ld (0e055h),a		;a138
	dec a			;a13b
	ld (0e054h),a		;a13c
	ld hl,0a15bh		;a13f
	add a,a			;a142
	call hl_mas_a		;a143   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;a146
	ld (0e056h),a		;a147
	inc hl			;a14a
	ld a,(hl)			;a14b
	ld (0e057h),a		;a14c
	ld a,(0e055h)		;a14f
	cp 001h		;a152
	jr z,L_A157		;a154
	xor a			;a156
L_A157:
	ld (0e051h),a		;a157
	ret			;a15a

; ----------------------------------------------------------------------
; DATOS resto_A15B: lo apuntan con el banco puesto p03:A13F (0xA15B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A13F (32 bytes)
;   0xa15b..0xa17b  (32 bytes)
DATA_resto_A15B:
	defb 008h,000h,004h,008h,004h,008h,001h,008h,008h,004h,008h,004h,004h,004h,004h,008h	; a15b  ................
	defb 001h,008h,008h,004h,008h,004h,004h,004h,004h,008h,004h,008h,001h,002h,008h,004h	; a16b  ................

; ======================================================================
; CODIGO 0xa17b..0xa2b1  (310 bytes)
; ======================================================================


L_A17B:
	ld a,(0d31ah)		;a17b
	cp 033h		;a17e
	jr c,L_A184		;a180
	sub 032h		;a182
L_A184:
	dec a			;a184
	ld (0e053h),a		;a185
	ld a,(0d31bh)		;a188
	cp 051h		;a18b
	jr c,L_A192		;a18d
	sub 050h		;a18f
	daa			;a191
L_A192:
	ld (0e052h),a		;a192
	ret			;a195
L_A196:
	ld a,(0d31ah)		;a196
	ld c,008h		;a199
	call multiplica		;a19b   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a19e
	ld (0e103h),a		;a19f
	ld hl,000c0h		;a1a2
	ld (0e1b8h),hl		;a1a5
	ret			;a1a8
L_A1A9:
	ld a,(0d31ah)		;a1a9
	ld c,006h		;a1ac
	call multiplica		;a1ae   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,e			;a1b1
	ld (0e042h),a		;a1b2
	ld a,l			;a1b5
	ld hl,(0d30ah)		;a1b6
	ld (hl),a			;a1b9
	call borra_pantalla_b		;a1ba   ; borra_pantalla_b: borra la tabla de nombres y esconde los sprites (gemela de p01:708B)
	ld a,004h		;a1bd
	ld (0e001h),a		;a1bf   ; guarda fila elegida de la SRAM
	ld a,008h		;a1c2
	ld (0e000h),a		;a1c4   ; guarda opcion / RC del juego
	ret			;a1c7
L_A1C8:
	call borra_pantalla_b		;a1c8   ; borra_pantalla_b: borra la tabla de nombres y esconde los sprites (gemela de p01:708B)
	ld hl,(0d304h)		;a1cb
	ld (hl),007h		;a1ce
	ret			;a1d0
L_A1D1:
	ld a,(0d31ah)		;a1d1
	dec a			;a1d4
	ld hl,(0d30ah)		;a1d5
	ld (hl),a			;a1d8
	ret			;a1d9
L_A1DA:
	ld a,(0d31ah)		;a1da
	dec a			;a1dd
	ld (0e206h),a		;a1de
	call pon_valor		;a1e1   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d31ah)		;a1e4
	ld c,003h		;a1e7
	call multiplica		;a1e9   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,e			;a1ec
	and 00fh		;a1ed
	rrca			;a1ef
	rrca			;a1f0
	rrca			;a1f1
	rrca			;a1f2
	add a,l			;a1f3
	ld (0e207h),a		;a1f4
	ld a,009h		;a1f7
	ld hl,(0d304h)		;a1f9
	ld (hl),a			;a1fc
	jp borra_pantalla_b		;a1fd   ; borra_pantalla_b: borra la tabla de nombres y esconde los sprites (gemela de p01:708B)
L_A200:
	ld a,(0d31ah)		;a200
	ld c,008h		;a203
	call multiplica		;a205   ; multiplica: HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	ld a,l			;a208
	ld hl,(0d30ah)		;a209
	ld (hl),a			;a20c
	ld a,e			;a20d
	cp 002h		;a20e
	jr c,L_A214		;a210
	ld a,002h		;a212
L_A214:
	ld (0e06ah),a		;a214
	ld a,(0d31bh)		;a217
	ld (0e053h),a		;a21a
	ret			;a21d
multiplica:		; HL = (A - 1) * ... (multiplicacion de 16 bits) (gemela de p01:706C)
	dec a			;a21e
	ld e,a			;a21f
	ld d,000h		;a220
	ld b,d			;a222
divide:		; DE / BC: cociente en DE y resto en HL (gemela de p05:9430)
	ld hl,00000h		;a223
	exx			;a226
	ld b,010h		;a227
L_A229:
	exx			;a229
	sla e		;a22a
	rl d		;a22c
	adc hl,hl		;a22e
	sbc hl,bc		;a230
	jr c,L_A237		;a232
	inc e			;a234
	jr L_A238		;a235
L_A237:
	add hl,bc			;a237
L_A238:
	exx			;a238
	djnz L_A229		;a239
	exx			;a23b
	ret			;a23c
borra_pantalla_b:		; borra la tabla de nombres y esconde los sprites (gemela de p01:708B)
	ld hl,03800h		;a23d
	xor a			;a240
	ld bc,00300h		;a241
	call 00056h		;a244   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;a247
	ld a,0d0h		;a24a
	jp 0004dh		;a24c   ; BIOS WRTVRM - Writes data in VRAM
L_A24F:
	call busca_ficha_b		;a24f   ; busca_ficha_b: copia la ficha por defecto (p00:45D0) a 0xD300 y busca la del juego
	call lee_cabecera_juego		;a252   ; lee_cabecera_juego: lee la cabecera de 0x4028 del juego y sus opciones (gemela de p01:70AA)
	ld a,(0d301h)		;a255
	ld b,a			;a258
	cp 036h		;a259
	jr nz,$+112		;a25b
	ld a,004h		;a25d
	ld (0d312h),a		;a25f
	ret			;a262
lee_cabecera_juego:		; lee la cabecera de 0x4028 del juego y sus opciones (gemela de p01:70AA)
	ld hl,(0d300h)		;a263   ; lee la ficha del juego (copia) y el byte siguiente (16 bits)
	ld a,l			;a266
	ld l,h			;a267
	ld h,a			;a268
	ld de,00754h		;a269
	rst 20h			;a26c
	jr c,L_A289		;a26d
	ld hl,04028h		;a26f
	ld de,0d4f6h		;a272
	ld bc,00006h		;a275
	call 08d74h		;a278   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE (gemela de p01:6371)
	ld hl,0d4f6h		;a27b
	ld a,(hl)			;a27e
	res 7,(hl)		;a27f
	add a,a			;a281
	ret nc			;a282
	ld a,001h		;a283
	ld (0d4d4h),a		;a285
	ret			;a288
L_A289:
	ex de,hl			;a289
	ld hl,0a2bdh		;a28a
L_A28D:
	ld a,(hl)			;a28d
	inc hl			;a28e
	cp 0ffh		;a28f
	jr z,L_A2A2		;a291
	cp e			;a293
	jr nz,L_A29A		;a294
	ld a,(hl)			;a296
	cp d			;a297
	jr z,L_A29D		;a298
L_A29A:
	inc hl			;a29a
	jr L_A28D		;a29b
L_A29D:
	ld hl,0a2b1h		;a29d
	jr L_A2A5		;a2a0
L_A2A2:
	ld hl,0a2b7h		;a2a2
L_A2A5:
	ld de,0d4f6h		;a2a5
	ld bc,00006h		;a2a8
	ldir		;a2ab
	call rc_751_o_752_b		;a2ad   ; rc_751_o_752_b: compara el RC del juego (0xD351, al reves) con 0x751 y 0x752
	ret			;a2b0

; ----------------------------------------------------------------------
; DATOS resto_A2B1: lo apuntan con el banco puesto p03:A29D (0xA2B1), p03:A2A2
;   (0xA2B7), p03:A28A (0xA2BD); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p03:A29D, p03:A2A2, p03:A28A (26 bytes)
;   0xa2b1..0xa2cb  (26 bytes)
DATA_resto_A2B1:
	defb 001h,001h,000h,002h,080h,0f6h,000h,000h,000h,000h,0ffh,0ffh,044h,007h,045h,007h	; a2b1  ............D.E.
	defb 047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh	; a2c1  G.H.P.S...

; ======================================================================
; CODIGO 0xa2cb..0xa392  (199 bytes)
; ======================================================================


L_A2CB:
	ld a,b			;a2cb
	sub 003h		;a2cc
	cp 002h		;a2ce
	jr c,L_A2D8		;a2d0
	ld a,b			;a2d2
	sub 010h		;a2d3
	cp 002h		;a2d5
	ret nc			;a2d7
L_A2D8:
	ld a,001h		;a2d8
	ld (0d339h),a		;a2da
	ret			;a2dd
busca_ficha_b:		; copia la ficha por defecto (p00:45D0) a 0xD300 y busca la del juego
	xor a			;a2de
	ld (0d4d4h),a		;a2df
busca_ficha:		; copia la ficha por defecto (p00:45D0) y busca la del juego por su suma (gemela de p01:7136)
	ld hl,045d0h		;a2e2
	ld de,0d300h		;a2e5   ; apunta a la ficha del juego (copia)
	ld bc,00016h		;a2e8
	ldir		;a2eb
	ld a,0ffh		;a2ed
	ld (0d313h),a		;a2ef
	ld hl,04010h		;a2f2
	call 08398h		;a2f5   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104) (gemela de p00:576B)
	ld hl,04241h		;a2f8
	rst 20h			;a2fb
	jr nz,L_A30A		;a2fc
	ld hl,04012h		;a2fe
	ld de,0d300h		;a301   ; apunta a la ficha del juego (copia)
	ld bc,00013h		;a304
	jp 08d74h		;a307   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE (gemela de p01:6371)
L_A30A:
	ld hl,04645h		;a30a
	rst 20h			;a30d
	jr z,L_A317		;a30e
	ld hl,04443h		;a310
	rst 20h			;a313
	jp nz,L_A39E		;a314
L_A317:
	ld hl,04012h		;a317
	ld de,0d351h		;a31a
	ld bc,0002dh		;a31d
	call 08d74h		;a320   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE (gemela de p01:6371)
	call rc_751_o_752_b		;a323   ; rc_751_o_752_b: compara el RC del juego (0xD351, al reves) con 0x751 y 0x752
	ld hl,0d351h		;a326
	ld de,0d300h		;a329   ; apunta a la ficha del juego (copia)
	ldi		;a32c
	ldi		;a32e
	ld a,0ffh		;a330
	ld (de),a			;a332
	inc de			;a333
	inc de			;a334
	ld a,(hl)			;a335
	rra			;a336
	jr c,L_A344		;a337
	inc hl			;a339
	ld bc,00002h		;a33a
	ldir		;a33d
	ld de,0d312h		;a33f
	ldi		;a342
L_A344:
	rra			;a344
	jr c,L_A353		;a345
	ld de,0d30ah		;a347
	ldi		;a34a
	ldi		;a34c
	ld de,0d313h		;a34e
	ldi		;a351
L_A353:
	ld ix,0a392h		;a353
	ld b,006h		;a357
L_A359:
	push bc			;a359
	rra			;a35a
	jr c,L_A368		;a35b
	ld e,(ix+000h)		;a35d
	ld d,(ix+001h)		;a360
	ld bc,00002h		;a363
	ldir		;a366
L_A368:
	pop bc			;a368
	inc ix		;a369
	inc ix		;a36b
	djnz L_A359		;a36d
	ret			;a36f
rc_751_o_752_b:		; compara el RC del juego (0xD351, al reves) con 0x751 y 0x752
	ld hl,(0d351h)		;a370
	ld a,h			;a373
	ld h,l			;a374
	ld l,a			;a375
	ld de,00751h		;a376
	rst 20h			;a379
	jr z,L_A38C		;a37a
	ld de,00752h		;a37c
	rst 20h			;a37f
	jr z,L_A38C		;a380
	ld de,00758h		;a382
	rst 20h			;a385
	ret c			;a386
	ld a,(0d379h)		;a387
	add a,a			;a38a
	ret nc			;a38b
L_A38C:
	ld a,001h		;a38c
	ld (0d4d4h),a		;a38e
	ret			;a391

; ----------------------------------------------------------------------
; DATOS resto_A392: lo apuntan con el banco puesto p03:A353 (0xA392); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A353 (12 bytes)
;   0xa392..0xa39e  (12 bytes)
DATA_resto_A392:
	defb 008h,0d3h,00ch,0d3h,00eh,0d3h,010h,0d3h,006h,0d3h,014h,0d3h	; a392  ............

; ======================================================================
; CODIGO 0xa39e..0xa423  (133 bytes)
; ======================================================================


L_A39E:
	ld a,(0d12fh)		;a39e
	ld de,00000h		;a3a1
	ld hl,05000h		;a3a4
	ld b,000h		;a3a7
L_A3A9:
	push af			;a3a9
	push bc			;a3aa
	push de			;a3ab
	call 0000ch		;a3ac   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;a3af
	pop bc			;a3b0
	add a,e			;a3b1
	ld e,a			;a3b2
	jr nc,L_A3B6		;a3b3
	inc d			;a3b5
L_A3B6:
	pop af			;a3b6
	inc hl			;a3b7
	djnz L_A3A9		;a3b8
	ld ix,044beh		;a3ba
L_A3BE:
	ld l,(ix+000h)		;a3be
	ld h,(ix+001h)		;a3c1
	ld a,l			;a3c4
	or h			;a3c5
	ret z			;a3c6
	rst 20h			;a3c7
	jr z,L_A3D4		;a3c8
	inc ix		;a3ca
	inc ix		;a3cc
	inc ix		;a3ce
	inc ix		;a3d0
	jr L_A3BE		;a3d2
L_A3D4:
	push de			;a3d4
	ld l,(ix+002h)		;a3d5
	ld h,(ix+003h)		;a3d8
	ld de,0d300h		;a3db   ; apunta a la ficha del juego (copia)
	ld bc,00013h		;a3de
	ldir		;a3e1
	pop de			;a3e3
	scf			;a3e4
	ret			;a3e5
hl_mas_a:		; HL = HL + A (gemela de p01:7251)
	add a,l			;a3e6
	ld l,a			;a3e7
	ret nc			;a3e8
	inc h			;a3e9
	ret			;a3ea
de_mas_a:		; DE = DE + A (gemela de p01:7256)
	add a,e			;a3eb
	ld e,a			;a3ec
	ret nc			;a3ed
	inc d			;a3ee
	ret			;a3ef
pon_color:		; MSX2: el color B de la paleta con D y E (R
	push bc			;a3f0
	push hl			;a3f1
	ld b,a			;a3f2
	ld a,(00007h)		;a3f3
	inc a			;a3f6
	ld c,a			;a3f7
	di			;a3f8
	out (c),b		;a3f9
	ld a,090h		;a3fb
	out (c),a		;a3fd
	inc c			;a3ff
	out (c),d		;a400
	push af			;a402
	pop af			;a403
	out (c),e		;a404
	pop hl			;a406
	pop bc			;a407
	ei			;a408
	ret			;a409
paleta_msx2:		; MSX2: los 16 colores de p01:728E (gemela de p01:7275)
	ld a,(0002dh)		;a40a
	and a			;a40d
	ret z			;a40e
paleta_bio:		; MSX2: los 16 colores de p05:82D7 (gemela de p05:82C3)
	ld hl,0a423h		;a40f
paleta_desde:		; MSX2: los 16 colores de HL (gemela de p05:82C6)
	ld b,010h		;a412
	ld a,000h		;a414
L_A416:
	ld d,(hl)			;a416
	inc hl			;a417
	ld e,(hl)			;a418
	inc hl			;a419
	push af			;a41a
	call pon_color		;a41b   ; pon_color: MSX2: el color B de la paleta con D y E (R
	pop af			;a41e
	inc a			;a41f
	djnz L_A416		;a420
	ret			;a422

; ----------------------------------------------------------------------
; DATOS resto_A423: lo apuntan con el banco puesto p03:A40F (0xA423); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A40F (32 bytes)
;   0xa423..0xa443  (32 bytes)
DATA_resto_A423:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; a423  ......3...'.Q.'.
	defb 071h,001h,073h,003h,061h,006h,064h,006h,011h,004h,065h,002h,055h,005h,077h,007h	; a433  q.s.a.d...e.U.w.

; ======================================================================
; CODIGO 0xa443..0xa477  (52 bytes)
; ======================================================================


paleta_lista:		; MSX2: colores de una lista [color, d, e] que acaba en 0xFF (gemela de p01:72AE)
	ld a,(hl)			;a443
	inc hl			;a444
	inc a			;a445
	ret z			;a446
	dec a			;a447
	ld d,(hl)			;a448
	inc hl			;a449
	ld e,(hl)			;a44a
	inc hl			;a44b
	call pon_color		;a44c   ; pon_color: MSX2: el color B de la paleta con D y E (R
	jr paleta_lista		;a44f
registros_vdp:		; los 8 registros del VDP de p01:72E2 y, en MSX2, R
	ld hl,0a477h		;a451
	ld bc,00800h		;a454
L_A457:
	push bc			;a457
	ld b,(hl)			;a458
	call 00047h		;a459   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;a45c
	inc hl			;a45d
	inc c			;a45e
	djnz L_A457		;a45f
	ld a,(0002dh)		;a461
	and a			;a464
	ret z			;a465
	ld bc,00017h		;a466
	call 00047h		;a469   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0ffe8h)		;a46c
	and 07fh		;a46f
	ld b,a			;a471
	ld c,009h		;a472
	jp 00047h		;a474   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; DATOS resto_A477: lo apuntan con el banco puesto p03:A451 (0xA477); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A451 (8 bytes)
;   0xa477..0xa47f  (8 bytes)
DATA_resto_A477:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; a477  .....v..

; ======================================================================
; CODIGO 0xa47f..0xa770  (753 bytes)
; ======================================================================


borra_nombres:		; borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	ld hl,03800h		;a47f
	ld bc,00300h		;a482
	xor a			;a485
	call 00056h		;a486   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;a489
	ld a,0d0h		;a48c
	jp 0004dh		;a48e   ; BIOS WRTVRM - Writes data in VRAM
rellena_tercios:		; FILVRM en los tres tercios de la pantalla (gemela de p01:72FC)
	ld d,003h		;a491
L_A493:
	push bc			;a493
	push de			;a494
	call 00056h		;a495   ; BIOS FILVRM - Fills VRAM with value
	ld bc,00800h		;a498
	add hl,bc			;a49b
	pop de			;a49c
	pop bc			;a49d
	dec d			;a49e
	jr nz,L_A493		;a49f
	ret			;a4a1
copia_tercios:		; LDIRVM en los tres tercios de la pantalla (gemela de p01:730D)
	ld a,003h		;a4a2
L_A4A4:
	push af			;a4a4
	push bc			;a4a5
	push hl			;a4a6
	push de			;a4a7
	call 0005ch		;a4a8   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop de			;a4ab
	ld hl,00800h		;a4ac
	add hl,de			;a4af
	ex de,hl			;a4b0
	pop hl			;a4b1
	pop bc			;a4b2
	pop af			;a4b3
	dec a			;a4b4
	jr nz,L_A4A4		;a4b5
	ret			;a4b7
descomprime_tercios:		; descomprime HL en los tres tercios de la pantalla (gemela de p01:7323)
	ld b,003h		;a4b8
L_A4BA:
	push bc			;a4ba
	push hl			;a4bb
	push de			;a4bc
	call descomprime		;a4bd   ; descomprime: descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias (gemela de p01:733A)
	pop de			;a4c0
	ld hl,00800h		;a4c1
	add hl,de			;a4c4
	ex de,hl			;a4c5
	pop hl			;a4c6
	pop bc			;a4c7
	djnz L_A4BA		;a4c8
	ret			;a4ca
descomprime_con_direccion:		; descomprime a la VRAM de la palabra de HL (gemela de p01:7336)
	ld e,(hl)			;a4cb
	inc hl			;a4cc
	ld d,(hl)			;a4cd
	inc hl			;a4ce
descomprime:		; descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias (gemela de p01:733A)
	ex de,hl			;a4cf
	call vram_escribe_en		;a4d0   ; vram_escribe_en: SETWRT (o NSTWRT en MSX2) en HL (gemela de p01:736A)
	ex de,hl			;a4d3
	ld a,(00007h)		;a4d4
	ld c,a			;a4d7
L_A4D8:
	ld a,(hl)			;a4d8
	and 07fh		;a4d9
	ld b,a			;a4db
	ld a,(hl)			;a4dc
	inc hl			;a4dd
	jr nz,L_A4E4		;a4de
	cp b			;a4e0
	jr nz,descomprime_con_direccion		;a4e1
	ret			;a4e3
L_A4E4:
	cp b			;a4e4
	jr z,L_A4F2		;a4e5
L_A4E7:
	ld a,(hl)			;a4e7
	inc hl			;a4e8
	out (c),a		;a4e9
	inc de			;a4eb
	push hl			;a4ec
	pop hl			;a4ed
	djnz L_A4E7		;a4ee
	jr L_A4D8		;a4f0
L_A4F2:
	ld a,(hl)			;a4f2
	inc hl			;a4f3
L_A4F4:
	out (c),a		;a4f4
	inc de			;a4f6
	push ix		;a4f7
	pop ix		;a4f9
	djnz L_A4F4		;a4fb
	jr L_A4D8		;a4fd
vram_escribe_en:		; SETWRT (o NSTWRT en MSX2) en HL (gemela de p01:736A)
	push af			;a4ff
	ld a,(0002dh)		;a500
	and a			;a503
	jr nz,L_A50B		;a504
	call 00053h		;a506   ; BIOS SETWRT - Enables VDP to write
	pop af			;a509
	ret			;a50a
L_A50B:
	call 00171h		;a50b   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	pop af			;a50e
	ret			;a50f
despacha:		; salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)
	pop hl			;a510
	add a,a			;a511
	add a,l			;a512
	ld l,a			;a513
	jr nc,L_A517		;a514
	inc h			;a516
L_A517:
	ld e,(hl)			;a517
	inc hl			;a518
	ld d,(hl)			;a519
	ex de,hl			;a51a
	jp (hl)			;a51b
L_A51C:
	ld c,000h		;a51c
	jr L_A526		;a51e
L_A520:
	ld c,0ffh		;a520
	jr L_A52A		;a522
pinta_texto_b:		; pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld c,0ffh		;a524
L_A526:
	ld e,(hl)			;a526
	inc hl			;a527
	ld d,(hl)			;a528
	inc hl			;a529
L_A52A:
	ld a,(hl)			;a52a
	inc hl			;a52b
	ld b,a			;a52c
	inc b			;a52d
	ret z			;a52e
	inc b			;a52f
	jr z,L_A526		;a530
	and c			;a532
	ex de,hl			;a533
	call 0004dh		;a534   ; BIOS WRTVRM - Writes data in VRAM
	ex de,hl			;a537
	inc de			;a538
	jr L_A52A		;a539
L_A53B:
	push bc			;a53b
	ld b,000h		;a53c
	push af			;a53e
	call 00056h		;a53f   ; BIOS FILVRM - Fills VRAM with value
	pop af			;a542
	ld bc,00020h		;a543
	add hl,bc			;a546
	pop bc			;a547
	djnz L_A53B		;a548
	ret			;a54a
binario_a_bcd:		; HL a BCD en DE (gemela de p01:746C)
	ld b,010h		;a54b
	ld de,00000h		;a54d
L_A550:
	add hl,hl			;a550
	ld a,e			;a551
	adc a,a			;a552
	daa			;a553
	ld e,a			;a554
	ld a,d			;a555
	adc a,a			;a556
	daa			;a557
	ld d,a			;a558
	djnz L_A550		;a559
	ret			;a55b
bcd_a_binario:		; A en BCD a binario (gemela de p01:747D)
	ld c,a			;a55c
	and 0f0h		;a55d
	rrca			;a55f
	rrca			;a560
	rrca			;a561
	rrca			;a562
	add a,a			;a563
	ld b,a			;a564
	add a,a			;a565
	add a,a			;a566
	add a,b			;a567
	ld b,a			;a568
	ld a,c			;a569
	and 00fh		;a56a
	add a,b			;a56c
	ret			;a56d
borra_ventana:		; borra la ventana de 0x9237 (gemela de p01:748F)
	ld bc,00613h		;a56e
	ld hl,(0d16eh)		;a571
	xor a			;a574
	jp L_A53B		;a575
L_A578:
	ld hl,0d12ah		;a578
	ld a,(hl)			;a57b
	or a			;a57c
	ret nz			;a57d
	dec a			;a57e
	ld (hl),a			;a57f
	ld de,0d8b1h		;a580
	ld hl,01000h		;a583
	ld bc,00080h		;a586
	call lee_vram_tercios		;a589   ; lee_vram_tercios: LDIRMV de los tres tercios (0x2000 de paso) (gemela de p01:7834)
	ld de,0d500h		;a58c
	ld hl,01180h		;a58f
	ld bc,00158h		;a592
	call lee_vram_tercios		;a595   ; lee_vram_tercios: LDIRMV de los tres tercios (0x2000 de paso) (gemela de p01:7834)
	ld hl,03a00h		;a598
	ld de,0d7b0h		;a59b
	ld bc,00100h		;a59e
	call 00059h		;a5a1   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,03b00h		;a5a4
	ld de,0d8b0h		;a5a7
	ld bc,00001h		;a5aa
	call 00059h		;a5ad   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,01000h		;a5b0
	ld bc,00008h		;a5b3
	ld a,055h		;a5b6
	call 00056h		;a5b8   ; BIOS FILVRM - Fills VRAM with value
	call borra_zona_3a00		;a5bb   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld ix,0409dh		;a5be
	ld iy,(0d12dh)		;a5c2
	call 0001ch		;a5c6   ; BIOS CALSLT - Executes inter-slot call
	ld hl,01180h		;a5c9
	ld a,0f5h		;a5cc
	ld bc,00158h		;a5ce
	call 00056h		;a5d1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;a5d4
	ld a,0d0h		;a5d7
	jp 0004dh		;a5d9   ; BIOS WRTVRM - Writes data in VRAM
lee_vram_tercios:		; LDIRMV de los tres tercios (0x2000 de paso) (gemela de p01:7834)
	push bc			;a5dc
	push de			;a5dd
	push hl			;a5de
	call 00059h		;a5df   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;a5e2
	ld bc,02000h		;a5e3
	add hl,bc			;a5e6
	pop de			;a5e7
	pop bc			;a5e8
	ex de,hl			;a5e9
	add hl,bc			;a5ea
	ex de,hl			;a5eb
	jp 00059h		;a5ec   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_A5EF:
	ld hl,0d12ah		;a5ef
	ld a,(hl)			;a5f2
	or a			;a5f3
	ret z			;a5f4
	xor a			;a5f5
	ld (hl),a			;a5f6
	call borra_zona_3a00		;a5f7   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld hl,0d8b1h		;a5fa
	ld de,01000h		;a5fd
	ld bc,00080h		;a600
	call copia_vram_tercios		;a603   ; copia_vram_tercios: LDIRVM de los tres tercios (0x2000 de paso) (gemela de p01:788E)
	ld hl,0d500h		;a606
	ld de,01180h		;a609
	ld bc,00158h		;a60c
	call copia_vram_tercios		;a60f   ; copia_vram_tercios: LDIRVM de los tres tercios (0x2000 de paso) (gemela de p01:788E)
	ld hl,0d7b0h		;a612
	ld de,03a00h		;a615
	ld bc,00100h		;a618
	call 0005ch		;a61b   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0d8b0h		;a61e
	ld de,03b00h		;a621
	ld bc,00001h		;a624
	jp 0005ch		;a627   ; BIOS LDIRVM - Block transfers to VRAM from memory
copia_vram_tercios:		; LDIRVM de los tres tercios (0x2000 de paso) (gemela de p01:788E)
	push bc			;a62a
	push hl			;a62b
	push de			;a62c
	call 0005ch		;a62d   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;a630
	ld bc,02000h		;a631
	add hl,bc			;a634
	pop de			;a635
	pop bc			;a636
	ex de,hl			;a637
	add hl,bc			;a638
	jp 0005ch		;a639   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_A63C:
	ld a,(0d13dh)		;a63c
	or a			;a63f
	ret z			;a640
	jp L_A578		;a641
L_A644:
	ld a,(0d13dh)		;a644
	or a			;a647
	ret z			;a648
	jr L_A5EF		;a649
L_A64B:
	ld a,(0d16dh)		;a64b
	cp 03ah		;a64e
	ld hl,03900h		;a650
	jr c,L_A658		;a653
borra_zona_3a00:		; borra 0x3A00 (0x100 bytes)
	ld hl,03a00h		;a655
L_A658:
	ld bc,00100h		;a658
	xor a			;a65b
	jp 00056h		;a65c   ; BIOS FILVRM - Fills VRAM with value
menu:		; menu de B opciones con el cursor A: devuelve la elegida (gemela de p01:750E)
	ld (0d167h),a		;a65f
	or a			;a662
	ld a,b			;a663
	jr nz,L_A668		;a664
	ld a,008h		;a666
L_A668:
	ld (0d164h),a		;a668
	ld (0d168h),hl		;a66b
	ld (0d16ah),hl		;a66e
	call cursor_pinta_b		;a671   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
	call borra_teclado		;a674   ; borra_teclado: borra el bufer de teclas del menu (0x920B) (gemela de p01:75E2)
L_A677:
	call 0009fh		;a677   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;a67a
	ld b,a			;a67c
	jr nz,L_A687		;a67d
	ld a,(0d165h)		;a67f
	ld (0d163h),a		;a682
	or a			;a685
	ret			;a686
L_A687:
	cp 01dh		;a687
	jr z,L_A68F		;a689
	cp 008h		;a68b
	jr nz,L_A6B4		;a68d
L_A68F:
	call opcion_cero		;a68f   ; opcion_cero: si no hay opcion elegida, vuelve al menu (gemela de p01:766D)
	ld a,(0d165h)		;a692
	ld hl,0d141h		;a695
	call hl_mas_a		;a698   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;a69b
	sub 03ch		;a69c
	jr nz,L_A6A3		;a69e
	ld (0d166h),a		;a6a0
L_A6A3:
	ld hl,0d165h		;a6a3
	dec (hl)			;a6a6
	call cursor_borra_b		;a6a7   ; cursor_borra_b: borra el cursor
	dec hl			;a6aa
	ld (0d168h),hl		;a6ab
	call cursor_pinta_b		;a6ae   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
	jp L_A677		;a6b1
L_A6B4:
	cp 02eh		;a6b4
	jr nz,L_A6CF		;a6b6
	ld a,(0d167h)		;a6b8
	cp 0feh		;a6bb
	jp nz,L_A677		;a6bd
	call opcion_cero		;a6c0   ; opcion_cero: si no hay opcion elegida, vuelve al menu (gemela de p01:766D)
	ld a,03ch		;a6c3
	ld hl,0d166h		;a6c5
	cp (hl)			;a6c8
	jp z,L_A677		;a6c9
	ld (hl),a			;a6cc
	jr L_A6F9		;a6cd
L_A6CF:
	ld c,a			;a6cf
	sub 030h		;a6d0
	cp 00ah		;a6d2
	jr nc,L_A6D9		;a6d4
	ld a,c			;a6d6
	jr L_A6F9		;a6d7
L_A6D9:
	ld a,c			;a6d9
	sub 041h		;a6da
	cp 01ah		;a6dc
	jr nc,L_A6EC		;a6de
	ld a,c			;a6e0
L_A6E1:
	ex af,af'			;a6e1
	ld a,(0d167h)		;a6e2
	inc a			;a6e5
	jp z,L_A677		;a6e6
	ex af,af'			;a6e9
	jr L_A6F9		;a6ea
L_A6EC:
	ld a,c			;a6ec
	sub 061h		;a6ed
	cp 01ah		;a6ef
	jp nc,L_A677		;a6f1
	ld a,c			;a6f4
	sub 020h		;a6f5
	jr L_A6E1		;a6f7
L_A6F9:
	ld b,a			;a6f9
	ld hl,0d165h		;a6fa
	ld a,(0d164h)		;a6fd
	cp (hl)			;a700
	jp z,L_A677		;a701
	inc (hl)			;a704
	ld a,(hl)			;a705
	cp 001h		;a706
	jr nz,L_A716		;a708
	push bc			;a70a
	ld hl,(0d16ah)		;a70b
	ld bc,0000eh		;a70e
	xor a			;a711
	call 00056h		;a712   ; BIOS FILVRM - Fills VRAM with value
	pop bc			;a715
L_A716:
	ld hl,(0d168h)		;a716
	ld a,b			;a719
	call 0004dh		;a71a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;a71d
	ld (0d168h),hl		;a71e
	call cursor_pinta_b		;a721   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
	ld a,(0d165h)		;a724
	ld hl,0d141h		;a727
	call hl_mas_a		;a72a   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld (hl),b			;a72d
	jp L_A677		;a72e
borra_teclado:		; borra el bufer de teclas del menu (0x920B) (gemela de p01:75E2)
	ld hl,0d142h		;a731
	ld de,0d143h		;a734
	ld (hl),000h		;a737
	ld bc,0001fh		;a739
	ldir		;a73c
	call cursor_apaga_b		;a73e   ; cursor_apaga_b: quita el cursor
	call 00156h		;a741   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;a744
	ld (0d163h),a		;a745
	ld (0d165h),a		;a748
	ld (0d166h),a		;a74b
	ret			;a74e
cursor_apaga_b:		; quita el cursor
	ld hl,0a770h		;a74f
	ld bc,00008h		;a752
	ld a,(0d13dh)		;a755
	or a			;a758
	jr nz,L_A76A		;a759
	ld a,(0d4d3h)		;a75b
	and a			;a75e
	ld de,021d0h		;a75f
	jr z,L_A767		;a762
	ld de,02080h		;a764
L_A767:
	jp copia_tercios		;a767   ; copia_tercios: LDIRVM en los tres tercios de la pantalla (gemela de p01:730D)
L_A76A:
	ld de,031d0h		;a76a
	jp 0005ch		;a76d   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS resto_A770: lo apuntan con el banco puesto p03:A74F (0xA770); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p03:A74F (8 bytes)
;   0xa770..0xa778  (8 bytes)
DATA_resto_A770:
	defb 000h,010h,018h,0fch,0feh,0fch,018h,010h	; a770  ........

; ======================================================================
; CODIGO 0xa778..0xa941  (457 bytes)
; ======================================================================


cursor_pinta_b:		; pinta el cursor (':' o el de MSX2)
	ld hl,(0d168h)		;a778
	ld a,(0d4d3h)		;a77b
	and a			;a77e
	ld a,03ah		;a77f
	jr z,L_A785		;a781
	ld a,010h		;a783
L_A785:
	jp 0004dh		;a785   ; BIOS WRTVRM - Writes data in VRAM
cursor_borra_b:		; borra el cursor
	ld hl,(0d168h)		;a788
	xor a			;a78b
	jp 0004dh		;a78c   ; BIOS WRTVRM - Writes data in VRAM
opcion_cero:		; si no hay opcion elegida, vuelve al menu (gemela de p01:766D)
	ld a,(0d165h)		;a78f
	or a			;a792
	ret nz			;a793
	pop hl			;a794
	jp L_A677		;a795
menu_con_esc:		; menu: espacio elige, ESC sale (gemela de p01:7676)
	call menu_prepara		;a798   ; menu_prepara: prepara el menu: opciones, posicion y cursor (gemela de p01:76AF)
	call menu_limpia_b		;a79b   ; menu_limpia_b: quita el cursor y borra el teclado
L_A79E:
	call 0009fh		;a79e   ; BIOS CHGET - One character input (waiting)
	cp 020h		;a7a1
	jr z,L_A7C0		;a7a3
	cp 01bh		;a7a5
	jr z,L_A7AF		;a7a7
	ld b,a			;a7a9
	call menu_cursor		;a7aa   ; menu_cursor: mueve el cursor con las flechas (0x1E arriba, 0x1F abajo) (gemela de p01:76C1)
	jr L_A79E		;a7ad
L_A7AF:
	or 0ffh		;a7af
	ret			;a7b1
menu_vertical:		; menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	call menu_prepara		;a7b2   ; menu_prepara: prepara el menu: opciones, posicion y cursor (gemela de p01:76AF)
	call menu_limpia_b		;a7b5   ; menu_limpia_b: quita el cursor y borra el teclado
L_A7B8:
	call 0009fh		;a7b8   ; BIOS CHGET - One character input (waiting)
	cp 020h		;a7bb
	ld b,a			;a7bd
	jr nz,L_A7CB		;a7be
L_A7C0:
	call cursor_borra_b		;a7c0   ; cursor_borra_b: borra el cursor
	ld a,(0d165h)		;a7c3
	ld (0d163h),a		;a7c6
	or a			;a7c9
	ret			;a7ca
L_A7CB:
	call menu_cursor		;a7cb   ; menu_cursor: mueve el cursor con las flechas (0x1E arriba, 0x1F abajo) (gemela de p01:76C1)
	jp L_A7B8		;a7ce
menu_prepara:		; prepara el menu: opciones, posicion y cursor (gemela de p01:76AF)
	ld a,b			;a7d1
	dec a			;a7d2
	ld (0d164h),a		;a7d3
	ld (0d16ah),hl		;a7d6
	ld a,(hl)			;a7d9
	inc hl			;a7da
	ld h,(hl)			;a7db
	ld l,a			;a7dc
	ld (0d168h),hl		;a7dd
	jp cursor_pinta_b		;a7e0   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
menu_cursor:		; mueve el cursor con las flechas (0x1E arriba, 0x1F abajo) (gemela de p01:76C1)
	ld c,0ffh		;a7e3
	cp 01eh		;a7e5
	jr z,L_A7EE		;a7e7
	ld c,001h		;a7e9
	cp 01fh		;a7eb
	ret nz			;a7ed
L_A7EE:
	ld hl,0d164h		;a7ee
	ld de,0d165h		;a7f1
	ld a,(de)			;a7f4
	add a,c			;a7f5
	jp p,L_A7FA		;a7f6
	ld a,(hl)			;a7f9
L_A7FA:
	cp (hl)			;a7fa
	jr c,L_A800		;a7fb
	jr z,L_A800		;a7fd
	xor a			;a7ff
L_A800:
	ld (de),a			;a800
	ld b,a			;a801
	ld hl,(0d16ah)		;a802
	add a,a			;a805
	call hl_mas_a		;a806   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;a809
	inc hl			;a80a
	ld h,(hl)			;a80b
	ld l,a			;a80c
	push hl			;a80d
	call cursor_borra_b		;a80e   ; cursor_borra_b: borra el cursor
	pop hl			;a811
	ld (0d168h),hl		;a812
	jp cursor_pinta_b		;a815   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
menu_limpia_b:		; quita el cursor y borra el teclado
	call cursor_apaga_b		;a818   ; cursor_apaga_b: quita el cursor
	call 00156h		;a81b   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;a81e
	ld (0d163h),a		;a81f
	ld (0d165h),a		;a822
	ld (0d166h),a		;a825
	ret			;a828
comprime:		; comprime 0x8802 en 0x8002 (lo contrario de p01:733A) (gemela de p01:7707)
	ld hl,0c442h		;a829
	ld de,0c002h		;a82c
L_A82F:
	ld a,081h		;a82f
	ld (0d13eh),a		;a831
	ld c,(hl)			;a834
	ld (0d13fh),de		;a835
	inc de			;a839
	ld a,c			;a83a
	ld (de),a			;a83b
	inc hl			;a83c
	inc de			;a83d
	call fin_de_8882		;a83e   ; fin_de_8882: compara HL con 0x8882 (gemela de p01:7790)
	jp z,L_A8D1		;a841
	ld a,c			;a844
	cp (hl)			;a845
	jr z,L_A885		;a846
	ld a,001h		;a848
	ld (0d13eh),a		;a84a
L_A84D:
	ld c,(hl)			;a84d
	inc hl			;a84e
	ld a,c			;a84f
	ld (de),a			;a850
	inc de			;a851
	call fin_de_8882		;a852   ; fin_de_8882: compara HL con 0x8882 (gemela de p01:7790)
	jp z,L_A8C8		;a855
	cp (hl)			;a858
	jr nz,L_A878		;a859
	inc hl			;a85b
	call fin_de_8882		;a85c   ; fin_de_8882: compara HL con 0x8882 (gemela de p01:7790)
	jr z,L_A8BD		;a85f
	cp (hl)			;a861
	dec hl			;a862
	jr nz,L_A878		;a863
L_A865:
	dec hl			;a865
	dec de			;a866
	push hl			;a867
	ld hl,(0d13fh)		;a868
	ld a,(0d13eh)		;a86b
	set 7,a		;a86e
	ld (hl),a			;a870
	pop hl			;a871
	ld (0d13fh),de		;a872
	jr L_A82F		;a876
L_A878:
	ld a,(0d13eh)		;a878
	cp 07bh		;a87b
	jr z,L_A865		;a87d
	inc a			;a87f
	ld (0d13eh),a		;a880
	jr L_A84D		;a883
L_A885:
	ld a,002h		;a885
	ld (0d13eh),a		;a887
L_A88A:
	inc hl			;a88a
	call fin_de_8882		;a88b   ; fin_de_8882: compara HL con 0x8882 (gemela de p01:7790)
	jr z,L_A8D1		;a88e
	ld a,c			;a890
	cp (hl)			;a891
	jr z,L_A8A5		;a892
L_A894:
	ld de,(0d13fh)		;a894
	ld a,(0d13eh)		;a898
	ld (de),a			;a89b
	inc de			;a89c
	inc de			;a89d
	ld (0d13fh),de		;a89e
	jp L_A82F		;a8a2
L_A8A5:
	ld a,(0d13eh)		;a8a5
	cp 07bh		;a8a8
	jr z,L_A894		;a8aa
	inc a			;a8ac
	ld (0d13eh),a		;a8ad
	jr L_A88A		;a8b0
fin_de_8882:		; compara HL con 0x8882 (gemela de p01:7790)
	push hl			;a8b2
	push de			;a8b3
	ld de,0c4c2h		;a8b4
	and a			;a8b7
	sbc hl,de		;a8b8
	pop de			;a8ba
	pop hl			;a8bb
	ret			;a8bc
L_A8BD:
	dec hl			;a8bd
	ld a,(hl)			;a8be
	ld (de),a			;a8bf
	inc de			;a8c0
	ld a,(0d13eh)		;a8c1
	inc a			;a8c4
	ld (0d13eh),a		;a8c5
L_A8C8:
	ld a,(0d13eh)		;a8c8
	inc a			;a8cb
	set 7,a		;a8cc
	ld (0d13eh),a		;a8ce
L_A8D1:
	xor a			;a8d1
	ld (de),a			;a8d2
	ld a,(0d13eh)		;a8d3
	ld hl,(0d13fh)		;a8d6
	ld (hl),a			;a8d9
	ex de,hl			;a8da
	ld de,0c001h		;a8db
	and a			;a8de
	sbc hl,de		;a8df
	ld (0c000h),hl		;a8e1   ; guarda el codigo de p00:4A9A en RAM y el byte siguiente (16 bits)
	ret			;a8e4
menu_principal:		; el menu del Game Master: engancha H.TIMI y pinta (gemela de p01:7973)
	di			;a8e5
	ld hl,0a965h		;a8e6
	ld de,0fd9fh		;a8e9
	ld bc,00003h		;a8ec
	ldir		;a8ef
	ld hl,00000h		;a8f1
	add hl,sp			;a8f4
	ld (0f000h),hl		;a8f5
	ei			;a8f8
	call 0448dh		;a8f9   ; borra_pantalla: borra la tabla de nombres (0x3800, 0x300 bytes)
	ld hl,0e000h		;a8fc   ; apunta a opcion / RC del juego
	ld de,0e001h		;a8ff   ; apunta a fila elegida de la SRAM
	ld bc,00fffh		;a902
	ld (hl),000h		;a905
	ldir		;a907
	ld hl,(00004h)		;a909
	ld de,02000h		;a90c
	ld bc,007f0h		;a90f
	call copia_tercios		;a912   ; copia_tercios: LDIRVM en los tres tercios de la pantalla (gemela de p01:730D)
	ld hl,00000h		;a915
	ld bc,007f0h		;a918
	ld a,0f0h		;a91b
	call rellena_tercios		;a91d   ; rellena_tercios: FILVRM en los tres tercios de la pantalla (gemela de p01:72FC)
	ld a,(0d12eh)		;a920   ; lee el slot del juego (copia)
	ld (0e000h),a		;a923   ; guarda opcion / RC del juego
	ld a,001h		;a926
	ld (0d4d3h),a		;a928
L_A92B:
	ld hl,04123h		;a92b
	call pinta_texto_b		;a92e   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld b,004h		;a931
	ld hl,04175h		;a933
	call menu_vertical		;a936   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	push af			;a939
	call 044adh		;a93a   ; borra_zona_3ac0: borra 0x3AC0 (0x20 bytes) letra a letra
	pop af			;a93d
	call despacha		;a93e   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_A941: tabla de 4 palabras del despachador (call 0x408D en
;   0xA93E); lo leen el despachador (8 bytes)
;   0xa941..0xa949  (8 bytes)
DATA_saltos_A941:
	defb 053h,0a9h	; a941
	defb 059h,0a9h	; a943
	defb 05fh,0a9h	; a945
	defb 049h,0a9h	; a947

; ======================================================================
; CODIGO 0xa949..0xa98c  (67 bytes)
; ======================================================================


L_A949:
	ld a,0c9h		;a949
	ld (0fd9fh),a		;a94b
	xor a			;a94e
	ld (0d4d3h),a		;a94f
	ret			;a952
L_A953:
	call 0417dh		;a953   ; menu_sram: el menu de la SRAM: limpia 0xE010, pinta y lee teclas
	jp L_A92B		;a956
L_A959:
	call 04209h		;a959   ; menu_borrar: pide el nombre de 5 letras a borrar (0xE250) y lo busca
	jp L_A92B		;a95c
L_A95F:
	call 04333h		;a95f   ; pregunta_formatear: pregunta si se formatea (Y/N) y llama a la SRAM
	jp L_A92B		;a962
L_A965:
	jp L_A968		;a965
L_A968:
	ld a,006h		;a968
	call 00141h		;a96a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;a96d
	jp nz,0013eh		;a96f   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;a972
	call 00141h		;a974   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;a977
	jp c,0013eh		;a978   ; BIOS RDVDP - Reads VDP status register
	xor a			;a97b
	ld (0d4d3h),a		;a97c
	ld a,0c9h		;a97f
	ld (0fd9fh),a		;a981
	call 0013eh		;a984   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f000h)		;a987
	ld sp,hl			;a98a
	ret			;a98b

; ----------------------------------------------------------------------
; DATOS relleno_ff: 5748 bytes a 0xFF hasta el final del banco: relleno; lo
;   leen nadie (5748 bytes)
;   0xa98c..0xc000  (5748 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a98c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a99c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; a9fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aa9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aaac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aabc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aacc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aadc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aaec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aafc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ab9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; abfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ac9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; accc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; acfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ad9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; addc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; adfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ae9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aeac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aebc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aecc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aedc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aeec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; aefc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; af9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; afec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; affc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b00c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b01c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b02c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b03c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b04c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b05c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b06c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b07c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b08c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b09c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b0fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b10c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b11c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b12c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b13c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b14c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b15c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b16c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b17c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b18c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b19c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b1fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b20c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b21c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b22c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b23c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b24c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b25c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b26c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b27c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b28c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b29c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b2fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b30c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b31c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b32c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b33c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b34c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b35c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b36c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b37c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b38c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b39c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b3fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b40c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b41c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b42c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b43c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b44c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b45c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b46c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b47c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b48c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b49c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b4fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b50c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b51c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b52c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b53c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b54c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b55c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b56c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b57c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b58c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b59c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b5fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b60c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b61c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b62c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b63c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b64c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b65c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b66c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b67c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b68c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b69c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b6fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b70c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b71c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b72c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b73c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b74c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b75c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b76c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b77c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b78c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b79c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b7fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b80c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b81c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b82c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b83c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b84c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b85c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b86c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b87c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b88c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b89c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b8fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b90c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b91c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b92c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b93c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b94c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b95c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b96c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b97c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b98c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b99c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9bc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9cc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9dc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9ec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; b9fc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; ba9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; baac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; babc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bacc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; badc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; baec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bafc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bb9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bbfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bc9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bccc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bcfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bd9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bddc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bdfc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; be9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bebc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; becc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bedc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; beec  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; befc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf0c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf1c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf2c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf3c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf4c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf5c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf6c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf7c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf8c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bf9c  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfac  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfbc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfcc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfdc  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; bfec  ................
	defb 0ffh,0ffh,0ffh,0ffh	; bffc
