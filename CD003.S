;---------------------------------------------------------------
;
; CD003
;
; affichage transparant d'un bloc avec clipping (au pixel pres)
;
; entree:  d0 x (signe)
;          d1 y (signe)
;          a1 adresse du sprite
;          cd003_1,cd003_2,cd003_3,cd003_4 coordonnees de la zone de clipping
;          (le sprite est au format GfA)

             .EXTERN sys01

             .TEXT 
puttcx::     
; entree:
;   a0.l adresse du sprite
;   a1.l adresse ecran
;          d0 x (signe)
;          d1 y (signe)
;          d2 taille x
;          d3 taille y
;          d4 largeur du buffer de destination
;          cd003_1,cd003_2,cd003_3,cd003_4 coordonnees de la zone de clipping

             move.w    d2,largeursource

             move.w    d2,d6                ; n_pix
             subq.w    #1,d6                ; n_pix-1 --> d6

             move.w    d3,d7                ; n_lin --> d7
             subq.w    #1,d7                ; n_lin-1 --> d7
             move.l    a1,sys01tempo
             movea.l   a0,a1
             move.w    d4,largeurdest
             bra       tronc_commun

puttc::      
cd003::      
             move.l    sys01,sys01tempo
             move.w    (a1)+,d6             ;n_pix-1-->d6
             move.w    (a1)+,d7             ;n_lin-1-->d7
             addq.l    #2,a1                ;a1 pointe les pixels du sprite
             move.w    #160,largeurdest
             move.w    d6,d2
             addq.w    #1,d2
             move.w    d2,largeursource
tronc_commun:          
             moveq.l   #0,d2
             lea.l     cd003_1,a5
             move.w    (a5),d2
             move.w    4(a5),d3
             sub.w     d0,d3                ;xf-X-->d3
             sub.w     d0,d2                ;xd-X-->d2
             ble.s     clips1
             sub.w     d2,d6                ;(n_pix-1)-(xd-X)-->d6
             blt       finclip
             move.w    (a5),d0              ;xd-->X
             move.w    4(a5),d3
             sub.w     d0,d3
             bra.s     clips2
clips1:      cmpi.w    #0,d3
             blt       finclip
clips2:      cmp.w     d3,d6                ;(n_pix-1)-(xf-X)
             ble.s     clips3
             move.w    d3,d6                ;(xf-X)-->(n_pix-1)
clips3:      move.w    6(a5),d5
             sub.w     d1,d5                ;yf-Y-->d5
             move.w    2(a5),d4
             sub.w     d1,d4                ;yd-Y-->d4
             ble.s     clips4
             sub.w     d4,d7                ;(n_lin-1)-(yd-Y)-->d7
             blt       finclip
             move.w    2(a5),d1             ;yd-->Y
             move.w    6(a5),d5
             sub.w     d1,d5
             bra.s     clips5
clips4:      cmpi.w    #0,d5
             blt       finclip
clips5:      cmp.w     d5,d7
             ble.s     clips6
             move.w    d5,d7                ;(yf-Y)-->(n_lin-1)
clips6:      
;a ce niveau:
;D0 contient X effectif
;D1 contient Y effectif
;D6 contient (n_pix-1) effectif
;D7 contient (n_lin-1) effectif
;si D2=(xd-X) est >0,il faut d‚caler … gauche les pixels de D2
;si D4=(yd-Y) est >0,il faut sauter les D4 prem. lignes de pixels

             movea.l   sys01tempo,a0        ;           movea.l  ad_log(pc),a0
;            ext.l    d1
;           move.l   d1,d3          ;D3=Y
;          asl.l    #7,d1          ;D1=128*Y
;         asl.l    #5,d3          ;D3=32*Y
;        add.l    d3,d1          ;D1=160*Y
             mulu.w    largeurdest,d1       ;;;;;;;;;;
             adda.w    d1,a0                ;       adda.l   d1,a0          ;A0=(ad_log)+160*Y
             move.w    d0,d3
             andi.w    #$fff0,d3
             lsr.w     #1,d3                ;D3=X'/2
             adda.w    d3,a0                ;A0=(ad_log)+160*Y+X'/2
             andi.w    #$f,d0

             moveq.l   #0,d3
             move.w    largeursource,d3
             subq.w    #1,d3
             andi.w    #$fff0,d3
             lsr.w     #1,d3
             addq.w    #8,d3

             cmpi.w    #0,d4                ;(yd-Y) est >0?
             ble.s     clips7
             mulu.w    d3,d4                ;(yd-Y) est >0
             adda.l    d4,a1                ;d‚caler de D4 lignes de pixels
clips7:      moveq.l   #0,d1
             cmpi.w    #0,d2                ;(xd-X) est >0?
             ble.s     clips8
             move.w    d2,d1                ;(xd-X) est >0 (clipping … gauche)
             andi.w    #$fff0,d2
             lsr.w     #1,d2
             adda.l    d2,a1                ;sauter 16 pix pour chaque d‚c … gauche de 16 bits
clips8:      

;a ce niveau:
;D0 contient le nbre de d‚calages … droite pour une ligne de pixels
;D1 contient le nbre de d‚calages … gauche pour une ligne de pixels
;D3.L=taille en octets d'une ligne de pixels du sprite
;D6 contient (n_pix-1) effectif
;D7 contient (n_lin-1) effectif
;A1 pointe sur la premiŠre ligne de pixels du sprite … afficher
;A0 pointe sur la m‚moire image

;  move.l   a0,(a2)+          ;sauver l'adresse du bloc … sauver
;;    movea.l  a2,a4             ;a4 pointe le nbre d'octets par ligne de pixels
;;  addq.l   #2,a2
; move.w   d7,(a2)+          ;sauver n_lin-1

             lea.l     mdroit,a3            ;a3 pointe sur la table des masques … droite
             addq.w    #1,d6                ;d6=n_pix
             move.w    d6,d5
             lsr.w     #4,d5                ;d5=(n_pix)'
             andi.w    #$f,d6               ;d6=(n_pix)''
             movea.l   d3,a5

             tst.w     d1
             bne       clippg
             tst.w     d0
             beq       deczer
;*****************************************************************************
;Cas du d‚calage … droite:

;a ce niveau:
;D0 contient le nbre de d‚calages … droite
;D1 contient le nbre de d‚calages … gauche pour une ligne de pixels
;A5 =taille en octets d'une ligne de pixels du sprite
;D5 contient (n_pix)' =quotient de (n_pix)/16
;D6 contient (n_pix)''=reste de (n_pix)/16
;D7 contient (n_lin-1) effectif
;A1 pointe sur la premiŠre ligne de pixels du sprite … afficher
;A0 pointe sur la m‚moire image
;A3 pointe sur la table des masques … droite
;A2 pointe sur l'espace m‚moire de sauvegarde de l'image


decdrt:                ;;  move.w   #0,(a4)
;   move.w   (a0),(a2)+        ;sauver les 16 premiers pixels
;  move.w   2(a0),(a2)+
; move.w   4(a0),(a2)+
; move.w   6(a0),(a2)+
;;           addq.w   #4,(a4)

             movem.l   d5/d6/a0/a1,-(sp)
             subq.w    #1,d5                ;(n_pix)'-1
             blt       decdrt2
decdrt1:     
             moveq.l   #0,d2                ;cas du d‚calage … droite
             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.
             swap.w    d2                   ;D2.L=masque,0

             lsr.l     d0,d2                ;d2 contient le masque du tr. sur 32b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt4:     move.w    (a0),d1              ;image-->d1
             swap.w    d1
             move.w    8(a0),d1             ;image 32b. -->d1.l
;   move.w   d1,(a2)+          ;sauver le mot
;; addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             swap.w    d4
             lsr.l     d0,d4                ;sprite d‚cal‚-->d4
             and.l     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.l     d2                   ;~masque
             and.l     d2,d1                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.l      d4,d1                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d1,8(a0)             ;va dans la m‚moire image
             swap.w    d1
             move.w    d1,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt4

             swap.w    d7                   ;restituer d7

             dbf       d5,decdrt1

decdrt2:     subq.w    #1,d6                ;(n_pix)''-1
             blt       decdrt3

             moveq.l   #0,d2
             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.
             lsl.w     #1,d6                ;offset pour trouver le masque … droite
             and.w     0(a3,d6.w),d2        ;masque ET masque … droite

             move.w    d6,d4
             add.w     d0,d4
             cmpi.w    #16,d4               ;nbre de d‚c.+(n_pix)''-16
             blt       decdrt5

             swap.w    d2                   ;ici [nbre de d‚c.+(n_pix)''] >ou= … 16
             lsr.l     d0,d2                ;d2 contient le masque du tr. sur 32b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt6:     move.w    (a0),d1              ;image-->d1
             swap.w    d1
             move.w    8(a0),d1             ;image 32b. -->d1.l
;    move.w   d1,(a2)+          ;sauver le mot
;;  addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             swap.w    d4
             lsr.l     d0,d4                ;sprite d‚cal‚-->d4
             and.l     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.l     d2                   ;~masque
             and.l     d2,d1                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.l      d4,d1                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d1,8(a0)             ;va dans la m‚moire image
             swap.w    d1
             move.w    d1,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt6

             swap.w    d7                   ;restituer d7

             bra.s     decdrt3

decdrt5:     lsr.w     d0,d2                ;d2 contient le masque du tr. sur 16b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt7:     move.w    (a0),d1              ;image-->d1
             move.w    (a1)+,d4             ;sprite-->d4
             lsr.w     d0,d4                ;sprite d‚cal‚-->d4
             and.w     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.w     d2                   ;~masque
             and.w     d2,d1                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.w      d4,d1                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d1,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt7

             swap.w    d7                   ;restituer d7

decdrt3:     movem.l   (sp)+,d5/d6/a0/a1
             adda.l    a5,a1                ;a1 pointe la ligne de pixels suivante
             adda.w    largeurdest,a0       ;a0 pointe la ligne image suivante
             dbf       d7,decdrt
             rts       

;fin du cas du d‚calage … droite
;*****************************************************************************
;Cas o— il n'y a pas de d‚calage:

;a ce niveau:
;A5 =taille en octets d'une ligne de pixels du sprite
;D5 contient (n_pix)' =quotient de (n_pix)/16
;D6 contient (n_pix)''=reste de (n_pix)/16
;D7 contient (n_lin-1) effectif
;A1 pointe sur la premiŠre ligne de pixels du sprite … afficher
;A0 pointe sur la m‚moire image
;A3 pointe sur la table des masques … droite
;A2 pointe sur l'espace m‚moire de sauvegarde de l'image

deczer:                ;;move.w   #0,(a4)
             movem.l   d5/d6/a0/a1,-(sp)
             subq.w    #1,d5                ;(n_pix)'-1
             blt       deczer2
deczer1:     
             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

deczer4:     move.w    (a0),d1              ;image-->d1
;    move.w   d1,(a2)+          ;sauver le mot
;;  addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             and.w     d2,d4                ;sprite ET masque
             move.w    d2,d0                ;sauver masque
             not.w     d2                   ;~masque
             and.w     d2,d1                ;image ET ~masque
             move.w    d0,d2                ;restituer masque
             or.w      d4,d1                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d1,(a0)+             ;va dans la m‚moire image
             dbf       d7,deczer4

             swap.w    d7                   ;restituer d7

             dbf       d5,deczer1

deczer2:     subq.w    #1,d6                ;(n_pix)''-1
             blt       deczer3

             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.
             lsl.w     #1,d6                ;offset pour trouver le masque … droite
             and.w     0(a3,d6.w),d2        ;masque ET masque … droite

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

deczer5:     move.w    (a0),d1              ;image-->d1
;     move.w   d1,(a2)+          ;sauver le mot
;;  addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             and.w     d2,d4                ;sprite ET masque
             move.w    d2,d0                ;sauver masque
             not.w     d2                   ;~masque
             and.w     d2,d1                ;image ET ~masque
             move.w    d0,d2                ;restituer masque
             or.w      d4,d1                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d1,(a0)+             ;va dans la m‚moire image
             dbf       d7,deczer5

             swap.w    d7                   ;restituer d7

deczer3:     movem.l   (sp)+,d5/d6/a0/a1
             adda.l    a5,a1                ;a1 pointe la ligne de pixels suivante
             adda.w    largeurdest,a0       ;a0 pointe la ligne image suivante
             dbf       d7,deczer
             rts       

;fin du cas o— il n'y a pas de d‚calage
;*****************************************************************************
clippg:      andi.w    #$f,d1

decdrtt:     

;Cas du d‚calage … droite et … gauche:

;a ce niveau:
;D0 contient le nbre de d‚calages … droite
;D1 contient le nbre de d‚calages … gauche pour une ligne de pixels
;A5 =taille en octets d'une ligne de pixels du sprite
;D5 contient (n_pix)' =quotient de (n_pix)/16
;D6 contient (n_pix)''=reste de (n_pix)/16
;D7 contient (n_lin-1) effectif
;A1 pointe sur la premiŠre ligne de pixels du sprite … afficher
;A0 pointe sur la m‚moire image
;A3 pointe sur la table des masques … droite
;A2 pointe sur l'espace m‚moire de sauvegarde de l'image


decdrt0:               ;;move.w   #0,(a4)
;   move.w   (a0),(a2)+        ;sauver les 16 premiers pixels
;  move.w   2(a0),(a2)+
; move.w   4(a0),(a2)+
;    move.w   6(a0),(a2)+
;;  addq.w   #4,(a4)

             movem.l   d5/d6/a0/a1,-(sp)
             subq.w    #1,d5                ;(n_pix)'-1
             blt       decdrt20
decdrt10:    
             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.
             swap.w    d2
             move.w    8(a1),d2             ;chercher le masque transparent sur 32b
             or.w      10(a1),d2
             or.w      12(a1),d2
             or.w      14(a1),d2            ;d2 contient le masque du transp. sur 32b.

             lsl.l     d1,d2
             clr.w     d2
             lsr.l     d0,d2                ;d2 contient le masque du tr. sur 32b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt40:    
             move.w    (a0),d3              ;image-->d3
             swap.w    d3
             move.w    8(a0),d3             ;image 32b. -->d3.l
;    move.w   d3,(a2)+          ;sauver le mot
;; addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             swap.w    d4
             move.w    6(a1),d4             ;sprite 32b. -->d4
             lsl.l     d1,d4
             tst.w     d0
             beq       ndec0
             lsr.l     d0,d4                ;sprite d‚cal‚-->d4
ndec0:       and.l     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.l     d2                   ;~masque
             and.l     d2,d3                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.l      d4,d3                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d3,8(a0)             ;va dans la m‚moire image
             swap.w    d3
             move.w    d3,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt40

             swap.w    d7                   ;restituer d7

             dbf       d5,decdrt10

decdrt20:    subq.w    #1,d6                ;(n_pix)''-1
             blt       decdrt30

             move.w    (a1),d2              ;chercher le masque transparent sur 16b
             or.w      2(a1),d2
             or.w      4(a1),d2
             or.w      6(a1),d2             ;d2 contient le masque du transp. sur 16b.
             swap.w    d2
             move.w    8(a1),d2             ;chercher le masque transparent sur 32b
             or.w      10(a1),d2
             or.w      12(a1),d2
             or.w      14(a1),d2            ;d2 contient le masque du transp. sur 32b.
             lsl.l     d1,d2
             clr.w     d2
             swap.w    d2

             lsl.w     #1,d6                ;offset pour trouver le masque … droite
             and.w     0(a3,d6.w),d2        ;masque ET masque … droite

             move.w    d6,d4
             add.w     d0,d4
             cmpi.w    #16,d4               ;nbre de d‚c.+(n_pix)''-16
             blt       decdrt50

             swap.w    d2                   ;ici [nbre de d‚c.+(n_pix)''] >ou= … 16
             tst.w     d0
             beq       ndec1
             lsr.l     d0,d2                ;d2 contient le masque du tr. sur 32b.
ndec1:       
             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt60:    move.w    (a0),d3              ;image-->d3
             swap.w    d3
             move.w    8(a0),d3             ;image 32b. -->d3.l
;   move.w   d3,(a2)+          ;sauver le mot
;;  addq.w   #1,(a4)
             move.w    (a1)+,d4             ;sprite-->d4
             swap.w    d4
             move.w    6(a1),d4             ;sprite 32b. -->d4
             lsl.l     d1,d4
             tst.w     d0
             beq       ndec2
             lsr.l     d0,d4                ;sprite d‚cal‚-->d4
ndec2:       and.l     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.l     d2                   ;~masque
             and.l     d2,d3                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.l      d4,d3                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d3,8(a0)             ;va dans la m‚moire image
             swap.w    d3
             move.w    d3,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt60

             swap.w    d7                   ;restituer d7

             bra.s     decdrt30

decdrt50:    lsr.w     d0,d2                ;d2 contient le masque du tr. sur 16b.

             swap.w    d7                   ;sauver d7
             move.w    #3,d7

decdrt70:    move.w    (a0),d3              ;image-->d3
             move.w    (a1)+,d4             ;sprite-->d4
             lsl.w     d1,d4
             tst.w     d0
             beq       ndec3
             lsr.w     d0,d4                ;sprite d‚cal‚-->d4
ndec3:       and.w     d2,d4                ;sprite ET masque
             movea.l   d2,a6                ;sauver masque
             not.w     d2                   ;~masque
             and.w     d2,d3                ;image ET ~masque
             move.l    a6,d2                ;restituer masque
             or.w      d4,d3                ;(sprite ET masque)OU(image ET ~masque)
             move.w    d3,(a0)+             ;va dans la m‚moire image
             dbf       d7,decdrt70

             swap.w    d7                   ;restituer d7

decdrt30:    movem.l   (sp)+,d5/d6/a0/a1
             adda.l    a5,a1                ;a1 pointe la ligne de pixels suivante
             adda.w    largeurdest,a0       ;a0 pointe la ligne image suivante
             dbf       d7,decdrt0
             rts       

;fin du cas du d‚calage … droite et … gauche
;*****************************************************************************
finclip:               ;clr.l    (a2)              ;indique pas de bloc sauv‚
             rts       

mdroit:      .DC.w $8000,$c000,$e000,$f000,$f800,$fc00,$fe00,$ff00
             .DC.w $ff80,$ffc0,$ffe0,$fff0,$fff8,$fffc,$fffe,$ffff



puttc_1::    
cd003_1::    .DC.w 0   ;fenetre de clipping du sprite
puttc_2::    
cd003_2::    .DC.w 0
puttc_3::    
cd003_3::    .DC.w 319
puttc_4::    
cd003_4::    .DC.w 199




             .BSS 

buffer:      .DS.w 4
sys01tempo:  
             .DS.l 1
largeurdest: .DS.w 1
largeursource:         .DS.w 1

             .END 


