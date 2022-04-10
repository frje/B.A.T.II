;---------------------------------------------------------------
;
; rnd             3/6/90
;
; generation d'un nombre aleatoire sur 16 bits
;
; entree:  d0 le plus grand nombre pouvant etre obtenu
;
; retour:  d0 nombre genere
;

             .TEXT 

rnd::        
             tst.w     d0
             blt       sautnoirrouge
             beq       rts
             move.w    d0,d7
             move.l    #$10000,d6
             addq.w    #1,d0
             divu.w    d0,d6

             move.w    contvbl+2,d0
             eori.w    #$1234,d0
             move.w    exalea,d1
             addq.w    #1,d1
             mulu.w    d1,d0
             lsr.l     #4,d0
             move.w    d0,exalea

             swap.w    d0
             clr.w     d0
             swap.w    d0
             divu.w    d6,d0
             cmp.w     d7,d0
             ble       rts
             move.w    d7,d0
rts:         
             rts       

exalea:      .DC.w $1234

sautnoirbleu:          
             jmp       noirbleu
sautnoirrouge:         
             jmp       noirrouge

