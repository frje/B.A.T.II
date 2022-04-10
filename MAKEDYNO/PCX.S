;---------------------------------------------------------------
;
; pcx
;
; decompactage pcx
;
; entree:     a0 adresse source (compacte)
;             a1 adresse destination (buffer)
;

pcx:         
             moveq.l   #0,d0
             move.w    (a0)+,d0
             lea.l     0(a1,d0.l),a2        ;adresse de fin

b0:          
             moveq.l   #0,d7
             move.b    (a0)+,d7
             cmpi.w    #192,d7
             bgt       sup

             move.b    d7,(a1)+
             cmpa.l    a1,a2
             bne.s     b0
             rts       

sup:         
             subi.w    #192+1,d7
             move.b    (a0)+,d6
sb0:         
             move.b    d6,(a1)+
             dbra      d7,sb0

             cmpa.l    a1,a2
             bne.s     b0
             rts       







