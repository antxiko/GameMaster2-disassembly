import sys,re; sys.path.insert(0,'tools')
from paginas import ORG
from bancos import BASE_LEN, ED_LEN4, IDX_DISP
d=open('gamemaster2.rom','rb').read()
def s8(x): return x-256 if x>127 else x
def ilen(m,i):
    op=m[i]
    if op==0xCB: return 2
    if op==0xED: return 4 if m[i+1] in ED_LEN4 else 2
    if op in (0xDD,0xFD):
        o2=m[i+1]
        if o2==0xCB: return 4
        if o2 in (0x21,0x22,0x2A,0x36): return 4
        return 2+(1 if o2 in IDX_DISP else 0)
    return BASE_LEN[op]
TERM={0xC9,0xC3,0x18,0xE9}
VALID_ED={0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,0x4B,0x4D,0x4F,0x50,0x51,0x52,0x53,0x56,0x57,0x58,0x59,0x5A,0x5B,0x5E,0x5F,0x60,0x61,0x62,0x67,0x68,0x69,0x6A,0x6F,0x72,0x73,0x78,0x79,0x7A,0x7B,0xA0,0xA1,0xA2,0xA3,0xA8,0xA9,0xAA,0xAB,0xB0,0xB1,0xB2,0xB3,0xB8,0xB9,0xBA,0xBB}
def refs(b,a):
    w=[j for j in range(1,len(d)-1) if d[j]==a&0xFF and d[j+1]==a>>8]
    seg=d[b*0x2000:(b+1)*0x2000]
    r=[i for i in range(len(seg)-1) if seg[i] in (0x18,0x20,0x28,0x30,0x38,0x10) and ORG[b]+i+2+s8(seg[i+1])==a]
    return w,r
for arg in sys.argv[1:]:
    b,a,n=arg.split(':'); b=int(b); a=int(a,16); n=int(n)
    seg=d[b*0x2000:(b+1)*0x2000]; o=a-ORG[b]
    i=o; ok=True; last=None; bad=None
    while i<o+n:
        op=seg[i]
        if op==0xED and seg[i+1] not in VALID_ED: ok=False; bad="ED %02X"%seg[i+1]; break
        if op==0xFF: ok=False; bad="rst 38"; break
        L=ilen(seg,i); last=op; i+=L
    fits = (i==o+n)
    w,r=refs(b,a)
    print("p%02d:%04X %3d  limpio=%s cuadra=%s ultimo=%s  palabras=%d rel=%d %s  %s"%(b,a,n,ok,fits,"%02X"%last if last is not None else None,len(w),len(r),bad or "",seg[o:o+10].hex()))
