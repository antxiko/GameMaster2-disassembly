; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 05 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ======================================================================
; CODIGO 0x8000..0x82d7  (727 bytes)
; ======================================================================


bio_arranca:		; el biorritmo: guarda la pila, borra 0xE000, engancha H.TIMI y sigue en el bucle de p05:8B14
	di			;8000   ; sin interrupciones
	ld hl,00000h		;8001   ; guarda la pila...
	add hl,sp			;8004
	ld (0f0f6h),hl		;8005   ; ...en 0xF0F6
	ld hl,0e000h		;8008   ; borra 0xE000-0xF0F4
	ld de,0e001h		;800b   ; apunta a el contador de cuadros
	ld bc,010f4h		;800e
	ld (hl),000h		;8011
	ldir		;8013
	ld hl,L_8030		;8015   ; H.TIMI salta a p05:8033: la salida con CTRL+STOP
	ld de,0fd9fh		;8018   ; apunta a el gancho H.TIMI
	ld bc,00003h		;801b
	ldir		;801e
	ld a,(0002dh)		;8020   ; 0 = MSX1...
	nop			;8023
	ld (0f0f5h),a		;8024   ; ...a 0xF0F5
	call bio_pantalla		;8027   ; bio_pantalla: prepara la pantalla: MSX1 (p05:873D) o MSX2 (p05:8768) segun 0xF0F5
	call bio_graficos		;802a   ; bio_graficos: los graficos: MSX1 (p05:8C73) o MSX2 (p05:8D22) segun 0xF0F5
	jp L_8B14		;802d   ; y el bucle del biorritmo
L_8030:
	jp L_8033		;8030
L_8033:
	call 0013eh		;8033   ; BIOS RDVDP - Reads VDP status register
	ld a,006h		;8036
	call 00141h		;8038   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;803b
	jp nz,0013eh		;803d   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;8040
	call 00141h		;8042   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;8045
	jp c,0013eh		;8046   ; BIOS RDVDP - Reads VDP status register
	ld a,0c9h		;8049
	ld (0fd9fh),a		;804b   ; guarda el gancho H.TIMI
	call 0013eh		;804e   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f0f6h)		;8051
	ld sp,hl			;8054
	ret			;8055
bio_pantalla:		; prepara la pantalla: MSX1 (p05:873D) o MSX2 (p05:8768) segun 0xF0F5
	ld a,(0f0f5h)		;8056
	and a			;8059
	jr nz,L_805F		;805a
	jp L_873D		;805c
L_805F:
	jp L_8768		;805f
bio_graficos:		; los graficos: MSX1 (p05:8C73) o MSX2 (p05:8D22) segun 0xF0F5
	ld a,(0f0f5h)		;8062
	and a			;8065
	jr nz,L_806B		;8066
	jp L_8C73		;8068
L_806B:
	jp L_8D22		;806b
hl_mas_a:		; HL = HL + A (gemela de p01:7251)
	add a,l			;806e
	ld l,a			;806f
	ret nc			;8070
	inc h			;8071
	ret			;8072
de_mas_a:		; DE = DE + A (gemela de p01:7256)
	add a,e			;8073
	ld e,a			;8074
	ret nc			;8075
	inc d			;8076
	ret			;8077
despacha:		; salta a la palabra A de la tabla pegada detras del `call`
	pop hl			;8078
	add a,a			;8079
	call hl_mas_a		;807a   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;807d
	inc hl			;807e
	ld d,(hl)			;807f
	ex de,hl			;8080
	jp (hl)			;8081
th_vram_escribe:		; SETWRT en HL y C = el puerto de datos del VDP (gemela de p07:85E2)
	ex af,af'			;8082
	call 00053h		;8083   ; BIOS SETWRT - Enables VDP to write
	exx			;8086
	ld a,(00007h)		;8087   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;808a
	exx			;808b
	ex af,af'			;808c
	ret			;808d
L_808E:
	call 00050h		;808e   ; BIOS SETRD - Enables VDP to read
	exx			;8091
	ld a,(00006h)		;8092   ; el puerto de lectura del VDP (VDP.DR)
	ld c,a			;8095
	exx			;8096
	ret			;8097
copia_a_vram_de:		; LDIRVM de DE a HL
	ex de,hl			;8098
	jp 0005ch		;8099   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_809C:
	exx			;809c
	ld b,003h		;809d
L_809F:
	exx			;809f   ; B tercios: copia a la VRAM
	push bc			;80a0
	push de			;80a1
	call copia_a_vram_de		;80a2   ; copia_a_vram_de: LDIRVM de DE a HL
	ld de,00800h		;80a5   ; el tercio siguiente esta 0x800 mas alla
	add hl,de			;80a8
	pop de			;80a9
	pop bc			;80aa
	exx			;80ab
	djnz L_809F		;80ac   ; los B tercios
	ret			;80ae
th_rellena_tercios:		; FILVRM en los tres tercios (gemela de p07:8605)
	ld d,003h		;80af
L_80B1:
	push bc			;80b1
	push de			;80b2
	call 00056h		;80b3   ; BIOS FILVRM - Fills VRAM with value
	ld de,00800h		;80b6
	add hl,de			;80b9
	pop de			;80ba
	pop bc			;80bb
	dec d			;80bc
	jr nz,L_80B1		;80bd
	ret			;80bf
th_descomprime_tercios:		; descomprime DE en los tres tercios (gemela de p07:8616)
	ld b,003h		;80c0
L_80C2:
	push bc			;80c2
	push de			;80c3
	call th_descomprime		;80c4   ; th_descomprime: descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba (gemela de p07:8647)
	ld de,00800h		;80c7
	add hl,de			;80ca
	pop de			;80cb
	pop bc			;80cc
	djnz L_80C2		;80cd
	ret			;80cf
pinta_texto_bio:		; pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	call pinta_texto_bio_b		;80d0   ; pinta_texto_bio_b: pinta un texto con la mascara C
	ret			;80d3
pinta_texto_bio_b:		; pinta un texto con la mascara C
	ld c,0ffh		;80d4
L_80D6:
	ex de,hl			;80d6   ; HL = la direccion que viene en el texto
	ld e,(hl)			;80d7
	inc hl			;80d8
	ld d,(hl)			;80d9
	ex de,hl			;80da
	inc de			;80db   ; y sigue con la letra siguiente
pinta_letras_bio:		; pinta letras hasta 0x80 (0x81 trae otra direccion)
	ld a,(de)			;80dc   ; una letra
	inc de			;80dd
	cp 080h		;80de   ; 0x80 acaba
	ret z			;80e0
	cp 081h		;80e1   ; 0x81: otra direccion
	jr z,L_80D6		;80e3
	and c			;80e5   ; con la mascara C
	ld (hl),a			;80e6   ; a la copia de nombres (HL)
	inc hl			;80e7
	jr pinta_letras_bio		;80e8
L_80EA:
	call pinta_texto_bio_c		;80ea   ; pinta_texto_bio_c: pinta un texto con la mascara 0
pinta_texto_bio_c:		; pinta un texto con la mascara 0
	ld c,000h		;80ed
	jr L_80D6		;80ef
L_80F1:
	ex de,hl			;80f1   ; HL = la direccion de VRAM que viene en el bloque
	ld e,(hl)			;80f2
	inc hl			;80f3
	ld d,(hl)			;80f4
	ex de,hl			;80f5
	inc de			;80f6
th_descomprime:		; descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba (gemela de p07:8647)
	call th_vram_escribe		;80f7   ; th_vram_escribe: SETWRT en HL y C = el puerto de datos del VDP (gemela de p07:85E2)
L_80FA:
	ld a,(de)			;80fa   ; el byte de cuenta
	and a			;80fb
	ret z			;80fc   ; 0 acaba
	inc de			;80fd
	ld b,a			;80fe
	and 07fh		;80ff   ; n & 0x7F...
	cp b			;8101   ; ...si es el mismo, bit 7 a 0: repetir
	jr z,L_8112		;8102
	and a			;8104   ; 0x80: otra direccion de VRAM
	jr z,L_80F1		;8105
	ld b,a			;8107   ; bit 7 a 1: copiar n bytes
L_8108:
	ld a,(de)			;8108   ; un byte...
	inc de			;8109
	exx			;810a
	out (c),a		;810b   ; ...a la VRAM
	exx			;810d
	djnz L_8108		;810e   ; los n bytes
	jr L_80FA		;8110
L_8112:
	ld a,(de)			;8112
	inc de			;8113
L_8114:
	exx			;8114
	out (c),a		;8115
	exx			;8117
	djnz L_8114		;8118
	jr L_80FA		;811a
L_811C:
	call vram_situa_lee		;811c   ; vram_situa_lee: pone la direccion de 17 bits de la VRAM para leer
	call cuenta_otir		;811f   ; cuenta_otir: A y B para un OTIR de BC bytes (gemela de p09:8DEE)
	ex af,af'			;8122
	ld a,(00006h)		;8123   ; el puerto de lectura del VDP (VDP.DR)
	ld c,a			;8126
	ex af,af'			;8127
L_8128:
	inir		;8128
	dec a			;812a
	jr nz,L_8128		;812b
	ex de,hl			;812d
	ret			;812e
cuenta_otir:		; A y B para un OTIR de BC bytes (gemela de p09:8DEE)
	ex de,hl			;812f
	ld a,c			;8130   ; BC bytes: B vueltas de 256...
	or a			;8131
	ld a,b			;8132
	ld b,c			;8133
	ret z			;8134   ; ...si C es 0, justas
	inc a			;8135   ; si no, una mas
	ret			;8136
escribe_vram_otir:		; escribe BC bytes de HL en la VRAM DE con OTIR (gemela de p09:8DF6)
	ex de,hl			;8137
	call vram_situa_128k		;8138   ; vram_situa_128k: pone la direccion de 17 bits de la VRAM (R
	call cuenta_otir		;813b   ; cuenta_otir: A y B para un OTIR de BC bytes (gemela de p09:8DEE)
	ex af,af'			;813e
	ld a,(00007h)		;813f   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;8142
	ex af,af'			;8143
L_8144:
	otir		;8144
	dec a			;8146
	jr nz,L_8144		;8147
	ret			;8149
rellena_vram_128k:		; rellena BC bytes de la VRAM HL (128 KB) con A
	push de			;814a
	push af			;814b
	call vram_situa_128k		;814c   ; vram_situa_128k: pone la direccion de 17 bits de la VRAM (R
	ld d,c			;814f
	ld a,c			;8150
	or a			;8151
	jr z,L_8155		;8152
	inc b			;8154
L_8155:
	ld a,(00007h)		;8155   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;8158
	pop af			;8159
L_815A:
	out (c),a		;815a   ; un byte a la VRAM
	dec d			;815c   ; D vueltas...
	jr nz,L_815A		;815d
	djnz L_815A		;815f   ; ...por B
	pop de			;8161
	ret			;8162
lee_vram_byte:		; lee el byte de la VRAM HL (128 KB)
	push bc			;8163
	call vram_situa_lee		;8164   ; vram_situa_lee: pone la direccion de 17 bits de la VRAM para leer
	ld a,(00006h)		;8167   ; el puerto de lectura del VDP (VDP.DR)
	ld c,a			;816a
	in a,(c)		;816b
	pop bc			;816d
	ret			;816e
escribe_vram_byte:		; escribe A en la VRAM HL (128 KB)
	push bc			;816f
	push af			;8170
	call vram_situa_128k		;8171   ; vram_situa_128k: pone la direccion de 17 bits de la VRAM (R
	ld a,(00007h)		;8174   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;8177
	pop af			;8178
	out (c),a		;8179
	pop bc			;817b
	ret			;817c
vram_situa_128k:		; pone la direccion de 17 bits de la VRAM (R
	push bc			;817d
	ld a,(00007h)		;817e   ; el puerto de los registros (VDP.DW + 1)
	inc a			;8181
	ld c,a			;8182
	ld a,h			;8183   ; los dos bits altos de la direccion...
	rlca			;8184
	rlca			;8185
	and 003h		;8186
	di			;8188
	out (c),a		;8189   ; ...a R#14
	ld a,08eh		;818b
	out (c),a		;818d
	ld a,l			;818f   ; la parte baja
	out (c),a		;8190
	ld a,h			;8192   ; y la alta con el bit de escritura (0x40)
	and 03fh		;8193
	or 040h		;8195
	out (c),a		;8197
	pop bc			;8199
	ei			;819a
	ret			;819b
vram_situa_lee:		; pone la direccion de 17 bits de la VRAM para leer
	push bc			;819c
	ld a,(00007h)		;819d   ; el puerto de los registros (VDP.DW + 1)
	inc a			;81a0
	ld c,a			;81a1
	ld a,h			;81a2   ; los dos bits altos de la direccion...
	rlca			;81a3
	rlca			;81a4
	and 003h		;81a5
	di			;81a7
	out (c),a		;81a8   ; ...a R#14
	ld a,08eh		;81aa
	out (c),a		;81ac
	ld a,l			;81ae   ; la parte baja
	out (c),a		;81af
	ld a,h			;81b1   ; y la alta, sin el bit de escritura: para leer
	and 03fh		;81b2
	out (c),a		;81b4
	pop bc			;81b6
	ei			;81b7
	ret			;81b8
L_81B9:
	ld c,000h		;81b9
L_81BB:
	ex de,hl			;81bb   ; HL = la direccion de VRAM que viene en el bloque
	ld e,(hl)			;81bc
	inc hl			;81bd
	ld d,(hl)			;81be
	inc hl			;81bf
	ex de,hl			;81c0
L_81C1:
	call vram_situa_128k		;81c1   ; vram_situa_128k: pone la direccion de 17 bits de la VRAM (R
	exx			;81c4
	ld a,(00007h)		;81c5   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;81c8
	exx			;81c9
L_81CA:
	ld a,(de)			;81ca   ; el byte de cuenta
	and a			;81cb
	ret z			;81cc   ; 0 acaba
	inc de			;81cd
	ld b,a			;81ce
	and 07fh		;81cf   ; n & 0x7F...
	cp b			;81d1   ; ...si es el mismo, bit 7 a 0: repetir
	jr z,L_81E3		;81d2
	and a			;81d4   ; 0x80: otra direccion de VRAM
	jr z,L_81B9		;81d5
	ld b,a			;81d7   ; bit 7 a 1: copiar n bytes
L_81D8:
	call lee_y_espeja		;81d8   ; lee_y_espeja: lee el byte de DE y, si C lleva el bit 0, le da la vuelta
	exx			;81db
	out (c),a		;81dc
	exx			;81de
	djnz L_81D8		;81df
	jr L_81CA		;81e1
L_81E3:
	call lee_y_espeja		;81e3   ; lee_y_espeja: lee el byte de DE y, si C lleva el bit 0, le da la vuelta
L_81E6:
	exx			;81e6
	out (c),a		;81e7
	exx			;81e9
	djnz L_81E6		;81ea
	jr L_81CA		;81ec
descomprime_bio:		; descomprime en la VRAM con C = 0
	ld c,000h		;81ee
	jr L_81C1		;81f0
L_81F2:
	ld c,001h		;81f2
	jr L_81BB		;81f4
L_81F6:
	ld c,001h		;81f6
	jr L_81C1		;81f8
L_81FA:
	call espejo_16		;81fa   ; espejo_16: escribe 16 bytes de la VRAM dados la vuelta (bit a bit)
	ld a,020h		;81fd
	call de_mas_a		;81ff   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	dec c			;8202
	jr nz,L_81FA		;8203
	ret			;8205
L_8206:
	call espejo_16		;8206   ; espejo_16: escribe 16 bytes de la VRAM dados la vuelta (bit a bit)
	ld a,0e0h		;8209
	add a,e			;820b
	ld e,a			;820c
	jr c,L_8210		;820d
	dec d			;820f
L_8210:
	call espejo_16		;8210   ; espejo_16: escribe 16 bytes de la VRAM dados la vuelta (bit a bit)
	ld a,060h		;8213
	call de_mas_a		;8215   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	dec c			;8218
	jr nz,L_8206		;8219
	ret			;821b
espejo_16:		; escribe 16 bytes de la VRAM dados la vuelta (bit a bit)
	push de			;821c
L_821D:
	ld b,010h		;821d
L_821F:
	ex de,hl			;821f   ; un byte de la VRAM...
	call lee_vram_byte		;8220   ; lee_vram_byte: lee el byte de la VRAM HL (128 KB)
	ex de,hl			;8223
	call espeja_byte		;8224   ; ...al reves...
	call escribe_vram_byte		;8227   ; ...se escribe en HL
	inc e			;822a   ; el siguiente
	inc hl			;822b
	djnz L_821F		;822c   ; los B bytes
	ld a,e			;822e   ; la fila de patrones anterior (-32)
	sub 020h		;822f
	ld e,a			;8231
	bit 4,e		;8232   ; hasta que el bit 4 de E diga que acabo
	jr z,L_821D		;8234
	pop de			;8236
	ret			;8237
lee_y_espeja:		; lee el byte de DE y, si C lleva el bit 0, le da la vuelta
	ld a,(de)			;8238
	inc de			;8239
	bit 0,c		;823a
	ret z			;823c
espeja_byte:		; da la vuelta a los 8 bits de A
	push bc			;823d
	ld c,a			;823e
	ld b,008h		;823f
L_8241:
	rr c		;8241
	rla			;8243
	djnz L_8241		;8244
	pop bc			;8246
	ret			;8247
L_8248:
	call esconde_sprites_msx2		;8248   ; esconde_sprites_msx2: 0xD8 en la tabla de sprites del MSX2 (0xF600)
	call pantalla_apagada		;824b   ; pantalla_apagada: R#1 sin el bit 6: pantalla apagada
	ld hl,00000h		;824e
	ld bc,00000h		;8251
	xor a			;8254
	ld d,000h		;8255
	call vdp_hmmv		;8257   ; vdp_hmmv: rellena un rectangulo de VRAM (HMMV, comando 0xC0) (gemela de p09:8F41)
	ld b,000h		;825a
	ld c,017h		;825c
	call 00047h		;825e   ; BIOS WRTVDP - Writes data in the VDP-register
pantalla_encendida:		; R#1 con el bit 6: pantalla encendida
	ld a,(0f3e0h)		;8261   ; lee el registro 1 del VDP (copia de la BIOS)
	or 040h		;8264
	ld b,a			;8266
	ld c,001h		;8267
	call 00047h		;8269   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_encendidos		;826c
pantalla_apagada:		; R#1 sin el bit 6: pantalla apagada
	ld a,(0f3e0h)		;826e   ; lee el registro 1 del VDP (copia de la BIOS)
	and 0bfh		;8271
	ld b,a			;8273
	ld c,001h		;8274
	call 00047h		;8276   ; BIOS WRTVDP - Writes data in the VDP-register
	jr sprites_apagados		;8279
esconde_sprites_msx2:		; 0xD8 en la tabla de sprites del MSX2 (0xF600)
	ld hl,0f600h		;827b
	ld a,0d8h		;827e
	jp escribe_vram_byte		;8280   ; escribe_vram_byte: escribe A en la VRAM HL (128 KB)
sprites_apagados:		; R
	ld a,(0ffe7h)		;8283   ; lee el registro 8 del VDP (copia de la BIOS)
	or 002h		;8286
	ld b,a			;8288
	ld c,008h		;8289
	jp 00047h		;828b   ; BIOS WRTVDP - Writes data in the VDP-register
sprites_encendidos:		; R
	ld a,(0ffe7h)		;828e   ; lee el registro 8 del VDP (copia de la BIOS)
	and 0fdh		;8291
	ld b,a			;8293
	ld c,008h		;8294
	jp 00047h		;8296   ; BIOS WRTVDP - Writes data in the VDP-register
pon_color:		; MSX2: el color B de la paleta con D y E (R#16 y puerto 2)
	push bc			;8299
	push hl			;829a
	ld b,a			;829b   ; B = el numero de color
	ld a,(00007h)		;829c   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;829f
	ld c,a			;82a0
	di			;82a1
	out (c),b		;82a2   ; el numero de color...
	ld a,090h		;82a4   ; ...a R#16, el puntero de la paleta
	out (c),a		;82a6
	inc c			;82a8   ; el puerto de la paleta
	out (c),d		;82a9   ; rojo y azul
	push af			;82ab   ; una pausa para el VDP
	pop af			;82ac
	out (c),e		;82ad   ; verde
	dec c			;82af
	ld hl,0f680h		;82b0   ; y lo copia tambien en la tabla de la paleta de la VRAM (0xF680 + 2 x color)
	ld a,b			;82b3
	add a,a			;82b4
	add a,l			;82b5
	ld l,a			;82b6
	call vram_situa_128k		;82b7   ; vram_situa_128k: pone la direccion de 17 bits de la VRAM (R
	dec c			;82ba
	out (c),d		;82bb   ; rojo y azul...
	out (c),e		;82bd   ; ...y verde
	pop hl			;82bf
	pop bc			;82c0
	ei			;82c1
	ret			;82c2
paleta_bio:		; MSX2: los 16 colores de p05:82D7
	ld hl,082d7h		;82c3
paleta_desde:		; MSX2: los 16 colores de HL
	ld b,010h		;82c6
	ld a,000h		;82c8
L_82CA:
	ld d,(hl)			;82ca   ; rojo y azul
	inc hl			;82cb
	ld e,(hl)			;82cc   ; verde
	inc hl			;82cd
	push af			;82ce
	call pon_color		;82cf   ; el color A
	pop af			;82d2
	inc a			;82d3   ; el siguiente
	djnz L_82CA		;82d4   ; los B colores
	ret			;82d6

; ----------------------------------------------------------------------
; DATOS resto_82D7: lo apuntan con el banco puesto p05:82C3 (0x82D7); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:82C3 (46 bytes)
;   0x82d7..0x8305  (46 bytes)
DATA_resto_82D7:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 82d7  ......3...'.Q.'.
	defb 071h,001h,073h,003h,061h,006h,064h,006h,011h,004h,065h,002h,055h,005h,077h,007h	; 82e7  q.s.a.d...e.U.w.
	defb 07eh,023h,03ch,0c8h,03dh,056h,023h,05eh,023h,0cdh,099h,082h,018h,0f2h	; 82f7  ~#<.=V#^#.....

; ======================================================================
; CODIGO 0x8305..0x8758  (1107 bytes)
; ======================================================================


espera_vdp:		; espera a que el VDP acabe el comando (bit 0 de S#2)
	ld a,002h		;8305
	call lee_estado_vdp		;8307   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	rra			;830a
	jp c,espera_vdp		;830b   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	ret			;830e
lee_estado_vdp:		; lee el registro de estado A del VDP (R
	push bc			;830f
	push hl			;8310
	ld hl,(00006h)		;8311   ; los puertos del VDP
	inc h			;8314   ; C = el de los registros
	inc l			;8315
	ld c,h			;8316
	di			;8317
	out (c),a		;8318   ; el numero de registro de estado...
	ld a,08fh		;831a   ; ...a R#15
	out (c),a		;831c
	ld c,l			;831e
	in a,(c)		;831f   ; lo lee
	push af			;8321
	xor a			;8322   ; y deja R#15 en 0
	ld c,h			;8323
	out (c),a		;8324
	ld a,08fh		;8326
	out (c),a		;8328
	pop af			;832a
	pop hl			;832b
	pop bc			;832c
	ei			;832d
	ret			;832e
vdp_linea:		; traza una linea con el comando del VDP (LINE, 0x70) de HL con el largo de la pila; el lado largo en horizontal
	call espera_vdp		;832f   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	push bc			;8332   ; guarda el largo
	ld a,(00007h)		;8333   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;8336
	ld c,a			;8337
	ld a,024h		;8338   ; R#17 = 36 (DX) con incremento
	di			;833a
	out (c),a		;833b
	ld a,091h		;833d
	out (c),a		;833f
	inc c			;8341
	inc c			;8342
	out (c),h		;8343   ; DX = H
	xor a			;8345
	out (c),a		;8346
	out (c),l		;8348   ; DY = L
	out (c),a		;834a
	pop hl			;834c
	out (c),h		;834d   ; NX = el lado largo (de la pila); 0 vale 256
	xor a			;834f
	cp h			;8350
	jr nz,L_8354		;8351
	inc a			;8353
L_8354:
	out (c),a		;8354   ; su parte alta
	xor a			;8356
	out (c),a		;8357
	out (c),a		;8359
	out (c),l		;835b   ; NY = el lado corto
	out (c),a		;835d   ; ARG = 0: el lado largo en horizontal
	ld a,070h		;835f   ; CMD = 0x70: LINE
	out (c),a		;8361
	ei			;8363
	ret			;8364
vdp_linea_vertical:		; traza una linea con el comando del VDP (LINE, 0x70) con el lado largo en vertical (ARG = 1)
	call espera_vdp		;8365   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	push bc			;8368
	ld a,(00007h)		;8369   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;836c
	ld c,a			;836d
	ld a,024h		;836e   ; R#17 = 36 (DX) con incremento
	di			;8370
	out (c),a		;8371
	ld a,091h		;8373
	out (c),a		;8375
	inc c			;8377
	inc c			;8378
	out (c),h		;8379   ; DX = H
	xor a			;837b
	out (c),a		;837c
	out (c),l		;837e   ; DY = L
	out (c),a		;8380
	pop hl			;8382
	out (c),h		;8383   ; NX = el lado largo; 0 vale 256
	xor a			;8385
	cp h			;8386
	jr nz,L_838A		;8387
	inc a			;8389
L_838A:
	out (c),a		;838a   ; su parte alta
	xor a			;838c
	out (c),a		;838d
	out (c),a		;838f
	out (c),l		;8391   ; NY
	inc a			;8393   ; ARG = 1: el lado largo en vertical
	out (c),a		;8394
	ld a,070h		;8396   ; CMD = 0x70: LINE
	out (c),a		;8398
	ei			;839a
	ret			;839b
vdp_rectangulo:		; dibuja el marco de un rectangulo con cuatro lineas
	ld b,e			;839c
	call vdp_linea_vertical_guardando		;839d   ; vdp_linea_vertical_guardando: vdp_linea_vertical guardando HL, DE y BC
	ld b,d			;83a0
	call vdp_linea_guardando		;83a1   ; vdp_linea_guardando: vdp_linea guardando HL, DE y BC
	push hl			;83a4
	ld a,l			;83a5
	add a,e			;83a6
	ld l,a			;83a7
	ld b,d			;83a8
	call vdp_linea_guardando		;83a9   ; vdp_linea_guardando: vdp_linea guardando HL, DE y BC
	pop hl			;83ac
	ld a,h			;83ad
	add a,d			;83ae
	ld h,a			;83af
	ld b,e			;83b0
	jp vdp_linea_vertical_guardando		;83b1   ; vdp_linea_vertical_guardando: vdp_linea_vertical guardando HL, DE y BC
vdp_linea_vertical_guardando:		; vdp_linea_vertical guardando HL, DE y BC
	push hl			;83b4   ; guarda los registros...
	push de			;83b5
	push bc			;83b6
	call vdp_linea_vertical		;83b7   ; ...traza la linea...
	pop bc			;83ba   ; ...y los devuelve
	pop de			;83bb
	pop hl			;83bc
	ret			;83bd
vdp_linea_guardando:		; vdp_linea guardando HL, DE y BC
	push hl			;83be
	push de			;83bf
	push bc			;83c0
	call vdp_linea		;83c1   ; vdp_linea: traza una linea con el comando del VDP (LINE, 0x70) de HL con el largo de la pila; el lado largo en horizontal
	pop bc			;83c4
	pop de			;83c5
	pop hl			;83c6
	ret			;83c7
vdp_hmmv:		; rellena un rectangulo de VRAM (HMMV, comando 0xC0) (gemela de p09:8F41)
	ex af,af'			;83c8   ; guarda el color
	call espera_vdp		;83c9   ; espera al VDP
	push bc			;83cc
	ld a,(00007h)		;83cd   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;83d0
	ld c,a			;83d1
	ld a,024h		;83d2   ; R#17 = 36 (DX) con incremento
	di			;83d4
	out (c),a		;83d5
	ld a,091h		;83d7
	out (c),a		;83d9
	inc c			;83db
	inc c			;83dc
	out (c),h		;83dd   ; DX = H
	xor a			;83df
	out (c),a		;83e0
	out (c),l		;83e2   ; DY = L, en la pagina D
	out (c),d		;83e4
	pop hl			;83e6
	out (c),h		;83e7   ; NX = B; 0 vale 256...
	cp h			;83e9
	jr nz,L_83ED		;83ea
	inc a			;83ec
L_83ED:
	out (c),a		;83ed   ; ...y su parte alta
	xor a			;83ef
	out (c),l		;83f0   ; NY = C; 0 vale 256
	cp l			;83f2
	jr nz,L_83F6		;83f3
	inc a			;83f5
L_83F6:
	out (c),a		;83f6   ; y su parte alta
	ex af,af'			;83f8
	out (c),a		;83f9   ; CLR = el color
	xor a			;83fb
	out (c),a		;83fc   ; ARG a 0
	ld a,0c0h		;83fe   ; CMD = 0xC0: HMMV
	out (c),a		;8400
	ei			;8402
	ret			;8403
vdp_hmmm:		; copia rapida de VRAM a VRAM (HMMM): origen HL, destino DE, tamano BC, paginas en A (gemela de p09:8E52)
	ex af,af'			;8404   ; guarda las paginas
	call espera_vdp		;8405   ; espera al VDP
	push bc			;8408   ; guarda NX y NY
	ld a,(00007h)		;8409   ; el puerto de los registros (VDP.DW + 1)
	inc a			;840c
	ld c,a			;840d
	ld a,020h		;840e   ; R#17 = 32 (SX) con incremento: los 15 registros del comando seguidos
	di			;8410   ; sin interrupciones
	out (c),a		;8411   ; el valor...
	ld a,091h		;8413   ; ...a R#17 (0x80 + 17)
	out (c),a		;8415
	inc c			;8417   ; C = el puerto de registros indirectos (VDP.DW + 3)
	inc c			;8418
	out (c),h		;8419   ; SX = H
	xor a			;841b   ; la parte alta de SX, 0
	out (c),a		;841c
	out (c),l		;841e   ; SY = L...
	ex af,af'			;8420
	ld l,a			;8421
	and 003h		;8422   ; ...con la pagina de origen (A & 3)
	out (c),a		;8424
	out (c),d		;8426   ; DX = D
	xor a			;8428   ; la parte alta de DX, 0
	out (c),a		;8429
	out (c),e		;842b   ; DY = E...
	ld a,l			;842d   ; ...con la pagina de destino ((A >> 2) & 3)
	rra			;842e
	rra			;842f
	and 003h		;8430
	out (c),a		;8432
	pop hl			;8434   ; NX = B (de la pila)
	out (c),h		;8435
	xor a			;8437   ; la parte alta de NX, 0
	out (c),a		;8438
	out (c),l		;843a   ; NY = C
	out (c),a		;843c   ; CLR y ARG a 0
	out (c),a		;843e
	out (c),a		;8440
	ld a,0d0h		;8442   ; CMD = 0xD0: HMMM
	out (c),a		;8444
	ei			;8446   ; vuelven las interrupciones
	ret			;8447
vdp_hmmc:		; copia rapida de la RAM (HL) a un rectangulo de VRAM (HMMC, 0xF0)
	ex af,af'			;8448   ; guarda la pagina
	call espera_vdp		;8449   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	push bc			;844c   ; guarda NX y NY
	ld a,(00007h)		;844d   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;8450   ; C = el puerto de los registros (VDP.DW + 1)
	ld c,a			;8451
	ld a,024h		;8452   ; R#17 = 36 (DX) con incremento
	di			;8454   ; sin interrupciones
	out (c),a		;8455   ; el valor...
	ld a,091h		;8457   ; ...a R#17 (0x80 + 17)
	out (c),a		;8459
	inc c			;845b   ; C = el puerto de registros indirectos (VDP.DW + 3)
	inc c			;845c
	out (c),d		;845d   ; DX = D
	xor a			;845f   ; la parte alta de DX, 0
	out (c),a		;8460
	out (c),e		;8462   ; DY = E, en la pagina A
	ex af,af'			;8464
	out (c),a		;8465   ; la parte alta de DY
	pop de			;8467   ; D = NX, E = NY
	out (c),d		;8468   ; NX = B (de la pila)
	xor a			;846a   ; la parte alta de NX, 0
	out (c),a		;846b
	out (c),e		;846d   ; NY = C
	out (c),a		;846f   ; la parte alta de NY, 0
	ld a,(hl)			;8471   ; CLR = el primer byte de HL
	inc hl			;8472
	out (c),a		;8473
	xor a			;8475   ; ARG = 0
	out (c),a		;8476
	ld a,0f0h		;8478   ; CMD = 0xF0: HMMC (de la CPU a la VRAM)
	out (c),a		;847a
	dec c			;847c   ; C = el puerto de los registros otra vez
	dec c			;847d
	ld a,0ach		;847e   ; R#17 = 44 (CLR) sin incremento, para los bytes que siguen
	out (c),a		;8480
	ld a,091h		;8482
	out (c),a		;8484
	inc c			;8486   ; C = el puerto de registros indirectos
	inc c			;8487
L_8488:
	ld a,002h		;8488   ; el estado S#2
	call lee_estado_vdp		;848a   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	rra			;848d   ; bit 0 (CE): el comando acabo
	ret nc			;848e
	add a,a			;848f   ; bit 7 (TR): el VDP pide otro byte
	add a,a			;8490
	jr nc,L_8488		;8491
	ld a,(hl)			;8493   ; el byte siguiente a CLR
	inc hl			;8494
	out (c),a		;8495
	jr L_8488		;8497
vdp_ymmm:		; copia en vertical dentro de la VRAM (YMMM, 0xE0)
	ex af,af'			;8499   ; guarda las paginas
	call espera_vdp		;849a   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	ld a,(00007h)		;849d   ; C = el puerto de los registros (VDP.DW + 1)
	inc a			;84a0
	ld c,a			;84a1
	ld a,022h		;84a2   ; R#17 = 34 (SY) con incremento
	di			;84a4   ; sin interrupciones
	out (c),a		;84a5   ; el valor...
	ld a,091h		;84a7   ; ...a R#17 (0x80 + 17)
	out (c),a		;84a9
	inc c			;84ab   ; C = el puerto de registros indirectos
	inc c			;84ac
	out (c),l		;84ad   ; SY = L...
	ex af,af'			;84af
	ld l,a			;84b0
	and 003h		;84b1
	out (c),a		;84b3   ; ...con la pagina de origen
	out (c),h		;84b5   ; DX = H
	xor a			;84b7   ; la parte alta de DX, 0
	out (c),a		;84b8
	out (c),e		;84ba   ; DY = E...
	ld a,l			;84bc   ; ...con la pagina de destino
	rra			;84bd
	rra			;84be
	and 003h		;84bf
	out (c),a		;84c1
	xor a			;84c3   ; NX no cuenta en YMMM: a cero
	out (c),a		;84c4
	out (c),a		;84c6
	out (c),d		;84c8   ; NY = D; 0 vale 256
	cp d			;84ca
	jr nz,L_84CE		;84cb
	inc a			;84cd
L_84CE:
	out (c),a		;84ce   ; su parte alta
	xor a			;84d0
	out (c),a		;84d1   ; ARG a 0
	out (c),a		;84d3
	ld a,0e0h		;84d5   ; CMD = 0xE0: YMMM
	out (c),a		;84d7
	ei			;84d9
	ret			;84da
vdp_lmmc:		; copia de la RAM (HL) a la VRAM con operacion logica (LMMC, 0xB0 | op)
	ex af,af'			;84db   ; guarda la operacion y la pagina
	call espera_vdp		;84dc   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	push bc			;84df
	ld a,(00007h)		;84e0   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;84e3
	ld c,a			;84e4
	ld a,024h		;84e5   ; R#17 = 36 (DX) con incremento
	di			;84e7
	out (c),a		;84e8
	ld a,091h		;84ea
	out (c),a		;84ec
	inc c			;84ee
	inc c			;84ef
	out (c),d		;84f0   ; DX = D
	xor a			;84f2
	out (c),a		;84f3
	out (c),e		;84f5   ; DY = E...
	ex af,af'			;84f7
	ld b,a			;84f8   ; ...con la pagina (bits 6-7 de A)
	rlca			;84f9   ; la pagina, a los bits 0-1
	rlca			;84fa
	and 003h		;84fb
	out (c),a		;84fd
	pop de			;84ff
	out (c),d		;8500   ; NX = B (de la pila)
	xor a			;8502
	out (c),a		;8503
	out (c),e		;8505   ; NY = C; 0 vale 256
	cp e			;8507   ; 0 vale 256
	jr nz,L_850B		;8508
	inc a			;850a
L_850B:
	out (c),a		;850b   ; su parte alta
	ld a,(hl)			;850d   ; CLR = el primer byte de HL
	inc hl			;850e
	out (c),a		;850f
	xor a			;8511
	out (c),a		;8512
	ld a,b			;8514   ; la operacion logica (bits 0-3)...
	and 00fh		;8515
	or 0b0h		;8517   ; ...con CMD = 0xB0: LMMC (de la CPU a la VRAM)
	out (c),a		;8519
	dec c			;851b
	dec c			;851c
	ld a,0ach		;851d   ; R#17 = 44 (CLR) sin incremento, para los bytes que siguen
	out (c),a		;851f
	ld a,091h		;8521
	out (c),a		;8523
	inc c			;8525
	inc c			;8526
L_8527:
	ld a,002h		;8527   ; el estado S#2
	call lee_estado_vdp		;8529   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	rra			;852c   ; bit 0 (CE): el comando acabo
	ret nc			;852d
	add a,a			;852e   ; bit 7 (TR): el VDP pide otro byte
	add a,a			;852f
	jr nc,L_8527		;8530
	ld a,(hl)			;8532   ; el byte siguiente a CLR
	inc hl			;8533
	out (c),a		;8534
	jr L_8527		;8536
vdp_lmcm:		; copia de la VRAM a la RAM con el comando del VDP (LMCM, 0xA0 | op)
	ex af,af'			;8538   ; guarda la operacion y la pagina
	call espera_vdp		;8539   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	ld a,007h		;853c   ; lee S#7 para dejarlo limpio
	call lee_estado_vdp		;853e   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	push de			;8541   ; guarda NX y NY
	push bc			;8542
	ld a,(00007h)		;8543   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;8546   ; C = el puerto de los registros (VDP.DW + 1)
	ld c,a			;8547
	ld a,020h		;8548   ; R#17 = 32 (SX) con incremento
	di			;854a
	out (c),a		;854b   ; el valor...
	ld a,091h		;854d   ; ...a R#17 (0x80 + 17)
	out (c),a		;854f
	inc c			;8551   ; C = el puerto de registros indirectos (VDP.DW + 3)
	inc c			;8552
	out (c),h		;8553   ; SX = H
	xor a			;8555   ; la parte alta de SX, 0
	out (c),a		;8556
	out (c),l		;8558   ; SY = L...
	ex af,af'			;855a   ; ...con la pagina (bits 6-7 de A)
	ld h,a			;855b   ; H = la operacion, para despues
	rlca			;855c
	rlca			;855d
	and 003h		;855e
	out (c),a		;8560   ; la parte alta de SY
	out (c),a		;8562   ; DX y DY no cuentan en LMCM: a cero
	out (c),a		;8564
	out (c),a		;8566
	out (c),a		;8568
	pop de			;856a
	out (c),d		;856b   ; NX = D (de la pila)
	xor a			;856d   ; la parte alta de NX, 0
	out (c),a		;856e
	out (c),e		;8570   ; NY = E; 0 vale 256
	cp e			;8572   ; 0 vale 256
	jr nz,L_8576		;8573
	inc a			;8575
L_8576:
	out (c),a		;8576   ; su parte alta
	out (c),a		;8578
	xor a			;857a   ; ARG a 0
	out (c),a		;857b
	ld a,h			;857d   ; la operacion logica...
	and 00fh		;857e
	or 0a0h		;8580   ; ...con CMD = 0xA0: LMCM (de la VRAM a la CPU)
	out (c),a		;8582
	pop de			;8584
L_8585:
	ld a,002h		;8585
	call lee_estado_vdp		;8587   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	rra			;858a
	ret nc			;858b
	add a,a			;858c
	add a,a			;858d
	jr nc,L_8585		;858e
	ld a,007h		;8590
	call lee_estado_vdp		;8592   ; lee_estado_vdp: lee el registro de estado A del VDP (R
	ld (de),a			;8595
	inc de			;8596
	jr L_8585		;8597
vdp_lmmm:		; copia de VRAM a VRAM con operacion logica (LMMM, desde R#32)
	ex af,af'			;8599   ; guarda la operacion y las paginas
	call espera_vdp		;859a   ; espera_vdp: espera a que el VDP acabe el comando (bit 0 de S#2)
	push bc			;859d   ; guarda NX y NY
	ld a,(00007h)		;859e   ; el puerto de los registros (VDP.DW + 1)
	inc a			;85a1
	ld c,a			;85a2
	ld a,020h		;85a3   ; R#17 = 32 (SX) con incremento
	di			;85a5   ; sin interrupciones
	out (c),a		;85a6   ; el valor...
	ld a,091h		;85a8   ; ...a R#17 (0x80 + 17)
	out (c),a		;85aa
	inc c			;85ac   ; C = el puerto de registros indirectos (VDP.DW + 3)
	inc c			;85ad
	out (c),h		;85ae   ; SX = H
	xor a			;85b0   ; la parte alta de SX, 0
	out (c),a		;85b1
	out (c),l		;85b3   ; SY = L...
	ex af,af'			;85b5   ; ...con la pagina de origen (bits 6-7 de A)
	rlca			;85b6
	rlca			;85b7
	ld l,a			;85b8
	and 003h		;85b9   ; los 2 bits de la pagina...
	out (c),a		;85bb   ; ...a la parte alta de SY
	out (c),d		;85bd   ; DX = D
	xor a			;85bf   ; la parte alta de DX, 0
	out (c),a		;85c0
	out (c),e		;85c2   ; DY = E...
	ld a,l			;85c4   ; ...con la pagina de destino (bits 4-5)
	ld e,a			;85c5
	rlca			;85c6
	rlca			;85c7
	and 003h		;85c8   ; los 2 bits de la pagina...
	out (c),a		;85ca   ; ...a la parte alta de DY
	pop hl			;85cc
	out (c),h		;85cd   ; NX = B (de la pila)
	xor a			;85cf   ; la parte alta de NX, 0
	out (c),a		;85d0
	out (c),l		;85d2   ; NY = C
	out (c),a		;85d4   ; la parte alta de NY, 0
	out (c),a		;85d6
	out (c),a		;85d8
	ld a,e			;85da   ; la operacion logica (bits 0-3 de A)...
	rra			;85db
	rra			;85dc
	and 00fh		;85dd
	or 090h		;85df   ; ...con CMD = 0x90: LMMM
	out (c),a		;85e1
	ei			;85e3   ; vuelven las interrupciones
	ret			;85e4
L_85E5:
	ld (0faf5h),a		;85e5   ; guarda DPPAGE, la pagina que se ve
	ld d,a			;85e8   ; D = la pagina
	add a,a			;85e9   ; L = pagina x 2...
	ld l,a			;85ea
	add a,a			;85eb   ; ...E = pagina x 16...
	add a,a			;85ec
	add a,a			;85ed
	ld e,a			;85ee
	add a,a			;85ef   ; ...H = pagina x 32
	ld h,a			;85f0
	ld a,(0f3e1h)		;85f1   ; R#2: la tabla de nombres de esa pagina
	and 01fh		;85f4   ; los bits que no son de la direccion
	or h			;85f6   ; con la pagina
	ld b,a			;85f7
	ld c,002h		;85f8   ; R#2
	call 00047h		;85fa   ; BIOS WRTVDP - Writes data in the VDP-register | a R#2
	ld a,(0ffe9h)		;85fd   ; R#10: los colores (la parte alta)
	and 001h		;8600   ; el bit de la parte baja
	or l			;8602   ; con la pagina
	ld b,a			;8603
	ld c,00ah		;8604   ; R#10
	call 00047h		;8606   ; BIOS WRTVDP - Writes data in the VDP-register | a R#10
	ld a,(0f3e3h)		;8609   ; R#4: los patrones
	and 00fh		;860c   ; los bits que se quedan
	or e			;860e   ; con la pagina
	ld b,a			;860f
	ld c,004h		;8610   ; R#4
	call 00047h		;8612   ; BIOS WRTVDP - Writes data in the VDP-register | a R#4
	ld b,d			;8615   ; R#11: los atributos de los sprites
	ld c,00bh		;8616   ; R#11 = la pagina
	call 00047h		;8618   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0f3e5h)		;861b   ; R#6: los patrones de los sprites
	and 00fh		;861e
	or e			;8620   ; con la pagina
	ld b,a			;8621
	ld c,006h		;8622   ; R#6
	call 00047h		;8624   ; BIOS WRTVDP - Writes data in the VDP-register | a R#6
	ret			;8627
letras_1bit_a_4bit:		; pinta B letras de 1 bit en SCREEN 5 (4 bits)
	call letra_1bit_a_4bit		;8628   ; letra_1bit_a_4bit: pasa una letra de 1 bit a 4 bits (0xE100) y la escribe (gemela de p09:8EEB)
	call siguiente_letra		;862b   ; siguiente_letra: D += 8; al pasar de fila, E += 8 (gemela de p09:903E)
	djnz letras_1bit_a_4bit		;862e
	ret			;8630
L_8631:
	push bc			;8631   ; guarda los registros
	push de			;8632
	push hl			;8633
	push de			;8634
	call letra_expande		;8635   ; la letra a 4 bits en 0xE090
	pop de			;8638
	ld hl,0e090h		;8639   ; desde 0xE090...
	ld bc,00808h		;863c   ; ...8 x 8 pixeles...
	ld a,001h		;863f   ; ...a la pagina 1
	call vdp_hmmc		;8641   ; HMMC
	call espera_vdp		;8644   ; espera a que acabe
	pop hl			;8647
	ld bc,00008h		;8648   ; la letra siguiente, 8 bytes mas alla
	add hl,bc			;864b
	pop de			;864c
	pop bc			;864d
	ret			;864e
letra_expande:		; expande los 8 bytes de la letra a 32 con el color C (0xE090)
	ld b,008h		;864f
	ld de,0e090h		;8651   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
L_8654:
	push bc			;8654   ; un byte de la letra (8 pixeles de 1 bit)
	push hl			;8655
	ex de,hl			;8656
	ld a,(de)			;8657
	ld d,a			;8658
	ld b,004h		;8659   ; 4 pares de pixeles
L_865B:
	ld a,c			;865b   ; el color C...
	rl d		;865c   ; ...si el pixel esta encendido...
	jr c,L_8664		;865e
	rrca			;8660   ; ...en la mitad de arriba; si no, el fondo
	rrca			;8661
	rrca			;8662
	rrca			;8663
L_8664:
	and 00fh		;8664   ; el primer pixel al byte de destino
	rld		;8666
	ld a,c			;8668   ; el segundo
	rl d		;8669
	jr c,L_8671		;866b
	rrca			;866d
	rrca			;866e
	rrca			;866f
	rrca			;8670
L_8671:
	and 00fh		;8671
	rld		;8673   ; dos pixeles al byte de destino
	inc hl			;8675
	djnz L_865B		;8676   ; los 4 pares
	ex de,hl			;8678
	pop hl			;8679
	inc hl			;867a   ; el byte siguiente
	pop bc			;867b
	djnz L_8654		;867c   ; los 8 bytes
	ret			;867e
letra_1bit_a_4bit:		; pasa una letra de 1 bit a 4 bits (0xE100) y la escribe (gemela de p09:8EEB)
	push bc			;867f   ; guarda los registros
	push de			;8680
	push hl			;8681
	push de			;8682
	call letra_expande		;8683   ; expande la letra a 4 bits en 0xE090
	pop de			;8686
	ld b,d			;8687   ; D y E: la posicion en pixeles...
	ld d,e			;8688
	ld e,b			;8689
	srl d		;868a   ; .../ 2: la direccion en la VRAM (2 pixeles por byte)
	rr e		;868c
	ld a,d			;868e   ; en la pagina 1 (+0x8000)
	add a,080h		;868f
	ld d,a			;8691
	ld hl,0e090h		;8692   ; los 32 bytes de 0xE090
	ld b,008h		;8695   ; 8 lineas
L_8697:
	push bc			;8697   ; una linea de la letra: 4 bytes (8 pixeles de 4 bits)
	ld bc,00004h		;8698
	call escribe_vram_otir		;869b   ; escribe_vram_otir: escribe BC bytes de HL en la VRAM DE con OTIR (gemela de p09:8DF6)
	ex de,hl			;869e
	ld bc,00080h		;869f   ; la linea siguiente esta 128 bytes mas abajo
	add hl,bc			;86a2
	ex de,hl			;86a3
	pop bc			;86a4
	djnz L_8697		;86a5   ; las 8 lineas
	pop hl			;86a7
	ld bc,00008h		;86a8   ; la letra siguiente, 8 bytes mas alla
	add hl,bc			;86ab
	pop de			;86ac
	pop bc			;86ad
	ret			;86ae
pinta_texto_8x8:		; pinta un texto [x, y][letras] con letras de 8x8 y la mascara 0xFF; 0xFF acaba, 0xFE otra posicion
	ld c,0ffh		;86af
	jr L_86B5		;86b1
L_86B3:
	ld c,000h		;86b3
L_86B5:
	ld d,(hl)			;86b5
	inc hl			;86b6
	ld e,(hl)			;86b7
	inc hl			;86b8
L_86B9:
	ld a,(hl)			;86b9   ; una letra
	inc hl			;86ba
	ld b,a			;86bb   ; 0xFF acaba
	inc b			;86bc
	ret z			;86bd
	inc b			;86be   ; 0xFE: otra posicion
	jr z,pinta_texto_8x8		;86bf
	and c			;86c1   ; con la mascara C
	call pinta_letra_8x8		;86c2   ; la pinta
	ld a,d			;86c5   ; 8 pixeles a la derecha
	add a,008h		;86c6
	ld d,a			;86c8
	jr L_86B9		;86c9
L_86CB:
	ld a,(hl)			;86cb   ; una letra
	inc hl			;86cc
	ld b,a			;86cd   ; 0xFF acaba
	inc b			;86ce
	ret z			;86cf
	inc b			;86d0
	and c			;86d1   ; con la mascara C
	ex de,hl			;86d2
	call 0004dh		;86d3   ; BIOS WRTVRM - Writes data in VRAM | a la copia de nombres en la VRAM
	ex de,hl			;86d6
	inc de			;86d7   ; la columna siguiente
	push bc			;86d8
	push hl			;86d9
	push de			;86da
	call letra_a_coordenadas		;86db   ; y su dibujo de 8x8...
	ld bc,00808h		;86de
	ld a,001h		;86e1   ; ...de la hoja de letras de la pagina 1 a la 0
	call vdp_hmmm		;86e3   ; vdp_hmmm: copia rapida de VRAM a VRAM (HMMM): origen HL, destino DE, tamano BC, paginas en A (gemela de p09:8E52)
	pop de			;86e6
	pop hl			;86e7
	pop bc			;86e8
	ret			;86e9
L_86EA:
	push bc			;86ea
	push hl			;86eb
	push de			;86ec
	call letra_a_coordenadas		;86ed   ; letra_a_coordenadas: H, L = la columna y la fila de la letra A - 0x20
	ld bc,00808h		;86f0
	ld a,001h		;86f3
	call vdp_hmmm		;86f5   ; vdp_hmmm: copia rapida de VRAM a VRAM (HMMM): origen HL, destino DE, tamano BC, paginas en A (gemela de p09:8E52)
	pop de			;86f8
	pop hl			;86f9
	pop bc			;86fa
	ret			;86fb
pinta_letra_8x8:		; copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	push bc			;86fc
	push hl			;86fd
	push de			;86fe
	call letra_a_coordenadas		;86ff   ; letra_a_coordenadas: H, L = la columna y la fila de la letra A - 0x20
	ld bc,00808h		;8702
	ld a,048h		;8705
	call vdp_lmmm		;8707   ; vdp_lmmm: copia de VRAM a VRAM con operacion logica (LMMM, desde R#32)
	pop de			;870a
	pop hl			;870b
	pop bc			;870c
	ret			;870d
letra_8x8_en_pagina_1:		; copia la letra A de 8x8 dentro de la pagina 1 (HMMM) (gemela de p09:8E96)
	push bc			;870e
	push hl			;870f
	push de			;8710
	call letra_a_coordenadas		;8711   ; letra_a_coordenadas: H, L = la columna y la fila de la letra A - 0x20
	ld bc,00808h		;8714
	ld a,005h		;8717
	call vdp_hmmm		;8719   ; vdp_hmmm: copia rapida de VRAM a VRAM (HMMM): origen HL, destino DE, tamano BC, paginas en A (gemela de p09:8E52)
	pop de			;871c
	pop hl			;871d
	pop bc			;871e
	ret			;871f
letra_a_coordenadas:		; H, L = la columna y la fila de la letra A - 0x20
	and a			;8720
	jr z,L_8725		;8721
	sub 020h		;8723
L_8725:
	ld b,a			;8725   ; la letra
	and 01fh		;8726   ; la columna (0-31) x 8: X
	add a,a			;8728
	add a,a			;8729
	add a,a			;872a
	ld h,a			;872b
	ld a,b			;872c   ; la fila (de 32 en 32) / 4: Y
	and 0e0h		;872d
	rrca			;872f
	rrca			;8730
	ld l,a			;8731
	ret			;8732
siguiente_letra:		; D += 8; al pasar de fila, E += 8 (gemela de p09:903E)
	ld a,d			;8733   ; 8 pixeles a la derecha
	add a,008h		;8734
	ld d,a			;8736
	ret nz			;8737   ; si no da la vuelta, ya esta
	ld a,e			;8738   ; si la da, 8 pixeles mas abajo
	add a,008h		;8739
	ld e,a			;873b
	ret			;873c
L_873D:
	ld hl,00000h		;873d
	ld bc,04000h		;8740
	xor a			;8743
	call 00056h		;8744   ; BIOS FILVRM - Fills VRAM with value
	ld hl,08758h		;8747
	ld d,008h		;874a
	ld c,000h		;874c
L_874E:
	ld b,(hl)			;874e
	call 00047h		;874f   ; BIOS WRTVDP - Writes data in the VDP-register
	inc hl			;8752
	inc c			;8753
	dec d			;8754
	jr nz,L_874E		;8755
	ret			;8757

; ----------------------------------------------------------------------
; DATOS resto_8758: lo apuntan con el banco puesto p05:8747 (0x8758); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8747 (8 bytes)
;   0x8758..0x8760  (8 bytes)
DATA_resto_8758:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0efh	; 8758  .....v..

; ======================================================================
; CODIGO 0x8760..0x877f  (31 bytes)
; ======================================================================


pon_color_fondo:		; el color 7 del fondo (R#7)
	ld c,007h		;8760
	jp L_8765		;8762
L_8765:
	jp 00047h		;8765   ; BIOS WRTVDP - Writes data in the VDP-register
L_8768:
	ld a,(0f0f5h)		;8768
	and a			;876b
	jr nz,$+27		;876c
registros_vdp_menu:		; los 8 registros del VDP de p02:8170 (gemela de p02:815F)
	ld hl,0877fh		;876e
	ld bc,00800h		;8771
L_8774:
	push bc			;8774
	ld b,(hl)			;8775
	call 00047h		;8776   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;8779
	inc hl			;877a
	inc c			;877b
	djnz L_8774		;877c
	ret			;877e

; ----------------------------------------------------------------------
; DATOS resto_877F: lo apuntan con el banco puesto p05:876E (0x877F); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:876E (8 bytes)
;   0x877f..0x8787  (8 bytes)
DATA_resto_877F:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 877f  .....v..

; ======================================================================
; CODIGO 0x8787..0x87b2  (43 bytes)
; ======================================================================


L_8787:
	ld a,005h		;8787
	call 0005fh		;8789   ; BIOS CHGMOD - Switches to given screen mode
	ld a,00fh		;878c
	ld (0f3ebh),a		;878e   ; guarda el color del borde (BDRCLR)
	call 00062h		;8791   ; BIOS CHGCLR - Changes the screen colors
	ld b,004h		;8794
	ld hl,087b2h		;8796
L_8799:
	push bc			;8799
	ld c,(hl)			;879a
	inc hl			;879b
	ld b,(hl)			;879c
	inc hl			;879d
	push hl			;879e
	call 00047h		;879f   ; BIOS WRTVDP - Writes data in the VDP-register
	pop hl			;87a2
	pop bc			;87a3
	djnz L_8799		;87a4
	call paleta_bio		;87a6   ; paleta_bio: MSX2: los 16 colores de p05:82D7
	ld bc,00007h		;87a9
	call 00047h		;87ac   ; BIOS WRTVDP - Writes data in the VDP-register
	jp sprites_apagados		;87af   ; sprites_apagados: R

; ----------------------------------------------------------------------
; DATOS resto_87B2: lo apuntan con el banco puesto p05:8796 (0x87B2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8796 (8 bytes)
;   0x87b2..0x87ba  (8 bytes)
DATA_resto_87B2:
	defb 001h,062h,005h,0efh,006h,01fh,00bh,001h	; 87b2  .b......

; ======================================================================
; CODIGO 0x87ba..0x8808  (78 bytes)
; ======================================================================


bio_fuente_msx1:		; la fuente (p05:8808) en 0x2080 y su color
	call th_patrones		;87ba   ; th_patrones: los patrones del campo (gemela de p07:883A)
	ld de,08808h		;87bd
	ld hl,02080h		;87c0
	call th_descomprime_tercios		;87c3   ; th_descomprime_tercios: descomprime DE en los tres tercios (gemela de p07:8616)
	ld a,0f4h		;87c6
	ld hl,00080h		;87c8
	ld bc,00780h		;87cb
	call th_rellena_tercios		;87ce   ; th_rellena_tercios: FILVRM en los tres tercios (gemela de p07:8605)
	ret			;87d1
th_patrones:		; los patrones del campo (gemela de p07:883A)
	ld hl,02000h		;87d2
	ld bc,00080h		;87d5
	xor a			;87d8
	call th_rellena_tercios		;87d9   ; th_rellena_tercios: FILVRM en los tres tercios (gemela de p07:8605)
	ld hl,00000h		;87dc
	ld de,00008h		;87df
	ld b,010h		;87e2
L_87E4:
	push bc			;87e4
	ld bc,00008h		;87e5
	push hl			;87e8
	call th_rellena_tercios		;87e9   ; th_rellena_tercios: FILVRM en los tres tercios (gemela de p07:8605)
	pop hl			;87ec
	add hl,de			;87ed
	inc a			;87ee
	pop bc			;87ef
	djnz L_87E4		;87f0
	ret			;87f2
bio_cifras_msx1:		; las cifras (p05:8951) en 0x2500 y su color
	ld hl,02500h		;87f3
	ld de,08951h		;87f6
	call th_descomprime		;87f9   ; th_descomprime: descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba (gemela de p07:8647)
	ld a,0f4h		;87fc
	ld hl,00500h		;87fe
	ld bc,000c0h		;8801
	call th_rellena_tercios		;8804   ; th_rellena_tercios: FILVRM en los tres tercios (gemela de p07:8605)
	ret			;8807

; ----------------------------------------------------------------------
; DATOS resto_8808: lo apuntan con el banco puesto p05:87BD (0x8808), p05:87F6
;   (0x8951); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:87BD, p05:87F6 (358 bytes)
;   0x8808..0x896e  (358 bytes)
DATA_resto_8808:
	defb 08bh,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,004h,018h,0c9h,07eh	; 8808  ..."ccc"...8...~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 8818  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 8828  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 8838  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 8848  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,0a8h,000h,07eh,063h,063h,063h,07eh,060h	; 8858  <B....B<..~ccc~`
	defb 060h,000h,03eh,063h,060h,03eh,003h,063h,03eh,000h,03ch,018h,018h,018h,018h,018h	; 8868  `.>c`>.c>.<.....
	defb 03ch,000h,018h,018h,07eh,07eh,018h,018h,000h,000h,000h,000h,07eh,07eh,000h,000h	; 8878  <...~~......~~..
	defb 000h,004h,000h,001h,07eh,004h,000h,0c1h,01ch,036h,063h,063h,07fh,063h,063h,000h	; 8888  ....~....6cc.cc.
	defb 07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h,03eh,000h	; 8898  ~cc~cc~.>c```c>.
	defb 07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h,07fh,000h	; 88a8  |fcccf|..``~``..
	defb 07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h,03fh,000h	; 88b8  .``~```.>c`gcc?.
	defb 063h,063h,063h,07fh,063h,063h,063h,000h,03ch,005h,018h,083h,03ch,000h,01fh,004h	; 88c8  ccc.ccc.<...<...
	defb 006h,08bh,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh,067h,000h,006h,060h,093h	; 88d8  ..f<.cflx|ng..`.
	defb 07fh,000h,063h,077h,07fh,07fh,06bh,063h,063h,000h,063h,073h,07bh,07fh,06fh,067h	; 88e8  ..cw..kcc.cs{.og
	defb 063h,000h,03eh,005h,063h,0a3h,03eh,000h,07eh,063h,063h,063h,07eh,060h,060h,000h	; 88f8  c.>.c.>.~ccc~``.
	defb 03eh,063h,063h,063h,06fh,066h,03dh,000h,07eh,063h,063h,062h,07ch,066h,063h,000h	; 8908  >cccof=.~ccb|fc.
	defb 03eh,063h,060h,03eh,003h,063h,03eh,000h,07eh,006h,018h,001h,000h,006h,063h,082h	; 8918  >c`>.c>.~.....c.
	defb 03eh,000h,004h,063h,0a3h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h,022h	; 8928  >..c.6...cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h,018h	; 8938  .cv<..7c.ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh,000h,001h,0ffh,007h,080h,007h,080h,001h	; 8948  .....8p.........
	defb 0ffh,008h,080h,001h,0ffh,007h,001h,007h,001h,001h,0ffh,008h,001h,001h,0ffh,007h	; 8958  ................
	defb 000h,007h,000h,001h,0ffh,000h	; 8968

; ======================================================================
; CODIGO 0x896e..0x89b4  (70 bytes)
; ======================================================================


bio_fuente_msx2:		; la fuente de p05:8B0C en la hoja de letras del MSX2
	ld a,001h		;896e
	ld (0faf6h),a		;8970   ; guarda ACPAGE, la pagina activa
	ld de,00000h		;8973
	ld bc,01000h		;8976
L_8979:
	push bc			;8979   ; una letra de p05:8B0C
	push de			;897a
	ld hl,08b0ch		;897b
	call letra_1bit_a_4bit		;897e   ; a la hoja de letras (SCREEN 5)
	pop de			;8981
	call siguiente_letra		;8982   ; la posicion siguiente
	pop bc			;8985
	inc c			;8986   ; el color
	djnz L_8979		;8987   ; las B letras
	ld de,00008h		;8989   ; en (0x08, 0x00)...
	ld a,020h		;898c   ; ...las letras de la BIOS desde el espacio
	call letra_en_bios		;898e   ; letra_en_bios: HL = la letra A de la fuente de la BIOS (0x0004)
	ld bc,0600fh		;8991   ; 0x60 letras en el color 0x0F
	call letras_1bit_a_4bit		;8994   ; letras_1bit_a_4bit: pinta B letras de 1 bit en SCREEN 5 (4 bits)
	ld de,08000h		;8997   ; en (0x00, 0x80)...
	ld hl,089b4h		;899a   ; ...las letras de p05:89B4
	ld bc,02b0fh		;899d   ; 0x2B letras en el color 0x0F
	call letras_1bit_a_4bit		;89a0   ; letras_1bit_a_4bit: pinta B letras de 1 bit en SCREEN 5 (4 bits)
	xor a			;89a3   ; la pagina activa, la 0
	ld (0faf6h),a		;89a4   ; guarda ACPAGE, la pagina activa
	ret			;89a7
letra_en_bios:		; HL = la letra A de la fuente de la BIOS (0x0004)
	ld l,a			;89a8
	ld h,000h		;89a9
	ld bc,(00004h)		;89ab   ; CGTABL: donde esta la fuente de la BIOS
	add hl,hl			;89af
	add hl,hl			;89b0
	add hl,hl			;89b1
	add hl,bc			;89b2
	ret			;89b3

; ----------------------------------------------------------------------
; DATOS resto_89B4: lo apuntan con el banco puesto p05:899A (0x89B4), p05:897B
;   (0x8B0C); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:899A, p05:897B (352 bytes)
;   0x89b4..0x8b14  (352 bytes)
DATA_resto_89B4:
	defb 000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,018h,018h,018h,018h,07eh	; 89b4  .."ccc"...8....~
	defb 000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h,03eh	; 89c4  .>c..<p..>c...c>
	defb 000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h,03eh	; 89d4  ...6ff....`~c.c>
	defb 000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h,018h	; 89e4  .>c`~cc>..c.....
	defb 000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h,03eh	; 89f4  .>cc>cc>.>cc?.c>
	defb 03ch,042h,099h,0a1h,0a1h,099h,042h,03ch,000h,018h,018h,07eh,07eh,018h,018h,000h	; 8a04  <B....B<...~~...
	defb 000h,000h,000h,07eh,07eh,000h,000h,000h,000h,000h,000h,0eeh,06bh,06bh,06bh,0ebh	; 8a14  ...~~.......kkk.
	defb 000h,000h,000h,073h,01ah,07ah,05ah,07ah,000h,003h,000h,0f3h,05bh,05bh,05bh,05bh	; 8a24  ...s.zZz....[[[[
	defb 000h,000h,000h,000h,07eh,000h,000h,000h,000h,01ch,036h,063h,063h,07fh,063h,063h	; 8a34  ....~.....6cc.cc
	defb 000h,07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h,03eh	; 8a44  .~cc~cc~.>c```c>
	defb 000h,07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h,07fh	; 8a54  .|fcccf|..``~``.
	defb 000h,07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h,03fh	; 8a64  ..``~```.>c`gcc?
	defb 000h,063h,063h,063h,07fh,063h,063h,063h,000h,03ch,018h,018h,018h,018h,018h,03ch	; 8a74  .ccc.ccc.<.....<
	defb 000h,01fh,006h,006h,006h,006h,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh,067h	; 8a84  ......f<.cflx|ng
	defb 000h,060h,060h,060h,060h,060h,060h,07fh,000h,063h,077h,07fh,07fh,06bh,063h,063h	; 8a94  .``````..cw..kcc
	defb 000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,063h,063h,063h,063h,063h,03eh	; 8aa4  .cs{.ogc.>ccccc>
	defb 000h,07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h,03dh	; 8ab4  .~ccc~``.>cccof=
	defb 000h,07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h,03eh	; 8ac4  .~ccb|fc.>c`>.c>
	defb 000h,07eh,018h,018h,018h,018h,018h,018h,000h,063h,063h,063h,063h,063h,063h,03eh	; 8ad4  .~.......cccccc>
	defb 000h,063h,063h,063h,063h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h,022h	; 8ae4  .cccc6...cckk.w"
	defb 000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h,018h	; 8af4  .cv<..7c.ff~<...
	defb 000h,07fh,007h,00eh,01ch,038h,070h,07fh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 8b04  .....8p.........

; ======================================================================
; CODIGO 0x8b14..0x8b1b  (7 bytes)
; ======================================================================


L_8B14:
	call bio_cuenta		;8b14   ; bio_cuenta: sube el contador de cuadros (0xE001)
	call bio_estado		;8b17   ; bio_estado: la rutina del estado 0xE002 (tabla p05:8B1B en MSX1, p05:8B29 en MSX2)
	jp (hl)			;8b1a

; ----------------------------------------------------------------------
; DATOS resto_8B1B: lo apuntan con el banco puesto p05:8B40 (0x8B1B), p05:8B49
;   (0x8B29); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:8B40, p05:8B49 (37 bytes)
;   0x8b1b..0x8b40  (37 bytes)
DATA_resto_8B1B:
	defb 05dh,08bh,06fh,08bh,078h,08bh,08dh,08bh,0bdh,08bh,0dbh,08bh,02bh,08ch,066h,08bh	; 8b1b  ].o.x.......+.f.
	defb 06fh,08bh,084h,08bh,0a5h,08bh,0cfh,08bh,002h,08ch,02bh,08ch,0cdh,02fh,08ch,03ah	; 8b2b  o.........+../.:
	defb 058h,0e0h,0e6h,004h,0c9h	; 8b3b

; ======================================================================
; CODIGO 0x8b40..0x8ce2  (418 bytes)
; ======================================================================


bio_estado:		; la rutina del estado 0xE002 (tabla p05:8B1B en MSX1, p05:8B29 en MSX2)
	ld hl,08b1bh		;8b40
	ld a,(0f0f5h)		;8b43
	and a			;8b46
	jr z,L_8B4C		;8b47
	ld hl,08b29h		;8b49
L_8B4C:
	ld a,(0e002h)		;8b4c   ; lee el estado del biorritmo
	add a,a			;8b4f
	call hl_mas_a		;8b50   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;8b53
	inc hl			;8b54
	ld d,(hl)			;8b55
	ex de,hl			;8b56
	ret			;8b57
bio_cuenta:		; sube el contador de cuadros (0xE001)
	ld hl,0e001h		;8b58   ; apunta a el contador de cuadros
	inc (hl)			;8b5b
	ret			;8b5c
L_8B5D:
	call bio_estado_fecha		;8b5d   ; bio_estado_fecha: el estado de pedir una fecha (MSX1)
	jp c,L_8C59		;8b60
	jp L_8C6A		;8b63
L_8B66:
	call bio_estado_fecha_msx2		;8b66   ; bio_estado_fecha_msx2: el estado de pedir una fecha (MSX2)
	jp c,L_8C59		;8b69
	jp L_8C6A		;8b6c
L_8B6F:
	call bio_calcula		;8b6f   ; bio_calcula: el calculo entero: los dias vividos y los tres ciclos
	call bio_dias_del_mes_b		;8b72   ; bio_dias_del_mes_b: los dias del mes (tabla p05:959E), con febrero segun el bisiesto
	jp L_8C59		;8b75
L_8B78:
	call bio_textos_grafica		;8b78   ; bio_textos_grafica: los textos de la grafica y su marco
	call bio_pinta_marcas		;8b7b   ; bio_pinta_marcas: pinta las marcas de los tres ciclos (p06:A33D)
	call bio_vuelca_nombres		;8b7e   ; bio_vuelca_nombres: vuelca la copia de la tabla de nombres (0xE300) a 0x3800
	jp L_8C59		;8b81
L_8B84:
	call bio_pantalla_msx2		;8b84   ; bio_pantalla_msx2: los marcos, el eje y la rejilla (p06:A006) y los textos
	call 0a336h		;8b87   ; bio_marcas: los tres valores y sus letras
	jp L_8C59		;8b8a
L_8B8D:
	ld a,(0e001h)		;8b8d   ; lee el contador de cuadros
	and 03fh		;8b90
	jr nz,L_8BA2		;8b92
	call bio_avanza_grafica		;8b94   ; bio_avanza_grafica: un paso de la grafica: alturas, puntos y dia siguiente
	call bio_dia_mas		;8b97   ; bio_dia_mas: pasa al dia siguiente: los tres angulos suben
	ld a,(0e03fh)		;8b9a   ; lee la columna de la grafica
	cp 0c0h		;8b9d
	jp nc,L_8C59		;8b9f
L_8BA2:
	jp L_8C6A		;8ba2
L_8BA5:
	ld a,(0e001h)		;8ba5   ; lee el contador de cuadros
	and 07fh		;8ba8
	jr nz,L_8BBA		;8baa
	call bio_avanza_grafica_msx2		;8bac   ; bio_avanza_grafica_msx2: un paso de la grafica en MSX2
	call bio_dia_mas		;8baf   ; bio_dia_mas: pasa al dia siguiente: los tres angulos suben
	ld a,(0e03fh)		;8bb2   ; lee la columna de la grafica
	cp 0c0h		;8bb5
	jp nc,L_8C59		;8bb7
L_8BBA:
	jp L_8C6A		;8bba
L_8BBD:
	call bio_textos_9f0a		;8bbd   ; bio_textos_9f0a: pinta los textos de p05:9F0A y p05:9F29
	call bio_recalcula		;8bc0   ; bio_recalcula: vuelve a los angulos de hoy y recalcula las alturas
	call bio_fecha_a_nombres		;8bc3   ; bio_fecha_a_nombres: la fecha a la copia de nombres (ano, mes y dia)
	call bio_pinta_niveles		;8bc6   ; bio_pinta_niveles: pinta los niveles de los tres ciclos
	call bio_vuelca_nombres		;8bc9   ; bio_vuelca_nombres: vuelca la copia de la tabla de nombres (0xE300) a 0x3800
	jp L_8C59		;8bcc
L_8BCF:
	call bio_actualiza_msx2		;8bcf   ; bio_actualiza_msx2: actualiza la grafica en MSX2 (p06)
	call bio_recalcula		;8bd2   ; bio_recalcula: vuelve a los angulos de hoy y recalcula las alturas
	call 0a3a4h		;8bd5   ; bio_niveles_si: si 0xE06A es 0, los niveles de los tres ciclos
	jp L_8C59		;8bd8
L_8BDB:
	ld a,(0e001h)		;8bdb   ; lee el contador de cuadros
	and 007h		;8bde
	jr nz,L_8BFF		;8be0
	call bio_vuelca_nombres		;8be2   ; bio_vuelca_nombres: vuelca la copia de la tabla de nombres (0xE300) a 0x3800
	call bio_vuelca_sprites		;8be5   ; bio_vuelca_sprites: vuelca la copia de sprites (0xE280) a 0x3B00
	call bio_teclas		;8be8   ; bio_teclas: las teclas recien pulsadas (0xE057)
	ld a,(0e058h)		;8beb   ; lee la tecla pulsada
	cp 001h		;8bee
	jr z,L_8C59		;8bf0
	cp 004h		;8bf2
	jr z,L_8C2E		;8bf4
	call bio_estado_grafica_msx2		;8bf6   ; bio_estado_grafica_msx2: el estado de la grafica en MSX2
	call bio_teclas		;8bf9   ; bio_teclas: las teclas recien pulsadas (0xE057)
	ld a,(0e058h)		;8bfc   ; lee la tecla pulsada
L_8BFF:
	jp L_8C6A		;8bff
L_8C02:
	ld a,(0e001h)		;8c02   ; lee el contador de cuadros
	and 00fh		;8c05
	jr nz,L_8C20		;8c07
	call bio_vuelca_sprites_msx2		;8c09   ; bio_vuelca_sprites_msx2: vuelca la copia de sprites a 0xF600 y sus colores a 0xF400
	call 0a27eh		;8c0c   ; bio_parpadea: cada 16 cuadros (0xE06E) cambia el texto que parpadea
	call bio_teclas		;8c0f   ; bio_teclas: las teclas recien pulsadas (0xE057)
	ld a,(0e058h)		;8c12   ; lee la tecla pulsada
	cp 001h		;8c15
	jr z,L_8C59		;8c17
	cp 004h		;8c19
	jr z,L_8C2E		;8c1b
	call bio_estado_grafica		;8c1d   ; bio_estado_grafica: el estado de la grafica: teclas, dia y textos
L_8C20:
	call pausa_corta		;8c20   ; pausa_corta: espera 16 vueltas
	jp L_8C6A		;8c23
pausa_corta:		; espera 16 vueltas
	ld b,010h		;8c26
L_8C28:
	djnz L_8C28		;8c28
	ret			;8c2a
L_8C2B:
	jp bio_arranca		;8c2b   ; bio_arranca: el biorritmo: guarda la pila, borra 0xE000, engancha H.TIMI y sigue en el bucle de p05:8B14
L_8C2E:
	ret			;8c2e
bio_teclas:		; las teclas recien pulsadas (0xE057)
	ld hl,0e057h		;8c2f   ; apunta a las teclas
	call bio_lee_teclas		;8c32   ; bio_lee_teclas: lee las teclas del biorritmo (SNSMAT 8 y 7)
	ld (hl),a			;8c35
	inc hl			;8c36
	ld b,(hl)			;8c37
	ld c,a			;8c38
	xor b			;8c39
	and c			;8c3a
	ld (hl),a			;8c3b
	ret			;8c3c
bio_lee_teclas:		; lee las teclas del biorritmo (SNSMAT 8 y 7)
	ld a,008h		;8c3d   ; la fila 8 del teclado...
	call 00141h		;8c3f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8c42   ; ...a nivel alto...
	and 099h		;8c43   ; ...el espacio y las flechas izquierda, abajo y derecha (0x99)
	push af			;8c45
	ld a,007h		;8c46   ; la fila 7...
	call 00141h		;8c48   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8c4b
	and 004h		;8c4c   ; ...el bit 2 (ESC)
	ld b,a			;8c4e
	pop af			;8c4f
	or b			;8c50   ; todo junto
	ret			;8c51
L_8C52:
	ld hl,0e002h		;8c52   ; apunta a el estado del biorritmo
	dec (hl)			;8c55
	jp L_8B14		;8c56
L_8C59:
	ld hl,0e002h		;8c59   ; apunta a el estado del biorritmo
	inc (hl)			;8c5c
	call bio_borra_e003		;8c5d   ; bio_borra_e003: pone a cero 0xE003
	jp L_8B14		;8c60
L_8C63:
	ld hl,0e003h		;8c63
	inc (hl)			;8c66
	jp L_8B14		;8c67
L_8C6A:
	jp L_8B14		;8c6a
bio_borra_e003:		; pone a cero 0xE003
	xor a			;8c6d
	ld hl,0e003h		;8c6e
	ld (hl),a			;8c71
	ret			;8c72
L_8C73:
	call bio_color_negro		;8c73   ; bio_color_negro: el fondo a 0
	call bio_esconde_sprites		;8c76   ; bio_esconde_sprites: pone 0xE0 en la copia de sprites (0xE280)
	call bio_fuente_msx1		;8c79   ; bio_fuente_msx1: la fuente (p05:8808) en 0x2080 y su color
	call bio_cifras_msx1		;8c7c   ; bio_cifras_msx1: las cifras (p05:8951) en 0x2500 y su color
	call bio_borra_patrones		;8c7f   ; bio_borra_patrones: borra los patrones y pone el color 0xF4
	call bio_patrones_msx1		;8c82   ; bio_patrones_msx1: descomprime p05:8DCC en 0x1800
	call bio_tabla_e400		;8c85   ; bio_tabla_e400: rellena 0xE400 con 0, 1, 2... dos veces
	call bio_borra_nombres		;8c88   ; bio_borra_nombres: llena la copia de la tabla de nombres (0xE300) con 4
	ret			;8c8b
bio_color_negro:		; el fondo a 0
	ld b,000h		;8c8c
	call pon_color_fondo		;8c8e   ; pon_color_fondo: el color 7 del fondo (R#7)
	ret			;8c91
bio_borra_nombres:		; llena la copia de la tabla de nombres (0xE300) con 4
	ld hl,0e300h		;8c92   ; apunta a la copia de la tabla de nombres
	ld de,0e301h		;8c95
	ld bc,0013fh		;8c98
	ld a,004h		;8c9b
	ld (hl),a			;8c9d
	ldir		;8c9e
	ret			;8ca0
bio_borra_patrones:		; borra los patrones y pone el color 0xF4
	ld hl,02a00h		;8ca1
	ld bc,00dffh		;8ca4
	xor a			;8ca7
	call 00056h		;8ca8   ; BIOS FILVRM - Fills VRAM with value
	ld hl,00a00h		;8cab
	ld bc,011ffh		;8cae
	ld a,0f4h		;8cb1
	call 00056h		;8cb3   ; BIOS FILVRM - Fills VRAM with value
	ret			;8cb6
bio_tabla_e400:		; rellena 0xE400 con 0, 1, 2... dos veces
	ld hl,0e400h		;8cb7
	ld b,002h		;8cba
L_8CBC:
	xor a			;8cbc
L_8CBD:
	ld (hl),a			;8cbd   ; 0, 1, 2... 0xFF
	inc hl			;8cbe
	inc a			;8cbf
	cp 000h		;8cc0
	jr nz,L_8CBD		;8cc2
	djnz L_8CBC		;8cc4   ; dos veces
	ld hl,0e400h		;8cc6   ; y 0x40 bytes de 0xE400 a cero
	xor a			;8cc9
	ld b,040h		;8cca
L_8CCC:
	ld (hl),a			;8ccc
	inc hl			;8ccd
	djnz L_8CCC		;8cce
	ret			;8cd0
bio_patrones_msx1:		; descomprime p05:8DCC en 0x1800
	ld hl,01800h		;8cd1
	ld de,08dcch		;8cd4
	call th_descomprime		;8cd7   ; th_descomprime: descomprime DE a la VRAM HL: n & 0x7F repeticiones o copias, 0 acaba (gemela de p07:8647)
	ret			;8cda
bio_sprites_8ce2:		; copia los sprites de p05:8CE2 a 0xE280
	ld hl,08ce2h		;8cdb
	call copia_sprites		;8cde   ; copia_sprites: copia 0x18 bytes de HL a la copia de sprites (0xE280)
	ret			;8ce1

; ----------------------------------------------------------------------
; DATOS resto_8CE2: lo apuntan con el banco puesto p05:8CDB (0x8CE2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8CDB (24 bytes)
;   0x8ce2..0x8cfa  (24 bytes)
DATA_resto_8CE2:
	defb 050h,05bh,000h,00fh,060h,05bh,000h,00fh,070h,05bh,000h,00fh,080h,05bh,000h,00fh	; 8ce2  P[..`[..p[...[..
	defb 090h,05bh,000h,00fh,0a0h,05bh,000h,00fh	; 8cf2  .[...[..

; ======================================================================
; CODIGO 0x8cfa..0x8d77  (125 bytes)
; ======================================================================


bio_vuelca_sprites:		; vuelca la copia de sprites (0xE280) a 0x3B00
	ld hl,03b00h		;8cfa
	ld de,0e280h		;8cfd   ; apunta a la copia de la tabla de sprites
	ld bc,0001eh		;8d00
	call copia_a_vram_de		;8d03   ; copia_a_vram_de: LDIRVM de DE a HL
	ret			;8d06
bio_vuelca_nombres:		; vuelca la copia de la tabla de nombres (0xE300) a 0x3800
	ld hl,03800h		;8d07
	ld de,0e300h		;8d0a   ; apunta a la copia de la tabla de nombres
	ld bc,00300h		;8d0d
	call copia_a_vram_de		;8d10   ; copia_a_vram_de: LDIRVM de DE a HL
	ret			;8d13
bio_esconde_sprites:		; pone 0xE0 en la copia de sprites (0xE280)
	ld hl,0e280h		;8d14   ; apunta a la copia de la tabla de sprites
	ld de,0e281h		;8d17
	ld bc,0007fh		;8d1a
	ld (hl),0e0h		;8d1d
	ldir		;8d1f
	ret			;8d21
L_8D22:
	call esconde_sprites_msx2		;8d22   ; esconde_sprites_msx2: 0xD8 en la tabla de sprites del MSX2 (0xF600)
	call bio_paleta		;8d25   ; bio_paleta: MSX2: la paleta de p05:8D77
	call bio_esconde_sprites_msx2		;8d28   ; bio_esconde_sprites_msx2: pone 0xD8 en la copia de sprites (0xE280)
	call bio_tres_casillas		;8d2b   ; bio_tres_casillas: pinta tres casillas de 8x8 (0x0000, 0x0040, 0x0080)
	call bio_fuente_msx2		;8d2e   ; bio_fuente_msx2: la fuente de p05:8B0C en la hoja de letras del MSX2
	call bio_pinta_letras		;8d31   ; bio_pinta_letras: pinta las letras de p05:8E06
	call pantalla_encendida		;8d34   ; pantalla_encendida: R#1 con el bit 6: pantalla encendida
	ret			;8d37
bio_tres_casillas:		; pinta tres casillas de 8x8 (0x0000, 0x0040, 0x0080)
	ld hl,00000h		;8d38
	call bio_casilla		;8d3b   ; bio_casilla: pinta una casilla de 8x8 con el comando del VDP
	ld hl,00040h		;8d3e
	call bio_casilla		;8d41   ; bio_casilla: pinta una casilla de 8x8 con el comando del VDP
	ld hl,00080h		;8d44
	call bio_casilla		;8d47   ; bio_casilla: pinta una casilla de 8x8 con el comando del VDP
bio_casilla:		; pinta una casilla de 8x8 con el comando del VDP
	ld bc,00808h		;8d4a
	ld a,001h		;8d4d
	ld d,a			;8d4f
	jp vdp_hmmv		;8d50   ; vdp_hmmv: rellena un rectangulo de VRAM (HMMV, comando 0xC0) (gemela de p09:8F41)
L_8D53:
	xor a			;8d53
	ld hl,0e000h		;8d54
	ld de,0e001h		;8d57   ; apunta a el contador de cuadros
	ld bc,000ffh		;8d5a
	ld (hl),a			;8d5d
	ldir		;8d5e
	ret			;8d60
bio_esconde_sprites_msx2:		; pone 0xD8 en la copia de sprites (0xE280)
	ld a,0d8h		;8d61
	ld hl,0e280h		;8d63   ; apunta a la copia de la tabla de sprites
	ld de,0e281h		;8d66
	ld bc,0007fh		;8d69
	ld (hl),a			;8d6c
	ldir		;8d6d
	ret			;8d6f
bio_paleta:		; MSX2: la paleta de p05:8D77
	ld hl,08d77h		;8d70
	call paleta_desde		;8d73   ; paleta_desde: MSX2: los 16 colores de HL
	ret			;8d76

; ----------------------------------------------------------------------
; DATOS resto_8D77: lo apuntan con el banco puesto p05:8D70 (0x8D77); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8D70 (32 bytes)
;   0x8d77..0x8d97  (32 bytes)
DATA_resto_8D77:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 8d77  ......3...'.Q.'.
	defb 071h,001h,013h,001h,016h,005h,061h,006h,077h,007h,077h,007h,077h,007h,077h,007h	; 8d87  q.....a.w.w.w.w.

; ======================================================================
; CODIGO 0x8d97..0x8daa  (19 bytes)
; ======================================================================


bio_sprites_msx2:		; los sprites de p05:8DAA y sus patrones
	ld hl,08daah		;8d97
	call copia_sprites		;8d9a   ; copia_sprites: copia 0x18 bytes de HL a la copia de sprites (0xE280)
	call bio_patrones_sprites		;8d9d   ; bio_patrones_sprites: descomprime p05:8DCC en 0xF800
	ret			;8da0
copia_sprites:		; copia 0x18 bytes de HL a la copia de sprites (0xE280)
	ld de,0e280h		;8da1   ; apunta a la copia de la tabla de sprites
	ld bc,00018h		;8da4
	ldir		;8da7
	ret			;8da9

; ----------------------------------------------------------------------
; DATOS resto_8DAA: lo apuntan con el banco puesto p05:8D97 (0x8DAA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8D97 (24 bytes)
;   0x8daa..0x8dc2  (24 bytes)
DATA_resto_8DAA:
	defb 058h,05ch,000h,00fh,068h,05ch,000h,00fh,078h,05ch,000h,00fh,088h,05ch,000h,00fh	; 8daa  X\..h\..x\...\..
	defb 098h,05ch,000h,00fh,0a8h,05ch,000h,00fh	; 8dba  .\...\..

; ======================================================================
; CODIGO 0x8dc2..0x8dcc  (10 bytes)
; ======================================================================


bio_patrones_sprites:		; descomprime p05:8DCC en 0xF800
	ld hl,0f800h		;8dc2
	ld de,08dcch		;8dc5
	call descomprime_bio		;8dc8   ; descomprime_bio: descomprime en la VRAM con C = 0
	ret			;8dcb

; ----------------------------------------------------------------------
; DATOS resto_8DCC: lo apuntan con el banco puesto p05:8CD4 (0x8DCC), p05:8DC5
;   (0x8DCC); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:8CD4, p05:8DC5 (9 bytes)
;   0x8dcc..0x8dd5  (9 bytes)
DATA_resto_8DCC:
	defb 008h,080h,008h,080h,008h,000h,008h,000h,000h	; 8dcc  .........

; ======================================================================
; CODIGO 0x8dd5..0x8e06  (49 bytes)
; ======================================================================


bio_vuelca_sprites_msx2:		; vuelca la copia de sprites a 0xF600 y sus colores a 0xF400
	ld de,0f600h		;8dd5
	ld hl,0e280h		;8dd8   ; apunta a la copia de la tabla de sprites
	ld bc,0001ch		;8ddb
	call escribe_vram_otir		;8dde   ; escribe_vram_otir: escribe BC bytes de HL en la VRAM DE con OTIR (gemela de p09:8DF6)
	ld hl,0f400h		;8de1
	ld bc,000e0h		;8de4
	ld a,00fh		;8de7
	call rellena_vram_128k		;8de9   ; rellena_vram_128k: rellena BC bytes de la VRAM HL (128 KB) con A
	ret			;8dec
L_8DED:
	call pantalla_apagada		;8ded   ; pantalla_apagada: R#1 sin el bit 6: pantalla apagada
	call pantalla_encendida		;8df0   ; pantalla_encendida: R#1 con el bit 6: pantalla encendida
	ld a,001h		;8df3
	ld (0e008h),a		;8df5
	ret			;8df8
bio_pinta_letras:		; pinta las letras de p05:8E06
	ld de,00018h		;8df9
	ld hl,08e06h		;8dfc
	ld bc,0020fh		;8dff
	call letras_1bit_a_4bit		;8e02   ; letras_1bit_a_4bit: pinta B letras de 1 bit en SCREEN 5 (4 bits)
	ret			;8e05

; ----------------------------------------------------------------------
; DATOS resto_8E06: lo apuntan con el banco puesto p05:8DFC (0x8E06); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:8DFC (46 bytes)
;   0x8e06..0x8e34  (46 bytes)
DATA_resto_8E06:
	defb 000h,000h,000h,0ffh,0ffh,000h,000h,000h,018h,018h,018h,0ffh,0ffh,018h,018h,018h	; 8e06  ................
	defb 001h,007h,002h,0cdh,047h,000h,0cdh,048h,082h,0c9h,0cdh,06eh,082h,021h,000h,000h	; 8e16  ....G..H...n.!..
	defb 001h,000h,000h,03eh,0ddh,016h,000h,0cdh,0c8h,083h,0cdh,061h,082h,0c9h	; 8e26  ...>.......a..

; ======================================================================
; CODIGO 0x8e34..0x9043  (527 bytes)
; ======================================================================


bio_calcula:		; el calculo entero: los dias vividos y los tres ciclos
	call bio_dias_del_ano		;8e34   ; bio_dias_del_ano: los dias de cada fecha por 365 (0x16D)
	call bio_bisiestos_4		;8e37   ; bio_bisiestos_4: suma los anos divisibles por 4
	call bio_bisiestos_100		;8e3a   ; bio_bisiestos_100: resta los anos divisibles por 100
	call bio_bisiestos_400		;8e3d   ; bio_bisiestos_400: suma los anos divisibles por 400
	call bio_dias_del_mes		;8e40   ; bio_dias_del_mes: suma los dias de los meses (tabla p05:959E)
	call bio_dias_vividos		;8e43   ; bio_dias_vividos: los dias vividos: la fecha de hoy menos la de nacimiento
	call bio_tres_restos		;8e46   ; bio_tres_restos: los dias modulo 23, 28 y 33 (0xE02D, 0xE02F, 0xE031)
	call bio_tres_angulos		;8e49   ; bio_tres_angulos: pasa cada resto a grados (x 360 / ciclo)
	call bio_retrasa		;8e4c   ; bio_retrasa: resta a los tres angulos la tabla de p05:9043
	call bio_guarda_angulos		;8e4f   ; bio_guarda_angulos: copia los tres angulos a 0xE033
	call bio_angulos_validos		;8e52   ; bio_angulos_validos: deja los tres angulos entre 0 y 359 y calcula sus alturas
	ret			;8e55
bio_dias_del_ano:		; los dias de cada fecha por 365 (0x16D)
	ld ix,0e018h		;8e56   ; apunta a los dias de la fecha de nacimiento (32 bits)
	ld hl,(0e010h)		;8e5a   ; lee el ano de nacimiento y el byte siguiente (16 bits)
	call por_365		;8e5d   ; por_365: multiplica HL por 365 en IX (32 bits)
	ld ix,0e01ch		;8e60   ; apunta a los dias de la fecha de hoy (32 bits)
	ld hl,(0e012h)		;8e64   ; lee el ano de hoy y el byte siguiente (16 bits)
	call por_365		;8e67   ; por_365: multiplica HL por 365 en IX (32 bits)
	ret			;8e6a
por_365:		; multiplica HL por 365 en IX (32 bits)
	ld de,0016dh		;8e6b
	call multiplica_32		;8e6e   ; multiplica_32: DE:HL = HL x DE
	ld (ix+000h),e		;8e71
	ld (ix+001h),d		;8e74
	ld (ix+002h),l		;8e77
	ld (ix+003h),h		;8e7a
	ret			;8e7d
bio_bisiestos_4:		; suma los anos divisibles por 4
	ld hl,(0e010h)		;8e7e   ; lee el ano de nacimiento y el byte siguiente (16 bits)
	ld de,0e018h		;8e81   ; apunta a los dias de la fecha de nacimiento (32 bits)
	call bio_divide_4		;8e84   ; bio_divide_4: suma (ano - 1) / 4
	ld hl,(0e012h)		;8e87   ; lee el ano de hoy y el byte siguiente (16 bits)
	ld de,0e01ch		;8e8a   ; apunta a los dias de la fecha de hoy (32 bits)
	call bio_divide_4		;8e8d   ; bio_divide_4: suma (ano - 1) / 4
	ret			;8e90
bio_bisiestos_100:		; resta los anos divisibles por 100
	ld hl,(0e010h)		;8e91   ; lee el ano de nacimiento y el byte siguiente (16 bits)
	ld de,0e018h		;8e94   ; apunta a los dias de la fecha de nacimiento (32 bits)
	call bio_divide_100		;8e97   ; bio_divide_100: resta (ano - 1) / 100
	ld hl,(0e012h)		;8e9a   ; lee el ano de hoy y el byte siguiente (16 bits)
	ld de,0e01ch		;8e9d   ; apunta a los dias de la fecha de hoy (32 bits)
	call bio_divide_100		;8ea0   ; bio_divide_100: resta (ano - 1) / 100
	ret			;8ea3
bio_bisiestos_400:		; suma los anos divisibles por 400
	ld hl,(0e010h)		;8ea4   ; lee el ano de nacimiento y el byte siguiente (16 bits)
	ld de,0e018h		;8ea7   ; apunta a los dias de la fecha de nacimiento (32 bits)
	call bio_divide_400		;8eaa   ; bio_divide_400: suma (ano - 1) / 400
	ld hl,(0e012h)		;8ead   ; lee el ano de hoy y el byte siguiente (16 bits)
	ld de,0e01ch		;8eb0   ; apunta a los dias de la fecha de hoy (32 bits)
	call bio_divide_400		;8eb3   ; bio_divide_400: suma (ano - 1) / 400
	ret			;8eb6
bio_dias_del_mes:		; suma los dias de los meses (tabla p05:959E)
	ld hl,0e010h		;8eb7   ; apunta a el ano de nacimiento
	ld ix,0e014h		;8eba   ; apunta a el mes de nacimiento
	ld de,0e018h		;8ebe   ; apunta a los dias de la fecha de nacimiento (32 bits)
	call bio_dias_hasta_el_mes		;8ec1   ; bio_dias_hasta_el_mes: suma los dias de los meses anteriores (tabla p05:959E)
	ld hl,0e012h		;8ec4   ; apunta a el ano de hoy
	ld ix,0e015h		;8ec7   ; apunta a el mes de hoy
	ld de,0e01ch		;8ecb   ; apunta a los dias de la fecha de hoy (32 bits)
	call bio_dias_hasta_el_mes		;8ece   ; bio_dias_hasta_el_mes: suma los dias de los meses anteriores (tabla p05:959E)
	ret			;8ed1
bio_divide_4:		; suma (ano - 1) / 4
	push de			;8ed2
	ld de,00004h		;8ed3
	call ano_menos_uno		;8ed6   ; ano_menos_uno: HL = HL - 1 y C si no llega a DE
	pop de			;8ed9
	jr c,L_8EE4		;8eda
	call divide_por_4		;8edc   ; divide_por_4: DE = DE / 4
	ex de,hl			;8edf
	call suma_24		;8ee0   ; suma_24: suma DE a los 24 bits de HL
	ret			;8ee3
L_8EE4:
	ret			;8ee4
ano_menos_uno:		; HL = HL - 1 y C si no llega a DE
	dec hl			;8ee5
	ld a,h			;8ee6
	and 080h		;8ee7
	jr nz,L_8EEF		;8ee9
	rst 20h			;8eeb   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr c,L_8EEF		;8eec
	ret			;8eee
L_8EEF:
	scf			;8eef
	ret			;8ef0
bio_divide_100:		; resta (ano - 1) / 100
	push de			;8ef1
	ld de,00064h		;8ef2
	call ano_menos_uno		;8ef5   ; ano_menos_uno: HL = HL - 1 y C si no llega a DE
	pop de			;8ef8
	jr c,L_8F07		;8ef9
	push de			;8efb
	ex de,hl			;8efc
	ld bc,00064h		;8efd
	call divide		;8f00   ; divide: DE / BC: cociente en DE y resto en HL
	pop hl			;8f03
	call resta_24		;8f04   ; resta_24: resta DE de los 24 bits de HL
L_8F07:
	ret			;8f07
bio_divide_400:		; suma (ano - 1) / 400
	push de			;8f08
	ld de,00190h		;8f09
	call ano_menos_uno		;8f0c   ; ano_menos_uno: HL = HL - 1 y C si no llega a DE
	pop de			;8f0f
	jr c,L_8F1E		;8f10
	push de			;8f12
	ex de,hl			;8f13
	ld bc,00190h		;8f14
	call divide		;8f17   ; divide: DE / BC: cociente en DE y resto en HL
	pop hl			;8f1a
	call suma_24		;8f1b   ; suma_24: suma DE a los 24 bits de HL
L_8F1E:
	ret			;8f1e
bio_dias_hasta_el_mes:		; suma los dias de los meses anteriores (tabla p05:959E)
	push de			;8f1f   ; guarda el destino
	push hl			;8f20
	ld a,(ix+000h)		;8f21   ; el mes (ix+0)
	dec a			;8f24
	ld hl,0959eh		;8f25   ; los dias de los meses anteriores, en la tabla de p05:959E
	add a,a			;8f28
	call hl_mas_a		;8f29   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld d,(hl)			;8f2c   ; D y E: los dias hasta el mes
	inc hl			;8f2d
	ld e,(hl)			;8f2e
	ld a,(ix+002h)		;8f2f   ; mas el dia del mes (ix+2)
	call de_mas_a		;8f32   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	pop hl			;8f35
	push de			;8f36
	call bio_es_bisiesto		;8f37   ; el ano es bisiesto?
	pop de			;8f3a
	jr nc,L_8F45		;8f3b   ; no: ya esta
	ld a,002h		;8f3d   ; si, y el mes es marzo o despues...
	cp (ix+000h)		;8f3f
	jr nc,L_8F45		;8f42
	inc de			;8f44   ; ...un dia mas (el 29 de febrero)
L_8F45:
	pop hl			;8f45
	call suma_24		;8f46   ; suma_24: suma DE a los 24 bits de HL
	ret			;8f49
bio_es_bisiesto:		; mira si el ano es bisiesto (4, 100 y 400): 0xE041
	xor a			;8f4a   ; el ano no es bisiesto...
	ld (0e041h),a		;8f4b   ; guarda el ano es bisiesto
	ld e,(hl)			;8f4e   ; ...el ano...
	inc hl			;8f4f
	ld d,(hl)			;8f50
	ld bc,00004h		;8f51   ; ...entre 4
	push de			;8f54
	call divide		;8f55   ; divide: DE / BC: cociente en DE y resto en HL
	pop de			;8f58
	ld a,l			;8f59   ; si hay resto, no es bisiesto
	and a			;8f5a
	jr nz,L_8F7E		;8f5b
	ld bc,00064h		;8f5d   ; entre 100
	push de			;8f60
	call divide		;8f61   ; divide: DE / BC: cociente en DE y resto en HL
	pop de			;8f64
	ld a,l			;8f65   ; si hay resto, es bisiesto
	and a			;8f66
	jr nz,L_8F77		;8f67
	ld bc,00190h		;8f69   ; entre 400
	call divide		;8f6c   ; divide: DE / BC: cociente en DE y resto en HL
	ld a,h			;8f6f   ; si hay resto, no lo es
	and a			;8f70
	jr nz,L_8F7E		;8f71
	ld a,l			;8f73   ; (los dos bytes del resto)
	and a			;8f74
	jr nz,L_8F7E		;8f75
L_8F77:
	ld a,001h		;8f77
	ld (0e041h),a		;8f79   ; guarda el ano es bisiesto
	scf			;8f7c
	ret			;8f7d
L_8F7E:
	xor a			;8f7e
	ld (0e041h),a		;8f7f   ; guarda el ano es bisiesto
	ret			;8f82
bio_dias_vividos:		; los dias vividos: la fecha de hoy menos la de nacimiento
	ld hl,0e01ch		;8f83   ; apunta a los dias de la fecha de hoy (32 bits)
	ld de,0e020h		;8f86   ; apunta a los dias vividos (32 bits)
	ld bc,00004h		;8f89
	ldir		;8f8c
	ld hl,0e020h		;8f8e   ; apunta a los dias vividos (32 bits)
	ld de,0e018h		;8f91   ; apunta a los dias de la fecha de nacimiento (32 bits)
	call resta_32		;8f94   ; resta_32: resta los 32 bits de HL de los de DE
	ret			;8f97
bio_tres_restos:		; los dias modulo 23, 28 y 33 (0xE02D, 0xE02F, 0xE031)
	ld hl,(0e020h)		;8f98   ; lee los dias vividos (32 bits) y el byte siguiente (16 bits)
	ld de,(0e022h)		;8f9b
	ld ix,0e02dh		;8f9f   ; apunta a el angulo del fisico (23 dias)
	ld bc,00017h		;8fa3
	call bio_resto		;8fa6   ; bio_resto: el resto de dividir por BC
	ld hl,(0e020h)		;8fa9   ; lee los dias vividos (32 bits) y el byte siguiente (16 bits)
	ld de,(0e022h)		;8fac
	ld ix,0e02fh		;8fb0   ; apunta a el angulo de la sensibilidad (28 dias)
	ld bc,0001ch		;8fb4
	call bio_resto		;8fb7   ; bio_resto: el resto de dividir por BC
	ld hl,(0e020h)		;8fba   ; lee los dias vividos (32 bits) y el byte siguiente (16 bits)
	ld de,(0e022h)		;8fbd
	ld ix,0e031h		;8fc1   ; apunta a el angulo del intelecto (33 dias)
	ld bc,00021h		;8fc5
	call bio_resto		;8fc8   ; bio_resto: el resto de dividir por BC
	ret			;8fcb
bio_tres_angulos:		; pasa cada resto a grados (x 360 / ciclo)
	ld ix,0e02dh		;8fcc   ; apunta a el angulo del fisico (23 dias)
	ld bc,00017h		;8fd0
	call bio_angulo		;8fd3   ; bio_angulo: el angulo del ciclo: resto x 360 / BC
	ld ix,0e02fh		;8fd6   ; apunta a el angulo de la sensibilidad (28 dias)
	ld bc,0001ch		;8fda
	call bio_angulo		;8fdd   ; bio_angulo: el angulo del ciclo: resto x 360 / BC
	ld ix,0e031h		;8fe0   ; apunta a el angulo del intelecto (33 dias)
	ld bc,00021h		;8fe4
	call bio_angulo		;8fe7   ; bio_angulo: el angulo del ciclo: resto x 360 / BC
	ret			;8fea
bio_resto:		; el resto de dividir por BC
	call cabe_en_b		;8feb   ; cabe_en_b: C si DE:HL es menor que B
	jr c,L_8FF4		;8fee
	call divide_32		;8ff0   ; divide_32: divide 32 bits por BC
	ex de,hl			;8ff3
L_8FF4:
	ld (ix+000h),e		;8ff4
	ld (ix+001h),d		;8ff7
	ret			;8ffa
bio_angulo:		; el angulo del ciclo: resto x 360 / BC
	ld e,(ix+000h)		;8ffb
	ld d,(ix+001h)		;8ffe
	call de_es_cero		;9001   ; de_es_cero: Z si DE es 0
	jr z,L_9012		;9004
	push bc			;9006
	ld bc,00168h		;9007
	call multiplica		;900a   ; multiplica: HL = DE x BC
	ex de,hl			;900d
	pop bc			;900e
	call divide		;900f   ; divide: DE / BC: cociente en DE y resto en HL
L_9012:
	ex de,hl			;9012
	ld (ix+000h),l		;9013
	ld (ix+001h),h		;9016
	ret			;9019
bio_retrasa:		; resta a los tres angulos la tabla de p05:9043
	ld b,003h		;901a
	ld ix,0e02dh		;901c   ; apunta a el angulo del fisico (23 dias)
	ld iy,09043h		;9020
L_9024:
	ld l,(ix+000h)		;9024   ; un angulo
	ld h,(ix+001h)		;9027
	ld e,(iy+000h)		;902a   ; menos el retraso de la tabla de IY
	ld d,(iy+001h)		;902d
	xor a			;9030
	sbc hl,de		;9031
	ld (ix+000h),l		;9033
	ld (ix+001h),h		;9036
	ld de,00002h		;9039   ; el siguiente (2 bytes)
	add ix,de		;903c
	add iy,de		;903e
	djnz L_9024		;9040   ; los B ciclos
	ret			;9042

; ----------------------------------------------------------------------
; DATOS resto_9043: lo apuntan con el banco puesto p05:9020 (0x9043), p05:9CED
;   (0x9043); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9020, p05:9CED (6 bytes)
;   0x9043..0x9049  (6 bytes)
DATA_resto_9043:
	defb 0ebh,000h,0c1h,000h,0a4h,000h	; 9043

; ======================================================================
; CODIGO 0x9049..0x94e8  (1183 bytes)
; ======================================================================


bio_guarda_angulos:		; copia los tres angulos a 0xE033
	ld hl,0e02dh		;9049   ; apunta a el angulo del fisico (23 dias)
	ld de,0e033h		;904c   ; apunta a los tres angulos de hoy (copia)
	ld bc,00006h		;904f
	ldir		;9052
	ret			;9054
bio_angulos_validos:		; deja los tres angulos entre 0 y 359 y calcula sus alturas
	ld hl,(0e02dh)		;9055   ; lee el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	call angulo_0_359		;9058   ; angulo_0_359: suma o resta 360 hasta que HL este entre 0 y 359
	ld (0e02dh),hl		;905b   ; guarda el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	call bio_alturas		;905e   ; bio_alturas: las alturas de los tres ciclos (sin desplazar)
	ld (0e039h),a		;9061
	ld hl,(0e02fh)		;9064   ; lee el angulo de la sensibilidad (28 dias) y el byte siguiente (16 bits)
	call angulo_0_359		;9067   ; angulo_0_359: suma o resta 360 hasta que HL este entre 0 y 359
	call bio_alturas		;906a   ; bio_alturas: las alturas de los tres ciclos (sin desplazar)
	ld (0e03bh),a		;906d
	ld hl,(0e031h)		;9070   ; lee el angulo del intelecto (33 dias) y el byte siguiente (16 bits)
	call angulo_0_359		;9073   ; angulo_0_359: suma o resta 360 hasta que HL este entre 0 y 359
	call bio_alturas		;9076   ; bio_alturas: las alturas de los tres ciclos (sin desplazar)
	ld (0e03dh),a		;9079
	ret			;907c
L_907D:
	push af			;907d
	push de			;907e
	call angulo_0_359		;907f   ; angulo_0_359: suma o resta 360 hasta que HL este entre 0 y 359
	pop de			;9082
	pop af			;9083
	ret			;9084
angulo_0_359:		; suma o resta 360 hasta que HL este entre 0 y 359
	ld a,h			;9085
	add a,080h		;9086
	jr nc,L_9095		;9088
L_908A:
	ld de,00168h		;908a   ; negativo: suma 360...
	add hl,de			;908d
	ld a,h			;908e   ; ...hasta que sea positivo
	add a,080h		;908f
	jr c,L_908A		;9091
	jr L_909F		;9093
L_9095:
	push hl			;9095   ; resta 360...
	ld de,00168h		;9096
	sbc hl,de		;9099
	pop de			;909b
	jr nc,L_9095		;909c   ; ...mientras se pueda
	ex de,hl			;909e
L_909F:
	ret			;909f
cabe_en_b:		; C si DE:HL es menor que B
	ld a,d			;90a0   ; si DE no es 0...
	add a,e			;90a1
	and a			;90a2
	ret nz			;90a3
	ld a,h			;90a4   ; ...o H no es 0, no cabe
	and a			;90a5
	ret nz			;90a6
	ld a,l			;90a7   ; L < B: cabe
	cp b			;90a8
	ret nc			;90a9
	ex de,hl			;90aa
	ret			;90ab
de_es_cero:		; Z si DE es 0
	ld a,d			;90ac
	or e			;90ad
	and a			;90ae
	ret			;90af
L_90B0:
	ex de,hl			;90b0
	ld bc,00010h		;90b1
	call divide		;90b4   ; divide: DE / BC: cociente en DE y resto en HL
	ret			;90b7
bio_avanza_grafica:		; un paso de la grafica: alturas, puntos y dia siguiente
	call bio_alturas_mas		;90b8   ; bio_alturas_mas: las alturas de los tres ciclos (desplazamientos 4, 3, 2)
	call bio_pinta_tres		;90bb   ; bio_pinta_tres: pinta un punto de cada ciclo con su color
	ld hl,0e03fh		;90be   ; apunta a la columna de la grafica
	inc (hl)			;90c1
	ret			;90c2
bio_pinta_tres:		; pinta un punto de cada ciclo con su color
	ld hl,(0e05ah)		;90c3   ; lee la altura del fisico y el byte siguiente (16 bits)
	ld bc,001f0h		;90c6
	call bio_pinta_punto		;90c9   ; bio_pinta_punto: pinta el punto de un ciclo
	ld hl,(0e05ch)		;90cc   ; lee la altura de la sensibilidad y el byte siguiente (16 bits)
	ld bc,00180h		;90cf
	call bio_pinta_punto		;90d2   ; bio_pinta_punto: pinta el punto de un ciclo
	ld hl,(0e05eh)		;90d5   ; lee la altura del intelecto y el byte siguiente (16 bits)
	ld bc,001c0h		;90d8
	call bio_pinta_punto		;90db   ; bio_pinta_punto: pinta el punto de un ciclo
	ret			;90de
bio_pinta_punto:		; pinta el punto de un ciclo
	call bio_posicion		;90df   ; bio_posicion: la posicion en la pantalla del punto (0xE08C)
	call bit_de_pixel		;90e2   ; bit_de_pixel: A = el bit del pixel
	ld c,0f0h		;90e5
	call bio_pon_color		;90e7   ; bio_pon_color: pone el color del punto si la casilla esta libre (0xF0)
	ret			;90ea
L_90EB:
	ld a,l			;90eb   ; la columna 0x88: el dia de hoy
	cp 088h		;90ec
	jr z,L_90F9		;90ee
	ld a,h			;90f0   ; la fila entre 0x58 y 0x5F: la linea del medio
	cp 058h		;90f1
	jr c,L_90FB		;90f3
	cp 060h		;90f5
	jr nc,L_90FB		;90f7
L_90F9:
	scf			;90f9
	ret			;90fa
L_90FB:
	xor a			;90fb
	ret			;90fc
bio_posicion:		; la posicion en la pantalla del punto (0xE08C)
	ld a,h			;90fd   ; la posicion del punto: H = la columna, L = la fila
	ld h,a			;90fe
	ld a,l			;90ff
	ld l,a			;9100
	sub 008h		;9101   ; la fila menos 8
	ld l,a			;9103
	ex de,hl			;9104
	push de			;9105
	ld l,e			;9106   ; la columna...
	ld c,008h		;9107   ; ...entre 8...
	call divide_8		;9109   ; divide_8: L / C: cociente en L y resto en H
	ld a,h			;910c   ; H = el resto: el pixel dentro de la casilla
	ld (0e088h),hl		;910d   ; guarda resultado de 32 bits (parte alta) y el byte siguiente (16 bits)
	ld b,000h		;9110   ; el cociente...
	ld c,l			;9112
	ld de,00100h		;9113   ; ...x 256: la fila de casillas
	call multiplica		;9116   ; multiplica: HL = DE x BC
	ld a,(0e089h)		;9119   ; mas la fila de pixeles dentro de la casilla
	call hl_mas_a		;911c   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld (0e08ch),hl		;911f   ; guarda la posicion del punto en la VRAM y el byte siguiente (16 bits)
	pop de			;9122
	ld l,d			;9123   ; la fila...
	ld c,008h		;9124   ; ...entre 8
	call divide_8		;9126   ; divide_8: L / C: cociente en L y resto en H
	ld (0e088h),hl		;9129   ; guarda resultado de 32 bits (parte alta) y el byte siguiente (16 bits)
	ld b,000h		;912c   ; el cociente...
	ld c,l			;912e
	ld de,00008h		;912f   ; ...x 8: la columna de casillas
	call multiplica		;9132   ; multiplica: HL = DE x BC
	ex de,hl			;9135
	ld hl,(0e08ch)		;9136   ; sumada a la posicion
	add hl,de			;9139
	ld (0e08ch),hl		;913a   ; guarda la posicion del punto en la VRAM y el byte siguiente (16 bits)
	ld a,(0e089h)		;913d   ; el pixel dentro del byte...
	ld b,a			;9140
	ld a,007h		;9141   ; ...contado desde la izquierda: 7 - resto
	sub b			;9143
	ret			;9144
bit_de_pixel:		; A = el bit del pixel
	inc a			;9145
	ld b,a			;9146
	ld a,001h		;9147
L_9149:
	sla a		;9149
	djnz L_9149		;914b
	rra			;914d
	ret			;914e
bio_pon_color:		; pone el color del punto si la casilla esta libre (0xF0)
	ld b,a			;914f
	ld hl,(0e08ch)		;9150   ; lee la posicion del punto en la VRAM y el byte siguiente (16 bits)
	call 0004ah		;9153   ; BIOS RDVRM - Reads the content of VRAM
	cp 0f0h		;9156
	jr z,L_915C		;9158
	cp c			;915a
	ret nz			;915b
L_915C:
	ld a,c			;915c
	ld hl,(0e08ch)		;915d   ; lee la posicion del punto en la VRAM y el byte siguiente (16 bits)
	call 0004dh		;9160   ; BIOS WRTVRM - Writes data in VRAM
	ld de,02000h		;9163
	ld hl,(0e08ch)		;9166   ; lee la posicion del punto en la VRAM y el byte siguiente (16 bits)
	add hl,de			;9169
	call 0004ah		;916a   ; BIOS RDVRM - Reads the content of VRAM
	or b			;916d
	ld hl,(0e08ch)		;916e   ; lee la posicion del punto en la VRAM y el byte siguiente (16 bits)
	ld de,02000h		;9171
	add hl,de			;9174
	call 0004dh		;9175   ; BIOS WRTVRM - Writes data in VRAM
	ret			;9178
bio_dia_mas:		; pasa al dia siguiente: los tres angulos suben
	call bio_sube_sensibilidad		;9179   ; bio_sube_sensibilidad: sube el angulo de la sensibilidad
	call bio_sube_fisico		;917c   ; bio_sube_fisico: sube el angulo del fisico
	call bio_sube_intelecto		;917f   ; bio_sube_intelecto: sube el angulo del intelecto
	ret			;9182
bio_sube_sensibilidad:		; sube el angulo de la sensibilidad
	ld a,(0e03fh)		;9183   ; lee la columna de la grafica
	ld hl,0e06ch		;9186
	ld c,006h		;9189
	call sube_con_tope		;918b   ; sube_con_tope: sube (HL); si llega a C vuelve a 0
	ret nc			;918e
	ld hl,(0e02fh)		;918f   ; lee el angulo de la sensibilidad (28 dias) y el byte siguiente (16 bits)
	inc hl			;9192
	ld (0e02fh),hl		;9193   ; guarda el angulo de la sensibilidad (28 dias) y el byte siguiente (16 bits)
	ret			;9196
bio_sube_fisico:		; sube el angulo del fisico
	ld a,(0e03fh)		;9197   ; lee la columna de la grafica
	ld hl,0e06bh		;919a
	ld c,004h		;919d
	call sube_con_tope		;919f   ; sube_con_tope: sube (HL); si llega a C vuelve a 0
	ret nc			;91a2
	ld a,(0e03fh)		;91a3   ; lee la columna de la grafica
	ld hl,0e06dh		;91a6
	ld c,014h		;91a9
	call sube_con_tope		;91ab   ; sube_con_tope: sube (HL); si llega a C vuelve a 0
	ret nc			;91ae
	ld hl,(0e02dh)		;91af   ; lee el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	dec hl			;91b2
	ld (0e02dh),hl		;91b3   ; guarda el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	ret			;91b6
bio_sube_intelecto:		; sube el angulo del intelecto
	ld a,(0e06bh)		;91b7
	and a			;91ba
	ret z			;91bb
	ld hl,(0e031h)		;91bc   ; lee el angulo del intelecto (33 dias) y el byte siguiente (16 bits)
	inc hl			;91bf
	ld (0e031h),hl		;91c0   ; guarda el angulo del intelecto (33 dias) y el byte siguiente (16 bits)
	ret			;91c3
bio_dia_menos:		; pasa al dia anterior: los tres angulos bajan
	call bio_baja_sensibilidad		;91c4   ; bio_baja_sensibilidad: baja el angulo de la sensibilidad
	call bio_baja_fisico		;91c7   ; bio_baja_fisico: baja el angulo del fisico
	call bio_baja_intelecto		;91ca   ; bio_baja_intelecto: baja el angulo del intelecto
	ret			;91cd
bio_baja_sensibilidad:		; baja el angulo de la sensibilidad
	ld a,(0e03fh)		;91ce   ; lee la columna de la grafica
	ld hl,0e06ch		;91d1
	ld c,006h		;91d4
	call baja_con_tope		;91d6   ; baja_con_tope: baja (HL); si llega a -C vuelve a 0
	ret nc			;91d9
	ld hl,(0e02fh)		;91da   ; lee el angulo de la sensibilidad (28 dias) y el byte siguiente (16 bits)
	dec hl			;91dd
	ld (0e02fh),hl		;91de   ; guarda el angulo de la sensibilidad (28 dias) y el byte siguiente (16 bits)
	ret			;91e1
bio_baja_fisico:		; baja el angulo del fisico
	ld a,(0e03fh)		;91e2   ; lee la columna de la grafica
	ld hl,0e06bh		;91e5
	ld c,004h		;91e8
	call baja_con_tope		;91ea   ; baja_con_tope: baja (HL); si llega a -C vuelve a 0
	ret nc			;91ed
	ld hl,0e06dh		;91ee
	ld c,014h		;91f1
	call baja_con_tope		;91f3   ; baja_con_tope: baja (HL); si llega a -C vuelve a 0
	ret nc			;91f6
	ld hl,(0e02dh)		;91f7   ; lee el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	inc hl			;91fa
	ld (0e02dh),hl		;91fb   ; guarda el angulo del fisico (23 dias) y el byte siguiente (16 bits)
	ret			;91fe
bio_baja_intelecto:		; baja el angulo del intelecto
	ld a,(0e06bh)		;91ff
	and a			;9202
	ret z			;9203
	ld hl,(0e031h)		;9204   ; lee el angulo del intelecto (33 dias) y el byte siguiente (16 bits)
	dec hl			;9207
	ld (0e031h),hl		;9208   ; guarda el angulo del intelecto (33 dias) y el byte siguiente (16 bits)
	ret			;920b
or_en_color:		; OR de A en el color de B casillas (VRAM + 0x2000)
	ld de,02000h		;920c
L_920F:
	add hl,de			;920f
	push af			;9210
	ld d,a			;9211
	call 0004ah		;9212   ; BIOS RDVRM - Reads the content of VRAM
	or d			;9215
	call 0004dh		;9216   ; BIOS WRTVRM - Writes data in VRAM
	pop af			;9219
	ld de,00008h		;921a
	djnz L_920F		;921d
	ret			;921f
or_en_color_8:		; OR de A en 8 filas de color de B casillas
	ld de,02000h		;9220
	add hl,de			;9223
L_9224:
	push bc			;9224
	push hl			;9225
	ld b,008h		;9226
L_9228:
	push af			;9228   ; el byte de color...
	ld d,a			;9229
	call 0004ah		;922a   ; BIOS RDVRM - Reads the content of VRAM | ...que habia...
	or d			;922d   ; ...con los bits de A...
	call 0004dh		;922e   ; BIOS WRTVRM - Writes data in VRAM | ...vuelve a la VRAM
	pop af			;9231
	inc hl			;9232   ; la casilla siguiente
	djnz L_9228		;9233   ; las B casillas
	pop hl			;9235
	ld de,00100h		;9236   ; la fila siguiente (0x100)
	add hl,de			;9239
	pop bc			;923a
	djnz L_9224		;923b   ; las filas
	ret			;923d
bio_avanza_grafica_msx2:		; un paso de la grafica en MSX2
	call bio_alturas_mas		;923e   ; bio_alturas_mas: las alturas de los tres ciclos (desplazamientos 4, 3, 2)
	call bio_pinta_tres_msx2		;9241   ; bio_pinta_tres_msx2: pinta un punto de cada ciclo en MSX2 (comando del VDP)
	ld hl,0e03fh		;9244   ; apunta a la columna de la grafica
	inc (hl)			;9247
	ret			;9248
bio_pinta_tres_msx2:		; pinta un punto de cada ciclo en MSX2 (comando del VDP)
	ld hl,(0e05ah)		;9249   ; lee la altura del fisico y el byte siguiente (16 bits)
	ld bc,0010ch		;924c
	call vdp_linea_vertical_b		;924f   ; vdp_linea_vertical_b: una linea con el lado largo en vertical (p05:8365)
	ld hl,(0e05ch)		;9252   ; lee la altura de la sensibilidad y el byte siguiente (16 bits)
	ld bc,0010dh		;9255
	call vdp_linea_vertical_b		;9258   ; vdp_linea_vertical_b: una linea con el lado largo en vertical (p05:8365)
	ld hl,(0e05eh)		;925b   ; lee la altura del intelecto y el byte siguiente (16 bits)
	ld bc,0010eh		;925e
	call vdp_linea_vertical_b		;9261   ; vdp_linea_vertical_b: una linea con el lado largo en vertical (p05:8365)
	ret			;9264
bio_alturas_mas:		; las alturas de los tres ciclos (desplazamientos 4, 3, 2)
	ld hl,0e02dh		;9265   ; apunta a el angulo del fisico (23 dias)
	ld de,0e05ah		;9268   ; apunta a la altura del fisico
	ld a,004h		;926b
	call bio_altura		;926d   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e02fh		;9270   ; apunta a el angulo de la sensibilidad (28 dias)
	ld de,0e05ch		;9273   ; apunta a la altura de la sensibilidad
	ld a,003h		;9276
	call bio_altura		;9278   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e031h		;927b   ; apunta a el angulo del intelecto (33 dias)
	ld de,0e05eh		;927e   ; apunta a la altura del intelecto
	ld a,002h		;9281
	call bio_altura		;9283   ; bio_altura: la altura de un ciclo: el seno del angulo
	ret			;9286
bio_alturas_menos:		; las alturas de los tres ciclos (desplazamientos -4, -3, -2)
	ld hl,0e02dh		;9287   ; apunta a el angulo del fisico (23 dias)
	ld de,0e05ah		;928a   ; apunta a la altura del fisico
	ld a,0fch		;928d
	call bio_altura		;928f   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e02fh		;9292   ; apunta a el angulo de la sensibilidad (28 dias)
	ld de,0e05ch		;9295   ; apunta a la altura de la sensibilidad
	ld a,0fdh		;9298
	call bio_altura		;929a   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e031h		;929d   ; apunta a el angulo del intelecto (33 dias)
	ld de,0e05eh		;92a0   ; apunta a la altura del intelecto
	ld a,0feh		;92a3
	call bio_altura		;92a5   ; bio_altura: la altura de un ciclo: el seno del angulo
	ret			;92a8
bio_alturas:		; las alturas de los tres ciclos (sin desplazar)
	ld hl,0e02dh		;92a9   ; apunta a el angulo del fisico (23 dias)
	ld de,0e05ah		;92ac   ; apunta a la altura del fisico
	xor a			;92af
	call bio_altura		;92b0   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e02fh		;92b3   ; apunta a el angulo de la sensibilidad (28 dias)
	ld de,0e05ch		;92b6   ; apunta a la altura de la sensibilidad
	xor a			;92b9
	call bio_altura		;92ba   ; bio_altura: la altura de un ciclo: el seno del angulo
	ld hl,0e031h		;92bd   ; apunta a el angulo del intelecto (33 dias)
	ld de,0e05eh		;92c0   ; apunta a la altura del intelecto
	xor a			;92c3
	call bio_altura		;92c4   ; bio_altura: la altura de un ciclo: el seno del angulo
	ret			;92c7
bio_altura:		; la altura de un ciclo: el seno del angulo
	push de			;92c8
	push hl			;92c9
	call bio_angulo_desplazado		;92ca   ; bio_angulo_desplazado: el angulo mas el desplazamiento A
	pop hl			;92cd
	call bio_seno		;92ce   ; bio_seno: la altura del angulo (p05:932F) y la columna (0xE03F)
	pop de			;92d1
	ex de,hl			;92d2
	call bio_a_pantalla		;92d3   ; bio_a_pantalla: pasa la altura a la pantalla (+0x88, +0x20)
	ret			;92d6
bio_a_pantalla:		; pasa la altura a la pantalla (+0x88, +0x20)
	ld a,e			;92d7   ; la altura + 0x88...
	add a,088h		;92d8
	ld e,a			;92da
	ld (hl),a			;92db   ; ...a la tabla
	inc hl			;92dc
	ld a,d			;92dd   ; la columna + 0x20
	add a,020h		;92de
	ld d,a			;92e0
	ld (hl),d			;92e1
	ret			;92e2
bio_angulo_desplazado:		; el angulo mas el desplazamiento A
	push hl			;92e3   ; el angulo...
	ld e,(hl)			;92e4
	inc hl			;92e5
	ld d,(hl)			;92e6
	call suma_con_signo		;92e7   ; ...mas el desplazamiento
	ex de,hl			;92ea
	call angulo_0_359		;92eb   ; entre 0 y 359
	ex de,hl			;92ee
	pop hl			;92ef
	ld (hl),e			;92f0   ; y se guarda
	inc hl			;92f1
	ld (hl),d			;92f2
	ret			;92f3
suma_con_signo:		; DE + A con signo
	add a,080h		;92f4
	jr nc,L_92FC		;92f6
	call resta_negativo		;92f8   ; resta_negativo: DE - (-A)
	ret			;92fb
L_92FC:
	add a,080h		;92fc
	call de_mas_a		;92fe   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	ret			;9301
resta_negativo:		; DE - (-A)
	add a,080h		;9302   ; A con signo (0x80 = cero)
	neg		;9304   ; en negativo
	ld b,a			;9306
	ld a,e			;9307   ; se resta de DE
	sub b			;9308
	ld e,a			;9309
	jr nc,L_930D		;930a
	dec d			;930c
L_930D:
	ret			;930d
bio_seno:		; la altura del angulo (p05:932F) y la columna (0xE03F)
	ld e,(hl)			;930e
	inc hl			;930f
	ld d,(hl)			;9310
	ex de,hl			;9311
	call seno		;9312   ; seno: el seno del angulo HL: el cuadrante (90, 180, 270) y la tabla
	ld e,a			;9315
	ld a,(0e03fh)		;9316   ; lee la columna de la grafica
	ld d,a			;9319
	ex de,hl			;931a
	ret			;931b
vdp_linea_vertical_b:		; una linea con el lado largo en vertical (p05:8365)
	call vdp_linea_vertical		;931c   ; vdp_linea_vertical: traza una linea con el comando del VDP (LINE, 0x70) con el lado largo en vertical (ARG = 1)
	ret			;931f
L_9320:
	scf			;9320   ; DE / 8 (sin signo)
	ccf			;9321
	srl d		;9322
	rr e		;9324
	srl d		;9326
	rr e		;9328
	srl d		;932a
	rr e		;932c
	ret			;932e
seno:		; el seno del angulo HL: el cuadrante (90, 180, 270) y la tabla
	ld de,0010eh		;932f   ; 270 grados o mas: el cuarto cuadrante
	rst 20h			;9332   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nc,L_9374		;9333
	ld de,000b4h		;9335   ; 180 o mas: el tercero
	rst 20h			;9338   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nc,L_9363		;9339
	ld de,0005ah		;933b   ; 90 o mas: el segundo
	rst 20h			;933e   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nc,L_934F		;933f
	ld a,l			;9341   ; el primero: el angulo...
	add a,a			;9342   ; ...x 2 bytes...
	ld hl,094e8h		;9343   ; ...en la tabla del seno de p05:94E8
	call hl_mas_a		;9346   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9349   ; el seno, en negativo (la pantalla crece hacia abajo)
	neg		;934a
	inc hl			;934c
	ld b,(hl)			;934d   ; B = el segundo byte
	ret			;934e
L_934F:
	ld de,000b4h		;934f   ; el tercer cuadrante (180-269): angulo - 180
	ex de,hl			;9352
	sbc hl,de		;9353
	ld a,l			;9355   ; x 2 bytes
	add a,a			;9356
	ld hl,094e8h		;9357   ; en la tabla del seno de p05:94E8
	call hl_mas_a		;935a   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;935d   ; el seno, en negativo
	neg		;935e
	inc hl			;9360
	ld b,(hl)			;9361   ; B = el segundo byte
	ret			;9362
L_9363:
	ld de,000b4h		;9363
	sbc hl,de		;9366
	ld a,l			;9368
	add a,a			;9369
	ld hl,094e8h		;936a
	call hl_mas_a		;936d   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9370
	inc hl			;9371
	ld b,(hl)			;9372
	ret			;9373
L_9374:
	ld de,00168h		;9374   ; el cuarto cuadrante (270-359): angulo - 360
	ex de,hl			;9377
	sbc hl,de		;9378
	ld a,l			;937a   ; x 2 bytes
	add a,a			;937b
	ld hl,094e8h		;937c   ; en la tabla del seno de p05:94E8
	call hl_mas_a		;937f   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9382   ; el seno
	inc hl			;9383
	ld b,(hl)			;9384   ; B = el segundo byte
	ret			;9385
bio_dias_del_mes_b:		; los dias del mes (tabla p05:959E), con febrero segun el bisiesto
	call bio_es_bisiesto		;9386   ; bio_es_bisiesto: mira si el ano es bisiesto (4, 100 y 400): 0xE041
	ld a,000h		;9389
	jr nc,L_9392		;938b
	ld a,001h		;938d
	ld (0e041h),a		;938f   ; guarda el ano es bisiesto
L_9392:
	ld hl,0959eh		;9392
	dec a			;9395
	add a,a			;9396
	call hl_mas_a		;9397   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld d,(hl)			;939a
	inc hl			;939b
	ld e,(hl)			;939c
	dec a			;939d
	ld b,a			;939e
	call de_mas_a		;939f   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	ld (0e042h),de		;93a2
	ret			;93a6
resta_24:		; resta DE de los 24 bits de HL
	ld a,(hl)			;93a7   ; el byte bajo menos E
	sub e			;93a8
	ld (hl),a			;93a9
	inc hl			;93aa
	ld a,(hl)			;93ab   ; el medio menos D con el acarreo
	sbc a,d			;93ac
	ld (hl),a			;93ad
	jr nc,L_93B7		;93ae   ; sin acarreo, ya esta
	inc hl			;93b0
	ld a,(hl)			;93b1   ; si no, el alto baja uno
	dec a			;93b2
	jr nc,L_93B7		;93b3
	inc hl			;93b5
	dec (hl)			;93b6
L_93B7:
	ret			;93b7
resta_32:		; resta los 32 bits de HL de los de DE
	ex de,hl			;93b8   ; HL = el sustraendo, DE = el minuendo
	ld a,(de)			;93b9   ; el byte 0
	ld b,(hl)			;93ba   ; menos el byte 0 del sustraendo
	sub b			;93bb
	ld (de),a			;93bc   ; el resultado, en el minuendo
	inc hl			;93bd   ; el byte siguiente
	inc de			;93be
	ld a,(de)			;93bf   ; el byte 1, con el acarreo
	ld b,(hl)			;93c0
	sbc a,b			;93c1   ; con el acarreo
	ld (de),a			;93c2
	inc hl			;93c3
	inc de			;93c4
	ld a,(de)			;93c5   ; el byte 2
	ld b,(hl)			;93c6
	sbc a,b			;93c7   ; con el acarreo
	ld (de),a			;93c8
	inc hl			;93c9
	inc de			;93ca
	ld a,(de)			;93cb   ; el byte 3
	ld b,(hl)			;93cc
	sbc a,b			;93cd   ; con el acarreo
	ld (de),a			;93ce
	ret			;93cf
L_93D0:
	ld b,004h		;93d0
	or a			;93d2
L_93D3:
	ld a,(de)			;93d3   ; suma con acarreo...
	inc de			;93d4
	adc a,(hl)			;93d5
	ld (hl),a			;93d6
	inc hl			;93d7
	djnz L_93D3		;93d8   ; ...B bytes
	ret			;93da
multiplica:		; HL = DE x BC
	ld hl,00000h		;93db
L_93DE:
	ld a,c			;93de   ; multiplica bit a bit: BC a cero acaba
	or b			;93df
	jr z,L_93EF		;93e0
	srl b		;93e2   ; el bit bajo de BC
	rr c		;93e4
	jr nc,L_93E9		;93e6
	add hl,de			;93e8   ; si esta, suma DE
L_93E9:
	sla e		;93e9
	rl d		;93eb
	jr L_93DE		;93ed
L_93EF:
	ret			;93ef
suma_24:		; suma DE a los 24 bits de HL
	xor a			;93f0
	ld a,(hl)			;93f1   ; el byte bajo mas E
	add a,e			;93f2
	ld (hl),a			;93f3
	inc hl			;93f4
	ld a,(hl)			;93f5   ; el medio mas D con el acarreo
	adc a,d			;93f6
	ld (hl),a			;93f7
	jr nc,L_9404		;93f8   ; sin acarreo, ya esta
	inc hl			;93fa
	ld a,(hl)			;93fb   ; si no, el alto sube uno
	inc a			;93fc
	ld (hl),a			;93fd
	jr nc,L_9404		;93fe
	inc hl			;9400
	ld a,(hl)			;9401   ; y el cuarto, si hace falta
	inc a			;9402
	ld (hl),a			;9403
L_9404:
	ret			;9404
multiplica_32:		; DE:HL = HL x DE
	push ix		;9405   ; guarda los registros
	push af			;9407
	push bc			;9408
	push de			;9409
	pop ix		;940a   ; IX = DE
	push hl			;940c
	pop bc			;940d   ; BC = HL
	ld hl,00000h		;940e   ; el resultado de 32 bits en HL:DE, a cero
	ld de,00000h		;9411
	ld a,010h		;9414   ; 16 bits
L_9416:
	sla e		;9416   ; el resultado se dobla...
	rl d		;9418
	rl l		;941a
	rl h		;941c
	add ix,ix		;941e   ; ...y el bit alto de IX...
	jr nc,L_9428		;9420   ; ...si esta, suma BC
	ex de,hl			;9422
	add hl,bc			;9423
	ex de,hl			;9424
	jr nc,L_9428		;9425   ; con el acarreo a HL
	inc hl			;9427
L_9428:
	dec a			;9428   ; los 16 bits
	jr nz,L_9416		;9429
	pop bc			;942b
	pop af			;942c
	pop ix		;942d
	ret			;942f
divide:		; DE / BC: cociente en DE y resto en HL
	ld hl,00000h		;9430
	exx			;9433
	ld b,010h		;9434
L_9436:
	exx			;9436   ; un paso de la division: el bit alto de DE...
	sla e		;9437
	rl d		;9439
	adc hl,hl		;943b   ; ...entra en HL
	sbc hl,bc		;943d   ; si cabe el divisor, se resta...
	jr c,L_9444		;943f
	inc e			;9441   ; ...y el bit del cociente es 1
	jr L_9445		;9442
L_9444:
	add hl,bc			;9444
L_9445:
	exx			;9445
	djnz L_9436		;9446
	exx			;9448
	ret			;9449
divide_32:		; divide 32 bits por BC
	push hl			;944a
	ld hl,00000h		;944b
	exx			;944e
	ld b,010h		;944f
L_9451:
	exx			;9451   ; un paso de la division: el bit alto de DE...
	sla e		;9452
	rl d		;9454
	adc hl,hl		;9456   ; ...entra en HL
	sbc hl,bc		;9458   ; si cabe el divisor, se resta...
	jr c,L_945F		;945a
	inc e			;945c   ; ...y el bit del cociente es 1
	jr L_9460		;945d
L_945F:
	add hl,bc			;945f
L_9460:
	exx			;9460
	djnz L_9451		;9461
	exx			;9463
	ld (0e088h),de		;9464   ; guarda resultado de 32 bits (parte alta) y el byte siguiente (16 bits)
	pop de			;9468
	exx			;9469
	ld b,010h		;946a
L_946C:
	exx			;946c   ; un paso de la division: el bit alto de DE...
	sla e		;946d
	rl d		;946f
	adc hl,hl		;9471   ; ...entra en HL
	sbc hl,bc		;9473   ; si cabe el divisor, se resta...
	jr c,L_947A		;9475
	inc e			;9477   ; ...y el bit del cociente es 1
	jr L_947B		;9478
L_947A:
	add hl,bc			;947a
L_947B:
	exx			;947b
	djnz L_946C		;947c
	exx			;947e
	ld (0e08ch),de		;947f   ; guarda la posicion del punto en la VRAM y el byte siguiente (16 bits)
	ret			;9483
L_9484:
	call signo_de_division		;9484   ; signo_de_division: el signo del resultado (B y D)
	push af			;9487   ; guarda el signo
	ld l,c			;9488   ; BC...
	ld h,b			;9489
	call valor_absoluto		;948a   ; ...en positivo
	ld c,l			;948d
	ld b,h			;948e
	ex de,hl			;948f   ; DE...
	call valor_absoluto		;9490   ; ...en positivo
	ex de,hl			;9493
	call divide		;9494   ; la division sin signo
	pop af			;9497   ; el signo
	jr c,L_94A1		;9498   ; positivo: ya esta
	ld a,d			;949a   ; negativo: complemento a dos del cociente
	cpl			;949b
	ld d,a			;949c
	ld a,e			;949d
	cpl			;949e
	ld e,a			;949f
	inc de			;94a0
L_94A1:
	ret			;94a1
valor_absoluto:		; HL = |HL|
	ld a,h			;94a2   ; positivo: tal cual
	or a			;94a3
	jp p,L_94AD		;94a4
	cpl			;94a7   ; negativo: complemento a dos
	ld h,a			;94a8
	ld l,a			;94a9
	cpl			;94aa
	ld l,a			;94ab
	inc hl			;94ac
L_94AD:
	ret			;94ad
signo_de_division:		; el signo del resultado (B y D)
	ld a,b			;94ae   ; el signo del divisor
	or a			;94af
	jp m,L_94BA		;94b0
	ld a,d			;94b3   ; y el del dividendo
	or a			;94b4
	jp p,L_94BF		;94b5
	jr L_94C0		;94b8
L_94BA:
	ld a,d			;94ba
	or a			;94bb
	jp p,L_94C0		;94bc
L_94BF:
	scf			;94bf
L_94C0:
	ret			;94c0
divide_8:		; L / C: cociente en L y resto en H
	ld b,008h		;94c1
	ld h,000h		;94c3
L_94C5:
	add hl,hl			;94c5   ; un paso de la division de 8 bits: L se dobla en HL
	ld a,h			;94c6   ; si H cabe en C...
	sub c			;94c7
	jr c,L_94CC		;94c8
	inc l			;94ca   ; ...el bit del cociente es 1...
	ld h,a			;94cb   ; ...y se resta
L_94CC:
	djnz L_94C5		;94cc
	ret			;94ce
divide_por_4:		; DE = DE / 4
	push de			;94cf
	ex de,hl			;94d0
	ld bc,00004h		;94d1
	call divide		;94d4   ; divide: DE / BC: cociente en DE y resto en HL
	ex de,hl			;94d7
	pop de			;94d8
	ret			;94d9
L_94DA:
	ex de,hl			;94da
	ld bc,00010h		;94db
	call divide		;94de   ; divide: DE / BC: cociente en DE y resto en HL
	ret			;94e1
por_10:		; A x 10
	add a,a			;94e2   ; A x 2
	ld b,a			;94e3
	add a,a			;94e4   ; x 8
	add a,a			;94e5
	add a,b			;94e6   ; x 8 + x 2 = x 10
	ret			;94e7

; ----------------------------------------------------------------------
; DATOS resto_94E8: lo apuntan con el banco puesto p05:9343 (0x94E8), p05:9357
;   (0x94E8), p05:936A (0x94E8), p05:937C (0x94E8), p05:8F25 (0x959E),
;   p05:9392 (0x959E); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9343, p05:9357, p05:936A, p05:937C, p05:8F25,
;   p05:9392 (207 bytes)
;   0x94e8..0x95b7  (207 bytes)
DATA_resto_94E8:
	defb 000h,001h,000h,001h,001h,001h,002h,001h,002h,001h,003h,001h,004h,001h,004h,001h	; 94e8  ................
	defb 005h,001h,006h,001h,006h,001h,007h,001h,008h,001h,008h,001h,009h,001h,00ah,001h	; 94f8  ................
	defb 00bh,001h,00bh,001h,00ch,001h,00dh,001h,00dh,001h,00eh,001h,00eh,001h,00fh,001h	; 9508  ................
	defb 010h,001h,010h,001h,011h,001h,012h,001h,012h,001h,013h,001h,014h,001h,014h,001h	; 9518  ................
	defb 015h,001h,015h,001h,016h,001h,016h,001h,017h,001h,018h,001h,018h,001h,019h,001h	; 9528  ................
	defb 019h,001h,01ah,002h,01ah,002h,01bh,002h,01bh,002h,01ch,002h,01ch,002h,01dh,002h	; 9538  ................
	defb 01dh,002h,01eh,002h,01eh,002h,01fh,002h,01fh,002h,01fh,002h,020h,002h,020h,002h	; 9548  ............ . .
	defb 021h,002h,021h,002h,021h,002h,022h,002h,022h,002h,022h,002h,023h,002h,023h,002h	; 9558  !.!.!.".".".#.#.
	defb 023h,002h,024h,002h,024h,002h,024h,002h,025h,002h,025h,002h,025h,002h,025h,002h	; 9568  #.$.$.$.%.%.%.%.
	defb 026h,002h,026h,002h,026h,002h,026h,002h,026h,002h,026h,002h,027h,002h,027h,002h	; 9578  &.&.&.&.&.&.'.'.
	defb 027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h,027h,002h	; 9588  '.'.'.'.'.'.'.'.
	defb 027h,002h,027h,002h,028h,002h,000h,000h,000h,01fh,000h,03bh,000h,05ah,000h,078h	; 9598  '.'.(........Z.x
	defb 000h,097h,000h,0b5h,000h,0d4h,000h,0f3h,001h,011h,001h,030h,001h,04eh,0c9h	; 95a8  ...........0.N.

; ======================================================================
; CODIGO 0x95b7..0x95bd  (6 bytes)
; ======================================================================


bio_estado_fecha:		; el estado de pedir una fecha (MSX1)
	ld a,(0e005h)		;95b7   ; lee la fecha que se pide (2 = la de hoy)
	call despacha		;95ba   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_95BD: tabla de 8 palabras del despachador (call 0x408D en
;   0x95BA); lo leen el despachador (16 bytes)
;   0x95bd..0x95cd  (16 bytes)
DATA_saltos_95BD:
	defb 0ebh,095h	; 95bd
	defb 0f9h,095h	; 95bf
	defb 0cdh,095h	; 95c1
	defb 005h,096h	; 95c3
	defb 0ffh,095h	; 95c5
	defb 0dch,095h	; 95c7
	defb 005h,096h	; 95c9
	defb 00bh,096h	; 95cb

; ======================================================================
; CODIGO 0x95cd..0x9680  (179 bytes)
; ======================================================================


L_95CD:
	call bio_si_mes_o_dia		;95cd   ; bio_si_mes_o_dia: si el cursor esta en el mes (8) o el dia (0x10), su texto
	call bio_pide_fecha		;95d0   ; bio_pide_fecha: lee teclas hasta una buena y la mete en la fecha
	jp c,L_97E4		;95d3
	call bio_segun_campo		;95d6   ; bio_segun_campo: salta segun el campo del cursor (p05:97C6)
	jp L_9915		;95d9
L_95DC:
	call bio_si_dia		;95dc   ; bio_si_dia: si el cursor esta en el dia (0x10), su texto
	call bio_pide_fecha		;95df   ; bio_pide_fecha: lee teclas hasta una buena y la mete en la fecha
	jp c,L_97E4		;95e2
	call bio_segun_campo		;95e5   ; bio_segun_campo: salta segun el campo del cursor (p05:97C6)
	jp L_9915		;95e8
L_95EB:
	ld b,010h		;95eb
	ld hl,0e090h		;95ed   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
L_95F0:
	ld a,0f4h		;95f0
	ld (hl),a			;95f2
	inc hl			;95f3
	djnz L_95F0		;95f4
	jp L_9905		;95f6
L_95F9:
	call bio_texto_9e50		;95f9   ; bio_texto_9e50: pinta el texto de p05:9E50
	jp L_9905		;95fc
L_95FF:
	call bio_cursor_al_mes		;95ff   ; bio_cursor_al_mes: el cursor y su tope al mes (8)
	jp L_9905		;9602
L_9605:
	call bio_texto_9e47		;9605   ; bio_texto_9e47: pinta el texto de p05:9E47
	jp L_9905		;9608
L_960B:
	call bio_guarda_fecha		;960b   ; bio_guarda_fecha: copia la fecha tecleada (0xE098...) a 0xE062
	scf			;960e
	ret			;960f
bio_vuelca:		; vuelca la copia de la tabla de nombres y las cifras
	call bio_vuelca_nombres		;9610   ; bio_vuelca_nombres: vuelca la copia de la tabla de nombres (0xE300) a 0x3800
	call bio_cifras_a_nombres		;9613   ; bio_cifras_a_nombres: las cifras de las dos fechas (0xE090...) a la copia de nombres
	ret			;9616
bio_si_mes_o_dia:		; si el cursor esta en el mes (8) o el dia (0x10), su texto
	ld a,(0e07ah)		;9617   ; lee la cifra en la que esta el cursor
	cp 008h		;961a
	jr z,L_9624		;961c
bio_si_dia:		; si el cursor esta en el dia (0x10), su texto
	ld a,(0e07ah)		;961e   ; lee la cifra en la que esta el cursor
	cp 010h		;9621
	ret nz			;9623
L_9624:
	call bio_texto_9e3e		;9624   ; bio_texto_9e3e: pinta el texto de p05:9E3E
	ret			;9627
bio_cifras_a_nombres:		; las cifras de las dos fechas (0xE090...) a la copia de nombres
	ld de,0e090h		;9628   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
	ld hl,0e34fh		;962b   ; el ano de nacimiento a la copia de nombres (0xE34F)...
	ld b,004h		;962e   ; ...4 cifras
	call cifras_a_letras		;9630   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ld de,0e094h		;9633   ; el mes (0xE356)
	ld hl,0e356h		;9636
	ld b,002h		;9639
	call cifras_a_letras		;963b   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ld de,0e096h		;963e   ; el dia (0xE35B)
	ld hl,0e35bh		;9641
	ld b,002h		;9644
	call cifras_a_letras		;9646   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ld de,0e098h		;9649   ; el ano de hoy (0xE3AF)
	ld hl,0e3afh		;964c
	ld b,004h		;964f
	call cifras_a_letras		;9651   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ld de,0e09ch		;9654   ; el mes (0xE3B6)
	ld hl,0e3b6h		;9657
	ld b,002h		;965a
	call cifras_a_letras		;965c   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ld de,0e09eh		;965f   ; el dia (0xE3BB)
	ld hl,0e3bbh		;9662
	ld b,002h		;9665
	call cifras_a_letras		;9667   ; cifras_a_letras: B cifras de DE a letras (+0x10) en HL
	ret			;966a
cifras_a_letras:		; B cifras de DE a letras (+0x10) en HL
	ld a,(de)			;966b   ; una cifra...
	add a,010h		;966c   ; ...a letra (+0x10)
	ld (hl),a			;966e
	inc hl			;966f
	inc de			;9670
	djnz cifras_a_letras		;9671   ; B cifras
	ret			;9673
bio_pide_fecha:		; lee teclas hasta una buena y la mete en la fecha
	call bio_espera_tecla		;9674   ; bio_espera_tecla: vuelca, anima el cursor y espera una tecla (0xE058)
	call bio_tecla		;9677   ; bio_tecla: B = la orden de la tecla A: RETURN, flechas o cifra
	jr c,bio_pide_fecha		;967a
	ld a,b			;967c
	call despacha		;967d   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_9680: tabla de 5 palabras del despachador (call 0x408D en
;   0x967D); lo leen el despachador (10 bytes)
;   0x9680..0x968a  (10 bytes)
DATA_saltos_9680:
	defb 01bh,09ah	; 9680
	defb 0eah,099h	; 9682
	defb 0f8h,099h	; 9684
	defb 00ah,09ah	; 9686
	defb 0e5h,099h	; 9688

; ======================================================================
; CODIGO 0x968a..0x96d2  (72 bytes)
; ======================================================================


bio_espera_tecla:		; vuelca, anima el cursor y espera una tecla (0xE058)
	call bio_vuelca		;968a   ; bio_vuelca: vuelca la copia de la tabla de nombres y las cifras
	call bio_parpadeo		;968d   ; bio_parpadeo: cada 16 cuadros cambia el parpadeo (0xE00D)
	call bio_cursor		;9690   ; bio_cursor: pinta el cursor parpadeando en su cifra (tabla p05:96D2)
	call 0009ch		;9693   ; BIOS CHSNS - Tests the status of the keyboard buffer
	jr z,bio_espera_tecla		;9696
	call 0009fh		;9698   ; BIOS CHGET - One character input (waiting)
	ld (0e058h),a		;969b   ; guarda la tecla pulsada
	ret			;969e
L_969F:
	ld a,0f4h		;969f
	ld b,004h		;96a1
L_96A3:
	ld (hl),a			;96a3
	inc hl			;96a4
	djnz L_96A3		;96a5
	ret			;96a7
L_96A8:
	inc hl			;96a8
	ld a,0f4h		;96a9
	ld (hl),a			;96ab
	ret			;96ac
bio_cursor:		; pinta el cursor parpadeando en su cifra (tabla p05:96D2)
	call bio_cursor_al_final		;96ad   ; bio_cursor_al_final: Z si el cursor esta en la ultima cifra
	jr z,L_96D1		;96b0   ; en la ultima cifra no hay cursor
	ld hl,0e07ah		;96b2   ; la cifra del cursor...
	ld a,(hl)			;96b5
	ld c,a			;96b6
	add a,a			;96b7   ; ...su posicion en la copia de nombres (tabla de p05:96D2)
	ld hl,096d2h		;96b8
	call hl_mas_a		;96bb   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;96be
	inc hl			;96bf
	ld d,(hl)			;96c0
	ld b,004h		;96c1   ; 4 = el cursor
	call bio_cifra_del_cursor		;96c3   ; o la cifra que hay
	ld a,(0e00dh)		;96c6   ; el parpadeo...
	bit 2,a		;96c9   ; ...bit 2
	jr nz,L_96CF		;96cb
	ld b,00fh		;96cd   ; apagado: la casilla vacia (0x0F)
L_96CF:
	ld a,b			;96cf
	ld (de),a			;96d0
L_96D1:
	ret			;96d1

; ----------------------------------------------------------------------
; DATOS resto_96D2: lo apuntan con el banco puesto p05:96B8 (0x96D2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:96B8 (32 bytes)
;   0x96d2..0x96f2  (32 bytes)
DATA_resto_96D2:
	defb 04fh,0e3h,050h,0e3h,051h,0e3h,052h,0e3h,056h,0e3h,057h,0e3h,05bh,0e3h,05ch,0e3h	; 96d2  O.P.Q.R.V.W.[.\.
	defb 0afh,0e3h,0b0h,0e3h,0b1h,0e3h,0b2h,0e3h,0b6h,0e3h,0b7h,0e3h,0bbh,0e3h,0bch,0e3h	; 96e2  ................

; ======================================================================
; CODIGO 0x96f2..0x9707  (21 bytes)
; ======================================================================


bio_cifra_del_cursor:		; B = la cifra que hay bajo el cursor
	ld hl,0e090h		;96f2   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
	ld a,(0e07ah)		;96f5   ; lee la cifra en la que esta el cursor
	call hl_mas_a		;96f8   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld b,(hl)			;96fb
	ld a,b			;96fc
	add a,010h		;96fd
	ld b,a			;96ff
	ret			;9700
bio_estado_fecha_msx2:		; el estado de pedir una fecha (MSX2)
	ld a,(0e005h)		;9701   ; lee la fecha que se pide (2 = la de hoy)
	call despacha		;9704   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_9707: tabla de 8 palabras del despachador (call 0x408D en
;   0x9704); lo leen el despachador (16 bytes)
;   0x9707..0x9717  (16 bytes)
DATA_saltos_9707:
	defb 017h,097h	; 9707
	defb 04dh,097h	; 9709
	defb 029h,097h	; 970b
	defb 05fh,097h	; 970d
	defb 053h,097h	; 970f
	defb 03bh,097h	; 9711
	defb 05fh,097h	; 9713
	defb 065h,097h	; 9715

; ======================================================================
; CODIGO 0x9717..0x9785  (110 bytes)
; ======================================================================


L_9717:
	ld b,010h		;9717
	ld hl,0e090h		;9719   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
L_971C:
	ld a,0d4h		;971c   ; 16 cifras a 0xD4 (el guion)
	ld (hl),a			;971e
	inc hl			;971f
	djnz L_971C		;9720
	xor a			;9722   ; 0xE004 = 0
	ld (0e004h),a		;9723
	jp L_9905		;9726   ; y sigue
L_9729:
	call bio_si_mes_o_dia_msx2		;9729   ; bio_si_mes_o_dia_msx2: si el cursor esta en el mes o el dia, su texto (MSX2)
	call bio_pinta_fecha_1		;972c   ; bio_pinta_fecha_1: pinta la fecha de nacimiento (MSX2)
	call bio_pide_fecha_msx2		;972f   ; bio_pide_fecha_msx2: lee teclas hasta una buena (MSX2)
	jp c,L_97E4		;9732
	call bio_segun_campo		;9735   ; bio_segun_campo: salta segun el campo del cursor (p05:97C6)
	jp L_9915		;9738
L_973B:
	call bio_si_dia_msx2		;973b   ; bio_si_dia_msx2: si el cursor esta en el dia, su texto (MSX2)
	call bio_pinta_fecha_2		;973e   ; bio_pinta_fecha_2: pinta la fecha de hoy (MSX2)
	call bio_pide_fecha_msx2		;9741   ; bio_pide_fecha_msx2: lee teclas hasta una buena (MSX2)
	jp c,L_97E4		;9744
	call bio_segun_campo		;9747   ; bio_segun_campo: salta segun el campo del cursor (p05:97C6)
	jp L_9915		;974a
L_974D:
	call bio_a066		;974d   ; bio_a066: llama a p06:A066
	jp L_9905		;9750
L_9753:
	call bio_pinta_fecha_1		;9753   ; bio_pinta_fecha_1: pinta la fecha de nacimiento (MSX2)
	call 0a092h		;9756   ; bio_caja_a17c: una caja con sombra, su marco y el texto de p06:A17C
	call bio_cursor_al_mes		;9759   ; bio_cursor_al_mes: el cursor y su tope al mes (8)
	jp L_9905		;975c
L_975F:
	call 0a270h		;975f   ; bio_borra_caja: borra una caja (color 0x44)
	jp L_9905		;9762
L_9765:
	call bio_pinta_fecha_2		;9765   ; bio_pinta_fecha_2: pinta la fecha de hoy (MSX2)
	call bio_guarda_fecha		;9768   ; bio_guarda_fecha: copia la fecha tecleada (0xE098...) a 0xE062
	scf			;976b
	ret			;976c
bio_si_mes_o_dia_msx2:		; si el cursor esta en el mes o el dia, su texto (MSX2)
	ld a,(0e07ah)		;976d   ; lee la cifra en la que esta el cursor
	cp 008h		;9770
	jr z,L_977A		;9772
bio_si_dia_msx2:		; si el cursor esta en el dia, su texto (MSX2)
	ld a,(0e07ah)		;9774   ; lee la cifra en la que esta el cursor
	cp 010h		;9777
	ret nz			;9779
L_977A:
	call 0a23bh		;977a   ; bio_caja_grande: una caja con sombra y su marco
	ret			;977d
bio_segun_campo:		; salta segun el campo del cursor (p05:97C6)
	call bio_campo		;977e   ; bio_campo: B = el campo del cursor: ano (4), mes (6), dia (8)...
	ld a,b			;9781
	call despacha		;9782   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_9785: tabla de 7 palabras del despachador (call 0x408D en
;   0x9782); lo leen el despachador (14 bytes)
;   0x9785..0x9793  (14 bytes)
DATA_saltos_9785:
	defb 00ch,098h	; 9785
	defb 02ch,098h	; 9787
	defb 04ah,098h	; 9789
	defb 01ch,098h	; 978b
	defb 03bh,098h	; 978d
	defb 059h,098h	; 978f
	defb 093h,097h	; 9791

; ======================================================================
; CODIGO 0x9793..0x9978  (485 bytes)
; ======================================================================


L_9793:
	ret			;9793
bio_guarda_fecha:		; copia la fecha tecleada (0xE098...) a 0xE062
	ld b,004h		;9794
	ld de,0e098h		;9796   ; apunta a las cifras de la fecha de hoy
	ld hl,0e062h		;9799   ; apunta a la fecha que se ve (cifras)
	call copia_b		;979c   ; copia_b: copia B bytes de DE a HL
	ld b,002h		;979f
	ld de,0e09ch		;97a1
	ld hl,0e066h		;97a4
	call copia_b		;97a7   ; copia_b: copia B bytes de DE a HL
	ld b,002h		;97aa
	ld de,0e09eh		;97ac
	ld hl,0e068h		;97af
	call copia_b		;97b2   ; copia_b: copia B bytes de DE a HL
	ret			;97b5
copia_b:		; copia B bytes de DE a HL
	ld a,(de)			;97b6   ; copia un byte
	ld (hl),a			;97b7
	inc hl			;97b8
	inc de			;97b9
	djnz copia_b		;97ba   ; B bytes
	ret			;97bc
bio_cursor_al_mes:		; el cursor y su tope al mes (8)
	ld a,008h		;97bd
	ld (0e078h),a		;97bf   ; guarda la ultima cifra a la que llega el cursor
	ld (0e07ah),a		;97c2   ; guarda la cifra en la que esta el cursor
	ret			;97c5
bio_campo:		; B = el campo del cursor: ano (4), mes (6), dia (8)...
	ld b,000h		;97c6
	ld a,(0e07ah)		;97c8   ; la cifra del cursor: 4...
	cp 004h		;97cb   ; el ano de nacimiento: B = 0
	ret z			;97cd
	inc b			;97ce   ; ...6...
	cp 006h		;97cf   ; el mes: 1
	ret z			;97d1
	inc b			;97d2   ; ...8 (los campos de la primera fecha)...
	cp 008h		;97d3   ; el dia: 2
	ret z			;97d5
	inc b			;97d6   ; ...12...
	cp 00ch		;97d7   ; el ano de hoy: 3
	ret z			;97d9
	inc b			;97da   ; ...14...
	cp 00eh		;97db   ; el mes: 4
	ret z			;97dd
	inc b			;97de   ; ...16 (los de la segunda)
	cp 010h		;97df   ; el dia: 5
	ret z			;97e1
	inc b			;97e2   ; otra cifra: 6
	ret			;97e3
L_97E4:
	call bio_comprueba_fecha		;97e4   ; bio_comprueba_fecha: comprueba la fecha: ano, mes y dia
	jp c,L_9915		;97e7
	jp L_9905		;97ea
bio_comprueba_fecha:		; comprueba la fecha: ano, mes y dia
	ld a,(0e005h)		;97ed   ; lee la fecha que se pide (2 = la de hoy)
	cp 002h		;97f0
	jr nz,L_9800		;97f2
	call bio_comprueba_ano		;97f4   ; bio_comprueba_ano: comprueba el ano de nacimiento (0xE010)
	ret c			;97f7
	call bio_comprueba_mes		;97f8   ; bio_comprueba_mes: comprueba el mes de nacimiento
	ret c			;97fb
	call bio_comprueba_dia		;97fc   ; bio_comprueba_dia: comprueba el dia de nacimiento
	ret			;97ff
L_9800:
	call bio_comprueba_ano_2		;9800   ; bio_comprueba_ano_2: comprueba el ano de hoy (0xE012)
	ret c			;9803
	call bio_comprueba_mes_2		;9804   ; bio_comprueba_mes_2: comprueba el mes de hoy
	ret c			;9807
	call bio_comprueba_dia_2		;9808   ; bio_comprueba_dia_2: comprueba el dia de hoy
	ret			;980b
bio_comprueba_ano:		; comprueba el ano de nacimiento (0xE010)
	ld a,000h		;980c
	ld (0e07bh),a		;980e   ; guarda la cifra del campo que esta mal
	ld ix,0e090h		;9811   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
	ld hl,0e010h		;9815   ; apunta a el ano de nacimiento
	call bio_lee_ano		;9818   ; bio_lee_ano: pasa las 4 cifras del ano a binario
	ret			;981b
bio_comprueba_ano_2:		; comprueba el ano de hoy (0xE012)
	ld a,008h		;981c
	ld (0e07bh),a		;981e   ; guarda la cifra del campo que esta mal
	ld ix,0e098h		;9821   ; apunta a las cifras de la fecha de hoy
	ld hl,0e012h		;9825   ; apunta a el ano de hoy
	call bio_lee_ano		;9828   ; bio_lee_ano: pasa las 4 cifras del ano a binario
	ret			;982b
bio_comprueba_mes:		; comprueba el mes de nacimiento
	ld a,004h		;982c
	ld (0e07bh),a		;982e   ; guarda la cifra del campo que esta mal
	ld hl,0e094h		;9831
	ld de,0e014h		;9834   ; apunta a el mes de nacimiento
	call bio_lee_mes		;9837   ; bio_lee_mes: pasa las 2 cifras del mes a binario y lo comprueba (1-12)
	ret			;983a
bio_comprueba_mes_2:		; comprueba el mes de hoy
	ld a,00ch		;983b
	ld (0e07bh),a		;983d   ; guarda la cifra del campo que esta mal
	ld hl,0e09ch		;9840
	ld de,0e015h		;9843   ; apunta a el mes de hoy
	call bio_lee_mes		;9846   ; bio_lee_mes: pasa las 2 cifras del mes a binario y lo comprueba (1-12)
	ret			;9849
bio_comprueba_dia:		; comprueba el dia de nacimiento
	ld a,006h		;984a
	ld (0e07bh),a		;984c   ; guarda la cifra del campo que esta mal
	ld hl,0e096h		;984f
	ld de,0e016h		;9852   ; apunta a el dia de nacimiento
	call bio_lee_dia		;9855   ; bio_lee_dia: pasa las 2 cifras del dia a binario y lo comprueba
	ret			;9858
bio_comprueba_dia_2:		; comprueba el dia de hoy
	ld a,00eh		;9859
	ld (0e07bh),a		;985b   ; guarda la cifra del campo que esta mal
	ld hl,0e09eh		;985e
	ld de,0e017h		;9861   ; apunta a el dia de hoy
	call bio_lee_dia		;9864   ; bio_lee_dia: pasa las 2 cifras del dia a binario y lo comprueba
	ret			;9867
bio_lee_ano:		; pasa las 4 cifras del ano a binario
	push hl			;9868
	call cuatro_cifras		;9869   ; cuatro_cifras: las 4 cifras de IX a binario (x1000, x100, x10)
	pop hl			;986c
	ld de,(0e088h)		;986d   ; lee resultado de 32 bits (parte alta) y el byte siguiente (16 bits)
	ld (hl),e			;9871
	inc hl			;9872
	ld (hl),d			;9873
	dec hl			;9874
	call bio_ano_valido		;9875   ; bio_ano_valido: comprueba el ano (y que hoy no sea antes del nacimiento)
	ret			;9878
bio_lee_mes:		; pasa las 2 cifras del mes a binario y lo comprueba (1-12)
	call dos_cifras		;9879   ; dos_cifras: las 2 cifras de HL a binario (x10)
	ld (de),a			;987c
	ld (0e04eh),a		;987d
	call bio_mes_valido		;9880   ; bio_mes_valido: C si el mes no esta entre 1 y 12
	ret			;9883
bio_lee_dia:		; pasa las 2 cifras del dia a binario y lo comprueba
	call dos_cifras		;9884   ; dos_cifras: las 2 cifras de HL a binario (x10)
	ld (de),a			;9887
	call bio_dia_valido		;9888   ; bio_dia_valido: C si el dia no cabe en el mes (tabla p05:9978, febrero con el bisiesto)
	ret			;988b
bio_ano_valido:		; comprueba el ano (y que hoy no sea antes del nacimiento)
	call bio_es_bisiesto		;988c   ; bio_es_bisiesto: mira si el ano es bisiesto (4, 100 y 400): 0xE041
	xor a			;988f
	ld a,(0e005h)		;9890   ; lee la fecha que se pide (2 = la de hoy)
	cp 002h		;9893
	jr z,L_989A		;9895
	call bio_hoy_despues		;9897   ; bio_hoy_despues: C si el ano de hoy es menor que el de nacimiento
L_989A:
	ret			;989a
bio_hoy_despues:		; C si el ano de hoy es menor que el de nacimiento
	ld de,(0e010h)		;989b   ; lee el ano de nacimiento y el byte siguiente (16 bits)
	ld hl,(0e012h)		;989f   ; lee el ano de hoy y el byte siguiente (16 bits)
	rst 20h			;98a2   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr c,L_98DD		;98a3
	ret			;98a5
bio_mes_valido:		; C si el mes no esta entre 1 y 12
	cp 001h		;98a6   ; el mes 0 no vale
	jr c,L_98AF		;98a8
	ld b,a			;98aa
	ld a,00ch		;98ab   ; ni mas de 12
	cp b			;98ad
	ret nc			;98ae
L_98AF:
	jr L_98E5		;98af
bio_dia_valido:		; C si el dia no cabe en el mes (tabla p05:9978, febrero con el bisiesto)
	cp 001h		;98b1   ; el dia 0 no vale
	jr c,L_98D9		;98b3
	ld b,a			;98b5
	ld hl,09978h		;98b6   ; los dias de cada mes, en la tabla de p05:9978
	ld a,(0e04eh)		;98b9   ; el mes
	cp 002h		;98bc   ; febrero se mira aparte (bisiesto)
	jr z,L_98C8		;98be
	dec a			;98c0
	ld c,a			;98c1
	call hl_mas_a		;98c2   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;98c5   ; los dias del mes...
	cp b			;98c6   ; ...no pueden ser menos que el dia
	ret nc			;98c7
L_98C8:
	ld a,(0e041h)		;98c8   ; lee el ano es bisiesto
	and a			;98cb
	jr z,L_98D5		;98cc
	ld a,01dh		;98ce
	cp b			;98d0
	jr c,L_98D9		;98d1
	xor a			;98d3
	ret			;98d4
L_98D5:
	ld a,01ch		;98d5
	cp b			;98d7
	ret nc			;98d8
L_98D9:
	call bio_cursor_al_error		;98d9   ; bio_cursor_al_error: lleva el cursor al campo que esta mal (0xE07B)
	ret			;98dc
L_98DD:
	ld a,(0e07bh)		;98dd   ; lee la cifra del campo que esta mal
	ld hl,0e07ah		;98e0   ; apunta a la cifra en la que esta el cursor
	ld (hl),a			;98e3
	ret			;98e4
L_98E5:
	ld a,(0e07bh)		;98e5   ; lee la cifra del campo que esta mal
	ld hl,0e07ah		;98e8   ; apunta a la cifra en la que esta el cursor
	ld (hl),a			;98eb
	ret			;98ec
bio_cursor_al_error:		; lleva el cursor al campo que esta mal (0xE07B)
	ld a,(0e07bh)		;98ed   ; lee la cifra del campo que esta mal
	ld hl,0e07ah		;98f0   ; apunta a la cifra en la que esta el cursor
	ld (hl),a			;98f3
	ret			;98f4
L_98F5:
	and a			;98f5   ; cuenta los bits hasta el ultimo a 1
	ret z			;98f6
	inc d			;98f7   ; D = la posicion
	srl a		;98f8
	jr nc,L_98F5		;98fa
	ret			;98fc
L_98FD:
	ret			;98fd
L_98FE:
	ld a,(hl)			;98fe
	call por_10		;98ff   ; por_10: A x 10
	inc hl			;9902
	add a,(hl)			;9903
	ret			;9904
L_9905:
	call bio_borra_estado		;9905   ; bio_borra_estado: pone a cero 0xE006 y 0xE004
	ld hl,0e005h		;9908   ; apunta a la fecha que se pide (2 = la de hoy)
	inc (hl)			;990b
	ret			;990c
L_990D:
	call nada		;990d   ; nada: `ret`
	ld hl,0e006h		;9910
	inc (hl)			;9913
	ret			;9914
L_9915:
	call nada		;9915   ; nada: `ret`
	xor a			;9918
	ret			;9919
L_991A:
	call bio_borra_estado		;991a   ; bio_borra_estado: pone a cero 0xE006 y 0xE004
	ld hl,0e005h		;991d   ; apunta a la fecha que se pide (2 = la de hoy)
	ld a,001h		;9920
	ld (hl),a			;9922
	ret			;9923
bio_borra_estado:		; pone a cero 0xE006 y 0xE004
	xor a			;9924
	ld (0e006h),a		;9925
	ld (0e004h),a		;9928
nada:		; `ret`
	ret			;992b
L_992C:
	ld a,b			;992c
	ld b,000h		;992d
	ld de,0e062h		;992f   ; apunta a la fecha que se ve (cifras)
	call de_mas_a		;9932   ; de_mas_a: DE = DE + A (gemela de p01:7256)
	ld hl,0e084h		;9935
	ldir		;9938
	ret			;993a
cuatro_cifras:		; las 4 cifras de IX a binario (x1000, x100, x10)
	ld a,(ix+000h)		;993b   ; la primera cifra...
	ld b,000h		;993e
	ld c,a			;9940
	ld de,003e8h		;9941   ; ...x 1000
	call multiplica		;9944   ; multiplica: HL = DE x BC
	push hl			;9947
	ld a,(ix+001h)		;9948   ; la segunda...
	ld b,000h		;994b
	ld c,a			;994d
	ld de,00064h		;994e   ; ...x 100
	call multiplica		;9951   ; multiplica: HL = DE x BC
	pop de			;9954
	add hl,de			;9955   ; sumadas
	push hl			;9956
	ld a,(ix+002h)		;9957   ; la tercera...
	ld b,000h		;995a
	ld c,a			;995c
	ld de,0000ah		;995d   ; ...x 10
	call multiplica		;9960   ; multiplica: HL = DE x BC
	pop de			;9963
	add hl,de			;9964   ; sumadas
	ld a,(ix+003h)		;9965   ; mas la cuarta
	call hl_mas_a		;9968   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld (0e088h),hl		;996b   ; el numero a 0xE088
	ret			;996e
dos_cifras:		; las 2 cifras de HL a binario (x10)
	push de			;996f
	ld a,(hl)			;9970
	call por_10		;9971   ; por_10: A x 10
	inc hl			;9974
	add a,(hl)			;9975
	pop de			;9976
	ret			;9977

; ----------------------------------------------------------------------
; DATOS resto_9978: lo apuntan con el banco puesto p05:98B6 (0x9978); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:98B6 (12 bytes)
;   0x9978..0x9984  (12 bytes)
DATA_resto_9978:
	defb 01fh,01dh,01fh,01eh,01fh,01eh,01fh,01fh,01eh,01fh,01eh,01fh	; 9978  ............

; ======================================================================
; CODIGO 0x9984..0x9990  (12 bytes)
; ======================================================================


bio_pide_fecha_msx2:		; lee teclas hasta una buena (MSX2)
	call bio_espera_tecla_msx2		;9984   ; bio_espera_tecla_msx2: anima el cursor y espera una tecla (MSX2)
	call bio_tecla		;9987   ; bio_tecla: B = la orden de la tecla A: RETURN, flechas o cifra
	jr c,bio_pide_fecha_msx2		;998a
	ld a,b			;998c
	call despacha		;998d   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_9990: tabla de 5 palabras del despachador (call 0x408D en
;   0x998D); lo leen el despachador (10 bytes)
;   0x9990..0x999a  (10 bytes)
DATA_saltos_9990:
	defb 01bh,09ah	; 9990
	defb 0eah,099h	; 9992
	defb 0f8h,099h	; 9994
	defb 00ah,09ah	; 9996
	defb 0e5h,099h	; 9998

; ======================================================================
; CODIGO 0x999a..0x9aa3  (265 bytes)
; ======================================================================


bio_espera_tecla_msx2:		; anima el cursor y espera una tecla (MSX2)
	call bio_parpadeo		;999a   ; bio_parpadeo: cada 16 cuadros cambia el parpadeo (0xE00D)
	call bio_cursor_msx2		;999d   ; bio_cursor_msx2: pinta el cursor parpadeando (MSX2, tabla p05:9AA3)
	call 0009ch		;99a0   ; BIOS CHSNS - Tests the status of the keyboard buffer
	jr z,bio_espera_tecla_msx2		;99a3
	call 0009fh		;99a5   ; BIOS CHGET - One character input (waiting)
	ld (0e058h),a		;99a8   ; guarda la tecla pulsada
	ret			;99ab
bio_tecla:		; B = la orden de la tecla A: RETURN, flechas o cifra
	ld b,000h		;99ac   ; B = 0: retroceso (BS)
	cp 008h		;99ae
	jp z,L_99CA		;99b0
	inc b			;99b3
	cp 01ch		;99b4   ; 1: flecha derecha (0x1C)
	jp z,L_99CA		;99b6
	inc b			;99b9
	cp 01dh		;99ba   ; 2: flecha izquierda (0x1D)
	jp z,L_99CA		;99bc
	inc b			;99bf
	cp 00dh		;99c0   ; 3: RETURN
	jp z,L_99CA		;99c2
	inc b			;99c5   ; 4: una cifra
	call es_cifra		;99c6   ; es_cifra: C si A no es una cifra (0x30-0x39)
	ret c			;99c9
L_99CA:
	ld a,b			;99ca
	ret			;99cb
es_cifra:		; C si A no es una cifra (0x30-0x39)
	cp 040h		;99cc
	jr nc,L_99D5		;99ce
	cp 030h		;99d0
	jr c,L_99D5		;99d2
	ret			;99d4
L_99D5:
	scf			;99d5
	ret			;99d6
bio_parpadeo:		; cada 16 cuadros cambia el parpadeo (0xE00D)
	ld hl,0e007h		;99d7
	ld a,(hl)			;99da
	inc a			;99db
	ld (hl),a			;99dc
	and 00fh		;99dd
	ret nz			;99df
	ld hl,0e00dh		;99e0   ; apunta a el parpadeo del cursor
	inc (hl)			;99e3
	ret			;99e4
L_99E5:
	call bio_mete_cifra		;99e5   ; bio_mete_cifra: mete la cifra tecleada en su sitio
	jr L_9A18		;99e8
L_99EA:
	ld a,(0e078h)		;99ea   ; lee la ultima cifra a la que llega el cursor
	ld b,a			;99ed
	ld hl,0e07ah		;99ee   ; apunta a la cifra en la que esta el cursor
	ld a,(hl)			;99f1
	cp b			;99f2
	jr z,L_99F6		;99f3
	inc (hl)			;99f5
L_99F6:
	jr L_9A18		;99f6
L_99F8:
	call bio_primer_campo		;99f8   ; bio_primer_campo: B = la primera cifra: 0 o 8 segun 0xE005
	ld a,b			;99fb
	ld hl,0e07ah		;99fc   ; apunta a la cifra en la que esta el cursor
	ld b,(hl)			;99ff
	cp b			;9a00
	jr z,L_9A08		;9a01
	jr nc,L_9A08		;9a03
	ld a,(hl)			;9a05
	dec a			;9a06
	ld (hl),a			;9a07
L_9A08:
	jr L_9A18		;9a08
L_9A0A:
	call bio_ultimo_campo		;9a0a   ; bio_ultimo_campo: B = la ultima cifra: 8 o 16 segun 0xE005
	ld a,(0e078h)		;9a0d   ; lee la ultima cifra a la que llega el cursor
	cp b			;9a10
	jr z,L_9A16		;9a11
	jp L_9A18		;9a13
L_9A16:
	scf			;9a16
	ret			;9a17
L_9A18:
	scf			;9a18
	ccf			;9a19
	ret			;9a1a
L_9A1B:
	jr L_9A18		;9a1b
bio_mete_cifra:		; mete la cifra tecleada en su sitio
	call bio_estado_5		;9a1d   ; bio_estado_5: compara 0xE005 con 5
	jr nc,L_9A28		;9a20
	ld a,(0e07ah)		;9a22   ; lee la cifra en la que esta el cursor
	cp 008h		;9a25
	ret z			;9a27
L_9A28:
	ld a,(0e07ah)		;9a28   ; lee la cifra en la que esta el cursor
	ld hl,0e090h		;9a2b   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
	call hl_mas_a		;9a2e   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(0e058h)		;9a31   ; lee la tecla pulsada
	sub 030h		;9a34
	ld (hl),a			;9a36
	call bio_cursor_derecha		;9a37   ; bio_cursor_derecha: el cursor una cifra a la derecha
	ret			;9a3a
bio_cursor_derecha:		; el cursor una cifra a la derecha
	ld hl,0e078h		;9a3b   ; apunta a la ultima cifra a la que llega el cursor
	ld b,(hl)			;9a3e
	ld a,(0e07ah)		;9a3f   ; lee la cifra en la que esta el cursor
	cp b			;9a42
	jr c,L_9A4C		;9a43
	call bio_ultimo_campo		;9a45   ; bio_ultimo_campo: B = la ultima cifra: 8 o 16 segun 0xE005
	ld a,(hl)			;9a48
	cp b			;9a49
	ret nc			;9a4a
	inc (hl)			;9a4b
L_9A4C:
	ld hl,0e07ah		;9a4c   ; apunta a la cifra en la que esta el cursor
	inc (hl)			;9a4f
	ret			;9a50
bio_primer_campo:		; B = la primera cifra: 0 o 8 segun 0xE005
	ld b,000h		;9a51
	ld a,(0e005h)		;9a53   ; lee la fecha que se pide (2 = la de hoy)
	cp 002h		;9a56
	jr z,L_9A5C		;9a58
	ld b,008h		;9a5a
L_9A5C:
	ret			;9a5c
bio_ultimo_campo:		; B = la ultima cifra: 8 o 16 segun 0xE005
	ld b,008h		;9a5d
	ld a,(0e005h)		;9a5f   ; lee la fecha que se pide (2 = la de hoy)
	cp 002h		;9a62
	jr z,L_9A68		;9a64
	ld b,010h		;9a66
L_9A68:
	ret			;9a68
bio_estado_5:		; compara 0xE005 con 5
	ld a,(0e005h)		;9a69   ; lee la fecha que se pide (2 = la de hoy)
	cp 005h		;9a6c
	ret			;9a6e
bio_cursor_msx2:		; pinta el cursor parpadeando (MSX2, tabla p05:9AA3)
	call bio_cursor_al_final		;9a6f   ; bio_cursor_al_final: Z si el cursor esta en la ultima cifra
	jr z,L_9AA2		;9a72   ; en la ultima cifra no hay cursor
	ld hl,0e07ah		;9a74   ; la cifra del cursor...
	ld a,(hl)			;9a77
	ld c,a			;9a78
	add a,a			;9a79
	ld hl,09aa3h		;9a7a   ; ...su posicion en la pantalla (tabla de p05:9AA3)
	call hl_mas_a		;9a7d   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld e,(hl)			;9a80
	inc hl			;9a81
	ld d,(hl)			;9a82
	ld a,c			;9a83   ; la cifra que hay alli
	call bio_cifra		;9a84   ; bio_cifra: A = la cifra A de 0xE090
	ld c,a			;9a87   ; C = la cifra
	ld a,(0e00dh)		;9a88   ; el parpadeo...
	bit 6,a		;9a8b   ; ...bit 6: encendido o apagado
	jr nz,L_9A96		;9a8d
	ex de,hl			;9a8f   ; apagado: la casilla de color 0xFF
	ld c,0ffh		;9a90
	call bio_casilla_8x8_c		;9a92   ; bio_casilla_8x8_c: pinta una casilla de 8x8 con el color C
	ret			;9a95
L_9A96:
	and 01fh		;9a96
	ret nz			;9a98
	call bio_borra_casilla		;9a99   ; bio_borra_casilla: borra la casilla de la cifra
	ld a,c			;9a9c
	add a,030h		;9a9d
	call pinta_letra_8x8		;9a9f   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
L_9AA2:
	ret			;9aa2

; ----------------------------------------------------------------------
; DATOS resto_9AA3: lo apuntan con el banco puesto p05:9A7A (0x9AA3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:9A7A (32 bytes)
;   0x9aa3..0x9ac3  (32 bytes)
DATA_resto_9AA3:
	defb 020h,030h,020h,038h,020h,040h,020h,048h,020h,068h,020h,070h,020h,090h,020h,098h	; 9aa3   0 8 @ H h p . .
	defb 038h,040h,038h,048h,038h,050h,038h,058h,038h,078h,038h,080h,038h,0a0h,038h,0a8h	; 9ab3  8@8H8P8X8x8.8.8.

; ======================================================================
; CODIGO 0x9ac3..0x9dc2  (767 bytes)
; ======================================================================


bio_cursor_al_final:		; Z si el cursor esta en la ultima cifra
	call bio_ultimo_campo		;9ac3   ; bio_ultimo_campo: B = la ultima cifra: 8 o 16 segun 0xE005
	ld hl,0e07ah		;9ac6   ; apunta a la cifra en la que esta el cursor
	ld a,(hl)			;9ac9
	cp b			;9aca
	ret			;9acb
bio_pinta_fecha_1:		; pinta la fecha de nacimiento (MSX2)
	xor a			;9acc
	ld de,03020h		;9acd
	call bio_pinta_4_cifras		;9ad0   ; bio_pinta_4_cifras: pinta 4 cifras
	ld de,06820h		;9ad3
	call bio_pinta_2_cifras		;9ad6   ; bio_pinta_2_cifras: pinta 2 cifras
	ld de,09020h		;9ad9
	call bio_pinta_2_cifras_b		;9adc   ; bio_pinta_2_cifras_b: pinta 2 cifras
	ret			;9adf
bio_pinta_fecha_2:		; pinta la fecha de hoy (MSX2)
	ld a,008h		;9ae0
	ld de,04038h		;9ae2
	call bio_pinta_4_cifras		;9ae5   ; bio_pinta_4_cifras: pinta 4 cifras
	ld de,07838h		;9ae8
	call bio_pinta_2_cifras		;9aeb   ; bio_pinta_2_cifras: pinta 2 cifras
	ld de,0a038h		;9aee
	call bio_pinta_2_cifras_b		;9af1   ; bio_pinta_2_cifras_b: pinta 2 cifras
	ret			;9af4
bio_pinta_4_cifras:		; pinta 4 cifras
	ld b,004h		;9af5
	call bio_pinta_cifras		;9af7   ; bio_pinta_cifras: pinta B cifras de 0xE090 con LMMM
	ret			;9afa
bio_pinta_2_cifras:		; pinta 2 cifras
	ld b,002h		;9afb
	call bio_pinta_cifras		;9afd   ; bio_pinta_cifras: pinta B cifras de 0xE090 con LMMM
	ret			;9b00
bio_pinta_2_cifras_b:		; pinta 2 cifras
	ld b,002h		;9b01
	call bio_pinta_cifras		;9b03   ; bio_pinta_cifras: pinta B cifras de 0xE090 con LMMM
	ret			;9b06
bio_pinta_cifras:		; pinta B cifras de 0xE090 con LMMM
	push af			;9b07
	call bio_borra_casilla		;9b08   ; bio_borra_casilla: borra la casilla de la cifra
	call bio_cifra		;9b0b   ; bio_cifra: A = la cifra A de 0xE090
	add a,030h		;9b0e
	call pinta_letra_8x8		;9b10   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	ld a,008h		;9b13
	add a,d			;9b15
	ld d,a			;9b16
	inc hl			;9b17
	pop af			;9b18
	inc a			;9b19
	djnz bio_pinta_cifras		;9b1a
	ret			;9b1c
bio_cifra:		; A = la cifra A de 0xE090
	ld hl,0e090h		;9b1d   ; apunta a el bufer de 0xE090 (las cifras de las fechas, o la letra expandida a 4 bits)
	call hl_mas_a		;9b20   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9b23
	ret			;9b24
bio_borra_casilla:		; borra la casilla de la cifra
	push af			;9b25   ; guarda los registros
	push bc			;9b26
	push hl			;9b27
	push de			;9b28
	ex de,hl			;9b29
	call bio_casilla_8x8		;9b2a   ; borra la casilla de la cifra
	pop de			;9b2d
	pop hl			;9b2e
	pop bc			;9b2f
	pop af			;9b30
	ret			;9b31
bio_casilla_8x8:		; pinta una casilla de 8x8 con el color 0x55
	ld c,055h		;9b32
bio_casilla_8x8_c:		; pinta una casilla de 8x8 con el color C
	ld d,000h		;9b34
	ld a,c			;9b36
	ld bc,00808h		;9b37
	call vdp_hmmv		;9b3a   ; vdp_hmmv: rellena un rectangulo de VRAM (HMMV, comando 0xC0) (gemela de p09:8F41)
	ret			;9b3d
bio_estado_grafica:		; el estado de la grafica: teclas, dia y textos
	call bio_tecla_grafica		;9b3e   ; bio_tecla_grafica: la tecla de la grafica: 0, 0x80 o 0x10
	ret c			;9b41
	call bio_si_tecla_5c		;9b42   ; bio_si_tecla_5c: si la tecla de 0xE281 es 0x5C, recalcula
	call bio_dia_en_cifras		;9b45   ; bio_dia_en_cifras: pasa el dia mostrado (0xE054, con signo) a dos cifras
	call bio_signo_del_dia		;9b48   ; bio_signo_del_dia: el signo del dia mostrado
	call bio_pinta_dia		;9b4b   ; bio_pinta_dia: pinta el dia mostrado (0xE04C) con LMMM
	call bio_pinta_signo		;9b4e   ; bio_pinta_signo: pinta el signo del dia ('<' o ';')
	call 0a3a4h		;9b51   ; bio_niveles_si: si 0xE06A es 0, los niveles de los tres ciclos
	ret			;9b54
bio_tecla_grafica:		; la tecla de la grafica: 0, 0x80 o 0x10
	and a			;9b55   ; ninguna tecla
	jr z,L_9B61		;9b56
	cp 080h		;9b58   ; 0x80: ...
	jr z,L_9B6C		;9b5a
	cp 010h		;9b5c   ; 0x10: ...
	jr z,L_9B9F		;9b5e
	ret			;9b60
L_9B61:
	scf			;9b61
	ret			;9b62
bio_si_tecla_5c:		; si la tecla de 0xE281 es 0x5C, recalcula
	ld a,(0e281h)		;9b63
	cp 05ch		;9b66
	jp z,bio_recalcula		;9b68   ; bio_recalcula: vuelve a los angulos de hoy y recalcula las alturas
	ret			;9b6b
L_9B6C:
	ld a,(0e052h)		;9b6c
	cp 082h		;9b6f
	jr z,L_9B8B		;9b71
	inc a			;9b73
	ld (0e052h),a		;9b74
	call bio_sube_e06a		;9b77   ; bio_sube_e06a: sube 0xE06A con tope 4
	jr nc,L_9B7F		;9b7a
	call bio_dia_sube		;9b7c   ; bio_dia_sube: sube el dia mostrado (0xE054)
L_9B7F:
	call bio_dia_siguiente		;9b7f   ; bio_dia_siguiente: dia siguiente: columna, alturas y angulos
	ld hl,0e281h		;9b82
	ld a,(hl)			;9b85
	inc a			;9b86
	call rellena_cada_4		;9b87   ; rellena_cada_4: pone A en B bytes de HL, de 4 en 4
	ret			;9b8a
L_9B8B:
	scf			;9b8b
	ret			;9b8c
bio_dia_sube:		; sube el dia mostrado (0xE054)
	ld hl,0e054h		;9b8d   ; apunta a el dia que se ve (respecto de hoy)
	ld a,(hl)			;9b90
	inc a			;9b91
	ld (hl),a			;9b92
	ret			;9b93
bio_dia_siguiente:		; dia siguiente: columna, alturas y angulos
	ld hl,0e03fh		;9b94   ; apunta a la columna de la grafica
	inc (hl)			;9b97
	call bio_alturas_mas		;9b98   ; bio_alturas_mas: las alturas de los tres ciclos (desplazamientos 4, 3, 2)
	call bio_dia_mas		;9b9b   ; bio_dia_mas: pasa al dia siguiente: los tres angulos suben
	ret			;9b9e
L_9B9F:
	ld a,(0e052h)		;9b9f
	cp 0c4h		;9ba2
	jr z,L_9B8B		;9ba4
	dec a			;9ba6
	ld (0e052h),a		;9ba7
	call bio_baja_e06a		;9baa   ; bio_baja_e06a: baja 0xE06A con tope 4
	jr nc,L_9BB2		;9bad
	call bio_dia_baja		;9baf   ; bio_dia_baja: baja el dia mostrado (0xE054)
L_9BB2:
	call bio_dia_anterior		;9bb2   ; bio_dia_anterior: dia anterior: columna, alturas y angulos
	ld hl,0e281h		;9bb5
	ld a,(hl)			;9bb8
	dec a			;9bb9
	call rellena_cada_4		;9bba   ; rellena_cada_4: pone A en B bytes de HL, de 4 en 4
	ret			;9bbd
bio_dia_baja:		; baja el dia mostrado (0xE054)
	ld hl,0e054h		;9bbe   ; apunta a el dia que se ve (respecto de hoy)
	ld a,(hl)			;9bc1
	dec a			;9bc2
	ld (hl),a			;9bc3
	ret			;9bc4
bio_dia_anterior:		; dia anterior: columna, alturas y angulos
	ld hl,0e03fh		;9bc5   ; apunta a la columna de la grafica
	dec (hl)			;9bc8
	call bio_alturas_menos		;9bc9   ; bio_alturas_menos: las alturas de los tres ciclos (desplazamientos -4, -3, -2)
	call bio_dia_menos		;9bcc   ; bio_dia_menos: pasa al dia anterior: los tres angulos bajan
	ret			;9bcf
rellena_cada_4:		; pone A en B bytes de HL, de 4 en 4
	ld b,006h		;9bd0
L_9BD2:
	ld (hl),a			;9bd2
	ld de,00004h		;9bd3
	add hl,de			;9bd6
	djnz L_9BD2		;9bd7
	ret			;9bd9
bio_dia_en_cifras:		; pasa el dia mostrado (0xE054, con signo) a dos cifras
	ld hl,0e04ch		;9bda
	ld a,(0e054h)		;9bdd   ; lee el dia que se ve (respecto de hoy)
	bit 7,a		;9be0
	jr z,L_9BE6		;9be2
	neg		;9be4
L_9BE6:
	push hl			;9be6
	ld l,a			;9be7
	ld c,00ah		;9be8
	call divide_8		;9bea   ; divide_8: L / C: cociente en L y resto en H
	ex de,hl			;9bed
	pop hl			;9bee
	ld (hl),d			;9bef
	inc hl			;9bf0
	ld (hl),e			;9bf1
	ret			;9bf2
bio_signo_del_dia:		; el signo del dia mostrado
	ld de,0e048h		;9bf3   ; el dia mostrado en BCD (0xE04C, 0xE04D)
	ld hl,0e04dh		;9bf6
	ld a,(hl)			;9bf9
	and a			;9bfa   ; las decenas
	jr nz,L_9C06		;9bfb
	dec hl			;9bfd
	ld a,(hl)			;9bfe   ; las unidades: 1...
	cp 001h		;9bff
	jr z,L_9C0A		;9c01
	and a			;9c03   ; ...o 0
	jr z,L_9C0A		;9c04
L_9C06:
	call 0a0d3h		;9c06   ; bio_texto_a1a6: pinta el texto de p06:A1A6
	ret			;9c09
L_9C0A:
	call bio_borra_casilla_b		;9c0a   ; bio_borra_casilla_b: borra la casilla de 8x8 de DE
	ret			;9c0d
bio_pinta_dia:		; pinta el dia mostrado (0xE04C) con LMMM
	ld ix,0e04ch		;9c0e
	ld de,0b848h		;9c12
	call bio_borra_casilla_b		;9c15   ; bio_borra_casilla_b: borra la casilla de 8x8 de DE
	ld a,(ix+001h)		;9c18
	add a,030h		;9c1b
	call pinta_letra_8x8		;9c1d   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	ld a,008h		;9c20
	add a,d			;9c22
	ld d,a			;9c23
	call bio_borra_casilla_b		;9c24   ; bio_borra_casilla_b: borra la casilla de 8x8 de DE
	ld a,(ix+000h)		;9c27
	add a,030h		;9c2a
	call pinta_letra_8x8		;9c2c   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	ret			;9c2f
bio_borra_casilla_b:		; borra la casilla de 8x8 de DE
	push de			;9c30
	ex de,hl			;9c31
	ld c,055h		;9c32
	ld d,000h		;9c34
	ld a,c			;9c36
	ld bc,00808h		;9c37
	call vdp_hmmv		;9c3a   ; vdp_hmmv: rellena un rectangulo de VRAM (HMMV, comando 0xC0) (gemela de p09:8F41)
	pop de			;9c3d
	ret			;9c3e
bio_baja_e06a:		; baja 0xE06A con tope 4
	ld hl,0e06ah		;9c3f
	ld c,004h		;9c42
	call baja_con_tope		;9c44   ; baja_con_tope: baja (HL); si llega a -C vuelve a 0
	ret			;9c47
baja_con_tope:		; baja (HL); si llega a -C vuelve a 0
	ld a,(hl)			;9c48   ; baja uno
	dec a			;9c49
	ld b,a			;9c4a
	neg		;9c4b   ; llego a -C?
	cp c			;9c4d
	jr z,L_9C54		;9c4e
	ld a,b			;9c50   ; si no, lo guarda
	ld (hl),a			;9c51
	xor a			;9c52   ; A = 0
	ret			;9c53
L_9C54:
	xor a			;9c54
	ld (hl),a			;9c55
	scf			;9c56
	ret			;9c57
bio_sube_e06a:		; sube 0xE06A con tope 4
	ld hl,0e06ah		;9c58
	ld c,004h		;9c5b
	call sube_con_tope		;9c5d   ; sube_con_tope: sube (HL); si llega a C vuelve a 0
	ret			;9c60
sube_con_tope:		; sube (HL); si llega a C vuelve a 0
	ld a,(hl)			;9c61   ; sube uno
	inc a			;9c62
	cp c			;9c63   ; llego a C?
	jr z,L_9C69		;9c64
	ld (hl),a			;9c66   ; si no, lo guarda
	xor a			;9c67   ; A = 0
	ret			;9c68
L_9C69:
	xor a			;9c69
	ld (hl),a			;9c6a
	scf			;9c6b
	ret			;9c6c
bio_pinta_signo:		; pinta el signo del dia ('<' o ';')
	ld de,0b048h		;9c6d
	call bio_borra_casilla_b		;9c70   ; bio_borra_casilla_b: borra la casilla de 8x8 de DE
	ld a,(0e054h)		;9c73   ; lee el dia que se ve (respecto de hoy)
	cp 020h		;9c76
	jr z,L_9C83		;9c78
	ld b,03ch		;9c7a
	ld a,(0e052h)		;9c7c
	sla a		;9c7f
	jr c,L_9C85		;9c81
L_9C83:
	ld b,03bh		;9c83
L_9C85:
	ld a,b			;9c85
	call pinta_letra_8x8		;9c86   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	ret			;9c89
bio_pinta_fecha:		; pinta el ano, el mes y el dia
	call bio_pinta_ano		;9c8a   ; bio_pinta_ano: pinta las 4 cifras del ano
	call bio_pinta_mes		;9c8d   ; bio_pinta_mes: pinta las 2 cifras del mes
	call bio_pinta_dia_b		;9c90   ; bio_pinta_dia_b: pinta las 2 cifras del dia
	ret			;9c93
bio_pinta_ano:		; pinta las 4 cifras del ano
	xor a			;9c94
	ld de,03820h		;9c95
	ld b,004h		;9c98
	call bio_pinta_cifras_b		;9c9a   ; bio_pinta_cifras_b: pinta B cifras de 0xE062
	ret			;9c9d
bio_pinta_mes:		; pinta las 2 cifras del mes
	ld de,07020h		;9c9e
	ld b,002h		;9ca1
	call bio_pinta_cifras_b		;9ca3   ; bio_pinta_cifras_b: pinta B cifras de 0xE062
	ret			;9ca6
bio_pinta_dia_b:		; pinta las 2 cifras del dia
	ld de,09820h		;9ca7
	ld b,002h		;9caa
	call bio_pinta_cifras_b		;9cac   ; bio_pinta_cifras_b: pinta B cifras de 0xE062
	ret			;9caf
bio_pinta_cifras_b:		; pinta B cifras de 0xE062
	push af			;9cb0
	call bio_cifra_e062		;9cb1   ; bio_cifra_e062: A = la cifra A de 0xE062
	add a,030h		;9cb4
	call pinta_letra_8x8		;9cb6   ; pinta_letra_8x8: copia la letra A de 8x8 de la hoja de letras a DE (LMMM)
	ld a,008h		;9cb9
	add a,d			;9cbb
	ld d,a			;9cbc
	inc hl			;9cbd
	pop af			;9cbe
	inc a			;9cbf
	djnz bio_pinta_cifras_b		;9cc0
	ret			;9cc2
bio_cifra_e062:		; A = la cifra A de 0xE062
	ld hl,0e062h		;9cc3   ; apunta a la fecha que se ve (cifras)
	call hl_mas_a		;9cc6   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9cc9
	ret			;9cca
bio_recalcula:		; vuelve a los angulos de hoy y recalcula las alturas
	call bio_angulos_de_hoy		;9ccb   ; bio_angulos_de_hoy: copia los angulos guardados (0xE033) a 0xE02D
	call bio_adelanta		;9cce   ; bio_adelanta: suma a los tres angulos la tabla de p05:9043
	call bio_columna_inicial		;9cd1   ; bio_columna_inicial: la columna de la grafica a 0x3C
	call bio_alturas		;9cd4   ; bio_alturas: las alturas de los tres ciclos (sin desplazar)
	call bio_angulos_validos		;9cd7   ; bio_angulos_validos: deja los tres angulos entre 0 y 359 y calcula sus alturas
	ret			;9cda
bio_angulos_de_hoy:		; copia los angulos guardados (0xE033) a 0xE02D
	ld hl,0e033h		;9cdb   ; apunta a los tres angulos de hoy (copia)
	ld de,0e02dh		;9cde   ; apunta a el angulo del fisico (23 dias)
	ld bc,00006h		;9ce1
	ldir		;9ce4
	ret			;9ce6
bio_adelanta:		; suma a los tres angulos la tabla de p05:9043
	ld b,003h		;9ce7
	ld ix,0e02dh		;9ce9   ; apunta a el angulo del fisico (23 dias)
	ld iy,09043h		;9ced
L_9CF1:
	ld l,(ix+000h)		;9cf1   ; un angulo
	ld h,(ix+001h)		;9cf4
	ld e,(iy+000h)		;9cf7   ; mas el adelanto de la tabla de IY
	ld d,(iy+001h)		;9cfa
	xor a			;9cfd
	add hl,de			;9cfe
	ld (ix+000h),l		;9cff
	ld (ix+001h),h		;9d02
	ld de,00002h		;9d05   ; el siguiente (2 bytes)
	add ix,de		;9d08
	add iy,de		;9d0a
	djnz L_9CF1		;9d0c   ; los B ciclos
	ret			;9d0e
bio_columna_inicial:		; la columna de la grafica a 0x3C
	ld hl,0003ch		;9d0f
	ld (0e03fh),hl		;9d12   ; guarda la columna de la grafica y el byte siguiente (16 bits)
	ret			;9d15
bio_estado_grafica_msx2:		; el estado de la grafica en MSX2
	call bio_tecla_grafica		;9d16   ; bio_tecla_grafica: la tecla de la grafica: 0, 0x80 o 0x10
	ret c			;9d19
	call bio_si_tecla_5c		;9d1a   ; bio_si_tecla_5c: si la tecla de 0xE281 es 0x5C, recalcula
	call bio_pinta_niveles		;9d1d   ; bio_pinta_niveles: pinta los niveles de los tres ciclos
	ret			;9d20
bio_fecha_a_nombres:		; la fecha a la copia de nombres (ano, mes y dia)
	call bio_ano_a_nombres		;9d21   ; bio_ano_a_nombres: el ano a 0xE34F
	call bio_mes_a_nombres		;9d24   ; bio_mes_a_nombres: el mes a 0xE356
	call bio_dia_a_nombres		;9d27   ; bio_dia_a_nombres: el dia a 0xE35B
	ret			;9d2a
bio_ano_a_nombres:		; el ano a 0xE34F
	xor a			;9d2b
	ld de,0e34fh		;9d2c
	ld b,004h		;9d2f
	call cifras_a_nombres		;9d31   ; cifras_a_nombres: B cifras de 0xE062 a letras (+0x10) en DE
	ret			;9d34
bio_mes_a_nombres:		; el mes a 0xE356
	ld de,0e356h		;9d35
	ld b,002h		;9d38
	call cifras_a_nombres		;9d3a   ; cifras_a_nombres: B cifras de 0xE062 a letras (+0x10) en DE
	ret			;9d3d
bio_dia_a_nombres:		; el dia a 0xE35B
	ld de,0e35bh		;9d3e
	ld b,002h		;9d41
	call cifras_a_nombres		;9d43   ; cifras_a_nombres: B cifras de 0xE062 a letras (+0x10) en DE
	ret			;9d46
cifras_a_nombres:		; B cifras de 0xE062 a letras (+0x10) en DE
	push af			;9d47
	call bio_cifra_e062		;9d48   ; bio_cifra_e062: A = la cifra A de 0xE062
	add a,010h		;9d4b
	ld (de),a			;9d4d
	inc hl			;9d4e
	inc de			;9d4f
	pop af			;9d50
	inc a			;9d51
	djnz cifras_a_nombres		;9d52
	ret			;9d54
bio_pinta_niveles:		; pinta los niveles de los tres ciclos
	call bio_niveles		;9d55   ; bio_niveles: clasifica los tres ciclos (0xE05A, 0xE05C, 0xE05E) (gemela de p06:A3B1)
	call L_9D5C		;9d58
	ret			;9d5b
L_9D5C:
	ld a,(0e075h)		;9d5c
	call bio_texto_nivel		;9d5f   ; bio_texto_nivel: el texto del nivel A (tabla de p05:9DC2)
	ld de,0e36ah		;9d62   ; en (0x30, 0x50)
	call bio_pinta_texto_nivel		;9d65   ; bio_pinta_texto_nivel: pinta el texto del nivel
	ld a,(0e074h)		;9d68
	call bio_texto_nivel		;9d6b   ; bio_texto_nivel: el texto del nivel A (tabla de p05:9DC2)
	ld de,0e38ah		;9d6e   ; en (0x3A, 0x50)
	call bio_pinta_texto_nivel		;9d71   ; bio_pinta_texto_nivel: pinta el texto del nivel
	ld a,(0e073h)		;9d74
	call bio_texto_nivel		;9d77   ; bio_texto_nivel: el texto del nivel A (tabla de p05:9DC2)
	ld de,0e3aah		;9d7a   ; en (0x44, 0x50)
	call bio_pinta_texto_nivel		;9d7d   ; bio_pinta_texto_nivel: pinta el texto del nivel
	ret			;9d80
bio_texto_nivel:		; el texto del nivel A (tabla de p05:9DC2)
	ld hl,09dc2h		;9d81
	call 0a421h		;9d84   ; tabla_palabra: DE = la palabra A de la tabla de HL
	ex de,hl			;9d87
	ret			;9d88
bio_niveles:		; clasifica los tres ciclos (0xE05A, 0xE05C, 0xE05E) (gemela de p06:A3B1)
	ld a,(0e05ah)		;9d89   ; lee la altura del fisico
	ld hl,0e075h		;9d8c
	call bio_nivel		;9d8f   ; bio_nivel: B = el nivel de A (umbrales 0xA0, 0x90, 0x80...)
	ld a,(0e05ch)		;9d92   ; lee la altura de la sensibilidad
	ld hl,0e074h		;9d95
	call bio_nivel		;9d98   ; bio_nivel: B = el nivel de A (umbrales 0xA0, 0x90, 0x80...)
	ld a,(0e05eh)		;9d9b   ; lee la altura del intelecto
	ld hl,0e073h		;9d9e
	call bio_nivel		;9da1   ; bio_nivel: B = el nivel de A (umbrales 0xA0, 0x90, 0x80...)
	ret			;9da4
bio_nivel:		; B = el nivel de A (umbrales 0xA0, 0x90, 0x80...)
	ld b,000h		;9da5   ; B = el nivel: 0 desde 0xA0
	cp 0a0h		;9da7
	jr nc,L_9DC0		;9da9
	inc b			;9dab   ; 1 desde 0x90
	cp 090h		;9dac
	jr nc,L_9DC0		;9dae
	inc b			;9db0   ; 2 desde 0x80
	cp 080h		;9db1
	jr nc,L_9DC0		;9db3
	inc b			;9db5   ; 3 desde 0x70
	cp 070h		;9db6
	jr nc,L_9DC0		;9db8
	inc b			;9dba   ; 4 por debajo
	cp 000h		;9dbb
	jr L_9DC0		;9dbd
L_9DBF:
	ret			;9dbf
L_9DC0:
	ld (hl),b			;9dc0
	ret			;9dc1

; ----------------------------------------------------------------------
; DATOS resto_9DC2: lo apuntan con el banco puesto p05:9D81 (0x9DC2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p05:9D81 (10 bytes)
;   0x9dc2..0x9dcc  (10 bytes)
DATA_resto_9DC2:
	defb 054h,09fh,05ah,09fh,05eh,09fh,066h,09fh,06dh,09fh	; 9dc2  T.Z.^.f.m.

; ======================================================================
; CODIGO 0x9dcc..0x9e3e  (114 bytes)
; ======================================================================


bio_pinta_texto_nivel:		; pinta el texto del nivel
	ex de,hl			;9dcc
	ld c,0ffh		;9dcd
	push de			;9dcf
	push hl			;9dd0
	call pon_4_cada_3		;9dd1   ; pon_4_cada_3: pone 4 en 5 bytes de HL + 3
	pop hl			;9dd4
	pop de			;9dd5
	call pinta_letras_bio		;9dd6   ; pinta_letras_bio: pinta letras hasta 0x80 (0x81 trae otra direccion)
	ret			;9dd9
bio_texto_9e50:		; pinta el texto de p05:9E50
	ld de,09e50h		;9dda
	call pinta_texto_bio		;9ddd   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ret			;9de0
bio_textos_grafica:		; los textos de la grafica y su marco
	ld de,09edch		;9de1
	call pinta_texto_bio		;9de4   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	call bio_lineas_guia		;9de7   ; bio_lineas_guia: pinta las lineas guia de la grafica
	call bio_borra_grafica		;9dea   ; bio_borra_grafica: borra la zona de la grafica (12 filas)
	call bio_sprites_8ce2		;9ded   ; bio_sprites_8ce2: copia los sprites de p05:8CE2 a 0xE280
	ret			;9df0
bio_textos_9f0a:		; pinta los textos de p05:9F0A y p05:9F29
	ld de,09f0ah		;9df1
	call pinta_texto_bio		;9df4   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ld de,09f29h		;9df7
	call pinta_texto_bio		;9dfa   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ret			;9dfd
bio_pinta_marcas:		; pinta las marcas de los tres ciclos (p06:A33D)
	ld ix,0e05ah		;9dfe   ; apunta a la altura del fisico
	ld h,(ix+000h)		;9e02   ; H = la altura del fisico
	ld d,(ix+002h)		;9e05   ; D = la de la sensibilidad
	ld b,(ix+004h)		;9e08   ; B = la del intelecto
	ld l,01bh		;9e0b   ; las letras de cada ciclo: 0x1B, 0x1C y 0x1D
	ld e,01ch		;9e0d
	ld c,01dh		;9e0f
	call 0a33dh		;9e11   ; pinta las marcas en la grafica (p06:A33D)
	ld a,(0e070h)		;9e14   ; el primer valor...
	ld hl,0e441h		;9e17   ; ...al texto de p05:E441
	ld (hl),a			;9e1a
	ld a,(0e071h)		;9e1b   ; el segundo
	ld hl,0e461h		;9e1e
	ld (hl),a			;9e21
	ld a,(0e072h)		;9e22   ; el tercero
	ld hl,0e481h		;9e25
	ld (hl),a			;9e28
	ld de,09ef9h		;9e29   ; y pinta los tres textos de p05:9EF9
	call pinta_texto_bio		;9e2c   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ret			;9e2f
bio_texto_9e3e:		; pinta el texto de p05:9E3E
	ld de,09e3eh		;9e30
	call pinta_texto_bio		;9e33   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ret			;9e36
bio_texto_9e47:		; pinta el texto de p05:9E47
	ld de,09e47h		;9e37
	call pinta_texto_bio		;9e3a   ; pinta_texto_bio: pinta un texto [direccion][letras]; 0x80 acaba, 0x81 otra direccion
	ret			;9e3d

; ----------------------------------------------------------------------
; DATOS resto_9E3E: lo apuntan con el banco puesto p05:9E30 (0x9E3E), p05:9E37
;   (0x9E47), p05:9DDA (0x9E50), p05:9DE1 (0x9EDC), p05:9E29 (0x9EF9),
;   p05:9DF1 (0x9F0A); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p05:9E30, p05:9E37, p05:9DDA, p05:9DE1, p05:9E29,
;   p05:9DF1 (308 bytes)
;   0x9e3e..0x9f72  (308 bytes)
DATA_resto_9E3E:
	defb 0f6h,0e3h,02fh,02bh,01fh,032h,025h,034h,080h,0f6h,0e3h,004h,004h,004h,004h,004h	; 9e3e  ../+.2%4........
	defb 004h,080h,022h,0e3h,0a0h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h	; 9e4e  ..".............
	defb 0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a3h	; 9e5e  ................
	defb 081h,042h,0e3h,0a2h,022h,029h,032h,034h,028h,024h,021h,039h,004h,004h,039h,004h	; 9e6e  .B..")24($!9..9.
	defb 004h,004h,004h,004h,004h,02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,081h	; 9e7e  .....-....$.....
	defb 062h,0e3h,0a2h,081h,07dh,0e3h,0a5h,081h,082h,0e3h,0a2h,081h,09dh,0e3h,0a5h,081h	; 9e8e  b...}...........
	defb 0a2h,0e3h,0a2h,023h,028h,025h,023h,02bh,004h,024h,021h,039h,004h,039h,004h,004h	; 9e9e  ...#(%#+.$!9.9..
	defb 004h,004h,004h,004h,02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,081h,0c2h	; 9eae  ....-....$......
	defb 0e3h,0a1h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h	; 9ebe  ................
	defb 0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a7h,0a4h,080h,002h,0e4h	; 9ece  ................
	defb 01fh,011h,015h,004h,004h,004h,004h,004h,004h,010h,004h,004h,004h,004h,004h,004h	; 9ede  ................
	defb 01eh,011h,015h,004h,004h,004h,004h,01eh,013h,010h,080h,0efh,0e3h,030h,035h,033h	; 9eee  .............053
	defb 028h,004h,033h,030h,021h,023h,025h,004h,02bh,025h,039h,080h,042h,0e3h,0a2h,023h	; 9efe  (.30!#%.+%9.B..#
	defb 028h,025h,023h,02bh,004h,024h,021h,039h,004h,039h,004h,004h,004h,004h,004h,004h	; 9f0e  (%#+.$!9.9......
	defb 02dh,004h,004h,004h,004h,024h,004h,004h,004h,0a5h,080h,065h,0e3h,030h,028h,039h	; 9f1e  -....$.....e.0(9
	defb 01fh,081h,085h,0e3h,033h,025h,02eh,01fh,081h,0a3h,0e3h,004h,004h,029h,02eh,034h	; 9f2e  ....3%.......).4
	defb 01fh,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h,004h	; 9f3e  ................
	defb 004h,004h,004h,004h,004h,080h,037h,02fh,032h,033h,034h,080h,022h,021h,024h,080h	; 9f4e  ......7/234."!$.
	defb 023h,021h,035h,034h,029h,02fh,02eh,080h,02eh,02fh,032h,02dh,021h,02ch,080h,027h	; 9f5e  #!54)/.../2-!,.'
	defb 02fh,02fh,024h,080h	; 9f6e

; ======================================================================
; CODIGO 0x9f72..0x9fff  (141 bytes)
; ======================================================================


pon_4_cada_3:		; pone 4 en 5 bytes de HL + 3
	ld b,005h		;9f72
	ld de,00003h		;9f74
	add hl,de			;9f77
	ld a,004h		;9f78
L_9F7A:
	ld (hl),a			;9f7a
	inc hl			;9f7b
	djnz L_9F7A		;9f7c
	ret			;9f7e
bio_borra_grafica:		; borra la zona de la grafica (12 filas)
	ld b,00ch		;9f7f
	ld hl,00a18h		;9f81
L_9F84:
	push bc			;9f84   ; una fila de la grafica
	ld bc,000d0h		;9f85   ; 0xD0 bytes...
	ld a,0f0h		;9f88   ; ...con el color 0xF0
	push hl			;9f8a
	call 00056h		;9f8b   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;9f8e
	pop bc			;9f8f
	ld de,00100h		;9f90   ; la fila siguiente, 0x100 mas alla
	add hl,de			;9f93
	djnz L_9F84		;9f94   ; las B filas
	ret			;9f96
bio_lineas_guia:		; pinta las lineas guia de la grafica
	ld hl,00a18h		;9f97   ; la linea de arriba de la grafica, a la derecha de 0x0A18...
	ld b,01ah		;9f9a   ; ...0x1A casillas...
	ld a,0ffh		;9f9c   ; ...con el color 0xFF
	call or_en_color		;9f9e   ; or_en_color: OR de A en el color de B casillas (VRAM + 0x2000)
	ld hl,01018h		;9fa1   ; la linea del medio (0x1018), de puntos (0xCC)
	ld b,01ah		;9fa4
	ld a,0cch		;9fa6
	call or_en_color		;9fa8   ; or_en_color: OR de A en el color de B casillas (VRAM + 0x2000)
	ld hl,01618h		;9fab   ; la de abajo (0x1618)
	ld b,01ah		;9fae
	ld a,0ffh		;9fb0
	call or_en_color		;9fb2   ; or_en_color: OR de A en el color de B casillas (VRAM + 0x2000)
	ld hl,00919h		;9fb5   ; la de la izquierda (0x0919)...
	ld b,01ah		;9fb8
	ld a,0ffh		;9fba
	call or_en_color		;9fbc   ; or_en_color: OR de A en el color de B casillas (VRAM + 0x2000)
	ld hl,01619h		;9fbf   ; ...y la de la derecha (0x1619)
	ld b,01ah		;9fc2
	ld a,0ffh		;9fc4
	call or_en_color		;9fc6   ; or_en_color: OR de A en el color de B casillas (VRAM + 0x2000)
	ld hl,00a18h		;9fc9   ; las marcas de la escala: 0xC0 en 0x0A18...
	ld b,00ch		;9fcc
	ld a,0c0h		;9fce
	call or_en_color_8		;9fd0   ; or_en_color_8: OR de A en 8 filas de color de B casillas
	ld hl,00a58h		;9fd3   ; ...0x10 en 0x0A58...
	ld b,00ch		;9fd6
	ld a,010h		;9fd8
	call or_en_color_8		;9fda   ; or_en_color_8: OR de A en 8 filas de color de B casillas
	ld hl,00ae0h		;9fdd   ; ...y 0x03 en 0x0AE0
	ld b,00ch		;9fe0
	ld a,003h		;9fe2
	call or_en_color_8		;9fe4   ; or_en_color_8: OR de A en 8 filas de color de B casillas
	ret			;9fe7
bio_a066:		; llama a p06:A066
	call 0a066h		;9fe8   ; bio_caja_a15e: una caja con sombra, su marco y el texto de p06:A15E
	ret			;9feb
bio_pantalla_msx2:		; los marcos, el eje y la rejilla (p06:A006) y los textos
	call 0a006h		;9fec   ; bio_cuadro: los marcos, el eje y la rejilla de la grafica
	call 0a0dah		;9fef   ; nada_b: `ret`
	call bio_sprites_msx2		;9ff2   ; bio_sprites_msx2: los sprites de p05:8DAA y sus patrones
	ret			;9ff5
bio_actualiza_msx2:		; actualiza la grafica en MSX2 (p06)
	call 0a0f6h		;9ff6   ; bio_caja_a1eb: una caja con sombra, su marco y el texto de p06:A1EB
	call 0a122h		;9ff9   ; bio_borra_zona: borra la zona de la grafica (comando del VDP)
	call 0a034h		;9ffc   ; bio_caja_a19d: una caja con su marco y el texto de p06:A19D

; ----------------------------------------------------------------------
; DATOS partida_9FFF: los 1 primeros bytes de una instruccion de 3 (CD 57 A1)
;   que sigue en el banco 6: el trazador de un solo banco no puede verla
;   entera (tools/bancos.py); lo leen p05:9FFF (1 bytes)
;   0x9fff..0xa000  (1 bytes)
DATA_partida_9FFF:
	defb 0cdh	; 9fff
