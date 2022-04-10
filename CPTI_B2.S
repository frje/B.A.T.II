;          15/03/89
;
; cpti
;
; compactage de fichier
;
; entree:  d0 taille (en octets) forcement paire
;          a0 adresse du fichier
;          a1 adresse du buffer (meme taille que fichier)
;sortie:   d0 taille du fichier compacte
;
;



cpti::       move.w    d0,d1                ;recherche du nombre de mots a "0" ou "1"
             subq.w    #1,d1                ;resultat dans [d3]
             movea.l   a0,a2
             clr.w     d3
boucle:      move.b    (a2)+,d2
             beq       plus
             cmpi.b    #$ff,d2
             beq.s     plus
             dbra      d1,boucle
retour:      addi.w    #15,d3
             andi.w    #$fff0,d3
             lsr.w     #3,d3                ;d3 taille en nombre d'octets zone 2eme passe
             move.w    d0,d4
             addi.w    #15,d4
             andi.l    #$fff0,d4
             lsr.w     #3,d4                ;d4 taille zone 1ere passe

             movea.l   a1,a2
             move.w    d0,(a1)+
             move.w    d4,(a1)+
             move.w    d3,(a1)+
             move.w    d3,d1
             add.w     d4,d1
             lsr.w     #1,d1
             subq.w    #1,d1
clear:       clr.w     (a1)+
             dbra      d1,clear
;                                  ;[a1] pointe sur zone donnee
             movea.l   a2,a3
             addq.l    #6,a3                ;[a3] pointe sur zone 1ere passe
             move.w    #7,d3                ;[d3] No bit dans le mot
             movea.l   a3,a4
             adda.l    d4,a4                ;[a4] pointe sur zone 2eme passe
             move.w    #7,d4                ;[d4] No bit dans le mot
             move.w    d0,d1
             subq.w    #1,d1

loop:        move.b    (a0)+,d2
             beq.s     zero
             cmpi.b    #$ff,d2
             beq.s     un
             move.b    d2,(a1)+
suite2:      subq.w    #1,d3
             bge.s     suite6
             move.w    #7,d3
             addq.w    #1,a3
suite6:      dbra      d1,loop
             suba.l    a2,a1
             moveq.l   #0,d0
             move.w    a1,d0
             rts       

zero:        bset      d3,(a3)
             bra.s     bitplus

un:          bset      d3,(a3)
             bset      d4,(a4)
bitplus:     subq.w    #1,d4
             bge.s     suite2
             move.w    #7,d4
             addq.l    #1,a4
             bra.s     suite2

plus:        addq.w    #1,d3
             dbra      d1,boucle
             bra.s     retour



