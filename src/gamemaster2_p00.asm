; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 00 (se ejecuta en 0x4000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x04000


; ----------------------------------------------------------------------
; DATOS resto_4000: lo apuntan con el banco puesto p00:4A7C (0x4000), p00:4AEB
;   (0x4000), p00:4AF1 (0x4000), p00:573B (0x4000), p00:578D (0x4000),
;   p00:57F9 (0x4000); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:4A7C, p00:4AEB, p00:4AF1, p00:573B, p00:578D,
;   p00:57F9 (32 bytes)
;   0x4000..0x4020  (32 bytes)
DATA_resto_4000:
	defb 041h,042h,083h,055h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 4000  AB.U............
	defb 059h,05ah,000h,000h,000h,000h,000h,000h,0c3h,0e5h,056h,000h,000h,000h,000h,000h	; 4010  YZ........V.....

; ======================================================================
; CODIGO 0x4020..0x4123  (259 bytes)
; ======================================================================


sram:		; pasarela a la SRAM: el cartucho en 0x8000, banco 4 en 0x8000 y la SRAM en 0xA000 (0x10); llama a p04:8000 con IX = DE y devuelve 2-3
	push ix		;4020
	push iy		;4022
	push de			;4024
	push bc			;4025
	call mi_slot		;4026   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld h,080h		;4029
	call 00024h		;402b   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;402e
	ld (08000h),a		;4030   ; el mapper: pone en 0x8000 el banco de A
	ld a,010h		;4033
	ld (0a000h),a		;4035   ; el mapper: pone en 0xA000 el banco de A
	pop bc			;4038
	pop de			;4039
	push de			;403a
	call 08000h		;403b
	push af			;403e
	ld a,002h		;403f
	ld (08000h),a		;4041   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4044
	ld (0a000h),a		;4045   ; el mapper: pone en 0xA000 el banco de A
	pop af			;4048
	pop de			;4049
	pop iy		;404a
	pop ix		;404c
	ret			;404e
p09_8043:		; pasarela: 1-9-10, p09:8043 y vuelve a 2-3
	call bancos_1_9_10		;404f   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 08043h		;4052
	jp bancos_2_3		;4055   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000
p09_801b:		; pasarela: 1-9-10, p09:801B y vuelve a 2-3
	call bancos_1_9_10		;4058   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 0801bh		;405b
	jp bancos_2_3		;405e   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000
p09_80d2:		; pasarela: 1-9-10, p09:80D2 y vuelve a 2-3
	call bancos_1_9_10		;4061   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 080d2h		;4064
	jr bancos_2_3		;4067
p09_8117:		; pasarela: 1-9-10, p09:8117 y vuelve a 2-3
	call bancos_1_9_10		;4069   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 08117h		;406c
	jr bancos_2_3		;406f
p09_8133:		; pasarela: 1-9-10, p09:8133 y vuelve a 2-3
	call bancos_1_9_10		;4071   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 08133h		;4074
	jr bancos_2_3		;4077
p09_8134:		; pasarela: 1-9-10, p09:8134 y vuelve a 2-3
	call bancos_1_9_10		;4079   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 08134h		;407c
	jr bancos_2_3		;407f
p09_82ca:		; pasarela: 1-9-10, p09:82CA y vuelve a 2-3
	call bancos_1_9_10		;4081   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 082cah		;4084
	jr bancos_2_3		;4087
p09_846d:		; pasarela: 1-9-10, p09:846D y vuelve a 2-3 guardando AF
	call bancos_1_9_10		;4089   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 0846dh		;408c
	push af			;408f
	call bancos_2_3		;4090   ; bancos_2_3: pone los bancos 2 y 3 en 0x8000 y 0xA000
	pop af			;4093
	ret			;4094
p09_8191:		; pasarela: 1-9-10, p09:8191 y vuelve a 2-3
	call bancos_1_9_10		;4095   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	call 08191h		;4098
	jr bancos_2_3		;409b
p09_8191_b:		; pasarela: 1-9-10 y p09:8191 (la llaman por CALSLT, p03:A5BE)
	call bancos_1_9_10		;409d   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	ld hl,0483fh		;40a0
	ld de,03180h		;40a3
	ld bc,00158h		;40a6
	call 0005ch		;40a9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	jr bancos_2_3		;40ac
p09_8191_c:		; pasarela de 0x4095 con otro bloque (hl=0x488F, bc=8); nada la apunta
	call bancos_1_9_10		;40ae   ; bancos_1_9_10: pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	ld hl,0488fh		;40b1
	ld bc,00008h		;40b4
	ld a,(0f112h)		;40b7   ; lee hay menu en pantalla
	or a			;40ba
	jr nz,L_40CE		;40bb
	ld a,(0f2e6h)		;40bd   ; lee el menu va en MSX2
	and a			;40c0
	ld de,021d0h		;40c1
	jr z,L_40C9		;40c4
	ld de,02080h		;40c6
L_40C9:
	call 0730dh		;40c9   ; copia_tercios: LDIRVM en los tres tercios de la pantalla
	jr bancos_2_3		;40cc
L_40CE:
	ld de,031d0h		;40ce
	call 0005ch		;40d1   ; BIOS LDIRVM - Block transfers to VRAM from memory
	jr bancos_2_3		;40d4
bancos_1_9_10:		; pone los bancos 1, 9 y 10 en 0x6000, 0x8000 y 0xA000
	ld a,001h		;40d6
	ld (06000h),a		;40d8   ; el mapper: pone en 0x6000 el banco de A
	ld a,009h		;40db
	ld (08000h),a		;40dd   ; el mapper: pone en 0x8000 el banco de A
	inc a			;40e0
	ld (0a000h),a		;40e1   ; el mapper: pone en 0xA000 el banco de A
	ret			;40e4
bancos_2_3:		; pone los bancos 2 y 3 en 0x8000 y 0xA000
	ld a,002h		;40e5
	ld (08000h),a		;40e7   ; el mapper: pone en 0x8000 el banco de A
	inc a			;40ea
	ld (0a000h),a		;40eb   ; el mapper: pone en 0xA000 el banco de A
	ret			;40ee
L_40EF:
	jp L_56E5		;40ef
banco_7:		; pone 7-8, llama a p07:8000 y vuelve a 2-3
	ld a,007h		;40f2
	ld (08000h),a		;40f4   ; el mapper: pone en 0x8000 el banco de A
	inc a			;40f7
	ld (0a000h),a		;40f8   ; el mapper: pone en 0xA000 el banco de A
	call 08000h		;40fb   ; guarda_pantalla: guarda la pantalla del juego antes del menu (segun el modo de 0xF3DF/0xF3E0)
	ld a,002h		;40fe
	ld (08000h),a		;4100   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4103
	ld (0a000h),a		;4104   ; el mapper: pone en 0xA000 el banco de A
	ret			;4107
banco_5:		; pone 5-6, llama a p05:8000, desengancha H.TIMI y vuelve a 2-3
	ld a,005h		;4108
	ld (08000h),a		;410a   ; el mapper: pone en 0x8000 el banco de A
	inc a			;410d
	ld (0a000h),a		;410e   ; el mapper: pone en 0xA000 el banco de A
	call 08000h		;4111   ; guarda_pantalla: guarda la pantalla del juego antes del menu (segun el modo de 0xF3DF/0xF3E0)
	ld a,0c9h		;4114
	ld (0fd9fh),a		;4116   ; guarda el gancho H.TIMI
	ld a,002h		;4119
	ld (08000h),a		;411b   ; el mapper: pone en 0x8000 el banco de A
	inc a			;411e
	ld (0a000h),a		;411f   ; el mapper: pone en 0xA000 el banco de A
	ret			;4122

; ----------------------------------------------------------------------
; DATOS resto_4123: lo apuntan con el banco puesto p01:79B9 (0x4123), p03:A92B
;   (0x4123), p01:79C1 (0x4175), p03:A933 (0x4175); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p01:79B9, p03:A92B,
;   p01:79C1, p03:A933 (90 bytes)
;   0x4123..0x417d  (90 bytes)
DATA_resto_4123:
	defb 024h,038h,02dh,02dh,053h,052h,041h,04dh,000h,044h,049h,053h,04bh,000h,055h,054h	; 4123  $8--SRAM.DISK.UT
	defb 049h,04ch,049h,054h,059h,02dh,02dh,0feh,0c2h,039h,053h,045h,04ch,045h,043h,054h	; 4133  ILITY--..9SELECT
	defb 000h,043h,04fh,04dh,04dh,041h,04eh,044h,0feh,0e4h,039h,044h,049h,052h,045h,043h	; 4143  .COMMAND..9DIREC
	defb 054h,04fh,052h,059h,0feh,004h,03ah,046h,049h,04ch,045h,000h,044h,045h,04ch,045h	; 4153  TORY..:FILE.DELE
	defb 054h,045h,0feh,024h,03ah,046h,04fh,052h,04dh,041h,054h,0feh,044h,03ah,045h,04eh	; 4163  TE.$:FORMAT.D:EN
	defb 044h,0ffh,0e3h,039h,003h,03ah,023h,03ah,043h,03ah	; 4173  D..9.:#:C:

; ======================================================================
; CODIGO 0x417d..0x41e2  (101 bytes)
; ======================================================================


menu_sram:		; el menu de la SRAM: limpia 0xE010, pinta y lee teclas
	call borra_zona_3a80		;417d   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	call borra_zona_38a0		;4180   ; borra_zona_38a0: borra 0x38A0 (0x100 bytes)
	ld hl,0e010h		;4183   ; apunta a la lista de la SRAM
	ld de,0e011h		;4186
	ld bc,00400h		;4189
	xor a			;418c
	ld (hl),a			;418d
	ldir		;418e
	ld (0e001h),a		;4190   ; guarda la fila elegida de la SRAM
	ld hl,041ech		;4193
	call 0738fh		;4196   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,0e010h		;4199   ; apunta a la lista de la SRAM
	ld (0e21dh),hl		;419c
	ld iy,(0dfffh)		;419f
	ld de,0e210h		;41a3
	ld c,005h		;41a6
	ld ix,04020h		;41a8
	call 0001ch		;41ac   ; BIOS CALSLT - Executes inter-slot call
	and a			;41af
	jp nz,L_41D1		;41b0
	ld a,c			;41b3
	and a			;41b4
	jp z,L_41D1		;41b5
	call sram_pinta_lista		;41b8   ; sram_pinta_lista: pinta la lista de la SRAM (0xE010, 64 bytes por fila)
	ld hl,041f8h		;41bb
L_41BE:
	call 0009fh		;41be   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;41c1
	jr z,L_41D8		;41c3
	cp 01fh		;41c5
	jr z,L_41DD		;41c7
	cp 020h		;41c9
	jr nz,L_41BE		;41cb
	call borra_zona_3a80		;41cd   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	ret			;41d0
L_41D1:
	ld hl,041e2h		;41d1
	call 0738fh		;41d4   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ret			;41d7
L_41D8:
	call sram_fila_arriba		;41d8   ; sram_fila_arriba: sube la fila elegida de la lista de la SRAM (0xE001)
	jr L_41BE		;41db
L_41DD:
	call sram_fila_abajo		;41dd   ; sram_fila_abajo: baja la fila elegida de la lista de la SRAM (0xE001)
	jr L_41BE		;41e0

; ----------------------------------------------------------------------
; DATOS resto_41E2: lo apuntan con el banco puesto p00:41D1 (0x41E2), p00:4193
;   (0x41EC), p00:41BB (0x41F8); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p00:41D1, p00:4193, p00:41BB (39 bytes)
;   0x41e2..0x4209  (39 bytes)
DATA_resto_41E2:
	defb 0eah,038h,04eh,04fh,000h,046h,049h,04ch,045h,0ffh,068h,038h,044h,049h,052h,045h	; 41e2  .8NO.FILE.h8DIRE
	defb 043h,054h,04fh,052h,059h,0ffh,084h,03ah,045h,04eh,044h,03ah,050h,055h,053h,048h	; 41f2  CTORY..:END:PUSH
	defb 000h,053h,050h,041h,043h,045h,0ffh	; 4202

; ======================================================================
; CODIGO 0x4209..0x42d3  (202 bytes)
; ======================================================================


menu_borrar:		; pide el nombre de 5 letras a borrar (0xE250) y lo busca
	call borra_zona_39c0		;4209   ; borra_zona_39c0: borra 0x39C0 (0xA0 bytes)
	call borra_zona_3a80		;420c   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	ld hl,042d3h		;420f
	call 0738fh		;4212   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	xor a			;4215
	ld (0e002h),a		;4216   ; guarda cuantas letras lleva el nombre
	ld hl,0e250h		;4219   ; apunta a el nombre de 5 letras
	ld b,005h		;421c
L_421E:
	ld (hl),a			;421e
	inc hl			;421f
	djnz L_421E		;4220
L_4222:
	call 0009fh		;4222   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;4225
	jp z,L_4282		;4227
	cp 01dh		;422a
	jr z,L_424F		;422c
	cp 01ch		;422e
	jr z,L_4222		;4230
	cp 008h		;4232
	jr z,L_424F		;4234
	ld c,a			;4236
	ld hl,0e250h		;4237   ; apunta a el nombre de 5 letras
	ld a,(0e002h)		;423a   ; lee cuantas letras lleva el nombre
	cp 005h		;423d
	jr z,L_4222		;423f
	call 07251h		;4241   ; hl_mas_a: HL = HL + A
	ld (hl),c			;4244
	ld hl,0e002h		;4245   ; apunta a cuantas letras lleva el nombre
	inc (hl)			;4248
	call pinta_nombre		;4249   ; pinta_nombre: pinta en 0x3AB1 las 5 letras de 0xE250 ('-' donde no hay)
	jp L_4222		;424c
L_424F:
	ld hl,0e250h		;424f   ; apunta a el nombre de 5 letras
	ld de,0e002h		;4252   ; apunta a cuantas letras lleva el nombre
	ld a,(de)			;4255
	and a			;4256
	jr z,L_4222		;4257
	call 07251h		;4259   ; hl_mas_a: HL = HL + A
	dec hl			;425c
	ld (hl),000h		;425d
	ex de,hl			;425f
	dec (hl)			;4260
	call pinta_nombre		;4261   ; pinta_nombre: pinta en 0x3AB1 las 5 letras de 0xE250 ('-' donde no hay)
	jp L_4222		;4264
pinta_nombre:		; pinta en 0x3AB1 las 5 letras de 0xE250 ('-' donde no hay)
	ld hl,03ab1h		;4267
	ld de,0e250h		;426a   ; apunta a el nombre de 5 letras
	ld b,005h		;426d
L_426F:
	ld a,(de)			;426f
	cp 000h		;4270
	jr z,L_4278		;4272
	cp 020h		;4274
	jr nz,L_427A		;4276
L_4278:
	ld a,02dh		;4278
L_427A:
	call 07646h		;427a   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;427d
	inc de			;427e
	djnz L_426F		;427f
	ret			;4281
L_4282:
	ld hl,0e250h		;4282   ; apunta a el nombre de 5 letras
	ld a,(hl)			;4285
	cp 000h		;4286
	jp z,L_42B8		;4288
	cp 020h		;428b
	jp z,L_42B8		;428d
	ld de,0e210h		;4290
	ld bc,00005h		;4293
	ldir		;4296
	ld iy,(0dfffh)		;4298
	ld de,0e210h		;429c
	ld c,006h		;429f
	ld ix,04020h		;42a1
	call 0001ch		;42a5   ; BIOS CALSLT - Executes inter-slot call
	and a			;42a8
	jr z,L_42C9		;42a9
	cp 0feh		;42ab
	jr z,L_42BF		;42ad
	cp 0f7h		;42af
	jr z,L_42C4		;42b1
	ld hl,042f4h		;42b3
	jr L_42CC		;42b6
L_42B8:
	call borra_zona_3a80		;42b8   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	call borra_zona_3ac0		;42bb   ; borra_zona_3ac0: borra 0x3AC0 (0x20 bytes) letra a letra
	ret			;42be
L_42BF:
	ld hl,042fdh		;42bf
	jr L_42CC		;42c2
L_42C4:
	ld hl,04313h		;42c4
	jr L_42CC		;42c7
L_42C9:
	ld hl,04324h		;42c9
L_42CC:
	call 0738fh		;42cc   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	call borra_zona_3a80		;42cf   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	ret			;42d2

; ----------------------------------------------------------------------
; DATOS resto_42D3: lo apuntan con el banco puesto p00:420F (0x42D3), p00:42B3
;   (0x42F4), p00:42BF (0x42FD), p00:42C4 (0x4313), p00:42C9 (0x4324); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:420F, p00:42B3, p00:42BF, p00:42C4, p00:42C9 (96 bytes)
;   0x42d3..0x4333  (96 bytes)
DATA_resto_42D3:
	defb 084h,03ah,044h,045h,04ch,045h,054h,045h,000h,046h,049h,04ch,045h,0feh,0a6h,03ah	; 42d3  .:DELETE.FILE..:
	defb 046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,000h,000h,02dh,02dh,02dh,02dh,02dh	; 42e3  FILE.NAME..-----
	defb 0ffh,0c4h,03ah,046h,041h,049h,04ch,045h,044h,0ffh,0c4h,03ah,052h,041h,04dh,000h	; 42f3  ..:FAILED..:RAM.
	defb 044h,049h,053h,04bh,000h,055h,04eh,046h,04fh,052h,04dh,041h,054h,045h,044h,0ffh	; 4303  DISK.UNFORMATED.
	defb 0c4h,03ah,046h,049h,04ch,045h,000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h	; 4313  .:FILE.NOT.FOUND
	defb 0ffh,0c4h,03ah,046h,049h,04ch,045h,000h,044h,045h,04ch,045h,054h,045h,044h,0ffh	; 4323  ..:FILE.DELETED.

; ======================================================================
; CODIGO 0x4333..0x4387  (84 bytes)
; ======================================================================


pregunta_formatear:		; pregunta si se formatea (Y/N) y llama a la SRAM
	call borra_pantalla		;4333   ; borra_pantalla: borra la tabla de nombres (0x3800, 0x300 bytes)
	ld hl,04387h		;4336
	call 0738fh		;4339   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
L_433C:
	call 0009fh		;433c   ; BIOS CHGET - One character input (waiting)
	cp 059h		;433f
	jr z,L_4351		;4341
	cp 079h		;4343
	jr z,L_4351		;4345
	cp 04eh		;4347
	jr z,L_4369		;4349
	cp 06eh		;434b
	jr z,L_4369		;434d
	jr L_433C		;434f
L_4351:
	call sram_ordenes_c_d		;4351   ; sram_ordenes_c_d: SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000)
	jr z,L_435B		;4354
	call sram_ordenes_c_d		;4356   ; sram_ordenes_c_d: SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000)
	jr nz,L_4363		;4359
L_435B:
	ld hl,043b3h		;435b
	call 0738fh		;435e   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jr L_4369		;4361
L_4363:
	ld hl,043c6h		;4363
	call 0738fh		;4366   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
L_4369:
	call borra_zona_38a0		;4369   ; borra_zona_38a0: borra 0x38A0 (0x100 bytes)
	call borra_zona_39c0		;436c   ; borra_zona_39c0: borra 0x39C0 (0xA0 bytes)
	call borra_zona_3a80		;436f   ; borra_zona_3a80: borra 0x3A80 (0x40 bytes)
	ret			;4372
sram_ordenes_c_d:		; SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000)
	ld c,00ch		;4373
	ld ix,04020h		;4375
	ld iy,(0dfffh)		;4379
	call 0001ch		;437d   ; BIOS CALSLT - Executes inter-slot call
	ld c,00dh		;4380
	call 0001ch		;4382   ; BIOS CALSLT - Executes inter-slot call
	and a			;4385
	ret			;4386

; ----------------------------------------------------------------------
; DATOS resto_4387: lo apuntan con el banco puesto p00:4336 (0x4387), p00:435B
;   (0x43B3), p00:4363 (0x43C6); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p00:4336, p00:435B, p00:4363 (79 bytes)
;   0x4387..0x43d6  (79 bytes)
DATA_resto_4387:
	defb 0a8h,038h,046h,04fh,052h,04dh,041h,054h,000h,052h,041h,04dh,000h,044h,049h,053h	; 4387  .8FORMAT.RAM.DIS
	defb 04bh,0feh,028h,039h,04fh,04bh,000h,000h,050h,055h,053h,048h,000h,059h,0feh,068h	; 4397  K.(9OK..PUSH.Y.h
	defb 039h,04eh,04fh,000h,000h,050h,055h,053h,048h,000h,04eh,0ffh,0c8h,03ah,046h,04fh	; 43a7  9NO..PUSH.N..:FO
	defb 052h,04dh,041h,054h,000h,043h,04fh,04dh,050h,04ch,045h,054h,045h,044h,0ffh,0c8h	; 43b7  RMAT.COMPLETED..
	defb 03ah,046h,04fh,052h,041h,04dh,054h,000h,046h,041h,049h,04ch,045h,044h,0ffh	; 43c7  :FORAMT.FAILED.

; ======================================================================
; CODIGO 0x43d6..0x44be  (232 bytes)
; ======================================================================


sram_fila_arriba:		; sube la fila elegida de la lista de la SRAM (0xE001)
	ld hl,0e001h		;43d6   ; apunta a la fila elegida de la SRAM
	ld a,(hl)			;43d9
	and a			;43da
	ret z			;43db
	dec (hl)			;43dc
	ld a,(hl)			;43dd
	call sram_fila_ocupada		;43de   ; sram_fila_ocupada: mira si la fila A de 0xE010 esta ocupada
	jp nc,sram_pinta_lista		;43e1   ; sram_pinta_lista: pinta la lista de la SRAM (0xE010, 64 bytes por fila)
	inc (hl)			;43e4
	ret			;43e5
sram_fila_abajo:		; baja la fila elegida de la lista de la SRAM (0xE001)
	ld hl,0e001h		;43e6   ; apunta a la fila elegida de la SRAM
	ld a,(hl)			;43e9
	cp 003h		;43ea
	ret z			;43ec
	inc (hl)			;43ed
	ld a,(hl)			;43ee
	call sram_fila_ocupada		;43ef   ; sram_fila_ocupada: mira si la fila A de 0xE010 esta ocupada
	jp nc,sram_pinta_lista		;43f2   ; sram_pinta_lista: pinta la lista de la SRAM (0xE010, 64 bytes por fila)
	dec (hl)			;43f5
	ret			;43f6
sram_pinta_lista:		; pinta la lista de la SRAM (0xE010, 64 bytes por fila)
	call borra_zona_38a0		;43f7   ; borra_zona_38a0: borra 0x38A0 (0x100 bytes)
	ld a,(0e001h)		;43fa   ; lee la fila elegida de la SRAM
	cp 004h		;43fd
	jr c,L_4405		;43ff
	xor a			;4401
	ld (0e001h),a		;4402   ; guarda la fila elegida de la SRAM
L_4405:
	ld l,000h		;4405
	ld h,a			;4407
	srl h		;4408
	rr l		;440a
	ld de,0e010h		;440c   ; apunta a la lista de la SRAM
	add hl,de			;440f
	ex de,hl			;4410
	ld hl,038a2h		;4411
	call sram_pinta_filas		;4414   ; sram_pinta_filas: pinta 8 filas de la lista
	ld hl,038b4h		;4417
sram_pinta_filas:		; pinta 8 filas de la lista
	ld b,008h		;441a
L_441C:
	push bc			;441c
	push hl			;441d
	push de			;441e
	call sram_pinta_fila		;441f   ; sram_pinta_fila: pinta una fila: nombre de 5 letras y sus datos
	pop de			;4422
	pop hl			;4423
	ld bc,00020h		;4424
	add hl,bc			;4427
	ld a,008h		;4428
	call 07256h		;442a   ; de_mas_a: DE = DE + A
	pop bc			;442d
	djnz L_441C		;442e
	ret			;4430
sram_pinta_fila:		; pinta una fila: nombre de 5 letras y sus datos
	ld b,005h		;4431
	ld a,(de)			;4433
	and a			;4434
	ret z			;4435
L_4436:
	ld a,(de)			;4436
	call 07646h		;4437   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc de			;443a
	inc hl			;443b
	djnz L_4436		;443c
	inc hl			;443e
	inc hl			;443f
	inc hl			;4440
	inc de			;4441
	push hl			;4442
	ex de,hl			;4443
	ld e,(hl)			;4444
	inc hl			;4445
	ld d,(hl)			;4446
	dec de			;4447
	ld a,d			;4448
	add a,a			;4449
	jr nc,L_444F		;444a
	ld de,00000h		;444c
L_444F:
	ex de,hl			;444f
	add hl,hl			;4450
	ld c,h			;4451
	pop hl			;4452
	inc c			;4453
	ld b,008h		;4454
	xor a			;4456
L_4457:
	rl c		;4457
	adc a,a			;4459
	daa			;445a
	djnz L_4457		;445b
	ld c,a			;445d
	rra			;445e
	rra			;445f
	rra			;4460
	rra			;4461
	and 00fh		;4462
	add a,030h		;4464
	call 07646h		;4466   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;4469
	ld a,c			;446a
	and 00fh		;446b
	add a,030h		;446d
	call 07646h		;446f   ; pon_letra: escribe A en la VRAM HL guardando los registros
	ret			;4472
sram_fila_ocupada:		; mira si la fila A de 0xE010 esta ocupada
	push hl			;4473
	cp 004h		;4474
	jr nc,L_448A		;4476
	ld h,a			;4478
	ld l,000h		;4479
	srl h		;447b
	rr l		;447d
	ld de,0e010h		;447f   ; apunta a la lista de la SRAM
	add hl,de			;4482
	ld a,(hl)			;4483
	and a			;4484
	jr z,L_448A		;4485
	xor a			;4487
	pop hl			;4488
	ret			;4489
L_448A:
	scf			;448a
	pop hl			;448b
	ret			;448c
borra_pantalla:		; borra la tabla de nombres (0x3800, 0x300 bytes)
	ld hl,03800h		;448d
	ld bc,00300h		;4490
	jr L_44B3		;4493
borra_zona_38a0:		; borra 0x38A0 (0x100 bytes)
	ld hl,038a0h		;4495
	ld bc,00100h		;4498
	jr L_44B3		;449b
borra_zona_3a80:		; borra 0x3A80 (0x40 bytes)
	ld hl,03a80h		;449d
	ld bc,00040h		;44a0
	jr L_44B3		;44a3
borra_zona_39c0:		; borra 0x39C0 (0xA0 bytes)
	ld hl,039c0h		;44a5
	ld bc,000a0h		;44a8
	jr L_44B3		;44ab
borra_zona_3ac0:		; borra 0x3AC0 (0x20 bytes) letra a letra
	ld hl,03ac0h		;44ad
	ld bc,00020h		;44b0
L_44B3:
	xor a			;44b3
	call 07646h		;44b4   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;44b7
	dec bc			;44b8
	ld a,b			;44b9
	or c			;44ba
	jr nz,L_44B3		;44bb
	ret			;44bd

; ----------------------------------------------------------------------
; DATOS resto_44BE: lo apuntan con el banco puesto p00:58E1 (0x44BE), p01:7215
;   (0x44BE), p02:8453 (0x44BE), p03:A3BA (0x44BE), p01:7136 (0x45D0),
;   p03:A2E2 (0x45D0); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:58E1, p01:7215, p02:8453, p03:A3BA, p01:7136,
;   p03:A2E2 (1241 bytes)
;   0x44be..0x4997  (1241 bytes)
DATA_resto_44BE:
	defb 050h,058h,0e3h,045h,0a4h,055h,0e3h,045h,0a9h,06ah,0f6h,045h,049h,066h,0f6h,045h	; 44be  PX.E.U.E.j.EIf.E
	defb 0d5h,06ch,009h,046h,061h,066h,0f6h,045h,003h,068h,009h,046h,0c5h,065h,01ch,046h	; 44ce  .l.Faf.E.h.F.e.F
	defb 040h,066h,01ch,046h,017h,05fh,01ch,046h,07eh,05bh,02fh,046h,0e8h,05ch,02fh,046h	; 44de  @f.F._.F~[/F.\/F
	defb 0e9h,05bh,02fh,046h,04ch,06ah,042h,046h,017h,05eh,055h,046h,00fh,05eh,055h,046h	; 44ee  .[/FLjBF.^UF.^UF
	defb 0bch,077h,068h,046h,037h,07ah,068h,046h,094h,078h,068h,046h,05bh,06dh,07bh,046h	; 44fe  .whF7zhF.xhF[m{F
	defb 04bh,077h,08eh,046h,017h,079h,08eh,046h,089h,078h,08eh,046h,06bh,076h,0a1h,046h	; 450e  Kw.F.y.F.x.Fkv.F
	defb 09fh,077h,0a1h,046h,0d5h,077h,0a1h,046h,076h,067h,0b4h,046h,072h,05bh,0c7h,046h	; 451e  .w.F.w.Fvg.Fr[.F
	defb 021h,05eh,0c7h,046h,065h,04ch,0c7h,046h,061h,067h,0dah,046h,014h,066h,0dah,046h	; 452e  !^.FeL.Fag.F.f.F
	defb 0c6h,068h,0dah,046h,0d4h,047h,0edh,046h,0a4h,083h,000h,047h,02ch,06ch,013h,047h	; 453e  .h.F.G.F...G,l.G
	defb 0a2h,072h,026h,047h,01ch,071h,026h,047h,0a3h,071h,026h,047h,0dch,076h,039h,047h	; 454e  .r&G.q&G.q&G.v9G
	defb 095h,046h,04ch,047h,01eh,05eh,05fh,047h,035h,05eh,05fh,047h,0b0h,05eh,05fh,047h	; 455e  .FLG.^_G5^_G.^_G
	defb 076h,068h,072h,047h,0d8h,057h,072h,047h,0edh,057h,072h,047h,085h,06dh,085h,047h	; 456e  vhrG.WrG.WrG.m.G
	defb 0b8h,06ah,085h,047h,062h,05dh,098h,047h,03bh,064h,098h,047h,018h,065h,098h,047h	; 457e  .j.Gb].G.d.G.e.G
	defb 09ch,071h,0abh,047h,048h,06bh,0abh,047h,0adh,068h,0beh,047h,08dh,067h,0beh,047h	; 458e  .q.GHk.G.h.G.g.G
	defb 02eh,068h,0beh,047h,002h,074h,0d1h,047h,004h,065h,0e4h,047h,007h,069h,0e4h,047h	; 459e  .h.G.t.G.e.G.i.G
	defb 022h,06bh,0e4h,047h,0b8h,087h,0f7h,047h,091h,079h,00ah,048h,036h,079h,00ah,048h	; 45ae  "k.G...G.y.H6y.H
	defb 0c1h,079h,00ah,048h,024h,07bh,00ah,048h,0f5h,07ah,00ah,048h,0e4h,085h,019h,048h	; 45be  .y.H${.H.z.H...H
	defb 000h,000h,000h,0ffh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 45ce  ................
	defb 000h,000h,000h,000h,000h,007h,000h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h	; 45de  .............P.Q
	defb 0e0h,040h,0e0h,043h,0e0h,046h,0e0h,009h,007h,001h,000h,000h,000h,0e0h,000h,000h	; 45ee  .@.C.F..........
	defb 000h,000h,0e0h,0e0h,040h,0e0h,043h,0e0h,000h,000h,009h,007h,001h,000h,001h,000h	; 45fe  ....@.C.........
	defb 0e0h,000h,000h,000h,000h,0e0h,0e0h,040h,0e0h,043h,0e0h,000h,000h,009h,007h,002h	; 460e  .......@.C......
	defb 000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,040h,0e0h,043h,0e0h,046h,0e0h	; 461e  ......P.Q.@.C.F.
	defb 009h,007h,003h,000h,000h,002h,0e0h,000h,0e0h,002h,0e0h,000h,000h,011h,0e0h,00bh	; 462e  ................
	defb 0e0h,00eh,0e0h,003h,007h,004h,000h,000h,002h,0e0h,000h,0e0h,002h,0e0h,000h,000h	; 463e  ................
	defb 011h,0e0h,00bh,0e0h,00eh,0e0h,003h,007h,005h,000h,000h,000h,0e0h,002h,0e0h,050h	; 464e  ...............P
	defb 0e0h,000h,000h,040h,0e0h,046h,0e0h,043h,0e0h,009h,007h,006h,000h,000h,000h,0e0h	; 465e  ...@.F.C........
	defb 002h,0e0h,050h,0e0h,000h,000h,040h,0e0h,043h,0e0h,046h,0e0h,009h,007h,007h,000h	; 466e  ..P...@.C.F.....
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 467e  ................
	defb 007h,010h,000h,000h,062h,0e1h,01bh,0e0h,000h,000h,016h,0e0h,080h,0e0h,083h,0e0h	; 468e  ....b...........
	defb 086h,0e0h,096h,007h,011h,000h,000h,062h,0e1h,01bh,0e0h,000h,000h,016h,0e0h,080h	; 469e  .......b........
	defb 0e0h,083h,0e0h,086h,0e0h,09fh,007h,012h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h	; 46ae  ..............P.
	defb 051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h,013h,000h,000h,000h,0e0h,002h	; 46be  Q.C.I.F.........
	defb 0e0h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h,014h,000h,000h	; 46ce  .P.Q.C.I.F......
	defb 000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,046h,0e0h,009h,007h	; 46de  ....P.Q.C.I.F...
	defb 015h,000h,000h,000h,0e0h,002h,0e0h,000h,000h,052h,0e0h,044h,0e0h,04ah,0e0h,047h	; 46ee  .........R.D.J.G
	defb 0e0h,009h,007h,016h,000h,000h,000h,0e0h,002h,0e0h,050h,0e0h,051h,0e0h,046h,0e0h	; 46fe  ..........P.Q.F.
	defb 049h,0e0h,04ch,0e0h,009h,007h,017h,000h,000h,000h,0e0h,000h,000h,000h,000h,080h	; 470e  I.L.............
	defb 0e0h,060h,0e0h,063h,0e0h,000h,000h,004h,007h,018h,000h,000h,000h,0e0h,000h,000h	; 471e  .`.c............
	defb 000h,000h,060h,0e0h,055h,0e0h,058h,0e0h,000h,000h,004h,007h,020h,000h,000h,000h	; 472e  ..`.U.X..... ...
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,007h,021h	; 473e  ...............!
	defb 000h,000h,000h,0e0h,000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h	; 474e  ......P.Q.C.I...
	defb 004h,007h,023h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 475e  ..#.............
	defb 000h,000h,000h,000h,007h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 476e  .....$..........
	defb 000h,000h,000h,000h,000h,000h,000h,007h,025h,000h,000h,000h,0e0h,000h,000h,050h	; 477e  ........%......P
	defb 0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h,004h,007h,027h,000h,000h,000h,0e0h	; 478e  .Q.C.I.....'....
	defb 000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,049h,0e0h,000h,000h,004h,007h,028h,000h	; 479e  ..P.Q.C.I.....(.
	defb 000h,000h,0e0h,001h,0e0h,050h,0e0h,053h,0e0h,047h,0e0h,04dh,0e0h,000h,000h,004h	; 47ae  .....P.S.G.M....
	defb 007h,029h,000h,000h,000h,0e0h,000h,000h,050h,0e0h,051h,0e0h,043h,0e0h,046h,0e0h	; 47be  .)......P.Q.C.F.
	defb 000h,000h,004h,007h,030h,000h,000h,000h,0e0h,002h,0e0h,000h,000h,043h,0e0h,03ch	; 47ce  ....0........C.<
	defb 0e0h,03fh,0e0h,000h,000h,003h,007h,031h,000h,000h,000h,000h,000h,000h,000h,000h	; 47de  .?.....1........
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,007h,033h,000h,000h,000h,0e0h,002h	; 47ee  ..........3.....
	defb 0e0h,000h,000h,06ah,0e0h,060h,0e0h,066h,0e0h,063h,0e0h,004h,007h,044h,0a8h,000h	; 47fe  ...j.`.f.c...D..
	defb 0c0h,004h,011h,0c4h,012h,010h,0c4h,005h,0c4h,002h,0c0h,007h,047h,0b8h,000h,0c1h	; 480e  ............G...
	defb 004h,061h,0c1h,005h,060h,0c1h,002h,0c1h,007h,048h,088h,000h,0c0h,004h,080h,0c2h	; 481e  .a..`....H......
	defb 007h,060h,0c2h,057h,0c2h,05ah,0c2h,002h,0c0h,000h,000h,000h,000h,000h,000h,000h	; 482e  .`.W.Z..........
	defb 000h,000h,01ch,022h,063h,063h,063h,022h,01ch,000h,018h,038h,018h,018h,018h,018h	; 483e  ..."ccc"...8....
	defb 07eh,000h,03eh,063h,003h,00eh,03ch,070h,07fh,000h,03eh,063h,003h,00eh,003h,063h	; 484e  ~.>c..<p..>c...c
	defb 03eh,000h,00eh,01eh,036h,066h,066h,07fh,006h,000h,07fh,060h,07eh,063h,003h,063h	; 485e  >...6ff....`~c.c
	defb 03eh,000h,03eh,063h,060h,07eh,063h,063h,03eh,000h,07fh,063h,006h,00ch,018h,018h	; 486e  >.>c`~cc>..c....
	defb 018h,000h,03eh,063h,063h,03eh,063h,063h,03eh,000h,03eh,063h,063h,03fh,003h,063h	; 487e  ..>cc>cc>.>cc?.c
	defb 03eh,000h,010h,018h,0fch,0feh,0fch,018h,010h,000h,000h,00ch,00ch,000h,000h,00ch	; 488e  >...............
	defb 00ch,000h,000h,000h,000h,000h,000h,00ch,00ch,000h,036h,036h,036h,000h,000h,000h	; 489e  ..........666...
	defb 000h,000h,000h,07eh,000h,000h,07eh,000h,000h,000h,01ch,022h,022h,00ch,008h,000h	; 48ae  ...~..~....""...
	defb 008h,000h,000h,000h,000h,07eh,000h,000h,000h,000h,01ch,036h,063h,063h,07fh,063h	; 48be  .....~.....6cc.c
	defb 063h,000h,07eh,063h,063h,07eh,063h,063h,07eh,000h,03eh,063h,060h,060h,060h,063h	; 48ce  c.~cc~cc~.>c```c
	defb 03eh,000h,07ch,066h,063h,063h,063h,066h,07ch,000h,07fh,060h,060h,07eh,060h,060h	; 48de  >.|fcccf|..``~``
	defb 07fh,000h,07fh,060h,060h,07eh,060h,060h,060h,000h,03eh,063h,060h,067h,063h,063h	; 48ee  ...``~```.>c`gcc
	defb 03fh,000h,063h,063h,063h,07fh,063h,063h,063h,000h,03ch,018h,018h,018h,018h,018h	; 48fe  ?.ccc.ccc.<.....
	defb 03ch,000h,01fh,006h,006h,006h,006h,066h,03ch,000h,063h,066h,06ch,078h,07ch,06eh	; 490e  <......f<.cflx|n
	defb 067h,000h,060h,060h,060h,060h,060h,060h,07fh,000h,063h,077h,07fh,07fh,06bh,063h	; 491e  g.``````..cw..kc
	defb 063h,000h,063h,073h,07bh,07fh,06fh,067h,063h,000h,03eh,063h,063h,063h,063h,063h	; 492e  c.cs{.ogc.>ccccc
	defb 03eh,000h,07eh,063h,063h,063h,07eh,060h,060h,000h,03eh,063h,063h,063h,06fh,066h	; 493e  >.~ccc~``.>cccof
	defb 03dh,000h,07eh,063h,063h,062h,07ch,066h,063h,000h,03eh,063h,060h,03eh,003h,063h	; 494e  =.~ccb|fc.>c`>.c
	defb 03eh,000h,07eh,018h,018h,018h,018h,018h,018h,000h,063h,063h,063h,063h,063h,063h	; 495e  >.~.......cccccc
	defb 03eh,000h,063h,063h,063h,063h,036h,01ch,008h,000h,063h,063h,06bh,06bh,07fh,077h	; 496e  >.cccc6...cckk.w
	defb 022h,000h,063h,076h,03ch,01ch,01eh,037h,063h,000h,066h,066h,07eh,03ch,018h,018h	; 497e  ".cv<..7c.ff~<..
	defb 018h,000h,07fh,007h,00eh,01ch,038h,070h,07fh	; 498e  ......8p.

; ======================================================================
; CODIGO 0x4997..0x4b18  (385 bytes)
; ======================================================================


llama_al_juego:		; llama al juego por CALSLT a 0xD314 con su slot (0xD12E) en la pagina 2
	ld a,(0d12fh)		;4997   ; lee el slot del cartucho del juego (copia)
	ld h,080h		;499a
	call 00024h		;499c   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld ix,(0d314h)		;499f   ; lee la rutina propia del juego (copia) y el byte siguiente (16 bits)
	ld iy,(0d12eh)		;49a3   ; lee el slot del Game Master (copia) y el byte siguiente (16 bits)
	call 0001ch		;49a7   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0d12eh)		;49aa   ; lee el slot del Game Master (copia)
	ld h,080h		;49ad
	call 00024h		;49af   ; BIOS ENASLT - Switches to specified slot and page definitively
	ret			;49b2
L_49B3:
	ld a,(0f2a0h)		;49b3   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;49b6
	call 00024h		;49b8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld sp,0df80h		;49bb
	ld hl,0c000h		;49be
	ld de,0c001h		;49c1
	ld (hl),000h		;49c4
	ld bc,01fffh		;49c6
	ldir		;49c9
	call copia_ficha_del_juego		;49cb   ; copia_ficha_del_juego: copia la ficha del juego (0xF280, 23 bytes) y sus opciones a 0xD300
	ld hl,0f2e1h		;49ce
	ld de,0d4f0h		;49d1
	ld bc,00005h		;49d4
	ldir		;49d7
	ld hl,09b80h		;49d9
	ld de,0c000h		;49dc
	ld bc,01100h		;49df
	ldir		;49e2
	ld hl,09b80h		;49e4
	ld de,0e280h		;49e7
	ld bc,01100h		;49ea
	ldir		;49ed
	call mi_slot		;49ef   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0d12eh),a		;49f2   ; guarda el slot del Game Master (copia)
	ld h,080h		;49f5
	call 00024h		;49f7   ; BIOS ENASLT - Switches to specified slot and page definitively
	call mapper_del_juego_a_cero		;49fa   ; mapper_del_juego_a_cero: pone 0-1-2-3 en 0x4000-0xA000: los registros del mapper del OTRO cartucho
	ld a,0ffh		;49fd
	ld (0d13bh),a		;49ff
	ld (0d13ch),a		;4a02   ; guarda la opcion elegida
	jp 08303h		;4a05
L_4A08:
	ld sp,0df80h		;4a08
	call mi_slot		;4a0b   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0d12eh),a		;4a0e   ; guarda el slot del Game Master (copia)
	ld h,080h		;4a11
	call 00024h		;4a13   ; BIOS ENASLT - Switches to specified slot and page definitively
	call mapper_del_juego_a_cero		;4a16   ; mapper_del_juego_a_cero: pone 0-1-2-3 en 0x4000-0xA000: los registros del mapper del OTRO cartucho
	jp 08306h		;4a19
copia_ficha_del_juego:		; copia la ficha del juego (0xF280, 23 bytes) y sus opciones a 0xD300
	ld hl,0f280h		;4a1c   ; apunta a la ficha del juego
	ld de,0d300h		;4a1f   ; apunta a la ficha del juego (copia)
	ld bc,00017h		;4a22
	ldir		;4a25
	ld hl,0f297h		;4a27
	ld de,0d316h		;4a2a
	ld bc,00007h		;4a2d
	ldir		;4a30
	ld a,(0f298h)		;4a32   ; lee las opciones del MODIFY
	ld (0d317h),a		;4a35   ; guarda las opciones del MODIFY (copia)
	ret			;4a38
L_4A39:
	di			;4a39
	ld hl,0c000h		;4a3a
	ld de,0c001h		;4a3d
	ld (hl),000h		;4a40
	ld bc,01fffh		;4a42
	ldir		;4a45
	ld a,0ffh		;4a47
	ld (0d13bh),a		;4a49
	call mi_slot		;4a4c   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0d12eh),a		;4a4f   ; guarda el slot del Game Master (copia)
	call salta_a_c000		;4a52   ; salta_a_c000: copia p00:4A9A a 0xC000 (0x87 bytes) y salta alli
	jr nc,L_4A5A		;4a55
	jp L_4B21		;4a57
L_4A5A:
	ld sp,0df80h		;4a5a
	ld a,0ffh		;4a5d
	ld (0d13bh),a		;4a5f
	ld hl,0fd9fh		;4a62   ; apunta a el gancho H.TIMI
	ld de,0d4f0h		;4a65
	ld bc,00005h		;4a68
	ldir		;4a6b
	ld a,(0d12eh)		;4a6d   ; lee el slot del Game Master (copia)
	ld h,080h		;4a70
	call 00024h		;4a72   ; BIOS ENASLT - Switches to specified slot and page definitively
	call mapper_del_juego_a_cero		;4a75   ; mapper_del_juego_a_cero: pone 0-1-2-3 en 0x4000-0xA000: los registros del mapper del OTRO cartucho
	jp 08300h		;4a78
mapper_del_juego_a_cero:		; pone 0-1-2-3 en 0x4000-0xA000: los registros del mapper del OTRO cartucho
	xor a			;4a7b
	ld (04000h),a		;4a7c
	inc a			;4a7f
	ld (06000h),a		;4a80   ; el mapper: pone en 0x6000 el banco de A
	inc a			;4a83
	ld (08000h),a		;4a84   ; el mapper: pone en 0x8000 el banco de A
	inc a			;4a87
	ld (0a000h),a		;4a88   ; el mapper: pone en 0xA000 el banco de A
	ret			;4a8b
salta_a_c000:		; copia p00:4A9A a 0xC000 (0x87 bytes) y salta alli
	ld hl,L_4A9A		;4a8c
	ld de,0c000h		;4a8f
	ld bc,00087h		;4a92
	ldir		;4a95
	jp 0c000h		;4a97
L_4A9A:
	ld bc,00400h		;4a9a
	ld hl,0fcc1h		;4a9d   ; apunta a EXPTBL, que slots estan expandidos
L_4AA0:
	push bc			;4aa0
	push hl			;4aa1
	ld a,(hl)			;4aa2
	bit 7,a		;4aa3
	jr nz,L_4AC4		;4aa5
	ld b,c			;4aa7
	call 0c02fh		;4aa8
	jr z,L_4AB1		;4aab
	ld a,c			;4aad
	call 0c04bh		;4aae
L_4AB1:
	pop hl			;4ab1
	pop bc			;4ab2
	jr c,L_4AB9		;4ab3
	inc hl			;4ab5
	inc c			;4ab6
	djnz L_4AA0		;4ab7
L_4AB9:
	push af			;4ab9
	ld a,(0d12eh)		;4aba   ; lee el slot del Game Master (copia)
	ld h,040h		;4abd
	call 00024h		;4abf   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;4ac2
	ret			;4ac3
L_4AC4:
	call 0c034h		;4ac4
	jr L_4AB1		;4ac7
L_4AC9:
	ld a,(0d12eh)		;4ac9   ; lee el slot del Game Master (copia)
	cp b			;4acc
	ret			;4acd
L_4ACE:
	and 080h		;4ace
	or c			;4ad0
	ld b,004h		;4ad1
L_4AD3:
	push bc			;4ad3
	ld b,a			;4ad4
	call 0c02fh		;4ad5
	jr z,L_4ADE		;4ad8
	ld a,b			;4ada
	call 0c04bh		;4adb
L_4ADE:
	pop bc			;4ade
	ret c			;4adf
	add a,004h		;4ae0
	djnz L_4AD3		;4ae2
	ret			;4ae4
L_4AE5:
	push af			;4ae5
	ld h,040h		;4ae6
	call 00024h		;4ae8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,04000h		;4aeb
	ld de,0c07eh		;4aee
	ld bc,04000h		;4af1
L_4AF4:
	ld a,044h		;4af4
	cpir		;4af6
	jr nz,L_4B15		;4af8
	jp po,0c07bh		;4afa
	push bc			;4afd
	push de			;4afe
	push hl			;4aff
	ld b,009h		;4b00
L_4B02:
	ld a,(de)			;4b02
	cp (hl)			;4b03
	jr nz,L_4B0A		;4b04
	inc hl			;4b06
	inc de			;4b07
	djnz L_4B02		;4b08
L_4B0A:
	pop hl			;4b0a
	pop de			;4b0b
	pop bc			;4b0c
	jr nz,L_4AF4		;4b0d
	pop af			;4b0f
	ld (0d33bh),a		;4b10
	scf			;4b13
	ret			;4b14
L_4B15:
	pop af			;4b15
	and a			;4b16
	ret			;4b17

; ----------------------------------------------------------------------
; DATOS resto_4B18: lo apuntan con el banco puesto p00:4AEE (0x4B18); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:4AEE (9 bytes)
;   0x4b18..0x4b21  (9 bytes)
DATA_resto_4B18:
	defb 069h,073h,06bh,020h,042h,041h,053h,049h,043h	; 4b18  isk BASIC

; ======================================================================
; CODIGO 0x4b21..0x4bca  (169 bytes)
; ======================================================================


L_4B21:
	ld a,001h		;4b21
	ld (0f3ebh),a		;4b23   ; guarda el color del borde (BDRCLR)
	call 00062h		;4b26   ; BIOS CHGCLR - Changes the screen colors
	ld a,(0d33bh)		;4b29
	ld c,a			;4b2c
	ld hl,04002h		;4b2d
	call lee_palabra_slot		;4b30   ; lee_palabra_slot: DE = la palabra HL del slot C (RDSLT)
	ld iy,(0d33ah)		;4b33
	push de			;4b37
	pop ix		;4b38
	ld hl,L_4B56		;4b3a
	ld de,0c800h		;4b3d
	ld bc,0000bh		;4b40
	ldir		;4b43
	ld hl,L_4B61		;4b45
	ld de,0fedah		;4b48
	ld bc,00003h		;4b4b
	ldir		;4b4e
	call 0001ch		;4b50   ; BIOS CALSLT - Executes inter-slot call
	jp 0fecbh		;4b53
L_4B56:
	ld a,(0d12eh)		;4b56   ; lee el slot del Game Master (copia)
	ld h,040h		;4b59
	call 00024h		;4b5b   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp L_4A5A		;4b5e
L_4B61:
	jp 0c800h		;4b61
disco_guarda_partida:		; graba en disco: abre, crea, escribe y cierra
	ld (0984ah),sp		;4b64   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4b68   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_crea		;4b6b   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;4b6e   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_vram		;4b71   ; disco_graba_vram: graba en disco la VRAM y los registros del VDP
	call bdos_cierra		;4b74   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco		;4b77   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_guarda_ram:		; graba en disco la RAM del juego (0x8000...)
	ld (0984ah),sp		;4b7a   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4b7e   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_crea		;4b81   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;4b84   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_ac80		;4b87   ; disco_graba_ac80: graba 0x67 registros de 0x80 bytes desde 0xAC80
	call disco_graba_vram		;4b8a   ; disco_graba_vram: graba en disco la VRAM y los registros del VDP
	ld hl,00000h		;4b8d
	add hl,sp			;4b90
	ld (08000h),hl		;4b91
	ld hl,00002h		;4b94
	call bdos_graba		;4b97   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	call bdos_cierra		;4b9a   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco		;4b9d   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_guarda_vrm:		; graba un fichero .VRM (la VRAM)
	ld (0984ah),sp		;4ba0   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4ba4   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	ld hl,09823h		;4ba7   ; apunta a el FCB
	ld (09848h),hl		;4baa   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	call borra_fcb		;4bad   ; borra_fcb: pone a cero el FCB de 0x982F
	ld de,0982ch		;4bb0
	ld hl,04bcah		;4bb3
	ld bc,00003h		;4bb6
	ldir		;4bb9
	call bdos_crea		;4bbb   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;4bbe   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_pantalla		;4bc1   ; disco_graba_pantalla: graba la pantalla segun el modo (0xF3DF, 0xF3E0)
	call bdos_cierra		;4bc4   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco		;4bc7   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)

; ----------------------------------------------------------------------
; DATOS resto_4BCA: lo apuntan con el banco puesto p00:4BB3 (0x4BCA); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:4BB3 (3 bytes)
;   0x4bca..0x4bcd  (3 bytes)
DATA_resto_4BCA:
	defb 056h,052h,04dh	; 4bca

; ======================================================================
; CODIGO 0x4bcd..0x5095  (1224 bytes)
; ======================================================================


disco_guarda_ranking:		; graba en disco el ranking (p01:69AD)
	ld (0984ah),sp		;4bcd   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4bd1   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_crea		;4bd4   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;4bd7   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call 069adh		;4bda   ; ranking_entra: mete la puntuacion en el ranking
	call disco_graba_9239		;4bdd   ; disco_graba_9239: graba 0x95 registros desde 0x9239
	call bdos_cierra		;4be0   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco		;4be3   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_guarda_bloque:		; graba en disco el bloque de 0xDF0C
	ld (0984ah),sp		;4be6   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4bea   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_crea		;4bed   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;4bf0   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_df0c		;4bf3   ; disco_graba_df0c: graba 3 registros desde 0xDF0C - 0x1380
	call bdos_cierra		;4bf6   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco		;4bf9   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_carga_partida:		; carga del disco una partida
	ld (0984ah),sp		;4bfc   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4c00   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_abre		;4c03   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;4c06   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	ld hl,03380h		;4c09
	call fcb_registro		;4c0c   ; fcb_registro: pone HL como registro aleatorio del FCB
	call disco_lee_vram		;4c0f   ; disco_lee_vram: lee del disco la VRAM y los registros del VDP
	ld hl,00002h		;4c12
	call bdos_lee		;4c15   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld hl,(08000h)		;4c18
	ld (0984ch),hl		;4c1b
	ld sp,09b80h		;4c1e
	ld hl,00000h		;4c21
	call fcb_registro		;4c24   ; fcb_registro: pone HL como registro aleatorio del FCB
	call disco_lee_ac80		;4c27   ; disco_lee_ac80: lee 0x67 registros a 0xAC80
	ld sp,(0984ch)		;4c2a
	call 06534h		;4c2e   ; silencia_psg: pone a cero los tres volumenes del PSG (y el SCC del juego si lo tiene)
	call 0656ch		;4c31   ; guarda_volumenes: guarda los tres volumenes del PSG en 0xF100
	jp sale_del_disco		;4c34   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_carga_vram:		; carga del disco la VRAM
	ld (0984ah),sp		;4c37   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4c3b   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_abre		;4c3e   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;4c41   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_vram		;4c44   ; disco_lee_vram: lee del disco la VRAM y los registros del VDP
	jp z,sale_del_disco		;4c47   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	call sale_del_disco		;4c4a   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	scf			;4c4d
	ret			;4c4e
disco_carga_ranking:		; carga del disco el ranking
	ld (0984ah),sp		;4c4f   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4c53   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_abre		;4c56   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;4c59   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_9239		;4c5c   ; disco_lee_9239: lee 0x95 registros a 0x9239
	call 0690bh		;4c5f   ; ranking_quita_1_y_2: quita las marcas 1 y 2 del ranking
	jp sale_del_disco		;4c62   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_carga_bloque:		; carga del disco el bloque de 0xDF0C
	ld (0984ah),sp		;4c65   ; guarda la pila guardada al ir al disco
	call entra_al_disco		;4c69   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	call bdos_abre		;4c6c   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;4c6f   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_df0c		;4c72   ; disco_lee_df0c: lee 3 registros a 0xDF0C - 0x1380
	jp sale_del_disco		;4c75   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
disco_graba_ac80:		; graba 0x67 registros de 0x80 bytes desde 0xAC80
	ld hl,0ac80h		;4c78
	ld b,067h		;4c7b
L_4C7D:
	push hl			;4c7d
	push bc			;4c7e
	ld bc,00080h		;4c7f
	call disco_graba_registro		;4c82   ; disco_graba_registro: copia 0x80 bytes a 0x8000 y los graba (BDOS 0x26)
	pop bc			;4c85
	pop hl			;4c86
	ld de,00080h		;4c87
	add hl,de			;4c8a
	djnz L_4C7D		;4c8b
	ret			;4c8d
disco_graba_registro:		; copia 0x80 bytes a 0x8000 y los graba (BDOS 0x26)
	push bc			;4c8e
	ld de,08000h		;4c8f
	ldir		;4c92
	ld de,08000h		;4c94
	ld c,01ah		;4c97
	call 0f37dh		;4c99
	pop hl			;4c9c
	call bdos_graba		;4c9d   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	ret			;4ca0
disco_graba_9239:		; graba 0x95 registros desde 0x9239
	ld de,09239h		;4ca1
	ld c,01ah		;4ca4
	call 0f37dh		;4ca6
	ld hl,00095h		;4ca9
	jp bdos_graba		;4cac   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
disco_graba_df0c:		; graba 3 registros desde 0xDF0C - 0x1380
	ld hl,(0df0ch)		;4caf
	ld bc,01380h		;4cb2
	and a			;4cb5
	sbc hl,bc		;4cb6
	ex de,hl			;4cb8
	ld c,01ah		;4cb9
	call 0f37dh		;4cbb
	ld hl,00003h		;4cbe
	jp bdos_graba		;4cc1   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
disco_lee_ac80:		; lee 0x67 registros a 0xAC80
	ld de,0ac80h		;4cc4
	ld b,067h		;4cc7
L_4CC9:
	push bc			;4cc9
	push de			;4cca
	ld c,01ah		;4ccb
	call 0f37dh		;4ccd
	ld hl,00080h		;4cd0
	call bdos_lee		;4cd3   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	pop de			;4cd6
	ld hl,00080h		;4cd7
	add hl,de			;4cda
	ex de,hl			;4cdb
	pop bc			;4cdc
	djnz L_4CC9		;4cdd
	ret			;4cdf
disco_lee_9239:		; lee 0x95 registros a 0x9239
	ld de,09239h		;4ce0
	ld c,01ah		;4ce3
	call 0f37dh		;4ce5
	ld hl,00095h		;4ce8
	jp bdos_lee		;4ceb   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_lee_df0c:		; lee 3 registros a 0xDF0C - 0x1380
	ld hl,(0df0ch)		;4cee
	ld bc,01380h		;4cf1
	and a			;4cf4
	sbc hl,bc		;4cf5
	ex de,hl			;4cf7
	ld c,01ah		;4cf8
	call 0f37dh		;4cfa
	ld hl,00003h		;4cfd
	jp bdos_lee		;4d00   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_graba_8000:		; graba 0x1000 registros desde 0x8000; nada la apunta
	ld de,08000h		;4d03
	ld c,01ah		;4d06
	call 0f37dh		;4d08
	ld hl,01000h		;4d0b
	jp bdos_graba		;4d0e   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
L_4D11:
	ld de,08000h		;4d11
	ld c,01ah		;4d14
	call 0f37dh		;4d16
	ld hl,01000h		;4d19
	jp bdos_lee		;4d1c   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_lee_vram:		; lee del disco la VRAM y los registros del VDP
	call disco_lee_cabecera_vram		;4d1f   ; disco_lee_cabecera_vram: lee el primer registro: modo y registros del VDP (MSX2)
	ret nz			;4d22
	ld a,(0dda3h)		;4d23
	and a			;4d26
	ld c,000h		;4d27
	jr nz,L_4D2D		;4d29
	ld c,040h		;4d2b
L_4D2D:
	ld hl,0faf6h		;4d2d   ; apunta a ACPAGE, la pagina activa
	ld a,(hl)			;4d30
	push af			;4d31
	ld (hl),000h		;4d32
	call disco_lee_a_vram		;4d34   ; disco_lee_a_vram: lee registros del disco y los pasa a la VRAM
	ld a,(0dda3h)		;4d37
	cp 002h		;4d3a
	jr nz,L_4D52		;4d3c
	ld a,(0fcafh)		;4d3e   ; lee SCRMOD, el modo de pantalla
	sub 005h		;4d41
	and 002h		;4d43
	ld a,001h		;4d45
	jr nz,L_4D4A		;4d47
	inc a			;4d49
L_4D4A:
	ld (0faf6h),a		;4d4a   ; guarda ACPAGE, la pagina activa
	ld c,000h		;4d4d
	call disco_lee_a_vram		;4d4f   ; disco_lee_a_vram: lee registros del disco y los pasa a la VRAM
L_4D52:
	pop af			;4d52
	ld (0faf6h),a		;4d53   ; guarda ACPAGE, la pagina activa
	xor a			;4d56
	ret			;4d57
disco_lee_a_vram:		; lee registros del disco y los pasa a la VRAM
	ld de,00000h		;4d58
L_4D5B:
	push bc			;4d5b
	push de			;4d5c
	call disco_lee_palabra		;4d5d   ; disco_lee_palabra: lee una palabra del fichero en HL
	push hl			;4d60
	ld de,08000h		;4d61
	ld c,01ah		;4d64
	call 0f37dh		;4d66
	pop hl			;4d69
	call bdos_lee		;4d6a   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	pop de			;4d6d
	ld hl,08000h		;4d6e
	push de			;4d71
	call 0733ah		;4d72   ; descomprime: descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias
	pop de			;4d75
	ld hl,00080h		;4d76
	add hl,de			;4d79
	ex de,hl			;4d7a
	pop bc			;4d7b
	ld h,c			;4d7c
	ld l,000h		;4d7d
	rst 20h			;4d7f   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nz,L_4D5B		;4d80
	ret			;4d82
disco_lee_cabecera_vram:		; lee el primer registro: modo y registros del VDP (MSX2)
	ld de,08000h		;4d83
	ld c,01ah		;4d86
	call 0f37dh		;4d88
	ld hl,00001h		;4d8b
	call bdos_lee		;4d8e   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld a,(08000h)		;4d91
	ld (0dda3h),a		;4d94
	and a			;4d97
	jr z,L_4DDC		;4d98
	ld a,(0002dh)		;4d9a   ; la version del MSX (0 = MSX1)
	and a			;4d9d
	jr z,L_4DD9		;4d9e
	ld de,08000h		;4da0
	ld c,01ah		;4da3
	call 0f37dh		;4da5
	ld hl,0003ah		;4da8
	call bdos_lee		;4dab   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld hl,08000h		;4dae
	ld e,018h		;4db1
	ld c,000h		;4db3
	call pon_registros_vdp		;4db5   ; pon_registros_vdp: escribe E registros del VDP desde HL, empezando por C
	ld de,(08018h)		;4db8
	ld hl,0801ah		;4dbc
	ld bc,00020h		;4dbf
	call 0005ch		;4dc2   ; BIOS LDIRVM - Block transfers to VRAM from memory
	xor a			;4dc5
	ld b,010h		;4dc6
	ld hl,0801ah		;4dc8
L_4DCB:
	ld d,(hl)			;4dcb
	inc hl			;4dcc
	ld e,(hl)			;4dcd
	inc hl			;4dce
	push af			;4dcf
	call 0725bh		;4dd0   ; pon_color: MSX2: el color B de la paleta con D y E (R#16 y puerto 2)
	pop af			;4dd3
	inc a			;4dd4
	djnz L_4DCB		;4dd5
	xor a			;4dd7
	ret			;4dd8
L_4DD9:
	or 0ffh		;4dd9
	ret			;4ddb
L_4DDC:
	ld de,08000h		;4ddc
	ld c,01ah		;4ddf
	call 0f37dh		;4de1
	ld hl,00008h		;4de4
	call bdos_lee		;4de7   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld hl,08000h		;4dea
	ld e,008h		;4ded
	ld c,000h		;4def
	call pon_registros_vdp		;4df1   ; pon_registros_vdp: escribe E registros del VDP desde HL, empezando por C
	ld a,(0002dh)		;4df4   ; la version del MSX (0 = MSX1)
	and a			;4df7
	ret z			;4df8
	call 07275h		;4df9   ; paleta_msx2: MSX2: los 16 colores de p01:728E
	xor a			;4dfc
	ret			;4dfd
pon_registros_vdp:		; escribe E registros del VDP desde HL, empezando por C
	push bc			;4dfe
	ld b,(hl)			;4dff
	inc hl			;4e00
	call 00047h		;4e01   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;4e04
	inc c			;4e05
	dec e			;4e06
	jr nz,pon_registros_vdp		;4e07
	ret			;4e09
disco_graba_vram:		; graba en disco la VRAM y los registros del VDP
	call disco_cabecera_vram		;4e0a   ; disco_cabecera_vram: prepara el primer registro: modo y registros del VDP
	ld a,(0dd9dh)		;4e0d
	and a			;4e10
	ld c,000h		;4e11
	jr nz,L_4E17		;4e13
	ld c,040h		;4e15
L_4E17:
	ld hl,0faf6h		;4e17   ; apunta a ACPAGE, la pagina activa
	ld a,(hl)			;4e1a
	push af			;4e1b
	ld (hl),000h		;4e1c
	call disco_graba_de_vram		;4e1e   ; disco_graba_de_vram: lee de la VRAM y lo graba en disco
	ld a,(0dd9dh)		;4e21
	cp 002h		;4e24
	jr nz,L_4E3C		;4e26
	ld a,(0fcafh)		;4e28   ; lee SCRMOD, el modo de pantalla
	sub 005h		;4e2b
	and 002h		;4e2d
	ld a,001h		;4e2f
	jr nz,L_4E34		;4e31
	inc a			;4e33
L_4E34:
	ld (0faf6h),a		;4e34   ; guarda ACPAGE, la pagina activa
	ld c,000h		;4e37
	call disco_graba_de_vram		;4e39   ; disco_graba_de_vram: lee de la VRAM y lo graba en disco
L_4E3C:
	pop af			;4e3c
	ld (0faf6h),a		;4e3d   ; guarda ACPAGE, la pagina activa
	ret			;4e40
disco_graba_de_vram:		; lee de la VRAM y lo graba en disco
	ld hl,00000h		;4e41
L_4E44:
	push bc			;4e44
	push hl			;4e45
	ld de,08802h		;4e46
	ld bc,00080h		;4e49
	call 00059h		;4e4c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call 07707h		;4e4f   ; comprime: comprime 0x8802 en 0x8002 (lo contrario de p01:733A)
	ld de,08000h		;4e52
	ld c,01ah		;4e55
	call 0f37dh		;4e57
	ld hl,(08000h)		;4e5a
	inc hl			;4e5d
	inc hl			;4e5e
	call bdos_graba		;4e5f   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	pop hl			;4e62
	pop bc			;4e63
	ld de,00080h		;4e64
	add hl,de			;4e67
	ld d,c			;4e68
	ld e,000h		;4e69
	rst 20h			;4e6b   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nz,L_4E44		;4e6c
	ret			;4e6e
disco_cabecera_vram:		; prepara el primer registro: modo y registros del VDP
	ld a,(0002dh)		;4e6f   ; la version del MSX (0 = MSX1)
	and a			;4e72
	jr z,L_4EBC		;4e73
	ld a,(0dd9ch)		;4e75
	and a			;4e78
	jr z,L_4EBC		;4e79
	ld a,(0dd9dh)		;4e7b
	ld de,08000h		;4e7e
	ld (de),a			;4e81
	inc de			;4e82
	ld hl,0f3dfh		;4e83   ; apunta a los registros del VDP (copia de la BIOS)
	ld bc,00008h		;4e86
	ldir		;4e89
	ld hl,0ffe7h		;4e8b   ; apunta a el registro 8 del VDP (copia de la BIOS)
	ld bc,00010h		;4e8e
	ldir		;4e91
	ld hl,(0dd98h)		;4e93
	ex de,hl			;4e96
	ld (hl),e			;4e97
	inc hl			;4e98
	ld (hl),d			;4e99
	inc hl			;4e9a
	ex de,hl			;4e9b
	ld bc,00020h		;4e9c
	push de			;4e9f
	ld de,0f680h		;4ea0
	rst 20h			;4ea3   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop de			;4ea4
	jr z,L_4EAB		;4ea5
	ldir		;4ea7
	jr L_4EAE		;4ea9
L_4EAB:
	call 00059h		;4eab   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_4EAE:
	ld de,08000h		;4eae
	ld c,01ah		;4eb1
	call 0f37dh		;4eb3
	ld hl,0003bh		;4eb6
	jp bdos_graba		;4eb9   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
L_4EBC:
	ld de,08000h		;4ebc
	ld c,01ah		;4ebf
	call 0f37dh		;4ec1
	xor a			;4ec4
	ld de,08000h		;4ec5
	ld (de),a			;4ec8
	inc de			;4ec9
	ld hl,0f3dfh		;4eca   ; apunta a los registros del VDP (copia de la BIOS)
	ld bc,00009h		;4ecd
	ldir		;4ed0
	ld hl,00009h		;4ed2
	jp bdos_graba		;4ed5   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
disco_graba_pantalla:		; graba la pantalla segun el modo (0xF3DF, 0xF3E0)
	ld a,(0f3dfh)		;4ed8   ; lee los registros del VDP (copia de la BIOS)
	and 00eh		;4edb
	ld l,a			;4edd
	ld a,(0f3e0h)		;4ede   ; lee el registro 1 del VDP (copia de la BIOS)
	and 018h		;4ee1
	ld h,a			;4ee3
	ld de,00002h		;4ee4
	rst 20h			;4ee7   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,disco_graba_bload		;4ee8
	ld a,0feh		;4eea
	call disco_graba_byte		;4eec   ; disco_graba_byte: graba el byte A en el fichero (por la pila)
	ld hl,00000h		;4eef
	call disco_graba_palabra		;4ef2   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,08000h		;4ef5
	call disco_graba_palabra		;4ef8   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,00000h		;4efb
	call disco_graba_palabra		;4efe   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,00000h		;4f01
	ld b,074h		;4f04
L_4F06:
	push bc			;4f06
	call disco_graba_100_de_vram		;4f07   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f0a
	djnz L_4F06		;4f0b
	ld hl,0f400h		;4f0d
	ld bc,00005h		;4f10
L_4F13:
	push bc			;4f13
	ld bc,00080h		;4f14
	call disco_graba_bc_de_vram		;4f17   ; disco_graba_bc_de_vram: lee BC bytes de la VRAM y los graba
	pop bc			;4f1a
	djnz L_4F13		;4f1b
	ld hl,0f680h		;4f1d
	ld bc,00020h		;4f20
	call disco_graba_bc_de_vram		;4f23   ; disco_graba_bc_de_vram: lee BC bytes de la VRAM y los graba
	ld hl,036a0h		;4f26
	ld bc,00160h		;4f29
	call disco_graba_bc_de_vram		;4f2c   ; disco_graba_bc_de_vram: lee BC bytes de la VRAM y los graba
	ld hl,0f800h		;4f2f
	ld b,008h		;4f32
L_4F34:
	push bc			;4f34
	call disco_graba_100_de_vram		;4f35   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f38
	djnz L_4F34		;4f39
	ret			;4f3b
disco_graba_bload:		; graba la cabecera de BLOAD (0xFE, inicio, fin y ejecucion) (gemela de p02:9336)
	ld a,0feh		;4f3c
	call disco_graba_byte		;4f3e   ; disco_graba_byte: graba el byte A en el fichero (por la pila)
	ld hl,00000h		;4f41
	call disco_graba_palabra		;4f44   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,03fffh		;4f47
	call disco_graba_palabra		;4f4a   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,00000h		;4f4d
	call disco_graba_palabra		;4f50   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,02000h		;4f53
	ld b,018h		;4f56
L_4F58:
	push bc			;4f58
	call disco_graba_100_de_vram		;4f59   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f5c
	djnz L_4F58		;4f5d
	ld hl,03800h		;4f5f
	ld b,008h		;4f62
L_4F64:
	push bc			;4f64
	call disco_graba_100_de_vram		;4f65   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f68
	djnz L_4F64		;4f69
	ld hl,00000h		;4f6b
	ld b,018h		;4f6e
L_4F70:
	push bc			;4f70
	call disco_graba_100_de_vram		;4f71   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f74
	djnz L_4F70		;4f75
	ld hl,01800h		;4f77
	ld b,008h		;4f7a
L_4F7C:
	push bc			;4f7c
	call disco_graba_100_de_vram		;4f7d   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;4f80
	djnz L_4F7C		;4f81
	ret			;4f83
disco_graba_100_de_vram:		; lee 0x100 bytes de la VRAM y los graba
	ld bc,00100h		;4f84
disco_graba_bc_de_vram:		; lee BC bytes de la VRAM y los graba
	push hl			;4f87
	push bc			;4f88
	ld de,08000h		;4f89
	call 00059h		;4f8c   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,08000h		;4f8f
	ld c,01ah		;4f92
	call 0f37dh		;4f94
	pop hl			;4f97
	push hl			;4f98
	call bdos_graba		;4f99   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	pop bc			;4f9c
	pop hl			;4f9d
	add hl,bc			;4f9e
	ret			;4f9f
entra_al_disco:		; pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	di			;4fa0
	ld a,(0f2a0h)		;4fa1   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;4fa4
	call 00024h		;4fa6   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f11bh)		;4fa9   ; lee el gancho del juego es H.KEYI (no H.TIMI)
	and a			;4fac
	ld hl,0fd9fh		;4fad   ; apunta a el gancho H.TIMI
	jr z,L_4FB5		;4fb0
	ld hl,0fd9ah		;4fb2   ; apunta a el gancho H.KEYI
L_4FB5:
	ld a,(hl)			;4fb5
	ld (0984eh),a		;4fb6
	ld (hl),0c9h		;4fb9
	ld hl,0c000h		;4fbb
	ld de,0ac80h		;4fbe
	ld bc,03380h		;4fc1
	ldir		;4fc4
	ld hl,09b80h		;4fc6
	ld de,0e280h		;4fc9
	ld bc,01100h		;4fcc
	ldir		;4fcf
	ld a,(0dd9eh)		;4fd1
	and a			;4fd4
	jr z,L_4FE2		;4fd5
	ld hl,0ac80h		;4fd7
	ld de,0e280h		;4fda
	ld bc,01100h		;4fdd
	ldir		;4fe0
L_4FE2:
	ld hl,00000h		;4fe2
	ld (0f1c0h),hl		;4fe5
	ld hl,00000h		;4fe8
	add hl,sp			;4feb
	ld de,0ec80h		;4fec
	add hl,de			;4fef
	ld sp,hl			;4ff0
	ei			;4ff1
	ret			;4ff2
sale_del_disco:		; espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	di			;4ff3
	ld bc,00200h		;4ff4
L_4FF7:
	push bc			;4ff7
	call 0df61h		;4ff8
	pop bc			;4ffb
	dec bc			;4ffc
	ld a,b			;4ffd
	or c			;4ffe
	jr nz,L_4FF7		;4fff
	di			;5001
	ld hl,0e280h		;5002
	ld de,09b80h		;5005
	ld bc,01100h		;5008
	ldir		;500b
	ld hl,0dfffh		;500d
	ld de,0f37fh		;5010
	ld bc,03380h		;5013
	lddr		;5016
	ld a,(0f11eh)		;5018   ; lee hay disco
	and a			;501b
	jr z,L_5029		;501c
	ld hl,09b80h		;501e
	ld de,0c000h		;5021
	ld bc,01100h		;5024
	ldir		;5027
L_5029:
	ld a,(0f11bh)		;5029   ; lee el gancho del juego es H.KEYI (no H.TIMI)
	and a			;502c
	ld hl,0fd9fh		;502d   ; apunta a el gancho H.TIMI
	jr z,L_5035		;5030
	ld hl,0fd9ah		;5032   ; apunta a el gancho H.KEYI
L_5035:
	ld a,(0984eh)		;5035
	ld (hl),a			;5038
	ld hl,00000h		;5039
	add hl,sp			;503c
	ld de,01380h		;503d
	add hl,de			;5040
	ld sp,hl			;5041
	ei			;5042
	ret			;5043
L_5044:
	xor a			;5044
	call 0750eh		;5045   ; menu: menu de B opciones con el cursor A: devuelve la elegida
	ld a,(0922ch)		;5048   ; lee cuantas letras lleva el nombre
	or a			;504b
	ret z			;504c
	ld hl,09823h		;504d   ; apunta a el FCB
	ld (09848h),hl		;5050   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	ld d,h			;5053
	ld e,l			;5054
	ld (hl),020h		;5055
	inc de			;5057
	ld bc,00008h		;5058
	ldir		;505b
	xor a			;505d
	ld (de),a			;505e
	inc hl			;505f
	inc de			;5060
	ld bc,0001bh		;5061
	ldir		;5064
	ld de,09823h		;5066   ; apunta a el FCB
	ld (de),a			;5069
	inc de			;506a
	ld a,(0922ch)		;506b   ; lee cuantas letras lleva el nombre
	ld c,a			;506e
	ld b,000h		;506f
	ld hl,0920bh		;5071   ; apunta a el bufer de teclas
	ldir		;5074
	call nombre_de_fichero		;5076   ; nombre_de_fichero: pone en el FCB (0x982C) el nombre: tipo y numero de juego
	ld a,0ffh		;5079
	or a			;507b
	ret			;507c
nombre_de_fichero:		; pone en el FCB (0x982C) el nombre: tipo y numero de juego
	ld de,0982ch		;507d
	ld hl,05095h		;5080
	ld a,(0f10bh)		;5083   ; lee tipo y opcion del menu de disco
	and 00fh		;5086
	call 07251h		;5088   ; hl_mas_a: HL = HL + A
	ldi		;508b
	ld a,(0f281h)		;508d   ; lee el codigo del juego
	ex de,hl			;5090
	call byte_a_hex		;5091   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	ret			;5094

; ----------------------------------------------------------------------
; DATOS resto_5095: lo apuntan con el banco puesto p00:5080 (0x5095); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5080 (4 bytes)
;   0x5095..0x5099  (4 bytes)
DATA_resto_5095:
	defb 048h,053h,047h,052h	; 5095

; ======================================================================
; CODIGO 0x5099..0x51c3  (298 bytes)
; ======================================================================


byte_a_hex:		; escribe A en hexadecimal (dos letras) en HL
	ld d,a			;5099
	and 0f0h		;509a
	rrca			;509c
	rrca			;509d
	rrca			;509e
	rrca			;509f
	or 030h		;50a0
	ld (hl),a			;50a2
	inc hl			;50a3
	ld a,d			;50a4
	and 00fh		;50a5
	or 030h		;50a7
	ld (hl),a			;50a9
	ret			;50aa
borra_fcb:		; pone a cero el FCB de 0x982F
	ld hl,0982fh		;50ab
	ld de,09830h		;50ae
	ld (hl),000h		;50b1
	ld bc,00018h		;50b3
	ldir		;50b6
	ret			;50b8
hay_disco:		; Z si no hay disco: mira si H.PHYD (0xFFA7) es un `ret`
	ld a,(0ffa7h)		;50b9
	cp 0c9h		;50bc
	ret			;50be
L_50BF:
	ld (09848h),de		;50bf   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	xor a			;50c3
	ld (de),a			;50c4
	inc de			;50c5
	ld bc,0000bh		;50c6
	ldir		;50c9
	xor a			;50cb
	ld b,019h		;50cc
L_50CE:
	ld (de),a			;50ce
	inc de			;50cf
	djnz L_50CE		;50d0
	ret			;50d2
L_50D3:
	ld (09848h),hl		;50d3   ; guarda el puntero al FCB y el byte siguiente (16 bits)
fcb_prepara:		; registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	ld hl,(09848h)		;50d6   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld bc,0000ch		;50d9
	add hl,bc			;50dc
	ld (hl),b			;50dd
	inc hl			;50de
	ld (hl),b			;50df
	inc hl			;50e0
	ld bc,00001h		;50e1
	ld (hl),c			;50e4
	inc hl			;50e5
	ld (hl),b			;50e6
	ld bc,00011h		;50e7
	add hl,bc			;50ea
	ld b,005h		;50eb
	xor a			;50ed
L_50EE:
	ld (hl),a			;50ee
	inc hl			;50ef
	djnz L_50EE		;50f0
	ret			;50f2
L_50F3:
	ld hl,(09848h)		;50f3   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld bc,00010h		;50f6
	add hl,bc			;50f9
	ld a,(hl)			;50fa
	inc hl			;50fb
	ld h,(hl)			;50fc
	ld l,a			;50fd
	ret			;50fe
L_50FF:
	ld (09848h),de		;50ff   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	jr L_5109		;5103
fcb_registro:		; pone HL como registro aleatorio del FCB
	ld de,(09848h)		;5105   ; lee el puntero al FCB y el byte siguiente (16 bits)
L_5109:
	ex de,hl			;5109
	ld bc,00021h		;510a
	add hl,bc			;510d
	ld (hl),e			;510e
	inc hl			;510f
	ld (hl),d			;5110
	ret			;5111
bdos_abre:		; BDOS 0x0F, abrir fichero; si falla, el error 0
	ld de,(09848h)		;5112   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,00fh		;5116
	call 0f37dh		;5118
	ld c,000h		;511b
	inc a			;511d
	jp z,L_5195		;511e
	ret			;5121
bdos_crea:		; BDOS 0x16, crear fichero; si falla, el error 1
	ld de,(09848h)		;5122   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,016h		;5126
	call 0f37dh		;5128
	ld c,001h		;512b
	inc a			;512d
	jp z,L_5195		;512e
	ret			;5131
bdos_cierra:		; BDOS 0x10, cerrar fichero; si falla, el error 2
	ld de,(09848h)		;5132   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,010h		;5136
	call 0f37dh		;5138
	ld c,002h		;513b
	inc a			;513d
	jp z,L_5195		;513e
	ret			;5141
bdos_lee:		; BDOS 0x27, leer HL registros; si falla, el error 3
	ld de,(09848h)		;5142   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,027h		;5146
	call 0f37dh		;5148
	ld c,003h		;514b
	or a			;514d
	jp nz,L_5195		;514e
	ret			;5151
bdos_graba:		; BDOS 0x26, grabar HL registros; si falla, el error 4
	ld de,(09848h)		;5152   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,026h		;5156
	call 0f37dh		;5158
	ld c,004h		;515b
	or a			;515d
	jp nz,L_5195		;515e
	ret			;5161
disco_lee_byte:		; lee un byte del fichero (por la pila)
	ld bc,bdos_lee		;5162
	jr L_516A		;5165
disco_graba_byte:		; graba el byte A en el fichero (por la pila)
	ld bc,bdos_graba		;5167
L_516A:
	push af			;516a
	ld hl,00001h		;516b
	add hl,sp			;516e
	push bc			;516f
	ex de,hl			;5170
	ld c,01ah		;5171
	call 0f37dh		;5173
	pop bc			;5176
	call un_registro		;5177   ; un_registro: HL = 1 y salta a la rutina de BC
	pop af			;517a
	ret			;517b
un_registro:		; HL = 1 y salta a la rutina de BC
	ld hl,00001h		;517c
	push bc			;517f
	ret			;5180
disco_graba_palabra:		; graba HL en el fichero, byte bajo primero
	push hl			;5181
	ld a,l			;5182
	call disco_graba_byte		;5183   ; disco_graba_byte: graba el byte A en el fichero (por la pila)
	pop hl			;5186
	ld a,h			;5187
	jr disco_graba_byte		;5188
disco_lee_palabra:		; lee una palabra del fichero en HL
	call disco_lee_byte		;518a   ; disco_lee_byte: lee un byte del fichero (por la pila)
	ld l,a			;518d
	push hl			;518e
	call disco_lee_byte		;518f   ; disco_lee_byte: lee un byte del fichero (por la pila)
	pop hl			;5192
	ld h,a			;5193
	ret			;5194
L_5195:
	push bc			;5195
	call sale_del_disco		;5196   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	call 07499h		;5199   ; p02_8000_si: si 0xF112: p02:8000 con el cartucho en la pagina 2
	call pinta_opcion		;519c   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	call pinta_tipo		;519f   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call pinta_juego		;51a2   ; pinta_juego: pinta 'GAME' y el numero de juego (0xF281) en hexadecimal
	ld hl,051c3h		;51a5
	ld de,(09237h)		;51a8   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	push de			;51ac
	call 0738bh		;51ad   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	pop hl			;51b0
	ld bc,00040h		;51b1
	add hl,bc			;51b4
	ex de,hl			;51b5
	pop bc			;51b6
	call error_de_disco		;51b7   ; error_de_disco: pinta el mensaje del error C (tabla de p00:5209)
	call 074bah		;51ba   ; p02_80e4_si: si 0xF112: p02:80E4
	ld sp,(0984ah)		;51bd   ; lee la pila guardada al ir al disco y el byte siguiente (16 bits)
	scf			;51c1
	ret			;51c2

; ----------------------------------------------------------------------
; DATOS resto_51C3: lo apuntan con el banco puesto p00:51A5 (0x51C3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:51A5 (15 bytes)
;   0x51c3..0x51d2  (15 bytes)
DATA_resto_51C3:
	defb 040h,040h,044h,049h,053h,04bh,000h,045h,052h,052h,04fh,052h,040h,040h,0ffh	; 51c3  @@DISK.ERROR@@.

; ======================================================================
; CODIGO 0x51d2..0x51fa  (40 bytes)
; ======================================================================


error_de_disco:		; pinta el mensaje del error C (tabla de p00:5209)
	ld a,c			;51d2
	add a,a			;51d3
	ld hl,05209h		;51d4
	call 07251h		;51d7   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;51da
	inc hl			;51db
	ld h,(hl)			;51dc
	ld l,a			;51dd
	push de			;51de
	call 0738bh		;51df   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	pop hl			;51e2
	ld bc,00040h		;51e3
	add hl,bc			;51e6
	ld de,051fah		;51e7
	ex de,hl			;51ea
	call 0738bh		;51eb   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	call 00156h		;51ee   ; BIOS KILBUF - Clears keyboard buffer
L_51F1:
	ld a,007h		;51f1
	call 00141h		;51f3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rla			;51f6
	jr c,L_51F1		;51f7
	ret			;51f9

; ----------------------------------------------------------------------
; DATOS resto_51FA: lo apuntan con el banco puesto p00:51E7 (0x51FA), p00:51D4
;   (0x5209); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:51E7, p00:51D4 (107 bytes)
;   0x51fa..0x5265  (107 bytes)
DATA_resto_51FA:
	defb 048h,049h,054h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh,045h,059h,0ffh,015h	; 51fa  HIT.RETURN.KEY..
	defb 052h,026h,052h,037h,052h,043h,052h,037h,052h,055h,052h,03dh,046h,049h,04ch,045h	; 520a  R&R7RCR7RUR=FILE
	defb 000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h,03dh,0ffh,03dh,054h,04fh,04fh	; 521a  .NOT.FOUND=.=TOO
	defb 000h,04dh,041h,04eh,059h,000h,046h,049h,04ch,045h,053h,03dh,0ffh,03dh,044h,049h	; 522a  .MANY.FILES=.=DI
	defb 053h,04bh,000h,046h,055h,04ch,04ch,03dh,0ffh,03dh,044h,049h,053h,04bh,000h,052h	; 523a  SK.FULL=.=DISK.R
	defb 045h,041h,044h,000h,045h,052h,052h,04fh,052h,03dh,0ffh,03dh,044h,049h,053h,04bh	; 524a  EAD.ERROR=.=DISK
	defb 000h,049h,04fh,000h,045h,052h,052h,04fh,052h,03dh,0ffh	; 525a  .IO.ERROR=.

; ======================================================================
; CODIGO 0x5265..0x5294  (47 bytes)
; ======================================================================


ventana:		; abre una ventana de texto con el marco de DE
	ex de,hl			;5265
	ld hl,09803h		;5266
	push hl			;5269
	ld (09801h),hl		;526a
	ld hl,09801h		;526d
	ld (0ac23h),hl		;5270
	ld a,(0f11eh)		;5273   ; lee hay disco
	and a			;5276
	jr z,L_527C		;5277
	ld (0d0a3h),hl		;5279
L_527C:
	pop hl			;527c
	push de			;527d
	ld de,05294h		;527e
	ld bc,0000dh		;5281
	ex de,hl			;5284
	ldir		;5285
	ld hl,09808h		;5287
	ld a,(0f103h)		;528a   ; lee el slot del Game Master
	ld (hl),a			;528d
	inc hl			;528e
	pop de			;528f
	ld (hl),e			;5290
	inc hl			;5291
	ld (hl),d			;5292
	ret			;5293

; ----------------------------------------------------------------------
; DATOS resto_5294: lo apuntan con el banco puesto p00:527E (0x5294), p00:5AA8
;   (0x52A1), p00:5BCD (0x52A1), p00:5F31 (0x52A1), p00:5BBD (0x52BA),
;   p01:624A (0x52BA); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:527E, p00:5AA8, p00:5BCD, p00:5F31, p00:5BBD,
;   p01:624A (255 bytes)
;   0x5294..0x5393  (255 bytes)
DATA_resto_5294:
	defb 0fdh,0e5h,0ddh,0e5h,0f7h,000h,000h,000h,0ddh,0e1h,0fdh,0e1h,0c9h,0c5h,0cdh,0f3h	; 5294  ................
	defb 04fh,0cdh,099h,074h,0c1h,0cdh,0d1h,052h,0f5h,0cdh,0bah,074h,0f1h,0dah,0bdh,051h	; 52a4  O..t...R...t...Q
	defb 0cdh,0a0h,04fh,00eh,001h,0c9h,0c5h,0cdh,0f3h,04fh,0c1h,0cdh,0d1h,052h,0dah,0bdh	; 52b4  ..O......O...R..
	defb 051h,0cdh,08fh,074h,0cdh,030h,05bh,0cdh,0a0h,04fh,00eh,001h,0c9h,0c5h,0cdh,0feh	; 52c4  Q..t.0[..O......
	defb 05ch,0cdh,056h,05dh,0cdh,02ah,05ch,021h,0c3h,051h,0edh,05bh,037h,092h,0cdh,08bh	; 52d4  \.V].*\!.Q.[7...
	defb 073h,0c1h,079h,0e6h,00eh,00fh,0feh,002h,038h,006h,0feh,006h,038h,049h,018h,006h	; 52e4  s.y.....8...8I..
	defb 021h,04dh,053h,00fh,030h,003h,021h,05eh,053h,0ebh,02ah,037h,092h,001h,040h,000h	; 52f4  !MS.0.!^S.*7..@.
	defb 009h,006h,011h,0e5h,01ah,0cdh,046h,076h,013h,023h,010h,0f8h,0e1h,001h,040h,000h	; 5304  ......Fv.#....@.
	defb 009h,0ebh,021h,06fh,053h,0d5h,0cdh,08bh,073h,0e1h,001h,020h,000h,009h,011h,081h	; 5314  ..!oS...s.. ....
	defb 053h,0ebh,0cdh,08bh,073h,0cdh,056h,001h,0cdh,09fh,000h,0feh,00dh,028h,006h,0feh	; 5324  S...s.V......(..
	defb 020h,028h,011h,018h,0f3h,0a7h,0c9h,02ah,037h,092h,001h,040h,000h,009h,0ebh,00eh	; 5334   (.....*7..@....
	defb 005h,0cdh,0d2h,051h,0cdh,08fh,074h,037h,0c9h,03dh,057h,052h,049h,054h,045h,000h	; 5344  ...Q..t7.=WRITE.
	defb 050h,052h,04fh,054h,045h,043h,054h,045h,044h,03dh,03dh,044h,049h,053h,04bh,000h	; 5354  PROTECTED==DISK.
	defb 04fh,046h,046h,04ch,049h,04eh,045h,03dh,000h,000h,000h,052h,045h,054h,055h,052h	; 5364  OFFLINE=...RETUR
	defb 04eh,000h,04bh,045h,059h,040h,040h,052h,045h,054h,052h,059h,0ffh,053h,050h,041h	; 5374  N.KEY@@RETRY.SPA
	defb 043h,045h,000h,04bh,045h,059h,000h,040h,040h,041h,042h,04fh,052h,054h,0ffh	; 5384  CE.KEY.@@ABORT.

; ======================================================================
; CODIGO 0x5393..0x546e  (219 bytes)
; ======================================================================


pide_nombre_fichero:		; lee el nombre del fichero letra a letra
	xor a			;5393
	ld (0922ch),a		;5394   ; guarda cuantas letras lleva el nombre
	ld (0922eh),a		;5397   ; guarda la opcion elegida
	ld hl,03a6ch		;539a
	ld (09231h),hl		;539d   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld (09233h),hl		;53a0   ; guarda la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	ld a,080h		;53a3
	ld (0922dh),a		;53a5   ; guarda la ultima opcion del menu
elige_fichero:		; lista los ficheros del disco y deja elegir uno
	call 07600h		;53a8   ; cursor_apaga: quita el cursor
	ld (0984ah),sp		;53ab   ; guarda la pila guardada al ir al disco
	call borra_lista_ficheros		;53af   ; borra_lista_ficheros: pone a cero la lista de ficheros (0x9103) y el FCB
	call busca_ficheros		;53b2   ; busca_ficheros: busca los ficheros del disco (BDOS 0x11 y 0x12)
	jp z,L_544A		;53b5
	call texto_5b4a		;53b8   ; texto_5b4a: pinta el texto de p00:5B4A
	call 07633h		;53bb   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
L_53BE:
	call pinta_fichero		;53be   ; pinta_fichero: pinta el nombre del fichero elegido
	call 00156h		;53c1   ; BIOS KILBUF - Clears keyboard buffer
L_53C4:
	ld hl,0922ch		;53c4   ; apunta a cuantas letras lleva el nombre
	ld de,0922eh		;53c7   ; apunta a la opcion elegida
	call 0009fh		;53ca   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;53cd
	jr z,L_543A		;53cf
	cp 01fh		;53d1
	jr z,L_5402		;53d3
	cp 020h		;53d5
	jr nz,L_53C4		;53d7
	ld a,(0922ch)		;53d9   ; lee cuantas letras lleva el nombre
	ld hl,09100h		;53dc   ; apunta a cuantos ficheros hay
	cp (hl)			;53df
	ccf			;53e0
	ret c			;53e1
	call fila_de_fichero		;53e2   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	push hl			;53e5
	call fcb_comodin		;53e6   ; fcb_comodin: FCB con '?' en el nombre para buscar ficheros
	pop hl			;53e9
	ld de,09823h		;53ea   ; apunta a el FCB
	ld (09848h),de		;53ed   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	inc de			;53f1
	ld a,(092cfh)		;53f2
	cp 001h		;53f5
	ld bc,00008h		;53f7
	jr nz,L_53FE		;53fa
	ld c,00bh		;53fc
L_53FE:
	ldir		;53fe
	or a			;5400
	ret			;5401
L_5402:
	ld a,(09100h)		;5402   ; lee cuantos ficheros hay
	cp (hl)			;5405
	jr z,L_53C4		;5406
	inc (hl)			;5408
	ld a,(de)			;5409
	ld b,a			;540a
	ld a,(hl)			;540b
	sub b			;540c
	cp 003h		;540d
	jr c,L_5419		;540f
	inc b			;5411
	ld a,b			;5412
	ld (de),a			;5413
	ld bc,00000h		;5414
	jr L_541C		;5417
L_5419:
	ld bc,00020h		;5419
L_541C:
	call 07642h		;541c   ; cursor_borra: borra el cursor
	add hl,bc			;541f
	push hl			;5420
	ld de,(09233h)		;5421   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	and a			;5425
	sbc hl,de		;5426
	ld a,(0922dh)		;5428   ; lee la ultima opcion del menu
	ld d,000h		;542b
	ld e,a			;542d
	rst 20h			;542e   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;542f
	jr nc,L_5435		;5430
	ld (09231h),hl		;5432   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
L_5435:
	call 07633h		;5435   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
	jr L_53BE		;5438
L_543A:
	ld a,(hl)			;543a
	or a			;543b
	jr z,L_53C4		;543c
	dec (hl)			;543e
	ex de,hl			;543f
	ld a,(de)			;5440
	cp (hl)			;5441
	jr nc,L_5445		;5442
	dec (hl)			;5444
L_5445:
	ld bc,0ffe0h		;5445
	jr L_541C		;5448
L_544A:
	ld hl,0546eh		;544a
	ld de,(09233h)		;544d   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	call 0738bh		;5451   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	ld de,05476h		;5454
	ld hl,(09233h)		;5457   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	ld bc,00040h		;545a
	add hl,bc			;545d
	ex de,hl			;545e
	call 0738bh		;545f   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	call 00156h		;5462   ; BIOS KILBUF - Clears keyboard buffer
L_5465:
	call 0009fh		;5465   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;5468
	jr nz,L_5465		;546a
	scf			;546c
	ret			;546d

; ----------------------------------------------------------------------
; DATOS resto_546E: lo apuntan con el banco puesto p00:544A (0x546E), p00:5454
;   (0x5476); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:544A, p00:5454 (23 bytes)
;   0x546e..0x5485  (23 bytes)
DATA_resto_546E:
	defb 04eh,04fh,000h,046h,049h,04ch,045h,0ffh,048h,049h,054h,000h,052h,045h,054h,055h	; 546e  NO.FILE.HIT.RETU
	defb 052h,04eh,000h,04bh,045h,059h,0ffh	; 547e

; ======================================================================
; CODIGO 0x5485..0x5545  (192 bytes)
; ======================================================================


pinta_fichero:		; pinta el nombre del fichero elegido
	ld a,(0922eh)		;5485   ; lee la opcion elegida
	call fila_de_fichero		;5488   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	ld de,(09233h)		;548b   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	inc de			;548f
	inc de			;5490
	ex de,hl			;5491
	ld b,003h		;5492
L_5494:
	push bc			;5494
	push hl			;5495
	push hl			;5496
	xor a			;5497
	ld b,00ch		;5498
L_549A:
	call 07646h		;549a   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;549d
	djnz L_549A		;549e
	pop hl			;54a0
	ld b,008h		;54a1
L_54A3:
	ld a,(de)			;54a3
	cp 020h		;54a4
	jr z,L_54AC		;54a6
	call 07646h		;54a8   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;54ab
L_54AC:
	inc de			;54ac
	djnz L_54A3		;54ad
	ld a,(092cfh)		;54af
	cp 001h		;54b2
	jr nz,L_54CA		;54b4
	ld a,(de)			;54b6
	or a			;54b7
	jr z,L_54BC		;54b8
	ld a,03ch		;54ba
L_54BC:
	call 07646h		;54bc   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;54bf
	ld b,003h		;54c0
L_54C2:
	ld a,(de)			;54c2
	call 07646h		;54c3   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc de			;54c6
	inc hl			;54c7
	djnz L_54C2		;54c8
L_54CA:
	pop hl			;54ca
	ld bc,00020h		;54cb
	add hl,bc			;54ce
	pop bc			;54cf
	djnz L_5494		;54d0
	ret			;54d2
borra_lista_ficheros:		; pone a cero la lista de ficheros (0x9103) y el FCB
	ld hl,09103h		;54d3   ; apunta a la lista de ficheros
	ld de,09104h		;54d6
	ld (hl),000h		;54d9
	ld bc,00107h		;54db
	ldir		;54de
fcb_comodin:		; FCB con '?' en el nombre para buscar ficheros
	ld hl,09823h		;54e0   ; apunta a el FCB
	ld de,09824h		;54e3
	ld (hl),000h		;54e6
	ld bc,00024h		;54e8
	ldir		;54eb
	ld hl,09824h		;54ed
	ld de,09825h		;54f0
	ld (hl),03fh		;54f3
	ld bc,0000ah		;54f5
	ldir		;54f8
	jp nombre_de_fichero		;54fa   ; nombre_de_fichero: pone en el FCB (0x982C) el nombre: tipo y numero de juego
busca_ficheros:		; busca los ficheros del disco (BDOS 0x11 y 0x12)
	call entra_al_disco		;54fd   ; entra_al_disco: pone la RAM en la pagina 2, desengancha la interrupcion y guarda la RAM del juego que pisa el disco
	xor a			;5500
	ld (09100h),a		;5501   ; guarda cuantos ficheros hay
	ld de,09103h		;5504   ; apunta a la lista de ficheros
	ld c,01ah		;5507
	call 0f37dh		;5509
	ld de,09823h		;550c   ; apunta a el FCB
	ld c,011h		;550f
	call 0f37dh		;5511
	inc a			;5514
	jr z,L_5540		;5515
L_5517:
	ld hl,09100h		;5517   ; apunta a cuantos ficheros hay
	inc (hl)			;551a
	push hl			;551b
	call guarda_fichero_hallado		;551c   ; guarda_fichero_hallado: copia el nombre hallado a la lista
	pop hl			;551f
	ld a,(hl)			;5520
	cp 014h		;5521
	jr z,L_5530		;5523
	ld de,09823h		;5525   ; apunta a el FCB
	ld c,012h		;5528
	call 0f37dh		;552a
	inc a			;552d
	jr nz,L_5517		;552e
L_5530:
	ld a,(09100h)		;5530   ; lee cuantos ficheros hay
	push af			;5533
	ld de,05545h		;5534
	call copia_nombre		;5537   ; copia_nombre: copia un nombre de la lista
	call sale_del_disco		;553a   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	pop af			;553d
	or a			;553e
	ret			;553f
L_5540:
	call sale_del_disco		;5540   ; sale_del_disco: espera, devuelve la RAM del juego, los ganchos y la pila (0x984A)
	xor a			;5543
	ret			;5544

; ----------------------------------------------------------------------
; DATOS resto_5545: lo apuntan con el banco puesto p00:5534 (0x5545); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5534 (11 bytes)
;   0x5545..0x5550  (11 bytes)
DATA_resto_5545:
	defb 040h,040h,045h,04eh,044h,040h,040h,000h,000h,000h,000h	; 5545  @@END@@....

; ======================================================================
; CODIGO 0x5550..0x56bd  (365 bytes)
; ======================================================================


guarda_fichero_hallado:		; copia el nombre hallado a la lista
	ld de,09104h		;5550
	ld a,(09100h)		;5553   ; lee cuantos ficheros hay
	dec a			;5556
copia_nombre:		; copia un nombre de la lista
	call fila_de_fichero		;5557   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	ex de,hl			;555a
	ld bc,00008h		;555b
	jr z,L_5562		;555e
	ld c,00bh		;5560
L_5562:
	ldir		;5562
	ret			;5564
fila_de_fichero:		; HL = la fila A de la lista de ficheros
	ld l,a			;5565
	ld h,000h		;5566
	ld a,(092cfh)		;5568
	cp 001h		;556b
	jr z,L_5574		;556d
	add hl,hl			;556f
	add hl,hl			;5570
	add hl,hl			;5571
	jr L_557D		;5572
L_5574:
	ld b,h			;5574
	ld c,l			;5575
	add hl,hl			;5576
	add hl,bc			;5577
	add hl,hl			;5578
	add hl,hl			;5579
	and a			;557a
	sbc hl,bc		;557b
L_557D:
	ld bc,09124h		;557d
	add hl,bc			;5580
	or a			;5581
	ret			;5582
init:		; INIT del cartucho: si no se pulsa nada, mira el otro cartucho, guarda los slots y arranca
	ld a,008h		;5583
	call 00141h		;5585   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;5588
	ret nc			;5589
	ld a,006h		;558a
	call 00141h		;558c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 2,a		;558f
	ret z			;5591
	di			;5592
	call mi_slot		;5593   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0f103h),a		;5596   ; guarda el slot del Game Master
	call busca_cartuchos		;5599   ; busca_cartuchos: copia p00:578D a 0xE010 y la ejecuta
	ld a,(0f2a0h)		;559c   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;559f
	push af			;55a1
	call 00024h		;55a2   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;55a5
	inc a			;55a6
	jp z,L_4A39		;55a7
	ld hl,08000h		;55aa
	ld de,08001h		;55ad
	ld bc,03fffh		;55b0
	ld (hl),000h		;55b3
	ldir		;55b5
	ld a,(0f103h)		;55b7   ; lee el slot del Game Master
	ld (0d800h),a		;55ba
	ld a,(0f29fh)		;55bd   ; lee el slot de la RAM de la pagina 1
	ld (0d801h),a		;55c0
	ld a,(0f2a0h)		;55c3   ; lee el slot de la RAM de la pagina 2
	ld (0d802h),a		;55c6
	call salta_a_e000_b		;55c9   ; salta_a_e000_b: copia p00:5945 a 0xE000 (0x87 bytes) y salta alli
	jr nc,L_55F5		;55cc
	jp L_59CC		;55ce
L_55D1:
	di			;55d1
	ld a,(0d802h)		;55d2
	ld h,080h		;55d5
	call 00024h		;55d7   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,0ffh		;55da
	ld (0f110h),a		;55dc   ; guarda el menu esta abierto
	ld hl,0e280h		;55df
	ld de,09b80h		;55e2
	ld bc,01100h		;55e5
	ldir		;55e8
	ld hl,0e280h		;55ea
	ld de,0c000h		;55ed
	ld bc,01100h		;55f0
	ldir		;55f3
L_55F5:
	di			;55f5
	ld sp,0f380h		;55f6
	ld hl,0f100h		;55f9   ; apunta a volumen del PSG, canal A
	ld de,0f101h		;55fc   ; apunta a volumen del PSG, canal B
	ld (hl),000h		;55ff
	ld bc,001f0h		;5601
	ldir		;5604
	ld hl,0fd9fh		;5606   ; apunta a el gancho H.TIMI
	ld de,0f2e1h		;5609
	ld bc,00005h		;560c
	ldir		;560f
	ld a,0c9h		;5611
	ld (0fd9fh),a		;5613   ; guarda el gancho H.TIMI
L_5616:
	ld a,0ffh		;5616
	call 00132h		;5618   ; BIOS CHGCAP - Alternates the CAPS lamp status
	ld a,0ffh		;561b
	ld (0f110h),a		;561d   ; guarda el menu esta abierto
	call mi_slot		;5620   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0f103h),a		;5623   ; guarda el slot del Game Master
	call busca_cartuchos		;5626   ; busca_cartuchos: copia p00:578D a 0xE010 y la ejecuta
	call mapper_del_juego_a_cero_b		;5629   ; mapper_del_juego_a_cero_b: pone el cartucho del juego en la pagina 2 y 0-1-2-3 en sus registros
	call salta_a_e000		;562c   ; salta_a_e000: copia p00:5832 a 0xE000 (0x105 bytes) y salta alli
	jp nc,L_565D		;562f
	ld hl,04002h		;5632
	call lee_palabra_del_juego		;5635   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	jp z,L_565D		;5638
	ex de,hl			;563b
	ld (0f107h),hl		;563c   ; guarda la direccion INIT del juego y el byte siguiente (16 bits)
L_563F:
	call 0632ah		;563f   ; engancha_al_juego: copia p01:6395 a 0xF130 y cambia el gancho del juego por el suyo
	jp nz,L_565D		;5642
	call 06389h		;5645   ; copia_f230: copia p01:64C6 a 0xF230 (22 bytes)
	call 0709dh		;5648   ; reconoce_juego: reconoce el juego del otro cartucho y prepara su ficha
	ld a,007h		;564b
	call 00141h		;564d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 004h		;5650
	jr z,L_5667		;5652
	ld hl,0f111h		;5654   ; apunta a la opcion de arranque
	ld a,(hl)			;5657
	or a			;5658
	jr nz,L_5667		;5659
	dec a			;565b
	ld (hl),a			;565c
L_565D:
	xor a			;565d
	ld (092cfh),a		;565e
	ld (0f112h),a		;5661   ; guarda hay menu en pantalla
	jp 06669h		;5664
L_5667:
	di			;5667
	ld de,(0f280h)		;5668   ; lee la ficha del juego y el byte siguiente (16 bits)
	ld a,d			;566c
	cp 0ffh		;566d
	jr z,L_565D		;566f
	ld d,e			;5671
	ld e,a			;5672
	ld hl,00743h		;5673
	rst 20h			;5676   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp nc,L_49B3		;5677
	ld hl,00753h		;567a
	rst 20h			;567d   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nc,L_56A3		;567e
	ld hl,04028h		;5680
	call lee_palabra_del_juego		;5683   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	ld a,e			;5686
	cp 002h		;5687
	jr z,L_5690		;5689
	and a			;568b
	jr z,L_5696		;568c
	jr $+71		;568e
L_5690:
	ld a,(0002dh)		;5690   ; la version del MSX (0 = MSX1)
	and a			;5693
	jr nz,$+65		;5694
L_5696:
	ld hl,0402ah		;5696
	call lee_palabra_del_juego		;5699   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	ld a,d			;569c
	and a			;569d
	jp z,L_49B3		;569e
	jr $+52		;56a1
L_56A3:
	ld hl,056bdh		;56a3
L_56A6:
	ld c,(hl)			;56a6
	inc hl			;56a7
	ld b,(hl)			;56a8
	inc hl			;56a9
	ld a,b			;56aa
	cp 0ffh		;56ab
	jp z,L_49B3		;56ad
	call compara_de_bc		;56b0   ; compara_de_bc: Z si DE = BC
	jr z,$+34		;56b3
	jr L_56A6		;56b5
compara_de_bc:		; Z si DE = BC
	ld a,d			;56b7
	sub b			;56b8
	ret nz			;56b9
	ld a,e			;56ba
	sub c			;56bb
	ret			;56bc

; ----------------------------------------------------------------------
; DATOS resto_56BD: lo apuntan con el banco puesto p00:56A3 (0x56BD); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:56A3 (24 bytes)
;   0x56bd..0x56d5  (24 bytes)
DATA_resto_56BD:
	defb 044h,007h,045h,007h,047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh,0c3h,0b3h	; 56bd  D.E.G.H.P.S.....
	defb 049h,03ah,02dh,000h,0a7h,0cah,0b3h,049h	; 56cd  I:-....I

; ======================================================================
; CODIGO 0x56d5..0x59c3  (750 bytes)
; ======================================================================


vuelve_al_juego:		; apaga el menu y vuelve al juego por 0xF15A
	di			;56d5
	ld a,0ffh		;56d6
	ld (0f112h),a		;56d8   ; guarda hay menu en pantalla
	xor a			;56db
	ld (0f29dh),a		;56dc
	ld (0f110h),a		;56df   ; guarda el menu esta abierto
	jp 0f15ah		;56e2
L_56E5:
	ld a,0c9h		;56e5
	ld (0fd9ah),a		;56e7   ; guarda el gancho H.KEYI
	ld (0fd9fh),a		;56ea   ; guarda el gancho H.TIMI
	call mi_slot		;56ed   ; mi_slot: A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	ld (0f103h),a		;56f0   ; guarda el slot del Game Master
	call busca_cartuchos		;56f3   ; busca_cartuchos: copia p00:578D a 0xE010 y la ejecuta
	call mapper_del_juego_a_cero_b		;56f6   ; mapper_del_juego_a_cero_b: pone el cartucho del juego en la pagina 2 y 0-1-2-3 en sus registros
	ld a,(0f2a0h)		;56f9   ; lee el slot de la RAM de la pagina 2
	inc a			;56fc
	jp z,L_4A08		;56fd
	ld hl,0f100h		;5700   ; apunta a volumen del PSG, canal A
	ld de,0f101h		;5703   ; apunta a volumen del PSG, canal B
	ld (hl),000h		;5706
	ld bc,001f0h		;5708
	ldir		;570b
	ld hl,0d4f0h		;570d
	ld de,0f2e1h		;5710
	ld bc,00005h		;5713
	ldir		;5716
	di			;5718
	ld sp,0f380h		;5719
	ld a,(0f2a0h)		;571c   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;571f
	call 00024h		;5721   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,0c000h		;5724
	ld de,09b80h		;5727
	ld bc,01100h		;572a
	ldir		;572d
	jp L_5616		;572f
mapper_del_juego_a_cero_b:		; pone el cartucho del juego en la pagina 2 y 0-1-2-3 en sus registros
	ld a,(0f103h)		;5732   ; lee el slot del Game Master
	ld h,080h		;5735
	call 00024h		;5737   ; BIOS ENASLT - Switches to specified slot and page definitively
	xor a			;573a
	ld (04000h),a		;573b
	inc a			;573e
	ld (06000h),a		;573f   ; el mapper: pone en 0x6000 el banco de A
	inc a			;5742
	ld (08000h),a		;5743   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5746
	ld (0a000h),a		;5747   ; el mapper: pone en 0xA000 el banco de A
	ld a,(0f2a0h)		;574a   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;574d
	jp 00024h		;574f   ; BIOS ENASLT - Switches to specified slot and page definitively
mi_slot:		; A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho
	call 00138h		;5752   ; BIOS RSLREG - Reads the primary slot register
	rrca			;5755
	rrca			;5756
	and 003h		;5757
	ld c,a			;5759
	ld b,000h		;575a
	ld hl,0fcc1h		;575c   ; apunta a EXPTBL, que slots estan expandidos
	add hl,bc			;575f
	or (hl)			;5760
	ld c,a			;5761
	inc hl			;5762
	inc hl			;5763
	inc hl			;5764
	inc hl			;5765
	ld a,(hl)			;5766
	and 00ch		;5767
	or c			;5769
	ret			;576a
lee_palabra_del_juego:		; DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	ld a,(0f104h)		;576b   ; lee el slot del cartucho del juego
	ld c,a			;576e
lee_palabra_slot:		; DE = la palabra HL del slot C (RDSLT)
	call lee_byte_slot		;576f   ; lee_byte_slot: D = el byte HL del slot C (RDSLT), y avanza HL
	ld e,d			;5772
lee_byte_slot:		; D = el byte HL del slot C (RDSLT), y avanza HL
	ld a,c			;5773
	push bc			;5774
	push de			;5775
	call 0000ch		;5776   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;5779
	pop bc			;577a
	ld d,a			;577b
	or e			;577c
	inc hl			;577d
	ret			;577e
busca_cartuchos:		; copia p00:578D a 0xE010 y la ejecuta
	ld hl,L_578D		;577f
	ld de,0e010h		;5782   ; apunta a la lista de la SRAM
	ld bc,00086h		;5785
	ldir		;5788
	jp 0e010h		;578a   ; la lista de la SRAM
L_578D:
	ld hl,04000h		;578d
	call 0e024h		;5790
	ld hl,08000h		;5793
	call 0e024h		;5796
	ld a,(0f103h)		;5799   ; lee el slot del Game Master
	ld h,040h		;579c
	jp 00024h		;579e   ; BIOS ENASLT - Switches to specified slot and page definitively
L_57A1:
	ld (0e000h),hl		;57a1
	ld bc,00400h		;57a4
	ld hl,0fcc1h		;57a7   ; apunta a EXPTBL, que slots estan expandidos
L_57AA:
	push bc			;57aa
	push hl			;57ab
	ld a,(hl)			;57ac
	bit 7,a		;57ad
	jr nz,L_57D5		;57af
	ld a,(0f103h)		;57b1   ; lee el slot del Game Master
	cp c			;57b4
	jr z,L_57BB		;57b5
	ld a,c			;57b7
	call 0e075h		;57b8
L_57BB:
	pop hl			;57bb
	pop bc			;57bc
	jr c,L_57C5		;57bd
	inc hl			;57bf
	inc c			;57c0
	djnz L_57AA		;57c1
	ld a,0ffh		;57c3
L_57C5:
	ld c,a			;57c5
	ld hl,0f29fh		;57c6   ; apunta a el slot de la RAM de la pagina 1
	ld a,(0e001h)		;57c9   ; lee la fila elegida de la SRAM
	cp 040h		;57cc
	jr z,L_57D3		;57ce
	ld hl,0f2a0h		;57d0   ; apunta a el slot de la RAM de la pagina 2
L_57D3:
	ld (hl),c			;57d3
	ret			;57d4
L_57D5:
	call 0e05dh		;57d5
	jr L_57BB		;57d8
L_57DA:
	and 080h		;57da
	or c			;57dc
	ld b,004h		;57dd
L_57DF:
	push bc			;57df
	ld b,a			;57e0
	ld a,(0f103h)		;57e1   ; lee el slot del Game Master
	cp b			;57e4
	jr z,L_57EB		;57e5
	ld a,b			;57e7
	call 0e075h		;57e8
L_57EB:
	pop bc			;57eb
	ret c			;57ec
	add a,004h		;57ed
	djnz L_57DF		;57ef
	ret			;57f1
L_57F2:
	push af			;57f2
	ld hl,(0e000h)		;57f3
	call 00024h		;57f6   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld bc,04000h		;57f9
	ld hl,(0e000h)		;57fc
L_57FF:
	ld a,(hl)			;57ff
	cpl			;5800
	ld (hl),a			;5801
	cp (hl)			;5802
	cpl			;5803
	ld (hl),a			;5804
	jr nz,L_5810		;5805
	inc hl			;5807
	dec bc			;5808
	ld a,b			;5809
	or c			;580a
	jr nz,L_57FF		;580b
	pop af			;580d
	scf			;580e
	ret			;580f
L_5810:
	pop af			;5810
	and a			;5811
	ret			;5812
L_5813:
	call salta_a_e000		;5813   ; salta_a_e000: copia p00:5832 a 0xE000 (0x105 bytes) y salta alli
	jr nc,L_5820		;5816
	ld de,(0f280h)		;5818   ; lee la ficha del juego y el byte siguiente (16 bits)
	ld a,e			;581c
	ld e,d			;581d
	ld d,a			;581e
	ret			;581f
L_5820:
	ld de,0ffffh		;5820
	ret			;5823
salta_a_e000:		; copia p00:5832 a 0xE000 (0x105 bytes) y salta alli
	ld hl,L_5832		;5824
	ld de,0e000h		;5827
	ld bc,00105h		;582a
	ldir		;582d
	jp 0e000h		;582f
L_5832:
	ld bc,00400h		;5832
	ld hl,0fcc1h		;5835   ; apunta a EXPTBL, que slots estan expandidos
L_5838:
	push bc			;5838
	push hl			;5839
	ld a,(hl)			;583a
	bit 7,a		;583b
	jr nz,L_585C		;583d
	ld b,c			;583f
	call 0e0f5h		;5840
	jr z,L_5849		;5843
	ld a,c			;5845
	call 0e046h		;5846
L_5849:
	pop hl			;5849
	pop bc			;584a
	jr c,L_5851		;584b
	inc hl			;584d
	inc c			;584e
	djnz L_5838		;584f
L_5851:
	push af			;5851
	ld a,(0f103h)		;5852   ; lee el slot del Game Master
	ld h,040h		;5855
	call 00024h		;5857   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;585a
	ret			;585b
L_585C:
	call 0e02fh		;585c
	jr L_5849		;585f
L_5861:
	and 080h		;5861
	or c			;5863
	ld b,004h		;5864
L_5866:
	push bc			;5866
	ld b,a			;5867
	call 0e0f5h		;5868
	jr z,L_5871		;586b
	ld a,b			;586d
	call 0e046h		;586e
L_5871:
	pop bc			;5871
	ret c			;5872
	add a,004h		;5873
	djnz L_5866		;5875
	ret			;5877
L_5878:
	ld (0f104h),a		;5878   ; guarda el slot del cartucho del juego
	ld h,040h		;587b
	call 00024h		;587d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(04000h)		;5880
	ld de,04241h		;5883
	rst 20h			;5886   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nz,L_58FC		;5887
	ld hl,(04002h)		;5889
	ld e,09fh		;588c
	call 0e065h		;588e
	ret c			;5891
	ld hl,(04002h)		;5892
	ld e,09ah		;5895
L_5897:
	ld bc,00100h		;5897
L_589A:
	ld a,e			;589a
	cpir		;589b
	jr nz,L_58FC		;589d
	jp po,0e0cah		;589f
	ld a,0fdh		;58a2
	cp (hl)			;58a4
	jr nz,L_589A		;58a5
	ld hl,(04010h)		;58a7
	ld de,04241h		;58aa
	rst 20h			;58ad   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_591C		;58ae
	ld de,04443h		;58b0
	rst 20h			;58b3   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_591C		;58b4
	ld de,04645h		;58b6
	rst 20h			;58b9   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_591C		;58ba
	ld hl,(04011h)		;58bc
	ld a,(04013h)		;58bf
	ld h,a			;58c2
	rst 20h			;58c3   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_5907		;58c4
	ld de,00000h		;58c6
	ld hl,05000h		;58c9
	ld b,000h		;58cc
L_58CE:
	ld a,(hl)			;58ce
	add a,e			;58cf
	ld e,a			;58d0
	jr nc,L_58D4		;58d1
	inc d			;58d3
L_58D4:
	inc hl			;58d4
	djnz L_58CE		;58d5
	push de			;58d7
	ld a,(0f103h)		;58d8   ; lee el slot del Game Master
	ld h,040h		;58db
	call 00024h		;58dd   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop de			;58e0
	ld ix,044beh		;58e1
L_58E5:
	ld l,(ix+000h)		;58e5
	ld h,(ix+001h)		;58e8
	ld a,l			;58eb
	or h			;58ec
	jr z,L_58FC		;58ed
	rst 20h			;58ef   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_5910		;58f0
	inc ix		;58f2
	inc ix		;58f4
	inc ix		;58f6
	inc ix		;58f8
	jr L_58E5		;58fa
L_58FC:
	ld hl,0ffffh		;58fc
	ld (0f280h),hl		;58ff   ; guarda la ficha del juego y el byte siguiente (16 bits)
	ld a,(0f104h)		;5902   ; lee el slot del cartucho del juego
	and a			;5905
	ret			;5906
L_5907:
	ld hl,(04015h)		;5907
	ld a,(04017h)		;590a
	ld h,a			;590d
	jr L_591F		;590e
L_5910:
	ld l,(ix+002h)		;5910
	ld h,(ix+003h)		;5913
	ld e,(hl)			;5916
	inc hl			;5917
	ld d,(hl)			;5918
	ex de,hl			;5919
	jr L_591F		;591a
L_591C:
	ld hl,(04012h)		;591c
L_591F:
	ld (0f280h),hl		;591f   ; guarda la ficha del juego y el byte siguiente (16 bits)
	ld a,(0f104h)		;5922   ; lee el slot del cartucho del juego
	scf			;5925
	ret			;5926
L_5927:
	ld a,(0f103h)		;5927   ; lee el slot del Game Master
	bit 7,a		;592a
	jr nz,L_5935		;592c
	bit 7,b		;592e
	ret nz			;5930
	sub b			;5931
	and 003h		;5932
	ret			;5934
L_5935:
	cp b			;5935
	ret			;5936
salta_a_e000_b:		; copia p00:5945 a 0xE000 (0x87 bytes) y salta alli
	ld hl,L_5945		;5937
	ld de,0e000h		;593a
	ld bc,00087h		;593d
	ldir		;5940
	jp 0e000h		;5942
L_5945:
	ld bc,00400h		;5945
	ld hl,0fcc1h		;5948   ; apunta a EXPTBL, que slots estan expandidos
L_594B:
	push bc			;594b
	push hl			;594c
	ld a,(hl)			;594d
	bit 7,a		;594e
	jr nz,L_596F		;5950
	ld b,c			;5952
	call 0e02fh		;5953
	jr z,L_595C		;5956
	ld a,c			;5958
	call 0e04bh		;5959
L_595C:
	pop hl			;595c
	pop bc			;595d
	jr c,L_5964		;595e
	inc hl			;5960
	inc c			;5961
	djnz L_594B		;5962
L_5964:
	push af			;5964
	ld a,(0f103h)		;5965   ; lee el slot del Game Master
	ld h,040h		;5968
	call 00024h		;596a   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;596d
	ret			;596e
L_596F:
	call 0e034h		;596f
	jr L_595C		;5972
L_5974:
	ld a,(0f103h)		;5974   ; lee el slot del Game Master
	cp b			;5977
	ret			;5978
L_5979:
	and 080h		;5979
	or c			;597b
	ld b,004h		;597c
L_597E:
	push bc			;597e
	ld b,a			;597f
	call 0e02fh		;5980
	jr z,L_5989		;5983
	ld a,b			;5985
	call 0e04bh		;5986
L_5989:
	pop bc			;5989
	ret c			;598a
	add a,004h		;598b
	djnz L_597E		;598d
	ret			;598f
L_5990:
	push af			;5990
	ld h,040h		;5991
	call 00024h		;5993   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,04000h		;5996
	ld de,0e07eh		;5999
	ld bc,04000h		;599c
L_599F:
	ld a,044h		;599f
	cpir		;59a1
	jr nz,L_59C0		;59a3
	jp po,0e07bh		;59a5
	push bc			;59a8
	push de			;59a9
	push hl			;59aa
	ld b,009h		;59ab
L_59AD:
	ld a,(de)			;59ad
	cp (hl)			;59ae
	jr nz,L_59B5		;59af
	inc hl			;59b1
	inc de			;59b2
	djnz L_59AD		;59b3
L_59B5:
	pop hl			;59b5
	pop de			;59b6
	pop bc			;59b7
	jr nz,L_599F		;59b8
	pop af			;59ba
	ld (09800h),a		;59bb
	scf			;59be
	ret			;59bf
L_59C0:
	pop af			;59c0
	and a			;59c1
	ret			;59c2

; ----------------------------------------------------------------------
; DATOS resto_59C3: lo apuntan con el banco puesto p00:5999 (0x59C3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5999 (9 bytes)
;   0x59c3..0x59cc  (9 bytes)
DATA_resto_59C3:
	defb 069h,073h,06bh,020h,042h,041h,053h,049h,043h	; 59c3  isk BASIC

; ======================================================================
; CODIGO 0x59cc..0x5a32  (102 bytes)
; ======================================================================


L_59CC:
	ld a,001h		;59cc
	ld (0f3ebh),a		;59ce   ; guarda el color del borde (BDRCLR)
	call 00062h		;59d1   ; BIOS CHGCLR - Changes the screen colors
	ld a,(09800h)		;59d4
	ld c,a			;59d7
	ld hl,04002h		;59d8
	call lee_palabra_slot		;59db   ; lee_palabra_slot: DE = la palabra HL del slot C (RDSLT)
	ld iy,(097ffh)		;59de
	push de			;59e2
	pop ix		;59e3
	ld hl,L_5A01		;59e5
	ld de,0e800h		;59e8
	ld bc,0000bh		;59eb
	ldir		;59ee
	ld hl,L_5A0C		;59f0
	ld de,0fedah		;59f3
	ld bc,00003h		;59f6
	ldir		;59f9
	call 0001ch		;59fb   ; BIOS CALSLT - Executes inter-slot call
	jp 0fecbh		;59fe
L_5A01:
	ld a,(0f103h)		;5a01   ; lee el slot del Game Master
	ld h,040h		;5a04
	call 00024h		;5a06   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp L_55D1		;5a09
L_5A0C:
	jp 0e800h		;5a0c
L_5A0F:
	call ventana_menu		;5a0f   ; ventana_menu: las esquinas de la ventana del menu (0x9235, 0x9237)
L_5A12:
	call 0749eh		;5a12   ; p02_8000: p02:8000 con el cartucho en la pagina 2 y vuelta a la RAM
L_5A15:
	call pinta_puntos		;5a15   ; pinta_puntos: pinta los puntos (0xF28E/0xF290)
	call cabecera_menu		;5a18   ; cabecera_menu: pinta la cabecera del menu y el numero de juego
	ld hl,05c9bh		;5a1b
	ld b,003h		;5a1e
	call 07690h		;5a20   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	ld b,a			;5a23
	ld hl,05a38h		;5a24
	call 07251h		;5a27   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;5a2a
	ld (0f10bh),a		;5a2b   ; guarda tipo y opcion del menu de disco
	ld a,b			;5a2e
	call 0737bh		;5a2f   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5A32: tabla de 3 palabras del despachador (call 0x408D en
;   0x5A2F); lo leen el despachador (6 bytes)
;   0x5a32..0x5a38  (6 bytes)
DATA_saltos_5A32:
	defb 0a2h,05ah	; 5a32
	defb 05bh,05bh	; 5a34
	defb 009h,05ch	; 5a36

; ----------------------------------------------------------------------
; DATOS resto_5A38: lo apuntan con el banco puesto p00:5A24 (0x5A38); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5A24 (3 bytes)
;   0x5a38..0x5a3b  (3 bytes)
DATA_resto_5A38:
	defb 010h,020h,000h	; 5a38

; ======================================================================
; CODIGO 0x5a3b..0x5acb  (144 bytes)
; ======================================================================


ventana_menu:		; las esquinas de la ventana del menu (0x9235, 0x9237)
	ld hl,03a21h		;5a3b
	ld (09235h),hl		;5a3e   ; guarda la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld hl,03a2ch		;5a41
	ld (09237h),hl		;5a44   ; guarda la esquina de la ventana pequena y el byte siguiente (16 bits)
	ret			;5a47
pinta_puntos:		; pinta los puntos (0xF28E/0xF290)
	ld a,(092ceh)		;5a48
	rra			;5a4b
	jr c,L_5A57		;5a4c
	ld hl,(0f28eh)		;5a4e
	ld de,(0f290h)		;5a51   ; lee los puntos del juego (para el ranking) y el byte siguiente (16 bits)
	jr L_5A6F		;5a55
L_5A57:
	ld hl,(0f28eh)		;5a57
	ld de,092cah		;5a5a
	call copia_3_al_reves		;5a5d   ; copia_3_al_reves: copia 3 bytes de HL hacia atras en DE
	ld hl,(0f290h)		;5a60   ; lee los puntos del juego (para el ranking) y el byte siguiente (16 bits)
	ld de,092cdh		;5a63
	call copia_3_al_reves		;5a66   ; copia_3_al_reves: copia 3 bytes de HL hacia atras en DE
	ld hl,092c8h		;5a69
	ld de,092cbh		;5a6c
L_5A6F:
	push de			;5a6f
	ld de,092b3h		;5a70
	call compara_3		;5a73   ; compara_3: compara 3 bytes (BCD) de HL y DE
	ld de,092b6h		;5a76
	pop hl			;5a79
	ld a,h			;5a7a
	or l			;5a7b
	call nz,compara_3		;5a7c   ; compara_3: compara 3 bytes (BCD) de HL y DE
	ret			;5a7f
copia_3_al_reves:		; copia 3 bytes de HL hacia atras en DE
	ld b,003h		;5a80
L_5A82:
	ld a,(hl)			;5a82
	ld (de),a			;5a83
	inc hl			;5a84
	dec de			;5a85
	djnz L_5A82		;5a86
	ret			;5a88
compara_3:		; compara 3 bytes (BCD) de HL y DE
	inc hl			;5a89
	inc hl			;5a8a
	push hl			;5a8b
	push de			;5a8c
	ld b,003h		;5a8d
L_5A8F:
	ld a,(de)			;5a8f
	cp (hl)			;5a90
	jr c,L_5A9A		;5a91
	dec hl			;5a93
	dec de			;5a94
	djnz L_5A8F		;5a95
	pop de			;5a97
	pop hl			;5a98
	ret			;5a99
L_5A9A:
	pop de			;5a9a
	pop hl			;5a9b
	ld bc,00003h		;5a9c
	lddr		;5a9f
	ret			;5aa1
L_5AA2:
	call hay_disco		;5aa2   ; hay_disco: Z si no hay disco: mira si H.PHYD (0xFFA7) es un `ret`
	jp z,L_5A15		;5aa5
	ld hl,052a1h		;5aa8
	call ventana		;5aab   ; ventana: abre una ventana de texto con el marco de DE
	call cabecera_screen		;5aae   ; cabecera_screen: pinta la cabecera SCREEN
	call pinta_opcion		;5ab1   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	ld hl,05cdeh		;5ab4
	ld b,003h		;5ab7
	call 07690h		;5ab9   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	ld b,a			;5abc
	ld hl,05ad1h		;5abd
	call 07251h		;5ac0   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;5ac3
	ld (0f10bh),a		;5ac4   ; guarda tipo y opcion del menu de disco
	ld a,b			;5ac7
	call 0737bh		;5ac8   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5ACB: tabla de 3 palabras del despachador (call 0x408D en
;   0x5AC8); lo leen el despachador (6 bytes)
;   0x5acb..0x5ad1  (6 bytes)
DATA_saltos_5ACB:
	defb 0e3h,05ah	; 5acb
	defb 0d4h,05ah	; 5acd
	defb 015h,05ah	; 5acf

; ----------------------------------------------------------------------
; DATOS resto_5AD1: lo apuntan con el banco puesto p00:5ABD (0x5AD1); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5ABD (3 bytes)
;   0x5ad1..0x5ad4  (3 bytes)
DATA_resto_5AD1:
	defb 011h,012h,000h	; 5ad1

; ======================================================================
; CODIGO 0x5ad4..0x5b3a  (102 bytes)
; ======================================================================


L_5AD4:
	call pregunta_si		;5ad4   ; pregunta_si: pinta la pregunta y espera la respuesta
	jp z,L_5AA2		;5ad7
	call 074bfh		;5ada   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_guarda_ram		;5add   ; disco_guarda_ram: graba en disco la RAM del juego (0x8000...)
	jp L_5A12		;5ae0
L_5AE3:
	call pregunta_si		;5ae3   ; pregunta_si: pinta la pregunta y espera la respuesta
	jp z,L_5AA2		;5ae6
	call 074bfh		;5ae9   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_guarda_partida		;5aec   ; disco_guarda_partida: graba en disco: abre, crea, escribe y cierra
	jp L_5A12		;5aef
L_5AF2:
	ld hl,(0f28ch)		;5af2
	ld a,h			;5af5
	or l			;5af6
	jp z,L_5AA2		;5af7
	call pregunta_si		;5afa   ; pregunta_si: pinta la pregunta y espera la respuesta
	jp z,L_5AA2		;5afd
	call 074bfh		;5b00   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_guarda_bloque		;5b03   ; disco_guarda_bloque: graba en disco el bloque de 0xDF0C
	jp L_5A12		;5b06
L_5B09:
	ld a,(092c7h)		;5b09
	or a			;5b0c
	jp z,L_5AA2		;5b0d
	call pregunta_si		;5b10   ; pregunta_si: pinta la pregunta y espera la respuesta
	jp z,L_5AA2		;5b13
	call 074bfh		;5b16   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_guarda_ranking		;5b19   ; disco_guarda_ranking: graba en disco el ranking (p01:69AD)
	jp L_5A12		;5b1c
pregunta_si:		; pinta la pregunta y espera la respuesta
	call pinta_tipo		;5b1f   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call texto_5b3a		;5b22   ; texto_5b3a: pinta el texto de p00:5B3A
	ld hl,03a6ch		;5b25
	jp L_5044		;5b28
texto_5b3a:		; pinta el texto de p00:5B3A
	ld hl,05b3ah		;5b2b
	jr L_5B33		;5b2e
texto_5b4a:		; pinta el texto de p00:5B4A
	ld hl,05b4ah		;5b30
L_5B33:
	ld de,(09237h)		;5b33   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	jp 0738bh		;5b37   ; pinta_texto_en: pinta el texto de HL en la VRAM DE

; ----------------------------------------------------------------------
; DATOS resto_5B3A: lo apuntan con el banco puesto p00:5B2B (0x5B3A), p00:5B30
;   (0x5B4A); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:5B2B, p00:5B30 (33 bytes)
;   0x5b3a..0x5b5b  (33 bytes)
DATA_resto_5B3A:
	defb 049h,04eh,050h,055h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,0ffh	; 5b3a  INPUT.FILE.NAME.
	defb 053h,045h,04ch,045h,043h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h	; 5b4a  SELECT.FILE.NAME
	defb 0ffh	; 5b5a

; ======================================================================
; CODIGO 0x5b5b..0x5b7e  (35 bytes)
; ======================================================================


L_5B5B:
	call hay_disco		;5b5b   ; hay_disco: Z si no hay disco: mira si H.PHYD (0xFFA7) es un `ret`
	jp z,L_5A15		;5b5e
	call cabecera_data		;5b61   ; cabecera_data: pinta la cabecera DATA
	call pinta_opcion		;5b64   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	ld hl,05cf6h		;5b67
	ld b,002h		;5b6a
	call 07690h		;5b6c   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	ld b,a			;5b6f
	ld hl,05b82h		;5b70
	call 07251h		;5b73   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;5b76
	ld (0f10bh),a		;5b77   ; guarda tipo y opcion del menu de disco
	ld a,b			;5b7a
	call 0737bh		;5b7b   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5B7E: tabla de 2 palabras del despachador (call 0x408D en
;   0x5B7B); lo leen el despachador (4 bytes)
;   0x5b7e..0x5b82  (4 bytes)
DATA_saltos_5B7E:
	defb 084h,05bh	; 5b7e
	defb 015h,05ah	; 5b80

; ----------------------------------------------------------------------
; DATOS resto_5B82: lo apuntan con el banco puesto p00:5B70 (0x5B82); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5B70 (2 bytes)
;   0x5b82..0x5b84  (2 bytes)
DATA_resto_5B82:
	defb 022h,000h	; 5b82

; ======================================================================
; CODIGO 0x5b84..0x5beb  (103 bytes)
; ======================================================================


L_5B84:
	call pide_fichero		;5b84   ; pide_fichero: abre la ventana de los ficheros y deja elegir
	jr c,$-44		;5b87
	call 074bfh		;5b89   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_carga_partida		;5b8c   ; disco_carga_partida: carga del disco una partida
	jp L_5A12		;5b8f
L_5B92:
	ld hl,(0f28ch)		;5b92
	ld a,h			;5b95
	or l			;5b96
	jp z,L_5B5B		;5b97
	call pide_fichero		;5b9a   ; pide_fichero: abre la ventana de los ficheros y deja elegir
	jr c,$-66		;5b9d
	call 074bfh		;5b9f   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_carga_bloque		;5ba2   ; disco_carga_bloque: carga del disco el bloque de 0xDF0C
	jp L_5A12		;5ba5
L_5BA8:
	ld a,(092c7h)		;5ba8
	or a			;5bab
	jp z,L_5B5B		;5bac
	call pide_fichero		;5baf   ; pide_fichero: abre la ventana de los ficheros y deja elegir
	jr c,$-87		;5bb2
	call 074bfh		;5bb4   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call disco_carga_ranking		;5bb7   ; disco_carga_ranking: carga del disco el ranking
	jp L_5A12		;5bba
pide_fichero:		; abre la ventana de los ficheros y deja elegir
	ld hl,052bah		;5bbd
	call ventana		;5bc0   ; ventana: abre una ventana de texto con el marco de DE
	call pinta_tipo		;5bc3   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call texto_search		;5bc6   ; texto_search: pinta 'SEARCH FILE'
	call pide_nombre_fichero		;5bc9   ; pide_nombre_fichero: lee el nombre del fichero letra a letra
	ret c			;5bcc
	ld hl,052a1h		;5bcd
	jp ventana		;5bd0   ; ventana: abre una ventana de texto con el marco de DE
L_5BD3:
	ld a,(092c7h)		;5bd3
	or a			;5bd6
	jp z,L_5A15		;5bd7
	call cabecera_5dbc		;5bda   ; cabecera_5dbc: pinta la cabecera de p00:5DBC
	call pinta_opcion		;5bdd   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	ld hl,05ddfh		;5be0
	ld b,003h		;5be3
	call 07690h		;5be5   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	call 0737bh		;5be8   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5BEB: tabla de 3 palabras del despachador (call 0x408D en
;   0x5BE8); lo leen el despachador (6 bytes)
;   0x5beb..0x5bf1  (6 bytes)
DATA_saltos_5BEB:
	defb 000h,05ch	; 5beb
	defb 0f1h,05bh	; 5bed
	defb 015h,05ah	; 5bef

; ======================================================================
; CODIGO 0x5bf1..0x5c72  (129 bytes)
; ======================================================================


L_5BF1:
	call 074d6h		;5bf1   ; borra_segun_modo: borra la pantalla segun el modo
	call pinta_juego		;5bf4   ; pinta_juego: pinta 'GAME' y el numero de juego (0xF281) en hexadecimal
	call pinta_opcion		;5bf7   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	call 0684ah		;5bfa   ; menu_ranking: la pantalla del RANKING
	jp L_5A15		;5bfd
L_5C00:
	call 069adh		;5c00   ; ranking_entra: mete la puntuacion en el ranking
	call 06aa0h		;5c03   ; ranking_nombre: pide el nombre para el ranking
	jp L_5A15		;5c06
L_5C09:
	call 074bfh		;5c09   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	xor a			;5c0c
	ld (0f10ah),a		;5c0d   ; guarda la opcion que eligio el menu
	ld (0f10bh),a		;5c10   ; guarda tipo y opcion del menu de disco
	ld a,006h		;5c13
	call 00141h		;5c15   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;5c18
	ret nz			;5c1a
	ld (0f111h),a		;5c1b   ; guarda la opcion de arranque
	jp 066d5h		;5c1e
cabecera_menu:		; pinta la cabecera del menu y el numero de juego
	call 074d6h		;5c21   ; borra_segun_modo: borra la pantalla segun el modo
	ld hl,05c72h		;5c24
	call 0738fh		;5c27   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
pinta_juego:		; pinta 'GAME' y el numero de juego (0xF281) en hexadecimal
	ld hl,(09235h)		;5c2a   ; lee la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld bc,000a0h		;5c2d
	add hl,bc			;5c30
	ex de,hl			;5c31
pinta_numero_de_juego:		; pinta el numero de juego (0xF281)
	ld a,(0f281h)		;5c32   ; lee el codigo del juego
	inc a			;5c35
	ret z			;5c36
	ld hl,05ca1h		;5c37
	push de			;5c3a
	call 0738bh		;5c3b   ; pinta_texto_en: pinta el texto de HL en la VRAM DE
	ld a,(0f281h)		;5c3e   ; lee el codigo del juego
	ld hl,0f2d1h		;5c41
	call byte_a_hex		;5c44   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	pop hl			;5c47
	call 073b5h		;5c48   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	jr z,L_5C5B		;5c4b
	ld bc,00004h		;5c4d
	add hl,bc			;5c50
	ld de,0f2d1h		;5c51
	ex de,hl			;5c54
	ld bc,00002h		;5c55
	jp 0005ch		;5c58   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_5C5B:
	ld a,0ffh		;5c5b
	ld (0f2d3h),a		;5c5d
	ld de,00004h		;5c60
	add hl,de			;5c63
	ex de,hl			;5c64
	ld hl,0f2d1h		;5c65
	call 073abh		;5c68   ; pinta_texto_grafico: pinta el texto en modo grafico
	ld a,(0f122h)		;5c6b   ; lee la pagina activa guardada
	ld (0faf6h),a		;5c6e   ; guarda ACPAGE, la pagina activa
	ret			;5c71

; ----------------------------------------------------------------------
; DATOS resto_5C72: lo apuntan con el banco puesto p00:5C24 (0x5C72), p00:5A1B
;   (0x5C9B), p00:5C37 (0x5CA1); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p00:5C24, p00:5A1B, p00:5C37 (52 bytes)
;   0x5c72..0x5ca6  (52 bytes)
DATA_resto_5C72:
	defb 021h,03ah,040h,040h,04dh,045h,04eh,055h,040h,040h,0feh,02ch,03ah,044h,049h,053h	; 5c72  !:@@MENU@@.,:DIS
	defb 04bh,000h,053h,041h,056h,045h,0feh,04ch,03ah,044h,049h,053h,04bh,000h,04ch,04fh	; 5c82  K.SAVE.L:DISK.LO
	defb 041h,044h,0feh,06ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,052h	; 5c92  AD.l:END.+:K:k:R
	defb 043h,040h,037h,0ffh	; 5ca2

; ======================================================================
; CODIGO 0x5ca6..0x5cbe  (24 bytes)
; ======================================================================


cabecera_screen:		; pinta la cabecera SCREEN
	call 074d6h		;5ca6   ; borra_segun_modo: borra la pantalla segun el modo
	ld hl,05cbeh		;5ca9
	call 0738fh		;5cac   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego		;5caf   ; pinta_juego: pinta 'GAME' y el numero de juego (0xF281) en hexadecimal
cabecera_data:		; pinta la cabecera DATA
	call 074d6h		;5cb2   ; borra_segun_modo: borra la pantalla segun el modo
	ld hl,05ce4h		;5cb5
	call 0738fh		;5cb8   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego		;5cbb   ; pinta_juego: pinta 'GAME' y el numero de juego (0xF281) en hexadecimal

; ----------------------------------------------------------------------
; DATOS resto_5CBE: lo apuntan con el banco puesto p00:5CA9 (0x5CBE), p00:5AB4
;   (0x5CDE), p00:5CB5 (0x5CE4), p00:5B67 (0x5CF6); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p00:5CA9, p00:5AB4,
;   p00:5CB5, p00:5B67 (64 bytes)
;   0x5cbe..0x5cfe  (64 bytes)
DATA_resto_5CBE:
	defb 02ch,03ah,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h,0feh,04ch,03ah	; 5cbe  ,:SCREEN.DATA.L:
	defb 047h,041h,04dh,045h,000h,044h,041h,054h,041h,0feh,06ch,03ah,045h,04eh,044h,0ffh	; 5cce  GAME.DATA.l:END.
	defb 02bh,03ah,04bh,03ah,06bh,03ah,02ch,03ah,047h,041h,04dh,045h,000h,044h,041h,054h	; 5cde  +:K:k:,:GAME.DAT
	defb 041h,0feh,04ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,0abh,03ah	; 5cee  A.L:END.+:K:k:.:

; ======================================================================
; CODIGO 0x5cfe..0x5d10  (18 bytes)
; ======================================================================


pinta_opcion:		; pinta la opcion elegida (0xF10B, nibble alto)
	ld hl,05d10h		;5cfe
	ld a,(0f10bh)		;5d01   ; lee tipo y opcion del menu de disco
	and 0f0h		;5d04
	rrca			;5d06
	rrca			;5d07
	rrca			;5d08
	rrca			;5d09
	dec a			;5d0a
	ld bc,00000h		;5d0b
	jr $+86		;5d0e

; ----------------------------------------------------------------------
; DATOS resto_5D10: lo apuntan con el banco puesto p00:5CFE (0x5D10); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5CFE (70 bytes)
;   0x5d10..0x5d56  (70 bytes)
DATA_resto_5D10:
	defb 01eh,05dh,028h,05dh,000h,000h,000h,000h,000h,000h,046h,05dh,04eh,05dh,044h,049h	; 5d10  .](]......F]N]DI
	defb 053h,04bh,040h,053h,041h,056h,045h,0ffh,044h,049h,053h,04bh,040h,04ch,04fh,041h	; 5d20  SK@SAVE.DISK@LOA
	defb 044h,0ffh,054h,041h,050h,045h,040h,053h,041h,056h,045h,0ffh,054h,041h,050h,045h	; 5d30  D.TAPE@SAVE.TAPE
	defb 040h,04ch,04fh,041h,044h,0ffh,052h,041h,04eh,04bh,049h,04eh,047h,0ffh,050h,052h	; 5d40  @LOAD.RANKING.PR
	defb 049h,04eh,054h,045h,052h,0ffh	; 5d50

; ======================================================================
; CODIGO 0x5d56..0x5d75  (31 bytes)
; ======================================================================


pinta_tipo:		; pinta el tipo elegido (0xF10B, nibble bajo)
	call 0748fh		;5d56   ; borra_ventana: borra la ventana de 0x9237
	ld a,(0f10bh)		;5d59   ; lee tipo y opcion del menu de disco
	and 00fh		;5d5c
	ld hl,05d75h		;5d5e
	ld bc,00040h		;5d61
L_5D64:
	ex de,hl			;5d64
	ld hl,(09235h)		;5d65   ; lee la esquina de la ventana del menu y el byte siguiente (16 bits)
	add hl,bc			;5d68
	ex de,hl			;5d69
	add a,a			;5d6a
	call 07251h		;5d6b   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;5d6e
	inc hl			;5d6f
	ld h,(hl)			;5d70
	ld l,a			;5d71
	jp 0738bh		;5d72   ; pinta_texto_en: pinta el texto de HL en la VRAM DE

; ----------------------------------------------------------------------
; DATOS resto_5D75: lo apuntan con el banco puesto p00:5D5E (0x5D75); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5D5E (37 bytes)
;   0x5d75..0x5d9a  (37 bytes)
DATA_resto_5D75:
	defb 089h,05dh,082h,05dh,07dh,05dh,092h,05dh,047h,041h,04dh,045h,0ffh,053h,043h,052h	; 5d75  .].]}].]GAME.SCR
	defb 045h,045h,04eh,0ffh,048h,049h,000h,053h,043h,04fh,052h,045h,0ffh,052h,041h,04eh	; 5d85  EEN.HI.SCORE.RAN
	defb 04bh,049h,04eh,047h,0ffh	; 5d95

; ======================================================================
; CODIGO 0x5d9a..0x5da4  (10 bytes)
; ======================================================================


texto_search:		; pinta 'SEARCH FILE'
	ld de,(09237h)		;5d9a   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	ld hl,05da4h		;5d9e
	jp 0738bh		;5da1   ; pinta_texto_en: pinta el texto de HL en la VRAM DE

; ----------------------------------------------------------------------
; DATOS resto_5DA4: lo apuntan con el banco puesto p00:5D9E (0x5DA4); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p00:5D9E (12 bytes)
;   0x5da4..0x5db0  (12 bytes)
DATA_resto_5DA4:
	defb 053h,045h,041h,052h,043h,048h,000h,046h,049h,04ch,045h,0ffh	; 5da4  SEARCH.FILE.

; ======================================================================
; CODIGO 0x5db0..0x5dbc  (12 bytes)
; ======================================================================


cabecera_5dbc:		; pinta la cabecera de p00:5DBC
	call 074d6h		;5db0   ; borra_segun_modo: borra la pantalla segun el modo
	ld hl,05dbch		;5db3
	call 0738fh		;5db6   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego		;5db9   ; pinta_juego: pinta 'GAME' y el numero de juego (0xF281) en hexadecimal

; ----------------------------------------------------------------------
; DATOS resto_5DBC: lo apuntan con el banco puesto p00:5DB3 (0x5DBC), p00:5BE0
;   (0x5DDF); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:5DB3, p00:5BE0 (41 bytes)
;   0x5dbc..0x5de5  (41 bytes)
DATA_resto_5DBC:
	defb 02ch,03ah,044h,049h,053h,050h,04ch,041h,059h,000h,044h,041h,054h,041h,0feh,04ch	; 5dbc  ,:DISPLAY.DATA.L
	defb 03ah,043h,048h,041h,04eh,047h,045h,000h,04eh,041h,04dh,045h,0feh,0cch,03ah,045h	; 5dcc  :CHANGE.NAME..:E
	defb 04eh,044h,0ffh,02bh,03ah,04bh,03ah,0cbh,03ah	; 5ddc  ND.+:K:.:

; ======================================================================
; CODIGO 0x5de5..0x5e0d  (40 bytes)
; ======================================================================


L_5DE5:
	ld hl,0f281h		;5de5   ; apunta a el codigo del juego
	ld a,(hl)			;5de8
	ld (hl),0ffh		;5de9
	ld (0f116h),a		;5deb
L_5DEE:
	call ventana_pequena		;5dee   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call 06762h		;5df1   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80
	call 062d3h		;5df4   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	ld hl,05fcfh		;5df7
	call 0738fh		;5dfa   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,06030h		;5dfd
	ld b,005h		;5e00
	call 07676h		;5e02   ; menu_con_esc: menu: espacio elige, ESC sale
	cp 0ffh		;5e05
	jp z,0665eh		;5e07
	call 0737bh		;5e0a   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5E0D: tabla de 5 palabras del despachador (call 0x408D en
;   0x5E0A); lo leen el despachador (10 bytes)
;   0x5e0d..0x5e17  (10 bytes)
DATA_saltos_5E0D:
	defb 01ah,05fh	; 5e0d
	defb 089h,05eh	; 5e0f
	defb 04ah,05eh	; 5e11
	defb 017h,05eh	; 5e13
	defb 098h,05eh	; 5e15

; ======================================================================
; CODIGO 0x5e17..0x5f84  (365 bytes)
; ======================================================================


L_5E17:
	ld a,(0f103h)		;5e17   ; lee el slot del Game Master
	ld h,080h		;5e1a
	call 00024h		;5e1c   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,005h		;5e1f
	ld (08000h),a		;5e21   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5e24
	ld (0a000h),a		;5e25   ; el mapper: pone en 0xA000 el banco de A
	call 08000h		;5e28
	ld a,0c9h		;5e2b
	ld (0fd9fh),a		;5e2d   ; guarda el gancho H.TIMI
	ld a,002h		;5e30
	ld (08000h),a		;5e32   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5e35
	ld (0a000h),a		;5e36   ; el mapper: pone en 0xA000 el banco de A
	ld a,(0f2a0h)		;5e39   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;5e3c
	call 00024h		;5e3e   ; BIOS ENASLT - Switches to specified slot and page definitively
	call pantalla_del_menu		;5e41   ; pantalla_del_menu: borra la VRAM y pone el modo del menu (MSX1 o MSX2)
	call p09_8191_desde_menu		;5e44   ; p09_8191_desde_menu: 1-9-10 con el cartucho en la pagina 2, p09:8191 y vuelta
	jp L_5EAF		;5e47
L_5E4A:
	ld a,(0f103h)		;5e4a   ; lee el slot del Game Master
	ld h,080h		;5e4d
	call 00024h		;5e4f   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,007h		;5e52
	ld (08000h),a		;5e54   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5e57
	ld (0a000h),a		;5e58   ; el mapper: pone en 0xA000 el banco de A
	call 08000h		;5e5b
	ld a,0e0h		;5e5e
	ld hl,03b00h		;5e60
	ld bc,00080h		;5e63
	call 00056h		;5e66   ; BIOS FILVRM - Fills VRAM with value
	ld a,002h		;5e69
	ld (08000h),a		;5e6b   ; el mapper: pone en 0x8000 el banco de A
	inc a			;5e6e
	ld (0a000h),a		;5e6f   ; el mapper: pone en 0xA000 el banco de A
	call 072eah		;5e72   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
	ld a,(0f2a0h)		;5e75   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;5e78
	call 00024h		;5e7a   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0672dh		;5e7d   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 08191h		;5e80
	call 0673fh		;5e83   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	jp L_5DEE		;5e86
L_5E89:
	call 07973h		;5e89   ; menu_principal: el menu del Game Master: engancha H.TIMI y pinta
	call 0672dh		;5e8c   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 08191h		;5e8f
	call 0673fh		;5e92   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	jp L_5DEE		;5e95
L_5E98:
	ld hl,0f298h		;5e98   ; apunta a las opciones del MODIFY
	ld a,(hl)			;5e9b
	or a			;5e9c
	jr nz,L_5EA2		;5e9d
	ld (092cfh),a		;5e9f
L_5EA2:
	ld hl,0f281h		;5ea2   ; apunta a el codigo del juego
	ld a,(0f116h)		;5ea5
	ld (hl),a			;5ea8
	jp 06669h		;5ea9
L_5EAC:
	call pregunta_vuelve		;5eac   ; pregunta_vuelve: pregunta y vuelve al menu
L_5EAF:
	call 072eah		;5eaf   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
	call p09_8191_desde_menu		;5eb2   ; p09_8191_desde_menu: 1-9-10 con el cartucho en la pagina 2, p09:8191 y vuelta
	jp L_5DEE		;5eb5
p09_8191_desde_menu:		; 1-9-10 con el cartucho en la pagina 2, p09:8191 y vuelta
	call 0672dh		;5eb8   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 08191h		;5ebb
	call 0673fh		;5ebe   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	ret			;5ec1
pantalla_del_menu:		; borra la VRAM y pone el modo del menu (MSX1 o MSX2)
	call borra_vram		;5ec2   ; borra_vram: borra la VRAM: 16 KB en MSX1, 64 KB en MSX2 (BIGFIL)
	ld a,(0002dh)		;5ec5   ; la version del MSX (0 = MSX1)
	and a			;5ec8
	jp z,072bch		;5ec9   ; registros_vdp: los 8 registros del VDP de p01:72E2 y, en MSX2, R#23 y R#9
	ld a,(0f103h)		;5ecc   ; lee el slot del Game Master
	ld h,080h		;5ecf
	call 00024h		;5ed1   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 08183h		;5ed4   ; sprites_encendidos: R
	ld a,(0f2a0h)		;5ed7   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;5eda
	call 00024h		;5edc   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,004h		;5edf
	call 0005fh		;5ee1   ; BIOS CHGMOD - Switches to given screen mode
	call 072bch		;5ee4   ; registros_vdp: los 8 registros del VDP de p01:72E2 y, en MSX2, R#23 y R#9
	jp 07275h		;5ee7   ; paleta_msx2: MSX2: los 16 colores de p01:728E
borra_vram:		; borra la VRAM: 16 KB en MSX1, 64 KB en MSX2 (BIGFIL)
	ld hl,00000h		;5eea
	call borra_16k		;5eed   ; borra_16k: BIGFIL de 0x4000 bytes desde HL
	ld a,(0002dh)		;5ef0   ; la version del MSX (0 = MSX1)
	and a			;5ef3
	jp z,00056h		;5ef4   ; BIOS FILVRM - Fills VRAM with value
	ld hl,04000h		;5ef7
	call borra_16k		;5efa   ; borra_16k: BIGFIL de 0x4000 bytes desde HL
	ld hl,08000h		;5efd
	call borra_16k		;5f00   ; borra_16k: BIGFIL de 0x4000 bytes desde HL
	ld hl,0c000h		;5f03
borra_16k:		; BIGFIL de 0x4000 bytes desde HL
	ld bc,04000h		;5f06
	xor a			;5f09
	jp 0016bh		;5f0a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
ventana_pequena:		; las esquinas de una ventana (0x9235, 0x9237)
	ld hl,03921h		;5f0d
	ld (09235h),hl		;5f10   ; guarda la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld hl,0392ch		;5f13
	ld (09237h),hl		;5f16   ; guarda la esquina de la ventana pequena y el byte siguiente (16 bits)
	ret			;5f19
L_5F1A:
	call hay_disco		;5f1a   ; hay_disco: Z si no hay disco: mira si H.PHYD (0xFFA7) es un `ret`
	jp z,L_5DEE		;5f1d
	call 062d3h		;5f20   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	ld a,021h		;5f23
	ld (0f10bh),a		;5f25   ; guarda tipo y opcion del menu de disco
	call 0623bh		;5f28   ; modify_mode: el MODIFY MODE MENU: limpia y pinta (gemela de p02:8BFC)
	call elige_fichero		;5f2b   ; elige_fichero: lista los ficheros del disco y deja elegir uno
	jp c,L_5DEE		;5f2e
	ld hl,052a1h		;5f31
	call ventana		;5f34   ; ventana: abre una ventana de texto con el marco de DE
	call 062d3h		;5f37   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	call borra_vram		;5f3a   ; borra_vram: borra la VRAM: 16 KB en MSX1, 64 KB en MSX2 (BIGFIL)
	call disco_carga_vram		;5f3d   ; disco_carga_vram: carga del disco la VRAM
	jr c,L_5F67		;5f40
	ld a,0ffh		;5f42
	ld (0f112h),a		;5f44   ; guarda hay menu en pantalla
	call pregunta_vuelve		;5f47   ; pregunta_vuelve: pregunta y vuelve al menu
	ld a,006h		;5f4a
	call 00141h		;5f4c   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;5f4f
	jp nz,L_5F5A		;5f51
	call ventana_menu		;5f54   ; ventana_menu: las esquinas de la ventana del menu (0x9235, 0x9237)
	call disco_guarda_vrm		;5f57   ; disco_guarda_vrm: graba un fichero .VRM (la VRAM)
L_5F5A:
	xor a			;5f5a
	ld (0f112h),a		;5f5b   ; guarda hay menu en pantalla
	call pantalla_del_menu		;5f5e   ; pantalla_del_menu: borra la VRAM y pone el modo del menu (MSX1 o MSX2)
	call p09_8191_desde_menu		;5f61   ; p09_8191_desde_menu: 1-9-10 con el cartucho en la pagina 2, p09:8191 y vuelta
	jp L_5EAF		;5f64
L_5F67:
	call pantalla_del_menu		;5f67   ; pantalla_del_menu: borra la VRAM y pone el modo del menu (MSX1 o MSX2)
	call p09_8191_desde_menu		;5f6a   ; p09_8191_desde_menu: 1-9-10 con el cartucho en la pagina 2, p09:8191 y vuelta
	jp L_5DEE		;5f6d
pregunta_vuelve:		; pregunta y vuelve al menu
	call 0749eh		;5f70   ; p02_8000: p02:8000 con el cartucho en la pagina 2 y vuelta a la RAM
	ld hl,05f96h		;5f73
	call 0738fh		;5f76   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,05fcbh		;5f79
	ld b,002h		;5f7c
	call 07690h		;5f7e   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	call 0737bh		;5f81   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_5F84: tabla de 2 palabras del despachador (call 0x408D en
;   0x5F81); lo leen el despachador (4 bytes)
;   0x5f84..0x5f88  (4 bytes)
DATA_saltos_5F84:
	defb 088h,05fh	; 5f84
	defb 093h,05fh	; 5f86

; ======================================================================
; CODIGO 0x5f88..0x5f96  (14 bytes)
; ======================================================================


L_5F88:
	call 074bfh		;5f88   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call 00156h		;5f8b   ; BIOS KILBUF - Clears keyboard buffer
	call 0009fh		;5f8e   ; BIOS CHGET - One character input (waiting)
	jr $-33		;5f91
L_5F93:
	jp 074bfh		;5f93   ; p02_80e4: p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM

; ----------------------------------------------------------------------
; DATOS resto_5F96: lo apuntan con el banco puesto p00:5F73 (0x5F96), p00:5F79
;   (0x5FCB), p00:5DF7 (0x5FCF); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p00:5F73, p00:5F79, p00:5DF7 (106 bytes)
;   0x5f96..0x6000  (106 bytes)
DATA_resto_5F96:
	defb 026h,03ah,040h,040h,053h,043h,052h,045h,045h,04eh,000h,044h,049h,053h,050h,04ch	; 5f96  &:@@SCREEN.DISPL
	defb 041h,059h,000h,04dh,04fh,044h,045h,040h,040h,0feh,067h,03ah,044h,049h,053h,050h	; 5fa6  AY.MODE@@.g:DISP
	defb 04ch,041h,059h,000h,041h,04ch,04ch,000h,053h,043h,052h,045h,045h,04eh,0feh,087h	; 5fb6  LAY.ALL.SCREEN..
	defb 03ah,045h,04eh,044h,0ffh,066h,03ah,086h,03ah,0c6h,038h,040h,040h,053h,045h,04ch	; 5fc6  :END.f:.:.8@@SEL
	defb 046h,000h,04dh,04fh,044h,045h,000h,04dh,045h,04eh,055h,040h,040h,0feh,027h,039h	; 5fd6  F.MODE.MENU@@.'9
	defb 04ch,04fh,041h,044h,000h,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h	; 5fe6  LOAD.SCREEN.DATA
	defb 0feh,067h,039h,053h,052h,041h,04dh,000h,044h,049h	; 5ff6  .g9SRAM.DI
