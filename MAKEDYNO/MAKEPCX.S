;---------------------------------------------------------------
;
; makepcx
;
; entree:     a0 source
;             a1 destination
;             d0 taille decompactee
;
; retour:     d0 taille compactee
;

makepcx:     
             movea.l   a1,a6
             move.w    d0,(a1)+             ;taille decompactee
             swap.w    d0
             clr.w     d0
             swap.w    d0
             lea.l     0(a0,d0.l),a2        ;adresse de fin de source
             lea.l     320+1(a0),a3         ;adresse de fin de ligne

             moveq.l   #0,d0                ;compteur de repetition
             moveq.l   #0,d1                ;valeur initiale
             move.b    (a0)+,d1
             moveq.l   #0,d2
b:           
             move.b    (a0)+,d2
             cmpa.l    a0,a2
             beq       last

             cmp.w     d1,d2
             beq       rep
             tst.w     d0
             bne       finrep
;un octet seul...
             cmpi.w    #192,d1
             blt.s     inf192
             move.b    #192+1,(a1)+
inf192:      
             move.b    d1,(a1)+
             move.w    d2,d1
             bra       b

rep:         
             cmpi.w    #62,d0
             beq       finrep

             cmpa.l    a0,a3
             beq       finligne
             addq.w    #1,d0
             bra       b

finligne:    
             lea.l     320(a3),a3
;;;;;;             bra      finrep

finrep:      
             addi.w    #192+1,d0
             move.b    d0,(a1)+
             move.b    d1,(a1)+
             move.w    d2,d1
             moveq.l   #0,d0
             bra       b

last:        
             tst.w     d0
             bne       finrepl
;un octet seul...
             cmpi.w    #192,d1
             blt.s     inf192l
             move.b    #192+1,(a1)+
inf192l:     
             move.b    d1,(a1)+
             suba.l    a6,a1
             move.l    a1,d0                ;taille
             rts       

finrepl:     
             addi.w    #192+2,d0
             move.b    d0,(a1)+
             move.b    d1,(a1)+
             suba.l    a6,a1
             move.l    a1,d0                ;taille
             rts       


