# omsx_msx2.tcl - Vuelca la VRAM (128 KB), los registros y la paleta del
# Game Master 2 en un MSX2 (C-BIOS_MSX2_JP), para cotejar los dibujos de MSX2.
#
# El arnes (tools/corre.py) no tiene V9938: en MSX2 el cotejo es contra esto.
# Camino por tiempo emulado: presentacion -> espacio -> menu -> abajo, abajo,
# espacio (SELF) -> abajo x3, espacio (BIORYTHM) -> las fechas de ejemplo.
#
#   "C:/Program Files/openMSX/openmsx.exe" -machine C-BIOS_MSX2_JP \
#       -cart gamemaster2.rom -script tools/omsx_msx2.tcl
#
# Variables de entorno: GM2_SALIDA (por defecto work/omsx2)

proc opcion {nombre porDefecto} {
    global env
    if {[info exists env($nombre)]} { return $env($nombre) }
    return $porDefecto
}

set ::SALIDA [opcion GM2_SALIDA {work/omsx2}]
file mkdir $::SALIDA

proc vuelca {etiqueta} {
    set f [open [file join $::SALIDA "vram-$etiqueta.bin"] wb]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block VRAM 0 131072]
    close $f
    set g [open [file join $::SALIDA "vdp-$etiqueta.txt"] w]
    for {set i 0} {$i < 47} {incr i} {
        puts $g [format "R%d = 0x%02X" $i [debug read "VDP regs" $i]]
    }
    for {set i 0} {$i < 16} {incr i} {
        puts $g [format "P%d = 0x%03X" $i [getcolor $i]]
    }
    close $g
    screenshot [file join $::SALIDA "ver-$etiqueta.png"]
    puts "volcado $etiqueta"
}

proc pulsa {fila bit} {
    keymatrixdown $fila [expr {1 << $bit}]
    after time 0.15 [list keymatrixup $fila [expr {1 << $bit}]]
}

after time 9  { vuelca "logo" }
after time 14 { vuelca "rotulo" }
after time 15 { pulsa 8 0 }
after time 20 { vuelca "menu" }
after time 21.5 { pulsa 8 6 }
after time 23 { pulsa 8 6 }
after time 24.5 { pulsa 8 0 }
after time 29 { vuelca "self" }
after time 30 { pulsa 8 6 }
after time 31 { pulsa 8 6 }
after time 32 { pulsa 8 6 }
after time 33 { pulsa 8 0 }
after time 37 { vuelca "bio" }
after time 38 { type "1970010119880101" }
after time 58 { vuelca "grafica" }
after time 59 { exit }
