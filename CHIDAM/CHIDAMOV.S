

;---------------------------------------------------------------
;
; CHIDAMOV
;

xchidam      equ 160
ychidam      equ 25+8

pactionx     equ 8
pactiony     equ 2

             .TEXT 

chidam:      
             move.w    #2,souri_11          ;fleche vers le haut

             move.w    #-1,select

             clr.w     sauter

             bsr       affjeu

             lea.l     palettechidam,a0
             jsr       degraon

boucle:      
             move.w    souri_7,d0
             move.w    souri_8,d1
             move.w    souri_5,d6
             cmpi.w    #1,d6
             beq       clic
             cmpi.w    #2,d6
             beq       droit

             bsr       affjeu               ;15/1/91
             bra       boucle

repeat:      
             bsr       relache
             bra       boucle

cpu:         
             bsr       gagne
             beq       fin
             clr.w     sauter
             move.w    #-1,select
             bsr       analyse              ;l'ordinateur choisi son coups
             bsr       perdu
             beq       fin
;              addq.w   #2,nbcoups
;             move.w   nbcoups,d0
;            bsr      print          ;affichage du nombre de coups (provisoire)
             bra       repeat

fin:         
             move.w    #-1,souri_11
             rts       



;---------------------------------------------------------------
;
; perdu
;
; on regarde si l'ordinateur a gagne (le joueur a perdu)
;

perdu:       
             lea.l     motif_p,a0
             clr.w     d7
             moveq.l   #7,d1
b022:        
             moveq.l   #16,d0
b023:        
             move.b    (a0)+,d7
             beq       e021

             movem.l   d0/d1/d3-d7/a0-a6,-(sp)
             neg.w     d1
             addi.w    #11+7,d1
             neg.w     d0
             addi.w    #16,d0
             bsr       read
             movem.l   (sp)+,d0/d1/d3-d7/a0-a6

             cmp.w     d7,d2
             bne       e022
e021:        
             dbra      d0,b023
             dbra      d1,b022
             clr.w     d6                   ;place le bit Z a 1
             rts       

e022:        
             moveq.l   #1,d6                ;place le bit Z a 0
             rts       

;---------------------------------------------------------------
;
; gagne
;
; on regarde si le joueur (humain) a gagne
;

gagne:       
             lea.l     motif_g,a0
             clr.w     d7
             moveq.l   #7,d1
b022g:       
             moveq.l   #16,d0
b023g:       
             move.b    (a0)+,d7
             beq       e021g

             movem.l   d0/d1/d3-d7/a0-a6,-(sp)
             neg.w     d1
             addi.w    #2+7,d1
             neg.w     d0
             addi.w    #16,d0
             bsr       read
             movem.l   (sp)+,d0/d1/d3-d7/a0-a6

             cmp.w     d7,d2
             bne       e022g
e021g:       
             dbra      d0,b023g
             dbra      d1,b022g
             clr.w     d6                   ;bit Z=1
             rts       

e022g:       
             moveq.l   #1,d6                ;bit Z=0
             rts       
;---------------------------------------------------------------
;
; analyse
;
; l'ordinateur analyse le meilleur coup
;

analyse:     

             clr.w     optdmax

             moveq.l   #20,d1
b004:        
             moveq.l   #16,d0
b005:        
             movem.l   d0/d1/a0-a6,-(sp)
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       e014
             cmpi.w    #6,d2
             bgt       e014
             btst      #0,d2
             bne       e014                 ;paire compris entre 2 et 6

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       analyse2
             movem.l   (sp)+,d0-d7/a0-a6


;              move.w   potentiel,d7
;             cmp.w    dmax,d7
;            blt      e014           ;andicap


             move.w    dmax,d7

             cmp.w     optdmax,d7
             ble       e014

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       trans
             movem.l   (sp)+,d0-d7/a0-a6

e014:        
             dbra      d0,b005
             dbra      d1,b004

             tst.w     optdmax
             beq       depun

bouge:       
             moveq.l   #15,d2
             lea.l     parcour,a0
             move.w    nparcour,d7
             beq       repeat

             subq.w    #2,d7
             move.w    (a0)+,d0
             move.w    (a0)+,d1

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d0,select            ;15/1/91
             move.w    d1,select+2          ;15/1/91
             bsr       affjeu
             movem.l   (sp)+,d0-d7/a0-a6

b008:        
             movem.l   d0/d1/d7/a0-a6,-(sp)
             clr.w     d2
             bsr       write
             movem.l   (sp)+,d0/d1/d7/a0-a6

             move.w    (a0)+,d0
             move.w    (a0)+,d1

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d0,select            ;15/1/91
             move.w    d1,select+2          ;15/1/91
             bsr       write
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affjeu
             bsr       pause
             bsr       pause
             movem.l   (sp)+,d0-d7/a0-a6

             dbra      d7,b008

             move.w    #-1,select           ;15/1/91
             rts       


;---------------------------------------------------------------
;
; depun
;
; aucun deplacement de plusieur case n'est rentable alors on cherche
; un deplacement d'une seule case
;

depun:       
             move.w    #-100,dmax
             moveq.l   #20,d1
b004u:       
             moveq.l   #16,d0
b005u:       
             movem.l   d0/d1/a0-a6,-(sp)
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       e014u
             cmpi.w    #6,d2
             bgt       e014u
             btst      #0,d2
             bne       e014u                ;paire compris entre 2 et 6

             subq.w    #1,d2
             lsl.w     #2,d2
             lea.l     ditable,a0
             move.l    0(a0,d2.w),distadr

             movem.l   d0/d1/a0-a6,-(sp)
             bsr       dist
             movem.l   (sp)+,d0/d1/a0-a6

             move.w    d2,disto

             move.w    d0,x
             move.w    d1,y

             moveq.l   #7,d2
b020:        
             movem.l   d0-d7/a0-a6,-(sp)
             addq.w    #6,d2

             movem.l   d0-d6/a0-a6,-(sp)
             bsr       possible
             movem.l   (sp)+,d0-d6/a0-a6

             tst.w     d7
             beq       e020

             movem.l   d2-d7/a0-a6,-(sp)
             bsr       delta
             movem.l   (sp)+,d2-d7/a0-a6

             movem.l   d0/d1/a0-a6,-(sp)
             bsr       dist
             movem.l   (sp)+,d0/d1/a0-a6

             neg.w     d2
             add.w     disto,d2
             cmp.w     dmax,d2
             blt       e020
             beq       alea
rtralea:     
             move.w    d2,dmax
             move.w    #2,nparcour
             lea.l     parcour,a0
             move.w    x,(a0)+
             move.w    y,(a0)+
             move.w    d0,(a0)+
             move.w    d1,(a0)+

;              not.w    $ff8240

e020:        
             movem.l   (sp)+,d0-d7/a0-a6

             dbra      d2,b020

e014u:       
             dbra      d0,b005u
             dbra      d1,b004u

;           tst.w    dmax
;            beq      gainzero

;              cmpi.w   #-100,dmax   le 17/1
;             beq      fin           le 17/1
             bra       bouge

alea:        
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #1,d0
             jsr       rnd
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6

             beq       e020
             bra       rtralea


;---------------------------------------------------------------
;
; trans
;

trans:       
             move.w    dmax,optdmax
             lea.l     chemin,a0
             lea.l     parcour,a1
             clr.w     nparcour

             move.w    nomax,d0

b006:        
             addq.w    #1,nparcour
             move.w    0(a0,d0.w),d1        ;origine*8

             move.l    2(a0,d0.w),-(sp)
             move.w    d1,d0
             blt       fintrans
             bra       b006
fintrans:    
             move.w    nparcour,d0
             subq.w    #1,d0
b007:        
             move.l    (sp)+,(a1)+
             dbra      d0,b007

             rts       

;---------------------------------------------------------------
;
; analyse2
;
; entree:  d0 x
;          d1 y
;

analyse2:    
             movem.l   d0/d1/a0-a6,-(sp)
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             subq.w    #1,d2
             lsl.w     #2,d2
             lea.l     ditable,a0
             move.l    0(a0,d2.w),distadr

             movem.l   d0/d1/a0-a6,-(sp)
             bsr       dist
             movem.l   (sp)+,d0/d1/a0-a6

             move.w    d2,disto

             lea.l     chemin,a0
             move.w    #-1,(a0)+
             move.w    d0,(a0)+
             move.w    d1,(a0)+
             clr.w     (a0)+

             lea.l     chemin,a1            ;origine des points a scruter
             clr.w     nbp                  ; 0 points

pasfini:     
             bsr       plus

             cmpa.l    a0,a1                ; si a1<>a0 il y encore de nouveaux points
             bne       pasfini

             clr.w     dmax

             move.w    nbp,d7
             beq       rts                  ;pas de deplacement possible

             lea.l     chemin+8,a0
             subq.w    #1,d7
b001:        
             addq.l    #2,a0
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             cmp.w     dmax,d2
             ble       e012
             move.w    d2,dmax
             move.l    a0,d2
             subi.l    #chemin,d2
             subq.w    #8,d2
             move.w    d2,nomax
e012:        
             moveq.l   #5,d2

             dbra      d7,b001

             bsr       iniana

rts:         rts       

;---------------------------------------------------------------
;
; plus
;

plus:        
             addq.l    #2,a1
             move.w    (a1)+,d0             ;x
             move.w    (a1)+,d1             ;y
             addq.l    #2,a1

             moveq.l   #5,d2
b002:        
             movem.l   d0-d6/a0-a6,-(sp)
             bsr       possible
             movem.l   (sp)+,d0-d6/a0-a6

             tst.w     d7
             beq       e011

             addq.w    #1,nbp
             move.l    a1,d7
             subi.l    #chemin,d7           ;numero du point*8
             subq.w    #8,d7
             move.w    d7,(a0)+

             movem.l   d0-d7/a0-a6,-(sp)

             movem.l   a0-a6,-(sp)
             bsr       delta
             movem.l   (sp)+,a0-a6

             move.w    d0,(a0)+             ;x
             move.w    d1,(a0)+             ;y

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #8,d2
             bsr       write
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0/d1/a0-a6,-(sp)
             bsr       dist
             movem.l   (sp)+,d0/d1/a0-a6

             move.w    disto,d3
             sub.w     d2,d3
             move.w    d3,(a0)+             ;delta dist

             movem.l   (sp)+,d0-d7/a0-a6

             addq.l    #6,a0

e011:        
             dbra      d2,b002
             rts       

;---------------------------------------------------------------
;
; droit
;
; on clic sur le bouton droit de la souris
;

droit:       
             tst.w     select
             blt       fin
             move.w    #-1,select
             clr.w     sauter
             bsr       affjeu
             bra       repeat

;---------------------------------------------------------------
;
; clic
;
; on clic sur le bouton gauche de la souris
;

clic:        
             addi.w    #pactionx,d0
             addi.w    #pactiony,d1


             subi.w    #ychidam,d1
             blt       repeat

             lsr.w     #3,d1                ;y
             addq.w    #2,d1

             subi.w    #xchidam,d0
             blt       repeat
             btst      #0,d1
             bne       e000
             subq.w    #4,d0
             blt       repeat

e000:        
             lsr.w     #3,d0                ;x

             tst.w     select
             blt       origine

             cmp.w     select,d0
             bne       e006
             cmp.w     select+2,d1
             beq       cpu                  ;on reclic sur le meme

e006:        
             movem.l   d0/d1,-(sp)
             bsr       read
             movem.l   (sp)+,d0/d1

             tst.w     d2
             bne       repeat               ;la case destination n'est pas vide

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d0,d2
             move.w    d1,d3
             sub.w     select,d2
             sub.w     select+2,d3

             move.w    select+2,d7
             btst      #0,d7
             bne       e003

             bsr       nodepp
             bra       e002
e003:        
             bsr       nodepi
e002:        
             move.w    d7,dep
             movem.l   (sp)+,d0-d7/a0-a6

             tst.w     dep
             blt       repeat               ;le deplacement n'est pas valide
             cmpi.w    #6,dep
             blt       saut

             tst.w     sauter
             blt       repeat               ;on ne peut plus se deplacer d'une case apres un saut

             movem.l   d0/d1,-(sp)
             move.w    select,d0
             move.w    select+2,d1
             bsr       read
             movem.l   (sp)+,d0/d1

             bsr       write
             move.w    select,d0
             move.w    select+2,d1
             clr.w     d2
             bsr       write

             move.w    #-1,select
             bsr       affjeu
             bra       cpu

origine:     
             movem.l   d0/d1,-(sp)
             bsr       read
             movem.l   (sp)+,d0/d1

             tst.w     d2
             ble       repeat
             cmpi.w    #5,d2
             bgt       repeat
             btst      #0,d2
             beq       repeat               ;1,3 ou 5

             move.w    d0,select
             move.w    d1,select+2
             bsr       affjeu
             bra       repeat


saut:        
             movem.l   d0-d6/a0-a6,-(sp)
             move.w    dep,d2
             move.w    select,d0
             move.w    select+2,d1
             bsr       possible
             movem.l   (sp)+,d0-d6/a0-a6

             tst.w     d7
             beq       repeat

             move.w    #-1,sauter

             movem.l   d0/d1,-(sp)
             move.w    select,d0
             move.w    select+2,d1
             bsr       read
             movem.l   (sp)+,d0/d1

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       write
             move.w    select,d0
             move.w    select+2,d1
             clr.w     d2
             bsr       write
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    d0,select
             move.w    d1,select+2

             bsr       affjeu
             bra       repeat

;---------------------------------------------------------------
;
; possible
;
; teste si un deplacement est possible
;
; entree:  d0 x origine
;          d1 y
;          d2 numero du deplacement
;
; retour:  d7=0 si pas possible, -1 sinon
;

possible:    
             btst      #0,d1
             bne       possible2

             tst.w     d2
             bne       suite1

             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d1
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide0:       
             subq.w    #1,d0
             subq.w    #2,d1
             bsr       read
             tst.w     d2
             bne       paspos

             bra       pos
suite1:      
             cmpi.w    #1,d2
             bne       suite2

             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d1
             addq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide1:       
             addi.w    #1,d0
             subq.w    #2,d1
             bsr       read
             tst.w     d2
             bne       paspos

             bra       pos
suite2:      
             cmpi.w    #2,d2
             bne       suite3

             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide2:       
             addq.w    #2,d0
             bsr       read
             tst.w     d2
             bne       paspos

             bra       pos
suite3:      
             cmpi.w    #3,d2
             bne       suite4

             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d1
             addq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide3:       
             addq.w    #1,d0
             addq.w    #2,d1
             bsr       read
             tst.w     d2
             bne       paspos

             bra       pos
suite4:      
             cmpi.w    #4,d2
             bne       suite5

             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d1
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide4:       
             subq.w    #1,d0
             addq.w    #2,d1
             bsr       read
             tst.w     d2
             bne       paspos

             bra       pos
suite5:      
             cmpi.w    #5,d2
             bne       suite6

             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6

             tst.w     d2
             beq       paspos

vide5:       
             subq.w    #2,d0
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite6:      
             cmpi.w    #7,d2
             bne       suite6b
             subq.w    #1,d1
             addq.w    #1,d0
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite6b:     
             cmpi.w    #9,d2
             bne       commun
             addq.w    #1,d0
             addq.w    #1,d1
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
commun:      
             cmpi.w    #6,d2
             bne       suite7
             subq.w    #1,d1
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite7:      
             cmpi.w    #8,d2
             bne       suite8
             addq.w    #1,d0
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite8:      
             cmpi.w    #10,d2
             bne       suite9
             addq.w    #1,d1
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite9:      
             cmpi.w    #11,d2
             bne       paspos
             subq.w    #1,d0
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos

pos:         
             move.w    #-1,d7
             rts       

paspos:      
             clr.w     d7
             rts       

possible2:   
             tst.w     d2
             bne       suite1b
             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d1
             subq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide0
suite1b:     
             cmpi.w    #1,d2
             bne       suite2b
             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d1
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide1
suite2b:     
             cmpi.w    #2,d2
             bne       suite3b
             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide2
suite3b:     
             cmpi.w    #3,d2
             bne       suite4b
             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d1
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide3
suite4b:     
             cmpi.w    #4,d2
             bne       suite5b
             movem.l   d0/d1/a0-a6,-(sp)
             addq.w    #1,d1
             subq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide4
suite5b:     
             cmpi.w    #5,d2
             bne       suite10
             movem.l   d0/d1/a0-a6,-(sp)
             subq.w    #1,d0
             bsr       read
             movem.l   (sp)+,d0/d1/a0-a6
             tst.w     d2
             beq       paspos
             bra       vide5
suite10:     
             cmpi.w    #12,d2
             bne       suite11
             subq.w    #1,d0
             subq.w    #1,d1
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos
suite11:     
             cmpi.w    #13,d2
             bne       commun
             subq.w    #1,d0
             addq.w    #1,d1
             bsr       read
             tst.w     d2
             bne       paspos
             bra       pos



relache:     
             tst.w     souri_5
             bne       relache
             rts       

;---------------------------------------------------------------
;
; pause
;

pause:       
             move.w    #3000,d0
b021:        
             nop       
             dbra      d0,b021
             rts       

;---------------------------------------------------------------
;
; write
;
; d0 x
; d1 y
; d2 nouvelle valeur
;
; echange d2 et l'octet concerne
;

write:       
             lea.l     motif_d,a0
             move.w    d1,d3
             mulu.w    #17,d3
             adda.l    d3,a0
             clr.w     d3
             move.b    0(a0,d0.w),d3
             move.b    d2,0(a0,d0.w)
             move.w    d3,d2
             rts       

;---------------------------------------------------------------
;
; read
;
; d0 x
; d1 y
;
; ecrit l'octet concerne dans d2
;

read:        
             lea.l     motif_d,a0
             move.w    d1,d3
             mulu.w    #17,d3
             adda.l    d3,a0
             clr.w     d2
             move.b    0(a0,d0.w),d2
             rts       

;---------------------------------------------------------------
;
; dist
;
; d0 x
; d1 y
;
; ecrit l'octet concerne dans d2
;

dist:        
             subq.w    #2,d0
             subq.w    #2,d1
             movea.l   distadr,a0
             move.w    d1,d3
             mulu.w    #13,d3
             adda.l    d3,a0
             clr.w     d2
             move.b    0(a0,d0.w),d2
             rts       
;---------------------------------------------------------------
;
; nodepp
;
; numero pour deplacement paire
;
; entree:  d2 x arrivee-x origine
;          d3 y ...     y ....
;
; retour:  d7 numero du deplacement
;          -1 si non valide
;

nodepp:      
             moveq.l   #13,d7
             lea.l     dep_p,a0
bdp:         
             move.w    (a0)+,d4
             move.w    (a0)+,d5
             cmp.w     d2,d4
             bne       e001
             cmp.w     d3,d5
             beq       egal
e001:        
             dbra      d7,bdp
             rts                            ;d7=-1

egal:        
             neg.w     d7
             addi.w    #13,d7
             rts       

;---------------------------------------------------------------
;
; nodepi
;
; numero pour deplacement impaire
;
; entree:  d2 x arrivee-x origine
;          d3 y ...     y ....
;
; retour:  d7 numero du deplacement
;          -1 si non valide
;

nodepi:      
             moveq.l   #13,d7
             lea.l     dep_i,a0
bdi:         
             move.w    (a0)+,d4
             move.w    (a0)+,d5
             cmp.w     d2,d4
             bne       e002b
             cmp.w     d3,d5
             beq       egali
e002b:       
             dbra      d7,bdi
             rts                            ;d7=-1

egali:       
             neg.w     d7
             addi.w    #13,d7
             rts       


;---------------------------------------------------------------
;
; affjeu
;
; affichage du plateau de jeu
;

affjeu:      
             movea.l   adrdicour,a0
             movea.l   sys01,a1
             move.w    #7999,d0
bv:          
             move.l    (a0)+,(a1)+
             dbra      d0,bv

             lea.l     motif_d,a0
             adda.w    #17*2,a0             ;on saute 2 lignes

             move.w    #xchidam,d0
             move.w    #ychidam,d1

             moveq.l   #16,d7
b_y:         
             moveq.l   #16,d6
             move.w    d7,d5
             andi.w    #1,d5
             neg.w     d5
             addq.w    #1,d5
             mulu.w    #4,d5
             add.w     d5,d0
b_x:         
             clr.w     d4
             move.b    (a0)+,d4
             beq       pasaff
             cmpi.w    #6,d4
             bgt       pasaff

             movem.l   d0-d7/a0-a6,-(sp)
             lsl.w     #2,d4
             lea.l     pions,a1
             movea.l   0(a1,d4.w),a1
             jsr       cd003
             movem.l   (sp)+,d0-d7/a0-a6

pasaff:      
             addq.w    #8,d0

             dbra      d6,b_x
             move.w    #xchidam,d0
             addq.w    #8,d1

             dbra      d7,b_y

             move.w    select,d0
             blt       e004
             move.w    select+2,d1
             moveq.l   #15,d2
             bsr       affpion

e004:        
             jsr       ecrswap
             rts       

;---------------------------------------------------------------
;
; affpion
;

affpion:     
             subq.w    #2,d1
             lsl.w     #3,d0
             addi.w    #xchidam,d0
             btst      #0,d1
             bne       e005
             addi.w    #4,d0
e005:        
             lsl.w     #3,d1
             addi.w    #ychidam,d1

             lea.l     cache,a1
             jsr       cd003
             rts       

;---------------------------------------------------------------
;
; delta
;

delta:       
             lea.l     dep_p,a0
             btst      #0,d1
             beq       e008
             lea.l     dep_i,a0
e008:        
             lsl.w     #2,d2
             move.w    2(a0,d2.w),d3
             move.w    0(a0,d2.w),d2
             add.w     d2,d0
             add.w     d3,d1
             rts       

;---------------------------------------------------------------
;
; iniana
;

iniana:      
             lea.l     motif_d,a0
             move.w    #17*21-1,d0
             clr.w     d1
b000:        
             move.b    (a0)+,d1
             cmpi.w    #8,d1
             bne       e010
             clr.b     -1(a0)
e010:        
             dbra      d0,b000
             rts       



;---------------------------------------------------------------
;
; hidem
;
; cache la soursi
;

hidem:       
             clr.w     souri_11
             rts       

;---------------------------------------------------------------
;
; showm
;
; montre la souris
;

showm:       
             move.w    #-1,souri_11
             rts       

             .DATA 

ditable:     .DC.l 0,dist_1,0,dist_3,0,dist_5

dep_p:       .DC.w -1,-2,1,-2,2,0,1,2,-1,2,-2,0,0,-1,1,-1,1,0,1,1,0,1,-1,0,0,0,0,0
dep_i:       .DC.w -1,-2,1,-2,2,0,1,2,-1,2,-2,0,0,-1,0,$0,1,0,0,0,0,1,-1,0,-1,-1,-1,1

motif_d:     

             .DC.b $7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,7,4,7,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,4,4,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,4,4,4,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7
             .DC.b $7,7,6,6,6,6,0,0,0,0,0,2,2,2,2,7,7
             .DC.b 7,7,7,6,6,6,0,0,0,0,0,0,2,2,2,7,7
             .DC.b $7,7,7,6,6,0,0,0,0,0,0,0,2,2,7,7,7
             .DC.b 7,7,7,7,6,0,0,0,0,0,0,0,0,2,7,7,7
             .DC.b $7,7,7,7,0,0,0,0,0,0,0,0,0,7,7,7,7
             .DC.b 7,7,7,7,1,0,0,0,0,0,0,0,0,5,7,7,7
             .DC.b $7,7,7,1,1,0,0,0,0,0,0,0,5,5,7,7,7
             .DC.b 7,7,7,1,1,1,0,0,0,0,0,0,5,5,5,7,7
             .DC.b $7,7,1,1,1,1,0,0,0,0,0,5,5,5,5,7,7
             .DC.b 7,7,7,7,7,7,7,3,3,3,3,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,3,3,3,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,3,3,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,7,3,7,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7


motif_p:     
             .DC.b 7,7,7,7,2,0,0,0,0,0,0,0,0,6,7,7,7
             .DC.b $7,7,7,2,2,0,0,0,0,0,0,0,6,6,7,7,7
             .DC.b 7,7,7,2,2,2,0,0,0,0,0,0,6,6,6,7,7
             .DC.b $7,7,2,2,2,2,0,0,0,0,0,6,6,6,6,7,7
             .DC.b 7,7,7,7,7,7,7,4,4,4,4,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,4,4,4,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,4,4,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,7,4,7,7,7,7,7,7,7,7

motif_g:     
             .DC.b $7,7,7,7,7,7,7,7,3,7,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,7,3,3,7,7,7,7,7,7,7
             .DC.b $7,7,7,7,7,7,7,3,3,3,7,7,7,7,7,7,7
             .DC.b 7,7,7,7,7,7,7,3,3,3,3,7,7,7,7,7,7
             .DC.b $7,7,5,5,5,5,0,0,0,0,0,1,1,1,1,7,7
             .DC.b 7,7,7,5,5,5,0,0,0,0,0,0,1,1,1,7,7
             .DC.b $7,7,7,5,5,0,0,0,0,0,0,0,1,1,7,7,7
             .DC.b 7,7,7,7,5,0,0,0,0,0,0,0,0,1,7,7,7


dist_3:      
             .DC.b $15,19,18,18,18,18,18,18,18,18,18,18,18
             .DC.b 20,19,18,17,17,17,17,17,17,17,17,17,17
             .DC.b $13,18,17,16,16,16,16,16,16,16,16,16,17
             .DC.b 18,17,16,15,15,15,15,15,15,15,15,15,16
             .DC.b $11,16,15,14,14,14,14,14,14,14,14,15,16
             .DC.b 16,15,14,13,13,13,13,13,13,13,13,14,15
             .DC.b $0f,14,13,12,12,12,12,12,12,12,13,14,15
             .DC.b 15,14,13,12,11,11,11,11,11,11,12,13,14
             .DC.b $0e,13,12,11,10,10,10,10,10,11,12,13,14
             .DC.b 14,13,12,11,10,$9,$9,$9,$9,10,11,12,13
             .DC.b $0d,12,11,10,$9,$8,$8,$8,$9,10,11,12,12
             .DC.b 13,12,11,10,$9,$8,$7,$7,$8,$9,10,11,12
             .DC.b $0c,11,10,$9,$8,$7,$6,$7,$8,$9,10,11,12
             .DC.b $7,$7,$7,$7,$7,$3,$5,$5,$3,$7,$7,$7,$7
             .DC.b $07,$7,$7,$7,$7,$2,$4,$2,$7,$7,$7,$7,$7
             .DC.b $7,$7,$7,$7,$7,$7,$1,$1,$7,$7,$7,$7,$7
             .DC.b $07,$7,$7,$7,$7,$7,$0,$7,$7,$7,$7,$7,$7


dist_1:      
             .DC.b $10,16,16,16,16,17,18,19,20,21,22,23,24
             .DC.b 15,15,15,15,15,16,17,18,19,20,21,22,23
             .DC.b $0e,14,14,14,15,16,17,18,19,20,21,22,23
             .DC.b 13,13,13,13,14,15,16,17,18,19,20,21,22
             .DC.b $0c,12,12,12,13,14,15,16,17,18,19,20,21
             .DC.b $7,11,11,11,12,13,14,15,16,17,18,19,20
             .DC.b $07,10,10,11,12,13,14,15,16,17,18,19,20
             .DC.b $7,$7,$9,$9,10,11,12,13,14,15,16,17,18
             .DC.b $07,$7,$8,$8,$9,10,11,12,13,14,15,16,17
             .DC.b $7,$7,$3,$7,$8,$9,10,11,12,13,14,15,16
             .DC.b $07,$2,$5,$6,$7,$8,$9,10,11,12,13,14,15
             .DC.b $7,$1,$4,$5,$7,$8,$9,10,11,12,13,14,15
             .DC.b $00,$1,$2,$3,$9,$9,10,11,12,13,14,15,16
             .DC.b $7,$7,$7,$7,$7,$9,10,11,12,13,14,15,16
             .DC.b $07,$7,$7,$7,$7,10,11,12,13,14,15,16,17
             .DC.b $7,$7,$7,$7,$7,$7,11,12,13,14,15,16,17
             .DC.b $07,$7,$7,$7,$7,$7,12,13,$7,$7,$7,$7,$7

dist_5:      
             .DC.b $15,19,18,17,16,16,16,16,16,16,16,16,16
             .DC.b 20,19,18,17,16,15,15,15,15,15,15,15,15
             .DC.b $13,18,17,16,15,14,14,14,14,14,14,14,14
             .DC.b 19,18,17,16,15,14,13,13,13,13,13,13,13
             .DC.b $12,17,16,15,14,13,12,12,12,12,12,12,12
             .DC.b 18,17,16,15,14,13,12,11,11,11,11,11,11
             .DC.b $11,16,15,14,13,12,11,10,10,10,10,10,10
             .DC.b 17,16,15,14,13,12,11,10,$9,$9,$9,$9,$9
             .DC.b $10,15,14,13,12,11,10,$9,$8,$8,$8,$7,$7
             .DC.b 16,15,14,13,12,11,10,$9,$8,$7,$7,$3,$7
             .DC.b $0f,14,13,12,11,10,$9,$8,$7,$6,$5,$2,$7
             .DC.b 16,15,14,13,12,11,10,$9,$8,$7,$5,$4,$1
             .DC.b $10,15,14,13,12,11,10,$9,$8,$3,$2,$1,$0
             .DC.b 17,16,15,14,13,12,11,10,$9,$7,$7,$7,$7
             .DC.b $11,16,15,14,13,12,11,10,$9,$7,$7,$7,$7
             .DC.b 18,17,16,15,14,13,12,11,10,$9,$7,$7,$7
             .DC.b $13,17,16,15,14,13,12,$7,10,$9,$7,$7,$7


             .EVEN 

pions:       .DC.l chidam0,chidam1,chidam2,chidam3,chidam4,chidam5,chidam6

;motifs des pions

chidam1:     
             .DC.w $6,$6,$4,$3800,$4400,$0,$7c00,$4400,$8200,$0,$fe00,$8200
             .DC.w $0,$0,$fe00,$8a00,$0,$0,$f600,$8a00,$0,$0,$f600,$5c00,$8200
             .DC.w $0,$e600,$3800,$4400,$0,$7c00

chidam2:     
             .DC.w $6,$6,$4,$4400,$4400,$7c00,$0,$aa00,$aa00,$fe00,$0,$5400
             .DC.w $5400,$fe00,$0,$2800,$2000,$f600,$0,$5c00,$5400,$f600,$0
             .DC.w $ba00,$a200,$e600,$0,$4400,$4400,$7c00,$0

chidam3:     
             .DC.w $6,$6,$4,$0,$0,$7c00,$7c00,$3800,$0,$fe00,$fe00,$7c00,$0
             .DC.w $fe00,$fe00,$7c00,$0,$f600,$f600,$7c00,$0,$f600,$f600,$3800
             .DC.w $0,$e600,$e600,$0,$0,$7c00,$7c00

chidam4:     
             .DC.w $6,$6,$4,$7c00,$0,$7c00,$0,$fe00,$3800,$fe00,$3800,$fe00
             .DC.w $7c00,$fe00,$7c00,$fe00,$7400,$f600,$7400,$fe00,$7400,$f600
             .DC.w $7400,$fe00,$2000,$e600,$2000,$7c00,$0,$7c00,$0

chidam5:     
             .DC.w $6,$6,$4,$4400,$7c00,$0,$7c00,$aa00,$fe00,$0,$fe00,$5400
             .DC.w $fe00,$0,$fe00,$2800,$f600,$0,$f600,$4c00,$f600,$0,$f600
             .DC.w $ba00,$e600,$0,$e600,$4400,$7c00,$0,$7c00

chidam6:     
             .DC.w $6,$6,$4,$3800,$3800,$4400,$0,$4400,$7c00,$8200,$0,$8200
             .DC.w $fe00,$0,$0,$8a00,$f600,$0,$0,$8a00,$f600,$0,$0,$5c00,$6400
             .DC.w $8200,$0,$3800,$3800,$4400,$0

chidam0:     

cache:       
             .DC.w $6,$6,$4,$0,$4400,$4400,$4400,$0,$ee00,$ee00,$ee00,$0,$6c00
             .DC.w $6c00,$6c00,$0,$1000,$1000,$1000,$0,$6c00,$6c00,$6c00,$0
             .DC.w $ee00,$ee00,$ee00,$0,$4400,$4400,$4400

nbcoups:     .DC.w 0



             .BSS 

chemin:      .DS.w 200
parcour:     .DS.w 200

nparcour:    .DS.w 1

disto:       .DS.w 1   ;distance entre l'origine et l'objectif
nbp:         .DS.w 1   ;nombre de points du chemin

distadr:     .DS.l 1   ;adresse de la table de distance pour la couleur traitee

dmax:        .DS.w 1   ;delta dist max
optdmax:     .DS.w 1

x:           .DS.w 1
y:           .DS.w 1

nomax:       .DS.w 1   ;no du point de delta max
dmin:        .DS.w 1
xmin:        .DS.w 1
ymin:        .DS.w 1
pos_x:       .DS.w 1
pos_y:       .DS.w 1
sauter:      .DS.w 1   ;le joueur a t-il deja saute un pion au quel cas il n'a plus le droit de se deplacer d'une case
select:      .DS.l 1
dep:         .DS.w 1
poly:        .DS.l 20

;---------------------------------------------------------------
; segment overlay
;

souri_5:     .DS.b 16
souri_7:     .DS.b 16
souri_8:     .DS.b 16
souri_11:    .DS.b 16
rnd:         .DS.b 16
cd003:       .DS.b 16
sys01:       .DS.b 16
ecrswap:     .DS.b 16
souri_13:    .DS.b 16
sys00:       .DS.b 16
puttcx:      .DS.b 16
pbox:        .DS.b 16

cd009:       
text:        .DS.b 16
adrdicour:   .DS.b 16
degraon:     .DS.b 16
degraoff:    .DS.b 16
palettechidam:         .DS.b 16
overlay17:   .DS.b 16
overlay18:   .DS.b 16
overlay19:   .DS.b 16
overlay20:   .DS.b 16
overlay21:   .DS.b 16
overlay22:   .DS.b 16
overlay23:   .DS.b 16
overlay24:   .DS.b 16
overlay25:   .DS.b 16
overlay26:   .DS.b 16
overlay27:   .DS.b 16
overlay28:   .DS.b 16
overlay29:   .DS.b 16
overlay30:   .DS.b 16
overlay31:   .DS.b 16
overlay32:   .DS.b 16
overlay33:   .DS.b 16
overlay34:   .DS.b 16
overlay35:   .DS.b 16
overlay36:   .DS.b 16
overlay37:   .DS.b 16
overlay38:   .DS.b 16
overlay39:   .DS.b 16


