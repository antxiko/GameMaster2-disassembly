# Konami's Game Master 2 (Konami, RC-755, 1987, MSX1)
# desensamblado
#
# El orden de las cosas: trazar el flujo -> generar el listado -> comprobar que
# vuelve a dar la ROM byte a byte -> las comprobaciones que el reensamblado NO
# cubre.
#
# Es un MegaROM de 128 KB con su propio mapper (GameMaster2: el de Konami sin
# SCC mas una SRAM en 0xA000), 16 bancos de 8 KB. Cada banco es un modulo
# (p00..p15) con su propio org -el sitio donde el
# mapper lo pone para ejecutarlo, medido en tools/paginas.py-, su trazado, sus
# notas y su listado. `make verify` reensambla los 16 y los concatena: tiene
# que salir la ROM entera, byte a byte.
#
# tools/bancos.py traza el CARTUCHO ENTERO llevando la cuenta de que banco hay
# en cada ranura. De ahi salen los src/pNN.entries -las llamadas que cruzan el
# mapper- y los src/pNN.nocode -las tablas de los despachadores-. `make
# semillas` los regenera.
#
# La ROM no se distribuye. Hace falta en la raiz como gamemaster2.rom, y
# `make comprueba` verifica el sha256.

ROM      = gamemaster2.rom
SHA      = 2054636a6ca292d56106e13d7fb1a94899c712d2ed0dde3f929a2dd162cd85ef
SRC      = src
WORK     = work
TITULO   = KONAMI'S GAME MASTER 2 - Konami (1987) - MSX1 - MegaROM RC-755 de 128 KB (GameMaster2)

PAGINAS  = 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15

# Donde se ejecuta cada banco. Es la misma tabla que `python3 tools/paginas.py
# lista` (un test lo comprueba); esta copiada aqui para no lanzar python 64
# veces por cada make.
ORG_00 = 0x4000
ORG_01 = 0x6000
ORG_02 = 0x8000
ORG_03 = 0xa000
ORG_04 = 0x8000
ORG_05 = 0x8000
ORG_06 = 0xa000
ORG_07 = 0x8000
ORG_08 = 0xa000
ORG_09 = 0x8000
ORG_10 = 0xa000
ORG_11 = 0xa000
ORG_12 = 0xa000
ORG_13 = 0xa000
ORG_14 = 0xa000
ORG_15 = 0xa000
ORG    = $(ORG_$(1))

all: listado verify sanity test

$(ROM):
	@echo "=================================================================="
	@echo " Falta $(ROM), y este repositorio NO lo distribuye."
	@echo ""
	@echo " Es Konami's Game Master 2 (Konami, RC-755, 1987) para MSX1, 131072"
	@echo " bytes exactos. Ponlo aqui con ese nombre."
	@echo " Para comprobar que es el mismo:"
	@echo "     shasum -a 256 $(ROM)"
	@echo "     $(SHA)"
	@echo ""
	@echo " Sin el se puede leer el listado ya generado en $(SRC)/, y los"
	@echo " tests que no dependen del binario siguen pasando."
	@echo "=================================================================="
	@false

comprueba: $(ROM)
	@echo "$(SHA)  $(ROM)" | shasum -a 256 -c -

# Reconocimiento: cabecera, escrituras al mapper, y la comprobacion de que la
# regla banco -> org la cumplen todas las escrituras. Es la base sobre la que
# se apoya todo lo demas.
reconoce: $(ROM)
	@python3 tools/reconocimiento.py $(ROM)

# Los 16 bancos cortados de la ROM, uno por fichero.
$(WORK)/p00.bin: $(ROM) tools/paginas.py
	@mkdir -p $(WORK)
	python3 tools/paginas.py corta $(ROM) $(WORK)

paginas: $(WORK)/p00.bin

# Las semillas: el trazado de cartucho entero, que es el unico que sabe que
# banco hay en cada ranura. Reescribe los .entries y los .nocode.
semillas: $(ROM)
	python3 tools/bancos.py $(ROM) escribe $(SRC)

# El trazado sigue el flujo desde los puntos de entrada DE CADA BANCO.
define REGLA_TRAZA
$(WORK)/p$(1).trace.json: $(WORK)/p00.bin $(SRC)/p$(1).entries $(SRC)/p$(1).nocode tools/z80trace.py
	python3 tools/z80trace.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(SRC)/p$(1).entries \
	        $(WORK)/p$(1) $(SRC)/p$(1).nocode
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_TRAZA,$(p))))

trace: $(foreach p,$(PAGINAS),$(WORK)/p$(p).trace.json)

# Un listado por banco: src/gamemaster2_pNN.asm, con el org de ese banco.
define REGLA_LISTADO
$(SRC)/gamemaster2_p$(1).asm: $(WORK)/p$(1).trace.json $(SRC)/p$(1).notes tools/mkasm.py
	python3 tools/mkasm.py $(WORK)/p$(1).bin $(call ORG,$(1)) $(WORK)/p$(1).trace.json \
	        $(SRC)/p$(1).notes $(WORK)/msx.sym $(SRC)/gamemaster2_p$(1).asm \
	        "$(TITULO) - banco $(1) (se ejecuta en $(call ORG,$(1)))"
endef
$(foreach p,$(PAGINAS),$(eval $(call REGLA_LISTADO,$(p))))

listado: $(foreach p,$(PAGINAS),$(SRC)/gamemaster2_p$(p).asm)

# La prueba que decide si el desensamblado es fiable: cada banco reensambla a
# sus 8192 bytes, y los 16 concatenados dan la ROM entera.
verify: $(WORK)/p00.bin
	@for p in $(PAGINAS); do \
	  sh tools/verify_build.sh $(SRC)/gamemaster2_p$$p.asm $(WORK)/p$$p.bin \
	     `python3 tools/paginas.py org $$p` $(WORK)/p$$p.out.bin || exit 1; \
	done
	@sh tools/verify_rom.sh $(WORK) $(ROM) $(SHA)

# Lo que el reensamblado NO puede cazar: que unos datos se esten leyendo como
# codigo. El binario sale identico igual, porque los bytes no cambian; lo unico
# que cambia es lo que decimos de ellos.
sanity: trace
	@echo "=================================================================="
	@echo " la regla banco -> org la cumplen todas las escrituras al mapper"
	@echo "=================================================================="
	@python3 tools/reconocimiento.py $(ROM) | tail -1
	@echo "=================================================================="
	@echo " ningun byte declarado como datos puede salir como codigo"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_trace.py $(WORK)/p$$p.trace.json $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@python3 tools/check_datos_como_codigo.py $(WORK) $(SRC)
	@echo "=================================================================="
	@echo " el trazado por bancos y el de cartucho entero dicen lo mismo"
	@echo "=================================================================="
	@python3 tools/check_bancos.py $(ROM) $(WORK) $(SRC)
	@echo "=================================================================="
	@echo " ningun punto de entrada puede caer dentro de una zona de datos"
	@echo "=================================================================="
	@for p in $(PAGINAS); do \
	  python3 tools/check_entradas.py $(SRC)/p$$p.entries $(SRC)/p$$p.notes \
	          $(SRC)/p$$p.nocode | tail -1 || exit 1; \
	done
	@echo "=================================================================="
	@echo " ni un byte del cartucho sin asignar (los 16 bancos)"
	@echo "=================================================================="
	@python3 tools/presupuesto.py $(WORK) $(SRC)

densidad:
	@for p in $(PAGINAS); do \
	  echo "-- p$$p"; python3 tools/densidad.py $(SRC)/gamemaster2_p$$p.asm | tail -2; \
	done

test:
	@echo "=================================================================="
	@echo " Tests"
	@echo "=================================================================="
	@python3 -m unittest discover -s tests -v

clean:
	rm -f $(WORK)/p*.trace.json $(WORK)/p*.blocks $(WORK)/p*.out.bin 	      $(WORK)/reensamblada.rom $(WORK)/pasmo.err
