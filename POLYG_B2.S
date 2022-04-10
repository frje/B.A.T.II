;---------------------------------------------------------------
;
; POLYG       25/05/90
;
; Remplissage d'un polygone avec clipping en option
;
; entree:(variables … d‚finir)
;
;             polyg_1.w nombre de points du polygone
;             polyg_2.l adresse de points (prevoir un mot de + dans le buffer)
;             polyg_4.w couleur
;             polyg_5.w clipping on/off (1 on, 0 off)
;             polyg_6 (4 mots) coordonnees pour clipping (eventuellement)
;

;NOTES:

;1) le nombre maximal de points du polygone est d‚fini par l'‚quivalence
;   "npmax equ 40" par d‚faut. Ceci d‚finit aussi la taille de la zone
;   m‚moire n‚cessaire: taille m‚moire = (16*npmax + 26) octets.
;2) ne remplit pas si le polygone est r‚duit … une ligne horizontale
;3) les autres variables utilis‚es sont adrmin et adrmax (longs_mots)
;4) les coordonn‚es de la fenetre doivent etre positives;et dans l'‚cran!
;5) tous les registres sont utilis‚s
;6) ne remplit pas si le polygone n'est pas constitu‚ d'au moins 3 points


             .EXTERN sys01

             .TEXT 

cd016::      
polyg::      
             lea.l     cd016_3,a0
             move.l    sys01,(a0)
             lea.l     cd016_1,a6
             movea.l   2(a6),a0             ;A0 pointe les points du polygone
             move.w    (a6),d7              ;D7.W  contient le nbre de points

             cmpi.w    #2,d7                ;il faut au moins 3 points
             ble       finpolyg

             tst.w     10(a6)               ;cd016_5
             beq.s     nonclipp
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
nonclipp:    

;terminer la liste de points par le 1er point:
poly_0:      
             move.w    d7,d0
             lsl.w     #2,d0
             move.l    (a0),0(a0,d0.w)

polygone:    

;s‚lectionne la couleur du polygone:
             move.w    28(a6),d0            ;D0 contient le code de la couleur
             lea.l     instruct,a1          ;A1 pointe les instructions
             lea.l     couleura,a2
             lsl.w     #3,d0                ;D0 est index
             move.l    0(a1,d0.w),d1
             move.l    d1,(a2)+
             move.l    4(a1,d0.w),d2
             move.l    d2,(a2)
             lea.l     128(a1),a1           ;adda.l   #128,a1
             lea.l     remplirr,a2
             move.w    0(a1,d0.w),2(a2)
             move.w    2(a1,d0.w),6(a2)
             move.w    4(a1,d0.w),10(a2)
             move.w    6(a1,d0.w),14(a2)
             lea.l     finircol,a2
             addi.l    #$02000200,d1
             addi.l    #$02000200,d2
             move.l    d1,(a2)+
             move.l    d2,(a2)
;fin de s‚lection de la couleur

;cr‚ation de la table des cot‚s tri‚e:
;A0 pointe les points, D7 contient le nbre de points (ou de cot‚s)
;utilise D0 … D5, A0 conserv‚ et A2=TBLCOTR conserv‚
;en fin de cette routine, D7 contient le nbre de cot‚s non horizontaux

cottrie:     lea.l     tblcotr,a2
             move.w    d7,d0                ;D0=npts
;cr‚ation de la table des cot‚s tri‚e:
             move.w    #$8000,-14(a2)       ;Ymin virtuel … $8000
             subq.w    #1,d0                ;D0=npts-1
             moveq.l   #0,d3                ;D3 contient le nbre de cot‚s stock‚s *14
create1:     
             move.w    d3,d4
             move.w    (a0)+,d1             ;D1=X1
             move.w    (a0)+,d2             ;D2=Y1
             sub.w     (a0),d1              ;D1=X1-X2
             blt.s     dxneg
             sub.w     2(a0),d2             ;D2=Y1-Y2
             beq       create5              ;laisser tomber cot‚s horiz.
             blt.s     dyneg
;ici DX et DY sont >0
             move.w    2(a0),d5             ;Ymin dans D5
;classer le cot‚ :
debtri1:     
             cmp.w     -14(a2,d4.w),d5      ;Ymin-Yminpr‚c‚dent
             bge.s     fintri1
             subi.w    #14,d4
             move.l    0(a2,d4.w),14(a2,d4.w)     ;d‚caler 4 octets
             move.l    4(a2,d4.w),18(a2,d4.w)     ;d‚caler 4 octets
             move.l    8(a2,d4.w),22(a2,d4.w)     ;d‚caler 4 octets
             move.w    12(a2,d4.w),26(a2,d4.w)    ;d‚caler 2 octets
             bra.s     debtri1
fintri1:     
;fin de classement du cot‚
             move.w    #1,12(a2,d4.w)       ;signe de DX >0
             bra.s     create4
dxneg:       
             sub.w     2(a0),d2             ;D2=Y1-Y2
             beq       create5              ;laisser tomber cot‚s horiz.
             blt.s     dyneg2
;ici DX<0 et DY>0
             neg.w     d1                   ;D1=|X2-X1|
             move.w    2(a0),d5             ;Ymin dans D5
;classer le cot‚ :
debtri3:     
             cmp.w     -14(a2,d4.w),d5      ;Ymin-Yminpr‚c‚dent
             bge.s     fintri3
             subi.w    #14,d4
             move.l    0(a2,d4.w),14(a2,d4.w)     ;d‚caler 4 octets
             move.l    4(a2,d4.w),18(a2,d4.w)     ;d‚caler 4 octets
             move.l    8(a2,d4.w),22(a2,d4.w)     ;d‚caler 4 octets
             move.w    12(a2,d4.w),26(a2,d4.w)    ;d‚caler 2 octets
             bra.s     debtri3
fintri3:     
;fin de classement du cot‚
             move.w    #-1,12(a2,d4.w)      ;signe de DX <0
create4:     
             move.w    d5,0(a2,d4.w)        ;stocker Ymin
             move.w    -2(a0),2(a2,d4.w)    ;stocker Ymax
             move.w    (a0),4(a2,d4.w)      ;stocker Xymin
             bra.s     create2
dyneg:                 ;ici DX>0 et DY<0
             move.w    -2(a0),d5            ;Ymin dans D5
;classer le cot‚ :
debtri2:     
             cmp.w     -14(a2,d4.w),d5      ;Ymin-Yminpr‚c‚dent
             bge.s     fintri2
             subi.w    #14,d4
             move.l    0(a2,d4.w),14(a2,d4.w)     ;d‚caler 4 octets
             move.l    4(a2,d4.w),18(a2,d4.w)     ;d‚caler 4 octets
             move.l    8(a2,d4.w),22(a2,d4.w)     ;d‚caler 4 octets
             move.w    12(a2,d4.w),26(a2,d4.w)    ;d‚caler 2 octets
             bra.s     debtri2
fintri2:     
;fin de classement du cot‚
             move.w    #-1,12(a2,d4.w)      ;signe de DX >0
             bra.s     create3
dyneg2:                ;ici DX<0 et DY<0
             neg.w     d1                   ;D1=|X2-X1|
             move.w    -2(a0),d5            ;Ymin dans D5
;classer le cot‚ :
debtri4:     
             cmp.w     -14(a2,d4.w),d5      ;Ymin-Yminpr‚c‚dent
             bge.s     fintri4
             subi.w    #14,d4
             move.l    0(a2,d4.w),14(a2,d4.w)     ;d‚caler 4 octets
             move.l    4(a2,d4.w),18(a2,d4.w)     ;d‚caler 4 octets
             move.l    8(a2,d4.w),22(a2,d4.w)     ;d‚caler 4 octets
             move.w    12(a2,d4.w),26(a2,d4.w)    ;d‚caler 2 octets
             bra.s     debtri4
fintri4:     
;fin de classement du cot‚
             move.w    #1,12(a2,d4.w)       ;signe de DX <0
create3:     
             neg.w     d2                   ;D2=|Y2-Y1|
             move.w    d5,0(a2,d4.w)        ;stocker Ymin
             move.w    2(a0),2(a2,d4.w)     ;stocker Ymax
             move.w    -4(a0),4(a2,d4.w)    ;stocker Xymin
create2:     
             lsl.w     #1,d1                ;D1=2*|X2-X1|
             move.w    d1,6(a2,d4.w)        ;2*D(X) stock‚
             sub.w     d2,d1
             neg.w     d1
             move.w    d1,10(a2,d4.w)       ;ERR stock‚e
             lsl.w     #1,d2                ;D2=2*|Y2-Y1|
             move.w    d2,8(a2,d4.w)        ;2*D(Y) stock‚
             addi.w    #14,d3               ;incr‚m. le nbre de cot‚s stock‚s
             dbf       d0,create1
             bra.s     createact00
create5:     
             subq.w    #1,d7
             dbf       d0,create1
;ici D7.W contient le nombre de cot‚s non horizontaux
createact00: 
             move.w    #$7fff,0(a2,d3.w)    ;finir la table
;fin de la cr‚ation de la table des cot‚s tri‚e

             cmpi.w    #0,d7                ;pas d'‚l‚ments non horizontaux?
             ble       finpolyg

;;;rechercher le max des Ymax des cot‚s:
             lea.l     tblcota,a1
             move.w    d7,d2
             moveq.l   #0,d5                ;D5 est registre d'index
             subq.w    #1,d2                ;D2=nbr de cot‚s -1
             move.w    2(a2,d5.w),d1
rechmax0:    
             cmp.w     2(a2,d5.w),d1        ;Ymax-Ymax du cot‚ actif
             bge.s     rechmax1
             move.w    2(a2,d5.w),d1
rechmax1:    
             addi.w    #14,d5
             dbf       d2,rechmax0
             move.w    d1,d6                ;D6=MAX(Ymax)
             ext.l     d6
             move.l    d6,d5                ;D5=MAX(Ymax)
             asl.w     #7,d6                ;D6=128*Y
             asl.w     #5,d5                ;D5=32*Y
             add.l     d5,d6                ;D6=160*MAX(Ymax)
             movea.l   6(a6),a0
             move.l    a0,d0
             add.l     d6,d0
             move.l    d0,-12(a2)           ;ordonn‚e MAX de l'‚cran stock‚e
;;;fin de la rech. du max des Ymax des cot‚s
;origine des coordonn‚es et ordonn‚e initiale de l'‚cran:
             move.w    (a2),d6              ;D6=Y
             ext.l     d6
             move.l    d6,d5                ;D5=Y
             asl.w     #7,d6                ;D6=128*Y
             asl.w     #5,d5                ;D5=32*Y
             add.l     d5,d6                ;D6=160*Y
             adda.l    d6,a0                ;A0=A0+160*Y
             movea.l   a0,a3
;ici A0 et A3 pointent l'origine  des ordonn‚es
             cmpa.l    -12(a2),a0
             beq       finpolyg

;Cr‚ation de la table des cot‚s actifs:
;A1 pointe TBLCOTA et A2 pointe TBLCOTR
createact:   
             moveq.l   #0,d4                ;D4.W est l'offset/A2 de l'‚l‚ment non encore actif
             move.w    d7,d5                ;D5.W =nbre de cot‚s non encore activ‚s
             moveq.l   #0,d3                ;D3=nbre de cot‚s actifs *2
             move.w    2(a2,d4.w),d1        ;D1=MIN(Ymax) initialis‚
createact0:  
             addq.l    #2,d3                ;D3=nbre de cot‚s actifs *2
             move.w    d4,6(a1,d3.w)        ;OFF de l'‚l‚ment actif stock‚
             addi.w    #14,d4               ;pointer vers l'‚l‚ment non encore actif suivant
             addq.l    #2,d3                ;D3=nbre de cot‚s actifs *2
             move.w    d4,6(a1,d3.w)        ;OFF de l'‚l‚ment actif stock‚
             addi.w    #14,d4               ;pointer vers l'‚l‚ment non encore actif suivant
             subq.w    #2,d5                ;2 cot‚s actifs en moins
             cmp.w     -12(a2,d4.w),d1      ;comparer le Ymax au MIN(Ymax)
             ble.s     createact2           ;D1 est toujours =  MIN(Ymax)
             move.w    -12(a2,d4.w),d1      ;D1=MIN(Ymax des cot‚s actifs)
createact2:  
             move.w    0(a2,d4.w),d2        ;D2 contient Ymin suivant
             cmp.w     -14(a2,d4.w),d2      ;Yminsuivant-cot‚ activ‚
             bne.s     createact1
             cmpi.w    #2,d5
             bge.s     createact0
createact1:  
             move.w    d1,2(a1)             ;MIN(Ymax) stock‚
             move.w    d3,6(a1)             ;nbre de cot‚s actifs *2 stock‚
             lsr.w     #1,d3                ;D3 contient nbre de cot‚s actifs
             sub.w     d3,d7                ;D7.W =nbre de cot‚s non encore activ‚s -1
             cmp.w     d1,d2                ;Ymin suivant - MIN(Ymax des cot‚s actifs)
             bge.s     yfmin
             move.w    d2,d1
yfmin:       
             move.w    d1,-2(a1)            ;Yf stock‚
             sub.w     (a2),d1
             move.w    d1,(a1)              ;D(Yf) stock‚

;fin de cr‚ation de la table des ‚l‚ments actifs
;D7.W =nbre de cot‚s non encore activ‚s
;D4.W est l'offset/A2 de l'‚l‚ment non encore actif

polygone1:   
             move.w    (a1),d0
             subq.w    #1,d0                ;D0=nbre de scan lines -1
             bmi       majtblact
polygone2:   
             move.w    d0,-(sp)             ;sauver D0
             bsr       trix
;***********tracer pour une scan line:
             lea.l     masque,a4            ;A4 pointe la table des masques pour le coloriage
             move.w    6(a1),d1
             lsr.w     #2,d1
             subq.w    #1,d1                ;D1=nbre de couples de cot‚s actifs -1
             moveq.l   #0,d2                ;D2 est registre d'index
colorierr:   
             bsr       colorier
;************fin du trac‚ pour une scan line
             addq.w    #4,d2                ;incr‚menter l'index pour le couple de cot‚s actifs suivant
             dbf       d1,colorierr
;erreur1:
;passer … la Scan Ligne suivante:
             lea.l     160(a3),a3           ;adda.l   #160,a3
             movea.l   a3,a0                ;reformer A0
;appliquer Bresenham aux cot‚s actifs:
             move.w    6(a1),d1
             lsr.w     #1,d1
             subq.w    #1,d1                ;D1=nbre de cot‚s actifs -1
             moveq.l   #0,d2                ;D2 est registre d'index
bresen2:     
             move.w    8(a1,d2.w),d0
bresen0:     
             cmpi.w    #0,10(a2,d0.w)       ;ERR?
bresen00:    
             bge.s     bresen1
             move.w    12(a2,d0.w),d3       ;SENS dans D3
             add.w     d3,4(a2,d0.w)        ;X mis … jour
             move.w    8(a2,d0.w),d3        ;2-D(Y) dans D3
             add.w     d3,10(a2,d0.w)       ;ERR mise … jour
             bra.s     bresen00
bresen1:     
             move.w    6(a2,d0.w),d3        ;2*D(X) dans D3
             sub.w     d3,10(a2,d0.w)       ;ERR mise … jour
             addq.w    #2,d2                ;incr. reg. d'index
             dbf       d1,bresen2
;fin de Bresenham
             move.w    (sp)+,d0             ;restituer D0
             cmpa.l    -12(a2),a3           ;la derniŠre ligne doit etre trac‚e?
             beq       polygone3
             dbf       d0,polygone2
;****************Mise … jour de la table des cot‚s actifs:
majtblact:   
;Quels sont les cot‚s qui se d‚sactivent?
             move.w    0(a2,d4.w),d2
             move.w    2(a1),d1             ;D1=MIN(Ymax)
             cmp.w     d1,d2                ;Yminsuivant-MIN(Ymax)
             bcs.s     actcot
;ici des cot‚s se d‚sactivent:
             move.w    6(a1),d3
             move.w    d3,d5                ;D5 est registre d'index
             lsr.w     #1,d3
             subq.w    #1,d3                ;D3=nbr de cot‚s actifs -1
desact0:     
             move.w    6(a1,d5.w),d0
             cmp.w     2(a2,d0.w),d1        ;MIN(Ymax) - Ymax du cot‚ actif
             bne.s     desact1
             move.w    6(a1),d0
             sub.w     d5,d0
             beq.s     desact2
             lsr.w     #1,d0
             subq.w    #1,d0                ;D0 contient le nbr de mots -1 … d‚caler
             bmi.s     desact2
             move.w    d5,d6                ;D6 est reg. d'index pour le d‚calage
desact3:     
             move.w    8(a1,d6.w),6(a1,d6.w)      ;un cot‚ actif d‚cal‚
             addq.w    #2,d6                ;additionner 2 au reg. d'index
             dbf       d0,desact3
desact2:     
             subi.w    #2,6(a1)             ;1 cot‚ actif de moins
desact1:     
             subq.w    #2,d5
             dbf       d3,desact0
;ici sont d‚sactiv‚s les cot‚s qui le doivent
             cmp.w     d1,d2                ;Yminsuivant-MIN(Ymax)pr‚c‚dent
             bne.s     finactiv0
actcot:                ;quels sont les cot‚s qui s'activent?
actcot1:     
             move.w    d7,d5                ;D5.W =nbre de cot‚s non encore activ‚s
             subq.w    #1,d5                ;D5.W =nbre de cot‚s non encore activ‚s -1
             move.w    6(a1),d3
creatact0:   
             addq.l    #2,d3                ;D3=nbre de cot‚s actifs *2
             subq.w    #1,d7                ;D7.W =nbre de cot‚s non encore activ‚s
             move.w    d4,6(a1,d3.w)        ;OFF de l'‚l‚ment actif stock‚
             addi.w    #14,d4               ;pointer vers l'‚l‚ment non encore actif suivant
             move.w    0(a2,d4.w),d2
             cmp.w     -14(a2,d4.w),d2      ;Yminsuivant-cot‚ activ‚
             bne.s     creatact1
             dbf       d5,creatact0
creatact1:   
             move.w    d3,6(a1)             ;nbre de cot‚s actifs *2 stock‚
finactiv0:   
;;;rechercher le min des Ymax des cot‚s actifs :
             move.w    6(a1),d3
             move.w    d3,d5                ;D5 est registre d'index
             lsr.w     #1,d3
             subq.w    #1,d3                ;D3=nbr de cot‚s actifs -1
             move.w    #$7fff,d1
rechmin0:    
             move.w    6(a1,d5.w),d0
             cmp.w     2(a2,d0.w),d1        ;Ymax-Ymax du cot‚ actif
             ble.s     rechmin1
             move.w    2(a2,d0.w),d1
rechmin1:    
             subq.w    #2,d5
             dbf       d3,rechmin0
             move.w    d1,2(a1)             ;MIN(Ymax) stock‚
;;;fin de la rech. du min des Ymax des cot‚s actifs
;stocker Yf:
             move.w    0(a2,d4.w),d2
             cmp.w     2(a1),d2             ;Yminsuivant-MIN(Ymax)
             bcs.s     finactiv1
             move.w    2(a1),d2
finactiv1:             ;D2 contient Yf
             move.w    d2,d0
             sub.w     -2(a1),d0
             move.w    d0,(a1)              ;D(Yf) stock‚
             move.w    d2,-2(a1)            ;Yf stock‚
             bra       polygone1
;fin de mise … jour de la table des ‚l‚ments actifs
;D7.W =nbre de cot‚s non encore activ‚s
;D4.W est l'offset/A2 de l'‚l‚ment non encore actif
;********************fin de mise … jour de la table des cot‚s actifs
polygone3:   
;ici tous les cot‚s ont ‚t‚ activ‚s,il n'y a plus qu'une ligne … tracer
             bsr       trix
             lea.l     masque,a4            ;A4 pointe la table des masques pour le coloriage
             move.w    6(a1),d1
             lsr.w     #2,d1
             subq.w    #1,d1                ;D1=nbre de couples de cot‚s actifs -1
             moveq.l   #0,d2                ;D2 est registre d'index
colorirr:    
             bsr       colorier
             addq.w    #4,d2                ;incr‚menter l'index pour le couple de cot‚s actifs suivant
             dbf       d1,colorirr
finpolyg:    
             rts       

;Trier la table des cot‚s actifs selon le sens des X croissants:
trix:        move.l    a0,-(sp)
;          cmpi.w    #0,4(a1)  ;Indic de tri=0?
;          bne       FINTRIX
;          move.w    #1,4(a1)  ;tri suppos‚ fini
             move.w    6(a1),d5
             lsr.w     #1,d5
             subq.w    #1,d5                ;D5 contient le nbre total de cot‚s … trier -1
             movea.l   a1,a5
             addq.l    #8,a5                ;A5 pointe le d‚but de la table … trier
trix1:       
             movea.l   a5,a4                ;A4 est chercheur du minimum
             movea.l   a5,a0                ;A0 d‚finit la position du minimum
             move.w    d5,d1                ;D1 contient le nbre de cot‚s … trier -1
             move.w    #$7fff,d3
trix2:       
             move.w    (a4)+,d0
             cmp.w     4(a2,d0.w),d3
             ble.s     trix3
             movea.l   a4,a0                ;position d‚finie
             move.w    4(a2,d0.w),d3        ;D3 prend la valeur du Xmin
             bra.s     trix5
trix3:       
             bne.s     trix5
trix4:       
             move.w    #0,4(a1)             ;0-->Indic de tri
trix5:       
             dbf       d1,trix2
             subq.l    #2,a0
             move.w    (a0),d0              ;sauver dans D0 l'OFF du mini
             move.l    a0,d1
             sub.l     a5,d1                ;D1=Position du mini - D‚part
             beq.s     trix6
             lsr.w     #1,d1
             subq.w    #1,d1                ;D1=nbre de mots … d‚caler -1
             moveq.l   #0,d2                ;D2 est registre d'index
trix7:       
             move.w    -2(a0,d2.w),0(a0,d2.w)
             subq.w    #2,d2
             dbf       d1,trix7
trix6:       
             move.w    d0,(a5)+             ;classer l'offset du mini et incr‚. A5
             dbf       d5,trix1
fintrix:     movea.l   (sp)+,a0
             rts       
;fin du tri de la table selon les X croissants

;***********tracer pour une scan line:
;Colorier une ligne de pixels d‚finie par X+ et X- (Sous-Programme):
;DONNEES:A0=A3 contient l'ordonn‚e Y;A4 pointe le masque
;utilise D0 … D6 sauf D4
colorier:    
             movem.w   d1/d2,-(sp)          ;sauver D1 et D2
             moveq.l   #0,d5
             move.w    8(a1,d2.w),d0
             move.w    4(a2,d0.w),d5        ;D5=X-
             move.w    10(a1,d2.w),d0
             move.w    4(a2,d0.w),d6        ;D6=X+
             tst.w     10(a6)               ;cd016_5
             beq.s     corr3
             cmp.w     20(a6),d5            ;clipping
             bge.s     corr1
             move.w    20(a6),d5
corr1:       
             cmp.w     24(a6),d5
             bgt.s     fincolor
             cmp.w     24(a6),d6
             ble.s     corr2
             move.w    24(a6),d6
corr2:       
             cmp.w     20(a6),d6
             blt.s     fincolor

             cmpa.l    12(a6),a3
             blt.s     fincolor
             cmpa.l    16(a6),a3
             bgt.s     fincolor             ;fin clipping
corr3:       
             move.w    d5,d0
             move.w    d6,d1
             andi.w    #$fff0,d5            ;D5=X'+
             andi.w    #$fff0,d6            ;D6=X'-
             andi.w    #$f,d0
             lsl.w     #1,d0                ;D0=2*(B3,B2,B1,B0)1
             andi.w    #$f,d1
             lsl.w     #1,d1                ;D1=2*(B3,B2,B1,B0)2
             move.w    0(a4,d0.w),d2        ;D2=MASQUE OU ¶ GAUCHE
             move.w    32(a4,d1.w),d3       ;D3=MASQUE OU ¶ DROITE
             move.w    d2,d0
             not.w     d0                   ;D0=MASQUE ET ¶ GAUCHE
             move.w    d3,d1
             not.w     d1                   ;D1=MASQUE ET ¶ DROITE
             sub.w     d5,d6                ;D6=X'2-X'1=DELTAX
             lsr.w     #4,d6
             beq.s     uneligne
             lsr.w     #1,d5                ;D5=X'1/2
             adda.l    d5,a0                ;A0=A3+X'1/2
;colorier 16 pixels
couleura:    
             .DC.l 0
             .DC.l 0
;fin du coloriage des 16 pixels
             subq.w    #1,d6                ;DELTAX-1
             beq.s     finircol
             subq.w    #1,d6
remplirr:    
;colorier 16 pixels
             .DC.w $30fc
             .DC.w 0
             .DC.w $30fc
             .DC.w 0
             .DC.w $30fc
             .DC.w 0
             .DC.w $30fc
             .DC.w 0
;fin du coloriage des 16 pixels
             dbf       d6,remplirr
finircol:    
;colorier 16 pixels
             .DC.l 0
             .DC.l 0
;fin du coloriage des 16 pixels
fincolor:    
             movea.l   a3,a0                ;reformer A0
             movem.w   (sp)+,d1/d2          ;restituer D1 et D2
             rts       
;************fin du trac‚ pour une scan line

uneligne:              ;cas d'un seul mot
             lsr.w     #1,d5                ;D5=X'1/2
             adda.l    d5,a0                ;A0=A3+X'1/2
             and.w     d2,d3
             or.w      d0,d1
             bra.s     finircol

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

;Equivalences pour poly_fill:

npmax        equ 40    ;nbre de pts max d'un polygone

;Variables pour poly_fill et poly_line:
;(note:les variables doivent rester dans cet ordre)

polyg_1::    
cd016_1::    .DC.w 10  ;nbre de pts du polygone
polyg_2::    
cd016_2::    .DC.l 0   ;adresse des pts du poly
polyg_3::    
cd016_3::    .DC.l 0   ;adresse de la m‚moire image

polyg_5::    
cd016_5::    .DC.w 0   ;indicateur de clipping
adrmin:      .DC.l 0   ;adrmin pour clipping
adrmax:      .DC.l 0   ;adrmax pour clipping
polyg_6::    
cd016_6::    .DC.w 0   ;fenetre de clipping
clipyd:      .DC.w 0
clipxf:      .DC.w 319
clipyf:      .DC.w 199

polyg_4::    
cd016_4::    .DC.w 0   ;code de la couleur de remplissage du polygone

;fin des variables pour poly_fill

             .BSS 

;M‚moire pour poly_fill:

             .DS.w 7   ;ligne r‚serv‚e
tblcotr:     
             .DS.w npmax*7
             .DS.w 1   ;1 mot r‚serv‚ pour finir la table
             .DS.w 1   ;1 mot r‚serv‚ ici pour Yf
tblcota:     
             .DS.w npmax+4



