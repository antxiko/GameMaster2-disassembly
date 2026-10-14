"""Saca la tabla de firmas de p00:44BE y la coteja contra las ROM de ../ROMS.

Para los juegos sin segunda cabecera, p00:58C6 suma los 256 bytes de
0x5000-0x50FF del cartucho de al lado y busca la suma aqui: entradas de
4 bytes [suma, ficha], 0 acaba. La ficha (19 bytes) empieza por el numero
de catalogo en BCD (07 01 = RC-701).
"""
import glob, os
NOMBRES = {
    0x700: "Athletic Land", 0x701: "Antarctic Adventure", 0x702: "Monkey Academy",
    0x703: "Time Pilot", 0x704: "Frogger", 0x705: "Super Cobra",
    0x706: "Konami's Billiards", 0x707: "Konami's Mahjong Dojo",
    0x710: "Hyper Olympic 1", 0x711: "Hyper Olympic 2", 0x712: "Circus Charlie",
    0x713: "Magical Tree", 0x714: "Comic Bakery", 0x715: "Hyper Sports 1",
    0x716: "Cabbage Patch Kids", 0x717: "Hyper Sports 2", 0x718: "Hyper Rally",
    0x720: "Konami's Tennis", 0x721: "Sky Jaguar", 0x723: "Konami's Golf",
    0x724: "Konami's Baseball", 0x725: "Yie Ar Kung-Fu", 0x727: "King's Valley",
    0x728: "Mopi Ranger", 0x729: "Pippols", 0x730: "Road Fighter",
    0x731: "Konami's Ping Pong", 0x733: "Hyper Sports 3",
    0x744: "Vampire Killer", 0x747: "Hinotori",
}
aqui = os.path.dirname(os.path.abspath(__file__))
rom = open(os.path.join(aqui, "..", "gamemaster2.rom"), "rb").read()
gm1 = open(os.path.join(aqui, "..", "..", "GAMEMASTER_DISAM", "gamemaster.rom"), "rb").read()

def tabla(r, ini):
    o, out = ini - 0x4000, []
    while True:
        s = r[o] | r[o + 1] << 8
        if s == 0:
            return out
        p = r[o + 2] | r[o + 3] << 8
        out.append((s, p, r[p - 0x4000] << 8 | r[p - 0x3FFF]))
        o += 4

sumas = {}
for f in sorted(glob.glob(os.path.join(aqui, "..", "..", "ROMS", "*.rom"))):
    d = open(f, "rb").read()
    if len(d) >= 0x1100:
        sumas.setdefault(sum(d[0x1000:0x1100]) & 0xFFFF, []).append(os.path.basename(f))

t2 = tabla(rom, 0x44BE)
del1 = {s for s, _, _ in tabla(gm1, 0x5F3A)}
print("| RC | juego | suma | ficha | GM1 | cotejo |")
print("|---|---|---|---|---|---|")
for s, p, rc in t2:
    rom_ok = [n for n in sumas.get(s, []) if "RC-%03X" % rc in n or NOMBRES[rc].split("'s ")[-1].split()[0] in n]
    print("| RC-%03X | %s | 0x%04X | p00:%04X | %s | %s |" % (
        rc, NOMBRES[rc], s, p, "si" if s in del1 else "**nueva**",
        "ROM aqui" if rom_ok else "-"))
print()
print("entradas %d, fichas %d, juegos %d, cotejadas %d, nuevas %d" % (
    len(t2), len({p for _, p, _ in t2}), len({rc for _, _, rc in t2}),
    sum(1 for s, _, rc in t2 if sumas.get(s)), sum(1 for s, _, _ in t2 if s not in del1)))
