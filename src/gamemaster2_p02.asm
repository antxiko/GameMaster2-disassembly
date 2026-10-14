; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 02 (se ejecuta en 0x8000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x08000


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l9000h:	equ 0x09000

; ======================================================================
; CODIGO 0x8000..0x8170  (368 bytes)
; ======================================================================


guarda_pantalla:		; guarda la pantalla del juego antes del menu (segun el modo de 0xF3DF/0xF3E0)
	ld hl,0f11ah		;8000
	ld a,(hl)			;8003
	or a			;8004
	ret nz			;8005
	dec a			;8006
	ld (hl),a			;8007
	ld a,(0f29fh)		;8008   ; lee el slot de la RAM de la pagina 1
	ld h,040h		;800b
	call 00024h		;800d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f3dfh)		;8010   ; lee los registros del VDP (copia de la BIOS)
	and 00eh		;8013
	ld l,a			;8015
	ld a,(0f3e0h)		;8016   ; lee el registro 1 del VDP (copia de la BIOS)
	and 018h		;8019
	ld h,a			;801b
	ld (0f2a1h),hl		;801c   ; guarda el modo de pantalla guardado y el byte siguiente (16 bits)
	ld de,00006h		;801f
	rst 20h			;8022   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_806F		;8023
	ld de,00002h		;8026
	rst 20h			;8029   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_8064		;802a
	ld de,00004h		;802d
	rst 20h			;8030   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_8064		;8031
	ld hl,0f3dfh		;8034   ; apunta a los registros del VDP (copia de la BIOS)
	ld de,06020h		;8037
	ld bc,00008h		;803a
	ldir		;803d
	call registros_vdp_menu		;803f   ; registros_vdp_menu: los 8 registros del VDP de p02:8170
	ld de,06000h		;8042
	ld hl,00000h		;8045
	ld bc,00008h		;8048
	call 00059h		;804b   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,06008h		;804e
	ld hl,00800h		;8051
	ld bc,00008h		;8054
	call 00059h		;8057   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,00000h		;805a
	ld bc,00008h		;805d
	xor a			;8060
	call 00056h		;8061   ; BIOS FILVRM - Fills VRAM with value
L_8064:
	ld a,(0f103h)		;8064   ; lee el slot del Game Master
	ld h,040h		;8067
	call 00024h		;8069   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp 077c3h		;806c
L_806F:
	call sprites_apagados		;806f   ; sprites_apagados: R#8 con el bit 1: sin sprites
	call vram_pagina		;8072   ; vram_pagina: H y el puerto de datos del VDP para la pagina de VRAM que se ve (0xF3E1)
	call lee_vram_128k		;8075   ; lee_vram_128k: lee BC bytes de la VRAM HL (128 KB) a DE
	ld a,(0f103h)		;8078   ; lee el slot del Game Master
	ld h,040h		;807b
	call 00024h		;807d   ; BIOS ENASLT - Switches to specified slot and page definitively
L_8080:
	call vram_pagina		;8080   ; vram_pagina: H y el puerto de datos del VDP para la pagina de VRAM que se ve (0xF3E1)
	call 00171h		;8083   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_8086:
	xor a			;8086   ; rellena con 0
	exx			;8087   ; C' = el puerto de datos del VDP
	out (c),a		;8088   ; un byte a la VRAM
	exx			;808a
	inc hl			;808b   ; la direccion siguiente
	ld a,h			;808c   ; cada 32 KB...
	and 07fh		;808d
	or l			;808f
	call z,vram_alta_escribe		;8090   ; ...cambia de mitad
	dec bc			;8093   ; BC bytes
	ld a,c			;8094
	or b			;8095
	jr nz,L_8086		;8096
	ret			;8098
vram_alta_escribe:		; H xor 0x80 y NSTWRT: la otra mitad de los 128 KB de VRAM
	ld a,h			;8099
	xor 080h		;809a
	ld h,a			;809c
	jp 00171h		;809d   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
vram_pagina:		; H y el puerto de datos del VDP para la pagina de VRAM que se ve (0xF3E1)
	exx			;80a0
	ld a,(00006h)		;80a1   ; el puerto de lectura del VDP (VDP.DR)
	ld c,a			;80a4
	exx			;80a5
	ld a,(0f3e1h)		;80a6   ; lee el registro 2 del VDP (copia de la BIOS)
	ld hl,00000h		;80a9
	and 040h		;80ac
	jr z,L_80B2		;80ae
	ld h,080h		;80b0
L_80B2:
	ld a,(0fff6h)		;80b2   ; lee el registro 14 del VDP (copia de la BIOS)
	add a,080h		;80b5
	ld e,000h		;80b7
	ld d,a			;80b9
	srl d		;80ba
	rr e		;80bc
	add hl,de			;80be
	ld de,06000h		;80bf
	ld bc,02000h		;80c2
	ret			;80c5
lee_vram_128k:		; lee BC bytes de la VRAM HL (128 KB) a DE
	call 0016eh		;80c6   ; BIOS NSETRD - Same function as SETRD (with 16-bit VRAM-address)
L_80C9:
	exx			;80c9   ; C' = el puerto de datos del VDP
	in a,(c)		;80ca   ; un byte de la VRAM...
	exx			;80cc
	ld (de),a			;80cd   ; ...a DE
	inc de			;80ce
	inc hl			;80cf   ; la direccion siguiente
	ld a,h			;80d0   ; cada 32 KB...
	and 07fh		;80d1
	or l			;80d3
	call z,vram_alta_lee		;80d4   ; ...cambia de mitad
	dec bc			;80d7   ; BC bytes
	ld a,c			;80d8
	or b			;80d9
	jr nz,L_80C9		;80da
	ret			;80dc
vram_alta_lee:		; H xor 0x80 y NSETRD
	ld a,h			;80dd
	xor 080h		;80de
	ld h,a			;80e0
	jp 0016eh		;80e1   ; BIOS NSETRD - Same function as SETRD (with 16-bit VRAM-address)
L_80E4:
	ld hl,0f11ah		;80e4
	ld a,(hl)			;80e7
	or a			;80e8
	ret z			;80e9
	xor a			;80ea
	ld (hl),a			;80eb
	ld a,(0f29fh)		;80ec   ; lee el slot de la RAM de la pagina 1
	ld h,040h		;80ef
	call 00024h		;80f1   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(0f2a1h)		;80f4   ; lee el modo de pantalla guardado y el byte siguiente (16 bits)
	ld de,00006h		;80f7
	rst 20h			;80fa   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_8132		;80fb
	ld de,00002h		;80fe
	rst 20h			;8101   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_8127		;8102
	ld de,00004h		;8105
	rst 20h			;8108   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,L_8127		;8109
	call registros_vdp_6020		;810c   ; registros_vdp_6020: los registros del VDP de p01:6020
	ld hl,06000h		;810f
	ld de,00000h		;8112
	ld bc,00008h		;8115
	call 0005ch		;8118   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,06008h		;811b
	ld de,00800h		;811e
	ld bc,00008h		;8121
	call 0005ch		;8124   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_8127:
	ld a,(0f103h)		;8127   ; lee el slot del Game Master
	ld h,040h		;812a
	call 00024h		;812c   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp 07847h		;812f
L_8132:
	call vram_pagina		;8132   ; vram_pagina: H y el puerto de datos del VDP para la pagina de VRAM que se ve (0xF3E1)
	call escribe_vram_128k		;8135   ; escribe_vram_128k: escribe BC bytes de DE en la VRAM HL (128 KB)
	ld a,(0f103h)		;8138   ; lee el slot del Game Master
	ld h,040h		;813b
	call 00024h		;813d   ; BIOS ENASLT - Switches to specified slot and page definitively
	jp sprites_encendidos		;8140   ; sprites_encendidos: R
escribe_vram_128k:		; escribe BC bytes de DE en la VRAM HL (128 KB)
	call 00171h		;8143   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
L_8146:
	ld a,(de)			;8146   ; un byte de DE...
	exx			;8147
	out (c),a		;8148   ; ...a la VRAM
	exx			;814a
	inc de			;814b
	inc hl			;814c   ; la direccion siguiente
	ld a,h			;814d   ; cada 32 KB...
	and 07fh		;814e
	or l			;8150
	call z,vram_alta_escribe		;8151   ; ...cambia de mitad
	dec bc			;8154   ; BC bytes
	ld a,c			;8155
	or b			;8156
	jr nz,L_8146		;8157
	ret			;8159
registros_vdp_6020:		; los registros del VDP de p01:6020
	ld hl,06020h		;815a
	jr L_8162		;815d
registros_vdp_menu:		; los 8 registros del VDP de p02:8170
	ld hl,08170h		;815f
L_8162:
	ld bc,00800h		;8162
L_8165:
	push bc			;8165
	ld b,(hl)			;8166
	call 00047h		;8167   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;816a
	inc hl			;816b
	inc c			;816c
	djnz L_8165		;816d
	ret			;816f

; ----------------------------------------------------------------------
; DATOS resto_8170: lo apuntan con el banco puesto p02:815F (0x8170); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:815F (8 bytes)
;   0x8170..0x8178  (8 bytes)
DATA_resto_8170:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 8170  .....v..

; ======================================================================
; CODIGO 0x8178..0x818e  (22 bytes)
; ======================================================================


sprites_apagados:		; R#8 con el bit 1: sin sprites
	ld a,(0ffe7h)		;8178   ; lee el registro 8 del VDP (copia de la BIOS)
	or 002h		;817b
	ld b,a			;817d
	ld c,008h		;817e
	jp 00047h		;8180   ; BIOS WRTVDP - Writes data in the VDP-register
sprites_encendidos:		; R
	ld a,(0ffe7h)		;8183   ; lee el registro 8 del VDP (copia de la BIOS)
	and 0fdh		;8186
	ld b,a			;8188
	ld c,008h		;8189
	jp 00047h		;818b   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; DATOS relleno_818E: 370 bytes a 0xFF en mitad del banco, sin ninguna
;   instruccion que apunte dentro: relleno; lo leen nadie (370 bytes)
;   0x818e..0x8300  (370 bytes)
DATA_relleno_818E:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 818e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 819e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ae  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81be  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ce  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81de  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81ee  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 81fe  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 820e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 821e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 822e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 823e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 824e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 825e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 826e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 827e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 828e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 829e  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ae  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82be  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ce  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82de  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 82ee  ................
	defb 0ffh,0ffh	; 82fe

; ======================================================================
; CODIGO 0x8300..0x84a7  (423 bytes)
; ======================================================================


L_8300:
	jp L_8309		;8300
L_8303:
	jp L_8315		;8303
L_8306:
	jp L_832C		;8306
L_8309:
	di			;8309
	ld hl,0e280h		;830a
	ld de,0c000h		;830d
	ld bc,01100h		;8310
	ldir		;8313
L_8315:
	di			;8315
	ld sp,0df80h		;8316
	call salta_a_da00		;8319   ; salta_a_da00: copia p02:83BA a 0xDA00 (0xCD bytes) y salta alli
	jp nc,L_835A		;831c
	ld hl,04002h		;831f
	call lee_palabra_del_juego		;8322   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	jp z,L_835A		;8325
	ex de,hl			;8328
	ld (0d132h),hl		;8329   ; guarda la direccion INIT del juego (copia) y el byte siguiente (16 bits)
L_832C:
	ld a,003h		;832c
	ld (0fcafh),a		;832e   ; guarda SCRMOD, el modo de pantalla
	ld hl,0f100h		;8331   ; apunta a volumen del PSG, canal A
	ld de,0d500h		;8334
	ld bc,00314h		;8337
	ldir		;833a
	call engancha_al_juego_b		;833c   ; engancha_al_juego_b: copia p02:8D98 a 0xD814 y busca en el INIT del juego el ld (0xFD9B),hl
	jp nz,L_835A		;833f
	call copia_d170		;8342   ; copia_d170: copia p02:8DE5 a 0xD170 (0x18E bytes): el codigo que corre con el juego
	call 0a24fh		;8345
	ld a,007h		;8348
	call 00141h		;834a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 004h		;834d
	jr z,L_8364		;834f
	ld hl,0d13ch		;8351   ; apunta a la opcion elegida
	ld a,(hl)			;8354
	or a			;8355
	jr nz,L_8364		;8356
	dec a			;8358
	ld (hl),a			;8359
L_835A:
	xor a			;835a
	ld (0d129h),a		;835b   ; guarda el tipo de fichero elegido
	ld (0d13dh),a		;835e
	jp L_9929		;8361
L_8364:
	di			;8364   ; vuelve al juego: sin interrupciones
	ld a,0ffh		;8365   ; 0xD13D = 0xFF
	ld (0d13dh),a		;8367
	xor a			;836a   ; borra 0xD33A y 0xD13B
	ld (0d33ah),a		;836b
	ld (0d13bh),a		;836e
	ld hl,0d4f0h		;8371   ; devuelve el gancho H.TIMI del juego (5 bytes guardados en 0xD4F0)
	ld de,0fd9fh		;8374   ; apunta a el gancho H.TIMI
	ld bc,00005h		;8377
	ldir		;837a
	jp 0d83bh		;837c   ; y sigue en 0xD83B (p02:8DBF, en RAM)
mi_slot:		; A = el slot de la pagina 1 (RSLREG y EXPTBL): el del propio cartucho (gemela de p00:5752)
	call 00138h		;837f   ; BIOS RSLREG - Reads the primary slot register
	rrca			;8382
	rrca			;8383
	and 003h		;8384
	ld c,a			;8386
	ld b,000h		;8387
	ld hl,0fcc1h		;8389   ; apunta a EXPTBL, que slots estan expandidos
	add hl,bc			;838c
	or (hl)			;838d
	ld c,a			;838e
	inc hl			;838f
	inc hl			;8390
	inc hl			;8391
	inc hl			;8392
	ld a,(hl)			;8393
	and 00ch		;8394
	or c			;8396
	ret			;8397
lee_palabra_del_juego:		; DE = la palabra HL del cartucho del juego (RDSLT en 0xF104) (gemela de p00:576B)
	ld a,(0d12fh)		;8398   ; lee el slot del cartucho del juego (copia)
	ld c,a			;839b
lee_palabra_slot:		; DE = la palabra HL del slot C (RDSLT) (gemela de p00:576F)
	call lee_byte_slot		;839c   ; lee_byte_slot: D = el byte HL del slot C (RDSLT), y avanza HL
	ld e,d			;839f
lee_byte_slot:		; D = el byte HL del slot C (RDSLT), y avanza HL (gemela de p00:5773)
	ld a,c			;83a0
	push bc			;83a1
	push de			;83a2
	call 0000ch		;83a3   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;83a6
	pop bc			;83a7
	ld d,a			;83a8
	or e			;83a9
	inc hl			;83aa
	ret			;83ab
salta_a_da00:		; copia p02:83BA a 0xDA00 (0xCD bytes) y salta alli
	ld hl,L_83BA		;83ac
	ld de,0da00h		;83af
	ld bc,000cdh		;83b2
	ldir		;83b5
	jp 0da00h		;83b7
L_83BA:
	ld bc,00400h		;83ba
	ld hl,0fcc1h		;83bd   ; apunta a EXPTBL, que slots estan expandidos
L_83C0:
	push bc			;83c0   ; recorre los 4 slots primarios
	push hl			;83c1
	ld a,(hl)			;83c2   ; el byte de EXPTBL de ese slot
	bit 7,a		;83c3   ; bit 7: el slot esta expandido
	jr nz,L_83E4		;83c5
	ld b,c			;83c7   ; B = el slot
	call 0dabdh		;83c8
	jr z,L_83D1		;83cb
	ld a,c			;83cd   ; el slot en A
	call 0da46h		;83ce
L_83D1:
	pop hl			;83d1
	pop bc			;83d2
	jr c,L_83D9		;83d3   ; encontrado: sale
	inc hl			;83d5   ; el slot siguiente
	inc c			;83d6
	djnz L_83C0		;83d7   ; los 4 slots primarios
L_83D9:
	push af			;83d9
	ld a,(0d12eh)		;83da   ; lee el slot del Game Master (copia)
	ld h,040h		;83dd
	call 00024h		;83df   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;83e2
	ret			;83e3
L_83E4:
	call 0da2fh		;83e4
	jr L_83D1		;83e7
L_83E9:
	and 080h		;83e9
	or c			;83eb
	ld b,004h		;83ec
L_83EE:
	push bc			;83ee   ; un subslot
	ld b,a			;83ef   ; B = el subslot
	call 0dabdh		;83f0
	jr z,L_83F9		;83f3
	ld a,b			;83f5
	call 0da46h		;83f6
L_83F9:
	pop bc			;83f9
	ret c			;83fa
	add a,004h		;83fb
	djnz L_83EE		;83fd
	ret			;83ff
L_8400:
	push af			;8400
	ld h,040h		;8401
	call 00024h		;8403   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(04000h)		;8406
	ld de,04241h		;8409
	rst 20h			;840c   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nz,L_846E		;840d
	ld hl,(04002h)		;840f
	ld bc,00100h		;8412
L_8415:
	ld a,09bh		;8415
	cpir		;8417
	jr nz,L_846E		;8419
	jp po,0dab4h		;841b
	ld a,0fdh		;841e
	cp (hl)			;8420
	jr nz,L_8415		;8421
	ld hl,(04010h)		;8423
	ld de,04241h		;8426
	rst 20h			;8429   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_8471		;842a
	ld de,04443h		;842c
	rst 20h			;842f   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_8471		;8430
	ld de,04645h		;8432
	rst 20h			;8435   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_8471		;8436
	ld de,00000h		;8438
	ld hl,05000h		;843b
	ld b,000h		;843e
L_8440:
	ld a,(hl)			;8440
	add a,e			;8441
	ld e,a			;8442
	jr nc,L_8446		;8443
	inc d			;8445
L_8446:
	inc hl			;8446
	djnz L_8440		;8447
	push de			;8449
	ld a,(0d12eh)		;844a   ; lee el slot del Game Master (copia)
	ld h,040h		;844d
	call 00024h		;844f   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop de			;8452
	ld ix,044beh		;8453
L_8457:
	ld l,(ix+000h)		;8457
	ld h,(ix+001h)		;845a
	ld a,l			;845d   ; ...0 acaba la tabla
	or h			;845e
	jr z,L_846E		;845f
	rst 20h			;8461   ; ¿es la del juego?
	jr z,L_8471		;8462   ; si: la ficha
	inc ix		;8464   ; la entrada siguiente, de 4 bytes
	inc ix		;8466
	inc ix		;8468
	inc ix		;846a
	jr L_8457		;846c
L_846E:
	pop af			;846e
	and a			;846f
	ret			;8470
L_8471:
	pop af			;8471
	ld (0d12fh),a		;8472   ; guarda el slot del cartucho del juego (copia)
	scf			;8475
	ret			;8476
L_8477:
	ld a,(0d12eh)		;8477   ; lee el slot del Game Master (copia)
	bit 7,a		;847a
	jr nz,L_8485		;847c
	bit 7,b		;847e
	ret nz			;8480
	sub b			;8481
	and 003h		;8482
	ret			;8484
L_8485:
	cp b			;8485
	ret			;8486
L_8487:
	call ventana_menu		;8487   ; ventana_menu: las esquinas de la ventana del menu (0x9235, 0x9237)
L_848A:
	call 0a578h		;848a
L_848D:
	call cabecera_menu_b		;848d   ; cabecera_menu_b: pinta la cabecera del menu con el juego puesto
	ld hl,08691h		;8490
	ld b,003h		;8493
	call 0a7b2h		;8495   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	ld b,a			;8498
	ld hl,084adh		;8499
	call 0a3e6h		;849c   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;849f
	ld (0d136h),a		;84a0   ; guarda tipo y opcion del menu de disco
	ld a,b			;84a3
	call 0a510h		;84a4   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_84A7: tabla de 3 palabras del despachador (call 0x408D en
;   0x84A4); lo leen el despachador (6 bytes)
;   0x84a7..0x84ad  (6 bytes)
DATA_saltos_84A7:
	defb 0bdh,084h	; 84a7
	defb 06dh,085h	; 84a9
	defb 01bh,086h	; 84ab

; ----------------------------------------------------------------------
; DATOS resto_84AD: lo apuntan con el banco puesto p02:8499 (0x84AD); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8499 (3 bytes)
;   0x84ad..0x84b0  (3 bytes)
DATA_resto_84AD:
	defb 010h,020h,000h	; 84ad

; ======================================================================
; CODIGO 0x84b0..0x84e0  (48 bytes)
; ======================================================================


ventana_menu:		; las esquinas de la ventana del menu (0x9235, 0x9237) (gemela de p00:5A3B)
	ld hl,03a21h		;84b0
	ld (0d16ch),hl		;84b3   ; guarda la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld hl,03a2ch		;84b6
	ld (0d16eh),hl		;84b9   ; guarda la esquina de la ventana pequena y el byte siguiente (16 bits)
	ret			;84bc
L_84BD:
	call hay_disco_b		;84bd   ; hay_disco_b: Z si no hay disco (H.PHYD = ret) y 0xD4F9 no lo fuerza
	jr z,$-51		;84c0
	ld hl,09644h		;84c2
	call ventana_b		;84c5   ; ventana_b: abre una ventana de texto con el marco de DE
	call cabecera_screen_b		;84c8   ; cabecera_screen_b: pinta la cabecera SCREEN DATA / GAME DATA
	call pinta_opcion_b		;84cb   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	ld hl,086d4h		;84ce
	ld b,003h		;84d1
	call 0a7b2h		;84d3   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	ld b,a			;84d6
	add a,011h		;84d7
	ld (0d136h),a		;84d9   ; guarda tipo y opcion del menu de disco
	ld a,b			;84dc
	call 0a510h		;84dd   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_84E0: tabla de 3 palabras del despachador (call 0x408D en
;   0x84DD); lo leen el despachador (6 bytes)
;   0x84e0..0x84e6  (6 bytes)
DATA_saltos_84E0:
	defb 0f5h,084h	; 84e0
	defb 0e6h,084h	; 84e2
	defb 08dh,084h	; 84e4

; ======================================================================
; CODIGO 0x84e6..0x854c  (102 bytes)
; ======================================================================


L_84E6:
	call pregunta_si_b		;84e6   ; pregunta_si_b: pinta la pregunta y espera la respuesta
	jp z,L_84BD		;84e9
	call 0a5efh		;84ec
	call disco_guarda_pantalla		;84ef   ; disco_guarda_pantalla: SCREEN DATA: graba la RAM y la pantalla
	jp L_848A		;84f2
L_84F5:
	call pregunta_si_b		;84f5   ; pregunta_si_b: pinta la pregunta y espera la respuesta
	jp z,L_84BD		;84f8
	call 0a5efh		;84fb
	call disco_guarda_partida_b		;84fe   ; disco_guarda_partida_b: GAME DATA: graba la RAM del juego (crea, escribe, cierra)
	jp L_848A		;8501
L_8504:
	ld hl,(0d30ch)		;8504
	ld a,h			;8507
	or l			;8508
	jp z,L_84BD		;8509
	call pregunta_si_b		;850c   ; pregunta_si_b: pinta la pregunta y espera la respuesta
	jp z,L_84BD		;850f
	call 0a5efh		;8512
	call disco_guarda_bloque_b		;8515   ; disco_guarda_bloque_b: graba el bloque de 0xD30C en disco
	jp L_848A		;8518
L_851B:
	ld a,(0d332h)		;851b
	or a			;851e
	jp z,L_84BD		;851f
	call pregunta_si_b		;8522   ; pregunta_si_b: pinta la pregunta y espera la respuesta
	jp z,L_84BD		;8525
	call 0a5efh		;8528
	call disco_guarda_ranking_b		;852b   ; disco_guarda_ranking_b: graba el ranking en disco
	jp L_848A		;852e
pregunta_si_b:		; pinta la pregunta y espera la respuesta
	call pinta_tipo		;8531   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call texto_854c		;8534   ; texto_854c: pinta el texto de p02:854C
	ld hl,03a6ch		;8537
	jp L_93E8		;853a
texto_854c:		; pinta el texto de p02:854C
	ld hl,0854ch		;853d
	jr L_8545		;8540
texto_855c:		; pinta el texto de p02:855C
	ld hl,0855ch		;8542
L_8545:
	ld de,(0d16eh)		;8545   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	jp 0a520h		;8549

; ----------------------------------------------------------------------
; DATOS resto_854C: lo apuntan con el banco puesto p02:853D (0x854C), p02:8542
;   (0x855C); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:853D, p02:8542 (33 bytes)
;   0x854c..0x856d  (33 bytes)
DATA_resto_854C:
	defb 049h,04eh,050h,055h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h,0ffh	; 854c  INPUT.FILE.NAME.
	defb 053h,045h,04ch,045h,043h,054h,000h,046h,049h,04ch,045h,000h,04eh,041h,04dh,045h	; 855c  SELECT.FILE.NAME
	defb 0ffh	; 856c

; ======================================================================
; CODIGO 0x856d..0x8590  (35 bytes)
; ======================================================================


L_856D:
	call hay_disco_b		;856d   ; hay_disco_b: Z si no hay disco (H.PHYD = ret) y 0xD4F9 no lo fuerza
	jp z,L_848D		;8570
	call cabecera_86de		;8573   ; cabecera_86de: pinta la cabecera de p02:86DE
	call pinta_opcion_b		;8576   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	ld hl,086f0h		;8579
	ld b,002h		;857c
	call 0a7b2h		;857e   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	ld b,a			;8581
	ld hl,08594h		;8582
	call 0a3e6h		;8585   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8588
	ld (0d136h),a		;8589   ; guarda tipo y opcion del menu de disco
	ld a,b			;858c
	call 0a510h		;858d   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8590: tabla de 2 palabras del despachador (call 0x408D en
;   0x858D); lo leen el despachador (4 bytes)
;   0x8590..0x8594  (4 bytes)
DATA_saltos_8590:
	defb 096h,085h	; 8590
	defb 08dh,084h	; 8592

; ----------------------------------------------------------------------
; DATOS resto_8594: lo apuntan con el banco puesto p02:8582 (0x8594); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8582 (2 bytes)
;   0x8594..0x8596  (2 bytes)
DATA_resto_8594:
	defb 022h,000h	; 8594

; ======================================================================
; CODIGO 0x8596..0x85fd  (103 bytes)
; ======================================================================


L_8596:
	call pide_fichero_b		;8596   ; pide_fichero_b: abre la ventana de los ficheros y deja elegir
	jr c,$-44		;8599
	call 0a5efh		;859b
	call disco_carga_partida_b		;859e   ; disco_carga_partida_b: carga GAME DATA del disco
	jp L_848A		;85a1
L_85A4:
	ld hl,(0d30ch)		;85a4
	ld a,h			;85a7
	or l			;85a8
	jp z,L_856D		;85a9
	call pide_fichero_b		;85ac   ; pide_fichero_b: abre la ventana de los ficheros y deja elegir
	jr c,$-66		;85af
	call 0a5efh		;85b1
	call disco_carga_bloque_b		;85b4   ; disco_carga_bloque_b: carga el bloque de 0xD30C del disco
	jp L_848A		;85b7
L_85BA:
	ld a,(0d332h)		;85ba
	or a			;85bd
	jp z,L_856D		;85be
	call pide_fichero_b		;85c1   ; pide_fichero_b: abre la ventana de los ficheros y deja elegir
	jr c,$-87		;85c4
	call 0a5efh		;85c6
	call disco_carga_ranking_b		;85c9   ; disco_carga_ranking_b: carga el ranking del disco
	jp L_848A		;85cc
pide_fichero_b:		; abre la ventana de los ficheros y deja elegir
	ld hl,0965dh		;85cf
	call ventana_b		;85d2   ; ventana_b: abre una ventana de texto con el marco de DE
	call pinta_tipo		;85d5   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call texto_search_b		;85d8   ; texto_search_b: pinta 'SEARCH FILE'
	call pide_nombre_fichero		;85db   ; pide_nombre_fichero: lee el nombre del fichero letra a letra
	ret c			;85de
	ld hl,09644h		;85df
	jp ventana_b		;85e2   ; ventana_b: abre una ventana de texto con el marco de DE
L_85E5:
	ld a,(0d332h)		;85e5
	or a			;85e8
	jp z,L_848D		;85e9
	call cabecera_87a2		;85ec   ; cabecera_87a2: pinta la cabecera de p02:87A2
	call pinta_opcion_b		;85ef   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	ld hl,087c5h		;85f2
	ld b,003h		;85f5
	call 0a7b2h		;85f7   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	call 0a510h		;85fa   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_85FD: tabla de 3 palabras del despachador (call 0x408D en
;   0x85FA); lo leen el despachador (6 bytes)
;   0x85fd..0x8603  (6 bytes)
DATA_saltos_85FD:
	defb 012h,086h	; 85fd
	defb 003h,086h	; 85ff
	defb 08dh,084h	; 8601

; ======================================================================
; CODIGO 0x8603..0x8668  (101 bytes)
; ======================================================================


L_8603:
	call 0a655h		;8603   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	call pinta_juego_b		;8606   ; pinta_juego_b: pinta el numero de juego (0xD301) en hexadecimal
	call pinta_opcion_b		;8609   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	call menu_ranking_b		;860c   ; menu_ranking_b: la pantalla del RANKING con el juego puesto
	jp L_848D		;860f
L_8612:
	call ranking_entra		;8612   ; ranking_entra: mete la puntuacion en el ranking (gemela de p01:69AD)
	call ranking_nombre		;8615   ; ranking_nombre: pide el nombre para el ranking (gemela de p01:6AA0)
	jp L_848D		;8618
L_861B:
	call 0a5efh		;861b
	xor a			;861e
	ld (0d135h),a		;861f
	ld (0d136h),a		;8622   ; guarda tipo y opcion del menu de disco
	ld a,006h		;8625
	call 00141h		;8627   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;862a
	ret nz			;862c
	ld (0d13ch),a		;862d   ; guarda la opcion elegida
	jp L_997E		;8630
cabecera_menu_b:		; pinta la cabecera del menu con el juego puesto
	call 0a655h		;8633   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld hl,08668h		;8636
	call 0a524h		;8639   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
pinta_juego_b:		; pinta el numero de juego (0xD301) en hexadecimal
	ld hl,(0d16ch)		;863c   ; lee la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld bc,000a0h		;863f
	add hl,bc			;8642
	ex de,hl			;8643
pinta_numero_de_juego_b:		; pinta el numero de juego (0xD301)
	ld a,(0d301h)		;8644   ; lee el codigo del juego (copia)
	inc a			;8647
	ret z			;8648
	ld hl,08697h		;8649
	push de			;864c
	call 0a520h		;864d
	ld a,(0d301h)		;8650   ; lee el codigo del juego (copia)
	ld hl,0da00h		;8653
	call byte_a_hex		;8656   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	pop hl			;8659
	ld bc,00004h		;865a
	add hl,bc			;865d
	ld de,0da00h		;865e
	ex de,hl			;8661
	ld bc,00002h		;8662
	jp 0005ch		;8665   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS resto_8668: lo apuntan con el banco puesto p02:8636 (0x8668), p02:8490
;   (0x8691), p02:8649 (0x8697); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p02:8636, p02:8490, p02:8649 (52 bytes)
;   0x8668..0x869c  (52 bytes)
DATA_resto_8668:
	defb 021h,03ah,040h,040h,04dh,045h,04eh,055h,040h,040h,0feh,02ch,03ah,044h,049h,053h	; 8668  !:@@MENU@@.,:DIS
	defb 04bh,000h,053h,041h,056h,045h,0feh,04ch,03ah,044h,049h,053h,04bh,000h,04ch,04fh	; 8678  K.SAVE.L:DISK.LO
	defb 041h,044h,0feh,06ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah,06bh,03ah,052h	; 8688  AD.l:END.+:K:k:R
	defb 043h,040h,037h,0ffh	; 8698

; ======================================================================
; CODIGO 0x869c..0x86b4  (24 bytes)
; ======================================================================


cabecera_screen_b:		; pinta la cabecera SCREEN DATA / GAME DATA
	call 0a655h		;869c   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld hl,086b4h		;869f
	call 0a524h		;86a2   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego_b		;86a5   ; pinta_juego_b: pinta el numero de juego (0xD301) en hexadecimal
cabecera_86de:		; pinta la cabecera de p02:86DE
	call 0a655h		;86a8   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld hl,086deh		;86ab
	call 0a524h		;86ae   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego_b		;86b1   ; pinta_juego_b: pinta el numero de juego (0xD301) en hexadecimal

; ----------------------------------------------------------------------
; DATOS resto_86B4: lo apuntan con el banco puesto p02:869F (0x86B4), p02:84CE
;   (0x86D4), p02:86AB (0x86DE), p02:8579 (0x86F0); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p02:869F, p02:84CE,
;   p02:86AB, p02:8579 (68 bytes)
;   0x86b4..0x86f8  (68 bytes)
DATA_resto_86B4:
	defb 02ch,03ah,053h,043h,052h,045h,045h,04eh,000h,044h,041h,054h,041h,0feh,04ch,03ah	; 86b4  ,:SCREEN.DATA.L:
	defb 047h,041h,04dh,045h,000h,044h,041h,054h,041h,0feh,06ch,03ah,045h,04eh,044h,0ffh	; 86c4  GAME.DATA.l:END.
	defb 02bh,03ah,04bh,03ah,06bh,03ah,08bh,03ah,0cbh,03ah,02ch,03ah,047h,041h,04dh,045h	; 86d4  +:K:k:.:.:,:GAME
	defb 000h,044h,041h,054h,041h,0feh,04ch,03ah,045h,04eh,044h,0ffh,02bh,03ah,04bh,03ah	; 86e4  .DATA.L:END.+:K:
	defb 06bh,03ah,0abh,03ah	; 86f4

; ======================================================================
; CODIGO 0x86f8..0x870a  (18 bytes)
; ======================================================================


pinta_opcion_b:		; pinta la opcion elegida (0xD136, nibble alto)
	ld hl,0870ah		;86f8
	ld a,(0d136h)		;86fb   ; lee tipo y opcion del menu de disco
	and 0f0h		;86fe
	rrca			;8700
	rrca			;8701
	rrca			;8702
	rrca			;8703
	dec a			;8704
	ld bc,00000h		;8705
	jr $+66		;8708

; ----------------------------------------------------------------------
; DATOS resto_870A: lo apuntan con el banco puesto p02:86F8 (0x870A), p01:77FE
;   (0x8730), p01:7882 (0x8730); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p02:86F8, p01:77FE, p01:7882 (50 bytes)
;   0x870a..0x873c  (50 bytes)
DATA_resto_870A:
	defb 018h,087h,022h,087h,000h,000h,000h,000h,000h,000h,02ch,087h,034h,087h,044h,049h	; 870a  ..".......,.4.DI
	defb 053h,04bh,040h,053h,041h,056h,045h,0ffh,044h,049h,053h,04bh,040h,04ch,04fh,041h	; 871a  SK@SAVE.DISK@LOA
	defb 044h,0ffh,052h,041h,04eh,04bh,049h,04eh,047h,0ffh,050h,052h,049h,04eh,054h,045h	; 872a  D.RANKING.PRINTE
	defb 052h,0ffh	; 873a

; ======================================================================
; CODIGO 0x873c..0x875b  (31 bytes)
; ======================================================================


pinta_tipo:		; pinta el tipo elegido (0xF10B, nibble bajo) (gemela de p00:5D56)
	call 0a56eh		;873c   ; borra_ventana: borra la ventana de 0x9237 (gemela de p01:748F)
	ld a,(0d136h)		;873f   ; lee tipo y opcion del menu de disco
	and 00fh		;8742
	ld hl,0875bh		;8744
	ld bc,00040h		;8747
L_874A:
	ex de,hl			;874a
	ld hl,(0d16ch)		;874b   ; lee la esquina de la ventana del menu y el byte siguiente (16 bits)
	add hl,bc			;874e
	ex de,hl			;874f
	add a,a			;8750
	call 0a3e6h		;8751   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;8754
	inc hl			;8755
	ld h,(hl)			;8756
	ld l,a			;8757
	jp 0a520h		;8758

; ----------------------------------------------------------------------
; DATOS resto_875B: lo apuntan con el banco puesto p02:8744 (0x875B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8744 (37 bytes)
;   0x875b..0x8780  (37 bytes)
DATA_resto_875B:
	defb 06fh,087h,068h,087h,063h,087h,078h,087h,047h,041h,04dh,045h,0ffh,053h,043h,052h	; 875b  o.h.c.x.GAME.SCR
	defb 045h,045h,04eh,0ffh,048h,049h,000h,053h,043h,04fh,052h,045h,0ffh,052h,041h,04eh	; 876b  EEN.HI.SCORE.RAN
	defb 04bh,049h,04eh,047h,0ffh	; 877b

; ======================================================================
; CODIGO 0x8780..0x878a  (10 bytes)
; ======================================================================


texto_search_b:		; pinta 'SEARCH FILE'
	ld de,(0d16eh)		;8780   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	ld hl,0878ah		;8784
	jp 0a520h		;8787

; ----------------------------------------------------------------------
; DATOS resto_878A: lo apuntan con el banco puesto p02:8784 (0x878A); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8784 (12 bytes)
;   0x878a..0x8796  (12 bytes)
DATA_resto_878A:
	defb 053h,045h,041h,052h,043h,048h,000h,046h,049h,04ch,045h,0ffh	; 878a  SEARCH.FILE.

; ======================================================================
; CODIGO 0x8796..0x87a2  (12 bytes)
; ======================================================================


cabecera_87a2:		; pinta la cabecera de p02:87A2
	call 0a655h		;8796   ; borra_zona_3a00: borra 0x3A00 (0x100 bytes)
	ld hl,087a2h		;8799
	call 0a524h		;879c   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jp pinta_juego_b		;879f   ; pinta_juego_b: pinta el numero de juego (0xD301) en hexadecimal

; ----------------------------------------------------------------------
; DATOS resto_87A2: lo apuntan con el banco puesto p02:8799 (0x87A2), p02:85F2
;   (0x87C5); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8799, p02:85F2 (41 bytes)
;   0x87a2..0x87cb  (41 bytes)
DATA_resto_87A2:
	defb 02ch,03ah,044h,049h,053h,050h,04ch,041h,059h,000h,044h,041h,054h,041h,0feh,04ch	; 87a2  ,:DISPLAY.DATA.L
	defb 03ah,043h,048h,041h,04eh,047h,045h,000h,04eh,041h,04dh,045h,0feh,0cch,03ah,045h	; 87b2  :CHANGE.NAME..:E
	defb 04eh,044h,0ffh,02bh,03ah,04bh,03ah,0cbh,03ah	; 87c2  ND.+:K:.:

; ======================================================================
; CODIGO 0x87cb..0x87f6  (43 bytes)
; ======================================================================


L_87CB:
	ld hl,0d301h		;87cb   ; apunta a el codigo del juego (copia)
	ld a,(hl)			;87ce
	ld (hl),0ffh		;87cf
	ld (0d141h),a		;87d1
L_87D4:
	call 04095h		;87d4   ; p09_8191: pasarela: 1-9-10, p09:8191 y vuelve a 2-3
	call ventana_pequena		;87d7   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call pinta_paleta_prueba		;87da   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80 (gemela de p01:6762)
	call borra_sprites		;87dd   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,0882eh		;87e0
	call 0a524h		;87e3   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,0888fh		;87e6
	ld b,005h		;87e9
	call 0a798h		;87eb   ; menu_con_esc: menu: espacio elige, ESC sale (gemela de p01:7676)
	cp 0ffh		;87ee
	jp z,L_9921		;87f0
	call 0a510h		;87f3   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_87F6: tabla de 5 palabras del despachador (call 0x408D en
;   0x87F3); lo leen el despachador (10 bytes)
;   0x87f6..0x8800  (10 bytes)
DATA_saltos_87F6:
	defb 0c3h,088h	; 87f6
	defb 026h,088h	; 87f8
	defb 013h,088h	; 87fa
	defb 000h,088h	; 87fc
	defb 099h,088h	; 87fe

; ======================================================================
; CODIGO 0x8800..0x882e  (46 bytes)
; ======================================================================


L_8800:
	call 04108h		;8800   ; banco_5: pone 5-6, llama a p05:8000, desengancha H.TIMI y vuelve a 2-3
	ld a,0e0h		;8803
	ld hl,03b00h		;8805
	ld bc,00080h		;8808
	call 00056h		;880b   ; BIOS FILVRM - Fills VRAM with value
	call 0a47fh		;880e   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	jr $-61		;8811
L_8813:
	call 040f2h		;8813   ; banco_7: pone 7-8, llama a p07:8000 y vuelve a 2-3
	call 0a47fh		;8816   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	ld a,0e0h		;8819
	ld hl,03b00h		;881b
	ld bc,00080h		;881e
	call 00056h		;8821   ; BIOS FILVRM - Fills VRAM with value
	jr $-80		;8824
L_8826:
	call 0a8e5h		;8826   ; menu_principal: el menu del Game Master: engancha H.TIMI y pinta (gemela de p01:7973)
	call 04095h		;8829   ; p09_8191: pasarela: 1-9-10, p09:8191 y vuelve a 2-3
	jr $-88		;882c

; ----------------------------------------------------------------------
; DATOS resto_882E: lo apuntan con el banco puesto p02:87E0 (0x882E), p01:7792
;   (0x8882), p02:87E6 (0x888F); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p02:87E0, p01:7792, p02:87E6 (107 bytes)
;   0x882e..0x8899  (107 bytes)
DATA_resto_882E:
	defb 0c6h,038h,040h,040h,053h,045h,04ch,046h,000h,04dh,04fh,044h,045h,000h,04dh,045h	; 882e  .8@@SELF.MODE.ME
	defb 04eh,055h,040h,040h,0feh,027h,039h,04ch,04fh,041h,044h,000h,053h,043h,052h,045h	; 883e  NU@@.'9LOAD.SCRE
	defb 045h,04eh,000h,044h,041h,054h,041h,0feh,067h,039h,053h,052h,041h,04dh,000h,044h	; 884e  EN.DATA.g9SRAM.D
	defb 049h,053h,04bh,000h,055h,054h,049h,04ch,049h,054h,059h,0feh,0a7h,039h,054h,045h	; 885e  ISK.UTILITY..9TE
	defb 04eh,04eh,049h,053h,000h,041h,04eh,044h,000h,048h,04fh,043h,04bh,045h,059h,0feh	; 886e  NNIS.AND.HOCKEY.
	defb 0e7h,039h,042h,049h,04fh,052h,059h,054h,048h,04dh,0feh,027h,03ah,045h,04eh,044h	; 887e  .9BIORYTHM.':END
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h,026h,03ah	; 888e  .&9f9.9.9&:

; ======================================================================
; CODIGO 0x8899..0x891c  (131 bytes)
; ======================================================================


L_8899:
	ld hl,0d317h		;8899   ; apunta a las opciones del MODIFY (copia)
	ld a,(hl)			;889c
	or a			;889d
	jr nz,L_88A3		;889e
	ld (0d129h),a		;88a0   ; guarda el tipo de fichero elegido
L_88A3:
	ld hl,0d301h		;88a3   ; apunta a el codigo del juego (copia)
	ld a,(0d141h)		;88a6
	ld (hl),a			;88a9
	jp L_9929		;88aa
L_88AD:
	call pregunta_vuelve		;88ad   ; pregunta_vuelve: pregunta y vuelve al menu
L_88B0:
	call 0a47fh		;88b0   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	jp L_87D4		;88b3
ventana_pequena:		; las esquinas de una ventana (0x9235, 0x9237) (gemela de p00:5F0D)
	ld hl,03921h		;88b6
	ld (0d16ch),hl		;88b9   ; guarda la esquina de la ventana del menu y el byte siguiente (16 bits)
	ld hl,0392ch		;88bc
	ld (0d16eh),hl		;88bf   ; guarda la esquina de la ventana pequena y el byte siguiente (16 bits)
	ret			;88c2
L_88C3:
	call hay_disco_b		;88c3   ; hay_disco_b: Z si no hay disco (H.PHYD = ret) y 0xD4F9 no lo fuerza
	jp z,L_87D4		;88c6
	call borra_sprites		;88c9   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld a,021h		;88cc
	ld (0d136h),a		;88ce   ; guarda tipo y opcion del menu de disco
	call modify_mode		;88d1   ; modify_mode: el MODIFY MODE MENU: limpia y pinta
	call elige_fichero		;88d4   ; elige_fichero: lista los ficheros del disco y deja elegir uno
	jp c,L_87D4		;88d7
	ld hl,09644h		;88da
	call ventana_b		;88dd   ; ventana_b: abre una ventana de texto con el marco de DE
	call borra_sprites		;88e0   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	call disco_carga_pantalla		;88e3   ; disco_carga_pantalla: carga SCREEN DATA del disco
	jp c,L_87D4		;88e6
	ld a,0ffh		;88e9
	ld (0d13dh),a		;88eb
	call pregunta_vuelve		;88ee   ; pregunta_vuelve: pregunta y vuelve al menu
	ld a,006h		;88f1
	call 00141h		;88f3   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	and 003h		;88f6
	jp nz,L_8901		;88f8
	call ventana_menu		;88fb   ; ventana_menu: las esquinas de la ventana del menu (0x9235, 0x9237)
	call disco_guarda_vrm		;88fe   ; disco_guarda_vrm: graba un fichero .VRM (la VRAM)
L_8901:
	xor a			;8901
	ld (0d13dh),a		;8902
	jp L_88B0		;8905
L_8908:
	call borra_sprites		;8908   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,0894eh		;890b
	call 0a524h		;890e   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
L_8911:
	ld hl,08996h		;8911
	ld b,002h		;8914
	call 0a7b2h		;8916   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	call 0a510h		;8919   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_891C: tabla de 2 palabras del despachador (call 0x408D en
;   0x8919); lo leen el despachador (4 bytes)
;   0x891c..0x8920  (4 bytes)
DATA_saltos_891C:
	defb 020h,089h	; 891c
	defb 0d4h,087h	; 891e

; ======================================================================
; CODIGO 0x8920..0x894e  (46 bytes)
; ======================================================================


L_8920:
	call sram_ordenes_c_d		;8920   ; sram_ordenes_c_d: SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000)
	jr z,L_892A		;8923
	call sram_ordenes_c_d		;8925   ; sram_ordenes_c_d: SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000)
	jr z,L_8932		;8928
L_892A:
	ld hl,08973h		;892a
	call 0a524h		;892d   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jr $-31		;8930
L_8932:
	ld hl,08986h		;8932
	call 0a524h		;8935   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	jr $-39		;8938
sram_ordenes_c_d:		; SRAM por CALSLT: las ordenes 0x0C y 0x0D (p04:8000) (gemela de p00:4373)
	ld c,00ch		;893a
	ld ix,04020h		;893c
	ld iy,(0d12dh)		;8940   ; lee volumen del PSG, canal C y el byte siguiente (16 bits)
	call 0001ch		;8944   ; BIOS CALSLT - Executes inter-slot call
	ld c,00dh		;8947
	call 0001ch		;8949   ; BIOS CALSLT - Executes inter-slot call
	and a			;894c
	ret			;894d

; ----------------------------------------------------------------------
; DATOS resto_894E: lo apuntan con el banco puesto p02:890B (0x894E), p02:892A
;   (0x8973), p02:8932 (0x8986), p02:8911 (0x8996); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p02:890B, p02:892A,
;   p02:8932, p02:8911 (78 bytes)
;   0x894e..0x899c  (78 bytes)
DATA_resto_894E:
	defb 0c6h,038h,040h,040h,052h,041h,04dh,000h,044h,049h,053h,04bh,000h,046h,04fh,052h	; 894e  .8@@RAM.DISK.FOR
	defb 04dh,041h,054h,040h,040h,0feh,027h,039h,046h,04fh,052h,04dh,041h,054h,0feh,067h	; 895e  MAT@@.'9FORMAT.g
	defb 039h,045h,04eh,044h,0ffh,0c9h,039h,046h,04fh,052h,041h,04dh,054h,000h,043h,04fh	; 896e  9END..9FORAMT.CO
	defb 04dh,050h,04ch,045h,054h,045h,044h,0ffh,0c9h,039h,046h,04fh,052h,041h,04dh,054h	; 897e  MPLETED..9FORAMT
	defb 000h,046h,041h,049h,04ch,045h,044h,0ffh,026h,039h,066h,039h,0a6h,039h	; 898e  .FAILED.&9f9.9

; ======================================================================
; CODIGO 0x899c..0x89b0  (20 bytes)
; ======================================================================


pregunta_vuelve:		; pregunta y vuelve al menu (gemela de p00:5F70)
	call 0a578h		;899c
	ld hl,089c2h		;899f
	call 0a524h		;89a2   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,089f7h		;89a5
	ld b,002h		;89a8
	call 0a7b2h		;89aa   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	call 0a510h		;89ad   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_89B0: tabla de 2 palabras del despachador (call 0x408D en
;   0x89AD); lo leen el despachador (4 bytes)
;   0x89b0..0x89b4  (4 bytes)
DATA_saltos_89B0:
	defb 0b4h,089h	; 89b0
	defb 0bfh,089h	; 89b2

; ======================================================================
; CODIGO 0x89b4..0x89c2  (14 bytes)
; ======================================================================


L_89B4:
	call 0a5efh		;89b4
	call 00156h		;89b7   ; BIOS KILBUF - Clears keyboard buffer
	call 0009fh		;89ba   ; BIOS CHGET - One character input (waiting)
	jr $-33		;89bd
L_89BF:
	jp 0a5efh		;89bf

; ----------------------------------------------------------------------
; DATOS resto_89C2: lo apuntan con el banco puesto p02:899F (0x89C2), p02:89A5
;   (0x89F7); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:899F, p02:89A5 (57 bytes)
;   0x89c2..0x89fb  (57 bytes)
DATA_resto_89C2:
	defb 026h,03ah,040h,040h,053h,043h,052h,045h,045h,04eh,000h,044h,049h,053h,050h,04ch	; 89c2  &:@@SCREEN.DISPL
	defb 041h,059h,000h,04dh,04fh,044h,045h,040h,040h,0feh,067h,03ah,044h,049h,053h,050h	; 89d2  AY.MODE@@.g:DISP
	defb 04ch,041h,059h,000h,041h,04ch,04ch,000h,053h,043h,052h,045h,045h,04eh,0feh,087h	; 89e2  LAY.ALL.SCREEN..
	defb 03ah,045h,04eh,044h,0ffh,066h,03ah,086h,03ah	; 89f2  :END.f:.:

; ======================================================================
; CODIGO 0x89fb..0x8a20  (37 bytes)
; ======================================================================


L_89FB:
	call ventana_pequena		;89fb   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call pinta_paleta_prueba		;89fe   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80 (gemela de p01:6762)
	call borra_sprites		;8a01   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,08c34h		;8a04
	call 0a524h		;8a07   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld de,0384dh		;8a0a
	call pinta_numero_de_juego_b		;8a0d   ; pinta_numero_de_juego_b: pinta el numero de juego (0xD301)
	ld hl,08c85h		;8a10
	ld b,003h		;8a13
	call 0a7b2h		;8a15   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	cp 0ffh		;8a18
	jp z,L_9921		;8a1a
	call 0a510h		;8a1d   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_8A20: tabla de 3 palabras del despachador (call 0x408D en
;   0x8A1D); lo leen el despachador (6 bytes)
;   0x8a20..0x8a26  (6 bytes)
DATA_saltos_8A20:
	defb 02bh,08ah	; 8a20
	defb 0a5h,08ah	; 8a22
	defb 030h,08ch	; 8a24

; ======================================================================
; CODIGO 0x8a26..0x8a79  (83 bytes)
; ======================================================================


sin_juego_b:		; Z si no se reconocio el juego (0xD301 = 0xFF)
	ld a,(0d301h)		;8a26   ; lee el codigo del juego (copia)
	inc a			;8a29
	ret			;8a2a
L_8A2B:
	call sin_juego_b		;8a2b   ; sin_juego_b: Z si no se reconocio el juego (0xD301 = 0xFF)
	jr z,$-51		;8a2e
	ld a,(0d302h)		;8a30
	inc a			;8a33
	jr nz,L_8A3F		;8a34
	ld hl,(0d30ah)		;8a36
	ld a,h			;8a39
	or l			;8a3a
	jr z,$-64		;8a3b
	jr L_8A47		;8a3d
L_8A3F:
	ld hl,09f11h		;8a3f
	call busca_en_tabla		;8a42   ; busca_en_tabla: busca 0xF281 en la tabla [codigo, direccion] de HL (gemela de p01:683A)
	jr nz,$-74		;8a45
L_8A47:
	call borra_sprites		;8a47   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,08a79h		;8a4a
	call 0a524h		;8a4d   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03974h		;8a50
	call menu_dos_b		;8a53   ; menu_dos_b: menu de 2 opciones (p03:A65F)
	jp z,L_8C27		;8a56
	ld hl,0d31ah		;8a59
	call teclado_a_nibble_c		;8a5c   ; teclado_a_nibble_c: pasa la tecla del bufer (0xD142) a un nibble
	jp z,L_8C27		;8a5f
	ld hl,0d31bh		;8a62
	call teclado_a_byte		;8a65   ; teclado_a_byte: pasa las teclas del bufer (0xD142) a un byte
	ld hl,(0d314h)		;8a68   ; lee la rutina propia del juego (copia) y el byte siguiente (16 bits)
	ld a,h			;8a6b
	or l			;8a6c
	ld hl,0d317h		;8a6d   ; apunta a las opciones del MODIFY (copia)
	jr z,L_8A74		;8a70
	set 2,(hl)		;8a72
L_8A74:
	set 1,(hl)		;8a74
	jp L_8C27		;8a76

; ----------------------------------------------------------------------
; DATOS resto_8A79: lo apuntan con el banco puesto p02:8A4A (0x8A79); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8A4A (44 bytes)
;   0x8a79..0x8aa5  (44 bytes)
DATA_resto_8A79:
	defb 0c5h,038h,040h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,053h,054h,041h,047h	; 8a79  .8@@@MODIFY.STAG
	defb 045h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,040h,0feh,067h,039h,053h,054h	; 8a89  E.NUMBER@@@.g9ST
	defb 041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh	; 8a99  AGE.NUMBER>.

; ======================================================================
; CODIGO 0x8aa5..0x8af8  (83 bytes)
; ======================================================================


L_8AA5:
	call sin_juego_b		;8aa5   ; sin_juego_b: Z si no se reconocio el juego (0xD301 = 0xFF)
	jp z,L_89FB		;8aa8
	ld a,(0d302h)		;8aab
	inc a			;8aae
	jr nz,L_8ABB		;8aaf
	ld hl,(0d308h)		;8ab1
	ld a,h			;8ab4
	or l			;8ab5
	jp z,L_89FB		;8ab6
	jr L_8AC4		;8ab9
L_8ABB:
	ld hl,09ee0h		;8abb
	call busca_en_tabla		;8abe   ; busca_en_tabla: busca 0xF281 en la tabla [codigo, direccion] de HL (gemela de p01:683A)
	jp nz,L_89FB		;8ac1
L_8AC4:
	call borra_sprites		;8ac4   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,08af8h		;8ac7
	call 0a524h		;8aca   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03975h		;8acd
	call menu_dos_b		;8ad0   ; menu_dos_b: menu de 2 opciones (p03:A65F)
	jp z,L_8C27		;8ad3
	ld hl,0d318h		;8ad6
	call teclado_a_nibble_c		;8ad9   ; teclado_a_nibble_c: pasa la tecla del bufer (0xD142) a un nibble
	jp z,L_8C27		;8adc
	ld hl,0d319h		;8adf
	call teclado_a_byte		;8ae2   ; teclado_a_byte: pasa las teclas del bufer (0xD142) a un byte
	ld hl,0d317h		;8ae5   ; apunta a las opciones del MODIFY (copia)
	set 0,(hl)		;8ae8
	ld de,(0d314h)		;8aea   ; lee la rutina propia del juego (copia) y el byte siguiente (16 bits)
	ld a,d			;8aee
	or e			;8aef
	jp z,L_8C27		;8af0
	set 2,(hl)		;8af3
	jp L_8C27		;8af5

; ----------------------------------------------------------------------
; DATOS resto_8AF8: lo apuntan con el banco puesto p02:8AC7 (0x8AF8); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8AC7 (260 bytes)
;   0x8af8..0x8bfc  (260 bytes)
DATA_resto_8AF8:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h	; 8af8  .8@@MODIFY.PLAYE
	defb 052h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,0feh,067h,039h,050h,04ch,041h	; 8b08  R.NUMBER@@.g9PLA
	defb 059h,045h,052h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh,0cdh,026h,08ah,0cah	; 8b18  YER.NUMBER>..&..
	defb 0fbh,089h,02ah,00eh,0d3h,07ch,0b5h,0cah,0fbh,089h,0cdh,0edh,08ch,021h,060h,08bh	; 8b28  ..*..|.......!`.
	defb 0cdh,024h,0a5h,021h,09fh,08bh,006h,003h,0cdh,0b2h,0a7h,0cdh,010h,0a5h,0d6h,08bh	; 8b38  .$.!............
	defb 04ch,08bh,027h,08ch,0cdh,0a5h,08bh,021h,017h,0d3h,0cbh,0feh,0c3h,027h,08ch,04bh	; 8b48  L.'....!.....'.K
	defb 04fh,04eh,041h,04dh,049h,000h,000h,001h,0c6h,038h,040h,040h,052h,041h,04eh,04bh	; 8b58  ONAMI....8@@RANK
	defb 049h,04eh,047h,000h,04dh,04fh,044h,045h,040h,040h,0feh,027h,039h,04ch,04fh,041h	; 8b68  ING.MODE@@.'9LOA
	defb 044h,000h,044h,049h,053h,04bh,000h,044h,041h,054h,041h,0feh,067h,039h,043h,04ch	; 8b78  D.DISK.DATA.g9CL
	defb 045h,041h,052h,000h,052h,041h,04eh,04bh,049h,04eh,047h,000h,044h,041h,054h,041h	; 8b88  EAR.RANKING.DATA
	defb 0feh,0a7h,039h,045h,04eh,044h,0ffh,026h,039h,066h,039h,0a6h,039h,021h,059h,0d4h	; 8b98  ..9END.&9f9.9!Y.
	defb 011h,05ah,0d4h,036h,000h,001h,01dh,000h,0edh,0b0h,021h,077h,0d4h,011h,078h,0d4h	; 8ba8  .Z.6......!w..x.
	defb 036h,03ch,001h,059h,000h,0edh,0b0h,011h,078h,0d4h,021h,057h,08bh,001h,006h,000h	; 8bb8  6<.Y....x.!W....
	defb 0edh,0b0h,011h,059h,0d4h,021h,05dh,08bh,001h,003h,000h,0edh,0b0h,0c9h,0cdh,05dh	; 8bc8  ...Y.!]........]
	defb 094h,0cah,03bh,08bh,03eh,023h,032h,036h,0d1h,0cdh,0fch,08bh,0cdh,048h,097h,0dah	; 8bd8  ....>#26.....H..
	defb 032h,08bh,021h,044h,096h,0cdh,011h,096h,0cdh,0edh,08ch,0cdh,0cdh,091h,0d2h,04fh	; 8be8  2.!D...........O
	defb 08bh,0c3h,032h,08bh	; 8bf8

; ======================================================================
; CODIGO 0x8bfc..0x8c34  (56 bytes)
; ======================================================================


modify_mode:		; el MODIFY MODE MENU: limpia y pinta
	call borra_sprites		;8bfc   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	call ventana_pequena		;8bff   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call pinta_opcion_b		;8c02   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	call pinta_tipo		;8c05   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call texto_search_b		;8c08   ; texto_search_b: pinta 'SEARCH FILE'
	ld hl,0965dh		;8c0b
	call ventana_b		;8c0e   ; ventana_b: abre una ventana de texto con el marco de DE
	xor a			;8c11
	ld (0d163h),a		;8c12   ; guarda cuantas letras lleva el nombre
	ld (0d165h),a		;8c15   ; guarda la fila elegida
	ld hl,0396ch		;8c18
	ld (0d168h),hl		;8c1b   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld (0d16ah),hl		;8c1e   ; guarda la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	ld a,080h		;8c21
	ld (0d164h),a		;8c23
	ret			;8c26
L_8C27:
	call pinta_paleta_prueba		;8c27   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80 (gemela de p01:6762)
	call borra_sprites		;8c2a   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	jp L_89FB		;8c2d
L_8C30:
	di			;8c30
	jp L_9968		;8c31

; ----------------------------------------------------------------------
; DATOS resto_8C34: lo apuntan con el banco puesto p02:8A04 (0x8C34), p02:8A10
;   (0x8C85); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8A04, p02:8A10 (89 bytes)
;   0x8c34..0x8c8d  (89 bytes)
DATA_resto_8C34:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,04dh,04fh,044h,045h,000h	; 8c34  .8@@MODIFY.MODE.
	defb 04dh,045h,04eh,055h,040h,040h,0feh,027h,039h,04dh,04fh,044h,049h,046h,059h,000h	; 8c44  MENU@@.'9MODIFY.
	defb 053h,054h,041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,0feh,067h,039h,04dh	; 8c54  STAGE.NUMBER.g9M
	defb 04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h,052h,000h,04eh,055h,04dh	; 8c64  ODIFY.PLAYER.NUM
	defb 042h,045h,052h,0feh,0a7h,039h,053h,054h,041h,052h,054h,000h,047h,041h,04dh,045h	; 8c74  BER..9START.GAME
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h	; 8c84  .&9f9.9.9

; ======================================================================
; CODIGO 0x8c8d..0x8cc7  (58 bytes)
; ======================================================================


menu_dos_b:		; menu de 2 opciones (p03:A65F)
	ld a,0ffh		;8c8d
	ld b,002h		;8c8f
	jp 0a65fh		;8c91   ; menu: menu de B opciones con el cursor A: devuelve la elegida (gemela de p01:750E)
L_8C94:
	call 0a47fh		;8c94   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	ld de,03800h		;8c97
	ld b,010h		;8c9a
L_8C9C:
	push bc			;8c9c
	push de			;8c9d
	ld bc,00020h		;8c9e
	ld hl,08ccdh		;8ca1
	call 0005ch		;8ca4   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;8ca7
	ld bc,00020h		;8ca8
	add hl,bc			;8cab
	ex de,hl			;8cac
	pop bc			;8cad
	djnz L_8C9C		;8cae
	ld hl,03a07h		;8cb0
	ld bc,00810h		;8cb3
	ld a,00fh		;8cb6
	call 0a53bh		;8cb8
	ld de,03af9h		;8cbb
	ld hl,08cc7h		;8cbe
	ld bc,00006h		;8cc1
	jp 0005ch		;8cc4   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS resto_8CC7: lo apuntan con el banco puesto p02:8CBE (0x8CC7), p02:8CA1
;   (0x8CCD); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:8CBE, p02:8CA1 (38 bytes)
;   0x8cc7..0x8ced  (38 bytes)
DATA_resto_8CC7:
	defb 088h,089h,08ah,08bh,08ch,08dh,080h,00eh,00eh,00eh,084h,00ah,00ah,00ah,00ah,081h	; 8cc7  ................
	defb 007h,007h,007h,085h,00ch,00ch,00ch,00ch,082h,00dh,00dh,00dh,086h,006h,006h,006h	; 8cd7  ................
	defb 006h,083h,004h,004h,004h,087h	; 8ce7

; ======================================================================
; CODIGO 0x8ced..0x8d87  (154 bytes)
; ======================================================================


borra_sprites:		; borra la tabla de sprites (0x3880, 0x200 bytes) (gemela de p01:62D3)
	ld hl,03880h		;8ced
	ld bc,00200h		;8cf0
	xor a			;8cf3
	jp 00056h		;8cf4   ; BIOS FILVRM - Fills VRAM with value
teclado_a_nibble_c:		; pasa la tecla del bufer (0xD142) a un nibble
	xor a			;8cf7
	ld (hl),a			;8cf8
	ld a,(0d163h)		;8cf9   ; lee cuantas letras lleva el nombre
	or a			;8cfc
	ret z			;8cfd
	ld de,0d142h		;8cfe   ; apunta a el bufer de teclas
	cp 001h		;8d01
	jr nz,L_8D0B		;8d03
	ld a,(de)			;8d05
	and 00fh		;8d06
	ld (hl),a			;8d08
	or a			;8d09
	ret			;8d0a
L_8D0B:
	cp 002h		;8d0b   ; con dos teclas en el bufer, un numero de dos cifras
	ret nz			;8d0d
	ld a,(de)			;8d0e   ; la primera cifra
	and 00fh		;8d0f
	add a,a			;8d11   ; por 10 (x2, x8 y suma)
	ld b,a			;8d12
	add a,a			;8d13
	add a,a			;8d14
	add a,b			;8d15
	ld b,a			;8d16
	inc de			;8d17   ; la segunda cifra
	ld a,(de)			;8d18
	and 00fh		;8d19
	add a,b			;8d1b   ; decenas y unidades
	ld (hl),a			;8d1c   ; el numero en binario
	ret			;8d1d
teclado_a_byte:		; pasa las teclas del bufer (0xD142) a un byte
	xor a			;8d1e
	ld (hl),a			;8d1f
	ld a,(0d163h)		;8d20   ; lee cuantas letras lleva el nombre
	or a			;8d23
	ret z			;8d24
	ld de,0d142h		;8d25   ; apunta a el bufer de teclas
	cp 001h		;8d28
	jr nz,L_8D32		;8d2a
	ld a,(de)			;8d2c
	and 00fh		;8d2d
	ld (hl),a			;8d2f
	or a			;8d30
	ret			;8d31
L_8D32:
	cp 002h		;8d32   ; con dos teclas en el bufer, un byte de dos cifras hexadecimales
	ret nz			;8d34
	ld a,(de)			;8d35   ; la primera cifra
	and 00fh		;8d36
	add a,a			;8d38   ; por 16
	add a,a			;8d39
	add a,a			;8d3a
	add a,a			;8d3b
	ld b,a			;8d3c
	inc de			;8d3d   ; la segunda cifra
	ld a,(de)			;8d3e
	and 00fh		;8d3f
	add a,b			;8d41   ; las dos juntas
	ld (hl),a			;8d42   ; el byte
	ret			;8d43
engancha_al_juego_b:		; copia p02:8D98 a 0xD814 y busca en el INIT del juego el ld (0xFD9B),hl
	ld hl,08d98h		;8d44
	ld de,0d814h		;8d47
	ld bc,0004dh		;8d4a
	ldir		;8d4d
	push de			;8d4f
	ld hl,(0d132h)		;8d50   ; lee la direccion INIT del juego (copia) y el byte siguiente (16 bits)
	ld bc,00100h		;8d53
	call copia_del_juego		;8d56   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE (gemela de p01:6371)
	pop hl			;8d59
	ld bc,00100h		;8d5a
L_8D5D:
	ld a,09bh		;8d5d   ; busca el byte bajo de 0xFD9B...
	cpir		;8d5f   ; ...en los 0x100 bytes copiados del INIT del juego
	ret nz			;8d61   ; no esta
	ret po			;8d62   ; se acabaron los bytes
	ld a,0fdh		;8d63   ; ¿le sigue 0xFD?
	cp (hl)			;8d65
	jr nz,L_8D5D		;8d66
	dec hl			;8d68   ; si: apunta al operando del `ld (0xFD9B),hl`
	ld de,08d87h		;8d69   ; lo cambia por los 5 bytes de p02:8D87
	ex de,hl			;8d6c
	ld bc,00005h		;8d6d
	ldir		;8d70
	xor a			;8d72   ; A = 0: hecho
	ret			;8d73
copia_del_juego:		; copia BC bytes de HL del cartucho del juego (RDSLT) a DE (gemela de p01:6371)
	push bc			;8d74
	push de			;8d75
	ld a,(0d12fh)		;8d76   ; lee el slot del cartucho del juego (copia)
	call 0000ch		;8d79   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;8d7c
	pop bc			;8d7d
	ld (de),a			;8d7e
	inc hl			;8d7f
	inc de			;8d80
	dec bc			;8d81
	ld a,b			;8d82
	or c			;8d83
	jr nz,copia_del_juego		;8d84
	ret			;8d86

; ----------------------------------------------------------------------
; DATOS resto_8D87: lo apuntan con el banco puesto p02:8D69 (0x8D87); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:8D69 (5 bytes)
;   0x8d87..0x8d8c  (5 bytes)
DATA_resto_8D87:
	defb 030h,0d1h,0cdh,014h,0d8h	; 8d87

; ======================================================================
; CODIGO 0x8d8c..0x9140  (948 bytes)
; ======================================================================


copia_d170:		; copia p02:8DE5 a 0xD170 (0x18E bytes): el codigo que corre con el juego
	ld hl,L_8DE5		;8d8c
	ld de,0d170h		;8d8f
	ld bc,0018eh		;8d92
	ldir		;8d95
	ret			;8d97
L_8D98:
	di			;8d98
	ld de,0fd00h		;8d99
	ld hl,0d961h		;8d9c
	ld bc,002cah		;8d9f
	ldir		;8da2
	ld a,0c3h		;8da4
	ld (0fd9ah),a		;8da6   ; guarda el gancho H.KEYI
	ld hl,0d2d8h		;8da9
	ld (0fd9bh),hl		;8dac   ; guarda la direccion del gancho H.KEYI y el byte siguiente (16 bits)
	pop hl			;8daf
	dec hl			;8db0
	dec hl			;8db1
	dec hl			;8db2
	ld de,0d861h		;8db3
	and a			;8db6
	sbc hl,de		;8db7
	ld de,(0d132h)		;8db9   ; lee la direccion INIT del juego (copia) y el byte siguiente (16 bits)
	add hl,de			;8dbd
	jp (hl)			;8dbe
L_8DBF:
	ld hl,0fd00h		;8dbf
	ld de,0d961h		;8dc2
	ld bc,002cah		;8dc5
	ldir		;8dc8
	ld a,(0d12fh)		;8dca   ; lee el slot del cartucho del juego (copia)
	ld hl,04000h		;8dcd
	call 00024h		;8dd0   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0d861h		;8dd3
	ld hl,(0fedch)		;8dd6
	ld de,(0d132h)		;8dd9   ; lee la direccion INIT del juego (copia) y el byte siguiente (16 bits)
	and a			;8ddd
	sbc hl,de		;8dde
	ld de,0d861h		;8de0
	add hl,de			;8de3
	jp (hl)			;8de4
L_8DE5:
	di			;8de5
	ld a,(0d13bh)		;8de6
	or a			;8de9
	ret nz			;8dea
	call 0013eh		;8deb   ; BIOS RDVDP - Reads VDP status register
	ld ix,(0d130h)		;8dee   ; lee la direccion a la que se vuelve del congelado y el byte siguiente (16 bits)
	ld a,007h		;8df2
	call 00141h		;8df4   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8df7
	and 010h		;8df8
	ld b,a			;8dfa
	ld a,008h		;8dfb
	call 00141h		;8dfd   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;8e00
	rrca			;8e01
	and 006h		;8e02
	or b			;8e04
	ld hl,0d137h		;8e05
	ld c,(hl)			;8e08
	ld (hl),a			;8e09
	xor c			;8e0a
	and (hl)			;8e0b
	ld c,a			;8e0c
	di			;8e0d
	bit 4,a		;8e0e
	jr z,L_8E19		;8e10
	ld ix,L_8F73		;8e12
	jp 0d214h		;8e16
L_8E19:
	ld a,(0d317h)		;8e19   ; lee las opciones del MODIFY (copia)
	or a			;8e1c   ; sin opciones de MODIFY, nada
	jr z,L_8E37		;8e1d
	ld hl,(0d304h)		;8e1f   ; la variable del juego que se mira (0xD304)
	ld a,(hl)			;8e22
	ld hl,0d316h		;8e23   ; la ultima que se vio
	cp (hl)			;8e26   ; sin cambios, nada
	jr z,L_8E37		;8e27
	ld (hl),a			;8e29   ; cambio: la apunta
	ld a,(0d312h)		;8e2a   ; ¿es la que se espera (0xD312)?
	cp (hl)			;8e2d
	jr nz,L_8E37		;8e2e
	ld ix,099fah		;8e30   ; si: el ranking (p02:99FA) por el puente de RAM
	jp 0d214h		;8e34
L_8E37:
	ld a,(0d332h)		;8e37   ; 0xD332: hay puntos que mirar
	or a			;8e3a
	jr z,L_8E5C		;8e3b
	push bc			;8e3d
	ld a,(0d339h)		;8e3e   ; 0xD339 bit 0...
	rra			;8e41
	jr c,L_8E64		;8e42
	ld hl,(0d30eh)		;8e44   ; los puntos del juego: 0xD30E y 0xD310
	ld de,(0d310h)		;8e47
L_8E4B:
	push de			;8e4b   ; guarda la segunda direccion
	ld de,0d31eh		;8e4c   ; los puntos de la primera a 0xD31E (0xD2BF en RAM)
	call 0d2bfh		;8e4f
	ld de,0d321h		;8e52   ; los de la segunda a 0xD321
	pop hl			;8e55
	ld a,h			;8e56   ; si hay segunda
	or l			;8e57
	call nz,0d2bfh		;8e58
	pop bc			;8e5b
L_8E5C:
	ld a,(0d134h)		;8e5c
	rra			;8e5f
	jr c,L_8E7E		;8e60
	jp (ix)		;8e62
L_8E64:
	ld hl,(0d30eh)		;8e64   ; lee los puntos de las dos direcciones (0xD2B6 en RAM)...
	ld de,0d335h		;8e67
	call 0d2b6h		;8e6a
	ld hl,(0d310h)		;8e6d   ; ...a 0xD335 y 0xD338
	ld de,0d338h		;8e70
	call 0d2b6h		;8e73
	ld hl,0d333h		;8e76   ; y los compara con 0xD333/0xD336
	ld de,0d336h		;8e79
	jr L_8E4B		;8e7c
L_8E7E:
	ld a,(0d135h)		;8e7e
	cp 002h		;8e81
	jr z,L_8EB9		;8e83
	ld ix,L_8FE8		;8e85
L_8E89:
	push ix		;8e89
	ld a,(0d12eh)		;8e8b   ; lee el slot del Game Master (copia)
	ld h,040h		;8e8e
	push af			;8e90
	call 00024h		;8e91   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;8e94
	ld h,080h		;8e95
	call 00024h		;8e97   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop ix		;8e9a
	ld a,002h		;8e9c
	ld (08000h),a		;8e9e   ; el mapper: pone en 0x8000 el banco de A
	inc a			;8ea1
	ld (0a000h),a		;8ea2   ; el mapper: pone en 0xA000 el banco de A
	call salta_a_ix		;8ea5   ; salta_a_ix: jp (ix)
	ld a,(0d12fh)		;8ea8   ; lee el slot del cartucho del juego (copia)
	ld h,040h		;8eab
	push af			;8ead
	call 00024h		;8eae   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;8eb1
	ld h,080h		;8eb2
	jp 00024h		;8eb4   ; BIOS ENASLT - Switches to specified slot and page definitively
salta_a_ix:		; jp (ix)
	jp (ix)		;8eb7
L_8EB9:
	ld hl,0d13ah		;8eb9   ; 0xD13A: el volumen pedido; 0xD139: el que suena
	ld de,0d139h		;8ebc
	bit 1,c		;8ebf   ; bit 1 de las teclas: bajar el volumen
	jr z,L_8EE3		;8ec1
	ld a,(hl)			;8ec3   ; ya esta a 0
	or a			;8ec4
	ret z			;8ec5
	sub 00dh		;8ec6   ; baja 13
	jr z,L_8ECC		;8ec8
	jr nc,L_8EDF		;8eca
L_8ECC:
	push hl			;8ecc   ; al llegar a 0...
	push de			;8ecd
	ld ix,guarda_volumenes		;8ece   ; ...guarda los volumenes del PSG...
	call 0d214h		;8ed2
	ld ix,silencia_psg_b		;8ed5   ; ...y lo deja en silencio
	call 0d214h		;8ed9
	pop de			;8edc
	pop hl			;8edd
	xor a			;8ede   ; A = 0
L_8EDF:
	ld (hl),a			;8edf
	xor a			;8ee0
	ld (de),a			;8ee1
	ret			;8ee2
L_8EE3:
	bit 2,c		;8ee3   ; bit 2: subir el volumen
	jr z,L_8EFF		;8ee5
	ld a,00dh		;8ee7   ; sube 13
	add a,(hl)			;8ee9
	jr nc,L_8EEE		;8eea
	ld a,0ffh		;8eec   ; con tope 0xFF
L_8EEE:
	ld (hl),a			;8eee   ; el volumen pedido
	cp 00dh		;8eef   ; si acaba de salir del 0...
	jr nz,L_8EFC		;8ef1
	push de			;8ef3
	ld ix,devuelve_volumenes_b		;8ef4   ; ...devuelve los volumenes del PSG
	call 0d214h		;8ef8
	pop de			;8efb
L_8EFC:
	xor a			;8efc
	ld (de),a			;8efd
	ret			;8efe
L_8EFF:
	ld a,(hl)			;8eff   ; lo que hay que sumar al volumen
	or a			;8f00
	jr z,L_8F24		;8f01
	ld a,(de)			;8f03   ; suma al que suena
	add a,(hl)			;8f04
	ld (de),a			;8f05
	ret nc			;8f06   ; sin pasarse, vuelve
	jp (ix)		;8f07   ; si se pasa, sigue en IX
L_8F09:
	ld a,(0d12fh)		;8f09   ; lee el slot del cartucho del juego (copia)
	ld h,080h		;8f0c
	call 00024h		;8f0e   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld iy,(0d12eh)		;8f11   ; lee el slot del Game Master (copia) y el byte siguiente (16 bits)
	ld ix,(0d130h)		;8f15   ; lee la direccion a la que se vuelve del congelado y el byte siguiente (16 bits)
	call 0001ch		;8f19   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0d12eh)		;8f1c   ; lee el slot del Game Master (copia)
	ld h,080h		;8f1f
	jp 00024h		;8f21   ; BIOS ENASLT - Switches to specified slot and page definitively
L_8F24:
	ld ix,silencia_psg_b		;8f24
	jp 0d214h		;8f28
copia_3_al_reves:		; copia 3 bytes de HL hacia atras en DE (gemela de p00:5A80)
	ld b,003h		;8f2b
L_8F2D:
	ld a,(hl)			;8f2d   ; copia un byte...
	ld (de),a			;8f2e
	inc hl			;8f2f
	dec de			;8f30   ; ...con DE hacia atras
	djnz L_8F2D		;8f31   ; B bytes
	ret			;8f33
compara_3:		; compara 3 bytes (BCD) de HL y DE (gemela de p00:5A89)
	inc hl			;8f34
	inc hl			;8f35
	push hl			;8f36
	push de			;8f37
	ld b,003h		;8f38
L_8F3A:
	ld a,(de)			;8f3a   ; compara las cifras BCD de la mas alta a la mas baja
	cp (hl)			;8f3b
	jr c,L_8F45		;8f3c   ; menor: sale con C
	dec hl			;8f3e
	dec de			;8f3f
	djnz L_8F3A		;8f40   ; las B cifras
	pop de			;8f42
	pop hl			;8f43
	ret			;8f44
L_8F45:
	pop de			;8f45
	pop hl			;8f46
	ld bc,00003h		;8f47
	lddr		;8f4a
	ret			;8f4c
L_8F4D:
	ld hl,00000h		;8f4d
	add hl,sp			;8f50
	ld de,0df80h		;8f51
	ld bc,00080h		;8f54
	ldir		;8f57
	ld sp,0df80h		;8f59
	ld hl,0d500h		;8f5c
	ld de,0f100h		;8f5f   ; apunta a volumen del PSG, canal A
	ld bc,00314h		;8f62
	ldir		;8f65
	ld a,0c9h		;8f67
	ld (0fd9fh),a		;8f69   ; guarda el gancho H.TIMI
	ld hl,0d170h		;8f6c
	ld (0fd9bh),hl		;8f6f   ; guarda la direccion del gancho H.KEYI y el byte siguiente (16 bits)
	ret			;8f72
L_8F73:
	call 0013eh		;8f73   ; BIOS RDVDP - Reads VDP status register
	ld hl,0d134h		;8f76
	inc (hl)			;8f79
	ld a,(hl)			;8f7a
	rra			;8f7b
	jr nc,L_8FD9		;8f7c
	xor a			;8f7e
	ld (0d135h),a		;8f7f
	call 00132h		;8f82   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call guarda_volumenes		;8f85   ; guarda_volumenes: guarda los tres volumenes del PSG en 0xF100 (gemela de p01:656C)
silencia_psg_b:		; pone a cero los tres volumenes del PSG (y el SCC del juego si 0xD4D4)
	ld e,000h		;8f88
	ld a,008h		;8f8a
	call 00093h		;8f8c   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;8f8f
	call 00093h		;8f90   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;8f93
	call 00093h		;8f94   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d4d4h)		;8f97   ; lee el juego tiene SCC (copia)
	and a			;8f9a
	ret z			;8f9b
	ld e,03fh		;8f9c
	ld a,(0d12fh)		;8f9e   ; lee el slot del cartucho del juego (copia)
	ld hl,l9000h		;8fa1
	call 00014h		;8fa4   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,000h		;8fa7
	ld a,(0d12fh)		;8fa9   ; lee el slot del cartucho del juego (copia)
	ld hl,0988fh		;8fac
	call 00014h		;8faf   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;8fb2
	ld e,a			;8fb5
	ld a,(0d12fh)		;8fb6   ; lee el slot del cartucho del juego (copia)
	ld hl,l9000h		;8fb9
	call 00014h		;8fbc   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;8fbf
guarda_volumenes:		; guarda los tres volumenes del PSG en 0xF100 (gemela de p01:656C)
	ld a,008h		;8fc0
	call 00096h		;8fc2   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12bh),a		;8fc5   ; guarda volumen del PSG, canal A
	ld a,009h		;8fc8
	call 00096h		;8fca   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12ch),a		;8fcd   ; guarda volumen del PSG, canal B
	ld a,00ah		;8fd0
	call 00096h		;8fd2   ; BIOS RDPSG - Reads value from PSG-register
	ld (0d12dh),a		;8fd5   ; guarda volumen del PSG, canal C
	ret			;8fd8
L_8FD9:
	ld (hl),000h		;8fd9
	ld a,0ffh		;8fdb
	call 00132h		;8fdd   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call devuelve_volumenes_b		;8fe0   ; devuelve_volumenes_b: devuelve los tres volumenes del PSG (0xD12B-0xD12D) y el SCC
	xor a			;8fe3
	ld (0d135h),a		;8fe4
	ret			;8fe7
L_8FE8:
	ld a,001h		;8fe8
	ld (0d13bh),a		;8fea
	call congela		;8fed   ; congela: congela el juego: silencio y espera la tecla (gemela de p01:65A1)
	xor a			;8ff0
	ld (0d13bh),a		;8ff1
	ret			;8ff4
congela:		; congela el juego: silencio y espera la tecla (gemela de p01:65A1)
	call silencia_psg_b		;8ff5   ; silencia_psg_b: pone a cero los tres volumenes del PSG (y el SCC del juego si 0xD4D4)
	ld ix,(0d130h)		;8ff8   ; lee la direccion a la que se vuelve del congelado y el byte siguiente (16 bits)
	ld iy,(0d12eh)		;8ffc   ; lee el slot del Game Master (copia) y el byte siguiente (16 bits)
L_9000:
	ld a,(0d135h)		;9000   ; 0xD135: el congelado esta en marcha
	or a			;9003
	jp nz,L_8487		;9004   ; si: sigue congelado
	call lee_teclas		;9007   ; lee_teclas: las teclas del Game Master (SNSMAT 1, 6 y 7) en 0xF10D: C = las recien pulsadas (gemela de p01:662E)
	ld a,c			;900a   ; el bit 7 de las teclas: el congelado
	rla			;900b
	jr c,L_9022		;900c
	rla			;900e   ; el bit 6
	jr c,L_9028		;900f
	rla			;9011   ; el bit 5
	jr c,L_9015		;9012
	ret			;9014
L_9015:
	ld a,002h		;9015
	ld (0d135h),a		;9017
bio_borra_estado:		; pone a cero 0xE006 y 0xE004 (gemela de p05:9924)
	xor a			;901a
	ld (0d13ah),a		;901b
	ld (0d139h),a		;901e
	ret			;9021
L_9022:
	call devuelve_volumenes_b		;9022   ; devuelve_volumenes_b: devuelve los tres volumenes del PSG (0xD12B-0xD12D) y el SCC
	jp 0d294h		;9025
L_9028:
	ld a,001h		;9028
	ld (0d135h),a		;902a
	ret			;902d
devuelve_volumenes_b:		; devuelve los tres volumenes del PSG (0xD12B-0xD12D) y el SCC
	ld a,(0d12bh)		;902e   ; lee volumen del PSG, canal A
	ld e,a			;9031
	ld a,008h		;9032
	call 00093h		;9034   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d12ch)		;9037   ; lee volumen del PSG, canal B
	ld e,a			;903a
	ld a,009h		;903b
	call 00093h		;903d   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d12dh)		;9040   ; lee volumen del PSG, canal C
	ld e,a			;9043
	ld a,00ah		;9044
	call 00093h		;9046   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0d4d4h)		;9049   ; lee el juego tiene SCC (copia)
	and a			;904c
	ret z			;904d
	ld e,03fh		;904e
	ld a,(0d12fh)		;9050   ; lee el slot del cartucho del juego (copia)
	ld hl,l9000h		;9053
	call 00014h		;9056   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,01fh		;9059
	ld a,(0d12fh)		;905b   ; lee el slot del cartucho del juego (copia)
	ld hl,0988fh		;905e
	call 00014h		;9061   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;9064
	ld e,a			;9067
	ld a,(0d12fh)		;9068   ; lee el slot del cartucho del juego (copia)
	ld hl,l9000h		;906b
	call 00014h		;906e   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;9071
lee_teclas:		; las teclas del Game Master (SNSMAT 1, 6 y 7) en 0xF10D: C = las recien pulsadas (gemela de p01:662E)
	ld a,001h		;9072
	call 00141h		;9074   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9077
	and 080h		;9078
	ld d,a			;907a
	ld a,006h		;907b
	call 00141h		;907d   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9080
	and 0e2h		;9081
	bit 1,a		;9083
	jr z,L_9089		;9085
	or 008h		;9087
L_9089:
	and 0e8h		;9089
	ld e,a			;908b
	ld a,007h		;908c
	call 00141h		;908e   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;9091
	and 007h		;9092
	or e			;9094
	rlca			;9095
	rlca			;9096
	rlca			;9097
	or d			;9098
	ld hl,0d138h		;9099   ; apunta a las teclas del Game Master
	ld c,(hl)			;909c
	ld (hl),a			;909d
	xor c			;909e
	and (hl)			;909f
	ld c,a			;90a0
	ret			;90a1
disco_guarda_partida_b:		; GAME DATA: graba la RAM del juego (crea, escribe, cierra)
	ld (0d127h),sp		;90a2   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;90a6   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	ld hl,0c000h		;90a9
	ld de,0d500h		;90ac
	ld bc,00900h		;90af
	ldir		;90b2
	call bdos_crea		;90b4   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;90b7   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_cabecera_pantalla		;90ba   ; disco_graba_cabecera_pantalla: graba 9 bytes: el modo (0xF3DF) y los registros del VDP
	call bdos_cierra		;90bd   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	ld hl,0d500h		;90c0
	ld de,0c000h		;90c3
	ld bc,00900h		;90c6
	ldir		;90c9
	jp sale_del_disco_b		;90cb   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_guarda_pantalla:		; SCREEN DATA: graba la RAM y la pantalla
	ld (0d127h),sp		;90ce   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;90d2   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_crea		;90d5   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;90d8   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_c000		;90db   ; disco_graba_c000: graba 0x22 registros de 0x80 bytes desde 0xC000
	call disco_graba_cabecera_pantalla		;90de   ; disco_graba_cabecera_pantalla: graba 9 bytes: el modo (0xF3DF) y los registros del VDP
	ld de,0c000h		;90e1
	ld c,01ah		;90e4
	call 0f37dh		;90e6
	di			;90e9
	ld hl,00000h		;90ea
	add hl,sp			;90ed
	push hl			;90ee
	ld hl,00000h		;90ef
	add hl,sp			;90f2
	ld de,0c000h		;90f3
	ld bc,00082h		;90f6
	ldir		;90f9
	pop hl			;90fb
	ei			;90fc
	ld hl,00082h		;90fd
	call bdos_graba		;9100   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	pop hl			;9103
	call bdos_cierra		;9104   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	call borra_fcb		;9107   ; borra_fcb: pone a cero el FCB de 0x982F
	call bdos_abre		;910a   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;910d   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_c000		;9110   ; disco_lee_c000: lee 0x1100 registros a 0xC000
	jp sale_del_disco_b		;9113   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_guarda_vrm:		; graba un fichero .VRM (la VRAM) (gemela de p00:4BA0)
	ld (0d127h),sp		;9116   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;911a   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	ld hl,0d100h		;911d   ; apunta a el nombre del fichero (FCB)
	ld (0d125h),hl		;9120   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	call borra_fcb		;9123   ; borra_fcb: pone a cero el FCB de 0x982F
	ld de,0d109h		;9126
	ld hl,09140h		;9129
	ld bc,00003h		;912c
	ldir		;912f
	call bdos_crea		;9131   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;9134   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_bload		;9137   ; disco_graba_bload: graba la cabecera de BLOAD (0xFE, inicio, fin y ejecucion)
	call bdos_cierra		;913a   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco_b		;913d   ; sale_del_disco_b: espera y devuelve la RAM del juego

; ----------------------------------------------------------------------
; DATOS resto_9140: lo apuntan con el banco puesto p02:9129 (0x9140); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9129 (3 bytes)
;   0x9140..0x9143  (3 bytes)
DATA_resto_9140:
	defb 056h,052h,04dh	; 9140

; ======================================================================
; CODIGO 0x9143..0x9439  (758 bytes)
; ======================================================================


disco_guarda_ranking_b:		; graba el ranking en disco
	ld (0d127h),sp		;9143   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;9147   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_crea		;914a   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;914d   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call ranking_entra		;9150   ; ranking_entra: mete la puntuacion en el ranking (gemela de p01:69AD)
	call disco_graba_d459		;9153   ; disco_graba_d459: graba 0x78 registros desde 0xD459
	call bdos_cierra		;9156   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco_b		;9159   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_guarda_bloque_b:		; graba el bloque de 0xD30C en disco
	ld (0d127h),sp		;915c   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;9160   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_crea		;9163   ; bdos_crea: BDOS 0x16, crear fichero; si falla, el error 1
	call fcb_prepara		;9166   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_graba_d30c		;9169   ; disco_graba_d30c: graba 3 registros desde 0xD30C - 0x2000
	call bdos_cierra		;916c   ; bdos_cierra: BDOS 0x10, cerrar fichero; si falla, el error 2
	jp sale_del_disco_b		;916f   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_carga_partida_b:		; carga GAME DATA del disco
	ld (0d127h),sp		;9172   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;9176   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_abre		;9179   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;917c   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	ld hl,01100h		;917f
	call fcb_registro		;9182   ; fcb_registro: pone HL como registro aleatorio del FCB
	call disco_lee_pantalla		;9185   ; disco_lee_pantalla: lee la cabecera de pantalla y, si es buena, la VRAM
	ld de,0c000h		;9188
	ld c,01ah		;918b
	call 0f37dh		;918d
	ld hl,00082h		;9190
	call bdos_lee		;9193   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld hl,(0c000h)		;9196
	ld sp,hl			;9199
	ld de,0c002h		;919a
	ex de,hl			;919d
	ld bc,00080h		;919e
	ldir		;91a1
	ld hl,00000h		;91a3
	call fcb_registro		;91a6   ; fcb_registro: pone HL como registro aleatorio del FCB
	call disco_lee_c000		;91a9   ; disco_lee_c000: lee 0x1100 registros a 0xC000
	call silencia_psg_b		;91ac   ; silencia_psg_b: pone a cero los tres volumenes del PSG (y el SCC del juego si 0xD4D4)
	call guarda_volumenes		;91af   ; guarda_volumenes: guarda los tres volumenes del PSG en 0xF100 (gemela de p01:656C)
	jp sale_del_disco_b		;91b2   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_carga_pantalla:		; carga SCREEN DATA del disco
	ld (0d127h),sp		;91b5   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;91b9   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_abre		;91bc   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;91bf   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_pantalla		;91c2   ; disco_lee_pantalla: lee la cabecera de pantalla y, si es buena, la VRAM
	jp z,sale_del_disco_b		;91c5   ; sale_del_disco_b: espera y devuelve la RAM del juego
	call sale_del_disco_b		;91c8   ; sale_del_disco_b: espera y devuelve la RAM del juego
	scf			;91cb
	ret			;91cc
disco_carga_ranking_b:		; carga el ranking del disco
	ld (0d127h),sp		;91cd   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;91d1   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_abre		;91d4   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;91d7   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_d459		;91da   ; disco_lee_d459: lee 0x78 registros a 0xD459
	call ranking_quita_1_y_2		;91dd   ; ranking_quita_1_y_2: quita las marcas 1 y 2 del ranking (gemela de p01:690B)
	jp sale_del_disco_b		;91e0   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_carga_bloque_b:		; carga el bloque de 0xD30C del disco
	ld (0d127h),sp		;91e3   ; guarda la pila guardada al ir al disco
	call entra_al_disco_b		;91e7   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	call bdos_abre		;91ea   ; bdos_abre: BDOS 0x0F, abrir fichero; si falla, el error 0
	call fcb_prepara		;91ed   ; fcb_prepara: registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848
	call disco_lee_d30c		;91f0   ; disco_lee_d30c: lee 3 registros a 0xD30C - 0x2000
	jp sale_del_disco_b		;91f3   ; sale_del_disco_b: espera y devuelve la RAM del juego
disco_graba_c000:		; graba 0x22 registros de 0x80 bytes desde 0xC000
	ld hl,0c000h		;91f6
	ld b,022h		;91f9
L_91FB:
	push hl			;91fb
	push bc			;91fc
	ld bc,00080h		;91fd
	call disco_graba_registro		;9200   ; disco_graba_registro: copia 0x80 bytes a 0x8000 y los graba (BDOS 0x26)
	pop bc			;9203
	pop hl			;9204
	ld de,00080h		;9205
	add hl,de			;9208
	djnz L_91FB		;9209
	ret			;920b
disco_graba_registro:		; copia 0x80 bytes a 0x8000 y los graba (BDOS 0x26) (gemela de p00:4C8E)
	push bc			;920c
	ld de,0c000h		;920d
	ldir		;9210
	ld de,0c000h		;9212
	ld c,01ah		;9215
	call 0f37dh		;9217
	pop hl			;921a
	call bdos_graba		;921b   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	ret			;921e
disco_graba_d459:		; graba 0x78 registros desde 0xD459
	ld de,0d459h		;921f
	ld c,01ah		;9222
	call 0f37dh		;9224
	ld hl,00078h		;9227
	jp bdos_graba		;922a   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
disco_graba_d30c:		; graba 3 registros desde 0xD30C - 0x2000
	ld hl,(0d30ch)		;922d
	ld bc,02000h		;9230
	and a			;9233
	sbc hl,bc		;9234
	ex de,hl			;9236
	ld c,01ah		;9237
	call 0f37dh		;9239
	ld hl,00003h		;923c
	jp bdos_graba		;923f   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
disco_lee_c000:		; lee 0x1100 registros a 0xC000
	ld de,0c000h		;9242
	ld c,01ah		;9245
	call 0f37dh		;9247
	ld hl,01100h		;924a
	jp bdos_lee		;924d   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_lee_d459:		; lee 0x78 registros a 0xD459
	ld de,0d459h		;9250
	ld c,01ah		;9253
	call 0f37dh		;9255
	ld hl,00078h		;9258
	jp bdos_lee		;925b   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_lee_d30c:		; lee 3 registros a 0xD30C - 0x2000
	ld hl,(0d30ch)		;925e
	ld bc,02000h		;9261
	and a			;9264
	sbc hl,bc		;9265
	ex de,hl			;9267
	ld c,01ah		;9268
	call 0f37dh		;926a
	ld hl,00003h		;926d
	jp bdos_lee		;9270   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
L_9273:
	ld de,0c000h		;9273
	ld c,01ah		;9276
	call 0f37dh		;9278
	ld hl,01000h		;927b
	jp bdos_graba		;927e   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
L_9281:
	ld de,0c000h		;9281
	ld c,01ah		;9284
	call 0f37dh		;9286
	ld hl,01000h		;9289
	jp bdos_lee		;928c   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
disco_lee_pantalla:		; lee la cabecera de pantalla y, si es buena, la VRAM
	call disco_lee_cabecera_pantalla		;928f   ; disco_lee_cabecera_pantalla: lee 9 bytes: el modo y los 8 registros del VDP
	ret nz			;9292
	call disco_lee_vram_bloques		;9293   ; disco_lee_vram_bloques: lee la VRAM por bloques de 0x80
	xor a			;9296
	ret			;9297
disco_lee_vram_bloques:		; lee la VRAM por bloques de 0x80
	ld de,00000h		;9298
L_929B:
	push de			;929b
	call disco_lee_palabra		;929c   ; disco_lee_palabra: lee una palabra del fichero en HL
	push hl			;929f
	ld de,0c000h		;92a0
	ld c,01ah		;92a3
	call 0f37dh		;92a5
	pop hl			;92a8
	call bdos_lee		;92a9   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	pop de			;92ac
	ld hl,0c000h		;92ad
	push de			;92b0
	call 0a4cfh		;92b1   ; descomprime: descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias (gemela de p01:733A)
	pop de			;92b4
	ld hl,00080h		;92b5
	add hl,de			;92b8
	ex de,hl			;92b9
	ld a,d			;92ba
	cp 040h		;92bb
	jr nz,L_929B		;92bd
	ret			;92bf
disco_lee_cabecera_pantalla:		; lee 9 bytes: el modo y los 8 registros del VDP
	ld de,0c000h		;92c0
	ld c,01ah		;92c3
	call 0f37dh		;92c5
	ld hl,00009h		;92c8
	call bdos_lee		;92cb   ; bdos_lee: BDOS 0x27, leer HL registros; si falla, el error 3
	ld hl,0c001h		;92ce
	ld e,008h		;92d1
	ld c,000h		;92d3
	call pon_registros_vdp		;92d5   ; pon_registros_vdp: escribe E registros del VDP desde HL, empezando por C
	ld a,(0c000h)		;92d8
	ld (0d4d2h),a		;92db
	and a			;92de
	ret z			;92df
	or 0ffh		;92e0
	ret			;92e2
pon_registros_vdp:		; escribe E registros del VDP desde HL, empezando por C (gemela de p00:4DFE)
	push bc			;92e3
	ld b,(hl)			;92e4
	inc hl			;92e5
	call 00047h		;92e6   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;92e9
	inc c			;92ea
	dec e			;92eb
	jr nz,pon_registros_vdp		;92ec
	ret			;92ee
disco_graba_cabecera_pantalla:		; graba 9 bytes: el modo (0xF3DF) y los registros del VDP
	ld de,0c000h		;92ef
	ld c,01ah		;92f2
	call 0f37dh		;92f4
	xor a			;92f7
	ld de,0c000h		;92f8
	ld (de),a			;92fb
	inc de			;92fc
	ld hl,0f3dfh		;92fd   ; apunta a los registros del VDP (copia de la BIOS)
	ld bc,00008h		;9300
	ldir		;9303
	ld hl,00009h		;9305
	call bdos_graba		;9308   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	ld hl,00000h		;930b
L_930E:
	push hl			;930e
	ld de,0c442h		;930f
	ld bc,00080h		;9312
	call 00059h		;9315   ; BIOS LDIRMV - Block transfers to memory from VRAM
	call 0a829h		;9318   ; comprime: comprime 0x8802 en 0x8002 (lo contrario de p01:733A) (gemela de p01:7707)
	ld de,0c000h		;931b
	ld c,01ah		;931e
	call 0f37dh		;9320
	ld hl,(0c000h)		;9323
	inc hl			;9326
	inc hl			;9327
	call bdos_graba		;9328   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	pop hl			;932b
	ld de,00080h		;932c
	add hl,de			;932f
	ld a,h			;9330
	cp 040h		;9331
	jr nz,L_930E		;9333
	ret			;9335
disco_graba_bload:		; graba la cabecera de BLOAD (0xFE, inicio, fin y ejecucion)
	ld a,0feh		;9336
	call disco_graba_byte		;9338   ; disco_graba_byte: graba el byte A en el fichero (por la pila)
	ld hl,00000h		;933b
	call disco_graba_palabra		;933e   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,03fffh		;9341
	call disco_graba_palabra		;9344   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,00000h		;9347
	call disco_graba_palabra		;934a   ; disco_graba_palabra: graba HL en el fichero, byte bajo primero
	ld hl,02000h		;934d
	ld b,018h		;9350
L_9352:
	push bc			;9352
	call disco_graba_100_de_vram		;9353   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;9356
	djnz L_9352		;9357
	ld hl,03800h		;9359
	ld b,008h		;935c
L_935E:
	push bc			;935e
	call disco_graba_100_de_vram		;935f   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;9362
	djnz L_935E		;9363
	ld hl,00000h		;9365
	ld b,018h		;9368
L_936A:
	push bc			;936a
	call disco_graba_100_de_vram		;936b   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;936e
	djnz L_936A		;936f
	ld hl,01800h		;9371
	ld b,008h		;9374
L_9376:
	push bc			;9376
	call disco_graba_100_de_vram		;9377   ; disco_graba_100_de_vram: lee 0x100 bytes de la VRAM y los graba
	pop bc			;937a
	djnz L_9376		;937b
	ret			;937d
disco_graba_100_de_vram:		; lee 0x100 bytes de la VRAM y los graba (gemela de p00:4F84)
	ld bc,00100h		;937e
disco_graba_bc_de_vram:		; lee BC bytes de la VRAM y los graba (gemela de p00:4F87)
	push hl			;9381
	push bc			;9382
	ld de,0c000h		;9383
	call 00059h		;9386   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld de,0c000h		;9389
	ld c,01ah		;938c
	call 0f37dh		;938e
	pop hl			;9391
	push hl			;9392
	call bdos_graba		;9393   ; bdos_graba: BDOS 0x26, grabar HL registros; si falla, el error 4
	pop bc			;9396
	pop hl			;9397
	add hl,bc			;9398
	ret			;9399
entra_al_disco_b:		; intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	di			;939a
	call intercambia_e000_c000		;939b   ; intercambia_e000_c000: intercambia 0x1100 bytes de 0xE000 y 0xC000
	ld hl,0f0ffh		;939e
	ld de,0f37fh		;93a1
	ld bc,01100h		;93a4
	lddr		;93a7
	ld hl,00000h		;93a9
	ld (0f1c0h),hl		;93ac
	ei			;93af
	ret			;93b0
sale_del_disco_b:		; espera y devuelve la RAM del juego
	di			;93b1
	ld bc,00200h		;93b2
L_93B5:
	push bc			;93b5   ; espera 0x200 vueltas...
	call 0d4f0h		;93b6   ; ...llamando a 0xD4F0
	pop bc			;93b9
	dec bc			;93ba
	ld a,b			;93bb
	or c			;93bc
	jr nz,L_93B5		;93bd   ; hasta que BC llega a 0
	di			;93bf
	ld hl,0e280h		;93c0   ; devuelve los 0x1100 bytes de 0xE280 a 0xE000
	ld de,0e000h		;93c3
	ld bc,01100h		;93c6
	ldir		;93c9
	call intercambia_e000_c000		;93cb   ; e intercambia otra vez 0xE000 con 0xC000
	ei			;93ce   ; con las interrupciones abiertas
	ret			;93cf
intercambia_e000_c000:		; intercambia 0x1100 bytes de 0xE000 y 0xC000
	ld hl,0e000h		;93d0
	ld de,0c000h		;93d3
	ld bc,01100h		;93d6
L_93D9:
	push bc			;93d9   ; intercambia un byte de HL con uno de DE
	ld b,(hl)			;93da
	ld a,(de)			;93db
	ld (hl),a			;93dc
	ld a,b			;93dd
	ld (de),a			;93de
	pop bc			;93df
	inc hl			;93e0   ; el siguiente
	inc de			;93e1
	dec bc			;93e2   ; BC bytes
	ld a,b			;93e3
	or c			;93e4
	jr nz,L_93D9		;93e5
	ret			;93e7
L_93E8:
	xor a			;93e8
	call 0a65fh		;93e9   ; menu: menu de B opciones con el cursor A: devuelve la elegida (gemela de p01:750E)
	ld a,(0d163h)		;93ec   ; lee cuantas letras lleva el nombre
	or a			;93ef
	ret z			;93f0
	ld hl,0d100h		;93f1   ; apunta a el nombre del fichero (FCB)
	ld (0d125h),hl		;93f4   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	ld d,h			;93f7
	ld e,l			;93f8
	ld (hl),020h		;93f9
	inc de			;93fb
	ld bc,00008h		;93fc
	ldir		;93ff
	xor a			;9401
	ld (de),a			;9402
	inc hl			;9403
	inc de			;9404
	ld bc,0001bh		;9405
	ldir		;9408
	ld de,0d100h		;940a   ; apunta a el nombre del fichero (FCB)
	ld (de),a			;940d
	inc de			;940e
	ld a,(0d163h)		;940f   ; lee cuantas letras lleva el nombre
	ld c,a			;9412
	ld b,000h		;9413
	ld hl,0d142h		;9415   ; apunta a el bufer de teclas
	ldir		;9418
	call nombre_de_fichero		;941a   ; nombre_de_fichero: pone en el FCB (0x982C) el nombre: tipo y numero de juego
	ld a,0ffh		;941d
	or a			;941f
	ret			;9420
nombre_de_fichero:		; pone en el FCB (0x982C) el nombre: tipo y numero de juego (gemela de p00:507D)
	ld de,0d109h		;9421
	ld hl,09439h		;9424
	ld a,(0d136h)		;9427   ; lee tipo y opcion del menu de disco
	and 00fh		;942a
	call 0a3e6h		;942c   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ldi		;942f
	ld a,(0d301h)		;9431   ; lee el codigo del juego (copia)
	ex de,hl			;9434
	call byte_a_hex		;9435   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	ret			;9438

; ----------------------------------------------------------------------
; DATOS resto_9439: lo apuntan con el banco puesto p02:9424 (0x9439); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9424 (4 bytes)
;   0x9439..0x943d  (4 bytes)
DATA_resto_9439:
	defb 048h,053h,047h,052h	; 9439

; ======================================================================
; CODIGO 0x943d..0x956f  (306 bytes)
; ======================================================================


byte_a_hex:		; escribe A en hexadecimal (dos letras) en HL (gemela de p00:5099)
	ld d,a			;943d   ; guarda A
	and 0f0h		;943e   ; la cifra alta...
	rrca			;9440   ; ...bajada a los cuatro bits de abajo
	rrca			;9441
	rrca			;9442
	rrca			;9443
	or 030h		;9444   ; en ASCII ('0'-'?', sin pasar a letras)
	ld (hl),a			;9446   ; la escribe
	inc hl			;9447
	ld a,d			;9448   ; la cifra baja
	and 00fh		;9449
	or 030h		;944b   ; en ASCII
	ld (hl),a			;944d   ; la escribe
	ret			;944e
borra_fcb:		; pone a cero el FCB de 0x982F (gemela de p00:50AB)
	ld hl,0d10ch		;944f
	ld de,0d10dh		;9452
	ld (hl),000h		;9455   ; ...a cero
	ld bc,00018h		;9457   ; 24 bytes
	ldir		;945a
	ret			;945c
hay_disco_b:		; Z si no hay disco (H.PHYD = ret) y 0xD4F9 no lo fuerza
	ld a,(0d4f9h)		;945d   ; 0xD4F9: hay disco aunque H.PHYD no lo diga
	and a			;9460
	jr nz,L_9469		;9461
	ld a,(0ffa7h)		;9463   ; H.PHYD es un `ret` si no hay disco
	cp 0c9h		;9466
	ret			;9468
L_9469:
	xor a			;9469
	ret			;946a
L_946B:
	ld (0d125h),de		;946b   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	xor a			;946f
	ld (de),a			;9470
	inc de			;9471
	ld bc,0000bh		;9472
	ldir		;9475
	xor a			;9477
	ld b,019h		;9478
L_947A:
	ld (de),a			;947a
	inc de			;947b
	djnz L_947A		;947c
	ret			;947e
L_947F:
	ld (0d125h),hl		;947f   ; guarda el puntero al FCB y el byte siguiente (16 bits)
fcb_prepara:		; registro 0, tamano de registro 1 y bloque actual en el FCB de 0x9848 (gemela de p00:50D6)
	ld hl,(0d125h)		;9482   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld bc,0000ch		;9485   ; el byte 12 del FCB (el bloque actual)...
	add hl,bc			;9488
	ld (hl),b			;9489   ; ...a cero, y el 13
	inc hl			;948a
	ld (hl),b			;948b
	inc hl			;948c
	ld bc,00001h		;948d   ; el tamano de registro a 1 (bytes 14 y 15)
	ld (hl),c			;9490
	inc hl			;9491
	ld (hl),b			;9492
	ld bc,00011h		;9493   ; el byte 33 del FCB: el registro aleatorio...
	add hl,bc			;9496
	ld b,005h		;9497   ; ...5 bytes...
	xor a			;9499   ; ...a cero
L_949A:
	ld (hl),a			;949a
	inc hl			;949b
	djnz L_949A		;949c
	ret			;949e
L_949F:
	ld hl,(0d125h)		;949f   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld bc,00010h		;94a2
	add hl,bc			;94a5
	ld a,(hl)			;94a6
	inc hl			;94a7
	ld h,(hl)			;94a8
	ld l,a			;94a9
	ret			;94aa
L_94AB:
	ld (0d125h),de		;94ab   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	jr L_94B5		;94af
fcb_registro:		; pone HL como registro aleatorio del FCB (gemela de p00:5105)
	ld de,(0d125h)		;94b1   ; lee el puntero al FCB y el byte siguiente (16 bits)
L_94B5:
	ex de,hl			;94b5   ; HL = el FCB
	ld bc,00021h		;94b6   ; el byte 33: el registro aleatorio
	add hl,bc			;94b9
	ld (hl),e			;94ba   ; = DE
	inc hl			;94bb
	ld (hl),d			;94bc
	ret			;94bd
bdos_abre:		; BDOS 0x0F, abrir fichero; si falla, el error 0 (gemela de p00:5112)
	ld de,(0d125h)		;94be   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,00fh		;94c2
	call 0f37dh		;94c4
	ld c,000h		;94c7
	inc a			;94c9
	jp z,L_9541		;94ca
	ret			;94cd
bdos_crea:		; BDOS 0x16, crear fichero; si falla, el error 1 (gemela de p00:5122)
	ld de,(0d125h)		;94ce   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,016h		;94d2
	call 0f37dh		;94d4
	ld c,001h		;94d7
	inc a			;94d9
	jp z,L_9541		;94da
	ret			;94dd
bdos_cierra:		; BDOS 0x10, cerrar fichero; si falla, el error 2 (gemela de p00:5132)
	ld de,(0d125h)		;94de   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,010h		;94e2
	call 0f37dh		;94e4
	ld c,002h		;94e7
	inc a			;94e9
	jp z,L_9541		;94ea
	ret			;94ed
bdos_lee:		; BDOS 0x27, leer HL registros; si falla, el error 3 (gemela de p00:5142)
	ld de,(0d125h)		;94ee   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,027h		;94f2
	call 0f37dh		;94f4
	ld c,003h		;94f7
	or a			;94f9
	jp nz,L_9541		;94fa
	ret			;94fd
bdos_graba:		; BDOS 0x26, grabar HL registros; si falla, el error 4 (gemela de p00:5152)
	ld de,(0d125h)		;94fe   ; lee el puntero al FCB y el byte siguiente (16 bits)
	ld c,026h		;9502
	call 0f37dh		;9504
	ld c,004h		;9507
	or a			;9509
	jp nz,L_9541		;950a
	ret			;950d
disco_lee_byte_b:		; lee un byte del fichero (por la pila)
	ld bc,bdos_lee		;950e
	jr L_9516		;9511
disco_graba_byte:		; graba el byte A en el fichero (por la pila) (gemela de p00:5167)
	ld bc,bdos_graba		;9513
L_9516:
	push af			;9516   ; guarda A
	ld hl,00001h		;9517   ; el byte guardado en la pila...
	add hl,sp			;951a
	push bc			;951b
	ex de,hl			;951c   ; ...es el bufer (DE)
	ld c,01ah		;951d   ; BDOS 0x1A: el bufer de los registros (DTA)
	call 0f37dh		;951f
	pop bc			;9522
	call un_registro_b		;9523   ; un registro de 1 byte por la rutina de BC
	pop af			;9526   ; A = el byte
	ret			;9527
un_registro_b:		; HL = 1 y salta a la rutina de BC
	ld hl,00001h		;9528
	push bc			;952b
	ret			;952c
disco_graba_palabra:		; graba HL en el fichero, byte bajo primero (gemela de p00:5181)
	push hl			;952d
	ld a,l			;952e
	call disco_graba_byte		;952f   ; disco_graba_byte: graba el byte A en el fichero (por la pila)
	pop hl			;9532
	ld a,h			;9533
	jr disco_graba_byte		;9534
disco_lee_palabra:		; lee una palabra del fichero en HL (gemela de p00:518A)
	call disco_lee_byte_b		;9536   ; disco_lee_byte_b: lee un byte del fichero (por la pila)
	ld l,a			;9539
	push hl			;953a
	call disco_lee_byte_b		;953b   ; disco_lee_byte_b: lee un byte del fichero (por la pila)
	pop hl			;953e
	ld h,a			;953f
	ret			;9540
L_9541:
	push bc			;9541
	call sale_del_disco_b		;9542   ; sale_del_disco_b: espera y devuelve la RAM del juego
	call 0a63ch		;9545
	call pinta_opcion_b		;9548   ; pinta_opcion_b: pinta la opcion elegida (0xD136, nibble alto)
	call pinta_tipo		;954b   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call pinta_juego_b		;954e   ; pinta_juego_b: pinta el numero de juego (0xD301) en hexadecimal
	ld hl,0956fh		;9551
	ld de,(0d16eh)		;9554   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	push de			;9558
	call 0a520h		;9559
	pop hl			;955c
	ld bc,00040h		;955d
	add hl,bc			;9560
	ex de,hl			;9561
	pop bc			;9562
	call error_de_disco		;9563   ; error_de_disco: pinta el mensaje del error C (tabla de p00:5209)
	call 0a644h		;9566
	ld sp,(0d127h)		;9569   ; lee la pila guardada al ir al disco y el byte siguiente (16 bits)
	scf			;956d
	ret			;956e

; ----------------------------------------------------------------------
; DATOS resto_956F: lo apuntan con el banco puesto p02:9551 (0x956F); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9551 (15 bytes)
;   0x956f..0x957e  (15 bytes)
DATA_resto_956F:
	defb 040h,040h,044h,049h,053h,04bh,000h,045h,052h,052h,04fh,052h,040h,040h,0ffh	; 956f  @@DISK.ERROR@@.

; ======================================================================
; CODIGO 0x957e..0x95a6  (40 bytes)
; ======================================================================


error_de_disco:		; pinta el mensaje del error C (tabla de p00:5209) (gemela de p00:51D2)
	ld a,c			;957e
	add a,a			;957f
	ld hl,095b5h		;9580
	call 0a3e6h		;9583   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9586
	inc hl			;9587
	ld h,(hl)			;9588
	ld l,a			;9589
	push de			;958a
	call 0a520h		;958b
	pop hl			;958e
	ld bc,00040h		;958f
	add hl,bc			;9592
	ld de,095a6h		;9593
	ex de,hl			;9596
	call 0a520h		;9597
	call 00156h		;959a   ; BIOS KILBUF - Clears keyboard buffer
L_959D:
	ld a,007h		;959d
	call 00141h		;959f   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rla			;95a2
	jr c,L_959D		;95a3
	ret			;95a5

; ----------------------------------------------------------------------
; DATOS resto_95A6: lo apuntan con el banco puesto p02:9593 (0x95A6), p02:9580
;   (0x95B5); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:9593, p02:9580 (107 bytes)
;   0x95a6..0x9611  (107 bytes)
DATA_resto_95A6:
	defb 048h,049h,054h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh,045h,059h,0ffh,0c1h	; 95a6  HIT.RETURN.KEY..
	defb 095h,0d2h,095h,0e3h,095h,0efh,095h,0e3h,095h,001h,096h,03dh,046h,049h,04ch,045h	; 95b6  ...........=FILE
	defb 000h,04eh,04fh,054h,000h,046h,04fh,055h,04eh,044h,03dh,0ffh,03dh,054h,04fh,04fh	; 95c6  .NOT.FOUND=.=TOO
	defb 000h,04dh,041h,04eh,059h,000h,046h,049h,04ch,045h,053h,03dh,0ffh,03dh,044h,049h	; 95d6  .MANY.FILES=.=DI
	defb 053h,04bh,000h,046h,055h,04ch,04ch,03dh,0ffh,03dh,044h,049h,053h,04bh,000h,052h	; 95e6  SK.FULL=.=DISK.R
	defb 045h,041h,044h,000h,045h,052h,052h,04fh,052h,03dh,0ffh,03dh,044h,049h,053h,04bh	; 95f6  EAD.ERROR=.=DISK
	defb 000h,049h,04fh,000h,045h,052h,052h,04fh,052h,03dh,0ffh	; 9606  .IO.ERROR=.

; ======================================================================
; CODIGO 0x9611..0x9637  (38 bytes)
; ======================================================================


ventana_b:		; abre una ventana de texto con el marco de DE
	ex de,hl			;9611
	ld hl,0d33eh		;9612
	push hl			;9615
	ld (0d33ch),hl		;9616
	ld hl,0d33ch		;9619
	ld (0d0a3h),hl		;961c
	pop hl			;961f   ; la direccion de vuelta
	push de			;9620
	ld de,09637h		;9621
	ld bc,0000dh		;9624
	ex de,hl			;9627
	ldir		;9628
	ld hl,0d343h		;962a
	ld a,(0d12eh)		;962d   ; ...del Game Master
	ld (hl),a			;9630
	inc hl			;9631
	pop de			;9632
	ld (hl),e			;9633   ; y la direccion de DE
	inc hl			;9634
	ld (hl),d			;9635
	ret			;9636

; ----------------------------------------------------------------------
; DATOS resto_9637: lo apuntan con el banco puesto p02:9621 (0x9637), p02:84C2
;   (0x9644), p02:85DF (0x9644), p02:88DA (0x9644), p02:85CF (0x965D),
;   p02:8C0B (0x965D); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:9621, p02:84C2, p02:85DF, p02:88DA, p02:85CF,
;   p02:8C0B (252 bytes)
;   0x9637..0x9733  (252 bytes)
DATA_resto_9637:
	defb 0fdh,0e5h,0ddh,0e5h,0f7h,000h,000h,000h,0ddh,0e1h,0fdh,0e1h,0c9h,0c5h,0cdh,0b1h	; 9637  ................
	defb 093h,0cdh,03ch,0a6h,0c1h,0cdh,074h,096h,0f5h,0cdh,044h,0a6h,0f1h,0dah,069h,095h	; 9647  ..<...t...D...i.
	defb 0cdh,09ah,093h,00eh,001h,0c9h,0c5h,0cdh,0b1h,093h,0c1h,0cdh,074h,096h,0dah,069h	; 9657  ............t..i
	defb 095h,0cdh,06eh,0a5h,0cdh,042h,085h,0cdh,09ah,093h,00eh,001h,0c9h,0c5h,0cdh,0f8h	; 9667  ..n..B..........
	defb 086h,0cdh,03ch,087h,0cdh,03ch,086h,021h,06fh,095h,0edh,05bh,06eh,0d1h,0cdh,020h	; 9677  ..<..<.!o..[n..
	defb 0a5h,0c1h,079h,0e6h,00eh,00fh,0feh,002h,038h,006h,0feh,006h,038h,046h,018h,006h	; 9687  ..y.....8...8F..
	defb 021h,0edh,096h,00fh,030h,003h,021h,0feh,096h,0ebh,02ah,06eh,0d1h,001h,040h,000h	; 9697  !...0.!...*n..@.
	defb 009h,0ebh,001h,011h,000h,0d5h,0cdh,05ch,000h,0e1h,001h,040h,000h,009h,0ebh,021h	; 96a7  .......\...@...!
	defb 00fh,097h,0d5h,0cdh,020h,0a5h,0e1h,001h,020h,000h,009h,011h,021h,097h,0ebh,0cdh	; 96b7  .... ... ...!...
	defb 020h,0a5h,0cdh,056h,001h,0cdh,09fh,000h,0feh,00dh,028h,006h,0feh,020h,028h,011h	; 96c7   ..V......(.. (.
	defb 018h,0f3h,0a7h,0c9h,02ah,06eh,0d1h,001h,040h,000h,009h,0ebh,00eh,005h,0cdh,07eh	; 96d7  ....*n..@......~
	defb 095h,0cdh,06eh,0a5h,037h,0c9h,03dh,057h,052h,049h,054h,045h,000h,050h,052h,04fh	; 96e7  ..n.7.=WRITE.PRO
	defb 054h,045h,043h,054h,045h,044h,03dh,03dh,044h,049h,053h,04bh,000h,04fh,046h,046h	; 96f7  TECTED==DISK.OFF
	defb 04ch,049h,04eh,045h,03dh,000h,000h,000h,052h,045h,054h,055h,052h,04eh,000h,04bh	; 9707  LINE=...RETURN.K
	defb 045h,059h,040h,040h,052h,045h,054h,052h,059h,0ffh,053h,050h,041h,043h,045h,000h	; 9717  EY@@RETRY.SPACE.
	defb 04bh,045h,059h,000h,040h,040h,041h,042h,04fh,052h,054h,0ffh	; 9727  KEY.@@ABORT.

; ======================================================================
; CODIGO 0x9733..0x980e  (219 bytes)
; ======================================================================


pide_nombre_fichero:		; lee el nombre del fichero letra a letra (gemela de p00:5393)
	xor a			;9733
	ld (0d163h),a		;9734   ; guarda cuantas letras lleva el nombre
	ld (0d165h),a		;9737   ; guarda la fila elegida
	ld hl,03a6ch		;973a
	ld (0d168h),hl		;973d   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld (0d16ah),hl		;9740   ; guarda la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	ld a,080h		;9743
	ld (0d164h),a		;9745
elige_fichero:		; lista los ficheros del disco y deja elegir uno (gemela de p00:53A8)
	call 0a74fh		;9748   ; cursor_apaga_b: quita el cursor
	ld (0d127h),sp		;974b   ; guarda la pila guardada al ir al disco
	call borra_lista_ficheros		;974f   ; borra_lista_ficheros: pone a cero la lista de ficheros (0x9103) y el FCB
	call busca_ficheros		;9752   ; busca_ficheros: busca los ficheros del disco (BDOS 0x11 y 0x12)
	jp z,L_97EA		;9755
	call texto_855c		;9758   ; texto_855c: pinta el texto de p02:855C
	call 0a778h		;975b   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
L_975E:
	call pinta_ficheros		;975e   ; pinta_ficheros: pinta la lista de ficheros
	call 00156h		;9761   ; BIOS KILBUF - Clears keyboard buffer
L_9764:
	ld hl,0d163h		;9764   ; apunta a cuantas letras lleva el nombre
	ld de,0d165h		;9767   ; apunta a la fila elegida
	call 0009fh		;976a   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;976d
	jr z,L_97DA		;976f
	cp 01fh		;9771
	jr z,L_97A2		;9773
	cp 020h		;9775
	jr nz,L_9764		;9777
	ld a,(0d163h)		;9779   ; lee cuantas letras lleva el nombre
	ld hl,0d34eh		;977c
	cp (hl)			;977f
	ccf			;9780
	ret c			;9781
	call fila_de_fichero		;9782   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	push hl			;9785
	call fcb_comodin		;9786   ; fcb_comodin: FCB con '?' en el nombre para buscar ficheros
	pop hl			;9789
	ld de,0d100h		;978a   ; apunta a el nombre del fichero (FCB)
	ld (0d125h),de		;978d   ; guarda el puntero al FCB y el byte siguiente (16 bits)
	inc de			;9791
	ld a,(0d129h)		;9792   ; lee el tipo de fichero elegido
	cp 001h		;9795
	ld bc,00008h		;9797
	jr nz,L_979E		;979a
	ld c,00bh		;979c
L_979E:
	ldir		;979e
	or a			;97a0
	ret			;97a1
L_97A2:
	ld a,(0d34eh)		;97a2   ; ya esta en el ultimo fichero
	cp (hl)			;97a5
	jr z,L_9764		;97a6
	inc (hl)			;97a8   ; el siguiente
	ld a,(de)			;97a9   ; la primera fila que se ve
	ld b,a			;97aa
	ld a,(hl)			;97ab   ; la fila elegida menos la primera
	sub b			;97ac
	cp 003h		;97ad   ; si cabe en las 3 filas de la ventana, no se mueve
	jr c,L_97B9		;97af
	inc b			;97b1   ; si no, la ventana baja una fila
	ld a,b			;97b2
	ld (de),a			;97b3
	ld bc,00000h		;97b4
	jr L_97BC		;97b7
L_97B9:
	ld bc,00020h		;97b9
L_97BC:
	call 0a788h		;97bc   ; cursor_borra_b: borra el cursor
	add hl,bc			;97bf
	push hl			;97c0
	ld de,(0d16ah)		;97c1   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	and a			;97c5
	sbc hl,de		;97c6
	ld a,(0d164h)		;97c8
	ld d,000h		;97cb
	ld e,a			;97cd
	rst 20h			;97ce   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;97cf
	jr nc,L_97D5		;97d0
	ld (0d168h),hl		;97d2   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
L_97D5:
	call 0a778h		;97d5   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
	jr L_975E		;97d8
L_97DA:
	ld a,(hl)			;97da   ; la fila elegida
	or a			;97db
	jr z,L_9764		;97dc   ; ya esta en la primera
	dec (hl)			;97de   ; la anterior
	ex de,hl			;97df
	ld a,(de)			;97e0   ; si queda por encima de la ventana...
	cp (hl)			;97e1
	jr nc,L_97E5		;97e2
	dec (hl)			;97e4   ; ...la ventana sube una fila
L_97E5:
	ld bc,0ffe0h		;97e5
	jr L_97BC		;97e8
L_97EA:
	ld hl,0980eh		;97ea
	ld de,(0d16ah)		;97ed   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	call 0a520h		;97f1
	ld de,09816h		;97f4
	ld hl,(0d16ah)		;97f7   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	ld bc,00040h		;97fa
	add hl,bc			;97fd
	ex de,hl			;97fe
	call 0a520h		;97ff
	call 00156h		;9802   ; BIOS KILBUF - Clears keyboard buffer
L_9805:
	call 0009fh		;9805   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;9808
	jr nz,L_9805		;980a
	scf			;980c
	ret			;980d

; ----------------------------------------------------------------------
; DATOS resto_980E: lo apuntan con el banco puesto p02:97EA (0x980E), p02:97F4
;   (0x9816), p00:4BA7 (0x9823), p00:504D (0x9823), p00:5066 (0x9823),
;   p00:53EA (0x9823); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:97EA, p02:97F4, p00:4BA7, p00:504D, p00:5066,
;   p00:53EA (23 bytes)
;   0x980e..0x9825  (23 bytes)
DATA_resto_980E:
	defb 04eh,04fh,000h,046h,049h,04ch,045h,0ffh,048h,049h,054h,000h,052h,045h,054h,055h	; 980e  NO.FILE.HIT.RETU
	defb 052h,04eh,000h,04bh,045h,059h,0ffh	; 981e

; ======================================================================
; CODIGO 0x9825..0x98e3  (190 bytes)
; ======================================================================


pinta_ficheros:		; pinta la lista de ficheros
	ld a,(0d165h)		;9825   ; lee la fila elegida
	call fila_de_fichero		;9828   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	ld de,(0d16ah)		;982b   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	inc de			;982f
	inc de			;9830
	ex de,hl			;9831
	ld b,003h		;9832
L_9834:
	push bc			;9834
	push hl			;9835
	push hl			;9836
	xor a			;9837
	ld bc,0000ch		;9838
	call 00056h		;983b   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;983e
	ld b,008h		;983f
L_9841:
	ld a,(de)			;9841
	cp 020h		;9842
	jr z,L_984A		;9844
	call 0004dh		;9846   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9849
L_984A:
	inc de			;984a
	djnz L_9841		;984b
	ld a,(0d129h)		;984d   ; lee el tipo de fichero elegido
	cp 001h		;9850
	jr nz,L_9868		;9852
	ld a,(de)			;9854
	or a			;9855
	jr z,L_985A		;9856
	ld a,03ch		;9858
L_985A:
	call 0004dh		;985a   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;985d
	ld b,003h		;985e
L_9860:
	ld a,(de)			;9860
	call 0004dh		;9861   ; BIOS WRTVRM - Writes data in VRAM
	inc de			;9864
	inc hl			;9865
	djnz L_9860		;9866
L_9868:
	pop hl			;9868   ; la fila siguiente de la pantalla
	ld bc,00020h		;9869
	add hl,bc			;986c
	pop bc			;986d
	djnz L_9834		;986e   ; las B filas
	ret			;9870
borra_lista_ficheros:		; pone a cero la lista de ficheros (0x9103) y el FCB (gemela de p00:54D3)
	ld hl,0d351h		;9871
	ld de,0d352h		;9874
	ld (hl),000h		;9877
	ld bc,00107h		;9879
	ldir		;987c
fcb_comodin:		; FCB con '?' en el nombre para buscar ficheros (gemela de p00:54E0)
	ld hl,0d100h		;987e   ; apunta a el nombre del fichero (FCB)
	ld de,0d101h		;9881
	ld (hl),000h		;9884
	ld bc,00024h		;9886
	ldir		;9889
	ld hl,0d101h		;988b
	ld de,0d102h		;988e
	ld (hl),03fh		;9891
	ld bc,0000ah		;9893
	ldir		;9896
	jp nombre_de_fichero		;9898   ; nombre_de_fichero: pone en el FCB (0x982C) el nombre: tipo y numero de juego
busca_ficheros:		; busca los ficheros del disco (BDOS 0x11 y 0x12) (gemela de p00:54FD)
	call entra_al_disco_b		;989b   ; entra_al_disco_b: intercambia la RAM del juego y desplaza 0xF0FF hacia arriba para el disco
	xor a			;989e
	ld (0d34eh),a		;989f
	ld de,0d351h		;98a2
	ld c,01ah		;98a5
	call 0f37dh		;98a7
	ld de,0d100h		;98aa   ; apunta a el nombre del fichero (FCB)
	ld c,011h		;98ad
	call 0f37dh		;98af
	inc a			;98b2
	jr z,L_98DE		;98b3
L_98B5:
	ld hl,0d34eh		;98b5
	inc (hl)			;98b8
	push hl			;98b9
	call guarda_fichero_hallado		;98ba   ; guarda_fichero_hallado: copia el nombre hallado a la lista
	pop hl			;98bd
	ld a,(hl)			;98be
	cp 014h		;98bf
	jr z,L_98CE		;98c1
	ld de,0d100h		;98c3   ; apunta a el nombre del fichero (FCB)
	ld c,012h		;98c6
	call 0f37dh		;98c8
	inc a			;98cb
	jr nz,L_98B5		;98cc
L_98CE:
	ld a,(0d34eh)		;98ce
	push af			;98d1
	ld de,098e3h		;98d2
	call copia_nombre		;98d5   ; copia_nombre: copia un nombre de la lista
	call sale_del_disco_b		;98d8   ; sale_del_disco_b: espera y devuelve la RAM del juego
	pop af			;98db
	or a			;98dc
	ret			;98dd
L_98DE:
	call sale_del_disco_b		;98de   ; sale_del_disco_b: espera y devuelve la RAM del juego
	xor a			;98e1
	ret			;98e2

; ----------------------------------------------------------------------
; DATOS resto_98E3: lo apuntan con el banco puesto p02:98D2 (0x98E3); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:98D2 (11 bytes)
;   0x98e3..0x98ee  (11 bytes)
DATA_resto_98E3:
	defb 040h,040h,045h,04eh,044h,040h,040h,000h,000h,000h,000h	; 98e3  @@END@@....

; ======================================================================
; CODIGO 0x98ee..0x994c  (94 bytes)
; ======================================================================


guarda_fichero_hallado:		; copia el nombre hallado a la lista (gemela de p00:5550)
	ld de,0d352h		;98ee
	ld a,(0d34eh)		;98f1
	dec a			;98f4
copia_nombre:		; copia un nombre de la lista (gemela de p00:5557)
	call fila_de_fichero		;98f5   ; fila_de_fichero: HL = la fila A de la lista de ficheros
	ex de,hl			;98f8
	ld bc,00008h		;98f9
	jr z,L_9900		;98fc
	ld c,00bh		;98fe
L_9900:
	ldir		;9900
	ret			;9902
fila_de_fichero:		; HL = la fila A de la lista de ficheros (gemela de p00:5565)
	ld l,a			;9903   ; HL = la fila A
	ld h,000h		;9904
	ld a,(0d129h)		;9906   ; el tipo de lista: 1 = nombre y extension (11 bytes); si no, 8
	cp 001h		;9909
	jr z,L_9912		;990b
	add hl,hl			;990d   ; 8 bytes por fila
	add hl,hl			;990e
	add hl,hl			;990f
	jr L_991B		;9910
L_9912:
	ld b,h			;9912   ; BC = la fila
	ld c,l			;9913
	add hl,hl			;9914   ; HL = fila x 12...
	add hl,bc			;9915
	add hl,hl			;9916
	add hl,hl			;9917
	and a			;9918
	sbc hl,bc		;9919   ; ...menos fila: 11 bytes por fila
L_991B:
	ld bc,0d372h		;991b
	add hl,bc			;991e
	or a			;991f
	ret			;9920
L_9921:
	call pon_opcion_b		;9921   ; pon_opcion_b: copia 0xD13C a 0xE000
	call 04058h		;9924   ; p09_801b: pasarela: 1-9-10, p09:801B y vuelve a 2-3
	jr L_993B		;9927
L_9929:
	call pon_opcion_b		;9929   ; pon_opcion_b: copia 0xD13C a 0xE000
	call 0404fh		;992c   ; p09_8043: pasarela: 1-9-10, p09:8043 y vuelve a 2-3
	call 04061h		;992f   ; p09_80d2: pasarela: 1-9-10, p09:80D2 y vuelve a 2-3
	call 04069h		;9932   ; p09_8117: pasarela: 1-9-10, p09:8117 y vuelve a 2-3
	call 04071h		;9935   ; p09_8133: pasarela: 1-9-10, p09:8133 y vuelve a 2-3
	call 04079h		;9938   ; p09_8134: pasarela: 1-9-10, p09:8134 y vuelve a 2-3
L_993B:
	call 04081h		;993b   ; p09_82ca: pasarela: 1-9-10, p09:82CA y vuelve a 2-3
	call 04089h		;993e   ; p09_846d: pasarela: 1-9-10, p09:846D y vuelve a 2-3 guardando AF
	push af			;9941
	call 0a47fh		;9942   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	call 04095h		;9945   ; p09_8191: pasarela: 1-9-10, p09:8191 y vuelve a 2-3
	pop af			;9948
	call 0a510h		;9949   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_994C: tabla de 3 palabras del despachador (call 0x408D en
;   0x9949); lo leen el despachador (6 bytes)
;   0x994c..0x9952  (6 bytes)
DATA_saltos_994C:
	defb 059h,099h	; 994c
	defb 081h,099h	; 994e
	defb 08ch,099h	; 9950

; ======================================================================
; CODIGO 0x9952..0x9b38  (486 bytes)
; ======================================================================


pon_opcion_b:		; copia 0xD13C a 0xE000
	ld a,(0d13ch)		;9952   ; lee la opcion elegida
	ld (0e000h),a		;9955
	ret			;9958
L_9959:
	ld a,(0d13ch)		;9959   ; lee la opcion elegida
	inc a			;995c
	jr nz,$-34		;995d
	ld bc,00107h		;995f
	call 00047h		;9962   ; BIOS WRTVDP - Writes data in the VDP-register
	call 0a47fh		;9965   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
L_9968:
	di			;9968
	ld hl,0fd9ah		;9969   ; apunta a el gancho H.KEYI
	ld a,0c9h		;996c
	ld b,00ah		;996e
L_9970:
	ld (hl),a			;9970   ; rellena B bytes con A
	inc hl			;9971
	djnz L_9970		;9972
	xor a			;9974   ; borra 0xD134 y 0xD13B
	ld (0d134h),a		;9975
	ld (0d13bh),a		;9978
	jp L_832C		;997b   ; y vuelve al juego
L_997E:
	jp 040efh		;997e
L_9981:
	ld a,(0d13ch)		;9981   ; lee la opcion elegida
	inc a			;9984
	jp nz,L_993B		;9985
	ld a,002h		;9988
	jr L_998E		;998a
L_998C:
	ld a,001h		;998c
L_998E:
	ld (0d129h),a		;998e   ; guarda el tipo de fichero elegido
	ld bc,00107h		;9991
	call 00047h		;9994   ; BIOS WRTVDP - Writes data in the VDP-register
	call 0a47fh		;9997   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00) (gemela de p01:72EA)
	call 04095h		;999a   ; p09_8191: pasarela: 1-9-10, p09:8191 y vuelve a 2-3
	ld a,(0d129h)		;999d   ; lee el tipo de fichero elegido
	cp 002h		;99a0
	jp z,L_89FB		;99a2
	jp L_87CB		;99a5
L_99A8:
	ld a,(0002dh)		;99a8   ; la version del MSX (0 = MSX1)
	and a			;99ab
	jr nz,L_99B8		;99ac
	ld hl,00000h		;99ae
	ld bc,04000h		;99b1
	xor a			;99b4
	jp 00056h		;99b5   ; BIOS FILVRM - Fills VRAM with value
L_99B8:
	ld hl,00000h		;99b8
	ld bc,00000h		;99bb
	xor a			;99be
	jp 0016bh		;99bf   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
L_99C2:
	ld b,001h		;99c2
L_99C4:
	ld hl,00000h		;99c4
espera_tecla:		; espera una tecla (CHSNS) HL x B veces (gemela de p01:6756)
	dec hl			;99c7
	call 0009ch		;99c8   ; BIOS CHSNS - Tests the status of the keyboard buffer
	ret nz			;99cb
	ld a,h			;99cc
	or l			;99cd
	jr nz,espera_tecla		;99ce
	djnz L_99C4		;99d0
	ret			;99d2
pinta_paleta_prueba:		; pinta los 16 colores en 0x3800 y 0x3A80 (gemela de p01:6762)
	ld hl,03800h		;99d3
	ld b,002h		;99d6
L_99D8:
	push bc			;99d8
	ld c,004h		;99d9
	call pinta_16_colores		;99db   ; pinta_16_colores: pinta 16 casillas con los colores 1-15 (gemela de p01:6774)
	pop bc			;99de
	ld hl,03a80h		;99df
	djnz L_99D8		;99e2
	ret			;99e4
pinta_16_colores:		; pinta 16 casillas con los colores 1-15 (gemela de p01:6774)
	ld b,010h		;99e5
	ld a,001h		;99e7
L_99E9:
	call 0004dh		;99e9   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;99ec
	call 0004dh		;99ed   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;99f0
	inc a			;99f1
	and 00fh		;99f2
	djnz L_99E9		;99f4
	dec c			;99f6
	jr nz,pinta_16_colores		;99f7
	ret			;99f9
L_99FA:
	ld a,(0d317h)		;99fa   ; lee las opciones del MODIFY (copia)
	ld b,a			;99fd
	bit 0,b		;99fe
	call nz,truco_vidas		;9a00   ; truco_vidas: las vidas: la rutina del juego de la tabla de p01:6CA6 (gemela de p01:67F3)
	bit 1,b		;9a03
	call nz,truco_fase		;9a05   ; truco_fase: la fase: la rutina del juego de la tabla de p01:6CD7 (gemela de p01:6804)
	bit 2,b		;9a08
	call nz,llama_al_juego_b		;9a0a   ; llama_al_juego_b: llama al juego (p00:4997)
	ld a,b			;9a0d
	and 0f8h		;9a0e
	ld d,a			;9a10
	call hay_ranking		;9a11   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286) (gemela de p01:68E1)
	jr z,L_9A26		;9a14
	ld a,(0d301h)		;9a16   ; lee el codigo del juego (copia)
	cp 015h		;9a19
	jr z,L_9A26		;9a1b
	ld hl,0d33ah		;9a1d
	inc (hl)			;9a20
	bit 1,(hl)		;9a21
	jr nz,L_9A26		;9a23
	ld d,b			;9a25
L_9A26:
	ei			;9a26
	ld hl,0d317h		;9a27   ; apunta a las opciones del MODIFY (copia)
	ld (hl),d			;9a2a
	bit 7,d		;9a2b
	ret z			;9a2d
	res 7,(hl)		;9a2e
	ld a,0ffh		;9a30
	ld (0d13bh),a		;9a32
	ld hl,0d322h		;9a35
	ld de,0d323h		;9a38
	ld (hl),03ch		;9a3b
	ld bc,0000fh		;9a3d
	ldir		;9a40
	ld hl,0d31ch		;9a42
	ld de,0d31dh		;9a45
	ld (hl),000h		;9a48
	ld bc,00005h		;9a4a
	ldir		;9a4d
	call silencia_psg_b		;9a4f   ; silencia_psg_b: pone a cero los tres volumenes del PSG (y el SCC del juego si 0xD4D4)
	call 0a578h		;9a52
	call menu_ranking_b		;9a55   ; menu_ranking_b: la pantalla del RANKING con el juego puesto
	call 0a5efh		;9a58
	xor a			;9a5b
	ld (0d13bh),a		;9a5c
	ld a,0ffh		;9a5f
	ld (0d332h),a		;9a61
	ret			;9a64
truco_vidas:		; las vidas: la rutina del juego de la tabla de p01:6CA6 (gemela de p01:67F3)
	ld a,(0d302h)		;9a65
	inc a			;9a68
	jr z,L_9A70		;9a69
	ld hl,09ee0h		;9a6b
	jr L_9A7F		;9a6e
L_9A70:
	push bc			;9a70
	call truco_9f69		;9a71   ; truco_9f69: pone 0xD319 en la variable del juego
	pop bc			;9a74
	ret			;9a75
truco_fase:		; la fase: la rutina del juego de la tabla de p01:6CD7 (gemela de p01:6804)
	ld a,(0d302h)		;9a76
	inc a			;9a79
	jr z,L_9A85		;9a7a
	ld hl,09f11h		;9a7c
L_9A7F:
	push bc			;9a7f
	call busca_en_tabla_y_salta		;9a80   ; busca_en_tabla_y_salta: busca 0xF281 en la tabla [codigo, direccion] de HL y salta (gemela de p01:6827)
	pop bc			;9a83
	ret			;9a84
L_9A85:
	push bc			;9a85
	call truco_9f7b		;9a86   ; truco_9f7b: calcula el valor que se escribe en el juego (p03:A21E)
	pop bc			;9a89
	ret			;9a8a
llama_al_juego_b:		; llama al juego (p00:4997)
	push bc			;9a8b
	call 04997h		;9a8c   ; llama_al_juego: llama al juego por CALSLT a 0xD314 con su slot (0xD12E) en la pagina 2
	pop bc			;9a8f
	ret			;9a90
busca_en_tabla_y_salta:		; busca 0xF281 en la tabla [codigo, direccion] de HL y salta (gemela de p01:6827)
	ld a,(hl)			;9a91
	inc a			;9a92
	ret z			;9a93
	ld a,(0d301h)		;9a94   ; lee el codigo del juego (copia)
	cp (hl)			;9a97
	inc hl			;9a98
	jr z,L_9A9F		;9a99
	inc hl			;9a9b
	inc hl			;9a9c
	jr busca_en_tabla_y_salta		;9a9d
L_9A9F:
	ld e,(hl)			;9a9f
	inc hl			;9aa0
	ld d,(hl)			;9aa1
	ex de,hl			;9aa2
	jp (hl)			;9aa3
busca_en_tabla:		; busca 0xF281 en la tabla [codigo, direccion] de HL (gemela de p01:683A)
	ld a,(hl)			;9aa4
	inc a			;9aa5
	jr z,L_9AB2		;9aa6
	ld a,(0d301h)		;9aa8   ; lee el codigo del juego (copia)
	cp (hl)			;9aab
	ret z			;9aac
	inc hl			;9aad
	inc hl			;9aae
	inc hl			;9aaf
	jr busca_en_tabla		;9ab0
L_9AB2:
	inc a			;9ab2
	ret			;9ab3
menu_ranking_b:		; la pantalla del RANKING con el juego puesto
	ld hl,03a8ch		;9ab4
	ld bc,00312h		;9ab7
	xor a			;9aba
	call 0a53bh		;9abb
	ld hl,09bc2h		;9abe
	call 0a524h		;9ac1   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	call pinta_ranking_b		;9ac4   ; pinta_ranking_b: pinta la cabecera y las filas del ranking
	ld hl,03acch		;9ac7
	call menu_ocho_b		;9aca   ; menu_ocho_b: menu de 8 opciones (p03:A65F)
	jr z,L_9AE8		;9acd
	ld hl,0d142h		;9acf   ; apunta a el bufer de teclas
	ld de,0d322h		;9ad2
	ld bc,00008h		;9ad5
	ldir		;9ad8
	ld hl,0d31ch		;9ada
	call borra_3		;9add   ; borra_3: pone a cero 3 bytes en HL (gemela de p01:68DA)
	ld a,031h		;9ae0
	call ranking_quita_marca		;9ae2   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257) (gemela de p01:6912)
	call pinta_ranking_b		;9ae5   ; pinta_ranking_b: pinta la cabecera y las filas del ranking
L_9AE8:
	call hay_ranking		;9ae8   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286) (gemela de p01:68E1)
	jr z,L_9B1D		;9aeb
	ld hl,09bdch		;9aed
	call 0a524h		;9af0   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03acch		;9af3
	push hl			;9af6
	ld bc,0000ah		;9af7
	xor a			;9afa
	call 00056h		;9afb   ; BIOS FILVRM - Fills VRAM with value
	pop hl			;9afe
	call menu_ocho_b		;9aff   ; menu_ocho_b: menu de 8 opciones (p03:A65F)
	jr z,L_9B1D		;9b02
	ld hl,0d142h		;9b04   ; apunta a el bufer de teclas
	ld de,0d32ah		;9b07
	ld bc,00008h		;9b0a
	ldir		;9b0d
	ld hl,0d31fh		;9b0f
	call borra_3		;9b12   ; borra_3: pone a cero 3 bytes en HL (gemela de p01:68DA)
	ld a,032h		;9b15
	call ranking_quita_marca		;9b17   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257) (gemela de p01:6912)
	call pinta_ranking_b		;9b1a   ; pinta_ranking_b: pinta la cabecera y las filas del ranking
L_9B1D:
	ld hl,03a8ch		;9b1d
	ld bc,00312h		;9b20
	xor a			;9b23
	call 0a53bh		;9b24
	ld hl,09c06h		;9b27
	call 0a524h		;9b2a   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,09c13h		;9b2d
	ld b,002h		;9b30
	call 0a7b2h		;9b32   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige (gemela de p01:7690)
	call 0a510h		;9b35   ; despacha: salta a la palabra A de la tabla pegada detras del `call` (gemela de p01:737B)

; ----------------------------------------------------------------------
; DATOS saltos_9B38: tabla de 2 palabras del despachador (call 0x408D en
;   0x9B35); lo leen el despachador (4 bytes)
;   0x9b38..0x9b3c  (4 bytes)
DATA_saltos_9B38:
	defb 03ch,09bh	; 9b38
	defb 0b4h,09ah	; 9b3a

; ======================================================================
; CODIGO 0x9b3c..0x9bc2  (134 bytes)
; ======================================================================


L_9B3C:
	ret			;9b3c
menu_ocho_b:		; menu de 8 opciones (p03:A65F)
	ld a,0feh		;9b3d
	ld b,008h		;9b3f
	jp 0a65fh		;9b41   ; menu: menu de B opciones con el cursor A: devuelve la elegida (gemela de p01:750E)
borra_3:		; pone a cero 3 bytes en HL (gemela de p01:68DA)
	xor a			;9b44   ; pone a cero 3 bytes
	ld (hl),a			;9b45
	inc hl			;9b46
	ld (hl),a			;9b47
	inc hl			;9b48
	ld (hl),a			;9b49
	ret			;9b4a
hay_ranking:		; Z si el juego no tiene ranking (0xF290, 0xF286) (gemela de p01:68E1)
	ld hl,(0d310h)		;9b4b
	ld a,h			;9b4e   ; sin puntos no hay ranking
	or l			;9b4f
	ret z			;9b50
	ld hl,(0d306h)		;9b51
	ld a,h			;9b54   ; tampoco sin el
	or l			;9b55
	ret z			;9b56
	ld a,(0d301h)		;9b57   ; lee el codigo del juego (copia)
	ld c,a			;9b5a   ; C = el codigo del juego
	sub 003h		;9b5b   ; los juegos de codigo 3 y 4...
	cp 002h		;9b5d
	jr c,L_9B71		;9b5f
	ld a,c			;9b61   ; ...y los de 0x10 y 0x11...
	sub 010h		;9b62
	cp 002h		;9b64
	jr nc,L_9B6D		;9b66
	ld a,(hl)			;9b68   ; ...miran el bit 0 de su variable: si esta a 1, no hay ranking
	cpl			;9b69
	and 001h		;9b6a
	ret			;9b6c
L_9B6D:
	ld a,(hl)			;9b6d
	bit 5,a		;9b6e
	ret			;9b70
L_9B71:
	ld a,(hl)			;9b71
	and 001h		;9b72
	ret			;9b74
ranking_quita_1_y_2:		; quita las marcas 1 y 2 del ranking (gemela de p01:690B)
	ld a,031h		;9b75
	call ranking_quita_marca		;9b77   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257) (gemela de p01:6912)
	ld a,032h		;9b7a
ranking_quita_marca:		; quita la marca A de las 10 filas del ranking (0x9257) (gemela de p01:6912)
	ld hl,0d477h		;9b7c
	ld b,00ah		;9b7f
	ld c,a			;9b81
L_9B82:
	ld a,c			;9b82
	cp (hl)			;9b83
	jr nz,L_9B88		;9b84
	ld (hl),000h		;9b86
L_9B88:
	ld a,009h		;9b88
	call 0a3e6h		;9b8a   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	djnz L_9B82		;9b8d
	ret			;9b8f
pinta_ranking_b:		; pinta la cabecera y las filas del ranking
	ld hl,03a2ch		;9b90
	ld bc,00212h		;9b93
	xor a			;9b96
	call 0a53bh		;9b97
	ld hl,09bech		;9b9a
	call 0a524h		;9b9d   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,0d322h		;9ba0
	ld de,03a36h		;9ba3
	ld bc,00008h		;9ba6
	call 0005ch		;9ba9   ; BIOS LDIRVM - Block transfers to VRAM from memory
	call hay_ranking		;9bac   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286) (gemela de p01:68E1)
	ret z			;9baf
	ld hl,09bf9h		;9bb0
	call 0a524h		;9bb3   ; pinta_texto_b: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,0d32ah		;9bb6
	ld de,03a56h		;9bb9
	ld bc,00008h		;9bbc
	jp 0005ch		;9bbf   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS resto_9BC2: lo apuntan con el banco puesto p02:9ABE (0x9BC2), p02:9AED
;   (0x9BDC), p02:9B9A (0x9BEC), p02:9BB0 (0x9BF9), p02:9B27 (0x9C06),
;   p02:9B2D (0x9C13); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:9ABE, p02:9AED, p02:9B9A, p02:9BB0, p02:9B27,
;   p02:9B2D (85 bytes)
;   0x9bc2..0x9c17  (85 bytes)
DATA_resto_9BC2:
	defb 021h,03ah,052h,041h,04eh,04bh,049h,04eh,047h,0feh,08ch,03ah,049h,04eh,050h,055h	; 9bc2  !:RANKING..:INPU
	defb 054h,000h,031h,050h,000h,04eh,041h,04dh,045h,0ffh,08ch,03ah,049h,04eh,050h,055h	; 9bd2  T.1P.NAME..:INPU
	defb 054h,000h,032h,050h,000h,04eh,041h,04dh,045h,0ffh,02ch,03ah,031h,050h,000h,04eh	; 9be2  T.2P.NAME.,:1P.N
	defb 041h,04dh,045h,000h,03eh,000h,0ffh,04ch,03ah,032h,050h,000h,04eh,041h,04dh,045h	; 9bf2  AME.>..L:2P.NAME
	defb 000h,03eh,000h,0ffh,08ch,03ah,04fh,04bh,0feh,0cch,03ah,052h,045h,054h,052h,059h	; 9c02  .>...:OK..:RETRY
	defb 0ffh,08bh,03ah,0cbh,03ah	; 9c12

; ======================================================================
; CODIGO 0x9c17..0x9e6f  (600 bytes)
; ======================================================================


ranking_entra:		; mete la puntuacion en el ranking (gemela de p01:69AD)
	ld hl,0d31eh		;9c17
	ld a,031h		;9c1a
	call ranking_busca_marca		;9c1c   ; ranking_busca_marca: busca la marca A en el ranking (gemela de p01:69BE)
	call hay_ranking		;9c1f   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286) (gemela de p01:68E1)
	ret z			;9c22
	ld hl,0d321h		;9c23
	ld a,032h		;9c26
ranking_busca_marca:		; busca la marca A en el ranking (gemela de p01:69BE)
	ld de,0d477h		;9c28
	ex de,hl			;9c2b
	ld c,a			;9c2c
	ld b,00ah		;9c2d
L_9C2F:
	ld a,c			;9c2f
	cp (hl)			;9c30
	jr z,L_9C3E		;9c31
	ld a,009h		;9c33
	call 0a3e6h		;9c35   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	djnz L_9C2F		;9c38
	ld b,009h		;9c3a
	jr L_9C45		;9c3c
L_9C3E:
	ld a,00ah		;9c3e
	sub b			;9c40
	ld b,a			;9c41
	jp z,L_9C79		;9c42
L_9C45:
	ld a,c			;9c45
	ld c,000h		;9c46
	ld hl,0d45bh		;9c48
L_9C4B:
	push af			;9c4b   ; guarda los registros para la comparacion
	push bc			;9c4c
	push hl			;9c4d
	push de			;9c4e
	ld b,003h		;9c4f   ; los puntos son 3 bytes BCD
	ex de,hl			;9c51
L_9C52:
	ld a,(de)			;9c52   ; compara de la cifra alta a la baja
	cp (hl)			;9c53
	jr c,L_9C5C		;9c54   ; menor: se queda debajo
	jr nz,L_9C69		;9c56   ; mayor: entra aqui
	dec de			;9c58   ; la cifra siguiente
	dec hl			;9c59
	djnz L_9C52		;9c5a   ; los 3 bytes
L_9C5C:
	pop de			;9c5c
	pop hl			;9c5d
	pop bc			;9c5e
	pop af			;9c5f
	call ranking_ordena		;9c60   ; ranking_ordena: ordena el ranking (gemela de p01:6A14)
	call ranking_mueve		;9c63   ; ranking_mueve: mueve una fila del ranking (gemela de p01:6A59)
	jp L_9CE4		;9c66
L_9C69:
	pop de			;9c69
	pop hl			;9c6a
	pop bc			;9c6b
	pop af			;9c6c
	inc hl			;9c6d   ; la fila siguiente (3 bytes de puntos)
	inc hl			;9c6e
	inc hl			;9c6f
	inc c			;9c70   ; C = la posicion
	djnz L_9C4B		;9c71   ; las B filas
	call ranking_mueve		;9c73   ; ranking_mueve: mueve una fila del ranking (gemela de p01:6A59)
	jp L_9CE4		;9c76   ; y pinta el ranking
L_9C79:
	ld a,c			;9c79
	ld c,b			;9c7a
	jp ranking_mueve		;9c7b   ; ranking_mueve: mueve una fila del ranking (gemela de p01:6A59)
ranking_ordena:		; ordena el ranking (gemela de p01:6A14)
	ld ix,0d458h		;9c7e
	ld iy,0d45bh		;9c82
	ld d,000h		;9c86
	call ranking_compara		;9c88   ; ranking_compara: compara dos filas del ranking (gemela de p01:6A2B)
	ld ix,0d476h		;9c8b
	ld iy,0d47fh		;9c8f
	ld d,001h		;9c93
ranking_compara:		; compara dos filas del ranking (gemela de p01:6A2B)
	push af			;9c95
	push bc			;9c96
	ld e,b			;9c97   ; E = la fila
	ld a,c			;9c98   ; C + B...
	add a,b			;9c99
	ld b,a			;9c9a
	add a,a			;9c9b   ; ...por 3 (puntos)
	add a,b			;9c9c
	bit 0,d		;9c9d   ; bit 0 de D: los nombres...
	jr z,L_9CA4		;9c9f
	ld b,a			;9ca1   ; ...que son 9 bytes (por 3 otra vez)
	add a,a			;9ca2
	add a,b			;9ca3
L_9CA4:
	ld c,a			;9ca4   ; BC = el desplazamiento
	ld b,000h		;9ca5
	add ix,bc		;9ca7   ; IX e IY a esa fila
	add iy,bc		;9ca9
	ld a,e			;9cab   ; E por 3...
	add a,a			;9cac
	add a,e			;9cad
	bit 0,d		;9cae   ; ...o por 9 si son nombres
	jr z,L_9CB5		;9cb0
	ld b,a			;9cb2
	add a,a			;9cb3
	add a,b			;9cb4
L_9CB5:
	ld c,a			;9cb5   ; BC = los bytes que hay que mover
	ld b,000h		;9cb6
	push ix		;9cb8   ; HL = IX
	pop hl			;9cba
	push iy		;9cbb   ; DE = IY
	pop de			;9cbd
	lddr		;9cbe   ; baja las filas una posicion
	pop bc			;9cc0
	pop af			;9cc1
	ret			;9cc2
ranking_mueve:		; mueve una fila del ranking (gemela de p01:6A59)
	push af			;9cc3   ; guarda los registros
	push bc			;9cc4
	push af			;9cc5
	ld a,c			;9cc6   ; la fila x 3: los puntos
	ld b,a			;9cc7
	add a,a			;9cc8
	add a,b			;9cc9
	ld hl,0d459h		;9cca   ; en el ranking (0xD459)
	call 0a3e6h		;9ccd   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	pop af			;9cd0
	ld de,0d31ch		;9cd1   ; los puntos que entran (0xD31C)...
	cp 032h		;9cd4   ; ...o, con la marca 2 ('2'), los de 0xD31F
	jr nz,L_9CDB		;9cd6
	ld de,0d31fh		;9cd8
L_9CDB:
	ex de,hl			;9cdb   ; copia los 3 bytes de los puntos
	ld bc,00003h		;9cdc
	ldir		;9cdf
	pop bc			;9ce1
	pop af			;9ce2
	ret			;9ce3
L_9CE4:
	push af			;9ce4   ; guarda los registros
	push bc			;9ce5
	push af			;9ce6
	ld a,c			;9ce7   ; la fila x 9: el nombre
	ld b,a			;9ce8
	add a,a			;9ce9
	add a,b			;9cea
	ld b,a			;9ceb
	add a,a			;9cec
	add a,b			;9ced
	ld hl,0d477h		;9cee   ; en el ranking (0xD477)
	call 0a3e6h		;9cf1   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	pop af			;9cf4
	ld de,0d322h		;9cf5   ; el nombre que entra (0xD322)...
	cp 032h		;9cf8   ; ...o, con la marca 2, el de 0xD32A
	jr nz,L_9CFF		;9cfa
	ld de,0d32ah		;9cfc
L_9CFF:
	ex de,hl			;9cff   ; la marca de la fila...
	ld (de),a			;9d00
	inc de			;9d01
	ld bc,00008h		;9d02   ; ...y los 8 bytes del nombre
	ldir		;9d05
	pop bc			;9d07
	pop af			;9d08
	ret			;9d09
ranking_nombre:		; pide el nombre para el ranking (gemela de p01:6AA0)
	ld hl,03a29h		;9d0a
	ld bc,00616h		;9d0d
	xor a			;9d10
	call 0a53bh		;9d11
	call 0a74fh		;9d14   ; cursor_apaga_b: quita el cursor
	xor a			;9d17
	ld (0d163h),a		;9d18   ; guarda cuantas letras lleva el nombre
	ld (0d165h),a		;9d1b   ; guarda la fila elegida
	ld hl,03a29h		;9d1e
	ld (0d16ah),hl		;9d21   ; guarda la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	inc hl			;9d24
	ld (0d168h),hl		;9d25   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld a,0c0h		;9d28
	ld (0d164h),a		;9d2a
	call 0a778h		;9d2d   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
L_9D30:
	call ranking_pinta_fila		;9d30   ; ranking_pinta_fila: pinta una fila del ranking
	call 00156h		;9d33   ; BIOS KILBUF - Clears keyboard buffer
L_9D36:
	ld hl,0d163h		;9d36   ; apunta a cuantas letras lleva el nombre
	ld de,0d165h		;9d39   ; apunta a la fila elegida
	call 0009fh		;9d3c   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;9d3f
	jr z,L_9D86		;9d41
	cp 01fh		;9d43
	jr z,L_9D4C		;9d45
	cp 020h		;9d47
	jr nz,L_9D36		;9d49
	ret			;9d4b
L_9D4C:
	ld a,009h		;9d4c   ; ya esta en la ultima fila (9)
	cp (hl)			;9d4e
	jr z,L_9D36		;9d4f
	inc (hl)			;9d51   ; la siguiente
	ld a,(de)			;9d52   ; la primera fila que se ve
	ld b,a			;9d53
	ld a,(hl)			;9d54   ; la elegida menos la primera
	sub b			;9d55
	cp 005h		;9d56   ; si cabe en las 5 filas de la ventana, no se mueve
	jr c,L_9D62		;9d58
	inc b			;9d5a   ; si no, la ventana baja una fila
	ld a,b			;9d5b
	ld (de),a			;9d5c
	ld bc,00000h		;9d5d
	jr L_9D65		;9d60
L_9D62:
	ld bc,00020h		;9d62
L_9D65:
	ld a,(hl)			;9d65
	cp 009h		;9d66
	jr nz,L_9D6B		;9d68
	dec bc			;9d6a
L_9D6B:
	call 0a788h		;9d6b   ; cursor_borra_b: borra el cursor
	add hl,bc			;9d6e
	push hl			;9d6f
	ld de,(0d16ah)		;9d70   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	and a			;9d74
	sbc hl,de		;9d75
	ld a,(0d164h)		;9d77
	ld d,000h		;9d7a
	ld e,a			;9d7c
	rst 20h			;9d7d   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;9d7e
	jr nc,L_9D84		;9d7f
	ld (0d168h),hl		;9d81   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
L_9D84:
	jr L_9D30		;9d84
L_9D86:
	ld a,(hl)			;9d86   ; la fila elegida
	or a			;9d87
	jr z,L_9D36		;9d88   ; ya esta en la primera
	dec (hl)			;9d8a   ; la anterior
	ex de,hl			;9d8b
	ld a,(de)			;9d8c   ; si queda por encima de la ventana...
	cp (hl)			;9d8d
	jr nc,L_9D91		;9d8e
	dec (hl)			;9d90   ; ...la ventana sube una fila
L_9D91:
	ld bc,0ffe0h		;9d91
	ld a,(de)			;9d94
	cp 008h		;9d95
	jr nz,L_9D9A		;9d97
	inc bc			;9d99
L_9D9A:
	jr L_9D6B		;9d9a
ranking_pinta_fila:		; pinta una fila del ranking
	ld a,(0d165h)		;9d9c   ; lee la fila elegida
	call fila_de_ranking		;9d9f   ; fila_de_ranking: HL = la fila A del ranking (0x9257, 9 bytes) (gemela de p01:6C38)
	push hl			;9da2
	pop ix		;9da3
	ld a,(0d165h)		;9da5   ; lee la fila elegida
	call puntos_de_ranking		;9da8   ; puntos_de_ranking: HL = los puntos de la fila A (0x9239, 3 bytes) (gemela de p01:6C46)
	push hl			;9dab
	pop iy		;9dac
	ld hl,(0d16ah)		;9dae   ; lee la posicion de la ventana en la VRAM y el byte siguiente (16 bits)
	inc hl			;9db1
	ld a,(0d165h)		;9db2   ; lee la fila elegida
	add a,031h		;9db5
	ld c,a			;9db7
	ld b,005h		;9db8
L_9DBA:
	push bc			;9dba
	push hl			;9dbb
	push hl			;9dbc
	push bc			;9dbd
	xor a			;9dbe
	ld bc,00015h		;9dbf
	call 00056h		;9dc2   ; BIOS FILVRM - Fills VRAM with value
	call 0a778h		;9dc5   ; cursor_pinta_b: pinta el cursor (':' o el de MSX2)
	pop bc			;9dc8
	pop hl			;9dc9
	ld a,c			;9dca
	cp 03ah		;9dcb
	jr z,L_9DD5		;9dcd
	inc hl			;9dcf
	call 0004dh		;9dd0   ; BIOS WRTVRM - Writes data in VRAM
	jr L_9DE0		;9dd3
L_9DD5:
	ld a,031h		;9dd5
	call 0004dh		;9dd7   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9dda
	ld a,030h		;9ddb
	call 0004dh		;9ddd   ; BIOS WRTVRM - Writes data in VRAM
L_9DE0:
	inc hl			;9de0
	ld a,03bh		;9de1
	call 0004dh		;9de3   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9de6
	push ix		;9de7
	pop de			;9de9
	ex de,hl			;9dea
	ld bc,00008h		;9deb
	push de			;9dee
	push bc			;9def
	call 0005ch		;9df0   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,0da00h		;9df3
	ld a,(iy+002h)		;9df6
	call byte_a_hex		;9df9   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	inc hl			;9dfc
	ld a,(iy+001h)		;9dfd
	call byte_a_hex		;9e00   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	inc hl			;9e03
	ld a,(iy+000h)		;9e04
	call byte_a_hex		;9e07   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	pop bc			;9e0a
	pop hl			;9e0b
	add hl,bc			;9e0c
	ld a,03eh		;9e0d
	call 0004dh		;9e0f   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e12
	ld de,0da00h		;9e13
	ld bc,00600h		;9e16
	ld a,(0d301h)		;9e19   ; lee el codigo del juego (copia)
	cp 029h		;9e1c
	jr nz,L_9E23		;9e1e
	inc de			;9e20
	dec b			;9e21
	inc c			;9e22
L_9E23:
	ld a,(de)			;9e23   ; se salta los ceros de la izquierda
	cp 030h		;9e24
	jr nz,L_9E37		;9e26
	inc hl			;9e28
	inc de			;9e29
	djnz L_9E23		;9e2a
	bit 0,c		;9e2c   ; bit 0 de C: si el numero es impar de cifras...
	jr nz,L_9E31		;9e2e
	dec hl			;9e30   ; ...retrocede una
L_9E31:
	call 0004dh		;9e31   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e34
	jr L_9E4F		;9e35
L_9E37:
	push bc			;9e37
	ld c,b			;9e38
	ld b,000h		;9e39
	ex de,hl			;9e3b
	push bc			;9e3c
	push de			;9e3d
	call 0005ch		;9e3e   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;9e41
	pop bc			;9e42
	add hl,bc			;9e43
	pop bc			;9e44
	bit 0,c		;9e45
	jr z,L_9E4F		;9e47
	ld a,030h		;9e49
	call 0004dh		;9e4b   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;9e4e
L_9E4F:
	ld de,09e6fh		;9e4f   ; pinta las tres letras de p02:9E6F
	ex de,hl			;9e52
	ld bc,00003h		;9e53
	call 0005ch		;9e56   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld bc,00009h		;9e59   ; la fila siguiente del ranking: 9 bytes de nombre...
	add ix,bc		;9e5c
	ld bc,00003h		;9e5e   ; ...y 3 de puntos
	add iy,bc		;9e61
	pop hl			;9e63
	ld bc,00020h		;9e64   ; la fila siguiente de la pantalla
	add hl,bc			;9e67
	pop bc			;9e68
	inc c			;9e69   ; la posicion
	dec b			;9e6a   ; las B filas
	jp nz,L_9DBA		;9e6b
	ret			;9e6e

; ----------------------------------------------------------------------
; DATOS resto_9E6F: lo apuntan con el banco puesto p02:9E4F (0x9E6F); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p02:9E4F (3 bytes)
;   0x9e6f..0x9e72  (3 bytes)
DATA_resto_9E6F:
	defb 050h,054h,053h	; 9e6f

; ======================================================================
; CODIGO 0x9e72..0x9e8a  (24 bytes)
; ======================================================================


fila_de_ranking:		; HL = la fila A del ranking (0x9257, 9 bytes) (gemela de p01:6C38)
	ld b,a			;9e72
	add a,a			;9e73
	add a,b			;9e74
	ld b,a			;9e75
	add a,a			;9e76
	add a,b			;9e77
	ld hl,0d477h		;9e78
	call 0a3e6h		;9e7b   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	inc hl			;9e7e
	ret			;9e7f
puntos_de_ranking:		; HL = los puntos de la fila A (0x9239, 3 bytes) (gemela de p01:6C46)
	ld b,a			;9e80
	add a,a			;9e81
	add a,b			;9e82
	ld hl,0d459h		;9e83
	call 0a3e6h		;9e86   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ret			;9e89

; ----------------------------------------------------------------------
; DATOS resto_9E8A: lo apuntan con el banco puesto p02:8ABB (0x9EE0), p02:9A6B
;   (0x9EE0), p02:8A3F (0x9F11), p02:9A7C (0x9F11); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p02:8ABB, p02:9A6B,
;   p02:8A3F, p02:9A7C (199 bytes)
;   0x9e8a..0x9f51  (199 bytes)
DATA_resto_9E8A:
	defb 0b1h,0d9h,02ah,02ah,02ah,020h,052h,043h,02dh,037h,020h,020h,020h,053h,043h,04fh	; 9e8a  ..*** RC-7   SCO
	defb 052h,045h,020h,052h,041h,04eh,04bh,049h,04eh,047h,020h,02ah,02ah,02ah,0feh,0ebh	; 9e9a  RE RANKING ***..
	defb 0d9h,052h,061h,06eh,06bh,02eh,020h,020h,04eh,061h,06dh,065h,02eh,020h,020h,020h	; 9eaa  .Rank.  Name.
	defb 053h,063h,06fh,072h,065h,02eh,0feh,005h,0dah,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 9eba  Score....-------
	defb 02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 9eca  ----------------
	defb 02dh,02dh,02dh,02dh,02dh,0ffh,000h,061h,09fh,002h,061h,09fh,003h,061h,09fh,004h	; 9eda  -----..a..a..a..
	defb 061h,09fh,005h,061h,09fh,006h,061h,09fh,012h,061h,09fh,013h,061h,09fh,014h,061h	; 9eea  a..a..a..a..a..a
	defb 09fh,016h,061h,09fh,025h,051h,09fh,021h,061h,09fh,027h,061h,09fh,028h,06eh,09fh	; 9efa  ..a.%Q.!a.'a.(n.
	defb 029h,069h,09fh,037h,069h,09fh,0ffh,000h,08ah,09fh,001h,0afh,09fh,010h,0eah,09fh	; 9f0a  )i.7i...........
	defb 011h,0eah,09fh,012h,033h,0a0h,013h,049h,0a0h,014h,09bh,0a0h,015h,09eh,0a0h,016h	; 9f1a  ....3..I........
	defb 08ah,09fh,017h,0a5h,0a0h,018h,0b1h,0a0h,021h,0e9h,0a0h,025h,0fah,0a0h,027h,02ah	; 9f2a  ........!..%..'*
	defb 0a1h,028h,07bh,0a1h,029h,096h,0a1h,030h,0a9h,0a1h,032h,0c8h,0a1h,033h,0d1h,0a1h	; 9f3a  .({.)..0..2..3..
	defb 036h,0dah,0a1h,037h,000h,0a2h,0ffh	; 9f4a

; ======================================================================
; CODIGO 0x9f51..0x9fd6  (133 bytes)
; ======================================================================


L_9F51:
	ld a,0ffh		;9f51
	ld (0e052h),a		;9f53
	ld a,(0d318h)		;9f56   ; la fase pedida...
	cp 00bh		;9f59   ; ...con tope 10
	jr c,L_9F5F		;9f5b
	ld a,00ah		;9f5d
L_9F5F:
	jr L_9F64		;9f5f
pon_valor:		; escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
	ld a,(0d318h)		;9f61
L_9F64:
	ld hl,(0d308h)		;9f64
	ld (hl),a			;9f67
	ret			;9f68
truco_9f69:		; pone 0xD319 en la variable del juego
	ld a,(0d319h)		;9f69
	jr L_9F64		;9f6c
L_9F6E:
	ld a,(0d318h)		;9f6e
	ld (0e050h),a		;9f71
	ld a,(0d319h)		;9f74
	ld (0e051h),a		;9f77
	ret			;9f7a
truco_9f7b:		; calcula el valor que se escribe en el juego (p03:A21E)
	ld a,(0d313h)		;9f7b
	ld c,a			;9f7e
	ld a,(0d31ah)		;9f7f
	call 0a21eh		;9f82   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit) (gemela de p01:706C)
	ld a,l			;9f85
	inc a			;9f86
	jp 0a125h		;9f87
L_9F8A:
	ld a,(0d31ah)		;9f8a
	dec a			;9f8d
	ld l,a			;9f8e
	ld h,000h		;9f8f
	add hl,hl			;9f91
	ld b,h			;9f92
	ld c,l			;9f93
	add hl,hl			;9f94
	add hl,hl			;9f95
	add hl,bc			;9f96
	call 0a54bh		;9f97   ; binario_a_bcd: HL a BCD en DE (gemela de p01:746C)
	ld a,e			;9f9a
	ld (0e059h),a		;9f9b
	push af			;9f9e
	add a,010h		;9f9f
	daa			;9fa1
	ld (0e05ah),a		;9fa2
	pop af			;9fa5
	call 0a55ch		;9fa6   ; bcd_a_binario: A en BCD a binario (gemela de p01:747D)
	ld (0e054h),a		;9fa9
	jp 0a122h		;9fac   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)
L_9FAF:
	ld a,(0d31ah)		;9faf   ; la fase pedida
	ld c,00ah		;9fb2   ; entre 10
	call 0a21eh		;9fb4   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit) (gemela de p01:706C)
	ld a,l			;9fb7   ; el resto...
	ld (0e0e1h),a		;9fb8   ; ...a 0xE0E1 y 0xE0E8 de la RAM del juego
	ld (0e0e8h),a		;9fbb
	ld b,a			;9fbe
	ld a,(0d303h)		;9fbf   ; 0xD303: segun la opcion...
	or a			;9fc2
	ld hl,09fd6h		;9fc3   ; ...una tabla (p02:9FD6)...
	jr z,L_9FCB		;9fc6
	ld hl,09fe0h		;9fc8   ; ...u otra (p02:9FE0)
L_9FCB:
	ld a,b			;9fcb
	call 0a3e6h		;9fcc   ; hl_mas_a: HL = HL + A (gemela de p01:7251)
	ld a,(hl)			;9fcf
	ld (0e0e2h),a		;9fd0
	jp 0a122h		;9fd3   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A) (gemela de p01:6F70)

; ----------------------------------------------------------------------
; DATOS resto_9FD6: lo apuntan con el banco puesto p02:9FC3 (0x9FD6), p02:9FC8
;   (0x9FE0); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p02:9FC3, p02:9FC8 (20 bytes)
;   0x9fd6..0x9fea  (20 bytes)
DATA_resto_9FD6:
	defb 000h,006h,00dh,013h,01ah,022h,027h,02dh,033h,035h,000h,007h,00fh,014h,01ah,020h	; 9fd6  ....."'-35.....
	defb 022h,02fh,035h,03ch	; 9fe6

; ======================================================================
; CODIGO 0x9fea..0x9fff  (21 bytes)
; ======================================================================


L_9FEA:
	ld a,(0d31ah)		;9fea   ; la fase pedida
	ld c,004h		;9fed   ; entre 4
	call 0a21eh		;9fef   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit) (gemela de p01:706C)
	ld a,l			;9ff2   ; el resto + 1
	inc a			;9ff3
	ld hl,(0d30ah)		;9ff4   ; a la variable del juego (0xD30A)
	ld (hl),a			;9ff7
	ld (0e015h),a		;9ff8   ; y a 0xE015 de la RAM del juego
	dec a			;9ffb
	push af			;9ffc
	add a,a			;9ffd
	ld b,a			;9ffe

; ----------------------------------------------------------------------
; DATOS partida_9FFF: los 1 primeros bytes de una instruccion de 3 (21 23 A0)
;   que sigue en el banco 3: el trazador de un solo banco no puede verla
;   entera (tools/bancos.py); lo leen p02:9FFF (1 bytes)
;   0x9fff..0xa000  (1 bytes)
DATA_partida_9FFF:
	defb 021h	; 9fff
