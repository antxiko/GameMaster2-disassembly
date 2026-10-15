# omsx_traza_bio.tcl - El orden en que el biorritmo de MSX2 entra en sus rutinas.
# Pone un punto de ruptura en cada rutina con nombre de p05 y p06 (work/bp_bio.tcl,
# generado desde el listado) y apunta la primera vez que pasa por cada una.
# Mismo camino que tools/omsx_msx2.tcl hasta la grafica.
set ::log [open work/traza_bio.txt w]
after time 33 { source work/bp_bio.tcl }
proc pulsa {fila bit} {
    keymatrixdown $fila [expr {1 << $bit}]
    after time 0.15 [list keymatrixup $fila [expr {1 << $bit}]]
}
after time 15 { pulsa 8 0 }
after time 21.5 { pulsa 8 6 }
after time 23 { pulsa 8 6 }
after time 24.5 { pulsa 8 0 }
after time 30 { pulsa 8 6 }
after time 31 { pulsa 8 6 }
after time 32 { pulsa 8 6 }
after time 33.5 { pulsa 8 0 }
after time 38 { type "19700101" }
after time 41 { pulsa 7 7 }
after time 44 { type "19880101" }
after time 47 { pulsa 7 7 }
after time 50 { pulsa 7 7 }
after time 100 { close $::log ; exit }
