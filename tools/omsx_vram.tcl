# omsx_vram.tcl - Vuelca la VRAM de verdad del Game Master 2 para cotejar.
#
# tools/pantallas.py dibuja las pantallas y tools/coteja.py las compara con el
# cartucho ejecutado en tools/corre.py. Esto es la otra mitad: el VDP de
# openMSX, para saber que el arnes (mapper, slots, BIOS) no se inventa nada.
#
# Camino por tiempo emulado, con teclas de la matriz (fila, bit):
#   espacio en el rotulo -> menu principal: abajo, abajo, espacio (SELF) ->
#   SELF: abajo, espacio (SRAM DISK UTILITY) -> espacio (DIRECTORY)
#
#   "C:/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX1_JP \
#       -cart gamemaster2.rom -script tools/omsx_vram.tcl
#
# Variables de entorno: GM2_SALIDA (por defecto work/omsx)

proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}

set ::SALIDA [opcion GM2_SALIDA {work/omsx}]
file mkdir $::SALIDA

proc vuelca {etiqueta} {
    set f [open [file join $::SALIDA "vram-$etiqueta.bin"] wb]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block VRAM 0 16384]
    close $f
    set g [open [file join $::SALIDA "vdp-$etiqueta.txt"] w]
    for {set i 0} {$i < 8} {incr i} {
        puts $g [format "R%d = 0x%02X" $i [debug read "VDP regs" $i]]
    }
    close $g
    puts "volcado $etiqueta"
}

# una tecla de la matriz durante 0.15 s
proc pulsa {fila bit} {
    keymatrixdown $fila [expr {1 << $bit}]
    after time 0.15 [list keymatrixup $fila [expr {1 << $bit}]]
}

set ESP {8 0}
set ABAJO {8 6}

after time 10 { vuelca "rotulo" }
after time 11 { pulsa 8 0 }
after time 15 { vuelca "menu" }
after time 16 { pulsa 8 6 }
after time 17 { pulsa 8 6 }
after time 18 { pulsa 8 0 }
after time 22 { vuelca "self" }
after time 23 { pulsa 8 6 }
after time 24 { pulsa 8 0 }
after time 28 { vuelca "sram" }
after time 29 { pulsa 8 0 }
after time 33 { vuelca "directorio" }
after time 34 { exit }
