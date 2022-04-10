;---------------------------------------------------------------
;
; mfp
;
; mfp_1 place le mfp en mode CD
; mfp_2 place le mfp en mode GEM
;

mfp          equ $fffa00
vr           equ mfp+$17
iera         equ mfp+$7
isra         equ mfp+$f
imra         equ mfp+$13
ipra         equ mfp+11
tadr         equ mfp+31
tacr         equ mfp+25
ierb         equ mfp+9
tcdcr        equ mfp+29
imrb         equ mfp+21
isrb         equ mfp+17
iprb         equ mfp+13
;vector     equ mfp+23
tbcr         equ mfp+$1b
tbdr         equ mfp+$21

mfp_1::      
             moveq.l   #14,d0
             movea.l   #mfp,a0
             lea.l     mfpmem,a1
b00:         
             addq.l    #1,a0
             move.b    (a0)+,(a1)+
             dbra      d0,b00


             move.b    #%00000000,iera
             move.b    #%01000000,ierb
             move.b    #%00000000,imra
             move.b    #%01000000,imrb
             bclr      #3,vr
             clr.b     tacr
             clr.b     tbcr
;         move.b   #%01010000,tcdcr           ;;;;;;;;;
             rts       


mfp_2::      
             move.w    #$2700,sr
             moveq.l   #14,d0
             movea.l   #mfp,a1
             lea.l     mfpmem,a0
b01:         
             addq.l    #1,a1
             move.b    (a0)+,(a1)+
             dbra      d0,b01
             move.w    #$2300,sr
             rts       

             .BSS 


