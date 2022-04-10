;---------------------------------------------------------------
;
; SOURI    29/01/92
;
; routines de gestion de la souris ( B.A.T ][ )
;

;ecrswap
;noyau
;vbl
;allertache
             .EXTERN sys00

nbchmot      equ 15    ;nombre de zones de changement de motif
nbmotif      equ 21

             .TEXT 

;---------------------------------------------------------------
;
; affisouris
;
; affiche la souris et stocke le fond
;
; entree:     d0 x
;             d1 y
;             d3 numero du motif
;

affisouris:  
             tst.w     d3
             beq       hide                 ;la souris est cachee

             movea.l   sys00,a6
             lea.l     sourisfond,a5

             cmpi.w    #nbmotif,d3          ;securite pour ne pas
             ble       asc                  ;pointer n'importe ou
             move.w    #$707,$ff8240        ;;;;;;;;;;;;;;;;;;;;;;;;;;
             moveq.l   #0,d3
             bra       hide
asc:         
             move.w    d0,d2
             andi.w    #$fff0,d2
             lsr.w     #1,d2
             adda.w    d2,a6                ;adresse +x

             lsl.w     #5,d1
             lea.l     0(a6,d1.w),a6
             lsl.w     #2,d1
             adda.w    d1,a6                ;adresse +y

             andi.w    #$f,d0               ;nb decalage

             .REPT 16

             move.l    (a6)+,(a5)+          ;stock le fond
             move.l    (a6)+,(a5)+
             move.l    (a6)+,(a5)+
             move.l    (a6)+,(a5)+
             lea.l     144(a6),a6

             .ENDR 

             lea.l     -2560(a6),a6

             lea.l     souri_15,a5
             subq.w    #1,d3                ;motif -1
             lsl.w     #2,d3
             movea.l   0(a5,d3.w),a5        ;adresse motif

             moveq.l   #0,d1
             move.w    contvbl+2,d1
             lsr.w     #3,d1                ;vitesse d'animation de la souris
             divu.w    (a5)+,d1
             swap.w    d1

             move.w    exetapemotif,etapemotif
             move.w    d1,etapemotif

             lsl.w     #5,d1                ;*160
             adda.w    d1,a5                ;plus rapide
             lsl.w     #2,d1                ;que
             adda.w    d1,a5                ;mulu #160

             .REPT 16
             move.w    (a5)+,d1             ; masque
             swap.w    d1
             clr.w     d1
             lsr.l     d0,d1
             not.l     d1
             move.w    d1,d2
             swap.w    d1

             .REPT 4

             and.w     d1,(a6)
             and.w     d2,8(a6)
             move.w    (a5)+,d3
             swap.w    d3
             clr.w     d3
             lsr.l     d0,d3
             or.w      d3,8(a6)
             swap.w    d3
             or.w      d3,(a6)+

             .ENDR 

             lea.l     152(a6),a6

             .ENDR 
hide:        
             rts       


;---------------------------------------------------------------
;
; ecrswap
;

ecrswap::    
             move.w    #$2500,sr

             addq.w    #1,sourisswap

             move.l    sys01,d0             ;le changement d'adresse physique
             lsr.l     #8,d0                ;ne sera effectif qu'a la
             movea.l   #$ff8201,a0          ;prochaine vbl
             .DC.l $01880000                ;movep.w  d0,0(a0)

             move.l    sys01,d0             ;le changement d'adresse phy est
             move.l    sys00,sys01          ;effectif... on corrige sys00 et sys01
             move.l    d0,sys00


             move.w    #$2300,sr

             move.l    contvbl,d1
waitvbl:     
             cmp.l     contvbl,d1
             beq.s     waitvbl              ;on attend la vbl



             rts       

;---------------------------------------------------------------
;
; ecrswapvbl3
;

ecrswapvbl3: 
             move.w    #$2500,sr

             addq.w    #1,sourisswap

             move.l    sys01,d0             ;le changement d'adresse physique
             lsr.l     #8,d0                ;ne sera effectif qu'a la
             movea.l   #$ff8201,a0          ;prochaine vbl
             .DC.l $01880000                ;movep.w  d0,0(a0)

             move.l    sys01,d0             ;le changement d'adresse phy est
             move.l    sys00,sys01          ;effectif... on corrige sys00 et sys01
             move.l    d0,sys00

             move.w    #$2300,sr

             rts       


;---------------------------------------------------------------
;
; souri_1
;

souri_1::    
             clr.w     souri_18
             move.l    $70,exvbl
             move.l    #vbl,$70

             move.w    #-1,souri_11

             clr.b     $fffa1d              ; timers C et D stoppes

             move.w    #100,wx_souris       ;souri_7
             move.w    #100,wy_souris       ;souri_8
             move.w    #100,souri_7
             move.w    #100,souri_8
             move.w    #1,souri_9

waitacia1:   
             btst      #1,$fffc00
             beq.s     waitacia1
             move.b    #$14,$fffc02
waitacia2:   
             btst      #1,$fffc00
             beq.s     waitacia2
             move.b    #$8,$fffc02

             move.l    sys00,adreffasouris
rts:         rts       

;---------------------------------------------------------------
;
; vbl
;

vbl:         
             move.w    #$2500,sr
             movem.l   d0-d7/a0-a6,-(sp)
             tst.w     flashcol0
             beq       vblflash0
             move.w    contvbl+2,d0
             andi.w    #$3f,d0
             cmpi.w    #1,d0
             beq       vblflash0
             tst.w     d0
             bne       vblflash1
             move.w    #$720,$ff8240

             bra       vblflash1
vblflash0:   
             clr.w     $ff8240
vblflash1:   

             addq.l    #1,contvbl


             jsr       gsour
             move.w    deltaxj,d0
             lea.l     wx_souris,a1
             add.w     d0,(a1)
             move.w    deltayj,d0
             add.w     d0,2(a1)
             jsr       ctrl

             move.w    xfondphy,d0
             move.w    yfondphy,d1
             move.w    motifphy,d2
             move.w    souri_7,d3
             move.w    souri_8,d4
             move.w    souri_9,d5
             move.w    etapemotif,d6
             move.w    exetapemotif,d7


             tst.w     sourisswap
             bne       changesouris

             cmp.w     d0,d3
             bne       changesouris
             cmp.w     d1,d4
             bne       changesouris
             cmp.w     d2,d5
             bne       changesouris


             cmp.w     d6,d7
             beq       paschange

changesouris:          
;              move.w   d6,exetapemotif

             tst.w     motifphy
             beq       exhide2              ;la souris etait cachee...pas de fond

             andi.w    #$fff0,d0
             lsr.w     #1,d0
             movea.l   adreffasouris,a0
             adda.w    d0,a0
             mulu.w    #160,d1
             adda.w    d1,a0

             lea.l     sourisfond,a1

             .REPT 16
             move.l    (a1)+,(a0)
             move.l    (a1)+,4(a0)
             move.l    (a1)+,8(a0)
             move.l    (a1)+,12(a0)

             lea.l     160(a0),a0
             .ENDR 

exhide2:     

             move.w    souri_7,d0
             move.w    souri_8,d1
             move.w    souri_9,d3

             move.w    d0,xfondphy
             move.w    d1,yfondphy
             move.w    d3,motifphy
             jsr       affisouris

paschange:   
             clr.w     sourisswap
;              move.w   etapemotif,exetapemotif

             move.l    sys00,adreffasouris

             tst.w     semait
             bne       exitnoyau


;---------------------------------------------------------------
;
; noyau
;
; (le MOVEM au debut de la routine VBL est utilise par "noyau")
;

noyau::      
             moveq.l   #0,d0
             move.w    contvbl+2,d0

             divu.w    #5,d0
             swap.w    d0
             tst.w     d0
             beq       vbl0
             cmpi.w    #4,d0
             bne       exitnoyau
             tst.w     tachecour            ;;;;;;;;;;
             beq       exitnoyau            ;;;;;;;;;;
             jsr       ecrswapvbl3
             bra       exitnoyau
vbl0:        

noyausuite:  
;         tst.w    tachecour
;       beq      noyausuite0

noyausuite0: 
             moveq.l   #0,d7
             move.w    tachecour,d0
             lsl.w     #2,d0
             lea.l     ppile,a0
             move.l    sp,0(a0,d0.w)

             move.w    d7,tachecour
             lsl.w     #2,d7
             movea.l   0(a0,d7.w),sp
exitnoyau:   
             movem.l   (sp)+,d0-d7/a0-a6
rte:         rte                            ;20


sourisswap:  .DC.w 0
adreffasouris::        .DC.l 0

;---------------------------------------------------------------
;
; allertache
;
; donne la main a une certaine tache
;
; entree:     d0 numero de la tache
;

allertache:: 
             move.w    sr,-(sp)

             move.w    #$2500,sr

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    tachecour,d7
             lsl.w     #2,d7
             lea.l     ppile,a0
             move.l    sp,0(a0,d7.w)
             move.w    d0,tachecour
             lsl.w     #2,d0
             movea.l   0(a0,d0.w),sp
             movem.l   (sp)+,d0-d7/a0-a6
             rte       

;---------------------------------------------------------------
;
; gsour
;

gsour::      

             movea.l   #bsour,a6
             cmpa.l    adrbsour,a6
             beq       rts
encore:      


             clr.w     d0
             move.b    (a6)+,d0

             move.w    souri_18,d1          ;tester l'‚tat
             bne.s     souri22

             cmpi.w    #$fe,d0
             bge       joystic

             cmpi.b    #$f8,d0              ;est-ce une touche?
             bcs.s     ttouche

             move.w    #2,souri_18
             move.w    d0,d1
             andi.w    #1,d0
             lsl.w     #1,d0
             andi.w    #2,d1
             lsr.w     #1,d1
             or.w      d1,d0
             move.w    d0,mousek
             bra       fgs

ttouche:     
             move.w    d0,souri_10
             bra       fgs

souri22:     lea.l     delta_x,a1           ;pack en cours de transmition
             lea.l     souri_18,a2
             cmpi.b    #2,d1
             bgt       joystic1
             beq       dx
             ext.w     d0
             move.w    d0,2(a1)
souri22a:    
             clr.w     (a2)
             move.w    delta_x,d0
             lea.l     wx_souris,a1
             add.w     d0,(a1)
             move.w    delta_y,d0
             add.w     d0,2(a1)
             move.w    mousek,souri_5
fgs:         


             move.w    #$2700,sr
             cmpa.l    adrbsour,a6
             bne       encore2
;           clr.w    $ff8240
             move.l    #bsour,adrbsour
             move.w    #$2500,sr
             rts       

dx:          
             ext.w     d0
             move.w    d0,(a1)
             move.w    #1,(a2)
             bra       fgs


encore2:     
             move.w    #$2500,sr
             bra       encore
joystic:     
             move.w    #3,souri_18
             bra       fgs
joystic1:    
             btst      #0,d0
             beq       dir1
             move.w    #-2,deltayj
             bra       dir2a
dir1:        
             btst      #1,d0
             beq       dir2
             move.w    #2,deltayj
             bra       dir2a
dir2:        
             clr.w     deltayj
dir2a:       
             btst      #2,d0
             beq       dir3
             move.w    #-2,deltaxj
             bra       dir4a
dir3:        
             btst      #3,d0
             beq       dir4
             move.w    #2,deltaxj
             bra       dir4a
dir4:        
             clr.w     deltaxj
dir4a:       
             bra       souri22a

;---------------------------------------------------------------
;
; ctrl
;

ctrl:        

;gestion de la zone de blocage

             lea.l     souri_13,a1
             lea.l     wx_souris,a0
             move.w    (a0)+,d0             ;x
             move.w    (a0),d1              ;y

             cmp.w     (a1)+,d0
             bge.s     suite0
             move.w    -2(a1),d0
suite0:      cmp.w     (a1)+,d1
             bge.s     suite1
             move.w    -2(a1),d1
suite1:      cmp.w     (a1)+,d0
             blt.s     suite2
             move.w    -2(a1),d0
suite2:      cmp.w     (a1),d1
             blt.s     suite3
             move.w    (a1),d1
suite3:      




;gestion des blocs de changementde forme

             moveq.l   #1,d3
             lea.l     souri_14,a1
             move.w    #nbchmot-1,d2

loop:        
             move.w    (a1)+,d4
             blt.s     nochange
             move.w    (a1)+,d5
             move.w    (a1)+,d6
             move.w    (a1)+,d7
             addq.l    #2,a1

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d0,d2
             move.w    d1,d3
             addi.w    #15,d2
             addi.w    #15,d3
             bsr       intersec
             tst.w     d7
             movem.l   (sp)+,d0-d7/a0-a6
             beq       finloop

             move.w    -2(a1),d3            ;changement de motif
             move.w    #nbchmot,d7
             sub.w     d2,d7
             bra.s     inbloc

finloop:     
             dbra      d2,loop
nochange:    
             clr.w     d7
inbloc:      
             move.w    d3,souri_9           ;motif souris
             move.w    d7,souri_6           ;numero du bloc
             lea.l     souri_7,a0
             move.w    d0,(a0)+             ;x
             move.w    d1,(a0)+             ;y
             lea.l     wx_souris,a0
             move.w    d0,(a0)+             ;x
             move.w    d1,(a0)+             ;y

             move.w    souri_11,d3
             blt       rts                  ;pas de motif prioritaire
             move.w    d3,souri_9
             rts       

;---------------------------------------------------------------
;
; souri_2
;
; deselection
;

souri_2::    
             move.w    #$2700,sr
             move.l    exvbl,$70
             move.w    #$2300,sr
             rts       

;---------------------------------------------------------------
;
; intersec
;
; recherche du rectangle commun entre 2 rectangles
;
; entree:  d0,d1,d2,d3 coordonnees du rectangle 1
;          d4,d5,d6,d7 coordonnees du rectangle 2
;
; retour:  d0,d1,d2,d3 coordonnees du rectangle commun (s'il existe)
;          d7=0 s'il n'existe pas
;

intersec:    
             clr.w     inter2
             clr.w     inter
             cmp.w     d0,d4
             blt       fig1
             cmp.w     d2,d6
             bgt       fig1
             move.w    d4,d0
             move.w    d6,d2
             move.w    #-1,inter
             bra       ordonnee
fig1:        
             cmp.w     d0,d4
             bgt       fig2
             cmp.w     d0,d6
             blt       fig2
             cmp.w     d2,d6
             bgt       fig2
             move.w    d6,d2
             move.w    #-1,inter
             bra       ordonnee
fig2:        
             cmp.w     d0,d4
             blt       fig3
             cmp.w     d2,d4
             bgt       fig3
             cmp.w     d2,d6
             blt       fig3
             move.w    d4,d0
             move.w    #-1,inter
             bra       ordonnee
fig3:        
             cmp.w     d4,d0
             blt       ordonnee
             cmp.w     d6,d2
             bgt       ordonnee
             move.w    #-1,inter
ordonnee:    
             cmp.w     d1,d5
             blt       fig4
             cmp.w     d3,d7
             bgt       fig4
             move.w    d5,d1
             move.w    d7,d3
             move.w    inter,inter2
             bra       e000
fig4:        
             cmp.w     d1,d5
             bgt       fig5
             cmp.w     d1,d7
             blt       fig5
             cmp.w     d3,d7
             bgt       fig5
             move.w    d7,d3
             move.w    inter,inter2
             bra       e000
fig5:        
             cmp.w     d1,d5
             blt       fig6
             cmp.w     d3,d5
             bgt       fig6
             cmp.w     d3,d7
             blt       fig6
             move.w    d5,d1
             move.w    inter,inter2
             bra       e000
fig6:        
             cmp.w     d5,d1
             blt       e000
             cmp.w     d7,d3
             bgt       e000
             move.w    inter,d7
             rts       

e000:        
             move.w    inter2,d7
             rts       



             .DATA 

souri_5::    .DC.w 0
souri_6::    .DC.w 0
souri_7::    .DC.w 0
souri_8::    .DC.w 0
souri_9::    .DC.w 0
souri_10::   .DC.w 0
souri_11::   .DC.w 0

souri_13::   .DC.w 0,20,319-16,199-20-16+1
souri_14::   
             .REPT nbchmot
             .DC.w -1,-1,-1,-1,-1
             .ENDR 

souri_15::   .DC.l motif1,motif2,motif3,motif4,motif5,motif6,motif7,motif8
             .DC.l motif9,motif10,motif11,motif12,motiflibre,motif14
             .DC.l motif15,motif16,motif17,motif18,motif19,motif20,motif21

motif1:      
             .DC.w $1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$3e,$2c,$32,$0,$0,$fe,$b2
             .DC.w $ce,$0,$0,$3fe,$c4,$13c,$202,$0,$7fe,$344,$2cc,$432,$0,$ffe
             .DC.w $6e4,$4ec,$9f2,$0,$1f1e,$d0c,$904,$1312,$0,$3fde,$1b8c,$1284
             .DC.w $2652,$0,$3ffe,$176e,$4e6,$2c32,$0,$7ffc,$16b0,$37b8,$4c64
             .DC.w $0,$77dc,$455c,$654c,$16c4,$0,$63b8,$3b0,$4390,$2388,$0
             .DC.w $6070,$6060,$6020,$2010,$0,$e0,$a0,$a0,$60,$0,$0,$0,$0,$0
             .DC.w $0

motif2:      
             .DC.w $1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$380,$280
             .DC.w $280,$380,$0,$7c0,$540,$540,$6c0,$0,$1ff0,$1390,$1390,$1c70
             .DC.w $0,$fffe,$9fe2,$9fe2,$e01e,$0,$ffff,$ffff,$fe1,$821,$0,$ffff
             .DC.w $f7df,$f7df,$f83f,$0,$3ff8,$2fe8,$2fe8,$3018,$0,$7ffe,$5ff2
             .DC.w $5ff2,$600e,$0,$ffff,$bffd,$bffd,$c003,$0,$ffff,$ffff,$ffff
             .DC.w $ffff,$0,$ffff,$ffff,$8001,$8001,$0,$ffff,$ffff,$8001,$8001
             .DC.w $0,$ffff,$ffff,$ffff,$ffff,$0

motif3:      
             .DC.w $1,$1f38,$1f38,$1f28,$1f28,$0,$1fb8,$1eb0,$12a0,$13a8,$0
             .DC.w $1ff8,$1f70,$1360,$12e8,$0,$1ffc,$1fbc,$13ac,$1264,$0,$1ffc
             .DC.w $1fd8,$13d8,$1234,$0,$1ffe,$1ffa,$13fa,$1206,$0,$1fff,$1ffd
             .DC.w $13fd,$1203,$0,$1fff,$1ffe,$13fe,$1201,$0,$1fff,$1ffd,$13fd
             .DC.w $1203,$0,$1ffe,$1ffa,$13fa,$1206,$0,$1ffc,$1fd8,$13d8,$1234
             .DC.w $0,$1ffc,$1fb4,$13a4,$126c,$0,$1ff8,$1f70,$1360,$12e8,$0
             .DC.w $1fb8,$1f30,$1320,$12a8,$0,$1fb8,$1eb8,$12a8,$13a8,$0,$1f30
             .DC.w $1f30,$1f30,$1f30,$0

motif4:      
             .DC.w $1,$0,$0,$0,$0,$0,$fffe,$fffe,$fffe,$fffe,$0,$fffe,$bffa
             .DC.w $bffa,$c006,$0,$fffe,$dff6,$9ff2,$a00a,$0,$fffe,$fffe,$bffa
             .DC.w $a00a,$0,$3ffc,$3ffc,$1ff4,$1014,$0,$ff0,$7d0,$7d0,$830
             .DC.w $0,$fffe,$efe6,$efe6,$f01e,$0,$fffe,$efee,$afea,$b01a,$0
             .DC.w $fffe,$f7de,$97d2,$9832,$0,$7ffe,$7bbe,$4ba6,$4c66,$0,$3ff8
             .DC.w $3d78,$2548,$26c8,$0,$1ff0,$1ef0,$1290,$1390,$0,$fe0,$fe0
             .DC.w $920,$920,$0,$7c0,$6c0,$440,$540,$0,$380,$380,$380,$380
             .DC.w $0

motif5:      
             .DC.w $1,$cf8,$cf8,$cf8,$cf8,$0,$1df8,$1d78,$1548,$15c8,$0,$1df8
             .DC.w $cf8,$4c8,$1548,$0,$1ff8,$ef8,$6c8,$1748,$0,$3ff8,$2df8
             .DC.w $25c8,$3648,$0,$3ff8,$1bf8,$1bc8,$2c48,$0,$7ff8,$5ff8,$5fc8
             .DC.w $6048,$0,$fff8,$bff8,$bfc8,$c048,$0,$fff8,$7ff8,$7fc8,$8048
             .DC.w $0,$fff8,$bff8,$bfc8,$c048,$0,$7ff8,$5ff8,$5fc8,$6048,$0
             .DC.w $3ff8,$1bf8,$1bc8,$2c48,$0,$3ff8,$3df8,$35c8,$2648,$0,$1ff8
             .DC.w $ef8,$6c8,$1748,$0,$1df8,$d78,$548,$15c8,$0,$1cf8,$1cf8
             .DC.w $14f8,$14f8,$0

motif6:      
             .DC.w $5,$e000,$a000,$2000,$0,$e000,$f000,$d000,$1000,$0,$f000
             .DC.w $f000,$5000,$9000,$0,$f000,$f800,$6800,$8800,$0,$f800,$f800
             .DC.w $f800,$f800,$0,$f800,$f800,$6800,$e800,$0,$f800,$fc00,$1400
             .DC.w $e400,$0,$fc00,$fe00,$4a00,$3200,$0,$fe00,$fe00,$2400,$1800
             .DC.w $0,$fe00,$fe00,$3e00,$1e00,$0,$fe00,$f600,$f400,$400,$0
             .DC.w $f600,$f300,$f200,$f200,$0,$f300,$c300,$4200,$c200,$0,$c300
             .DC.w $f600,$1400,$7400,$0,$f600,$f000,$0,$0,$0,$f000,$f000,$b000
             .DC.w $7000,$0,$f000,$e000,$a000,$2000,$0,$e000,$f000,$d000,$1000
             .DC.w $0,$f000,$f000,$5000,$9000,$0,$f000,$f800,$6800,$8800,$0
             .DC.w $f800,$f800,$f800,$f800,$0,$f800,$f800,$6800,$e800,$0,$f800
             .DC.w $fc00,$1400,$e400,$0,$fc00,$fe00,$4a00,$3200,$0,$fe00,$fe00
             .DC.w $2400,$1800,$0,$fe00,$ff80,$3f00,$1f00,$0,$ff80,$f0c0,$f080
             .DC.w $80,$0,$f0c0,$f0c0,$7080,$f080,$0,$f0c0,$c0c0,$8080,$4080
             .DC.w $0,$c0c0,$f0c0,$5080,$3080,$0,$f0c0,$f180,$100,$100,$0,$f180
             .DC.w $f000,$b000,$7000,$0,$f000,$e000,$a000,$2000,$0,$e000,$f000
             .DC.w $d000,$1000,$0,$f000,$f000,$5000,$9000,$0,$f000,$f800,$6800
             .DC.w $8800,$0,$f800,$f800,$f800,$f800,$0,$f800,$f800,$6800,$e800
             .DC.w $0,$f800,$fc00,$1400,$e400,$0,$fc00,$fe00,$4a00,$3200,$0
             .DC.w $fe00,$fe30,$2420,$1820,$0,$fe30,$fe18,$3e10,$1e10,$0,$fe18
             .DC.w $f018,$f010,$10,$0,$f018,$f018,$d010,$3010,$0,$f018,$e018
             .DC.w $e010,$2010,$0,$e018,$f018,$5010,$3010,$0,$f018,$f030,$20
             .DC.w $20,$0,$f030,$f000,$b000,$7000,$0,$f000,$e000,$a000,$2000
             .DC.w $0,$e000,$f000,$d000,$1000,$0,$f000,$f000,$5000,$9000,$0
             .DC.w $f000,$f800,$6800,$8800,$0,$f800,$f800,$f800,$f800,$0,$f800
             .DC.w $f800,$6800,$e800,$0,$f800,$fc00,$1400,$e400,$0,$fc00,$fe06
             .DC.w $4a04,$3204,$0,$fe06,$fe03,$2402,$1802,$0,$fe03,$fe03,$3e02
             .DC.w $1e02,$0,$fe03,$f003,$f002,$2,$0,$f003,$f003,$d002,$3002
             .DC.w $0,$f003,$e003,$a002,$6002,$0,$e003,$e003,$2002,$6002,$0
             .DC.w $e003,$f003,$1002,$2,$0,$f003,$f006,$b004,$7004,$0,$f006
             .DC.w $e000,$a000,$2000,$0,$e000,$f000,$d000,$1000,$0,$f000,$f000
             .DC.w $5000,$9000,$0,$f000,$f800,$6800,$8800,$0,$f800,$f800,$f800
             .DC.w $f800,$0,$f800,$f800,$6800,$e800,$0,$f800,$fc00,$1400,$e400
             .DC.w $0,$fc00,$fe00,$4a00,$3200,$0,$fe00,$fe00,$2400,$1800,$0
             .DC.w $fe00,$fe00,$3e00,$1e00,$0,$fe00,$f000,$f000,$0,$0,$f000
             .DC.w $f000,$7000,$f000,$0,$f000,$c000,$8000,$4000,$0,$c000,$f000
             .DC.w $5000,$3000,$0,$f000,$f000,$0,$0,$0,$f000,$f000,$b000,$7000
             .DC.w $0,$f000

motif7:      
             .DC.w $9,$7ffe,$3e68,$4196,$3e68,$4196,$7ffe,$6400,$7ffe,$1bfe
             .DC.w $6400,$1ff8,$1ff8,$1ff8,$0,$0,$1ff8,$f88,$1008,$ff0,$ff0
             .DC.w $ff0,$3d0,$810,$3e0,$7e0,$7e0,$1a0,$420,$1c0,$3c0,$3c0,$c0
             .DC.w $240,$80,$180,$180,$180,$80,$0,$0,$180,$180,$80,$0,$0,$3c0
             .DC.w $140,$2c0,$0,$0,$7e0,$220,$5a0,$40,$0,$ff0,$410,$bd0,$20
             .DC.w $0,$1ff8,$8,$1f88,$70,$0,$1ff8,$1ff8,$1ff8,$0,$0,$7ffe,$5f92
             .DC.w $606e,$1f90,$606e,$7ffe,$20b4,$7ffe,$5f4a,$20b4,$7ffe,$3e68
             .DC.w $4196,$3e68,$4196,$7ffe,$6400,$7ffe,$1bfe,$6400,$1ff8,$1ff8
             .DC.w $1ff8,$0,$0,$1ff8,$8,$1f88,$70,$0,$ff0,$3d0,$810,$3e0,$7e0
             .DC.w $7e0,$1a0,$420,$1c0,$3c0,$3c0,$c0,$240,$80,$180,$180,$0
             .DC.w $0,$80,$180,$180,$0,$0,$80,$180,$3c0,$140,$2c0,$0,$0,$7e0
             .DC.w $220,$5a0,$40,$0,$ff0,$410,$bd0,$20,$0,$1ff8,$188,$1e08
             .DC.w $1f0,$180,$1ff8,$1ff8,$1ff8,$0,$0,$7ffe,$5f92,$606e,$1f90
             .DC.w $606e,$7ffe,$20b4,$7ffe,$5f4a,$20b4,$7ffe,$3e68,$4196,$3e68
             .DC.w $4196,$7ffe,$6400,$7ffe,$1bfe,$6400,$1ff8,$1ff8,$1ff8,$0
             .DC.w $0,$1ff8,$8,$1f88,$70,$0,$ff0,$410,$bd0,$20,$0,$7e0,$1a0
             .DC.w $420,$1c0,$3c0,$3c0,$c0,$240,$80,$180,$180,$0,$0,$80,$180
             .DC.w $180,$100,$0,$80,$80,$3c0,$1c0,$240,$80,$80,$7e0,$220,$5a0
             .DC.w $40,$0,$ff0,$410,$a50,$20,$180,$1ff8,$788,$1808,$7f0,$7c0
             .DC.w $1ff8,$1ff8,$1ff8,$0,$0,$7ffe,$5f92,$606e,$1f90,$606e,$7ffe
             .DC.w $20b4,$7ffe,$5f4a,$20b4,$7ffe,$3e68,$4196,$3e68,$4196,$7ffe
             .DC.w $6400,$7ffe,$1bfe,$6400,$1ff8,$1ff8,$1ff8,$0,$0,$1ff8,$8
             .DC.w $1f88,$70,$0,$ff0,$410,$bd0,$20,$0,$7e0,$220,$5a0,$40,$0
             .DC.w $3c0,$80,$200,$c0,$1c0,$180,$0,$0,$80,$180,$180,$0,$0,$80
             .DC.w $180,$3c0,$140,$2c0,$0,$0,$7e0,$220,$420,$40,$180,$ff0,$10
             .DC.w $810,$20,$7c0,$1ff8,$f88,$1008,$ff0,$fc0,$1ff8,$1ff8,$1ff8
             .DC.w $0,$0,$7ffe,$5f92,$606e,$1f90,$606e,$7ffe,$20b4,$7ffe,$5f4a
             .DC.w $20b4,$7ffe,$3e68,$4196,$3e68,$4196,$7ffe,$6400,$7ffe,$1bfe
             .DC.w $6400,$1ff8,$1ff8,$1ff8,$0,$0,$1ff8,$8,$1f88,$70,$0,$ff0
             .DC.w $410,$bd0,$20,$0,$7e0,$220,$5a0,$40,$0,$3c0,$140,$2c0,$0
             .DC.w $0,$180,$0,$0,$80,$180,$180,$0,$0,$80,$180,$3c0,$c0,$240
             .DC.w $80,$180,$7e0,$20,$420,$40,$3c0,$ff0,$3d0,$810,$3e0,$7e0
             .DC.w $1ff8,$f88,$1008,$ff0,$ff0,$1ff8,$1ff8,$1ff8,$0,$0,$7ffe
             .DC.w $5f92,$606e,$1f90,$606e,$7ffe,$20b4,$7ffe,$5f4a,$20b4,$7ffe
             .DC.w $3e68,$4196,$3e68,$4196,$7ffe,$6400,$7ffe,$1bfe,$6400,$1ff8
             .DC.w $1ff8,$1ff8,$0,$0,$1ff8,$8,$1f88,$70,$0,$ff0,$410,$bd0,$20
             .DC.w $0,$7e0,$220,$5a0,$40,$0,$3c0,$140,$2c0,$0,$0,$180,$180
             .DC.w $80,$0,$0,$180,$180,$80,$0,$0,$3c0,$140,$2c0,$0,$0,$7e0
             .DC.w $1e0,$420,$1c0,$3c0,$ff0,$3d0,$810,$3e0,$7e0,$1ff8,$f88
             .DC.w $1008,$ff0,$ff0,$1ff8,$1ff8,$1ff8,$0,$0,$7ffe,$5f92,$606e
             .DC.w $1f90,$606e,$7ffe,$20b4,$7ffe,$5f4a,$20b4,$e0,$60,$c0,$a0
             .DC.w $40,$f0,$50,$60,$f0,$0,$1f8,$f8,$f0,$128,$10,$1fc,$30,$fc
             .DC.w $118,$4,$1fe,$192,$17c,$e,$0,$1ff,$188,$17f,$6,$1,$1ff,$4
             .DC.w $1e7,$1b,$0,$7ff,$580,$641,$3f,$0,$fffe,$21be,$be7e,$c002
             .DC.w $0,$ff80,$3000,$e180,$d000,$1e00,$ff80,$1f80,$f080,$6f00
             .DC.w $8f00,$7f80,$4f80,$3880,$7700,$700,$3f80,$f00,$3c00,$1b80
             .DC.w $2300,$1f80,$1f00,$f00,$1480,$800,$f00,$a00,$600,$f00,$0
             .DC.w $700,$600,$300,$500,$200,$0,$0,$0,$0,$0,$c003,$4002,$c003
             .DC.w $8000,$4003,$c003,$8003,$c002,$1,$c002,$f00f,$6005,$b00e
             .DC.w $c003,$0,$f81f,$7005,$a81e,$d003,$1000,$fc3f,$7017,$a42e
             .DC.w $d001,$1802,$fe7f,$7825,$a25e,$d803,$1c00,$ffff,$7fc4,$a03f
             .DC.w $dc02,$1c01,$ffff,$fd84,$a3ff,$5c02,$9c01,$fe7f,$2e45,$e256
             .DC.w $9c2b,$5c00,$fc3f,$a425,$e426,$181b,$d800,$f81f,$e814,$a817
             .DC.w $500a,$9001,$f00f,$300d,$f00e,$8003,$4000,$c003,$8000,$c003
             .DC.w $2,$c001,$c003,$4000,$c003,$8002,$4001,$0,$0,$0,$0,$0,$700
             .DC.w $0,$700,$300,$400,$f00,$800,$600,$f00,$0,$1f00,$300,$1f00
             .DC.w $c00,$1000,$3f00,$2600,$1d00,$3a00,$200,$7f00,$7c00,$3900
             .DC.w $5400,$2600,$ff80,$bc80,$7180,$ec00,$e00,$ff80,$fc00,$e180
             .DC.w $5c00,$9e00,$fffc,$3db0,$a270,$dc0c,$1c00,$3fff,$db4,$e4d
             .DC.w $3003,$0,$1ff,$7,$1ff,$2,$1,$1ff,$10d,$17e,$87,$0,$1fe,$11e
             .DC.w $13c,$ca,$4,$1fc,$124,$138,$dc,$0,$1f8,$140,$178,$b0,$8
             .DC.w $1f0,$110,$160,$1f0,$0,$e0,$0,$e0,$c0,$20

motif8:      
             .DC.w $1,$300,$0,$200,$100,$0,$780,$280,$680,$180,$0,$fc0,$440
             .DC.w $c40,$3c0,$0,$1fe0,$820,$1820,$7e0,$0,$3ff0,$1010,$3010
             .DC.w $ff0,$0,$7ff8,$2008,$6008,$1ff8,$0,$fffc,$c004,$c004,$3ffc
             .DC.w $0,$1ff0,$cd0,$cd0,$1ff0,$0,$1ff0,$1ab0,$1ef0,$dd0,$0,$1ff0
             .DC.w $aa0,$1ef0,$dd0,$0,$1ff0,$1aa0,$1ef0,$dd0,$0,$1ff0,$aa0
             .DC.w $1ef0,$dd0,$0,$1ff0,$19a0,$1df0,$fd0,$0,$1ff0,$c60,$1ff0
             .DC.w $fd0,$0,$1ff0,$13c0,$13d0,$c30,$0,$1ff0,$800,$ff0,$1ff0
             .DC.w $0

motif9:      
             .DC.w $1,$8000,$8000,$8000,$0,$8000,$c000,$c000,$c000,$0,$c000
             .DC.w $e000,$a000,$e000,$0,$e000,$f000,$d000,$b000,$0,$f000,$f800
             .DC.w $c800,$b800,$0,$f800,$fc00,$c400,$bc00,$0,$fc00,$fe00,$c200
             .DC.w $be00,$0,$fe00,$ff00,$c100,$bf00,$0,$ff00,$ff80,$c080,$bf80
             .DC.w $0,$ff80,$ffc0,$c3c0,$bfc0,$0,$ffc0,$fe00,$f200,$8e00,$0
             .DC.w $fe00,$fe00,$fa00,$b600,$0,$fe00,$cf00,$cd00,$cb00,$0,$cf00
             .DC.w $8f80,$8d00,$8b80,$0,$8f80,$780,$680,$580,$0,$780,$700,$700
             .DC.w $700,$0,$700

motif10:     
             .DC.w $1,$3e00,$3c00,$3e00,$3e00,$0,$7f00,$6300,$6700,$7f00,$0
             .DC.w $ff80,$4180,$eb80,$f780,$0,$ffc0,$4540,$d5c0,$fbc0,$0,$ffe0
             .DC.w $4120,$e9e0,$ffe0,$0,$fff0,$6210,$73f0,$7ff0,$8000,$7ff8
             .DC.w $3c08,$3ff8,$3ff8,$4000,$3ffc,$1064,$1fbc,$1ffc,$2000,$1ffe
             .DC.w $8d2,$f6e,$ffe,$1000,$fff,$4a1,$7cf,$7ff,$800,$7ff,$240
             .DC.w $39f,$3ff,$400,$3ff,$106,$1fb,$1ff,$200,$1ff,$8d,$f6,$ff
             .DC.w $100,$ff,$4e,$7c,$7f,$80,$7f,$24,$39,$3f,$40,$3f,$10,$1f
             .DC.w $1f,$20

motif11:     
             .DC.w $3,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$ffff,$ce79,$ffff,$0,$ce79
             .DC.w $ffff,$ffff,$ffff,$0,$ffff,$ffff,$7fff,$ffff,$0,$7fff,$ffff
             .DC.w $5d43,$ffff,$0,$7fff,$ffff,$dd5a,$ffff,$0,$fffe,$ffff,$dd5a
             .DC.w $ffff,$0,$fffe,$ffff,$dd43,$ffff,$0,$ffff,$ffff,$eb5b,$ffff
             .DC.w $0,$ffff,$ffff,$775b,$ffff,$0,$7fff,$ffff,$7fff,$ffff,$0
             .DC.w $7fff,$ffff,$fffe,$ffff,$0,$fffe,$ffff,$e79e,$ffff,$0,$e79e
             .DC.w $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
             .DC.w $0,$ffff,$739e,$ffff,$0,$739e,$ffff,$7ffe,$ffff,$0,$7ffe
             .DC.w $ffff,$ffff,$ffff,$0,$ffff,$ffff,$ffdb,$dd67,$0,$ffff,$ffff
             .DC.w $ffff,$dd5b,$0,$ffff,$ffff,$ffff,$dd5b,$0,$ffff,$ffff,$7ffe
             .DC.w $dd43,$0,$7ffe,$ffff,$7ffe,$eb5b,$0,$7ffe,$ffff,$ffff,$f75b
             .DC.w $0,$ffff,$ffff,$ffff,$ffff,$0,$ffff,$ffff,$ffff,$ffff,$0
             .DC.w $ffff,$ffff,$9e79,$ffff,$0,$9e79,$0,$0,$0,$0,$0,$0,$0,$0
             .DC.w $0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$ffff,$9ce7,$ffff,$0
             .DC.w $9ce7,$ffff,$ffff,$ffff,$0,$ffff,$ffff,$fffe,$ffff,$0,$fffe
             .DC.w $ffff,$dd66,$dd43,$0,$fffe,$ffff,$5d5b,$dd5b,$0,$7fff,$ffff
             .DC.w $5d5b,$dd5b,$0,$7fff,$ffff,$dd43,$dd43,$0,$ffff,$ffff,$eb5b
             .DC.w $eb5b,$0,$ffff,$ffff,$f75a,$f75b,$0,$fffe,$ffff,$fffe,$ffff
             .DC.w $0,$fffe,$ffff,$7fff,$ffff,$0,$7fff,$ffff,$79e7,$ffff,$0
             .DC.w $79e7,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0

motif12:     
             .DC.w $c,$7c0,$440,$0,$0,$7c0,$fe0,$380,$0,$0,$fe0,$1c70,$440
             .DC.w $0,$0,$1c70,$3838,$3828,$0,$0,$2838,$3018,$1010,$0,$0,$2008
             .DC.w $3018,$2010,$0,$0,$1008,$3018,$3010,$0,$0,$3008,$38,$28
             .DC.w $0,$0,$38,$30,$0,$0,$0,$30,$60,$0,$0,$0,$60,$e0,$20,$0,$0
             .DC.w $e0,$1c0,$40,$0,$0,$1c0,$1c0,$1c0,$0,$0,$1c0,$0,$0,$0,$0
             .DC.w $0,$1c0,$c0,$0,$0,$1c0,$1c0,$c0,$0,$0,$1c0,$3e0,$0,$60,$60
             .DC.w $380,$7e0,$300,$20,$20,$4c0,$ff0,$aa0,$110,$110,$ee0,$e70
             .DC.w $440,$210,$210,$c60,$c70,$860,$410,$410,$40,$c70,$60,$410
             .DC.w $410,$840,$c70,$860,$410,$410,$840,$70,$0,$10,$10,$60,$e0
             .DC.w $e0,$0,$0,$a0,$e0,$40,$20,$20,$c0,$1c0,$180,$40,$40,$100
             .DC.w $1c0,$80,$40,$40,$100,$1c0,$180,$40,$40,$180,$0,$0,$0,$0
             .DC.w $0,$1c0,$180,$40,$40,$180,$1c0,$180,$40,$40,$180,$3c0,$280
             .DC.w $40,$40,$380,$7e0,$340,$420,$420,$c0,$7f0,$540,$30,$30,$7c0
             .DC.w $7f0,$280,$130,$130,$640,$7f0,$680,$130,$130,$240,$7f0,$2c0
             .DC.w $130,$130,$600,$7f0,$2c0,$130,$130,$600,$f0,$40,$30,$30
             .DC.w $80,$f0,$40,$30,$30,$c0,$1f0,$140,$30,$30,$1c0,$1e0,$80
             .DC.w $60,$60,$180,$1e0,$80,$60,$60,$180,$1e0,$180,$60,$60,$180
             .DC.w $0,$0,$0,$0,$0,$1e0,$180,$60,$60,$180,$1e0,$180,$60,$60
             .DC.w $180,$1c0,$80,$40,$40,$180,$1c0,$80,$40,$40,$180,$1c0,$180
             .DC.w $40,$40,$80,$1c0,$180,$40,$40,$80,$1c0,$180,$40,$40,$80
             .DC.w $1c0,$180,$40,$40,$80,$1c0,$80,$40,$40,$180,$1c0,$80,$40
             .DC.w $40,$180,$1c0,$100,$c0,$c0,$100,$1c0,$100,$c0,$c0,$100,$1c0
             .DC.w $100,$c0,$c0,$100,$1c0,$180,$40,$40,$80,$1c0,$80,$40,$40
             .DC.w $180,$0,$0,$0,$0,$0,$1c0,$80,$40,$40,$180,$1c0,$80,$40,$40
             .DC.w $180,$1e0,$1a0,$0,$0,$160,$3f0,$1c0,$10,$10,$3e0,$7f0,$710
             .DC.w $e0,$e0,$710,$7f0,$200,$1e0,$1e0,$610,$7b0,$610,$1a0,$1a0
             .DC.w $200,$7b0,$600,$1a0,$1a0,$210,$7b0,$610,$1a0,$1a0,$210,$780
             .DC.w $200,$180,$180,$600,$780,$700,$80,$80,$700,$3c0,$100,$c0
             .DC.w $c0,$300,$3c0,$80,$240,$240,$180,$1c0,$80,$40,$40,$180,$1c0
             .DC.w $180,$40,$40,$180,$0,$0,$0,$0,$0,$1c0,$180,$40,$40,$180
             .DC.w $1c0,$180,$40,$40,$180,$1e0,$120,$0,$0,$1e0,$3f0,$210,$c0
             .DC.w $c0,$330,$7f8,$408,$1e0,$1e0,$618,$ff8,$408,$be0,$be0,$418
             .DC.w $f38,$808,$330,$330,$c00,$f38,$800,$330,$330,$c08,$f38,$c08
             .DC.w $330,$330,$c08,$f00,$c00,$300,$300,$c00,$f00,$0,$b00,$b00
             .DC.w $400,$780,$600,$180,$180,$600,$3c0,$300,$c0,$c0,$300,$1c0
             .DC.w $100,$c0,$c0,$100,$1c0,$100,$c0,$c0,$100,$0,$0,$0,$0,$0
             .DC.w $1c0,$100,$c0,$c0,$100,$1c0,$100,$c0,$c0,$100,$3e0,$2a0
             .DC.w $0,$0,$360,$7f0,$5c0,$0,$0,$3f0,$ff8,$230,$1c0,$1c0,$e28
             .DC.w $1c1c,$1414,$0,$0,$1c1c,$1c0c,$808,$400,$400,$1004,$1c0c
             .DC.w $1800,$400,$400,$c,$1c0c,$80c,$400,$400,$100c,$1c00,$1c00
             .DC.w $0,$0,$1400,$e00,$400,$200,$200,$800,$700,$200,$100,$100
             .DC.w $400,$380,$0,$80,$80,$300,$1c0,$100,$40,$40,$80,$1c0,$180
             .DC.w $40,$40,$180,$0,$0,$0,$0,$0,$1c0,$180,$40,$40,$180,$1c0
             .DC.w $180,$40,$40,$180,$1f0,$0,$1f0,$1f0,$0,$3f8,$280,$38,$38
             .DC.w $340,$7f8,$5c0,$18,$18,$7e0,$7f8,$320,$d8,$d8,$720,$738
             .DC.w $620,$118,$118,$220,$738,$620,$118,$118,$220,$738,$220,$118
             .DC.w $118,$620,$780,$700,$80,$80,$700,$7c0,$100,$4c0,$4c0,$300
             .DC.w $3c0,$280,$40,$40,$380,$1c0,$180,$40,$40,$80,$1c0,$100,$40
             .DC.w $40,$180,$1c0,$180,$40,$40,$180,$0,$0,$0,$0,$0,$1c0,$180
             .DC.w $40,$40,$180,$1c0,$180,$40,$40,$180,$1e0,$0,$1e0,$1e0,$0
             .DC.w $3f0,$280,$70,$70,$380,$3f0,$340,$30,$30,$1c0,$7f0,$480
             .DC.w $130,$130,$6c0,$7f0,$2c0,$130,$130,$680,$7f0,$6c0,$130,$130
             .DC.w $280,$7f0,$680,$130,$130,$2c0,$780,$200,$180,$180,$600,$7c0
             .DC.w $400,$1c0,$1c0,$600,$3c0,$100,$c0,$c0,$300,$3c0,$300,$c0
             .DC.w $c0,$200,$1c0,$0,$c0,$c0,$100,$1c0,$100,$c0,$c0,$100,$0
             .DC.w $0,$0,$0,$0,$1c0,$100,$c0,$c0,$100,$1c0,$100,$c0,$c0,$100
             .DC.w $1c0,$40,$0,$0,$1c0,$1c0,$c0,$0,$0,$1c0,$1c0,$1c0,$0,$0
             .DC.w $c0,$1c0,$1c0,$0,$0,$c0,$1c0,$1c0,$0,$0,$c0,$1c0,$c0,$0
             .DC.w $0,$1c0,$1c0,$1c0,$0,$0,$1c0,$1c0,$0,$1c0,$1c0,$0,$1c0,$0
             .DC.w $1c0,$1c0,$0,$1c0,$1c0,$0,$0,$1c0,$1c0,$c0,$0,$0,$1c0,$1c0
             .DC.w $c0,$0,$0,$1c0,$1c0,$1c0,$0,$0,$c0,$0,$0,$0,$0,$0,$1c0,$1c0
             .DC.w $0,$0,$c0,$1c0,$c0,$0,$0,$1c0,$3c0,$40,$380,$380,$40,$7e0
             .DC.w $a0,$700,$700,$e0,$7e0,$140,$600,$600,$1e0,$7f0,$90,$640
             .DC.w $640,$1b0,$7f0,$1a0,$640,$640,$b0,$7f0,$30,$6c0,$6c0,$120
             .DC.w $7f0,$130,$6c0,$6c0,$120,$f0,$20,$c0,$c0,$30,$1f0,$10,$1c0
             .DC.w $1c0,$30,$1e0,$60,$180,$180,$40,$1e0,$20,$180,$180,$60,$1c0
             .DC.w $0,$180,$180,$40,$1c0,$40,$180,$180,$40,$0,$0,$0,$0,$0,$1c0
             .DC.w $40,$180,$180,$40,$1c0,$40,$180,$180,$40,$3c0,$1c0,$200
             .DC.w $200,$1c0,$7e0,$2a0,$400,$400,$360,$ff0,$510,$8c0,$8c0,$730
             .DC.w $ff0,$220,$9c0,$9c0,$630,$e70,$610,$860,$860,$200,$e70,$210
             .DC.w $860,$860,$600,$e70,$630,$840,$840,$620,$f0,$20,$c0,$c0
             .DC.w $30,$1f0,$50,$180,$180,$70,$1e0,$e0,$100,$100,$a0,$1c0,$80
             .DC.w $100,$100,$c0,$1c0,$40,$100,$100,$c0,$1c0,$c0,$100,$100
             .DC.w $c0,$0,$0,$0,$0,$0,$1c0,$c0,$100,$100,$c0,$1c0,$c0,$100
             .DC.w $100,$c0

motif14:     



             .DC.w $1,$180,$180,$80,$0,$0,$3c0,$3c0,$40,$0,$0,$7e0,$7e0,$20
             .DC.w $0,$0,$3c0,$3c0,$40,$0,$0,$3c0,$3c0,$40,$0,$0,$0,$0,$0,$0
             .DC.w $0,$ff0,$950,$cf0,$10,$300,$ff0,$610,$f10,$f0,$300,$1ff8
             .DC.w $1208,$1f08,$f8,$700,$1ff8,$fb8,$1fb8,$48,$600,$3ffc,$2df4
             .DC.w $3ff4,$c,$600,$3ffc,$15ac,$3fac,$54,$e00,$7ffe,$5fea,$7fea
             .DC.w $16,$c00,$7ffe,$2bbe,$7fbe,$42,$1c00,$ffff,$ffff,$ffff,$ffff
             .DC.w $0,$ffff,$0,$ffff,$ffff,$0
motif15:     
             .DC.w $1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0,$490,$0,$490,$0,$490,$2492
             .DC.w $0,$2492,$0,$2492,$97f2,$0,$97f2,$0,$97f2,$5ffc,$660,$5e7c
             .DC.w $180,$581c,$7ffe,$15a8,$7dbe,$3c0,$6006,$ffff,$4242,$fbdf
             .DC.w $760,$8001,$ffff,$8241,$fbdf,$7e0,$0,$ffff,$45a2,$fdbf,$3c0
             .DC.w $8001,$7fff,$1248,$7e7f,$180,$6007,$5ffc,$420,$5ffc,$0,$581c
             .DC.w $17f4,$0,$17f4,$0,$17f4,$490,$0,$490,$0,$490,$0,$0,$0,$0
             .DC.w $0,$0,$0,$0,$0,$0



motif16:     
             .DC.w $6,$1fe,$144,$182,$0,$1fe,$1ff,$11a,$181,$0,$1ff,$3ff,$ad
             .DC.w $310,$0,$3ff,$3ff,$b4,$178,$0,$3ff,$3ff,$2c4,$1f8,$30,$3cf
             .DC.w $3ff,$3e2,$3fc,$10,$3ef,$3ff,$4b,$3c,$10,$3ef,$3ff,$cd,$3e
             .DC.w $10,$3ef,$3ff,$20b,$3fc,$10,$3ef,$3ff,$22,$21c,$18,$3e7
             .DC.w $3ff,$74,$21e,$8,$3f7,$1ff,$115,$1fe,$8,$1f7,$1ff,$a2,$11f
             .DC.w $c,$1f3,$ff,$21,$ff,$1e,$e1,$0,$0,$0,$0,$0,$0,$0,$0,$0,$0
             .DC.w $7f8,$510,$608,$0,$7f8,$7fc,$468,$604,$0,$7fc,$fff,$2b5
             .DC.w $c43,$0,$fff,$fff,$2d3,$5e1,$0,$fff,$fff,$b12,$7e1,$c0,$f3f
             .DC.w $fff,$f8a,$ff1,$40,$fbf,$fff,$12e,$f1,$40,$fbf,$fff,$334
             .DC.w $fb,$40,$fbf,$fff,$82f,$ff0,$40,$fbf,$fff,$8a,$871,$60,$f9f
             .DC.w $fff,$1d2,$879,$20,$fdf,$7ff,$457,$7f9,$20,$7df,$7ff,$28b
             .DC.w $47f,$30,$7cf,$3fc,$84,$3fc,$78,$384,$0,$0,$0,$0,$0,$0,$0
             .DC.w $0,$0,$0,$1fe0,$1440,$1820,$0,$1fe0,$1ff0,$11a0,$1810,$0
             .DC.w $1ff0,$3fff,$ad7,$310f,$0,$3fff,$3fff,$b4c,$1787,$0,$3fff
             .DC.w $3fff,$2c48,$1f84,$300,$3cff,$3fff,$3e28,$3fc4,$100,$3eff
             .DC.w $3fff,$4bb,$3c4,$100,$3eff,$3fff,$cd0,$3ef,$100,$3eff,$3fff
             .DC.w $20bc,$3fc0,$100,$3eff,$3fff,$22b,$21c4,$180,$3e7f,$3fff
             .DC.w $74b,$21e4,$80,$3f7f,$1fff,$115c,$1fe7,$80,$1f7f,$1ffc,$a2c
             .DC.w $11fc,$c0,$1f3c,$ff0,$210,$ff0,$1e0,$e10,$0,$0,$0,$0,$0
             .DC.w $0,$0,$0,$0,$0,$9fe0,$1440,$1820,$8000,$1fe0,$5ff0,$11a0
             .DC.w $1810,$4000,$1ff0,$3fff,$ad7,$310f,$0,$3fff,$3fff,$b4c,$1787
             .DC.w $0,$3fff,$3fff,$2c48,$1f84,$300,$3cff,$3fff,$3e28,$3fc4
             .DC.w $100,$3eff,$ffff,$4bb,$3c4,$c100,$3eff,$3fff,$cd0,$3ef,$100
             .DC.w $3eff,$3fff,$20bc,$3fc0,$100,$3eff,$3fff,$22b,$21c4,$180
             .DC.w $3e7f,$3fff,$74b,$21e4,$80,$3f7f,$5fff,$115c,$1fe7,$4080
             .DC.w $1f7f,$9ffc,$a2c,$11fc,$80c0,$1f3c,$ff0,$210,$ff0,$1e0,$e10
             .DC.w $800,$0,$0,$800,$0,$1000,$0,$0,$1000,$0,$9fe0,$9440,$9820
             .DC.w $0,$1fe0,$5ff0,$51a0,$5810,$0,$1ff0,$3fff,$ad7,$310f,$0
             .DC.w $3fff,$3fff,$b4c,$1787,$0,$3fff,$3fff,$2c48,$1f84,$300,$3cff
             .DC.w $3fff,$3e28,$3fc4,$100,$3eff,$ffff,$c4bb,$c3c4,$100,$3eff
             .DC.w $3fff,$cd0,$3ef,$100,$3eff,$3fff,$20bc,$3fc0,$100,$3eff
             .DC.w $3fff,$22b,$21c4,$180,$3e7f,$3fff,$74b,$21e4,$80,$3f7f,$5fff
             .DC.w $515c,$5fe7,$80,$1f7f,$9ffc,$8a2c,$91fc,$c0,$1f3c,$ff0,$210
             .DC.w $ff0,$1e0,$e10,$800,$800,$800,$0,$0,$1000,$1000,$1000,$0
             .DC.w $0,$9fe0,$9440,$9820,$0,$1fe0,$5ff0,$11a0,$5810,$0,$1ff0
             .DC.w $3fff,$ad7,$310f,$0,$3fff,$3fff,$b4c,$1787,$0,$3fff,$3fff
             .DC.w $2c48,$1f84,$300,$3cff,$3fff,$3e28,$3fc4,$100,$3eff,$ffff
             .DC.w $84bb,$c3c4,$100,$3eff,$3fff,$cd0,$3ef,$100,$3eff,$3fff
             .DC.w $20bc,$3fc0,$100,$3eff,$3fff,$22b,$21c4,$180,$3e7f,$3fff
             .DC.w $74b,$21e4,$80,$3f7f,$5fff,$115c,$5fe7,$80,$1f7f,$9ffc,$8a2c
             .DC.w $91fc,$c0,$1f3c,$ff0,$210,$ff0,$1e0,$e10,$800,$0,$800,$0
             .DC.w $0,$1000,$1000,$1000,$0,$0

motif17:     
             .DC.w $1,$7ffe,$500a,$5ffa,$2006,$0,$ffff,$9069,$9ff9,$6067,$0
             .DC.w $ffff,$9069,$9ff9,$6067,$0,$ffff,$9069,$9ff9,$6067,$0,$ffff
             .DC.w $8ff1,$8ff1,$700f,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$8001
             .DC.w $8001,$7fff,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$9ff9,$9ff9
             .DC.w $6007,$0,$ffff,$bffd,$a005,$4003,$0,$ffff,$befd,$a105,$4103
             .DC.w $100,$ffff,$b00d,$a305,$4303,$ff0,$ffff,$fefd,$a105,$103
             .DC.w $4100,$ffff,$f00d,$e105,$103,$4ff0,$ffff,$befd,$a105,$c103
             .DC.w $100,$7ffe,$700e,$6006,$4002,$ff0

motif18:     
             .DC.w $1,$7ffe,$500a,$5ffa,$2006,$0,$ffff,$9069,$9ff9,$6067,$0
             .DC.w $ffff,$9069,$9ff9,$6067,$0,$ffff,$9069,$9ff9,$6067,$0,$ffff
             .DC.w $8ff1,$8ff1,$700f,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$8001
             .DC.w $8001,$7fff,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$9ff9,$9ff9
             .DC.w $6007,$0,$ffff,$bffd,$a005,$4003,$0,$ffff,$be7d,$a185,$4183
             .DC.w $180,$ffff,$b00d,$a045,$4043,$ff0,$ffff,$ff7d,$a085,$83
             .DC.w $4080,$ffff,$f00d,$e105,$103,$4ff0,$ffff,$be3d,$a1c5,$c1c3
             .DC.w $1c0,$7ffe,$700e,$6006,$4002,$ff0

motif19:     
             .DC.w $1,$7ffe,$500a,$5ffa,$2006,$0,$ffff,$9069,$9ff9,$6067,$0
             .DC.w $ffff,$9069,$9ff9,$6067,$0,$ffff,$9069,$9ff9,$6067,$0,$ffff
             .DC.w $8ff1,$8ff1,$700f,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$8001
             .DC.w $8001,$7fff,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$9ff9,$9ff9
             .DC.w $6007,$0,$ffff,$bffd,$a005,$4003,$0,$ffff,$bc7d,$a385,$4383
             .DC.w $380,$ffff,$b00d,$a085,$4083,$ff0,$ffff,$fe7d,$a185,$183
             .DC.w $4180,$ffff,$f00d,$e085,$83,$4ff0,$ffff,$bc7d,$a385,$c383
             .DC.w $380,$7ffe,$700e,$6006,$4002,$ff0

motif20:     
             .DC.w $1,$7ffe,$500a,$5ffa,$2006,$0,$ffff,$9069,$9ff9,$6067,$0
             .DC.w $ffff,$9069,$9ff9,$6067,$0,$ffff,$9069,$9ff9,$6067,$0,$ffff
             .DC.w $8ff1,$8ff1,$700f,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$8001
             .DC.w $8001,$7fff,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$9ff9,$9ff9
             .DC.w $6007,$0,$ffff,$bffd,$a005,$4003,$0,$ffff,$befd,$a105,$4103
             .DC.w $100,$ffff,$b00d,$a105,$4103,$ff0,$ffff,$fd7d,$a285,$283
             .DC.w $4280,$ffff,$f00d,$e3c5,$3c3,$4ff0,$ffff,$bf7d,$a085,$c083
             .DC.w $80,$7ffe,$700e,$6006,$4002,$ff0

motif21:     
             .DC.w $1,$7ffe,$500a,$5ffa,$2006,$0,$ffff,$9069,$9ff9,$6067,$0
             .DC.w $ffff,$9069,$9ff9,$6067,$0,$ffff,$9069,$9ff9,$6067,$0,$ffff
             .DC.w $8ff1,$8ff1,$700f,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$8001
             .DC.w $8001,$7fff,$0,$ffff,$8001,$8001,$7fff,$0,$ffff,$9ff9,$9ff9
             .DC.w $6007,$0,$ffff,$bffd,$a005,$4003,$0,$ffff,$bc3d,$a3c5,$43c3
             .DC.w $3c0,$ffff,$b00d,$a205,$4203,$ff0,$ffff,$fc7d,$a385,$383
             .DC.w $4380,$ffff,$f00d,$e045,$43,$4ff0,$ffff,$b87d,$a785,$c783
             .DC.w $780,$7ffe,$700e,$6006,$4002,$ff0

deltaxj:     .DC.w 0
deltayj:     .DC.w 0

             .BSS 

savessp:     .DS.l 1
exvect:      .DS.l 1
exvect2:     .DS.l 1
exvect3:     .DS.l 1
exsr:        .DS.w 1
souri_18::   .DS.w 1
delta_x:     .DS.w 1
delta_y:     .DS.w 1

wx_souris::  .DS.w 1
wy_souris::  .DS.w 1

mousek:      .DS.w 1
exvbl:       .DS.l 1

inter:       .DS.w 1
inter2:      .DS.w 1


xfondphy:    .DS.w 1
yfondphy:    .DS.w 1
sourisfond:  .DS.b 256
motifphy:    .DS.w 1
etapemotif:  .DS.w 1
exetapemotif:          .DS.w 1

motiflibre:  
             .DS.w 1+16*5

flashcol0::  .DS.w 1




