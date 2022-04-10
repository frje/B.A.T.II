;---------------------------------------------------------------
;
; POLYL       26/11/90
;
; Trac‚ d'une ligne constitu‚e par une suite de points avec
; clipping en option
;
;entree:(variables … d‚finir)
;
;             polyl_1.w nombre de points
;             polyl_2.l adresse de points (prevoir un mot de + dans le buffer)
;             polyl_4.w couleur
;             polyl_5.w clipping on/off (1 on, 0 off)
;             polyl_6 (4 mots) coordonnees pour clipping (eventuellement)
;

;NOTES:

;1) ne trace pas s'il n'y a pas au moins 2 points
;2) des points successifs peuvent etre identiques
;3) les autres variables utilis‚es sont adrmin et adrmax (longs_mots)
;4) les coordonn‚es de la fenetre doivent etre positives;et dans l'‚cran!
;5) tous les registres sont utilis‚s sauf A2


             .EXTERN sys01

             .TEXT 

box::        
             move.w    #5,polyl_1
             move.l    #bufligne,polyl_2
             move.w    d4,polyl_4
             clr.w     polyl_5
             lea.l     bufligne,a0
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             move.w    d2,(a0)+
             move.w    d1,(a0)+
             move.w    d2,(a0)+
             move.w    d3,(a0)+
             move.w    d0,(a0)+
             move.w    d3,(a0)+
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             bsr       cd017
             rts       

point::      
             move.w    #2,polyl_1
             move.l    #bufligne,polyl_2
             move.w    d2,polyl_4
             clr.w     polyl_5
             lea.l     bufligne,a0
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             bsr       cd017
             rts       


ligne::                ;te
             move.w    #2,polyl_1
             move.l    #bufligne,polyl_2
             move.w    d4,polyl_4
             clr.w     polyl_5
             lea.l     bufligne,a0
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             move.w    d2,(a0)+
             move.w    d3,(a0)+
             bsr       cd017
             rts       

bufligne:    .DC.l 0,0,0,0,0

cd017::      
polyl::      
             lea.l     cd017_3,a0
             move.l    sys01,(a0)
             lea.l     cd017_1,a6
             move.w    (a6),d4              ;d4=cd017_1
             subq.w    #2,d4
             bge.s     okline
             rts                            ;il faut au moins 2 points
okline:      
             tst.w     10(a6)               ;clip_line?
             beq.s     nonclipl
             movea.l   6(a6),a5
             move.w    22(a6),d6            ;D6=Y
             ext.l     d6
             move.l    d6,d5                ;D5=Y
             asl.l     #7,d6                ;D6=128*Y
             asl.l     #5,d5                ;D5=32*Y
             add.l     d5,d6                ;D6=160*Y
             adda.l    d6,a5                ;A5=A5+160*Y
             move.l    a5,12(a6)            ;adrmin

             movea.l   6(a6),a5
             move.w    26(a6),d6            ;D6=Y
             ext.l     d6
             move.l    d6,d5                ;D5=Y
             asl.l     #7,d6                ;D6=128*Y
             asl.l     #5,d5                ;D5=32*Y
             add.l     d5,d6                ;D6=160*Y
             adda.l    d6,a5                ;A5=A5+160*Y
             move.l    a5,16(a6)            ;adrmax
nonclipl:    

;s‚lectionner la couleur du trac‚:

             move.w    30(a6),d0            ;D0 contient le code de la couleur du trac‚
             andi.w    #$000f,d0
             lea.l     instruct,a2          ;A2 pointe les instructions
             lsl.w     #3,d0                ;D0 est index
             move.l    0(a2,d0.w),d1
             move.l    4(a2,d0.w),d2
             lea.l     couleurl,a2
             addi.l    #$02000200,d1
             addi.l    #$02000200,d2
             move.l    d1,(a2)+
             move.l    d2,(a2)              ;fin de s‚lection de la couleur du trac‚

             movea.l   2(a6),a1             ;a1 pointe la liste des points
             lea.l     masque,a4            ;A4 pointe la table des masques

polyloop0:   
             swap.w    d4

             moveq.l   #0,d5
             move.w    (a1)+,d5             ;x1-->d5
             move.w    d5,d0
             move.w    (a1)+,d6             ;y1-->d6
             move.w    d6,d1
             ext.l     d6
             move.l    d6,d3
             movea.l   6(a6),a3
             asl.l     #7,d6
             asl.l     #5,d3
             add.l     d3,d6
             adda.l    d6,a3                ;adresse de l'ordonn‚e de l'origine

             moveq.l   #0,d2
             moveq.l   #0,d3
             sub.w     (a1),d0              ;x1-x2-->d0
             beq.s     polyl1
             bgt.s     dxpos
             neg.w     d0
             move.w    #1,d2
             bra.s     polyl1
dxpos:       move.w    #-1,d2
polyl1:      sub.w     2(a1),d1             ;y1-y2-->d1
             beq.s     polyl2
             bgt.s     dypos
             neg.w     d1
             move.l    #160,d3
             bra.s     polyl2
dypos:       move.l    #-160,d3

polyl2:      tst.w     d0
             bne.s     polyl3
             tst.w     d1
             beq.s     confondu

polyl3:      moveq.l   #0,d6                ;interchange … 0
             cmp.w     d0,d1                ;dy-dx
             ble.s     polyl4
             exg.l     d0,d1
             moveq.l   #1,d6                ;interchange … 1

polyl4:      move.w    d0,d7
             lsl.w     #1,d1                ;2*dy-->d1
             move.w    d1,d4
             sub.w     d0,d4                ;err=2*dy-dx
             lsl.w     #1,d0

polyloop:    
             tst.w     10(a6)               ;clip_line?
             beq.s     corl2
             cmp.w     20(a6),d5            ;clipping   (d5-cd017_6)
             blt.s     polyl5
             cmp.w     24(a6),d5            ;           (d5-clipxf)
             bgt.s     polyl5

             cmpa.l    12(a6),a3
             blt.s     polyl5
             cmpa.l    16(a6),a3
             bgt.s     polyl5               ;fin clipping
corl2:       
             bsr       affpt                ;afficher le point

polyl5:      cmpi.w    #0,d4                ;signe de l'erreur
             blt.s     polyl6
             tst.w     d6                   ;test de interchange
             beq.s     polyl7
             add.w     d2,d5                ;x+s1-->x
             bra.s     polyl8
polyl7:      adda.l    d3,a3                ;y+s2-->y
polyl8:      sub.w     d0,d4                ;err-2*dx-->err
             bra.s     polyl5

polyl6:      tst.w     d6                   ;test de interchange
             beq.s     polyl9
             adda.l    d3,a3                ;y+s2-->y
             bra.s     polyl10
polyl9:      add.w     d2,d5                ;x+s1-->x
polyl10:     add.w     d1,d4                ;err+2*dy-->err

             dbf       d7,polyloop
unpoint:     swap.w    d4
             dbf       d4,polyloop0

             rts       

confondu:              ;ici les 2 points sont confondus
             tst.w     10(a6)               ;clip_line?
             beq.s     corl1
             cmp.w     20(a6),d5            ;clipping   (d5-cd017_6)
             blt.s     unpoint
             cmp.w     24(a6),d5            ;           (d5-clipxf)
             bgt.s     unpoint

             cmpa.l    12(a6),a3
             blt.s     unpoint
             cmpa.l    16(a6),a3
             bgt.s     unpoint              ;fin clipping
corl1:       
             bsr       affpt
             bra.s     unpoint


;afficher un point
;la couleur doit etre s‚lectionn‚e,D5 contient l'abscisse X et
;A3 contient l'adresse de l'ordonn‚e Y:

affpt:       movem.l   d0-d3/d5,-(sp)       ;afficher le point
             movea.l   a3,a0
             move.w    d5,d0
             andi.w    #$fff0,d5            ;D5=X'+
             andi.w    #$f,d0
             lsl.w     #1,d0                ;D0=2*(B3,B2,B1,B0)1
             move.w    0(a4,d0.w),d2        ;D2=MASQUE OU ¶ GAUCHE
             move.w    32(a4,d0.w),d3       ;D3=MASQUE OU ¶ DROITE
             move.w    d2,d0
             not.w     d0                   ;D0=MASQUE ET ¶ GAUCHE
             move.w    d3,d1
             not.w     d1                   ;D1=MASQUE ET ¶ DROITE
             lsr.w     #1,d5                ;D5=X'1/2
             adda.l    d5,a0                ;A0=A3+X'1/2
             and.w     d2,d3
             or.w      d0,d1
couleurl:    
             .DC.l 0
             .DC.l 0
             movem.l   (sp)+,d0-d3/d5       ;fin de l'affichage du point
             rts       

             .DATA 

;;;table des masques OU … gauche:
masque:      
             .DC.w $ffff,$7fff,$3fff,$1fff,$0fff,$07ff,$03ff,$01ff
             .DC.w $00ff,$007f,$003f,$001f,$000f,$0007,$0003,$0001
;;;table des masques OU … droite:
             .DC.w $8000,$c000,$e000,$f000,$f800,$fc00,$fe00,$ff00
             .DC.w $ff80,$ffc0,$ffe0,$fff0,$fff8,$fffc,$fffe,$ffff

instruct:    
             .DC.w $c158,$c158,$c158,$c158  ;code 0
             .DC.w $8558,$c158,$c158,$c158  ;code 1
             .DC.w $c158,$8558,$c158,$c158  ;code 2
             .DC.w $8558,$8558,$c158,$c158  ;code 3
             .DC.w $c158,$c158,$8558,$c158  ;code 4
             .DC.w $8558,$c158,$8558,$c158  ;code 5
             .DC.w $c158,$8558,$8558,$c158  ;code 6
             .DC.w $8558,$8558,$8558,$c158  ;code 7
             .DC.w $c158,$c158,$c158,$8558  ;code 8
             .DC.w $8558,$c158,$c158,$8558  ;code 9
             .DC.w $c158,$8558,$c158,$8558  ;code 10
             .DC.w $8558,$8558,$c158,$8558  ;code 11
             .DC.w $c158,$c158,$8558,$8558  ;code 12
             .DC.w $8558,$c158,$8558,$8558  ;code 13
             .DC.w $c158,$8558,$8558,$8558  ;code 14
             .DC.w $8558,$8558,$8558,$8558  ;code 15

             .DC.w $0000,$0000,$0000,$0000  ;code 0
             .DC.w $ffff,$0000,$0000,$0000  ;code 1
             .DC.w $0000,$ffff,$0000,$0000  ;code 2
             .DC.w $ffff,$ffff,$0000,$0000  ;code 3
             .DC.w $0000,$0000,$ffff,$0000  ;code 4
             .DC.w $ffff,$0000,$ffff,$0000  ;code 5
             .DC.w $0000,$ffff,$ffff,$0000  ;code 6
             .DC.w $ffff,$ffff,$ffff,$0000  ;code 7
             .DC.w $0000,$0000,$0000,$ffff  ;code 8
             .DC.w $ffff,$0000,$0000,$ffff  ;code 9
             .DC.w $0000,$ffff,$0000,$ffff  ;code 10
             .DC.w $ffff,$ffff,$0000,$ffff  ;code 11
             .DC.w $0000,$0000,$ffff,$ffff  ;code 12
             .DC.w $ffff,$0000,$ffff,$ffff  ;code 13
             .DC.w $0000,$ffff,$ffff,$ffff  ;code 14
             .DC.w $ffff,$ffff,$ffff,$ffff  ;code 15



polyl_1::    
cd017_1::    .DC.w 10  ;nbre de pts du polygone
polyl_2::    
cd017_2::    .DC.l 0   ;adresse des pts du poly
polyl_3::    
cd017_3::    .DC.l 0   ;adresse de la m‚moire image

polyl_5::    
cd017_5::    .DC.w 0   ;indicateur de clipping
adrmin:      .DC.l 0   ;adrmin pour clipping
adrmax:      .DC.l 0   ;adrmax pour clipping

polyl_6::    
cd017_6::    .DC.w 0   ;fenetre de clipping
clipyd:      .DC.w 0
clipxf:      .DC.w 319
clipyf:      .DC.w 199

coulpoly:    .DC.w 0   ;code de la couleur de remplissage du polygone
polyl_4::    
cd017_4::    .DC.w 0   ;code de la couleur du trac‚ de la ligne

