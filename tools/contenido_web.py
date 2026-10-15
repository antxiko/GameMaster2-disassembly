#!/usr/bin/env python3
"""Lo que la web dice de ESTE cartucho: nombre, cifras, cabecera, hallazgos,
galeria y paginas. La maquinaria (md2html.py, make_web.py) no nombra ningun
juego."""

NOMBRE = "Konami's Game Master 2"
CATALOGO = "RC-755"
ANIO = 1987
REPOSITORIO = "https://github.com/antxiko/GameMaster2-disassembly"

# Las cifras del listado (tools/densidad_total.py y tools/presupuesto.py)
CODIGO = 36633
DATOS = 94439
RUTINAS = 2338
INSTRUCCIONES = 18220
COMENTARIOS = 7312

BANCOS_CON_CODIGO = ("00", "01", "02", "03", "04", "05", "06", "07", "08", "09")

# Las paginas, en el mismo orden en los dos idiomas (la pareja sale de ahi)
NAV_EN = [("index.html", "Home"), ("GETTING-STARTED.html", "Start"),
          ("THE-CARTRIDGE.html", "The cartridge"),
          ("THE-SCREENS.html", "The screens"),
          ("TENNIS-AND-HOCKEY.html", "Tennis and Hockey"),
          ("THE-BIORHYTHM.html", "The biorhythm"),
          ("THE-MUSIC.html", "The music"),
          ("THE-TEXTS.html", "The texts"),
          ("THE-CODE.html", "The code"),
          ("FINDINGS.html", "Findings"),
          ("OPEN-QUESTIONS.html", "Open questions")]
NAV_ES = [("index.html", "Portada"), ("EMPEZAR.html", "Empezar"),
          ("EL-CARTUCHO.html", "El cartucho"),
          ("LAS-PANTALLAS.html", "Las pantallas"),
          ("TENNIS-Y-HOCKEY.html", "Tennis and Hockey"),
          ("EL-BIORRITMO.html", "El biorritmo"),
          ("LA-MUSICA.html", "La música"),
          ("LOS-TEXTOS.html", "Los textos"),
          ("EL-CODIGO.html", "El código"),
          ("HALLAZGOS.html", "Hallazgos"),
          ("PREGUNTAS-ABIERTAS.html", "Preguntas abiertas")]


def densidad(idioma):
    """El porcentaje comentado, con la coma o el punto de cada idioma."""
    d = "%.1f" % (100.0 * COMENTARIOS / INSTRUCCIONES)
    return d.replace(".", ",") if idioma == "es" else d


PIE_LEGAL = {
    "es": "<em>Konami's Game Master 2</em> (en Jap&oacute;n, <em>Konami no Shin "
          "10-bai Cartridge</em>) lo public&oacute; Konami para MSX en 1987; su "
          "n&uacute;mero de cat&aacute;logo es RC-755 y son 128 KB. Todos los "
          "derechos siguen siendo de sus titulares. Este trabajo es de "
          "preservaci&oacute;n, estudio y documentaci&oacute;n, y la imagen del "
          "cartucho no se distribuye.",
    "en": "<em>Konami's Game Master 2</em> (in Japan, <em>Konami no Shin "
          "10-bai Cartridge</em>) was published by Konami for the MSX in 1987; "
          "its catalogue number is RC-755 and it is 128 KB. All rights remain "
          "with their holders. This is preservation, study and documentation "
          "work, and the cartridge image is not distributed.",
}

PORTADA = {
    "es": dict(
        titulo="Konami's Game Master 2 - desensamblado comentado",
        claim="El cartucho de trucos de Konami por dentro: c&oacute;mo se cuela "
              "en 30 juegos, su SRAM, un Tennis and Hockey para dos, un "
              "biorritmo y nueve m&uacute;sicas. 24 pantallas dibujadas desde la "
              "ROM, en MSX1 y en MSX2.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "Cartucho <b>RC-755</b>, 128 KB con SRAM (mapper Game Master 2)",
               "<b>MSX</b> (y MSX2)", "Volcado <b>5c00f9e3...</b>"],
        aviso="<b>Aqu&iacute; no hay ninguna captura.</b> Todas las "
              "im&aacute;genes est&aacute;n <b>dibujadas desde los bytes de la "
              "ROM</b> y <b>cotejadas a 0 bytes</b> contra el cartucho ejecutado "
              "o contra la VRAM de openMSX. Las m&uacute;sicas salen del propio "
              "motor y coinciden con openMSX cuadro a cuadro. El listado se "
              "reensambla <b>byte a byte</b> con <code>make</code>.",
    ),
    "en": dict(
        titulo="Konami's Game Master 2 - a commented disassembly",
        claim="Konami's cheat cartridge from the inside: how it gets into 30 "
              "games, its SRAM, a two-player Tennis and Hockey, a biorhythm and "
              "nine tunes. 24 screens drawn from the ROM, on MSX1 and MSX2.",
        ficha=["Konami - <b>(c) Konami 1987</b>",
               "An <b>RC-755</b> cartridge, 128 KB with SRAM (Game Master 2 mapper)",
               "<b>MSX</b> (and MSX2)", "Dump <b>5c00f9e3...</b>"],
        aviso="<b>Not one capture here.</b> Every picture is <b>drawn from the "
              "bytes of the ROM</b> and <b>checked to 0 bytes</b> against the "
              "running cartridge or the openMSX VRAM. The tunes come from the "
              "cartridge's own engine and match openMSX frame by frame. The "
              "listing reassembles <b>byte for byte</b> with <code>make</code>.",
    ),
}

LEIDO = {"es": "<p>Le&iacute;do en el c&oacute;digo.</p>", "en": "<p>Read in the code.</p>"}
COTEJADO = {"es": "<p>Cotejado con openMSX.</p>", "en": "<p>Checked against openMSX.</p>"}

HALLAZGOS = {
    "es": [
        ("Entra tambi&eacute;n en los cartuchos de MSX2",
         "<p>Para colarse en el juego busca en su arranque la direcci&oacute;n de "
         "un gancho de interrupci&oacute;n: primero la de H.TIMI, donde se "
         "cuelgan los seis cartuchos de MSX2 de Konami, y luego la de H.KEYI, la "
         "de los de MSX1 (<code>p00:588C</code>). El Game Master 1 solo buscaba "
         "la segunda.</p>" + LEIDO["es"]),
        ("68 firmas para 30 juegos",
         "<p>Si el juego no trae la segunda cabecera de <code>0x4010</code>, suma "
         "los 256 bytes de <code>0x5000</code> y busca la suma en "
         "<code>p00:44BE</code>: son las 62 del Game Master 1 m&aacute;s cinco "
         "de Vampire Killer y una de Hinotori. 35 est&aacute;n comprobadas "
         "sumando las ROM.</p>"),
        ("En MSX1 llama a una rutina que solo existe en MSX2",
         "<p>Al borrar la VRAM usa BIGFIL (<code>0x016B</code>) tambi&eacute;n en "
         "MSX1, donde esa entrada de la BIOS no existe: la VRAM no se borra "
         "entera. No se ve porque lo que queda cae en letras que la pantalla no "
         "usa.</p>" + COTEJADO["es"]),
        ("Cinco pistas para tres voces",
         "<p>El motor de Tennis and Hockey lleva tres pistas de m&uacute;sica y "
         "dos de efectos; los efectos le quitan al PSG la voz B o la C mientras "
         "suenan y se la devuelven al acabar (<code>p08:A291</code>). Nunca toca "
         "un SCC.</p>" + COTEJADO["es"]),
        ("Las curvas del biorritmo se encienden",
         "<p>En MSX2 los colores de las tres curvas suben un poco cada d&iacute;a "
         "de la animaci&oacute;n hasta quedar en amarillo, cian y magenta "
         "(<code>p06:A2B7</code>).</p>" + COTEJADO["es"]),
    ],
    "en": [
        ("It also gets into MSX2 cartridges",
         "<p>To get into the game it looks in its start-up code for the address "
         "of an interrupt hook: first H.TIMI, where Konami's six MSX2 cartridges "
         "hook in, then H.KEYI, the MSX1 one (<code>p00:588C</code>). Game "
         "Master 1 only looked for the second.</p>" + LEIDO["en"]),
        ("68 signatures for 30 games",
         "<p>If the game has no second header at <code>0x4010</code>, it adds up "
         "the 256 bytes at <code>0x5000</code> and looks the sum up at "
         "<code>p00:44BE</code>: Game Master 1's 62 plus five for Vampire Killer "
         "and one for Hinotori. 35 are checked by adding up the ROMs.</p>"),
        ("On MSX1 it calls a routine that only exists on MSX2",
         "<p>To clear the VRAM it uses BIGFIL (<code>0x016B</code>) on MSX1 too, "
         "where that BIOS entry does not exist: the VRAM is not fully cleared. "
         "It does not show because what is left falls on characters the screen "
         "does not use.</p>" + COTEJADO["en"]),
        ("Five tracks for three voices",
         "<p>The Tennis and Hockey engine has three music tracks and two effect "
         "tracks; the effects take PSG voice B or C while they play and give it "
         "back when they end (<code>p08:A291</code>). It never touches an "
         "SCC.</p>" + COTEJADO["en"]),
        ("The biorhythm curves fade in",
         "<p>On MSX2 the colours of the three curves rise a little each day of "
         "the animation until they end up yellow, cyan and magenta "
         "(<code>p06:A2B7</code>).</p>" + COTEJADO["en"]),
    ],
}

LOGOTIPO = "presentacion_japonesa.png"
GALERIA = [
    ("menu_principal.png",
     "El men&uacute; principal (<code>p09:82CA</code>).",
     "The main menu (<code>p09:82CA</code>)."),
    ("menu_principal_internacional.png",
     "El mismo men&uacute; en una m&aacute;quina no japonesa (<code>p09:8D27</code>).",
     "The same menu on a non-Japanese machine (<code>p09:8D27</code>)."),
    ("menu_self.png",
     "El men&uacute; del cartucho solo (<code>p00:5DEE</code>).",
     "The menu of the cartridge on its own (<code>p00:5DEE</code>)."),
    ("tenis_pista.png",
     "La pista de tenis lista para sacar (<code>p07:81A2</code>).",
     "The tennis court ready to serve (<code>p07:81A2</code>)."),
    ("hockey_pista.png",
     "La pista de hockey (<code>p07:81A2</code>).",
     "The hockey rink (<code>p07:81A2</code>)."),
    ("bio_grafica.png",
     "El biorritmo en MSX1, con las fechas de ejemplo (<code>p05:8B1B</code>).",
     "The biorhythm on MSX1, with the example dates (<code>p05:8B1B</code>)."),
    ("rotulo_msx2.png",
     "El r&oacute;tulo en MSX2 (<code>p09:8B20</code>).",
     "The title on MSX2 (<code>p09:8B20</code>)."),
    ("menu_msx2.png",
     "El men&uacute; en MSX2 (<code>p09:8692</code>).",
     "The menu on MSX2 (<code>p09:8692</code>)."),
    ("bio_grafica_msx2.png",
     "El biorritmo en MSX2 (<code>p05:8B29</code>).",
     "The biorhythm on MSX2 (<code>p05:8B29</code>)."),
]
