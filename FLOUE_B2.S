;---------------------------------------------------------------
;
; floue_b2          le 2/6/90
;
; entree:     a0 pointe sur l'image
;             d0 nombre de mots de large
;             d1 nombre de lignes
;
;             a1 adresse de la palette;;;;;;;;;;;;;;          tient compte de l'etat de la palette $ff8240 a $ff8240+15*2
;

             .TEXT 

floue::      
             move.l    a1,adrpalette

             lea.l     -512(sp),sp
             move.l    sp,adrconvert
             lea.l     -256(sp),sp
             move.l    sp,adrcolcol


;on calcule la table de convertion

             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   adrconvert,a0        ;;;              lea.l    convert,a0
             lea.l     512(a0),a0

             moveq.l   #7,d0                ;rouge
a002:        
             moveq.l   #7,d1                ;vert
a001:        
             moveq.l   #7,d2                ;bleu
a000:        

             move.w    #200,min

             moveq.l   #15,d3
a003:        
             move.w    d3,d4

             add.w     d4,d4
             move.w    0(a1,d4.w),d4        ;composante rvb de la couleur numero d3

             move.w    d4,d7
             andi.w    #$7,d7               ;bleu
             sub.w     d2,d7
             muls.w    d7,d7

             move.w    d4,d6
             lsr.w     #4,d6
             move.w    d6,d5
             andi.w    #$7,d6               ;vert
             sub.w     d1,d6
             muls.w    d6,d6
             add.w     d6,d7

             lsr.w     #4,d5
             andi.w    #$7,d5               ;rouge
             sub.w     d0,d5
             muls.w    d5,d5
             add.w     d5,d7

             cmp.w     min,d7
             bgt       a004
             move.w    d7,min
             move.b    d3,nocol
a004:        
             dbra      d3,a003

             move.b    nocol,-(a0)

             dbra      d2,a000
             dbra      d1,a001
             dbra      d0,a002
             movem.l   (sp)+,d0-d7/a0-a6


;---------------------------------------------------------------

             movem.l   d0-d7/a0-a6,-(sp)


             movea.l   adrcolcol,a0         ;              lea.l    colcol,a0 ¨Mode d'adressage ill‚gal
             lea.l     256(a0),a0
             movea.l   adrconvert,a1        ;              lea.l    convert,a1
             movea.l   adrpalette,a2        ;              movea.l  #$ff8240,a2

             moveq.l   #15,d0
t000:        
             moveq.l   #15,d1
t001:        
             move.w    d0,d2
             move.w    d1,d3
             add.w     d2,d2
             add.w     d3,d3
             move.w    0(a2,d2.w),d2
             move.w    0(a2,d3.w),d3
             move.w    d2,d4
             move.w    d3,d5

             andi.w    #7,d4
             andi.w    #7,d5
             add.w     d5,d4
             lsr.w     #1,d4                ;bleu

             move.w    d2,d5
             move.w    d3,d6
             lsr.w     #4,d5
             lsr.w     #4,d6
             andi.w    #7,d5
             andi.w    #7,d6
             add.w     d6,d5
             lsr.w     #1,d5                ;vert

             lsr.w     #8,d2
             lsr.w     #8,d3
             andi.w    #7,d2
             andi.w    #7,d3
             add.w     d3,d2
             lsr.w     #1,d2                ;rouge

             lsl.w     #3,d2
             or.w      d5,d2
             lsl.w     #3,d2
             or.w      d4,d2

             move.b    0(a1,d2.w),-(a0)
             dbra      d1,t001
             dbra      d0,t000

             movem.l   (sp)+,d0-d7/a0-a6



; on filtre l'image


             move.w    d0,d7
             mulu.w    #10,d7               ;nombre d'octets entre 5 ligne
             subq.w    #8,d7

             lsr.w     #2,d0
             subq.w    #5,d1
             mulu.w    d1,d0                ;nombre de boucles
             subq.w    #1,d0

             move.w    d7,d1

             movea.l   a0,a3                ;adresse image source et destination

r000:        
             lea.l     buf16,a1
             bsr       bitpoct

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     buf16b,a1
             lea.l     0(a0,d1.w),a0
             bsr       bitpoct
             movem.l   (sp)+,d0-d7/a0-a6


             lea.l     buf16,a6
             movea.l   adrcolcol,a5         ;;             lea.l    colcol,a5
             lea.l     buf16b,a4

             .REPT 16
             moveq.l   #0,d7
             move.b    (a6),d7
             lsl.w     #4,d7
             or.b      (a4)+,d7
             move.b    0(a5,d7.w),(a6)+
             .ENDR 

             lea.l     buf16,a2
             bsr       octbitp
             dbra      d0,r000

             lea.l     512+256(sp),sp

             rts       

octbitp:     
             .REPT 16
             move.b    (a2)+,d3
             lsr.w     #1,d3
             addx.w    d4,d4
             lsr.w     #1,d3
             addx.w    d5,d5
             lsr.w     #1,d3
             addx.w    d6,d6
             lsr.w     #1,d3
             addx.w    d7,d7
             .ENDR 

             move.w    d4,(a3)+
             move.w    d5,(a3)+
             move.w    d6,(a3)+
             move.w    d7,(a3)+

             rts       



bitpoct:     
             move.w    (a0)+,d4
             move.w    (a0)+,d5
             move.w    (a0)+,d6
             move.w    (a0)+,d7

             .REPT 16
             moveq.l   #0,d3
             add.w     d7,d7
             addx.w    d3,d3
             add.w     d6,d6
             addx.w    d3,d3
             add.w     d5,d5
             addx.w    d3,d3
             add.w     d4,d4
             addx.w    d3,d3
             move.b    d3,(a1)+
             .ENDR 

             rts       


             .BSS 

;convert:      .DS.b 512               ;table de correspondance entre la couleur recherchee et une des couleurs de la palette

;colcol:       .DS.b 16*16

adrconvert:  .DS.l 1
adrcolcol:   .DS.l 1

adrpalette:  .DS.l 1

min:         .DS.w 1
nocol:       .DS.w 1
buf16:       .DS.b 16

