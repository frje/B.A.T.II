;---------------------------------------------------------------
;
; text
;
; affichage transparent d'un texte de petite taille
;
; entree:  a0 adresse de la chaine de caractere
;          d0 longueur de la chaine
;          d1 pos x
;          d2 pos y
;          d3 couleur
;

;textx

text::       
cd009::      
             movea.l   sys01,a1
             lea.l     auto_mod(pc),a2
             btst      #0,d3
             beq       and1
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test1:       btst      #1,d3
             beq       and2
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test2:       btst      #2,d3
             beq       and3
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test3:       btst      #3,d3
             beq       and4
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
retour:      subq.w    #1,d0
             swap.w    d0
             move.w    d1,d0
             andi.w    #$f,d0
             swap.w    d0
             mulu.w    #160,d2
             andi.w    #$fff0,d1
             lsr.w     #1,d1
             add.w     d1,d2
             adda.l    d2,a1                ;[a1] adresse ecran debut texte
             lea.l     font(pc),a2
             moveq.l   #0,d2
             moveq.l   #0,d3
             moveq.l   #0,d4
             moveq.l   #0,d5
             moveq.l   #0,d6
             moveq.l   #0,d7

boucle:      
             swap.w    d0
             clr.w     d1
             move.b    (a0)+,d1
             subi.w    #' ',d1
             mulu.w    #6,d1
             movea.l   a2,a3
             adda.l    d1,a3                ;[a3] adresse caractere
             or.b      (a3)+,d2
             or.b      (a3)+,d3
             or.b      (a3)+,d4
             or.b      (a3)+,d5
             or.b      (a3)+,d6
             or.b      (a3)+,d7
             addq.w    #6,d0
             cmpi.w    #16,d0
             bge.s     affi

decal:       lsl.l     #6,d2
             lsl.l     #6,d3
             lsl.l     #6,d4
             lsl.l     #6,d5
             lsl.l     #6,d6
             lsl.l     #6,d7
             swap.w    d0
             dbra      d0,boucle

             swap.w    d0
             neg.w     d0
             addi.w    #16,d0
             lsr.l     #6,d2
             lsl.w     d0,d2
             lsr.l     #6,d3
             lsl.w     d0,d3
             lsr.l     #6,d4
             lsl.w     d0,d4
             lsr.l     #6,d5
             lsl.w     d0,d5
             lsr.l     #6,d6
             lsl.w     d0,d6
             lsr.l     #6,d7
             lsl.w     d0,d7
             move.w    d2,d1
             bsr.s     affi3
             move.w    d3,d1
             bsr.s     affi3
             move.w    d4,d1
             bsr.s     affi3
             move.w    d5,d1
             bsr.s     affi3
             move.w    d6,d1
             bsr.s     affi3
             move.w    d7,d1
             bsr.s     affi3
             rts       

affi:        subi.w    #16,d0
             move.l    d2,d1
             bsr.s     affi2
             move.l    d3,d1
             bsr.s     affi2
             move.l    d4,d1
             bsr.s     affi2
             move.l    d5,d1
             bsr.s     affi2
             move.l    d6,d1
             bsr.s     affi2
             move.l    d7,d1
             bsr.s     affi2
             suba.l    #6*160-8,a1
             move.w    #-1,d1
             lsl.w     d0,d1
             not.w     d1
             and.w     d1,d2
             and.w     d1,d3
             and.w     d1,d4
             and.w     d1,d5
             and.w     d1,d6
             and.w     d1,d7
             bra       decal

affi2:       lsr.l     d0,d1
affi3:       move.w    d0,-(sp)
             move.w    d1,d0
             not.w     d0
auto_mod:    or.w      d1,(a1)+             ;  and.w d0,(a1)+  automodifie
             or.w      d1,(a1)+             ;             "
             or.w      d1,(a1)+             ;             "
             or.w      d1,(a1)+             ;             "
             lea.l     152(a1),a1           ;adda.l   #160-8,a1
             move.w    (sp)+,d0
             rts       

and1:        move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test1
and2:        move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test2
and3:        move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test3
and4:        move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       retour

;---------------------------------------------------------------
;
; textx (fonction text etendue)
;
; affichage transparent d'un texte de petite taille
;
; entree:  a0 adresse de la chaine de caractere
;          (la chaine doit se terminer par un 0)
;          a1 adresse du buffer
;          d1 pos x
;          d2 pos y
;          d3 couleur
;          d4 largeur du buffer (nb d'octets par ligne)
;
; retour:  d0 nombre de caracteres affiches
;

textx::      
             movea.l   a0,a6
             move.w    d4,largbuf
             move.w    d4,d5
             mulu.w    #6,d5
             subq.w    #8,d5
             move.w    d5,largbuff6m8
             subq.w    #8,d4
             move.w    d4,largbufm8

             lea.l     auto_modx(pc),a2
             btst      #0,d3
             beq       and1x
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test1x:      btst      #1,d3
             beq       and2x
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test2x:      btst      #2,d3
             beq       and3x
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
test3x:      btst      #3,d3
             beq       and4x
             move.w    #%1000001101011001,(a2)+   ; or.w d1,(a1)+
retourx:     subq.w    #1,d0
             move.w    d1,d0
             andi.w    #$f,d0
             mulu.w    largbuf,d2
             andi.w    #$fff0,d1
             lsr.w     #1,d1
             add.w     d1,d2
             adda.l    d2,a1                ;[a1] adresse ecran debut texte
             lea.l     font(pc),a2
             moveq.l   #0,d2
             moveq.l   #0,d3
             moveq.l   #0,d4
             moveq.l   #0,d5
             moveq.l   #0,d6
             moveq.l   #0,d7

bouclex:     
             clr.w     d1
             move.b    (a0)+,d1
             beq       fintx
             subi.w    #' ',d1
             mulu.w    #6,d1
             movea.l   a2,a3
             adda.l    d1,a3                ;[a3] adresse caractere
             or.b      (a3)+,d2
             or.b      (a3)+,d3
             or.b      (a3)+,d4
             or.b      (a3)+,d5
             or.b      (a3)+,d6
             or.b      (a3)+,d7
             addq.w    #6,d0
             cmpi.w    #16,d0
             bge.s     affix

decalx:      lsl.l     #6,d2
             lsl.l     #6,d3
             lsl.l     #6,d4
             lsl.l     #6,d5
             lsl.l     #6,d6
             lsl.l     #6,d7
             bra       bouclex

fintx:       
             neg.w     d0
             addi.w    #16,d0
             lsr.l     #6,d2
             lsl.w     d0,d2
             lsr.l     #6,d3
             lsl.w     d0,d3
             lsr.l     #6,d4
             lsl.w     d0,d4
             lsr.l     #6,d5
             lsl.w     d0,d5
             lsr.l     #6,d6
             lsl.w     d0,d6
             lsr.l     #6,d7
             lsl.w     d0,d7
             move.w    d2,d1
             bsr.s     affi3x
             move.w    d3,d1
             bsr.s     affi3x
             move.w    d4,d1
             bsr.s     affi3x
             move.w    d5,d1
             bsr.s     affi3x
             move.w    d6,d1
             bsr.s     affi3x
             move.w    d7,d1
             bsr.s     affi3x

             suba.l    a6,a0
             move.w    a0,d0
             subq.w    #1,d0
             rts       


affix:       subi.w    #16,d0
             move.l    d2,d1
             bsr.s     affi2x
             move.l    d3,d1
             bsr.s     affi2x
             move.l    d4,d1
             bsr.s     affi2x
             move.l    d5,d1
             bsr.s     affi2x
             move.l    d6,d1
             bsr.s     affi2x
             move.l    d7,d1
             bsr.s     affi2x
             suba.w    largbuff6m8,a1
             move.w    #-1,d1
             lsl.w     d0,d1
             not.w     d1
             and.w     d1,d2
             and.w     d1,d3
             and.w     d1,d4
             and.w     d1,d5
             and.w     d1,d6
             and.w     d1,d7
             bra       decalx

affi2x:      lsr.l     d0,d1
affi3x:      move.w    d0,-(sp)
             move.w    d1,d0
             not.w     d0
auto_modx:   or.w      d1,(a1)+             ;  and.w d0,(a1)+  automodifie
             or.w      d1,(a1)+             ;             "
             or.w      d1,(a1)+             ;             "
             or.w      d1,(a1)+             ;             "
             adda.w    largbufm8,a1         ;              lea.l    152(a1),a1     ;adda.l   #160-8,a1
             move.w    (sp)+,d0
             rts       

and1x:       move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test1x
and2x:       move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test2x
and3x:       move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       test3x
and4x:       move.w    #%1100000101011001,(a2)+   ; and.w d0,(a1)+
             bra       retourx

font:        
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00011000                ; !
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00000000
             .DC.b %00011000
             .DC.b %00000000

             .DC.b %00110110                ; "
             .DC.b %00110110
             .DC.b %00100100
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %01110000                ; # = fleche droite
             .DC.b %00011110
             .DC.b %00001111
             .DC.b %00011110
             .DC.b %01110000
             .DC.b %00000000

             .DC.b %00001110                ; $ = fleche gauche
             .DC.b %01111000
             .DC.b %11110000
             .DC.b %01111000
             .DC.b %00001110
             .DC.b %00000000

             .DC.b %00010000                ; % = fleche haut
             .DC.b %00111000
             .DC.b %01111100
             .DC.b %11000110
             .DC.b %10000010
             .DC.b %00000000

             .DC.b %10000010                ; & = fleche bas
             .DC.b %11000110
             .DC.b %01111100
             .DC.b %00111000
             .DC.b %00010000
             .DC.b %00000000

             .DC.b %00011000                ; '
             .DC.b %00011000
             .DC.b %00110000
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00001100                ; (
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00011000                ; )
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00011000
             .DC.b %00000000

             .DC.b %00100100                ; *
             .DC.b %00011000
             .DC.b %00111100
             .DC.b %00011000
             .DC.b %00100100
             .DC.b %00000000

             .DC.b %00001000                ; +
             .DC.b %00001000
             .DC.b %00111110
             .DC.b %00001000
             .DC.b %00001000
             .DC.b %00000000

             .DC.b %00000000                ; ,
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00110000

             .DC.b %00000000                ; -
             .DC.b %00000000
             .DC.b %00111110
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00000000                ; .
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00000000

             .DC.b %00000110                ; /
             .DC.b %00001100
             .DC.b %00011000
             .DC.b %00110000
             .DC.b %00100000
             .DC.b %00000000

             .DC.b %00111110                ; 0
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00000100                ; 1
             .DC.b %00000100
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00111110                ; 2
             .DC.b %00000010
             .DC.b %00111110
             .DC.b %00110000
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00111110                ; 3
             .DC.b %00000010
             .DC.b %00111110
             .DC.b %00000010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00110010                ; 4
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00000010
             .DC.b %00000010
             .DC.b %00000000

             .DC.b %00111110                ; 5
             .DC.b %00110000
             .DC.b %00111110
             .DC.b %00000010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00111110                ; 6
             .DC.b %00110000
             .DC.b %00111110
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00111110                ; 7
             .DC.b %00000010
             .DC.b %00000100
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00000000

             .DC.b %00111110                ; 8
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00111110                ; 9
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00000010
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00011000                ; :
             .DC.b %00011000
             .DC.b %00000000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00000000

             .DC.b %00011000                ; ;
             .DC.b %00011000
             .DC.b %00000000
             .DC.b %00011000
             .DC.b %00001000
             .DC.b %00010000

             .DC.b %00001100                ; <
             .DC.b %00011000
             .DC.b %00110000
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00000000                ; =
             .DC.b %00111110
             .DC.b %00000000
             .DC.b %00111110
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00110000                ; >
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00011000
             .DC.b %00110000
             .DC.b %00000000

             .DC.b %00011100                ; ?
             .DC.b %00100010
             .DC.b %00000100
             .DC.b %00000000
             .DC.b %00000100
             .DC.b %00000000

             .DC.b %00001100                ; @ = angle
             .DC.b %00011000
             .DC.b %00111000
             .DC.b %01100100
             .DC.b %11111111
             .DC.b %00000000

             .DC.b %00011100                ; A
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00000000

             .DC.b %00111100                ; B
             .DC.b %00110010
             .DC.b %00111100
             .DC.b %00110010
             .DC.b %00111100
             .DC.b %00000000

             .DC.b %00011110                ; C
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00011110
             .DC.b %00000000

             .DC.b %00111100                ; D
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00111100
             .DC.b %00000000

             .DC.b %00111110                ; E
             .DC.b %00110000
             .DC.b %00111100
             .DC.b %00110000
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00111110                ; F
             .DC.b %00110000
             .DC.b %00111100
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00000000

             .DC.b %00011110                ; G
             .DC.b %00110000
             .DC.b %00110110
             .DC.b %00110010
             .DC.b %00011110
             .DC.b %00000000

             .DC.b %00110010                ; H
             .DC.b %00110010
             .DC.b %00111110
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00000000

             .DC.b %00111100                ; I
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00111100
             .DC.b %00000000

             .DC.b %00000110                ; J
             .DC.b %00000110
             .DC.b %00000110
             .DC.b %00100110
             .DC.b %00011100
             .DC.b %00000000

             .DC.b %00110100                ; K
             .DC.b %00111000
             .DC.b %00110000
             .DC.b %00111000
             .DC.b %00110100
             .DC.b %00000000

             .DC.b %00110000                ; L
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00100010                ; M
             .DC.b %00110110
             .DC.b %00111110
             .DC.b %00101010
             .DC.b %00100010
             .DC.b %00000000

             .DC.b %00110010                ; N
             .DC.b %00110010
             .DC.b %00111010
             .DC.b %00110110
             .DC.b %00110010
             .DC.b %00000000

             .DC.b %00011100                ; O
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00011100
             .DC.b %00000000

             .DC.b %00111100                ; P
             .DC.b %00110010
             .DC.b %00111100
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00000000

             .DC.b %00011100                ; Q
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00011100
             .DC.b %00000110

             .DC.b %00111100                ; R
             .DC.b %00110010
             .DC.b %00111100
             .DC.b %00111000
             .DC.b %00110110
             .DC.b %00000000

             .DC.b %00011110                ; S
             .DC.b %00110000
             .DC.b %00011100
             .DC.b %00000110
             .DC.b %00111100
             .DC.b %00000000

             .DC.b %00111110                ; T
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00110010                ; U
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00011110
             .DC.b %00000000

             .DC.b %00110010                ; V
             .DC.b %00110010
             .DC.b %00110010
             .DC.b %00011100
             .DC.b %00001000
             .DC.b %00000000

             .DC.b %00110010                ; W
             .DC.b %00110010
             .DC.b %00111010
             .DC.b %00110110
             .DC.b %00100010
             .DC.b %00000000

             .DC.b %00110010                ; X
             .DC.b %00011100
             .DC.b %00001000
             .DC.b %00011100
             .DC.b %00110010
             .DC.b %00000000

             .DC.b %00110010                ; Y
             .DC.b %00110010
             .DC.b %00011100
             .DC.b %00001000
             .DC.b %00001000
             .DC.b %00000000

             .DC.b %00111110                ; Z
             .DC.b %00001100
             .DC.b %00001000
             .DC.b %00011000
             .DC.b %00111110
             .DC.b %00000000

             .DC.b %00011110                ; [
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00011000
             .DC.b %00011110
             .DC.b %00000000

             .DC.b %00110000                ; \
             .DC.b %00110000
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00011110                ; [
             .DC.b %00000110
             .DC.b %00000110
             .DC.b %00000110
             .DC.b %00011110
             .DC.b %00000000


             .DC.b %00001000                ; accent circonflexe
             .DC.b %00010100
             .DC.b %00100010
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000


             .DC.b %00000000                ; -
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00111110
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00011000                ; `
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00000000
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00000000                ; a
             .DC.b %00111110
             .DC.b %00100010
             .DC.b %00111110
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00111111                ; b
             .DC.b %00111111
             .DC.b %00000110
             .DC.b %00000110
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00111111                ; C
             .DC.b %00000001
             .DC.b %00000011
             .DC.b %00000101
             .DC.b %00011111
             .DC.b %00000000

             .DC.b %00111111                ; D
             .DC.b %00011010
             .DC.b %00111110
             .DC.b %00110110
             .DC.b %00000110
             .DC.b %00000000

             .DC.b %00000000                ; E
             .DC.b %00000111
             .DC.b %00111111
             .DC.b %00111000
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00000000                ; F
             .DC.b %00110000
             .DC.b %00111111
             .DC.b %00110000
             .DC.b %00110000
             .DC.b %00000000

             .DC.b %00000011                ; G
             .DC.b %00000101
             .DC.b %00001001
             .DC.b %00010001
             .DC.b %00100001
             .DC.b %00000000

             .DC.b %00001001                ; H
             .DC.b %00111111
             .DC.b %00110000
             .DC.b %00011000
             .DC.b %00001100
             .DC.b %00000000

             .DC.b %00001000                ; I
             .DC.b %00001000
             .DC.b %00110110
             .DC.b %00110110
             .DC.b %00001000
             .DC.b %00000000

             .DC.b %00101001                ; J
             .DC.b %00101001
             .DC.b %00101001
             .DC.b %00111111
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00100000                ; K
             .DC.b %00011111
             .DC.b %00001000
             .DC.b %00111100
             .DC.b %00000010
             .DC.b %00000000

             .DC.b %00100001                ; L
             .DC.b %00100001
             .DC.b %00010010
             .DC.b %00001100
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00100010                ; M
             .DC.b %00011100
             .DC.b %00100001
             .DC.b %00111111
             .DC.b %00000000
             .DC.b %00000000

             .DC.b %00000000                ; N
             .DC.b %00011110
             .DC.b %00101010
             .DC.b %00000000
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00001000                ; O
             .DC.b %00001110
             .DC.b %00111001
             .DC.b %00001110
             .DC.b %00001000
             .DC.b %00000000

             .DC.b %00000000                ; P
             .DC.b %00111111
             .DC.b %00000010
             .DC.b %00001111
             .DC.b %00000010
             .DC.b %00000000

             .DC.b %00000000                ; Q
             .DC.b %00111111
             .DC.b %00010011
             .DC.b %00010011
             .DC.b %00110011
             .DC.b %00000000

             .DC.b %00111111                ; R
             .DC.b %00100101
             .DC.b %00111111
             .DC.b %00100101
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00011100                ; S
             .DC.b %00100010
             .DC.b %00001101
             .DC.b %00111111
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00011111                ; T
             .DC.b %00011010
             .DC.b %00011000
             .DC.b %00011111
             .DC.b %00011111
             .DC.b %00000000

             .DC.b %00011110                ; U
             .DC.b %00110011
             .DC.b %00101101
             .DC.b %00100001
             .DC.b %00011110
             .DC.b %00000000

             .DC.b %00111111                ; V
             .DC.b %00100000
             .DC.b %00100000
             .DC.b %00100011
             .DC.b %00100011
             .DC.b %00000000

             .DC.b %00000011                ; W
             .DC.b %00111111
             .DC.b %00100000
             .DC.b %00100111
             .DC.b %00111111
             .DC.b %00000000

             .DC.b %00100001                ; X
             .DC.b %00011110
             .DC.b %00100001
             .DC.b %00011100
             .DC.b %00100001
             .DC.b %00000000

             .DC.b %00000000                ; Y
             .DC.b %00110000
             .DC.b %00001000
             .DC.b %00111100
             .DC.b %00000011
             .DC.b %00000000

             .DC.b %00000000                ; Z
             .DC.b %00111000
             .DC.b %00111000
             .DC.b %00001111
             .DC.b %00110011
             .DC.b %00000000








             .BSS 

largbuf:     .DS.w 1
largbufm8:   .DS.w 1
largbuff6m8: .DS.w 1

