;---------------------------------------------------------------
;
; pbox   13/01/90
;
; affichage d'une boite pleine
;
; entree:  d0 pos x
;          d1 pos y
;          d2 pos x2
;          d3 pos y2
;          d4 couleur

             .EXTERN sys01,cd013,cd013_3,cd013_4,cd013_12

pbox::       

             movea.l   sys01,a0
             cmp.w     d0,d2
             bge.s     suite1
             exg.l     d0,d2
suite1:      cmp.w     d1,d3
             bge.s     suite2
             exg.l     d1,d3
suite2:      
             lea.l     auto_mod1(pc),a1
             lea.l     auto_mod2(pc),a2
             lea.l     auto_mod3(pc),a3
             btst      #0,d4
             beq       and1
             move.w    #%1000110101011000,(a1)+   ;or.w d6,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #$ffff,(a0)+
             move.w    #$ffff,(a2)+
             move.w    #%1000111101011000,(a3)+   ;or.w d7,(a0)+
auto1:       btst      #1,d4
             beq       and2
             move.w    #%1000110101011000,(a1)+   ;or.w d6,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #$ffff,(a0)+
             move.w    #$ffff,(a2)+
             move.w    #%1000111101011000,(a3)+   ;or.w d7,(a0)+
auto2:       btst      #2,d4
             beq       and3
             move.w    #%1000110101011000,(a1)+   ;or.w d6,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #$ffff,(a0)+
             move.w    #$ffff,(a2)+
             move.w    #%1000111101011000,(a3)+   ;or.w d7,(a0)+
auto3:       btst      #3,d4
             beq       and4
             move.w    #%1000110101011000,(a1)+   ;or.w d6,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #$ffff,(a0)+
             move.w    #$ffff,(a2)+
             move.w    #%1000111101011000,(a3)+   ;or.w d7,(a0)+


auto4:       movea.w   d0,a2
             movea.w   d2,a3
             move.w    d2,d5
             addq.w    #1,d5
             andi.w    #$f,d5
             neg.w     d5
             addi.w    #16,d5
             move.w    #-1,d7
             lsl.w     d5,d7                ;d7 masque droit
             move.w    d0,d5
             andi.w    #$f,d5
             neg.w     d5
             addi.w    #16,d5
             move.w    #-1,d6
             lsl.w     d5,d6                ;d6 masque gauche

             sub.w     d1,d3                ;hauteur-1
             mulu.w    #160,d1
             adda.l    d1,a0
             move.w    d0,d1
             andi.l    #$fff0,d1
             lsr.w     #1,d1
             adda.l    d1,a0                ;a0 adresse mem
             movea.l   a0,a1
             move.w    d6,d4                ;d4=~d6
             not.w     d6
             move.w    d7,d5                ;d5=~d7
             not.w     d5

             addq.w    #1,d2
             lsr.w     #4,d0
             lsr.w     #4,d2
             sub.w     d0,d2                ;d2 nb mots milieu
             subq.w    #2,d2                ;d2 nb mots milieu -2
             cmpi.w    #-2,d2
             beq       inf_16

vertical:    move.w    d2,d0
auto_mod1:   or.w      d6,(a0)+             ;and.w d4,(a0)+ automodifie
             or.w      d6,(a0)+             ;      "
             or.w      d6,(a0)+             ;      "
             or.w      d6,(a0)+             ;      "
horizon:     cmpi.w    #0,d0
             blt.s     ici
auto_mod2:   move.w    #$ffff,(a0)+         ;move.w #0,(a0)+ automodife
             move.w    #$ffff,(a0)+         ;        "
             move.w    #$ffff,(a0)+         ;        "
             move.w    #$ffff,(a0)+         ;        "
             dbra      d0,horizon
ici:         tst.w     d7
             beq.s     ici2
             bsr       auto_mod3

ici2:        lea.l     160(a1),a1           ;adda.l   #160,a1
             movea.l   a1,a0
             dbra      d3,vertical
             bra       fin

auto_mod3:   or.w      d7,(a0)+             ;and.w d5,(a0)+ automodifie
             or.w      d7,(a0)+             ;      "
             or.w      d7,(a0)+             ;      "
             or.w      d7,(a0)+             ;      "
             rts       


inf_16:      
             move.w    a2,d0                ;x
             move.w    a3,d1                ;x2
             andi.w    #$f,d0
             andi.w    #$f,d1
             neg.w     d1
             addi.w    #15,d1
             move.w    #-1,d2
             lsl.w     d0,d2
             lsr.w     d0,d2
             lsr.w     d1,d2
             lsl.w     d1,d2
             move.w    d2,d7
             move.w    d7,d5
             not.w     d5
boucle:      
             bsr       auto_mod3
             lea.l     160(a1),a1           ;adda.l   #160,a1
             movea.l   a1,a0
             dbra      d3,boucle
fin:         
             rts       

and1:        move.w    #%1100100101011000,(a1)+   ;and.w d4,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #0,(a0)+
             clr.w     (a2)+
             move.w    #%1100101101011000,(a3)+   ;and.w d5,(a0)+
             bra       auto1
and2:        move.w    #%1100100101011000,(a1)+   ;and.w d4,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #0,(a0)+
             clr.w     (a2)+
             move.w    #%1100101101011000,(a3)+   ;and.w d5,(a0)+
             bra       auto2
and3:        move.w    #%1100100101011000,(a1)+   ;and.w d4,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #0,(a0)+
             clr.w     (a2)+
             move.w    #%1100101101011000,(a3)+   ;and.w d5,(a0)+
             bra       auto3
and4:        move.w    #%1100100101011000,(a1)+   ;and.w d4,(a0)+
             move.w    #%0011000011111100,(a2)+   ;move.w #0,(a0)+
             clr.w     (a2)+
             move.w    #%1100101101011000,(a3)+   ;and.w d5,(a0)+
             bra       auto4


