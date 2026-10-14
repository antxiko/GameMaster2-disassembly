; ==========================================================================
; KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2) - banco 01 (se ejecuta en 0x6000)
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x06000


; ----------------------------------------------------------------------
; DATOS resto_6000: lo apuntan con el banco puesto p00:40D8 (0x6000), p00:4A80
;   (0x6000), p00:573F (0x6000), p02:8042 (0x6000), p02:80BF (0x6000),
;   p02:810F (0x6000); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p00:40D8, p00:4A80, p00:573F, p02:8042, p02:80BF,
;   p02:810F (58 bytes)
;   0x6000..0x603a  (58 bytes)
DATA_resto_6000:
	defb 053h,04bh,000h,055h,054h,049h,04ch,049h,054h,059h,0feh,0a7h,039h,054h,045h,04eh	; 6000  SK.UTILITY..9TEN
	defb 04eh,049h,053h,000h,041h,04eh,044h,000h,048h,04fh,043h,04bh,045h,059h,0feh,0e7h	; 6010  NIS.AND.HOCKEY..
	defb 039h,042h,049h,04fh,052h,059h,054h,048h,04dh,0feh,027h,03ah,045h,04eh,044h,0ffh	; 6020  9BIORYTHM.':END.
	defb 026h,039h,066h,039h,0a6h,039h,0e6h,039h,026h,03ah	; 6030  &9f9.9.9&:

; ======================================================================
; CODIGO 0x603a..0x605f  (37 bytes)
; ======================================================================


L_603A:
	call 05f0dh		;603a   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call pinta_paleta_prueba		;603d   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80
	call borra_sprites		;6040   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	ld hl,06273h		;6043
	call pinta_texto		;6046   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld de,0384dh		;6049
	call 05c32h		;604c   ; pinta_numero_de_juego: pinta el numero de juego (0xF281)
	ld hl,062c4h		;604f
	ld b,003h		;6052
	call menu_con_esc		;6054   ; menu_con_esc: menu: espacio elige, ESC sale
	cp 0ffh		;6057
	jp z,L_665E		;6059
	call despacha		;605c   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_605F: tabla de 3 palabras del despachador (call 0x408D en
;   0x605C); lo leen el despachador (6 bytes)
;   0x605f..0x6065  (6 bytes)
DATA_saltos_605F:
	defb 06ah,060h	; 605f
	defb 0e4h,060h	; 6061
	defb 06fh,062h	; 6063

; ======================================================================
; CODIGO 0x6065..0x60b8  (83 bytes)
; ======================================================================


sin_juego:		; Z si no se reconocio el juego (0xF281 = 0xFF)
	ld a,(0f281h)		;6065   ; lee el codigo del juego
	inc a			;6068
	ret			;6069
L_606A:
	call sin_juego		;606a   ; sin_juego: Z si no se reconocio el juego (0xF281 = 0xFF)
	jr z,$-51		;606d
	ld a,(0f282h)		;606f   ; lee el truco de vidas del juego
	inc a			;6072
	jr nz,L_607E		;6073
	ld hl,(0f28ah)		;6075   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld a,h			;6078
	or l			;6079
	jr z,$-64		;607a
	jr L_6086		;607c
L_607E:
	ld hl,06cd7h		;607e
	call busca_en_tabla		;6081   ; busca_en_tabla: busca 0xF281 en la tabla [codigo, direccion] de HL
	jr nz,$-74		;6084
L_6086:
	call borra_sprites		;6086   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	ld hl,060b8h		;6089
	call pinta_texto		;608c   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03974h		;608f
	call menu_dos		;6092   ; menu_dos: menu de 2 opciones (p01:750E)
	jp z,L_6266		;6095
	ld hl,0f29bh		;6098   ; apunta a la fase que se pide
	call teclado_a_nibble		;609b   ; teclado_a_nibble: pasa la tecla del bufer (0x920B) a un nibble
	jp z,L_6266		;609e
	ld hl,0f29ch		;60a1   ; apunta a el valor que se escribe
	call teclado_a_nibble_b		;60a4   ; teclado_a_nibble_b: pasa las teclas del bufer (0x920B) a un byte
	ld hl,(0f294h)		;60a7   ; lee la rutina propia del juego y el byte siguiente (16 bits)
	ld a,h			;60aa
	or l			;60ab
	ld hl,0f298h		;60ac   ; apunta a las opciones del MODIFY
	jr z,L_60B3		;60af
	set 2,(hl)		;60b1
L_60B3:
	set 1,(hl)		;60b3
	jp L_6266		;60b5

; ----------------------------------------------------------------------
; DATOS resto_60B8: lo apuntan con el banco puesto p01:6089 (0x60B8); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6089 (44 bytes)
;   0x60b8..0x60e4  (44 bytes)
DATA_resto_60B8:
	defb 0c5h,038h,040h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,053h,054h,041h,047h	; 60b8  .8@@@MODIFY.STAG
	defb 045h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,040h,0feh,067h,039h,053h,054h	; 60c8  E.NUMBER@@@.g9ST
	defb 041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh	; 60d8  AGE.NUMBER>.

; ======================================================================
; CODIGO 0x60e4..0x6137  (83 bytes)
; ======================================================================


L_60E4:
	call sin_juego		;60e4   ; sin_juego: Z si no se reconocio el juego (0xF281 = 0xFF)
	jp z,L_603A		;60e7
	ld a,(0f282h)		;60ea   ; lee el truco de vidas del juego
	inc a			;60ed
	jr nz,L_60FA		;60ee
	ld hl,(0f288h)		;60f0
	ld a,h			;60f3
	or l			;60f4
	jp z,L_603A		;60f5
	jr L_6103		;60f8
L_60FA:
	ld hl,06ca6h		;60fa
	call busca_en_tabla		;60fd   ; busca_en_tabla: busca 0xF281 en la tabla [codigo, direccion] de HL
	jp nz,L_603A		;6100
L_6103:
	call borra_sprites		;6103   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	ld hl,06137h		;6106
	call pinta_texto		;6109   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03975h		;610c
	call menu_dos		;610f   ; menu_dos: menu de 2 opciones (p01:750E)
	jp z,L_6266		;6112
	ld hl,0f299h		;6115
	call teclado_a_nibble		;6118   ; teclado_a_nibble: pasa la tecla del bufer (0x920B) a un nibble
	jp z,L_6266		;611b
	ld hl,0f29ah		;611e
	call teclado_a_nibble_b		;6121   ; teclado_a_nibble_b: pasa las teclas del bufer (0x920B) a un byte
	ld hl,0f298h		;6124   ; apunta a las opciones del MODIFY
	set 0,(hl)		;6127
	ld de,(0f294h)		;6129   ; lee la rutina propia del juego y el byte siguiente (16 bits)
	ld a,d			;612d
	or e			;612e
	jp z,L_6266		;612f
	set 2,(hl)		;6132
	jp L_6266		;6134

; ----------------------------------------------------------------------
; DATOS resto_6137: lo apuntan con el banco puesto p01:6106 (0x6137); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6106 (260 bytes)
;   0x6137..0x623b  (260 bytes)
DATA_resto_6137:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h	; 6137  .8@@MODIFY.PLAYE
	defb 052h,000h,04eh,055h,04dh,042h,045h,052h,040h,040h,0feh,067h,039h,050h,04ch,041h	; 6147  R.NUMBER@@.g9PLA
	defb 059h,045h,052h,000h,04eh,055h,04dh,042h,045h,052h,03eh,0ffh,0cdh,065h,060h,0cah	; 6157  YER.NUMBER>..e`.
	defb 03ah,060h,02ah,08eh,0f2h,07ch,0b5h,0cah,03ah,060h,0cdh,0d3h,062h,021h,09fh,061h	; 6167  :`*..|..:`..b!.a
	defb 0cdh,08fh,073h,021h,0deh,061h,006h,003h,0cdh,090h,076h,0cdh,07bh,073h,015h,062h	; 6177  ..s!.a....v.{s.b
	defb 08bh,061h,066h,062h,0cdh,0e4h,061h,021h,098h,0f2h,0cbh,0feh,0c3h,066h,062h,04bh	; 6187  .afb..a!.....fbK
	defb 04fh,04eh,041h,04dh,049h,000h,000h,001h,0c6h,038h,040h,040h,052h,041h,04eh,04bh	; 6197  ONAMI....8@@RANK
	defb 049h,04eh,047h,000h,04dh,04fh,044h,045h,040h,040h,0feh,027h,039h,04ch,04fh,041h	; 61a7  ING.MODE@@.'9LOA
	defb 044h,000h,044h,049h,053h,04bh,000h,044h,041h,054h,041h,0feh,067h,039h,043h,04ch	; 61b7  D.DISK.DATA.g9CL
	defb 045h,041h,052h,000h,052h,041h,04eh,04bh,049h,04eh,047h,000h,044h,041h,054h,041h	; 61c7  EAR.RANKING.DATA
	defb 0feh,0a7h,039h,045h,04eh,044h,0ffh,026h,039h,066h,039h,0a6h,039h,021h,039h,092h	; 61d7  ..9END.&9f9.9!9.
	defb 011h,03ah,092h,036h,000h,001h,01dh,000h,0edh,0b0h,021h,057h,092h,011h,058h,092h	; 61e7  .:.6......!W..X.
	defb 036h,03ch,001h,059h,000h,0edh,0b0h,011h,058h,092h,021h,096h,061h,001h,006h,000h	; 61f7  6<.Y....X.!.a...
	defb 0edh,0b0h,011h,039h,092h,021h,09ch,061h,001h,003h,000h,0edh,0b0h,0c9h,0cdh,0b9h	; 6207  ...9.!.a........
	defb 050h,0cah,07ah,061h,03eh,023h,032h,00bh,0f1h,0cdh,03bh,062h,0cdh,0a8h,053h,0dah	; 6217  P.za>#2....b..S.
	defb 071h,061h,021h,0a1h,052h,0cdh,065h,052h,0cdh,0d3h,062h,0cdh,04fh,04ch,0d2h,08eh	; 6227  qa!.R.eR..b.OL..
	defb 061h,0c3h,071h,061h	; 6237

; ======================================================================
; CODIGO 0x623b..0x6273  (56 bytes)
; ======================================================================


modify_mode:		; el MODIFY MODE MENU: limpia y pinta (gemela de p02:8BFC)
	call borra_sprites		;623b   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	call 05f0dh		;623e   ; ventana_pequena: las esquinas de una ventana (0x9235, 0x9237)
	call 05cfeh		;6241   ; pinta_opcion: pinta la opcion elegida (0xF10B, nibble alto)
	call 05d56h		;6244   ; pinta_tipo: pinta el tipo elegido (0xF10B, nibble bajo)
	call 05d9ah		;6247   ; texto_search: pinta 'SEARCH FILE'
	ld hl,052bah		;624a
	call 05265h		;624d   ; ventana: abre una ventana de texto con el marco de DE
	xor a			;6250
	ld (0922ch),a		;6251   ; guarda cuantas letras lleva el nombre
	ld (0922eh),a		;6254   ; guarda la opcion elegida
	ld hl,0396ch		;6257
	ld (09231h),hl		;625a   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld (09233h),hl		;625d   ; guarda la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	ld a,080h		;6260
	ld (0922dh),a		;6262   ; guarda la ultima opcion del menu
	ret			;6265
L_6266:
	call pinta_paleta_prueba		;6266   ; pinta_paleta_prueba: pinta los 16 colores en 0x3800 y 0x3A80
	call borra_sprites		;6269   ; borra_sprites: borra la tabla de sprites (0x3880, 0x200 bytes)
	jp L_603A		;626c
L_626F:
	di			;626f
	jp L_66BF		;6270

; ----------------------------------------------------------------------
; DATOS resto_6273: lo apuntan con el banco puesto p01:6043 (0x6273), p01:604F
;   (0x62C4); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6043, p01:604F (89 bytes)
;   0x6273..0x62cc  (89 bytes)
DATA_resto_6273:
	defb 0c6h,038h,040h,040h,04dh,04fh,044h,049h,046h,059h,000h,04dh,04fh,044h,045h,000h	; 6273  .8@@MODIFY.MODE.
	defb 04dh,045h,04eh,055h,040h,040h,0feh,027h,039h,04dh,04fh,044h,049h,046h,059h,000h	; 6283  MENU@@.'9MODIFY.
	defb 053h,054h,041h,047h,045h,000h,04eh,055h,04dh,042h,045h,052h,0feh,067h,039h,04dh	; 6293  STAGE.NUMBER.g9M
	defb 04fh,044h,049h,046h,059h,000h,050h,04ch,041h,059h,045h,052h,000h,04eh,055h,04dh	; 62a3  ODIFY.PLAYER.NUM
	defb 042h,045h,052h,0feh,0a7h,039h,053h,054h,041h,052h,054h,000h,047h,041h,04dh,045h	; 62b3  BER..9START.GAME
	defb 0ffh,026h,039h,066h,039h,0a6h,039h,0e6h,039h	; 62c3  .&9f9.9.9

; ======================================================================
; CODIGO 0x62cc..0x6384  (184 bytes)
; ======================================================================


menu_dos:		; menu de 2 opciones (p01:750E)
	ld a,0ffh		;62cc
	ld b,002h		;62ce
	jp menu		;62d0   ; menu: menu de B opciones con el cursor A: devuelve la elegida
borra_sprites:		; borra la tabla de sprites (0x3880, 0x200 bytes)
	ld hl,03880h		;62d3
	ld bc,00200h		;62d6
	xor a			;62d9
	jp 00056h		;62da   ; BIOS FILVRM - Fills VRAM with value
teclado_a_nibble:		; pasa la tecla del bufer (0x920B) a un nibble
	xor a			;62dd
	ld (hl),a			;62de
	ld a,(0922ch)		;62df   ; lee cuantas letras lleva el nombre
	or a			;62e2
	ret z			;62e3
	ld de,0920bh		;62e4   ; apunta a el bufer de teclas
	cp 001h		;62e7
	jr nz,L_62F1		;62e9
	ld a,(de)			;62eb
	and 00fh		;62ec
	ld (hl),a			;62ee
	or a			;62ef
	ret			;62f0
L_62F1:
	cp 002h		;62f1   ; con dos teclas en el bufer, un numero de dos cifras
	ret nz			;62f3
	ld a,(de)			;62f4   ; la primera cifra
	and 00fh		;62f5
	add a,a			;62f7   ; por 10 (x2, x8 y suma)
	ld b,a			;62f8
	add a,a			;62f9
	add a,a			;62fa
	add a,b			;62fb
	ld b,a			;62fc
	inc de			;62fd   ; la segunda cifra
	ld a,(de)			;62fe
	and 00fh		;62ff
	add a,b			;6301   ; decenas y unidades
	ld (hl),a			;6302   ; el numero en binario
	ret			;6303
teclado_a_nibble_b:		; pasa las teclas del bufer (0x920B) a un byte
	xor a			;6304
	ld (hl),a			;6305
	ld a,(0922ch)		;6306   ; lee cuantas letras lleva el nombre
	or a			;6309
	ret z			;630a
	ld de,0920bh		;630b   ; apunta a el bufer de teclas
	cp 001h		;630e
	jr nz,L_6318		;6310
	ld a,(de)			;6312
	and 00fh		;6313
	ld (hl),a			;6315
	or a			;6316
	ret			;6317
L_6318:
	cp 002h		;6318   ; con dos teclas en el bufer, un byte de dos cifras hexadecimales
	ret nz			;631a
	ld a,(de)			;631b   ; la primera cifra
	and 00fh		;631c
	add a,a			;631e   ; por 16
	add a,a			;631f
	add a,a			;6320
	add a,a			;6321
	ld b,a			;6322
	inc de			;6323   ; la segunda cifra
	ld a,(de)			;6324
	and 00fh		;6325
	add a,b			;6327   ; las dos juntas
	ld (hl),a			;6328   ; el byte
	ret			;6329
engancha_al_juego:		; copia p01:6395 a 0xF130 y cambia el gancho del juego por el suyo
	ld hl,06395h		;632a
	ld de,0f130h		;632d   ; apunta a el codigo del gancho en RAM
	ld bc,00045h		;6330
	ldir		;6333
	push de			;6335
	ld hl,(0f107h)		;6336   ; lee la direccion INIT del juego y el byte siguiente (16 bits)
	ld bc,000c0h		;6339
	call copia_del_juego		;633c   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE
	xor a			;633f
	ld (0f11bh),a		;6340   ; guarda el gancho del juego es H.KEYI (no H.TIMI)
	pop hl			;6343
	push hl			;6344
	ld e,0a0h		;6345
	call busca_gancho		;6347   ; busca_gancho: busca en la copia del INIT del juego el `ld (0xFD9B),hl` (9B FD)
	pop hl			;634a
	ret z			;634b
	ld a,001h		;634c
	ld (0f11bh),a		;634e   ; guarda el gancho del juego es H.KEYI (no H.TIMI)
	ld e,09bh		;6351
busca_gancho:		; busca en la copia del INIT del juego el `ld (0xFD9B),hl` (9B FD)
	ld bc,00100h		;6353
L_6356:
	ld a,e			;6356   ; busca el byte bajo (E = 0x9B)...
	cpir		;6357   ; ...en los 0x100 bytes copiados del INIT del juego
	ret nz			;6359   ; no esta: el juego no pone su gancho asi
	jp po,L_636E		;635a   ; se acabaron los bytes
	ld a,0fdh		;635d   ; ¿le sigue 0xFD? (la palabra 0xFD9B, la direccion de H.KEYI)
	cp (hl)			;635f
	jr nz,L_6356		;6360
	dec hl			;6362   ; si: apunta al operando del `ld (0xFD9B),hl`
	ld de,06384h		;6363   ; lo cambia por los 5 bytes de p01:6384
	ex de,hl			;6366
	ld bc,00005h		;6367
	ldir		;636a
	xor a			;636c   ; A = 0: hecho
	ret			;636d
L_636E:
	or 0ffh		;636e
	ret			;6370
copia_del_juego:		; copia BC bytes de HL del cartucho del juego (RDSLT) a DE
	push bc			;6371
	push de			;6372
	ld a,(0f104h)		;6373   ; lee el slot del cartucho del juego
	call 0000ch		;6376   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;6379
	pop bc			;637a
	ld (de),a			;637b
	inc hl			;637c
	inc de			;637d
	dec bc			;637e
	ld a,b			;637f
	or c			;6380
	jr nz,copia_del_juego		;6381
	ret			;6383

; ----------------------------------------------------------------------
; DATOS resto_6384: lo apuntan con el banco puesto p01:6363 (0x6384); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6363 (5 bytes)
;   0x6384..0x6389  (5 bytes)
DATA_resto_6384:
	defb 005h,0f1h,0cdh,030h,0f1h	; 6384

; ======================================================================
; CODIGO 0x6389..0x669e  (789 bytes)
; ======================================================================


copia_f230:		; copia p01:64C6 a 0xF230 (22 bytes)
	ld hl,L_64C6		;6389
	ld de,0f230h		;638c
	ld bc,00016h		;638f
	ldir		;6392
	ret			;6394
L_6395:
	di			;6395
	ld a,(0f11eh)		;6396   ; lee hay disco
	and a			;6399
	jr z,L_63A4		;639a
	ld a,(0f103h)		;639c   ; lee el slot del Game Master
	ld h,080h		;639f
	call 00024h		;63a1   ; BIOS ENASLT - Switches to specified slot and page definitively
L_63A4:
	ld a,0c3h		;63a4
	ld (0fd9ah),a		;63a6   ; guarda el gancho H.KEYI
	ld hl,0f230h		;63a9
	ld (0fd9bh),hl		;63ac   ; guarda la direccion del gancho H.KEYI y el byte siguiente (16 bits)
	pop hl			;63af
	dec hl			;63b0
	dec hl			;63b1
	dec hl			;63b2
	ld de,0f175h		;63b3
	and a			;63b6
	sbc hl,de		;63b7
	ld de,(0f107h)		;63b9   ; lee la direccion INIT del juego y el byte siguiente (16 bits)
	add hl,de			;63bd
	jp (hl)			;63be
L_63BF:
	ld a,(0f104h)		;63bf   ; lee el slot del cartucho del juego
	ld hl,04000h		;63c2
	call 00024h		;63c5   ; BIOS ENASLT - Switches to specified slot and page definitively
	call 0f175h		;63c8
	ld hl,(0fedch)		;63cb
	ld de,(0f107h)		;63ce   ; lee la direccion INIT del juego y el byte siguiente (16 bits)
	and a			;63d2
	sbc hl,de		;63d3
	ld de,0f175h		;63d5
	add hl,de			;63d8
	jp (hl)			;63d9
L_63DA:
	di			;63da
	ld a,(0f110h)		;63db   ; si el menu esta abierto, nada
	or a			;63de
	ret nz			;63df
	call 0013eh		;63e0   ; BIOS RDVDP - Reads VDP status register | lee el estado del VDP (la interrupcion)
	ld ix,(0f105h)		;63e3   ; IX = la vuelta del congelado
	ld iy,(0f102h)		;63e7   ; IY para CALSLT: el slot del Game Master va en IYh (0xF103)
	ld a,007h		;63eb   ; la fila 7 del teclado
	call 00141h		;63ed   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;63f0   ; a nivel alto: el bit 4 (STOP)
	and 010h		;63f1
	ld b,a			;63f3
	ld a,008h		;63f4   ; la fila 8
	call 00141h		;63f6   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;63f9   ; los bits 1 y 2 (el espacio y la flecha?)...
	rrca			;63fa
	and 006h		;63fb
	or b			;63fd   ; ...juntos
	ld hl,0f10ch		;63fe   ; lo que habia pulsado
	ld c,(hl)			;6401
	ld (hl),a			;6402   ; lo de ahora
	xor c			;6403   ; lo recien pulsado
	and (hl)			;6404
	ld c,a			;6405
	ld (0f29eh),a		;6406   ; a 0xF29E
	di			;6409
	bit 4,a		;640a   ; STOP: el menu
	jr z,L_6415		;640c
	ld ix,L_651F		;640e   ; salta al menu por CALSLT (p01:651F)
	jp 0001ch		;6412   ; BIOS CALSLT - Executes inter-slot call
L_6415:
	ld a,(0f298h)		;6415   ; lee las opciones del MODIFY
	or a			;6418
	jr z,L_6433		;6419
	ld hl,(0f284h)		;641b
	ld a,(hl)			;641e
	ld hl,0f297h		;641f
	cp (hl)			;6422
	jr z,L_6433		;6423
	ld (hl),a			;6425
	ld a,(0f292h)		;6426   ; lee el numero de jugadores del juego
	cp (hl)			;6429
	jr nz,L_6433		;642a
	ld ix,06789h		;642c
	jp 0001ch		;6430   ; BIOS CALSLT - Executes inter-slot call
L_6433:
	ld a,(0f109h)		;6433
	rra			;6436
	jr c,L_643B		;6437
	jp (ix)		;6439
L_643B:
	ld a,(0f103h)		;643b   ; lee el slot del Game Master
	ld h,040h		;643e
	call 00024h		;6440   ; BIOS ENASLT - Switches to specified slot and page definitively
	call vuelve_tras_menu		;6443   ; vuelve_tras_menu: devuelve la RAM a la pagina 2 y sigue segun 0xF10A
	ld a,(0f104h)		;6446   ; lee el slot del cartucho del juego
	ld h,040h		;6449
	push af			;644b
	call 00024h		;644c   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;644f
	ld h,080h		;6450
	jp 00024h		;6452   ; BIOS ENASLT - Switches to specified slot and page definitively
L_6455:
	ld h,040h		;6455
	ld a,(0f104h)		;6457   ; lee el slot del cartucho del juego
	push af			;645a
	call 00024h		;645b   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;645e
	ld h,080h		;645f
	call 00024h		;6461   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld hl,(0f105h)		;6464   ; lee la direccion a la que se vuelve del congelado y el byte siguiente (16 bits)
	jp (hl)			;6467
vuelve_tras_menu:		; devuelve la RAM a la pagina 2 y sigue segun 0xF10A
	ld a,(0f2a0h)		;6468   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;646b
	call 00024h		;646d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f29eh)		;6470
	ld c,a			;6473
	ld a,(0f10ah)		;6474   ; lee la opcion que eligio el menu
	cp 002h		;6477
	jr z,L_647E		;6479
	jp L_6594		;647b
L_647E:
	ld hl,0f10fh		;647e   ; 0xF10F: el volumen pedido; 0xF10E: el que suena
	ld de,0f10eh		;6481
	bit 1,c		;6484   ; bit 1 de las teclas: bajar el volumen
	jr z,L_64A0		;6486
	ld a,(hl)			;6488   ; ya esta a 0
	or a			;6489
	ret z			;648a
	sub 00dh		;648b   ; baja 13
	jr z,L_6491		;648d
	jr nc,L_649C		;648f
L_6491:
	push hl			;6491
	push de			;6492
	call guarda_volumenes		;6493   ; guarda_volumenes: guarda los tres volumenes del PSG en 0xF100
	call silencia_psg		;6496   ; silencia_psg: pone a cero los tres volumenes del PSG (y el SCC del juego si lo tiene)
	pop de			;6499
	pop hl			;649a
	xor a			;649b
L_649C:
	ld (hl),a			;649c
	xor a			;649d
	ld (de),a			;649e
	ret			;649f
L_64A0:
	bit 2,c		;64a0   ; bit 2: subir el volumen
	jr z,L_64B8		;64a2
	ld a,00dh		;64a4   ; sube 13
	add a,(hl)			;64a6
	jr nc,L_64AB		;64a7
	ld a,0ffh		;64a9   ; con tope 0xFF
L_64AB:
	ld (hl),a			;64ab
	cp 00dh		;64ac
	jr nz,L_64B5		;64ae
	push de			;64b0
	call devuelve_volumenes		;64b1   ; devuelve_volumenes: devuelve los tres volumenes del PSG (y el SCC)
	pop de			;64b4
L_64B5:
	xor a			;64b5
	ld (de),a			;64b6
	ret			;64b7
L_64B8:
	ld a,(hl)			;64b8   ; lo que hay que sumar al volumen
	or a			;64b9
	jr z,L_64C3		;64ba
	ld a,(de)			;64bc   ; suma al que suena
	add a,(hl)			;64bd
	ld (de),a			;64be
	ret nc			;64bf   ; sin pasarse, vuelve
	jp 0f1abh		;64c0   ; si se pasa, a 0xF1AB (p01:6455, en RAM)
L_64C3:
	jp silencia_psg		;64c3   ; silencia_psg: pone a cero los tres volumenes del PSG (y el SCC del juego si lo tiene)
L_64C6:
	di			;64c6
	ld ix,L_64DC		;64c7
	ld iy,(0f102h)		;64cb   ; IY para CALSLT: en IYh el slot del Game Master
	call 0001ch		;64cf   ; BIOS CALSLT - Executes inter-slot call
	ld a,(0f104h)		;64d2   ; lee el slot del cartucho del juego
	ld h,080h		;64d5
	call 00024h		;64d7   ; BIOS ENASLT - Switches to specified slot and page definitively
	ei			;64da
	ret			;64db
L_64DC:
	ld a,0c9h		;64dc
	ld (0fd9ah),a		;64de   ; guarda el gancho H.KEYI
	ld (0fd9fh),a		;64e1   ; guarda el gancho H.TIMI
	ld a,(0f11bh)		;64e4   ; lee el gancho del juego es H.KEYI (no H.TIMI)
	ld hl,0fd9fh		;64e7   ; apunta a el gancho H.TIMI
	and a			;64ea
	jr z,L_64F0		;64eb
	ld hl,0fd9ah		;64ed   ; apunta a el gancho H.KEYI
L_64F0:
	ld a,0c3h		;64f0
	ld de,0f130h		;64f2   ; apunta a el codigo del gancho en RAM
	ld (hl),a			;64f5
	inc hl			;64f6
	ld (hl),e			;64f7
	inc hl			;64f8
	ld (hl),d			;64f9
	ld a,(0f2a0h)		;64fa   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;64fd
	call 00024h		;64ff   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,(0f11eh)		;6502   ; lee hay disco
	and a			;6505
	jr z,L_6513		;6506
	ld hl,09b80h		;6508
	ld de,0c000h		;650b
	ld bc,01100h		;650e
	ldir		;6511
L_6513:
	ld hl,L_63DA		;6513
	ld de,0f130h		;6516   ; apunta a el codigo del gancho en RAM
	ld bc,0008eh		;6519
	ldir		;651c
	ret			;651e
L_651F:
	call 0013eh		;651f   ; BIOS RDVDP - Reads VDP status register
	ld hl,0f109h		;6522
	inc (hl)			;6525
	ld a,(hl)			;6526
	rra			;6527
	jr nc,L_6585		;6528
	xor a			;652a
	ld (0f10ah),a		;652b   ; guarda la opcion que eligio el menu
	call 00132h		;652e   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call guarda_volumenes		;6531   ; guarda_volumenes: guarda los tres volumenes del PSG en 0xF100
silencia_psg:		; pone a cero los tres volumenes del PSG (y el SCC del juego si lo tiene)
	ld e,000h		;6534
	ld a,008h		;6536   ; R#8 a 0: el volumen A
	call 00093h		;6538   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;653b   ; R#9: el B
	call 00093h		;653c   ; BIOS WRTPSG - Writes data to PSG-register
	inc a			;653f   ; R#10: el C
	call 00093h		;6540   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f124h)		;6543   ; lee el juego tiene SCC
	and a			;6546
	ret z			;6547   ; si el juego no tiene SCC, ya esta
	ld e,03fh		;6548   ; 0x3F en el registro 0x9000 del juego: el SCC aparece en 0x9800
	ld a,(0f104h)		;654a   ; lee el slot del cartucho del juego
	ld hl,09000h		;654d
	call 00014h		;6550   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,000h		;6553   ; 0 en 0x988F: los cinco canales del SCC apagados
	ld a,(0f104h)		;6555   ; lee el slot del cartucho del juego
	ld hl,0988fh		;6558
	call 00014h		;655b   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;655e   ; y el banco que tenia el juego en 0x9000 (su copia en 0xF0F2)
	ld e,a			;6561
	ld a,(0f104h)		;6562   ; lee el slot del cartucho del juego
	ld hl,09000h		;6565
	call 00014h		;6568   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;656b
guarda_volumenes:		; guarda los tres volumenes del PSG en 0xF100
	ld a,008h		;656c
	call 00096h		;656e   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f100h),a		;6571   ; guarda volumen del PSG, canal A
	ld a,009h		;6574
	call 00096h		;6576   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f101h),a		;6579   ; guarda volumen del PSG, canal B
	ld a,00ah		;657c
	call 00096h		;657e   ; BIOS RDPSG - Reads value from PSG-register
	ld (0f102h),a		;6581   ; guarda volumen del PSG, canal C
	ret			;6584
L_6585:
	ld (hl),000h		;6585
	ld a,0ffh		;6587
	call 00132h		;6589   ; BIOS CHGCAP - Alternates the CAPS lamp status
	call devuelve_volumenes		;658c   ; devuelve_volumenes: devuelve los tres volumenes del PSG (y el SCC)
	xor a			;658f
	ld (0f10ah),a		;6590   ; guarda la opcion que eligio el menu
	ret			;6593
L_6594:
	ld a,001h		;6594
	ld (0f110h),a		;6596   ; guarda el menu esta abierto
	call congela		;6599   ; congela: congela el juego: silencio y espera la tecla
	xor a			;659c
	ld (0f110h),a		;659d   ; guarda el menu esta abierto
	ret			;65a0
congela:		; congela el juego: silencio y espera la tecla
	call silencia_psg		;65a1   ; silencia_psg: pone a cero los tres volumenes del PSG (y el SCC del juego si lo tiene)
	ld ix,(0f105h)		;65a4   ; lee la direccion a la que se vuelve del congelado y el byte siguiente (16 bits)
	ld iy,(0f103h)		;65a8   ; IY para CALSLT: en IYh el slot del cartucho del juego
	ld a,(0f10ah)		;65ac   ; lee la opcion que eligio el menu
	or a			;65af
	jp nz,05a0fh		;65b0   ; si: sigue congelado
	call lee_teclas		;65b3   ; lee_teclas: las teclas del Game Master (SNSMAT 1, 6 y 7) en 0xF10D: C = las recien pulsadas
	ld a,c			;65b6   ; el bit 7 de las teclas: el congelado
	rla			;65b7
	jr c,L_65CE		;65b8
	rla			;65ba   ; el bit 6
	jr c,L_65E4		;65bb
	rla			;65bd   ; el bit 5
	jr c,L_65C1		;65be
	ret			;65c0
L_65C1:
	ld a,002h		;65c1
	ld (0f10ah),a		;65c3   ; guarda la opcion que eligio el menu
bio_borra_estado:		; pone a cero 0xE006 y 0xE004 (gemela de p05:9924)
	xor a			;65c6
	ld (0f10fh),a		;65c7
	ld (0f10eh),a		;65ca
	ret			;65cd
L_65CE:
	call devuelve_volumenes		;65ce   ; devuelve_volumenes: devuelve los tres volumenes del PSG (y el SCC)
	push ix		;65d1
	push iy		;65d3
	ld a,(0f104h)		;65d5   ; lee el slot del cartucho del juego
	ld h,080h		;65d8
	call 00024h		;65da   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop iy		;65dd
	pop ix		;65df
	jp 0001ch		;65e1   ; BIOS CALSLT - Executes inter-slot call
L_65E4:
	ld a,001h		;65e4
	ld (0f10ah),a		;65e6   ; guarda la opcion que eligio el menu
	ret			;65e9
devuelve_volumenes:		; devuelve los tres volumenes del PSG (y el SCC)
	ld a,(0f100h)		;65ea   ; lee volumen del PSG, canal A
	ld e,a			;65ed
	ld a,008h		;65ee   ; el volumen A a R#8 del PSG
	call 00093h		;65f0   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f101h)		;65f3   ; lee volumen del PSG, canal B
	ld e,a			;65f6
	ld a,009h		;65f7   ; el B a R#9
	call 00093h		;65f9   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f102h)		;65fc   ; lee volumen del PSG, canal C
	ld e,a			;65ff
	ld a,00ah		;6600   ; el C a R#10
	call 00093h		;6602   ; BIOS WRTPSG - Writes data to PSG-register
	ld a,(0f124h)		;6605   ; lee el juego tiene SCC
	and a			;6608
	ret z			;6609   ; si el juego no tiene SCC, ya esta
	ld e,03fh		;660a   ; 0x3F en el registro 0x9000 del juego: el SCC aparece en 0x9800
	ld a,(0f104h)		;660c   ; lee el slot del cartucho del juego
	ld hl,09000h		;660f
	call 00014h		;6612   ; BIOS WRSLT - Writes a value to an address in another slot
	ld e,01fh		;6615   ; 0x1F en 0x988F: los cinco canales del SCC encendidos
	ld a,(0f104h)		;6617   ; lee el slot del cartucho del juego
	ld hl,0988fh		;661a
	call 00014h		;661d   ; BIOS WRSLT - Writes a value to an address in another slot
	ld a,(0f0f2h)		;6620   ; y el banco que tenia el juego en 0x9000 (su copia en 0xF0F2)
	ld e,a			;6623
	ld a,(0f104h)		;6624   ; lee el slot del cartucho del juego
	ld hl,09000h		;6627
	call 00014h		;662a   ; BIOS WRSLT - Writes a value to an address in another slot
	ret			;662d
lee_teclas:		; las teclas del Game Master (SNSMAT 1, 6 y 7) en 0xF10D: C = las recien pulsadas
	ld a,001h		;662e
	call 00141h		;6630   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;6633
	and 080h		;6634
	ld d,a			;6636
	ld a,006h		;6637
	call 00141h		;6639   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;663c
	and 0e2h		;663d
	bit 1,a		;663f
	jr z,L_6645		;6641
	or 008h		;6643
L_6645:
	and 0e8h		;6645   ; los bits de la fila 6 que interesan
	ld e,a			;6647
	ld a,007h		;6648   ; la fila 7 del teclado
	call 00141h		;664a   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	cpl			;664d   ; a nivel alto: los bits 0-2
	and 007h		;664e
	or e			;6650   ; junto con lo de la fila 6
	rlca			;6651   ; en su sitio
	rlca			;6652
	rlca			;6653
	or d			;6654   ; y la fila 1
	ld hl,0f10dh		;6655   ; apunta a las teclas del Game Master
	ld c,(hl)			;6658   ; lo que habia
	ld (hl),a			;6659   ; lo de ahora
	xor c			;665a   ; lo que cambio...
	and (hl)			;665b   ; ...y esta pulsado
	ld c,a			;665c   ; C = lo recien pulsado
	ret			;665d
L_665E:
	call pon_opcion		;665e   ; pon_opcion: copia 0xF111 a 0xE000
	call bancos_9_10		;6661   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 0801bh		;6664
	jr L_6681		;6667
L_6669:
	call pon_opcion		;6669   ; pon_opcion: copia 0xF111 a 0xE000
	call bancos_9_10		;666c   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 08043h		;666f
	call 080d2h		;6672
	call 08117h		;6675
	call 08846h		;6678
	call 08133h		;667b
	call 08134h		;667e
L_6681:
	call 082cah		;6681
	call 0846dh		;6684
	push af			;6687
	call bancos_2_3_y_ram		;6688   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	call 05ec2h		;668b   ; pantalla_del_menu: borra la VRAM y pone el modo del menu (MSX1 o MSX2)
	call bancos_9_10		;668e   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call borra_nombres		;6691   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
	call 08191h		;6694
	call bancos_2_3_y_ram		;6697   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	pop af			;669a
	call despacha		;669b   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_669E: tabla de 3 palabras del despachador (call 0x408D en
;   0x669B); lo leen el despachador (6 bytes)
;   0x669e..0x66a4  (6 bytes)
DATA_saltos_669E:
	defb 0b0h,066h	; 669e
	defb 0e6h,066h	; 66a0
	defb 0f1h,066h	; 66a2

; ======================================================================
; CODIGO 0x66a4..0x68ce  (554 bytes)
; ======================================================================


L_66A4:
	call bancos_9_10		;66a4   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	jr $-38		;66a7
pon_opcion:		; copia 0xF111 a 0xE000
	ld a,(0f111h)		;66a9   ; lee la opcion de arranque
	ld (0e000h),a		;66ac
	ret			;66af
L_66B0:
	ld a,(0f111h)		;66b0   ; lee la opcion de arranque
	inc a			;66b3
	jr nz,L_66A4		;66b4
	ld bc,00107h		;66b6
	call 00047h		;66b9   ; BIOS WRTVDP - Writes data in the VDP-register
	call borra_nombres		;66bc   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
L_66BF:
	di			;66bf
	ld hl,0fd9ah		;66c0   ; apunta a el gancho H.KEYI
	ld a,0c9h		;66c3
	ld b,00ah		;66c5
L_66C7:
	ld (hl),a			;66c7   ; rellena B bytes con A
	inc hl			;66c8
	djnz L_66C7		;66c9
	xor a			;66cb
	ld (0f109h),a		;66cc
	ld (0f110h),a		;66cf   ; guarda el menu esta abierto
	jp 0563fh		;66d2   ; y vuelve al juego
L_66D5:
	ld sp,0f380h		;66d5
	ld a,0ffh		;66d8
	call 00132h		;66da   ; BIOS CHGCAP - Alternates the CAPS lamp status
	xor a			;66dd
	ld (0f298h),a		;66de   ; guarda las opciones del MODIFY
	ld (092c7h),a		;66e1
	jr L_66BF		;66e4
L_66E6:
	ld a,(0f111h)		;66e6   ; lee la opcion de arranque
	inc a			;66e9
	jp nz,L_66A4		;66ea
	ld a,002h		;66ed
	jr L_66F3		;66ef
L_66F1:
	ld a,001h		;66f1
L_66F3:
	ld (092cfh),a		;66f3
	ld bc,00107h		;66f6
	call 00047h		;66f9   ; BIOS WRTVDP - Writes data in the VDP-register
	call borra_nombres		;66fc   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
	call bancos_9_10		;66ff   ; bancos_9_10: el cartucho en la pagina 2 y los bancos 9-10
	call 08191h		;6702
	call bancos_2_3_y_ram		;6705   ; bancos_2_3_y_ram: los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	ld a,(092cfh)		;6708
	cp 002h		;670b
	jp z,L_603A		;670d
	jp 05de5h		;6710
L_6713:
	ld a,(0002dh)		;6713   ; la version del MSX (0 = MSX1)
	and a			;6716
	jr nz,L_6723		;6717
	ld hl,00000h		;6719
	ld bc,04000h		;671c
	xor a			;671f
	jp 00056h		;6720   ; BIOS FILVRM - Fills VRAM with value
L_6723:
	ld hl,00000h		;6723
	ld bc,00000h		;6726
	xor a			;6729
	jp 0016bh		;672a   ; BIOS BIGFIL - Same function as FILVRM (with 16-bit VRAM-address)
bancos_9_10:		; el cartucho en la pagina 2 y los bancos 9-10
	ld a,(0f103h)		;672d   ; lee el slot del Game Master
	ld h,080h		;6730
	call 00024h		;6732   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld a,009h		;6735
	ld (08000h),a		;6737   ; el mapper: pone en 0x8000 el banco de A
	inc a			;673a
	ld (0a000h),a		;673b   ; el mapper: pone en 0xA000 el banco de A
	ret			;673e
bancos_2_3_y_ram:		; los bancos 2-3 y devuelve la RAM (0xF2A0) a la pagina 2
	ld a,002h		;673f
	ld (08000h),a		;6741   ; el mapper: pone en 0x8000 el banco de A
	inc a			;6744
	ld (0a000h),a		;6745   ; el mapper: pone en 0xA000 el banco de A
	ld a,(0f2a0h)		;6748   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;674b
	call 00024h		;674d   ; BIOS ENASLT - Switches to specified slot and page definitively
	ret			;6750
L_6751:
	ld b,001h		;6751
L_6753:
	ld hl,00000h		;6753
espera_tecla:		; espera una tecla (CHSNS) HL x B veces
	dec hl			;6756
	call 0009ch		;6757   ; BIOS CHSNS - Tests the status of the keyboard buffer
	ret nz			;675a
	ld a,h			;675b
	or l			;675c
	jr nz,espera_tecla		;675d
	djnz L_6753		;675f
	ret			;6761
pinta_paleta_prueba:		; pinta los 16 colores en 0x3800 y 0x3A80
	ld hl,03800h		;6762
	ld b,002h		;6765
L_6767:
	push bc			;6767
	ld c,004h		;6768
	call pinta_16_colores		;676a   ; pinta_16_colores: pinta 16 casillas con los colores 1-15
	pop bc			;676d
	ld hl,03a80h		;676e
	djnz L_6767		;6771
	ret			;6773
pinta_16_colores:		; pinta 16 casillas con los colores 1-15
	ld b,010h		;6774
	ld a,001h		;6776
L_6778:
	call 0004dh		;6778   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;677b
	call 0004dh		;677c   ; BIOS WRTVRM - Writes data in VRAM
	inc hl			;677f
	inc a			;6780
	and 00fh		;6781
	djnz L_6778		;6783
	dec c			;6785
	jr nz,pinta_16_colores		;6786
	ret			;6788
L_6789:
	ld a,(0f298h)		;6789   ; lee las opciones del MODIFY
	ld b,a			;678c   ; B = las opciones
	bit 0,b		;678d   ; bit 0: vidas infinitas
	call nz,truco_vidas		;678f   ; truco_vidas: las vidas: la rutina del juego de la tabla de p01:6CA6
	bit 1,b		;6792   ; bit 1: la fase elegida
	call nz,truco_fase		;6794   ; truco_fase: la fase: la rutina del juego de la tabla de p01:6CD7
	bit 2,b		;6797   ; bit 2: la rutina propia del juego
	call nz,truco_propio		;6799   ; truco_propio: llama por CALSLT a la rutina del juego de 0xF294
	ld a,b			;679c   ; D = el resto de los bits
	and 0f8h		;679d
	ld d,a			;679f
	call hay_ranking		;67a0   ; sin ranking, ya esta
	jr z,L_67B5		;67a3
	ld a,(0f281h)		;67a5   ; el juego de codigo 0x15 tampoco
	cp 015h		;67a8
	jr z,L_67B5		;67aa
	ld hl,0f29dh		;67ac   ; cada dos cuadros...
	inc (hl)			;67af
	bit 1,(hl)		;67b0
	jr nz,L_67B5		;67b2
	ld d,b			;67b4   ; ...las opciones se quedan
L_67B5:
	ld hl,0f298h		;67b5   ; apunta a las opciones del MODIFY
	ld (hl),d			;67b8   ; las opciones del MODIFY
	bit 7,d		;67b9   ; bit 7: la partida acabo
	ret z			;67bb
	res 7,(hl)		;67bc   ; lo quita
	ld a,0ffh		;67be   ; el menu esta abierto
	ld (0f110h),a		;67c0   ; guarda el menu esta abierto
	ld hl,092b7h		;67c3   ; el nombre del ranking a '<' (16 bytes)
	ld de,092b8h		;67c6
	ld (hl),03ch		;67c9
	ld bc,0000fh		;67cb
	ldir		;67ce
	ld hl,092b1h		;67d0   ; y los puntos a cero
	ld de,092b2h		;67d3
	ld (hl),000h		;67d6
	ld bc,00005h		;67d8
	ldir		;67db
	call silencia_psg		;67dd   ; silencio
	call p02_8000		;67e0   ; guarda la pantalla del juego
	call menu_ranking		;67e3   ; el ranking
	call p02_80e4		;67e6   ; devuelve la pantalla del juego
	xor a			;67e9   ; el menu ya no esta abierto
	ld (0f110h),a		;67ea   ; guarda el menu esta abierto
	ld a,0ffh		;67ed   ; 0x92C7 = 0xFF: hay ranking
	ld (092c7h),a		;67ef
	ret			;67f2
truco_vidas:		; las vidas: la rutina del juego de la tabla de p01:6CA6
	ld a,(0f282h)		;67f3   ; lee el truco de vidas del juego
	inc a			;67f6
	jr z,L_67FE		;67f7
	ld hl,06ca6h		;67f9
	jr L_680D		;67fc
L_67FE:
	push bc			;67fe
	call truco_6d2f		;67ff   ; truco_6d2f: pone 0xF29A en la variable del juego
	pop bc			;6802
	ret			;6803
truco_fase:		; la fase: la rutina del juego de la tabla de p01:6CD7
	ld a,(0f282h)		;6804   ; lee el truco de vidas del juego
	inc a			;6807
	jr z,L_6813		;6808
	ld hl,06cd7h		;680a
L_680D:
	push bc			;680d
	call busca_en_tabla_y_salta		;680e   ; busca_en_tabla_y_salta: busca 0xF281 en la tabla [codigo, direccion] de HL y salta
	pop bc			;6811
	ret			;6812
L_6813:
	push bc			;6813
	call truco_6d41		;6814   ; truco_6d41: calcula el valor que se escribe en el juego (p01:706C)
	pop bc			;6817
	ret			;6818
truco_propio:		; llama por CALSLT a la rutina del juego de 0xF294
	push bc			;6819
	ld ix,(0f294h)		;681a   ; lee la rutina propia del juego y el byte siguiente (16 bits)
	ld iy,(0f103h)		;681e   ; IY para CALSLT: en IYh el slot del cartucho del juego
	call 0001ch		;6822   ; BIOS CALSLT - Executes inter-slot call
	pop bc			;6825
	ret			;6826
busca_en_tabla_y_salta:		; busca 0xF281 en la tabla [codigo, direccion] de HL y salta
	ld a,(hl)			;6827
	inc a			;6828
	ret z			;6829
	ld a,(0f281h)		;682a   ; lee el codigo del juego
	cp (hl)			;682d
	inc hl			;682e
	jr z,L_6835		;682f
	inc hl			;6831
	inc hl			;6832
	jr busca_en_tabla_y_salta		;6833
L_6835:
	ld e,(hl)			;6835
	inc hl			;6836
	ld d,(hl)			;6837
	ex de,hl			;6838
	jp (hl)			;6839
busca_en_tabla:		; busca 0xF281 en la tabla [codigo, direccion] de HL
	ld a,(hl)			;683a
	inc a			;683b
	jr z,L_6848		;683c
	ld a,(0f281h)		;683e   ; lee el codigo del juego
	cp (hl)			;6841
	ret z			;6842
	inc hl			;6843
	inc hl			;6844
	inc hl			;6845
	jr busca_en_tabla		;6846
L_6848:
	inc a			;6848
	ret			;6849
menu_ranking:		; la pantalla del RANKING
	ld hl,03a8ch		;684a
	ld bc,00312h		;684d
	xor a			;6850
	call rellena_ventana		;6851   ; rellena_ventana: rellena una ventana de B filas por C columnas con A
	ld hl,06958h		;6854
	call pinta_texto		;6857   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	call pinta_ranking		;685a   ; pinta_ranking: pinta la cabecera y las filas del ranking
	ld hl,03acch		;685d
	call menu_ocho		;6860   ; menu_ocho: menu de 8 opciones (p01:750E)
	jr z,L_687E		;6863
	ld hl,0920bh		;6865   ; apunta a el bufer de teclas
	ld de,092b7h		;6868   ; apunta a el nombre que se mete en el ranking
	ld bc,00008h		;686b
	ldir		;686e
	ld hl,092b1h		;6870
	call borra_3		;6873   ; borra_3: pone a cero 3 bytes en HL
	ld a,031h		;6876
	call ranking_quita_marca		;6878   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257)
	call pinta_ranking		;687b   ; pinta_ranking: pinta la cabecera y las filas del ranking
L_687E:
	call hay_ranking		;687e   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286)
	jr z,L_68B3		;6881
	ld hl,06972h		;6883
	call pinta_texto		;6886   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,03acch		;6889
	push hl			;688c
	ld bc,0000ah		;688d
	xor a			;6890
	call rellena_vram		;6891   ; rellena_vram: rellena la VRAM con A (letra a letra si la pantalla es de texto)
	pop hl			;6894
	call menu_ocho		;6895   ; menu_ocho: menu de 8 opciones (p01:750E)
	jr z,L_68B3		;6898
	ld hl,0920bh		;689a   ; apunta a el bufer de teclas
	ld de,092bfh		;689d
	ld bc,00008h		;68a0
	ldir		;68a3
	ld hl,092b4h		;68a5
	call borra_3		;68a8   ; borra_3: pone a cero 3 bytes en HL
	ld a,032h		;68ab
	call ranking_quita_marca		;68ad   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257)
	call pinta_ranking		;68b0   ; pinta_ranking: pinta la cabecera y las filas del ranking
L_68B3:
	ld hl,03a8ch		;68b3
	ld bc,00312h		;68b6
	xor a			;68b9
	call rellena_ventana		;68ba   ; rellena_ventana: rellena una ventana de B filas por C columnas con A
	ld hl,0699ch		;68bd
	call pinta_texto		;68c0   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,069a9h		;68c3
	ld b,002h		;68c6
	call menu_vertical		;68c8   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	call despacha		;68cb   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_68CE: tabla de 2 palabras del despachador (call 0x408D en
;   0x68CB); lo leen el despachador (4 bytes)
;   0x68ce..0x68d2  (4 bytes)
DATA_saltos_68CE:
	defb 0d2h,068h	; 68ce
	defb 04ah,068h	; 68d0

; ======================================================================
; CODIGO 0x68d2..0x6958  (134 bytes)
; ======================================================================


L_68D2:
	ret			;68d2
menu_ocho:		; menu de 8 opciones (p01:750E)
	ld a,0feh		;68d3
	ld b,008h		;68d5
	jp menu		;68d7   ; menu: menu de B opciones con el cursor A: devuelve la elegida
borra_3:		; pone a cero 3 bytes en HL
	xor a			;68da   ; pone a cero 3 bytes
	ld (hl),a			;68db
	inc hl			;68dc
	ld (hl),a			;68dd
	inc hl			;68de
	ld (hl),a			;68df
	ret			;68e0
hay_ranking:		; Z si el juego no tiene ranking (0xF290, 0xF286)
	ld hl,(0f290h)		;68e1   ; los puntos del juego
	ld a,h			;68e4   ; sin puntos no hay ranking
	or l			;68e5
	ret z			;68e6
	ld hl,(0f286h)		;68e7   ; 0xF286: donde guarda el juego los puntos
	ld a,h			;68ea   ; tampoco sin el
	or l			;68eb
	ret z			;68ec
	ld a,(0f281h)		;68ed   ; lee el codigo del juego
	ld c,a			;68f0   ; C = el codigo del juego
	sub 003h		;68f1   ; los juegos de codigo 3 y 4...
	cp 002h		;68f3
	jr c,L_6907		;68f5
	ld a,c			;68f7   ; ...y los de 0x10 y 0x11...
	sub 010h		;68f8
	cp 002h		;68fa
	jr nc,L_6903		;68fc
	ld a,(hl)			;68fe   ; ...miran el bit 0 de su variable: si esta a 1, no hay ranking
	cpl			;68ff
	and 001h		;6900
	ret			;6902
L_6903:
	ld a,(hl)			;6903
	bit 5,a		;6904
	ret			;6906
L_6907:
	ld a,(hl)			;6907
	and 001h		;6908
	ret			;690a
ranking_quita_1_y_2:		; quita las marcas 1 y 2 del ranking
	ld a,031h		;690b
	call ranking_quita_marca		;690d   ; ranking_quita_marca: quita la marca A de las 10 filas del ranking (0x9257)
	ld a,032h		;6910
ranking_quita_marca:		; quita la marca A de las 10 filas del ranking (0x9257)
	ld hl,09257h		;6912   ; apunta a los nombres del ranking (9 bytes por fila)
	ld b,00ah		;6915
	ld c,a			;6917
L_6918:
	ld a,c			;6918
	cp (hl)			;6919
	jr nz,L_691E		;691a
	ld (hl),000h		;691c
L_691E:
	ld a,009h		;691e
	call hl_mas_a		;6920   ; hl_mas_a: HL = HL + A
	djnz L_6918		;6923
	ret			;6925
pinta_ranking:		; pinta la cabecera y las filas del ranking
	ld hl,03a2ch		;6926
	ld bc,00212h		;6929
	xor a			;692c
	call rellena_ventana		;692d   ; rellena_ventana: rellena una ventana de B filas por C columnas con A
	ld hl,06982h		;6930
	call pinta_texto		;6933   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,092b7h		;6936   ; apunta a el nombre que se mete en el ranking
	ld de,03a36h		;6939
	ld bc,00008h		;693c
	call copia_a_vram		;693f   ; copia_a_vram: copia BC bytes de HL a la VRAM DE (letra a letra si es de texto)
	call hay_ranking		;6942   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286)
	ret z			;6945
	ld hl,0698fh		;6946
	call pinta_texto		;6949   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld hl,092bfh		;694c
	ld de,03a56h		;694f
	ld bc,00008h		;6952
	jp copia_a_vram		;6955   ; copia_a_vram: copia BC bytes de HL a la VRAM DE (letra a letra si es de texto)

; ----------------------------------------------------------------------
; DATOS resto_6958: lo apuntan con el banco puesto p01:6854 (0x6958), p01:6883
;   (0x6972), p01:6930 (0x6982), p01:6946 (0x698F), p01:68BD (0x699C),
;   p01:68C3 (0x69A9); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6854, p01:6883, p01:6930, p01:6946, p01:68BD,
;   p01:68C3 (85 bytes)
;   0x6958..0x69ad  (85 bytes)
DATA_resto_6958:
	defb 021h,03ah,052h,041h,04eh,04bh,049h,04eh,047h,0feh,08ch,03ah,049h,04eh,050h,055h	; 6958  !:RANKING..:INPU
	defb 054h,000h,031h,050h,000h,04eh,041h,04dh,045h,0ffh,08ch,03ah,049h,04eh,050h,055h	; 6968  T.1P.NAME..:INPU
	defb 054h,000h,032h,050h,000h,04eh,041h,04dh,045h,0ffh,02ch,03ah,031h,050h,000h,04eh	; 6978  T.2P.NAME.,:1P.N
	defb 041h,04dh,045h,000h,03eh,000h,0ffh,04ch,03ah,032h,050h,000h,04eh,041h,04dh,045h	; 6988  AME.>..L:2P.NAME
	defb 000h,03eh,000h,0ffh,08ch,03ah,04fh,04bh,0feh,0cch,03ah,052h,045h,054h,052h,059h	; 6998  .>...:OK..:RETRY
	defb 0ffh,08bh,03ah,0cbh,03ah	; 69a8

; ======================================================================
; CODIGO 0x69ad..0x6c35  (648 bytes)
; ======================================================================


ranking_entra:		; mete la puntuacion en el ranking
	ld hl,092b3h		;69ad
	ld a,031h		;69b0
	call ranking_busca_marca		;69b2   ; ranking_busca_marca: busca la marca A en el ranking
	call hay_ranking		;69b5   ; hay_ranking: Z si el juego no tiene ranking (0xF290, 0xF286)
	ret z			;69b8
	ld hl,092b6h		;69b9
	ld a,032h		;69bc
ranking_busca_marca:		; busca la marca A en el ranking
	ld de,09257h		;69be   ; apunta a los nombres del ranking (9 bytes por fila)
	ex de,hl			;69c1
	ld c,a			;69c2
	ld b,00ah		;69c3
L_69C5:
	ld a,c			;69c5
	cp (hl)			;69c6
	jr z,L_69D4		;69c7
	ld a,009h		;69c9
	call hl_mas_a		;69cb   ; hl_mas_a: HL = HL + A
	djnz L_69C5		;69ce
	ld b,009h		;69d0
	jr L_69DB		;69d2
L_69D4:
	ld a,00ah		;69d4
	sub b			;69d6
	ld b,a			;69d7
	jp z,L_6A0F		;69d8
L_69DB:
	ld a,c			;69db
	ld c,000h		;69dc
	ld hl,0923bh		;69de
L_69E1:
	push af			;69e1   ; guarda los registros para la comparacion
	push bc			;69e2
	push hl			;69e3
	push de			;69e4
	ld b,003h		;69e5   ; los puntos son 3 bytes BCD
	ex de,hl			;69e7
L_69E8:
	ld a,(de)			;69e8   ; compara de la cifra alta a la baja
	cp (hl)			;69e9
	jr c,L_69F2		;69ea   ; menor: se queda debajo
	jr nz,L_69FF		;69ec   ; mayor: entra aqui
	dec de			;69ee   ; la cifra siguiente
	dec hl			;69ef
	djnz L_69E8		;69f0   ; los 3 bytes
L_69F2:
	pop de			;69f2
	pop hl			;69f3
	pop bc			;69f4
	pop af			;69f5
	call ranking_ordena		;69f6   ; ranking_ordena: ordena el ranking
	call ranking_mueve		;69f9   ; ranking_mueve: mueve una fila del ranking
	jp L_6A7A		;69fc
L_69FF:
	pop de			;69ff
	pop hl			;6a00
	pop bc			;6a01
	pop af			;6a02
	inc hl			;6a03   ; la fila siguiente (3 bytes de puntos)
	inc hl			;6a04
	inc hl			;6a05
	inc c			;6a06   ; C = la posicion
	djnz L_69E1		;6a07   ; las B filas
	call ranking_mueve		;6a09   ; ranking_mueve: mueve una fila del ranking
	jp L_6A7A		;6a0c   ; y pinta el ranking
L_6A0F:
	ld a,c			;6a0f
	ld c,b			;6a10
	jp ranking_mueve		;6a11   ; ranking_mueve: mueve una fila del ranking
ranking_ordena:		; ordena el ranking
	ld ix,09238h		;6a14
	ld iy,0923bh		;6a18
	ld d,000h		;6a1c
	call ranking_compara		;6a1e   ; ranking_compara: compara dos filas del ranking
	ld ix,09256h		;6a21
	ld iy,0925fh		;6a25
	ld d,001h		;6a29
ranking_compara:		; compara dos filas del ranking
	push af			;6a2b
	push bc			;6a2c
	ld e,b			;6a2d   ; E = la fila
	ld a,c			;6a2e   ; C + B...
	add a,b			;6a2f
	ld b,a			;6a30
	add a,a			;6a31   ; ...por 3 (puntos)
	add a,b			;6a32
	bit 0,d		;6a33   ; bit 0 de D: los nombres...
	jr z,L_6A3A		;6a35
	ld b,a			;6a37   ; ...que son 9 bytes (por 3 otra vez)
	add a,a			;6a38
	add a,b			;6a39
L_6A3A:
	ld c,a			;6a3a   ; BC = el desplazamiento
	ld b,000h		;6a3b
	add ix,bc		;6a3d   ; IX e IY a esa fila
	add iy,bc		;6a3f
	ld a,e			;6a41   ; E por 3...
	add a,a			;6a42
	add a,e			;6a43
	bit 0,d		;6a44   ; ...o por 9 si son nombres
	jr z,L_6A4B		;6a46
	ld b,a			;6a48
	add a,a			;6a49
	add a,b			;6a4a
L_6A4B:
	ld c,a			;6a4b   ; BC = los bytes que hay que mover
	ld b,000h		;6a4c
	push ix		;6a4e   ; HL = IX
	pop hl			;6a50
	push iy		;6a51   ; DE = IY
	pop de			;6a53
	lddr		;6a54   ; baja las filas una posicion
	pop bc			;6a56
	pop af			;6a57
	ret			;6a58
ranking_mueve:		; mueve una fila del ranking
	push af			;6a59   ; guarda los registros
	push bc			;6a5a
	push af			;6a5b
	ld a,c			;6a5c   ; la fila x 3: los puntos
	ld b,a			;6a5d
	add a,a			;6a5e
	add a,b			;6a5f
	ld hl,09239h		;6a60   ; apunta a los puntos del ranking (3 bytes por fila)
	call hl_mas_a		;6a63   ; hl_mas_a: HL = HL + A
	pop af			;6a66
	ld de,092b1h		;6a67
	cp 032h		;6a6a
	jr nz,L_6A71		;6a6c
	ld de,092b4h		;6a6e
L_6A71:
	ex de,hl			;6a71   ; copia los 3 bytes de los puntos
	ld bc,00003h		;6a72
	ldir		;6a75
	pop bc			;6a77
	pop af			;6a78
	ret			;6a79
L_6A7A:
	push af			;6a7a   ; guarda los registros
	push bc			;6a7b
	push af			;6a7c
	ld a,c			;6a7d   ; la fila x 9: el nombre
	ld b,a			;6a7e
	add a,a			;6a7f
	add a,b			;6a80
	ld b,a			;6a81
	add a,a			;6a82
	add a,b			;6a83
	ld hl,09257h		;6a84   ; apunta a los nombres del ranking (9 bytes por fila)
	call hl_mas_a		;6a87   ; hl_mas_a: HL = HL + A
	pop af			;6a8a
	ld de,092b7h		;6a8b   ; apunta a el nombre que se mete en el ranking
	cp 032h		;6a8e
	jr nz,L_6A95		;6a90
	ld de,092bfh		;6a92
L_6A95:
	ex de,hl			;6a95   ; la marca de la fila...
	ld (de),a			;6a96
	inc de			;6a97
	ld bc,00008h		;6a98   ; ...y los 8 bytes del nombre
	ldir		;6a9b
	pop bc			;6a9d
	pop af			;6a9e
	ret			;6a9f
ranking_nombre:		; pide el nombre para el ranking
	ld hl,03a29h		;6aa0
	ld bc,00616h		;6aa3
	xor a			;6aa6
	call rellena_ventana		;6aa7   ; rellena_ventana: rellena una ventana de B filas por C columnas con A
	call cursor_apaga		;6aaa   ; cursor_apaga: quita el cursor
	xor a			;6aad
	ld (0922ch),a		;6aae   ; guarda cuantas letras lleva el nombre
	ld (0922eh),a		;6ab1   ; guarda la opcion elegida
	ld hl,03a29h		;6ab4
	ld (09233h),hl		;6ab7   ; guarda la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	inc hl			;6aba
	ld (09231h),hl		;6abb   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld a,0c0h		;6abe
	ld (0922dh),a		;6ac0   ; guarda la ultima opcion del menu
	call cursor_pinta		;6ac3   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
L_6AC6:
	call ranking_edita		;6ac6   ; ranking_edita: edita el nombre del ranking
	call 00156h		;6ac9   ; BIOS KILBUF - Clears keyboard buffer
L_6ACC:
	ld hl,0922ch		;6acc   ; apunta a cuantas letras lleva el nombre
	ld de,0922eh		;6acf   ; apunta a la opcion elegida
	call 0009fh		;6ad2   ; BIOS CHGET - One character input (waiting)
	cp 01eh		;6ad5
	jr z,L_6B1C		;6ad7
	cp 01fh		;6ad9
	jr z,L_6AE2		;6adb
	cp 020h		;6add
	jr nz,L_6ACC		;6adf
	ret			;6ae1
L_6AE2:
	ld a,009h		;6ae2   ; ya esta en la ultima fila (9)
	cp (hl)			;6ae4
	jr z,L_6ACC		;6ae5
	inc (hl)			;6ae7   ; la siguiente
	ld a,(de)			;6ae8   ; la primera fila que se ve
	ld b,a			;6ae9
	ld a,(hl)			;6aea   ; la elegida menos la primera
	sub b			;6aeb
	cp 005h		;6aec   ; si cabe en las 5 filas de la ventana, no se mueve
	jr c,L_6AF8		;6aee
	inc b			;6af0   ; si no, la ventana baja una fila
	ld a,b			;6af1
	ld (de),a			;6af2
	ld bc,00000h		;6af3
	jr L_6AFB		;6af6
L_6AF8:
	ld bc,00020h		;6af8
L_6AFB:
	ld a,(hl)			;6afb
	cp 009h		;6afc
	jr nz,L_6B01		;6afe
	dec bc			;6b00
L_6B01:
	call cursor_borra		;6b01   ; cursor_borra: borra el cursor
	add hl,bc			;6b04
	push hl			;6b05
	ld de,(09233h)		;6b06   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	and a			;6b0a
	sbc hl,de		;6b0b
	ld a,(0922dh)		;6b0d   ; lee la ultima opcion del menu
	ld d,000h		;6b10
	ld e,a			;6b12
	rst 20h			;6b13   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;6b14
	jr nc,L_6B1A		;6b15
	ld (09231h),hl		;6b17   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
L_6B1A:
	jr L_6AC6		;6b1a
L_6B1C:
	ld a,(hl)			;6b1c   ; la fila elegida
	or a			;6b1d
	jr z,L_6ACC		;6b1e   ; ya esta en la primera
	dec (hl)			;6b20   ; la anterior
	ex de,hl			;6b21
	ld a,(de)			;6b22   ; si queda por encima de la ventana...
	cp (hl)			;6b23
	jr nc,L_6B27		;6b24
	dec (hl)			;6b26   ; ...la ventana sube una fila
L_6B27:
	ld bc,0ffe0h		;6b27
	ld a,(de)			;6b2a
	cp 008h		;6b2b
	jr nz,L_6B30		;6b2d
	inc bc			;6b2f
L_6B30:
	jr L_6B01		;6b30
rellena_vram:		; rellena la VRAM con A (letra a letra si la pantalla es de texto)
	call modo_de_texto		;6b32   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	ld a,000h		;6b35
	jp nz,00056h		;6b37   ; BIOS FILVRM - Fills VRAM with value
L_6B3A:
	call pon_letra		;6b3a   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6b3d
	dec c			;6b3e
	jr nz,L_6B3A		;6b3f
	ld a,(0f122h)		;6b41   ; lee la pagina activa guardada
	ld (0faf6h),a		;6b44   ; guarda ACPAGE, la pagina activa
	ret			;6b47
copia_a_vram:		; copia BC bytes de HL a la VRAM DE (letra a letra si es de texto)
	call modo_de_texto		;6b48   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	jp nz,0005ch		;6b4b   ; BIOS LDIRVM - Block transfers to VRAM from memory
L_6B4E:
	ld a,(hl)			;6b4e
	ex de,hl			;6b4f
	call pon_letra		;6b50   ; pon_letra: escribe A en la VRAM HL guardando los registros
	ex de,hl			;6b53
	inc hl			;6b54
	inc de			;6b55
	dec bc			;6b56
	ld a,b			;6b57
	or c			;6b58
	jr nz,L_6B4E		;6b59
	ld a,(0f122h)		;6b5b   ; lee la pagina activa guardada
	ld (0faf6h),a		;6b5e   ; guarda ACPAGE, la pagina activa
	ret			;6b61
ranking_edita:		; edita el nombre del ranking
	ld a,(0922eh)		;6b62   ; lee la opcion elegida
	call fila_de_ranking		;6b65   ; fila_de_ranking: HL = la fila A del ranking (0x9257, 9 bytes)
	push hl			;6b68
	pop ix		;6b69
	ld a,(0922eh)		;6b6b   ; lee la opcion elegida
	call puntos_de_ranking		;6b6e   ; puntos_de_ranking: HL = los puntos de la fila A (0x9239, 3 bytes)
	push hl			;6b71
	pop iy		;6b72
	ld hl,(09233h)		;6b74   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	inc hl			;6b77
	ld a,(0922eh)		;6b78   ; lee la opcion elegida
	add a,031h		;6b7b
	ld c,a			;6b7d
	ld b,005h		;6b7e
L_6B80:
	push bc			;6b80
	push hl			;6b81
	push hl			;6b82
	push bc			;6b83
	xor a			;6b84
	ld bc,00015h		;6b85
	call rellena_vram		;6b88   ; rellena_vram: rellena la VRAM con A (letra a letra si la pantalla es de texto)
	call cursor_pinta		;6b8b   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
	pop bc			;6b8e
	pop hl			;6b8f
	ld a,c			;6b90
	cp 03ah		;6b91
	jr z,L_6B9B		;6b93
	inc hl			;6b95
	call pon_letra		;6b96   ; pon_letra: escribe A en la VRAM HL guardando los registros
	jr L_6BA6		;6b99
L_6B9B:
	ld a,031h		;6b9b
	call pon_letra		;6b9d   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6ba0
	ld a,030h		;6ba1
	call pon_letra		;6ba3   ; pon_letra: escribe A en la VRAM HL guardando los registros
L_6BA6:
	inc hl			;6ba6   ; la columna siguiente
	ld a,03bh		;6ba7   ; ';'
	call pon_letra		;6ba9   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6bac
	push ix		;6bad   ; el nombre de la fila (IX)...
	pop de			;6baf
	ex de,hl			;6bb0
	ld bc,00008h		;6bb1   ; ...8 letras...
	push de			;6bb4
	push bc			;6bb5
	call copia_a_vram		;6bb6   ; ...a la VRAM
	ld hl,0e000h		;6bb9   ; los puntos (IY, 3 bytes BCD) en hexadecimal a 0xE000:
	ld a,(iy+002h)		;6bbc   ; el byte alto
	call 05099h		;6bbf   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	inc hl			;6bc2
	ld a,(iy+001h)		;6bc3   ; el medio
	call 05099h		;6bc6   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	inc hl			;6bc9
	ld a,(iy+000h)		;6bca   ; el bajo
	call 05099h		;6bcd   ; byte_a_hex: escribe A en hexadecimal (dos letras) en HL
	pop bc			;6bd0
	pop hl			;6bd1
	add hl,bc			;6bd2
	ld a,03eh		;6bd3   ; '>'
	call pon_letra		;6bd5   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6bd8
	ld de,0e000h		;6bd9   ; las 6 cifras de 0xE000
	ld bc,00600h		;6bdc
	ld a,(0f281h)		;6bdf   ; el juego de codigo 0x29...
	cp 029h		;6be2
	jr nz,L_6BE9		;6be4
	inc de			;6be6   ; ...cuenta con 5 cifras: se salta la primera
	dec b			;6be7
	inc c			;6be8
L_6BE9:
	ld a,(de)			;6be9   ; se salta los ceros de la izquierda
	cp 030h		;6bea
	jr nz,L_6BFD		;6bec
	inc hl			;6bee
	inc de			;6bef
	djnz L_6BE9		;6bf0
	bit 0,c		;6bf2   ; bit 0 de C: si el numero es impar de cifras...
	jr nz,L_6BF7		;6bf4
	dec hl			;6bf6   ; ...retrocede una
L_6BF7:
	call pon_letra		;6bf7   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6bfa
	jr L_6C15		;6bfb
L_6BFD:
	push bc			;6bfd   ; las cifras que quedan
	ld c,b			;6bfe
	ld b,000h		;6bff
	ex de,hl			;6c01
	push bc			;6c02
	push de			;6c03
	call copia_a_vram		;6c04   ; a la VRAM
	pop hl			;6c07
	pop bc			;6c08
	add hl,bc			;6c09   ; avanza
	pop bc			;6c0a
	bit 0,c		;6c0b   ; con un numero impar de cifras...
	jr z,L_6C15		;6c0d
	ld a,030h		;6c0f   ; ...un 0 al final
	call pon_letra		;6c11   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;6c14
L_6C15:
	ld de,06c35h		;6c15   ; pinta las tres letras de p01:6C35
	ex de,hl			;6c18
	ld bc,00003h		;6c19
	call copia_a_vram		;6c1c   ; copia_a_vram: copia BC bytes de HL a la VRAM DE (letra a letra si es de texto)
	ld bc,00009h		;6c1f   ; la fila siguiente del ranking: 9 bytes de nombre...
	add ix,bc		;6c22
	ld bc,00003h		;6c24   ; ...y 3 de puntos
	add iy,bc		;6c27
	pop hl			;6c29
	ld bc,00020h		;6c2a   ; la fila siguiente de la pantalla
	add hl,bc			;6c2d
	pop bc			;6c2e
	inc c			;6c2f   ; la posicion
	dec b			;6c30   ; las B filas
	jp nz,L_6B80		;6c31
	ret			;6c34

; ----------------------------------------------------------------------
; DATOS resto_6C35: lo apuntan con el banco puesto p01:6C15 (0x6C35); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6C15 (3 bytes)
;   0x6c35..0x6c38  (3 bytes)
DATA_resto_6C35:
	defb 050h,054h,053h	; 6c35

; ======================================================================
; CODIGO 0x6c38..0x6c50  (24 bytes)
; ======================================================================


fila_de_ranking:		; HL = la fila A del ranking (0x9257, 9 bytes)
	ld b,a			;6c38
	add a,a			;6c39
	add a,b			;6c3a
	ld b,a			;6c3b
	add a,a			;6c3c
	add a,b			;6c3d
	ld hl,09257h		;6c3e   ; apunta a los nombres del ranking (9 bytes por fila)
	call hl_mas_a		;6c41   ; hl_mas_a: HL = HL + A
	inc hl			;6c44
	ret			;6c45
puntos_de_ranking:		; HL = los puntos de la fila A (0x9239, 3 bytes)
	ld b,a			;6c46
	add a,a			;6c47
	add a,b			;6c48
	ld hl,09239h		;6c49   ; apunta a los puntos del ranking (3 bytes por fila)
	call hl_mas_a		;6c4c   ; hl_mas_a: HL = HL + A
	ret			;6c4f

; ----------------------------------------------------------------------
; DATOS resto_6C50: lo apuntan con el banco puesto p01:60FA (0x6CA6), p01:67F9
;   (0x6CA6), p01:607E (0x6CD7), p01:680A (0x6CD7); el tamano es lo que hay
;   hasta lo siguiente, no sale de recorrerlo; lo leen p01:60FA, p01:67F9,
;   p01:607E, p01:680A (199 bytes)
;   0x6c50..0x6d17  (199 bytes)
DATA_resto_6C50:
	defb 000h,080h,02ah,02ah,02ah,020h,052h,043h,02dh,037h,020h,020h,020h,053h,043h,04fh	; 6c50  ..*** RC-7   SCO
	defb 052h,045h,020h,052h,041h,04eh,04bh,049h,04eh,047h,020h,02ah,02ah,02ah,0feh,03ah	; 6c60  RE RANKING ***.:
	defb 080h,052h,061h,06eh,06bh,02eh,020h,020h,04eh,061h,06dh,065h,02eh,020h,020h,020h	; 6c70  .Rank.  Name.
	defb 053h,063h,06fh,072h,065h,02eh,0feh,054h,080h,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 6c80  Score..T.-------
	defb 02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh,02dh	; 6c90  ----------------
	defb 02dh,02dh,02dh,02dh,02dh,0ffh,000h,027h,06dh,002h,027h,06dh,003h,027h,06dh,004h	; 6ca0  -----..'m.'m.'m.
	defb 027h,06dh,005h,027h,06dh,006h,027h,06dh,012h,027h,06dh,013h,027h,06dh,014h,027h	; 6cb0  'm.'m.'m.'m.'m.'
	defb 06dh,016h,027h,06dh,025h,017h,06dh,021h,027h,06dh,027h,027h,06dh,028h,034h,06dh	; 6cc0  m.'m%.m!'m''m(4m
	defb 029h,02fh,06dh,037h,02fh,06dh,0ffh,000h,0d8h,06dh,001h,0fdh,06dh,010h,038h,06eh	; 6cd0  )/m7/m...m..m.8n
	defb 011h,038h,06eh,012h,081h,06eh,013h,097h,06eh,014h,0e9h,06eh,015h,0ech,06eh,016h	; 6ce0  .8n..n..n..n..n.
	defb 0d8h,06dh,017h,0f3h,06eh,018h,0ffh,06eh,021h,037h,06fh,025h,048h,06fh,027h,078h	; 6cf0  .m..n..n!7o%Ho'x
	defb 06fh,028h,0c9h,06fh,029h,0e4h,06fh,030h,0f7h,06fh,032h,016h,070h,033h,01fh,070h	; 6d00  o(.o).o0.o2.p3.p
	defb 036h,028h,070h,037h,04eh,070h,0ffh	; 6d10

; ======================================================================
; CODIGO 0x6d17..0x6d87  (112 bytes)
; ======================================================================


L_6D17:
	ld a,0ffh		;6d17   ; 0xE052 = 0xFF en la RAM del juego
	ld (0e052h),a		;6d19
	ld a,(0f299h)		;6d1c   ; la fase pedida...
	cp 00bh		;6d1f   ; ...con tope 10
	jr c,L_6D25		;6d21
	ld a,00ah		;6d23
L_6D25:
	jr L_6D2A		;6d25
L_6D27:
	ld a,(0f299h)		;6d27
L_6D2A:
	ld hl,(0f288h)		;6d2a
	ld (hl),a			;6d2d
	ret			;6d2e
truco_6d2f:		; pone 0xF29A en la variable del juego
	ld a,(0f29ah)		;6d2f
	jr L_6D2A		;6d32
L_6D34:
	ld a,(0f299h)		;6d34
	ld (0e050h),a		;6d37
	ld a,(0f29ah)		;6d3a
	ld (0e051h),a		;6d3d
	ret			;6d40
truco_6d41:		; calcula el valor que se escribe en el juego (p01:706C)
	ld a,(0f293h)		;6d41   ; lee la fase elegida
	ld c,a			;6d44   ; C = cuantas fases tiene el juego
	ld a,(0f29bh)		;6d45   ; la fase pedida
	call divide_a_menos_1		;6d48   ; entre C
	ld a,l			;6d4b   ; el resto + 1...
	inc a			;6d4c
	ld hl,(0f28ah)		;6d4d   ; ...a la variable de fase del juego
	ld (hl),a			;6d50
	push hl			;6d51
	push af			;6d52
	call busca_juego_6dc9		;6d53   ; ¿el juego tiene mas que poner? (tabla de p01:6DC9)
	pop af			;6d56
	pop hl			;6d57
	dec c			;6d58   ; C = el tipo: 0 nada mas...
	ret m			;6d59
	jr z,$+67		;6d5a   ; ...1, 2 o 3: una de las tres
	dec c			;6d5c
	jr z,$+61		;6d5d
	dec c			;6d5f
	jr z,$+58		;6d60
	ld c,a			;6d62   ; si no, la fase en BCD
	ld l,a			;6d63
	xor a			;6d64
	ld b,008h		;6d65
L_6D67:
	rl l		;6d67   ; pasa L a BCD bit a bit
	adc a,a			;6d69
	daa			;6d6a   ; en decimal
	djnz L_6D67		;6d6b
	ld (0c411h),a		;6d6d   ; a la RAM del juego (0xC411)
	ld a,c			;6d70
	ld (0d000h),a		;6d71   ; y C a 0xD000
	ld hl,06d87h		;6d74   ; el valor de la tabla de p01:6D87
	call hl_mas_a		;6d77   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;6d7a
	ld (0d002h),a		;6d7b   ; a 0xD002 del juego
	xor a			;6d7e   ; 0xD001 del juego a 0
	ld (0d001h),a		;6d7f
	inc a			;6d82
	ld (0c40dh),a		;6d83   ; y 0xC40D a 1
	ret			;6d86

; ----------------------------------------------------------------------
; DATOS resto_6D87: lo apuntan con el banco puesto p01:6D74 (0x6D87); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6D74 (19 bytes)
;   0x6d87..0x6d9a  (19 bytes)
DATA_resto_6D87:
	defb 000h,000h,000h,000h,001h,001h,001h,002h,002h,002h,003h,003h,003h,004h,004h,004h	; 6d87  ................
	defb 005h,005h,005h	; 6d97

; ======================================================================
; CODIGO 0x6d9a..0x6dc9  (47 bytes)
; ======================================================================


L_6D9A:
	dec a			;6d9a
	ld (hl),a			;6d9b
	ret			;6d9c
L_6D9D:
	ld (0c481h),a		;6d9d   ; la fase a 0xC481 de la RAM del juego
	dec a			;6da0
	ld (0c482h),a		;6da1   ; y la anterior a 0xC482
	ld l,a			;6da4   ; por 3, mas 1...
	add a,a			;6da5
	add a,l			;6da6
	inc a			;6da7
	ld (0c480h),a		;6da8   ; ...a 0xC480
	ld a,001h		;6dab
	ld (0c483h),a		;6dad   ; 0xC483 a 1
	ret			;6db0
busca_juego_6dc9:		; busca el juego (0xF280) en la tabla de p01:6DC9
	ld hl,06dc9h		;6db1
	ld de,(0f280h)		;6db4   ; lee la ficha del juego y el byte siguiente (16 bits)
L_6DB8:
	ld b,(hl)			;6db8   ; recorre la tabla [palabra, byte]: B = la parte alta...
	inc hl			;6db9
	ld a,(hl)			;6dba   ; ...y la baja
	or b			;6dbb   ; 0x0000 acaba
	ld a,(hl)			;6dbc
	inc hl			;6dbd
	ld c,(hl)			;6dbe   ; C = el valor
	ret z			;6dbf
	inc hl			;6dc0
	cp e			;6dc1   ; ¿coincide con la del juego (DE)?
	jr nz,L_6DB8		;6dc2
	ld a,b			;6dc4
	cp d			;6dc5
	ret z			;6dc6   ; si: C es el valor
	jr L_6DB8		;6dc7

; ----------------------------------------------------------------------
; DATOS resto_6DC9: lo apuntan con el banco puesto p01:6DB1 (0x6DC9); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6DB1 (15 bytes)
;   0x6dc9..0x6dd8  (15 bytes)
DATA_resto_6DC9:
	defb 047h,007h,001h,048h,007h,002h,053h,007h,003h,044h,007h,004h,000h,000h,000h	; 6dc9  G..H..S..D.....

; ======================================================================
; CODIGO 0x6dd8..0x6e24  (76 bytes)
; ======================================================================


L_6DD8:
	ld a,(0f29bh)		;6dd8   ; la fase pedida - 1...
	dec a			;6ddb
	ld l,a			;6ddc
	ld h,000h		;6ddd
	add hl,hl			;6ddf   ; ...x 10 (x2, x8 y suma)
	ld b,h			;6de0
	ld c,l			;6de1
	add hl,hl			;6de2
	add hl,hl			;6de3
	add hl,bc			;6de4
	call binario_a_bcd		;6de5   ; en BCD
	ld a,e			;6de8   ; a 0xE059 de la RAM del juego
	ld (0e059h),a		;6de9
	push af			;6dec   ; mas 10 (BCD)...
	add a,010h		;6ded
	daa			;6def
	ld (0e05ah),a		;6df0   ; ...a 0xE05A
	pop af			;6df3
	call bcd_a_binario		;6df4   ; en binario...
	ld (0e054h),a		;6df7   ; ...a 0xE054
	jp pon_valor		;6dfa   ; y el valor elegido
L_6DFD:
	ld a,(0f29bh)		;6dfd   ; la fase pedida
	ld c,00ah		;6e00   ; entre 10
	call divide_a_menos_1		;6e02   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6e05   ; el resto...
	ld (0e0e1h),a		;6e06
	ld (0e0e8h),a		;6e09
	ld b,a			;6e0c
	ld a,(0f283h)		;6e0d
	or a			;6e10
	ld hl,06e24h		;6e11
	jr z,L_6E19		;6e14
	ld hl,06e2eh		;6e16
L_6E19:
	ld a,b			;6e19
	call hl_mas_a		;6e1a   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;6e1d
	ld (0e0e2h),a		;6e1e
	jp pon_valor		;6e21   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)

; ----------------------------------------------------------------------
; DATOS resto_6E24: lo apuntan con el banco puesto p01:6E11 (0x6E24), p01:6E16
;   (0x6E2E); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6E11, p01:6E16 (20 bytes)
;   0x6e24..0x6e38  (20 bytes)
DATA_resto_6E24:
	defb 000h,006h,00dh,013h,01ah,022h,027h,02dh,033h,035h,000h,007h,00fh,014h,01ah,020h	; 6e24  ....."'-35.....
	defb 022h,02fh,035h,03ch	; 6e34

; ======================================================================
; CODIGO 0x6e38..0x6e71  (57 bytes)
; ======================================================================


L_6E38:
	ld a,(0f29bh)		;6e38   ; lee la fase que se pide
	ld c,004h		;6e3b
	call divide_a_menos_1		;6e3d   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6e40
	inc a			;6e41
	ld hl,(0f28ah)		;6e42   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld (hl),a			;6e45
	ld (0e015h),a		;6e46
	dec a			;6e49
	push af			;6e4a
	add a,a			;6e4b
	ld b,a			;6e4c
	ld hl,06e71h		;6e4d
	ld a,(0f281h)		;6e50   ; lee el codigo del juego
	cp 010h		;6e53
	jr z,L_6E5A		;6e55
	ld hl,06e79h		;6e57
L_6E5A:
	ld a,b			;6e5a
	call hl_mas_a		;6e5b   ; hl_mas_a: HL = HL + A
	ex de,hl			;6e5e
	pop af			;6e5f
	ld b,a			;6e60
	add a,a			;6e61
	add a,b			;6e62
	ld hl,0e050h		;6e63
	call hl_mas_a		;6e66   ; hl_mas_a: HL = HL + A
	ex de,hl			;6e69
	inc de			;6e6a
	ld bc,00002h		;6e6b
	ldir		;6e6e
	ret			;6e70

; ----------------------------------------------------------------------
; DATOS resto_6E71: lo apuntan con el banco puesto p01:6E4D (0x6E71), p01:6E57
;   (0x6E79); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6E4D, p01:6E57 (16 bytes)
;   0x6e71..0x6e81  (16 bytes)
DATA_resto_6E71:
	defb 014h,000h,006h,000h,080h,000h,055h,000h,015h,000h,075h,000h,002h,030h,004h,030h	; 6e71  ......U...u..0.0

; ======================================================================
; CODIGO 0x6e81..0x6ece  (77 bytes)
; ======================================================================


L_6E81:
	call pon_valor		;6e81   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
	ld a,(0f29bh)		;6e84   ; lee la fase que se pide
	ld l,a			;6e87
	sub 005h		;6e88
	jr c,L_6E92		;6e8a
	inc a			;6e8c
	ld c,005h		;6e8d
	call divide_a_menos_1		;6e8f   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
L_6E92:
	ld a,l			;6e92
	ld (0e052h),a		;6e93
	ret			;6e96
L_6E97:
	call pon_valor		;6e97   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
	ld a,(0f29bh)		;6e9a   ; lee la fase que se pide
	ld b,a			;6e9d
	dec a			;6e9e
	ld (0e05ch),a		;6e9f
	cp 008h		;6ea2
	jr c,L_6EA8		;6ea4
	ld a,008h		;6ea6
L_6EA8:
	ld hl,06eceh		;6ea8
	call hl_mas_a		;6eab   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;6eae
	ld (0e05dh),a		;6eaf
	ld a,08ah		;6eb2
	ld (0e056h),a		;6eb4
	ld a,b			;6eb7   ; la fase pedida
	ld c,009h		;6eb8   ; entre 9
	call divide_a_menos_1		;6eba   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6ebd   ; el resto x 2...
	add a,a			;6ebe
	ld hl,06ed7h		;6ebf
	call hl_mas_a		;6ec2   ; hl_mas_a: HL = HL + A
	ld de,0e054h		;6ec5
	ld bc,00002h		;6ec8
	ldir		;6ecb
	ret			;6ecd

; ----------------------------------------------------------------------
; DATOS resto_6ECE: lo apuntan con el banco puesto p01:6EA8 (0x6ECE), p01:6EBF
;   (0x6ED7); el tamano es lo que hay hasta lo siguiente, no sale de
;   recorrerlo; lo leen p01:6EA8, p01:6EBF (27 bytes)
;   0x6ece..0x6ee9  (27 bytes)
DATA_resto_6ECE:
	defb 077h,033h,0bbh,0eeh,011h,0bbh,0eeh,011h,011h,000h,000h,070h,00ch,020h,01ah,050h	; 6ece  w3.........p. .P
	defb 028h,030h,036h,0e0h,043h,040h,052h,0c0h,061h,0d0h,06eh	; 6ede  (06.C@R.a.n

; ======================================================================
; CODIGO 0x6ee9..0x6f1d  (52 bytes)
; ======================================================================


L_6EE9:
	jp pon_valor		;6ee9   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
L_6EEC:
	ld a,(0f29bh)		;6eec   ; lee la fase que se pide
	dec a			;6eef
	jp L_6F73		;6ef0
L_6EF3:
	ld a,(0f29bh)		;6ef3   ; lee la fase que se pide
	ld c,003h		;6ef6
	call divide_a_menos_1		;6ef8   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6efb
	jp L_6F73		;6efc
L_6EFF:
	ld a,(0f29bh)		;6eff   ; lee la fase que se pide
	ld c,00dh		;6f02   ; entre 13
	call divide_a_menos_1		;6f04   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6f07   ; el resto + 1...
	inc a			;6f08
	ld (0e060h),a		;6f09
	dec a			;6f0c
	add a,a			;6f0d
	ld hl,06f1dh		;6f0e
	call hl_mas_a		;6f11   ; hl_mas_a: HL = HL + A
	ld de,0e05bh		;6f14
	ld bc,00002h		;6f17
	ldir		;6f1a
	ret			;6f1c

; ----------------------------------------------------------------------
; DATOS resto_6F1D: lo apuntan con el banco puesto p01:6F0E (0x6F1D); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6F0E (26 bytes)
;   0x6f1d..0x6f37  (26 bytes)
DATA_resto_6F1D:
	defb 006h,080h,006h,070h,006h,070h,006h,070h,006h,060h,006h,050h,006h,050h,006h,050h	; 6f1d  ...p.p.p.`.P.P.P
	defb 006h,060h,006h,060h,006h,050h,006h,050h,000h,080h	; 6f2d  .`.`.P.P..

; ======================================================================
; CODIGO 0x6f37..0x6fa9  (114 bytes)
; ======================================================================


L_6F37:
	ld a,(0f29bh)		;6f37   ; lee la fase que se pide
	ld c,008h		;6f3a
	call divide_a_menos_1		;6f3c   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld h,l			;6f3f
	ld l,000h		;6f40
	ld (0e1b8h),hl		;6f42
	jp pon_valor		;6f45   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
L_6F48:
	call pon_valor		;6f48   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
	ld a,(0f29bh)		;6f4b   ; la fase pedida
	push af			;6f4e
	ld c,005h		;6f4f   ; entre 5
	call divide_a_menos_1		;6f51   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6f54
	ld (0e054h),a		;6f55
	pop af			;6f58
	cp 006h		;6f59   ; de la 6 en adelante...
	ret c			;6f5b
	ld b,a			;6f5c
	sub 005h		;6f5d   ; ...la parte de arriba (con tope 3)...
	cp 004h		;6f5f
	jr c,L_6F65		;6f61
	ld a,003h		;6f63
L_6F65:
	ld (0e056h),a		;6f65   ; A a 0xE056 de la RAM del juego
	ld a,b			;6f68   ; y B - 1 (0-3) a 0xE059
	dec a			;6f69
	and 003h		;6f6a
	ld (0e059h),a		;6f6c
	ret			;6f6f
pon_valor:		; escribe 0xF29C en la variable del juego (0xF28A)
	ld a,(0f29ch)		;6f70   ; lee el valor que se escribe
L_6F73:
	ld hl,(0f28ah)		;6f73   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld (hl),a			;6f76
	ret			;6f77
L_6F78:
	ld a,(0f29bh)		;6f78   ; el juego de codigo 0x27 (tabla p01:6CD7): la fase pedida
	ld c,00fh		;6f7b   ; entre 15
	call divide_a_menos_1		;6f7d   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,e			;6f80   ; el cociente a 0xE058 del juego
	ld (0e058h),a		;6f81
	ld a,l			;6f84   ; el resto + 1 a 0xE055...
	inc a			;6f85
	ld (0e055h),a		;6f86
	dec a			;6f89   ; ...y el resto a 0xE054
	ld (0e054h),a		;6f8a
	ld hl,06fa9h		;6f8d   ; dos bytes de la tabla de p01:6FA9...
	add a,a			;6f90
	call hl_mas_a		;6f91   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;6f94   ; ...a 0xE056 y 0xE057 del juego
	ld (0e056h),a		;6f95
	inc hl			;6f98
	ld a,(hl)			;6f99
	ld (0e057h),a		;6f9a
	ld a,(0e055h)		;6f9d   ; en la primera fase...
	cp 001h		;6fa0
	jr z,L_6FA5		;6fa2
	xor a			;6fa4
L_6FA5:
	ld (0e051h),a		;6fa5
	ret			;6fa8

; ----------------------------------------------------------------------
; DATOS resto_6FA9: lo apuntan con el banco puesto p01:6F8D (0x6FA9); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:6F8D (32 bytes)
;   0x6fa9..0x6fc9  (32 bytes)
DATA_resto_6FA9:
	defb 008h,000h,004h,008h,004h,008h,001h,008h,008h,004h,008h,004h,004h,004h,004h,008h	; 6fa9  ................
	defb 001h,008h,008h,004h,008h,004h,004h,004h,004h,008h,004h,008h,001h,002h,008h,004h	; 6fb9  ................

; ======================================================================
; CODIGO 0x6fc9..0x70f8  (303 bytes)
; ======================================================================


L_6FC9:
	ld a,(0f29bh)		;6fc9   ; lee la fase que se pide
	cp 033h		;6fcc
	jr c,L_6FD2		;6fce
	sub 032h		;6fd0
L_6FD2:
	dec a			;6fd2
	ld (0e053h),a		;6fd3
	ld a,(0f29ch)		;6fd6   ; el valor elegido...
	cp 051h		;6fd9   ; ...de 0x51 en adelante...
	jr c,L_6FE0		;6fdb
	sub 050h		;6fdd   ; ...resta 0x50 en BCD
	daa			;6fdf
L_6FE0:
	ld (0e052h),a		;6fe0
	ret			;6fe3
L_6FE4:
	ld a,(0f29bh)		;6fe4   ; lee la fase que se pide
	ld c,008h		;6fe7   ; entre 8
	call divide_a_menos_1		;6fe9   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;6fec
	ld (0e103h),a		;6fed
	ld hl,000c0h		;6ff0
	ld (0e1b8h),hl		;6ff3
	ret			;6ff6
L_6FF7:
	ld a,(0f29bh)		;6ff7   ; lee la fase que se pide
	ld c,006h		;6ffa   ; entre 6
	call divide_a_menos_1		;6ffc   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,e			;6fff
	ld (0e042h),a		;7000
	ld a,l			;7003
	ld hl,(0f28ah)		;7004   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld (hl),a			;7007
	call borra_pantalla_b		;7008   ; borra la pantalla
	ld a,004h		;700b
	ld (0e001h),a		;700d
	ld a,008h		;7010
	ld (0e000h),a		;7012
	ret			;7015
L_7016:
	call borra_pantalla_b		;7016   ; borra_pantalla_b: borra la tabla de nombres y esconde los sprites
	ld hl,(0f284h)		;7019
	ld (hl),007h		;701c
	ret			;701e
L_701F:
	ld a,(0f29bh)		;701f   ; lee la fase que se pide
	dec a			;7022
	ld hl,(0f28ah)		;7023   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld (hl),a			;7026
	ret			;7027
L_7028:
	ld a,(0f29bh)		;7028   ; lee la fase que se pide
	dec a			;702b
	ld (0e206h),a		;702c
	call pon_valor		;702f   ; pon_valor: escribe 0xF29C en la variable del juego (0xF28A)
	ld a,(0f29bh)		;7032   ; la fase pedida
	ld c,003h		;7035   ; entre 3
	call divide_a_menos_1		;7037   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,e			;703a   ; el cociente a la parte alta...
	and 00fh		;703b
	rrca			;703d
	rrca			;703e
	rrca			;703f
	rrca			;7040
	add a,l			;7041   ; ...y el resto a la baja...
	ld (0e207h),a		;7042
	ld a,009h		;7045
	ld hl,(0f284h)		;7047
	ld (hl),a			;704a
	jp borra_pantalla_b		;704b   ; y borra la pantalla
L_704E:
	ld a,(0f29bh)		;704e   ; lee la fase que se pide
	ld c,008h		;7051   ; entre 8
	call divide_a_menos_1		;7053   ; divide_a_menos_1: DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	ld a,l			;7056
	ld hl,(0f28ah)		;7057   ; lee la variable del juego que se cambia y el byte siguiente (16 bits)
	ld (hl),a			;705a
	ld a,e			;705b   ; el cociente, con tope 2
	cp 002h		;705c
	jr c,L_7062		;705e
	ld a,002h		;7060
L_7062:
	ld (0e06ah),a		;7062
	ld a,(0f29ch)		;7065   ; lee el valor que se escribe
	ld (0e053h),a		;7068
	ret			;706b
divide_a_menos_1:		; DE = (A - 1) / C y HL = el resto (division de 16 bits, bit a bit)
	dec a			;706c
	ld e,a			;706d
	ld d,000h		;706e
	ld b,d			;7070
divide:		; DE / BC: cociente en DE y resto en HL (gemela de p05:9430)
	ld hl,00000h		;7071
	exx			;7074
	ld b,010h		;7075
L_7077:
	exx			;7077   ; un paso de la division: el bit alto de DE...
	sla e		;7078
	rl d		;707a
	adc hl,hl		;707c   ; ...entra en HL
	sbc hl,bc		;707e   ; si cabe el divisor, se resta...
	jr c,L_7085		;7080
	inc e			;7082   ; ...y el bit del cociente es 1
	jr L_7086		;7083
L_7085:
	add hl,bc			;7085
L_7086:
	exx			;7086
	djnz L_7077		;7087
	exx			;7089
	ret			;708a
borra_pantalla_b:		; borra la tabla de nombres y esconde los sprites
	ld hl,03800h		;708b
	xor a			;708e
	ld bc,00300h		;708f
	call 00056h		;7092   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;7095
	ld a,0d0h		;7098
	jp 0004dh		;709a   ; BIOS WRTVRM - Writes data in VRAM
reconoce_juego:		; reconoce el juego del otro cartucho y prepara su ficha
	call ficha_del_juego		;709d   ; ficha_del_juego: busca la ficha del juego (p00:44BE) y la copia a 0xF280
	call lee_cabecera_juego		;70a0   ; lee_cabecera_juego: lee la cabecera de 0x4028 del juego y sus opciones
	ld hl,(0f120h)		;70a3
	ld (0f118h),hl		;70a6
	ret			;70a9
lee_cabecera_juego:		; lee la cabecera de 0x4028 del juego y sus opciones
	ld hl,(0f280h)		;70aa   ; el RC del juego
	ld a,l			;70ad   ; en orden
	ld l,h			;70ae
	ld h,a			;70af
	ld de,00754h		;70b0   ; antes del RC-754...
	rst 20h			;70b3   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr c,L_70D0		;70b4
	ld hl,04028h		;70b6
	ld de,0f11ch		;70b9   ; apunta a la cabecera de 0x4028 del juego (6 bytes)
	ld bc,00006h		;70bc
	call copia_del_juego		;70bf   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE
	ld hl,0f11ch		;70c2   ; apunta a la cabecera de 0x4028 del juego (6 bytes)
	ld a,(hl)			;70c5   ; el primer byte
	res 7,(hl)		;70c6   ; sin el bit 7
	add a,a			;70c8   ; el bit 7: el juego tiene SCC
	ret nc			;70c9
	ld a,001h		;70ca
	ld (0f124h),a		;70cc   ; guarda el juego tiene SCC
	ret			;70cf
L_70D0:
	ex de,hl			;70d0
	ld hl,07104h		;70d1
L_70D4:
	ld a,(hl)			;70d4   ; recorre la tabla de RC: 0xFF acaba
	inc hl			;70d5
	cp 0ffh		;70d6
	jr z,L_70E9		;70d8
	cp e			;70da   ; ¿la parte baja?
	jr nz,L_70E1		;70db
	ld a,(hl)			;70dd   ; ¿y la alta?
	cp d			;70de
	jr z,L_70E4		;70df   ; es este juego
L_70E1:
	inc hl			;70e1
	jr L_70D4		;70e2
L_70E4:
	ld hl,070f8h		;70e4
	jr L_70EC		;70e7
L_70E9:
	ld hl,070feh		;70e9
L_70EC:
	ld de,0f11ch		;70ec   ; apunta a la cabecera de 0x4028 del juego (6 bytes)
	ld bc,00006h		;70ef
	ldir		;70f2
	call rc_751_o_752		;70f4   ; rc_751_o_752: compara el RC del juego (0xE000, al reves) con 0x751 y 0x752
	ret			;70f7

; ----------------------------------------------------------------------
; DATOS resto_70F8: lo apuntan con el banco puesto p01:70E4 (0x70F8), p01:70E9
;   (0x70FE), p01:70D1 (0x7104); el tamano es lo que hay hasta lo siguiente,
;   no sale de recorrerlo; lo leen p01:70E4, p01:70E9, p01:70D1 (26 bytes)
;   0x70f8..0x7112  (26 bytes)
DATA_resto_70F8:
	defb 001h,001h,000h,002h,080h,0f6h,000h,000h,000h,000h,0ffh,0ffh,044h,007h,045h,007h	; 70f8  ............D.E.
	defb 047h,007h,048h,007h,050h,007h,053h,007h,0ffh,0ffh	; 7108  G.H.P.S...

; ======================================================================
; CODIGO 0x7112..0x71ed  (219 bytes)
; ======================================================================


ficha_del_juego:		; busca la ficha del juego (p00:44BE) y la copia a 0xF280
	call busca_ficha		;7112   ; busca_ficha: copia la ficha por defecto (p00:45D0) y busca la del juego por su suma
	ld a,(0f281h)		;7115   ; lee el codigo del juego
	ld b,a			;7118
	cp 036h		;7119
	jr nz,L_7123		;711b
	ld a,004h		;711d
	ld (0f292h),a		;711f   ; guarda el numero de jugadores del juego
	ret			;7122
L_7123:
	ld a,b			;7123   ; B = el codigo del juego: los de 3 y 4...
	sub 003h		;7124
	cp 002h		;7126
	jr c,L_7130		;7128
	ld a,b			;712a   ; ...y los de 0x10 y 0x11...
	sub 010h		;712b
	cp 002h		;712d
	ret nc			;712f   ; ...siguen; los demas vuelven
L_7130:
	ld a,001h		;7130
	ld (092ceh),a		;7132
	ret			;7135
busca_ficha:		; copia la ficha por defecto (p00:45D0) y busca la del juego por su suma
	ld hl,045d0h		;7136
	ld de,0f280h		;7139   ; apunta a la ficha del juego
	ld bc,00016h		;713c
	ldir		;713f
	ld a,0ffh		;7141
	ld (0f293h),a		;7143   ; guarda la fase elegida
	ld hl,04010h		;7146
	call 0576bh		;7149   ; lee_palabra_del_juego: DE = la palabra HL del cartucho del juego (RDSLT en 0xF104)
	ld hl,04241h		;714c
	rst 20h			;714f   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr nz,L_715E		;7150
	ld hl,04012h		;7152
	ld de,0f280h		;7155   ; apunta a la ficha del juego
	ld bc,00013h		;7158
	jp copia_del_juego		;715b   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE
L_715E:
	ld hl,04645h		;715e
	rst 20h			;7161   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_716B		;7162
	ld hl,04443h		;7164
	rst 20h			;7167   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp nz,L_71F9		;7168
L_716B:
	ld hl,04012h		;716b
	ld de,0e000h		;716e
	ld bc,0002dh		;7171
	call copia_del_juego		;7174   ; copia_del_juego: copia BC bytes de HL del cartucho del juego (RDSLT) a DE
	ld hl,0e000h		;7177
L_717A:
	ld de,0f280h		;717a   ; el RC de la cabecera del juego (2 bytes) a la ficha
	ldi		;717d
	ldi		;717f
	ld a,0ffh		;7181   ; 0xFF: el codigo de juego, aun sin saber
	ld (de),a			;7183
	inc de			;7184
	inc de			;7185
	ld bc,(0f280h)		;7186   ; el RC
	ld a,c			;718a   ; ¿RC-748...
	cp 007h		;718b
	jr nz,L_719C		;718d
	ld a,b			;718f
	cp 048h		;7190
	jr z,L_7199		;7192
	cp 050h		;7194   ; ...o RC-750?
	ret z			;7196   ; RC-750: ya esta
	jr L_719C		;7197
L_7199:
	ld hl,04828h		;7199
L_719C:
	ld a,(hl)			;719c
	rra			;719d
	jr c,L_71AB		;719e
	inc hl			;71a0
	ld bc,00002h		;71a1
	ldir		;71a4
	ld de,0f292h		;71a6   ; apunta a el numero de jugadores del juego
	ldi		;71a9
L_71AB:
	rra			;71ab   ; un bit de la cabecera por cada palabra
	jr c,L_71BA		;71ac   ; bit a 1: se salta
	ld de,0f28ah		;71ae   ; apunta a la variable del juego que se cambia
	ldi		;71b1
	ldi		;71b3
	ld de,0f293h		;71b5   ; apunta a la fase elegida
	ldi		;71b8
L_71BA:
	ld ix,071edh		;71ba
	ld b,006h		;71be
L_71C0:
	push bc			;71c0   ; un bit de la cabecera por cada palabra
	rra			;71c1   ; bit a 1: se salta
	jr c,L_71CF		;71c2
	ld e,(ix+000h)		;71c4   ; DE = el destino de IX
	ld d,(ix+001h)		;71c7
	ld bc,00002h		;71ca   ; copia 2 bytes
	ldir		;71cd
L_71CF:
	pop bc			;71cf
	inc ix		;71d0
	inc ix		;71d2
	djnz L_71C0		;71d4
	ret			;71d6
rc_751_o_752:		; compara el RC del juego (0xE000, al reves) con 0x751 y 0x752
	ld hl,(0e000h)		;71d7
	ld a,h			;71da
	ld h,l			;71db
	ld l,a			;71dc
	ld de,00751h		;71dd
	rst 20h			;71e0   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jr z,L_71E7		;71e1
	ld de,00752h		;71e3
	rst 20h			;71e6   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
L_71E7:
	ld a,001h		;71e7
	ld (0f124h),a		;71e9   ; guarda el juego tiene SCC
	ret			;71ec

; ----------------------------------------------------------------------
; DATOS resto_71ED: lo apuntan con el banco puesto p01:71BA (0x71ED); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:71BA (12 bytes)
;   0x71ed..0x71f9  (12 bytes)
DATA_resto_71ED:
	defb 088h,0f2h,08ch,0f2h,08eh,0f2h,090h,0f2h,086h,0f2h,094h,0f2h	; 71ed  ............

; ======================================================================
; CODIGO 0x71f9..0x728e  (149 bytes)
; ======================================================================


L_71F9:
	ld a,(0f104h)		;71f9   ; lee el slot del cartucho del juego
	ld de,00000h		;71fc
	ld hl,05000h		;71ff
	ld b,000h		;7202
L_7204:
	push af			;7204
	push bc			;7205
	push de			;7206
	call 0000ch		;7207   ; BIOS RDSLT - Reads the value of an address in another slot
	pop de			;720a
	pop bc			;720b
	add a,e			;720c
	ld e,a			;720d
	jr nc,L_7211		;720e
	inc d			;7210
L_7211:
	pop af			;7211
	inc hl			;7212
	djnz L_7204		;7213
	ld ix,044beh		;7215
L_7219:
	ld l,(ix+000h)		;7219   ; recorre la tabla de juegos (p00:44BE): la suma...
	ld h,(ix+001h)		;721c
	ld a,l			;721f   ; ...0 acaba la tabla
	or h			;7220
	ret z			;7221
	rst 20h			;7222   ; ¿es la del juego?
	jr z,L_722F		;7223   ; si: la ficha
	inc ix		;7225   ; la entrada siguiente, de 4 bytes
	inc ix		;7227
	inc ix		;7229
	inc ix		;722b
	jr L_7219		;722d
L_722F:
	push de			;722f   ; guarda DE
	ld l,(ix+002h)		;7230   ; la ficha que dice la tabla
	ld h,(ix+003h)		;7233
	push hl			;7236
	ld d,(hl)			;7237   ; su RC, al reves...
	inc hl			;7238
	ld e,(hl)			;7239
	ld hl,00744h		;723a   ; ...¿llega al RC-744?
	ex de,hl			;723d
	rst 20h			;723e   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;723f
	jr nc,L_724D		;7240   ; si: no vale
	ld de,0f280h		;7242   ; copia la ficha (19 bytes) a 0xF280
	ld bc,00013h		;7245
	ldir		;7248
	pop de			;724a
	scf			;724b   ; C: encontrada
	ret			;724c
L_724D:
	pop de			;724d
	jp L_717A		;724e
hl_mas_a:		; HL = HL + A
	add a,l			;7251
	ld l,a			;7252
	ret nc			;7253
	inc h			;7254
	ret			;7255
de_mas_a:		; DE = DE + A
	add a,e			;7256
	ld e,a			;7257
	ret nc			;7258
	inc d			;7259
	ret			;725a
pon_color:		; MSX2: el color B de la paleta con D y E (R#16 y puerto 2)
	push bc			;725b
	push hl			;725c
	ld b,a			;725d   ; B = el numero de color
	ld a,(00007h)		;725e   ; el puerto de escritura del VDP (VDP.DW)
	inc a			;7261   ; el puerto de los registros (VDP.DW + 1)
	ld c,a			;7262
	di			;7263
	out (c),b		;7264   ; el numero de color...
	ld a,090h		;7266   ; ...a R#16, el puntero de la paleta
	out (c),a		;7268
	inc c			;726a   ; el puerto de la paleta (VDP.DW + 2)
	out (c),d		;726b   ; rojo y azul
	push af			;726d   ; una pausa para el VDP
	pop af			;726e
	out (c),e		;726f   ; verde
	pop hl			;7271
	pop bc			;7272
	ei			;7273
	ret			;7274
paleta_msx2:		; MSX2: los 16 colores de p01:728E
	ld a,(0002dh)		;7275   ; la version del MSX (0 = MSX1)
	and a			;7278
	ret z			;7279
paleta_bio:		; MSX2: los 16 colores de p05:82D7 (gemela de p05:82C3)
	ld hl,0728eh		;727a
paleta_desde:		; MSX2: los 16 colores de HL (gemela de p05:82C6)
	ld b,010h		;727d
	ld a,000h		;727f
L_7281:
	ld d,(hl)			;7281
	inc hl			;7282
	ld e,(hl)			;7283
	inc hl			;7284
	push af			;7285
	call pon_color		;7286   ; pon_color: MSX2: el color B de la paleta con D y E (R#16 y puerto 2)
	pop af			;7289
	inc a			;728a
	djnz L_7281		;728b
	ret			;728d

; ----------------------------------------------------------------------
; DATOS resto_728E: lo apuntan con el banco puesto p01:727A (0x728E); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:727A (32 bytes)
;   0x728e..0x72ae  (32 bytes)
DATA_resto_728E:
	defb 000h,000h,000h,000h,011h,006h,033h,007h,017h,001h,027h,003h,051h,001h,027h,006h	; 728e  ......3...'.Q.'.
	defb 071h,001h,073h,003h,061h,006h,064h,006h,011h,004h,065h,002h,055h,005h,077h,007h	; 729e  q.s.a.d...e.U.w.

; ======================================================================
; CODIGO 0x72ae..0x72e2  (52 bytes)
; ======================================================================


paleta_lista:		; MSX2: colores de una lista [color, d, e] que acaba en 0xFF
	ld a,(hl)			;72ae   ; el numero de color
	inc hl			;72af
	inc a			;72b0   ; 0xFF acaba la lista
	ret z			;72b1
	dec a			;72b2
	ld d,(hl)			;72b3   ; D y E: el color
	inc hl			;72b4
	ld e,(hl)			;72b5
	inc hl			;72b6
	call pon_color		;72b7   ; a la paleta
	jr paleta_lista		;72ba
registros_vdp:		; los 8 registros del VDP de p01:72E2 y, en MSX2, R#23 y R#9
	ld hl,072e2h		;72bc
	ld bc,00800h		;72bf
L_72C2:
	push bc			;72c2
	ld b,(hl)			;72c3
	call 00047h		;72c4   ; BIOS WRTVDP - Writes data in the VDP-register
	pop bc			;72c7
	inc hl			;72c8
	inc c			;72c9
	djnz L_72C2		;72ca
	ld a,(0002dh)		;72cc   ; la version del MSX (0 = MSX1)
	and a			;72cf
	ret z			;72d0
	ld bc,00017h		;72d1
	call 00047h		;72d4   ; BIOS WRTVDP - Writes data in the VDP-register
	ld a,(0ffe8h)		;72d7   ; lee el registro 9 del VDP (copia de la BIOS)
	and 07fh		;72da
	ld b,a			;72dc
	ld c,009h		;72dd
	jp 00047h		;72df   ; BIOS WRTVDP - Writes data in the VDP-register

; ----------------------------------------------------------------------
; DATOS resto_72E2: lo apuntan con el banco puesto p01:72BC (0x72E2); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:72BC (8 bytes)
;   0x72e2..0x72ea  (8 bytes)
DATA_resto_72E2:
	defb 002h,0e2h,00eh,07fh,007h,076h,003h,0e1h	; 72e2  .....v..

; ======================================================================
; CODIGO 0x72ea..0x762b  (833 bytes)
; ======================================================================


borra_nombres:		; borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
	ld hl,03800h		;72ea
	ld bc,00300h		;72ed
	xor a			;72f0
	call 00056h		;72f1   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;72f4
	ld a,0d0h		;72f7
	jp 0004dh		;72f9   ; BIOS WRTVRM - Writes data in VRAM
rellena_tercios:		; FILVRM en los tres tercios de la pantalla
	ld d,003h		;72fc
L_72FE:
	push bc			;72fe
	push de			;72ff
	call 00056h		;7300   ; BIOS FILVRM - Fills VRAM with value
	ld bc,00800h		;7303
	add hl,bc			;7306
	pop de			;7307
	pop bc			;7308
	dec d			;7309
	jr nz,L_72FE		;730a
	ret			;730c
copia_tercios:		; LDIRVM en los tres tercios de la pantalla
	ld a,003h		;730d
L_730F:
	push af			;730f   ; A tercios: copia BC bytes de HL a la VRAM DE
	push bc			;7310
	push hl			;7311
	push de			;7312
	call 0005ch		;7313   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop de			;7316
	ld hl,00800h		;7317   ; el tercio siguiente esta 0x800 mas alla
	add hl,de			;731a
	ex de,hl			;731b
	pop hl			;731c
	pop bc			;731d
	pop af			;731e
	dec a			;731f   ; los A tercios
	jr nz,L_730F		;7320
	ret			;7322
descomprime_tercios:		; descomprime HL en los tres tercios de la pantalla
	ld b,003h		;7323
L_7325:
	push bc			;7325   ; B tercios: descomprime HL en la VRAM DE
	push hl			;7326
	push de			;7327
	call descomprime		;7328   ; descomprime: descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias
	pop de			;732b
	ld hl,00800h		;732c   ; el tercio siguiente esta 0x800 mas alla
	add hl,de			;732f
	ex de,hl			;7330
	pop hl			;7331
	pop bc			;7332
	djnz L_7325		;7333   ; los B tercios
	ret			;7335
descomprime_con_direccion:		; descomprime a la VRAM de la palabra de HL
	ld e,(hl)			;7336
	inc hl			;7337
	ld d,(hl)			;7338
	inc hl			;7339
descomprime:		; descomprime HL a la VRAM DE: n & 0x7F repeticiones o copias
	ex de,hl			;733a
	call vram_escribe_en		;733b   ; vram_escribe_en: SETWRT (o NSTWRT en MSX2) en HL
	ex de,hl			;733e
	ld a,(00007h)		;733f   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;7342
L_7343:
	ld a,(hl)			;7343   ; el byte de cuenta
	and 07fh		;7344   ; n & 0x7F: cuantos
	ld b,a			;7346
	ld a,(hl)			;7347   ; el bit 7 dice que hacer
	inc hl			;7348
	jr nz,L_734F		;7349   ; 0x80-0xFF: copiar los n bytes que siguen
	cp b			;734b   ; 0x00 acaba; 0x01-0x7F: repetir
	jr nz,descomprime_con_direccion		;734c   ; (0x80 justo: otra direccion de VRAM)
	ret			;734e
L_734F:
	cp b			;734f
	jr z,L_735D		;7350
L_7352:
	ld a,(hl)			;7352   ; copia: un byte...
	inc hl			;7353
	out (c),a		;7354   ; ...a la VRAM
	inc de			;7356
	push hl			;7357   ; una pausa para el VDP
	pop hl			;7358
	djnz L_7352		;7359   ; los n bytes
	jr L_7343		;735b
L_735D:
	ld a,(hl)			;735d
	inc hl			;735e
L_735F:
	out (c),a		;735f   ; repite: el mismo byte n veces
	inc de			;7361
	push ix		;7362   ; una pausa para el VDP
	pop ix		;7364
	djnz L_735F		;7366
	jr L_7343		;7368
vram_escribe_en:		; SETWRT (o NSTWRT en MSX2) en HL
	push af			;736a
	ld a,(0002dh)		;736b   ; la version del MSX (0 = MSX1)
	and a			;736e
	jr nz,L_7376		;736f
	call 00053h		;7371   ; BIOS SETWRT - Enables VDP to write
	pop af			;7374
	ret			;7375
L_7376:
	call 00171h		;7376   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address)
	pop af			;7379
	ret			;737a
despacha:		; salta a la palabra A de la tabla pegada detras del `call`
	pop hl			;737b   ; la direccion de la tabla, que va pegada al `call`
	add a,a			;737c   ; A x 2: cada destino es una palabra
	add a,l			;737d
	ld l,a			;737e
	jr nc,L_7382		;737f
	inc h			;7381
L_7382:
	ld e,(hl)			;7382
	inc hl			;7383
	ld d,(hl)			;7384
	ex de,hl			;7385
	jp (hl)			;7386
L_7387:
	ld c,000h		;7387
	jr L_7391		;7389
pinta_texto_en:		; pinta el texto de HL en la VRAM DE
	ld c,0ffh		;738b
	jr L_7395		;738d
pinta_texto:		; pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld c,0ffh		;738f
L_7391:
	ld e,(hl)			;7391
	inc hl			;7392
	ld d,(hl)			;7393
	inc hl			;7394
L_7395:
	call modo_de_texto		;7395   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	jr z,pinta_texto_grafico		;7398
	ld a,(hl)			;739a   ; la letra
	inc hl			;739b
	ld b,a			;739c
	inc b			;739d   ; 0xFF acaba
	ret z			;739e
	inc b			;739f   ; 0xFE: otra direccion de VRAM
	jr z,L_7391		;73a0
	and c			;73a2   ; con la mascara C
	ex de,hl			;73a3
	call 0004dh		;73a4   ; BIOS WRTVRM - Writes data in VRAM | a la VRAM
	ex de,hl			;73a7
	inc de			;73a8   ; la columna siguiente
	jr L_7395		;73a9
pinta_texto_grafico:		; pinta el texto en modo grafico
	call letra_grafica		;73ab   ; letra_grafica: pinta una letra en modo grafico
	ld a,(0f122h)		;73ae   ; lee la pagina activa guardada
	ld (0faf6h),a		;73b1   ; guarda ACPAGE, la pagina activa
	ret			;73b4
modo_de_texto:		; Z si la pantalla es de texto (0xFCAF < 5)
	push hl			;73b5
	push de			;73b6
	push af			;73b7
	ld a,(0fcafh)		;73b8   ; lee SCRMOD, el modo de pantalla
	sub 005h		;73bb
	jr c,L_73CB		;73bd
	ld a,(0faf6h)		;73bf   ; lee ACPAGE, la pagina activa
	ld (0f122h),a		;73c2   ; guarda la pagina activa guardada
	ld a,(0faf5h)		;73c5   ; lee DPPAGE, la pagina que se ve
	ld (0faf6h),a		;73c8   ; guarda ACPAGE, la pagina activa
L_73CB:
	ld a,(0f3dfh)		;73cb   ; lee los registros del VDP (copia de la BIOS)
	and 00eh		;73ce
	ld l,a			;73d0
	ld a,(0f3e0h)		;73d1   ; lee el registro 1 del VDP (copia de la BIOS)
	and 018h		;73d4
	ld h,a			;73d6
	pop af			;73d7
	ld de,00006h		;73d8
	and a			;73db
	sbc hl,de		;73dc
	pop de			;73de
	pop hl			;73df
	ret			;73e0
rellena_ventana:		; rellena una ventana de B filas por C columnas con A
	call modo_de_texto		;73e1   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	jr z,L_73F6		;73e4
L_73E6:
	push bc			;73e6
	ld b,000h		;73e7
	push af			;73e9
	call 00056h		;73ea   ; BIOS FILVRM - Fills VRAM with value
	pop af			;73ed
	ld bc,00020h		;73ee
	add hl,bc			;73f1
	pop bc			;73f2
	djnz L_73E6		;73f3
	ret			;73f5
L_73F6:
	push af			;73f6
	push bc			;73f7
	push hl			;73f8
	exx			;73f9
	ld a,(00006h)		;73fa   ; el puerto de lectura del VDP (VDP.DR)
	ld c,a			;73fd
	exx			;73fe
	ld a,(0fff6h)		;73ff   ; lee el registro 14 del VDP (copia de la BIOS)
	ld l,000h		;7402
	ld h,a			;7404
	srl h		;7405
	rr l		;7407
	ld a,(0f3e1h)		;7409   ; lee el registro 2 del VDP (copia de la BIOS)
	and 040h		;740c
	jr z,L_7412		;740e
	set 7,h		;7410
L_7412:
	ld (0f2d1h),hl		;7412   ; guarda la pagina de VRAM
	pop hl			;7415   ; la posicion en la tabla de nombres (0x3800 + ...)
	ld de,0c800h		;7416   ; +0xC800: queda en 0x0000 (fila y columna)
	add hl,de			;7419
	ld a,l			;741a   ; la columna x 4: el pixel en SCREEN 5/7 (4 bits, 2 por byte)
	and 01fh		;741b
	add a,a			;741d
	add a,a			;741e
	ld c,a			;741f
	ld b,000h		;7420
	ld a,l			;7422   ; la fila de 8 en 8...
	and 0e0h		;7423
	ld l,a			;7425
	add hl,hl			;7426   ; ...x 32: 128 bytes por linea x 8 lineas
	add hl,hl			;7427
	add hl,hl			;7428
	add hl,hl			;7429
	add hl,hl			;742a
	add hl,bc			;742b   ; mas la columna
	ld de,(0f2d1h)		;742c   ; mas la pagina
	ld a,h			;7430   ; si cruza la mitad de 32 KB...
	add hl,de			;7431
	xor h			;7432
	and 080h		;7433
	call nz,hl_otra_mitad		;7435   ; ...cambia de mitad (NSTWRT solo ve 16 bits)
	pop bc			;7438
	ld a,c			;7439   ; el ancho x 4
	add a,a			;743a
	add a,a			;743b
	ld c,a			;743c
	ld a,b			;743d   ; el alto x 8
	add a,a			;743e
	add a,a			;743f
	add a,a			;7440
	ld b,a			;7441
	pop af			;7442
L_7443:
	push bc			;7443
	push af			;7444
	call vram_escribe_en		;7445   ; vram_escribe_en: SETWRT (o NSTWRT en MSX2) en HL
	pop af			;7448
L_7449:
	exx			;7449   ; un byte de color...
	out (c),a		;744a   ; ...al VDP
	exx			;744c
	dec c			;744d   ; C bytes por linea
	jr nz,L_7449		;744e
	pop bc			;7450
	ex af,af'			;7451
	ld a,h			;7452   ; la linea siguiente (128 bytes)
	ld de,00080h		;7453
	add hl,de			;7456
	xor h			;7457   ; si cruza la mitad de 32 KB...
	and 080h		;7458
	call nz,hl_otra_mitad		;745a   ; hl_otra_mitad: H xor 0x80
	ex af,af'			;745d
	djnz L_7443		;745e   ; las B lineas
	ld a,(0f122h)		;7460   ; devuelve la pagina activa
	ld (0faf6h),a		;7463   ; guarda ACPAGE, la pagina activa
	ret			;7466
hl_otra_mitad:		; H xor 0x80
	ld a,h			;7467
	xor 080h		;7468
	ld h,a			;746a
	ret			;746b
binario_a_bcd:		; HL a BCD en DE
	ld b,010h		;746c
	ld de,00000h		;746e
L_7471:
	add hl,hl			;7471   ; HL a BCD bit a bit: el bit alto de HL...
	ld a,e			;7472   ; ...entra en E doblandolo...
	adc a,a			;7473
	daa			;7474   ; ...en decimal...
	ld e,a			;7475
	ld a,d			;7476   ; ...y en D
	adc a,a			;7477
	daa			;7478
	ld d,a			;7479
	djnz L_7471		;747a   ; los B bits
	ret			;747c
bcd_a_binario:		; A en BCD a binario
	ld c,a			;747d   ; guarda A
	and 0f0h		;747e   ; la cifra alta...
	rrca			;7480
	rrca			;7481
	rrca			;7482
	rrca			;7483
	add a,a			;7484   ; ...por 10 (x2, x8 y suma)
	ld b,a			;7485
	add a,a			;7486
	add a,a			;7487
	add a,b			;7488
	ld b,a			;7489
	ld a,c			;748a   ; la cifra baja
	and 00fh		;748b
	add a,b			;748d   ; mas las decenas
	ret			;748e
borra_ventana:		; borra la ventana de 0x9237
	ld bc,00613h		;748f
	ld hl,(09237h)		;7492   ; lee la esquina de la ventana pequena y el byte siguiente (16 bits)
	xor a			;7495
	jp rellena_ventana		;7496   ; rellena_ventana: rellena una ventana de B filas por C columnas con A
p02_8000_si:		; si 0xF112: p02:8000 con el cartucho en la pagina 2
	ld a,(0f112h)		;7499   ; lee hay menu en pantalla
	or a			;749c
	ret z			;749d
p02_8000:		; p02:8000 con el cartucho en la pagina 2 y vuelta a la RAM
	call cartucho_en_8000		;749e   ; cartucho_en_8000: pone el cartucho (0xF103) en la pagina 2
	ld a,002h		;74a1
	ld (08000h),a		;74a3   ; el mapper: pone en 0x8000 el banco de A
	call 08000h		;74a6   ; guarda_pantalla: guarda la pantalla del juego antes del menu (segun el modo de 0xF3DF/0xF3E0)
L_74A9:
	push af			;74a9
	push hl			;74aa
	push de			;74ab
	push bc			;74ac
	ld a,(0f2a0h)		;74ad   ; lee el slot de la RAM de la pagina 2
	ld h,080h		;74b0
	call 00024h		;74b2   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop bc			;74b5
	pop de			;74b6
	pop hl			;74b7
	pop af			;74b8
	ret			;74b9
p02_80e4_si:		; si 0xF112: p02:80E4
	ld a,(0f112h)		;74ba   ; lee hay menu en pantalla
	or a			;74bd
	ret z			;74be
p02_80e4:		; p02:80E4 con el cartucho en la pagina 2 y vuelta a la RAM
	call cartucho_en_8000		;74bf   ; cartucho_en_8000: pone el cartucho (0xF103) en la pagina 2
	ld a,002h		;74c2
	ld (08000h),a		;74c4   ; el mapper: pone en 0x8000 el banco de A
	call 080e4h		;74c7
	jr L_74A9		;74ca
L_74CC:
	ld a,(09236h)		;74cc
	cp 03ah		;74cf
	ld hl,03900h		;74d1
	jr c,L_74D9		;74d4
borra_segun_modo:		; borra la pantalla segun el modo
	ld hl,03a00h		;74d6
L_74D9:
	push hl			;74d9
	ld a,(0f3dfh)		;74da   ; lee los registros del VDP (copia de la BIOS)
	and 00eh		;74dd
	ld l,a			;74df
	ld a,(0f3e0h)		;74e0   ; lee el registro 1 del VDP (copia de la BIOS)
	and 018h		;74e3
	ld h,a			;74e5
	ld de,00006h		;74e6
	rst 20h			;74e9   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	pop hl			;74ea
	jr z,L_74F4		;74eb
	ld bc,00100h		;74ed
	xor a			;74f0
	jp 00056h		;74f1   ; BIOS FILVRM - Fills VRAM with value
L_74F4:
	call cartucho_en_8000		;74f4   ; cartucho_en_8000: pone el cartucho (0xF103) en la pagina 2
	call 08080h		;74f7
	jp L_74A9		;74fa
cartucho_en_8000:		; pone el cartucho (0xF103) en la pagina 2
	push hl			;74fd
	push de			;74fe
	push bc			;74ff
	push af			;7500
	ld a,(0f103h)		;7501   ; lee el slot del Game Master
	ld h,080h		;7504
	call 00024h		;7506   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop af			;7509
	pop bc			;750a
	pop de			;750b
	pop hl			;750c
	ret			;750d
menu:		; menu de B opciones con el cursor A: devuelve la elegida
	ld (09230h),a		;750e   ; guarda el menu es de cursor (0) o de letras
	or a			;7511
	ld a,b			;7512
	jr nz,L_7517		;7513
	ld a,008h		;7515
L_7517:
	ld (0922dh),a		;7517   ; guarda la ultima opcion del menu
	ld (09231h),hl		;751a   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld (09233h),hl		;751d   ; guarda la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	call cursor_pinta		;7520   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
	call borra_teclado		;7523   ; borra_teclado: borra el bufer de teclas del menu (0x920B)
L_7526:
	call 0009fh		;7526   ; BIOS CHGET - One character input (waiting)
	cp 00dh		;7529
	ld b,a			;752b
	jr nz,L_7536		;752c
	ld a,(0922eh)		;752e   ; lee la opcion elegida
	ld (0922ch),a		;7531   ; guarda cuantas letras lleva el nombre
	or a			;7534
	ret			;7535
L_7536:
	cp 01dh		;7536
	jr z,L_753E		;7538
	cp 008h		;753a
	jr nz,L_7563		;753c
L_753E:
	call opcion_cero		;753e   ; opcion_cero: si no hay opcion elegida, vuelve al menu
	ld a,(0922eh)		;7541   ; lee la opcion elegida
	ld hl,0920ah		;7544
	call hl_mas_a		;7547   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;754a
	sub 03ch		;754b
	jr nz,L_7552		;754d
	ld (0922fh),a		;754f
L_7552:
	ld hl,0922eh		;7552   ; apunta a la opcion elegida
	dec (hl)			;7555
	call cursor_borra		;7556   ; cursor_borra: borra el cursor
	dec hl			;7559
	ld (09231h),hl		;755a   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	call cursor_pinta		;755d   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
	jp L_7526		;7560
L_7563:
	cp 02eh		;7563   ; '.': la tecla del punto
	jr nz,L_757E		;7565
	ld a,(09230h)		;7567   ; solo en el menu de letras (0xFE)
	cp 0feh		;756a
	jp nz,L_7526		;756c
	call opcion_cero		;756f   ; opcion_cero: si no hay opcion elegida, vuelve al menu
	ld a,03ch		;7572   ; '<', el punto en la fuente del menu
	ld hl,0922fh		;7574
	cp (hl)			;7577   ; si ya esta, nada
	jp z,L_7526		;7578
	ld (hl),a			;757b
	jr L_75A8		;757c
L_757E:
	ld c,a			;757e   ; ¿es una cifra?
	sub 030h		;757f
	cp 00ah		;7581
	jr nc,L_7588		;7583
	ld a,c			;7585   ; si: tal cual
	jr L_75A8		;7586
L_7588:
	ld a,c			;7588
	sub 041h		;7589
	cp 01ah		;758b
	jr nc,L_759B		;758d
	ld a,c			;758f
L_7590:
	ex af,af'			;7590   ; guarda la tecla
	ld a,(09230h)		;7591   ; lee el menu es de cursor (0) o de letras
	inc a			;7594
	jp z,L_7526		;7595
	ex af,af'			;7598
	jr L_75A8		;7599
L_759B:
	ld a,c			;759b   ; ¿es una minuscula (a-z)?
	sub 061h		;759c
	cp 01ah		;759e
	jp nc,L_7526		;75a0   ; no: no vale
	ld a,c			;75a3   ; a mayuscula
	sub 020h		;75a4
	jr L_7590		;75a6
L_75A8:
	ld b,a			;75a8
	ld hl,0922eh		;75a9   ; apunta a la opcion elegida
	ld a,(0922dh)		;75ac   ; lee la ultima opcion del menu
	cp (hl)			;75af
	jp z,L_7526		;75b0
	inc (hl)			;75b3
	ld a,(hl)			;75b4
	cp 001h		;75b5
	jr nz,L_75C7		;75b7
	push bc			;75b9
	ld hl,(09233h)		;75ba   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	ld b,00eh		;75bd
	xor a			;75bf
L_75C0:
	call pon_letra		;75c0   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;75c3
	djnz L_75C0		;75c4
	pop bc			;75c6
L_75C7:
	ld hl,(09231h)		;75c7   ; lee la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld a,b			;75ca
	call pon_letra		;75cb   ; pon_letra: escribe A en la VRAM HL guardando los registros
	inc hl			;75ce
	ld (09231h),hl		;75cf   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	call cursor_pinta		;75d2   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
	ld a,(0922eh)		;75d5   ; lee la opcion elegida
	ld hl,0920ah		;75d8
	call hl_mas_a		;75db   ; hl_mas_a: HL = HL + A
	ld (hl),b			;75de
	jp L_7526		;75df
borra_teclado:		; borra el bufer de teclas del menu (0x920B)
	ld hl,0920bh		;75e2   ; apunta a el bufer de teclas
	ld de,0920ch		;75e5
	ld (hl),000h		;75e8
	ld bc,0001fh		;75ea
	ldir		;75ed
	call cursor_apaga		;75ef   ; cursor_apaga: quita el cursor
	call 00156h		;75f2   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;75f5
	ld (0922ch),a		;75f6   ; guarda cuantas letras lleva el nombre
	ld (0922eh),a		;75f9   ; guarda la opcion elegida
	ld (0922fh),a		;75fc
	ret			;75ff
cursor_apaga:		; quita el cursor
	call modo_de_texto		;7600   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	ld a,(0f122h)		;7603   ; lee la pagina activa guardada
	ld (0faf6h),a		;7606   ; guarda ACPAGE, la pagina activa
	ret z			;7609
cursor_apaga_b:		; quita el cursor (gemela de p03:A74F)
	ld hl,0762bh		;760a
	ld bc,00008h		;760d
	ld a,(0f112h)		;7610   ; lee hay menu en pantalla
	or a			;7613
	jr nz,L_7625		;7614
	ld a,(0f2e6h)		;7616   ; lee el menu va en MSX2
	and a			;7619
	ld de,021d0h		;761a
	jr z,L_7622		;761d
	ld de,02080h		;761f
L_7622:
	jp copia_tercios		;7622   ; copia_tercios: LDIRVM en los tres tercios de la pantalla
L_7625:
	ld de,031d0h		;7625
	jp 0005ch		;7628   ; BIOS LDIRVM - Block transfers to VRAM from memory

; ----------------------------------------------------------------------
; DATOS resto_762B: lo apuntan con el banco puesto p01:760A (0x762B); el
;   tamano es lo que hay hasta lo siguiente, no sale de recorrerlo; lo leen
;   p01:760A (8 bytes)
;   0x762b..0x7633  (8 bytes)
DATA_resto_762B:
	defb 000h,010h,018h,0fch,0feh,0fch,018h,010h	; 762b  ........

; ======================================================================
; CODIGO 0x7633..0x79cf  (924 bytes)
; ======================================================================


cursor_pinta:		; pinta el cursor (':' o el de MSX2)
	ld hl,(09231h)		;7633   ; lee la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	ld a,(0f2e6h)		;7636   ; lee el menu va en MSX2
	and a			;7639
	ld a,03ah		;763a
	jr z,L_7640		;763c
	ld a,010h		;763e
L_7640:
	jr pon_letra		;7640
cursor_borra:		; borra el cursor
	ld hl,(09231h)		;7642   ; lee la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	xor a			;7645
pon_letra:		; escribe A en la VRAM HL guardando los registros
	push af			;7646
	push bc			;7647
	push hl			;7648
	push de			;7649
	call pon_letra_b		;764a   ; pon_letra_b: escribe A en la VRAM HL (WRTVRM o en modo grafico)
	pop de			;764d
	pop hl			;764e
	pop bc			;764f
	pop af			;7650
	ret			;7651
pon_letra_b:		; escribe A en la VRAM HL (WRTVRM o en modo grafico)
	ex af,af'			;7652
	call modo_de_texto		;7653   ; modo_de_texto: Z si la pantalla es de texto (0xFCAF < 5)
	jr z,L_765C		;7656
	ex af,af'			;7658
	jp 0004dh		;7659   ; BIOS WRTVRM - Writes data in VRAM
L_765C:
	ex af,af'			;765c
	ex de,hl			;765d
	call cartucho_en_8000		;765e   ; cartucho_en_8000: pone el cartucho (0xF103) en la pagina 2
	call letra_grafica_b		;7661   ; letra_grafica_b: posicion y letra en modo grafico
	ld a,(0f122h)		;7664   ; lee la pagina activa guardada
	ld (0faf6h),a		;7667   ; guarda ACPAGE, la pagina activa
	jp L_74A9		;766a
opcion_cero:		; si no hay opcion elegida, vuelve al menu
	ld a,(0922eh)		;766d   ; lee la opcion elegida
	or a			;7670
	ret nz			;7671
	pop hl			;7672
	jp L_7526		;7673
menu_con_esc:		; menu: espacio elige, ESC sale
	call menu_prepara		;7676   ; menu_prepara: prepara el menu: opciones, posicion y cursor
	call menu_limpia		;7679   ; menu_limpia: quita el cursor y borra el teclado
L_767C:
	call 0009fh		;767c   ; BIOS CHGET - One character input (waiting)
	cp 020h		;767f
	jr z,L_769E		;7681
	cp 01bh		;7683
	jr z,L_768D		;7685
	ld b,a			;7687
	call menu_cursor		;7688   ; menu_cursor: mueve el cursor con las flechas (0x1E arriba, 0x1F abajo)
	jr L_767C		;768b
L_768D:
	or 0ffh		;768d
	ret			;768f
menu_vertical:		; menu de B opciones: cursores arriba y abajo, espacio elige
	call menu_prepara		;7690   ; menu_prepara: prepara el menu: opciones, posicion y cursor
	call menu_limpia		;7693   ; menu_limpia: quita el cursor y borra el teclado
L_7696:
	call 0009fh		;7696   ; BIOS CHGET - One character input (waiting)
	cp 020h		;7699
	ld b,a			;769b
	jr nz,L_76A9		;769c
L_769E:
	call cursor_borra		;769e   ; cursor_borra: borra el cursor
	ld a,(0922eh)		;76a1   ; lee la opcion elegida
	ld (0922ch),a		;76a4   ; guarda cuantas letras lleva el nombre
	or a			;76a7
	ret			;76a8
L_76A9:
	call menu_cursor		;76a9   ; menu_cursor: mueve el cursor con las flechas (0x1E arriba, 0x1F abajo)
	jp L_7696		;76ac
menu_prepara:		; prepara el menu: opciones, posicion y cursor
	ld a,b			;76af
	dec a			;76b0
	ld (0922dh),a		;76b1   ; guarda la ultima opcion del menu
	ld (09233h),hl		;76b4   ; guarda la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	ld a,(hl)			;76b7
	inc hl			;76b8
	ld h,(hl)			;76b9
	ld l,a			;76ba
	ld (09231h),hl		;76bb   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	jp cursor_pinta		;76be   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
menu_cursor:		; mueve el cursor con las flechas (0x1E arriba, 0x1F abajo)
	ld c,0ffh		;76c1   ; C = -1: arriba
	cp 01eh		;76c3   ; 0x1E es la flecha arriba
	jr z,L_76CC		;76c5
	ld c,001h		;76c7   ; C = +1: abajo
	cp 01fh		;76c9   ; 0x1F es la flecha abajo
	ret nz			;76cb   ; otra tecla: nada
L_76CC:
	ld hl,0922dh		;76cc   ; apunta a la ultima opcion del menu
	ld de,0922eh		;76cf   ; apunta a la opcion elegida
	ld a,(de)			;76d2
	add a,c			;76d3
	jp p,L_76D8		;76d4
	ld a,(hl)			;76d7
L_76D8:
	cp (hl)			;76d8
	jr c,L_76DE		;76d9
	jr z,L_76DE		;76db
	xor a			;76dd
L_76DE:
	ld (de),a			;76de
	ld b,a			;76df
	ld hl,(09233h)		;76e0   ; lee la posicion de la primera opcion en la VRAM y el byte siguiente (16 bits)
	add a,a			;76e3
	call hl_mas_a		;76e4   ; hl_mas_a: HL = HL + A
	ld a,(hl)			;76e7
	inc hl			;76e8
	ld h,(hl)			;76e9
	ld l,a			;76ea
	push hl			;76eb
	call cursor_borra		;76ec   ; cursor_borra: borra el cursor
	pop hl			;76ef
	ld (09231h),hl		;76f0   ; guarda la posicion del cursor en la VRAM y el byte siguiente (16 bits)
	jp cursor_pinta		;76f3   ; cursor_pinta: pinta el cursor (':' o el de MSX2)
menu_limpia:		; quita el cursor y borra el teclado
	call cursor_apaga		;76f6   ; cursor_apaga: quita el cursor
	call 00156h		;76f9   ; BIOS KILBUF - Clears keyboard buffer
	xor a			;76fc
	ld (0922ch),a		;76fd   ; guarda cuantas letras lleva el nombre
	ld (0922eh),a		;7700   ; guarda la opcion elegida
	ld (0922fh),a		;7703
	ret			;7706
comprime:		; comprime 0x8802 en 0x8002 (lo contrario de p01:733A)
	ld hl,08802h		;7707
	ld de,08002h		;770a
L_770D:
	ld a,081h		;770d   ; 0x81: empieza un trozo de copias (bit 7 a 1, uno)
	ld (0dd93h),a		;770f
	ld c,(hl)			;7712   ; el byte
	ld (0dd94h),de		;7713   ; donde va la cuenta de este trozo
	inc de			;7717
	ld a,c			;7718
	ld (de),a			;7719   ; lo copia
	inc hl			;771a
	inc de			;771b
	call fin_de_8882		;771c   ; ¿se acabo la pantalla?
	jp z,L_77AF		;771f
	ld a,c			;7722   ; ¿el siguiente es igual?
	cp (hl)			;7723
	jr z,L_7763		;7724   ; si: empieza una repeticion
	ld a,001h		;7726   ; no: un trozo de copias que lleva 1
	ld (0dd93h),a		;7728
L_772B:
	ld c,(hl)			;772b   ; el byte
	inc hl			;772c
	ld a,c			;772d   ; se copia
	ld (de),a			;772e
	inc de			;772f
	call fin_de_8882		;7730   ; ¿se acabo la pantalla?
	jp z,L_77A6		;7733
	cp (hl)			;7736   ; ¿el siguiente es igual?
	jr nz,L_7756		;7737   ; no: copias
	inc hl			;7739   ; ¿y el otro?
	call fin_de_8882		;773a   ; fin_de_8882: compara HL con 0x8882
	jr z,L_779B		;773d
	cp (hl)			;773f   ; tres iguales: repeticion
	dec hl			;7740
	jr nz,L_7756		;7741
L_7743:
	dec hl			;7743   ; retrocede un byte
	dec de			;7744
	push hl			;7745
	ld hl,(0dd94h)		;7746   ; cierra el trozo: su cuenta...
	ld a,(0dd93h)		;7749
	set 7,a		;774c   ; ...con el bit 7 (copias)
	ld (hl),a			;774e
	pop hl			;774f
	ld (0dd94h),de		;7750   ; el trozo siguiente empieza aqui
	jr L_770D		;7754
L_7756:
	ld a,(0dd93h)		;7756   ; la cuenta de la repeticion
	cp 07bh		;7759   ; con tope 0x7B
	jr z,L_7743		;775b
	inc a			;775d   ; una mas
	ld (0dd93h),a		;775e
	jr L_772B		;7761
L_7763:
	ld a,002h		;7763
	ld (0dd93h),a		;7765
L_7768:
	inc hl			;7768
	call fin_de_8882		;7769   ; fin_de_8882: compara HL con 0x8882
	jr z,L_77AF		;776c
	ld a,c			;776e
	cp (hl)			;776f
	jr z,L_7783		;7770
L_7772:
	ld de,(0dd94h)		;7772   ; cierra la repeticion: su cuenta...
	ld a,(0dd93h)		;7776
	ld (de),a			;7779   ; ...delante del byte
	inc de			;777a   ; el trozo siguiente
	inc de			;777b
	ld (0dd94h),de		;777c
	jp L_770D		;7780
L_7783:
	ld a,(0dd93h)		;7783   ; la cuenta de las copias
	cp 07bh		;7786   ; con tope 0x7B
	jr z,L_7772		;7788
	inc a			;778a   ; una mas
	ld (0dd93h),a		;778b
	jr L_7768		;778e
fin_de_8882:		; compara HL con 0x8882
	push hl			;7790
	push de			;7791
	ld de,08882h		;7792   ; el final del bloque que se comprime
	and a			;7795
	sbc hl,de		;7796   ; Z si HL ha llegado
	pop de			;7798
	pop hl			;7799
	ret			;779a
L_779B:
	dec hl			;779b   ; el byte...
	ld a,(hl)			;779c
	ld (de),a			;779d   ; ...se copia
	inc de			;779e
	ld a,(0dd93h)		;779f   ; una copia mas
	inc a			;77a2
	ld (0dd93h),a		;77a3
L_77A6:
	ld a,(0dd93h)		;77a6
	inc a			;77a9
	set 7,a		;77aa
	ld (0dd93h),a		;77ac
L_77AF:
	xor a			;77af   ; el 0 que acaba...
	ld (de),a			;77b0
	ld a,(0dd93h)		;77b1   ; ...y la cuenta del ultimo trozo
	ld hl,(0dd94h)		;77b4
	ld (hl),a			;77b7
	ex de,hl			;77b8   ; el tamano comprimido...
	ld de,08001h		;77b9
	and a			;77bc
	sbc hl,de		;77bd
	ld (08000h),hl		;77bf   ; ...va en 0x8000
	ret			;77c2
L_77C3:
	ld a,(0f2a0h)		;77c3   ; la RAM en la pagina 2
	ld h,080h		;77c6
	call 00024h		;77c8   ; BIOS ENASLT - Switches to specified slot and page definitively
	ld de,08000h		;77cb   ; guarda en 0x8000 los patrones de 0x1000 (0x80 bytes de cada tercio)
	ld hl,01000h		;77ce
	ld bc,00080h		;77d1
	call lee_vram_tercios		;77d4   ; lee_vram_tercios: LDIRMV de los tres tercios (0x2000 de paso)
	ld de,08100h		;77d7   ; los de 0x1180 (0x158 bytes)
	ld hl,01180h		;77da
	ld bc,00158h		;77dd
	call lee_vram_tercios		;77e0   ; lee_vram_tercios: LDIRMV de los tres tercios (0x2000 de paso)
	ld de,083b0h		;77e3   ; los de 0x1400 (0x40 bytes)
	ld hl,01400h		;77e6
	ld bc,00040h		;77e9
	call lee_vram_tercios		;77ec   ; lee_vram_tercios: LDIRMV de los tres tercios (0x2000 de paso)
	ld hl,03a00h		;77ef   ; la tabla de nombres de 0x3A00 (0x300 bytes)
	ld de,08430h		;77f2
	ld bc,00300h		;77f5
	call 00059h		;77f8   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,03b00h		;77fb   ; y el primer byte de los sprites
	ld de,08730h		;77fe
	ld bc,00001h		;7801
	call 00059h		;7804   ; BIOS LDIRMV - Block transfers to memory from VRAM
	ld hl,01000h		;7807   ; la casilla 0x200 a 0x55
	ld bc,00008h		;780a
	ld a,055h		;780d
	call 00056h		;780f   ; BIOS FILVRM - Fills VRAM with value
	call borra_por_modo		;7812   ; borra la pantalla segun el modo
	ld hl,0483fh		;7815   ; la fuente del Game Master (p00:483F) a 0x3180
	ld de,03180h		;7818
	ld bc,00158h		;781b
	call 0005ch		;781e   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,01180h		;7821   ; y su color 0xF5
	ld a,0f5h		;7824
	ld bc,00158h		;7826
	call 00056h		;7829   ; BIOS FILVRM - Fills VRAM with value
	ld hl,03b00h		;782c   ; sin sprites (0xD0)
	ld a,0d0h		;782f
	jp 0004dh		;7831   ; BIOS WRTVRM - Writes data in VRAM
lee_vram_tercios:		; LDIRMV de los tres tercios (0x2000 de paso)
	push bc			;7834
	push de			;7835
	push hl			;7836
	call 00059h		;7837   ; BIOS LDIRMV - Block transfers to memory from VRAM
	pop hl			;783a
	ld bc,02000h		;783b
	add hl,bc			;783e
	pop de			;783f
	pop bc			;7840
	ex de,hl			;7841
	add hl,bc			;7842
	ex de,hl			;7843
	jp 00059h		;7844   ; BIOS LDIRMV - Block transfers to memory from VRAM
L_7847:
	ld a,(0f2a0h)		;7847   ; la RAM en la pagina 2
	ld h,080h		;784a
	call 00024h		;784c   ; BIOS ENASLT - Switches to specified slot and page definitively
	call borra_por_modo		;784f   ; borra la pantalla
	ld hl,08000h		;7852   ; devuelve los patrones de 0x1000 (de 0x8000)
	ld de,01000h		;7855
	ld bc,00080h		;7858
	call copia_vram_tercios		;785b   ; copia_vram_tercios: LDIRVM de los tres tercios (0x2000 de paso)
	ld hl,08100h		;785e   ; los de 0x1180
	ld de,01180h		;7861
	ld bc,00158h		;7864
	call copia_vram_tercios		;7867   ; copia_vram_tercios: LDIRVM de los tres tercios (0x2000 de paso)
	ld hl,083b0h		;786a   ; los de 0x1400
	ld de,01400h		;786d
	ld bc,00040h		;7870
	call copia_vram_tercios		;7873   ; copia_vram_tercios: LDIRVM de los tres tercios (0x2000 de paso)
	ld hl,08430h		;7876   ; la tabla de nombres de 0x3A00
	ld de,03a00h		;7879
	ld bc,00300h		;787c
	call 0005ch		;787f   ; BIOS LDIRVM - Block transfers to VRAM from memory
	ld hl,08730h		;7882   ; y el primer byte de los sprites
	ld de,03b00h		;7885
	ld bc,00001h		;7888
	jp 0005ch		;788b   ; BIOS LDIRVM - Block transfers to VRAM from memory
copia_vram_tercios:		; LDIRVM de los tres tercios (0x2000 de paso)
	push bc			;788e
	push hl			;788f
	push de			;7890
	call 0005ch		;7891   ; BIOS LDIRVM - Block transfers to VRAM from memory
	pop hl			;7894
	ld bc,02000h		;7895
	add hl,bc			;7898
	pop de			;7899
	pop bc			;789a
	ex de,hl			;789b
	add hl,bc			;789c
	jp 0005ch		;789d   ; BIOS LDIRVM - Block transfers to VRAM from memory
borra_por_modo:		; borra la pantalla segun el modo de 0xF2A1
	ld hl,(0f2a1h)		;78a0   ; lee el modo de pantalla guardado y el byte siguiente (16 bits)
	ld de,00002h		;78a3
	rst 20h			;78a6   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,borra_segun_modo		;78a7   ; borra_segun_modo: borra la pantalla segun el modo
	ld de,00004h		;78aa
	rst 20h			;78ad   ; DCOMPR: compara HL con DE (Z si son iguales, C si HL es menor)
	jp z,borra_segun_modo		;78ae   ; borra_segun_modo: borra la pantalla segun el modo
	jp borra_nombres		;78b1   ; borra_nombres: borra la tabla de nombres y esconde los sprites (0xD0 en 0x3B00)
L_78B4:
	ld c,0ffh		;78b4
	ld e,(hl)			;78b6
	inc hl			;78b7
	ld d,(hl)			;78b8
	inc hl			;78b9
letra_grafica:		; pinta una letra en modo grafico
	call posicion_grafica		;78ba   ; posicion_grafica: la posicion en modo grafico de la letra
L_78BD:
	ld a,(hl)			;78bd   ; la letra
	and c			;78be   ; con la mascara C
	inc hl			;78bf
	ld b,a			;78c0
	inc b			;78c1   ; 0xFF acaba
	ret z			;78c2
	inc b			;78c3   ; 0xFE: otra posicion
	jr z,L_78B4		;78c4
	and c			;78c6
	call dibuja_letra		;78c7   ; la dibuja
	inc de			;78ca   ; cuatro bytes a la derecha: 8 pixeles en SCREEN 5
	inc de			;78cb
	inc de			;78cc
	inc de			;78cd
	jr L_78BD		;78ce
posicion_grafica:		; la posicion en modo grafico de la letra
	push af			;78d0
	push hl			;78d1
	ld hl,0c800h		;78d2   ; la posicion en la tabla de nombres (0x3800 + ...)
	add hl,de			;78d5   ; +0xC800: queda en 0x0000 (fila y columna)
	ld a,l			;78d6   ; la columna x 4...
	and 01fh		;78d7
	add a,a			;78d9
	add a,a			;78da
	ld (0f2b1h),a		;78db   ; ...en 0xF2B1
	ld a,l			;78de   ; la fila de 8 en 8...
	and 0e0h		;78df
	ld l,a			;78e1
	add hl,hl			;78e2   ; ...x 32
	add hl,hl			;78e3
	add hl,hl			;78e4
	add hl,hl			;78e5
	add hl,hl			;78e6
	ld a,(0f2b1h)		;78e7   ; mas la columna
	ld e,a			;78ea
	ld d,000h		;78eb
	add hl,de			;78ed
	ld a,(0f3e1h)		;78ee   ; R#2 bit 5: la pagina 1...
	and 020h		;78f1
	jr z,L_78F7		;78f3
	set 7,h		;78f5   ; ...en la mitad alta de la VRAM
L_78F7:
	ld a,(0fff6h)		;78f7   ; la direccion a la VRAM
	ld e,000h		;78fa
	ld d,a			;78fc
	srl d		;78fd
	rr e		;78ff
	ld a,h			;7901
	add hl,de			;7902
	xor h			;7903
	and 080h		;7904
	ex de,hl			;7906
	call nz,de_otra_mitad		;7907   ; de_otra_mitad: D xor 0x80
	pop hl			;790a
	pop af			;790b
	ret			;790c
dibuja_letra:		; dibuja la letra A con la fuente de p00:4837
	push hl			;790d
	push bc			;790e
	push de			;790f
	sub 02fh		;7910   ; la fuente empieza en el 0x2F...
	jr nc,L_7915		;7912
	xor a			;7914   ; ...y lo de antes es un espacio
L_7915:
	ld de,04837h		;7915   ; la letra en la fuente del Game Master (p00:4837), 8 bytes cada una
	ld l,a			;7918
	ld h,000h		;7919
	add hl,hl			;791b
	add hl,hl			;791c
	add hl,hl			;791d
	add hl,de			;791e
	ex de,hl			;791f   ; DE = la letra
	ld hl,0f2b1h		;7920   ; la fila de 4 bytes que se monta en 0xF2B1
	ld c,008h		;7923   ; 8 lineas
L_7925:
	ld b,004h		;7925
	ld a,(de)			;7927
	inc de			;7928
L_7929:
	add a,a			;7929
	ld (hl),000h		;792a
	jr nc,L_7930		;792c
	ld (hl),0e0h		;792e
L_7930:
	add a,a			;7930   ; un pixel encendido...
	jr nc,L_7939		;7931
	ex af,af'			;7933
	ld a,(hl)			;7934   ; ...pone el color 0x0E en su mitad del byte
	or 00eh		;7935
	ld (hl),a			;7937
	ex af,af'			;7938
L_7939:
	inc hl			;7939
	djnz L_7929		;793a
	dec c			;793c
	jr nz,L_7925		;793d
	pop de			;793f
	push de			;7940
	ld a,(00007h)		;7941   ; el puerto de escritura del VDP (VDP.DW)
	ld c,a			;7944
	ld hl,0f2b1h		;7945
	ld b,008h		;7948
L_794A:
	push bc			;794a   ; una linea de la letra
	ex de,hl			;794b
	call 00171h		;794c   ; BIOS NSTWRT - Same function as SETWRT (with 16-bit VRAM-address) | la VRAM en DE
	ex de,hl			;794f
	ld b,004h		;7950   ; cuatro bytes (8 pixeles)
	otir		;7952
	ld a,d			;7954   ; guarda la mitad de la VRAM
	push hl			;7955
	ld hl,00080h		;7956   ; la linea siguiente esta 128 bytes mas abajo
	add hl,de			;7959
	ex de,hl			;795a
	pop hl			;795b
	xor d			;795c   ; si cruza la mitad de 32 KB...
	and 080h		;795d
	call nz,de_otra_mitad		;795f   ; ...cambia de mitad
	pop bc			;7962
	djnz L_794A		;7963   ; las 8 lineas
	pop de			;7965
	pop bc			;7966
	pop hl			;7967
	ret			;7968
de_otra_mitad:		; D xor 0x80
	ld a,d			;7969
	xor 080h		;796a
	ld d,a			;796c
	ret			;796d
letra_grafica_b:		; posicion y letra en modo grafico
	call posicion_grafica		;796e   ; posicion_grafica: la posicion en modo grafico de la letra
	jr dibuja_letra		;7971
menu_principal:		; el menu del Game Master: engancha H.TIMI y pinta
	di			;7973   ; sin interrupciones
	ld hl,079f3h		;7974   ; H.TIMI salta a p01:79F6
	ld de,0fd9fh		;7977   ; apunta a el gancho H.TIMI
	ld bc,00003h		;797a
	ldir		;797d
	ld hl,00000h		;797f   ; guarda la pila
	add hl,sp			;7982
	ld (0f000h),hl		;7983   ; guarda la pila del menu principal y el byte siguiente (16 bits)
	ei			;7986   ; abre las interrupciones
	call 0448dh		;7987   ; borra la pantalla
	ld hl,0e000h		;798a   ; borra 0xE000-0xEFFF
	ld de,0e001h		;798d
	ld bc,00fffh		;7990
	ld (hl),000h		;7993
	ldir		;7995
	ld hl,(00004h)		;7997   ; la fuente de la BIOS...
	ld de,02000h		;799a   ; ...a los patrones (0x2000), en los tres tercios
	ld bc,007f0h		;799d
	call copia_tercios		;79a0   ; copia_tercios: LDIRVM en los tres tercios de la pantalla
	ld hl,00000h		;79a3   ; el color 0xF0 en los tres tercios
	ld bc,007f0h		;79a6
	ld a,0f0h		;79a9
	call rellena_tercios		;79ab   ; rellena_tercios: FILVRM en los tres tercios de la pantalla
	ld a,(0f103h)		;79ae   ; el slot del Game Master a 0xE000
	ld (0e000h),a		;79b1
	ld a,001h		;79b4   ; el menu va en MSX2
	ld (0f2e6h),a		;79b6   ; guarda el menu va en MSX2
L_79B9:
	ld hl,04123h		;79b9
	call pinta_texto		;79bc   ; pinta_texto: pinta el texto de HL: [direccion de VRAM] y letras; 0xFE otra direccion, 0xFF acaba
	ld b,004h		;79bf
	ld hl,04175h		;79c1
	call menu_vertical		;79c4   ; menu_vertical: menu de B opciones: cursores arriba y abajo, espacio elige
	push af			;79c7
	call 044adh		;79c8   ; borra_zona_3ac0: borra 0x3AC0 (0x20 bytes) letra a letra
	pop af			;79cb
	call despacha		;79cc   ; despacha: salta a la palabra A de la tabla pegada detras del `call`

; ----------------------------------------------------------------------
; DATOS saltos_79CF: tabla de 4 palabras del despachador (call 0x408D en
;   0x79CC); lo leen el despachador (8 bytes)
;   0x79cf..0x79d7  (8 bytes)
DATA_saltos_79CF:
	defb 0e1h,079h	; 79cf
	defb 0e7h,079h	; 79d1
	defb 0edh,079h	; 79d3
	defb 0d7h,079h	; 79d5

; ======================================================================
; CODIGO 0x79d7..0x7a1a  (67 bytes)
; ======================================================================


L_79D7:
	ld a,0c9h		;79d7
	ld (0fd9fh),a		;79d9   ; guarda el gancho H.TIMI
	xor a			;79dc
	ld (0f2e6h),a		;79dd   ; guarda el menu va en MSX2
	ret			;79e0
L_79E1:
	call 0417dh		;79e1   ; menu_sram: el menu de la SRAM: limpia 0xE010, pinta y lee teclas
	jp L_79B9		;79e4
L_79E7:
	call 04209h		;79e7   ; menu_borrar: pide el nombre de 5 letras a borrar (0xE250) y lo busca
	jp L_79B9		;79ea
L_79ED:
	call 04333h		;79ed   ; pregunta_formatear: pregunta si se formatea (Y/N) y llama a la SRAM
	jp L_79B9		;79f0
L_79F3:
	jp L_79F6		;79f3
L_79F6:
	ld a,006h		;79f6
	call 00141h		;79f8   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	bit 1,a		;79fb
	jp nz,0013eh		;79fd   ; BIOS RDVDP - Reads VDP status register
	ld a,003h		;7a00
	call 00141h		;7a02   ; BIOS SNSMAT - Returns the value of the specified line from the keyboard matrix
	rra			;7a05
	jp c,0013eh		;7a06   ; BIOS RDVDP - Reads VDP status register
	xor a			;7a09
	ld (0f2e6h),a		;7a0a   ; guarda el menu va en MSX2
	ld a,0c9h		;7a0d
	ld (0fd9fh),a		;7a0f   ; guarda el gancho H.TIMI
	call 0013eh		;7a12   ; BIOS RDVDP - Reads VDP status register
	ld hl,(0f000h)		;7a15   ; lee la pila del menu principal y el byte siguiente (16 bits)
	ld sp,hl			;7a18
	ret			;7a19

; ----------------------------------------------------------------------
; DATOS relleno_ff: 1510 bytes a 0xFF hasta el final del banco: relleno; lo
;   leen nadie (1510 bytes)
;   0x7a1a..0x8000  (1510 bytes)
DATA_relleno_ff:
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7a9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aaa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7ada  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7aea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7afa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7b9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7baa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7bfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7c9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7caa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7cfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7d9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7daa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7dfa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7e9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eaa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7eea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7efa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f0a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f1a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f2a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f3a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f4a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f5a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f6a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f7a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f8a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7f9a  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7faa  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fba  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fca  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fda  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7fea  ................
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh	; 7ffa
