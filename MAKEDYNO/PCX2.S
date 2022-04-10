;---------------------------------------------------------------
;
; pcx2
;
; decompactage pcx2
;
; entree:     a0 adresse source (compacte)
;             a1 adresse destination (buffer)
;

pcx2:        
             moveq.l   #0,d5
             moveq.l   #0,d0
             move.w    (a0)+,d0
             lea.l     0(a1,d0.l),a2        ;adresse de fin

b0:          
             moveq.l   #0,d7
             move.b    (a0)+,d7
             cmpi.w    #128,d7
             bge       sup

             add.b     d5,d7
             move.b    d7,(a1)+
             cmpa.l    a1,a2
             bgt.s     b0
             rts       

sup:         bne       sup1
             eor.w     d5,$80
             cmpa.l    a1,a2
             bgt.s     b0
             rts       

sup1:        cmpi.w    #192,d7
             bcs       sup2
             subi.w    #192+1,d7
             move.b    (a0)+,d6
sb0:         
             move.b    d6,(a1)+
             dbra      d7,sb0

             cmpa.l    a1,a2
             bgt.s     b0
             rts       

sup2:        subi.w    #128+1,d7
             move.b    (a0)+,d4             ;;;;;;;;              move.w   (a0)+,d6
             move.b    (a0)+,d6
             add.b     d5,d4
             add.b     d5,d6

sb1:         
;  move.w   d6,(a1)+
             move.b    d4,(a1)+
             move.b    d6,(a1)+

             dbra      d7,sb1
             cmpa.l    a1,a2
             bgt       b0
             rts       






