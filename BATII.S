;---------------------------------------------------------------
; B.A.T II          27/2/92
;

;##### modif apres listing du 24/2/92


protege      equ 1

son          equ 1

_quattro     equ 0

_simu        equ 0
_via         equ 0
_combat      equ 0
_chidam      equ 0
_tubular     equ 0
_bob         equ 1
_interchap   equ 0
_glad        equ 0

boot         equ 1
disquedur    equ 0

st1ag3       equ 1
st160ag40    equ 160

heuredebutjeu          equ 16

nbload       equ 0     ;nombre de lieux a charger-1 (de 0 a 33)
nbload2      equ -1    ;nombre de lieux a charger-1 (de 0 a 15)
nbload3      equ -1    ;nombre de lieux a charger-1 (de 0 a 6)
nbload4      equ -1    ;nombre de lieux a charger-1 (de 0 a 10)
nbload5      equ -1    ;nombre de lieux a charger-1 (de 0 a 25)
nbload6      equ -1    ;nombre de lieux a charger-1 (de 0 a 34)
nbload7      equ -1    ;nombre de lieux a charger-1 (de 0 a 10)

imagedebut   equ 100

debug        equ 0
debug2       equ 1

nosondebut   equ 3000
nosonfin     equ 3999

;newtache0
;newtache0loop
;newtache1
;biitempoprog
;specialbii
;biicond
;fenetreevi
;clic
;biic0

;objracine
;combatmain

;bss
;data


             .MACRO JSR_TEXTX
             .DC.w $a000
             .ENDM 

             .MACRO JSR_PBOX
             .DC.w $a001
             .ENDM 

             .MACRO JSR_RND
             .DC.w $a002
             .ENDM 

             .MACRO JSR_PUTTCX
             .DC.w $a003
             .ENDM 

             .MACRO JSR_ECRSWAP
             .DC.w $a004
             .ENDM 

             .MACRO JSR_RELACHE
             .DC.w $a005
             .ENDM 

             .MACRO JSR_BOITE
             .DC.w $a006
             .ENDM 

             .MACRO LEA_MENUTXLSTA1
             .DC.w $a007
             .ENDM 

             .MACRO JSR_SCENATSTBIT
             .DC.w $a008
             .ENDM 

             .MACRO JSR_SCENASETBIT
             .DC.w $a009
             .ENDM 

             .MACRO JSR_AFFINTERPEL
             .DC.w $a00a
             .ENDM 

             .MACRO JSR__AFF
             .DC.w $a00b
             .ENDM 

             .MACRO JSR_MEMFINDBLOC
             .DC.w $a00c
             .ENDM 

             .MACRO JSR_TRAITEEXP
             .DC.w $a00d
             .ENDM 

             .TEXT 

screg        equ $ff8800
scdata       equ $ff8802

mididata     equ $fffc06
midisr       equ $fffc04



;couleurs

noir         equ 0
blanc        equ 1
bleuclair    equ 2
bleu         equ 3
bleufonce    equ 4
vert         equ 5
vertfonce    equ 6
bleutresfonce          equ 7
marronclair  equ 8
marron       equ 9
marronfonce  equ 10
marrontresfonce        equ 11
orangefonce  equ 12
orange       equ 13
rouge        equ 14
vertclair    equ 15

yorg         equ 35

typetitrepro           equ 9

sourisbat    equ 1
sourisfhaut  equ 2
sourisfdroite          equ 3
sourisfbas   equ 4
sourisfgauche          equ 5
sourisinterpel         equ 6
sourissablier          equ 7
sourisutiliser         equ 8
sourismenu   equ 9
sourisbob    equ 10
sourisvia    equ 11
sourispointi           equ 12
sourislibre  equ 13
souriscredit           equ 14
sourisregarder         equ 15
sourispoing  equ 16
sourisdisque1          equ 17

messagesylvia1         equ 0
messagesylvia2         equ 1
messagesylvia3         equ 2
massigliavu  equ 3
livrelu      equ 4
boglimortvu  equ 5
attaquewelco           equ 6
attaquesenex           equ 7
tablettedecodee        equ 8
murcarperce  equ 9
coffremasperce         equ 10
journallu    equ 11
serrurezohs  equ 12
portezoopen  equ 13
partie3      equ 14
douaniervu   equ 15
puittrouve   equ 16
partie2      equ 17
manettekoshan          equ 18
partiegagnee           equ 19
combatprison           equ 20
mitar        equ 21
rationprison           equ 22
partie2fin   equ 23

animcodenop  equ $08000000
animcodefin  equ $07000000
vbljournal   equ 3*24*21846
vblattaque   equ 1000  ;temps requis entre vu et attaque
delaikoshan  equ 21846 ;1 heure jeu/6 minutes homme pour ouvrir coffre
vblsubstance           equ 21846            ;1 heure d'effet pour chaque substance

interpelx    equ 64
interpely    equ 45

enrolerlove  equ 192   ;seuil limite pour que 'enroler' reussisse
jehanleader  equ 254

rdvprobadep  equ 5     ;nombre de coups d'essai pour rejoindre le secteur du RDV

probaramasser          equ 10               ;une change sur XX de ramsser un obj a chaque deplacement
probaperdre  equ 700
probadepoub  equ 200   ;trouver un obj dans la poubelle
probaapprendre         equ 150
probavendrecher        equ 50               ;une chance sur 50 de pouvoir vendre un obj plus cher que 5000 cred.
probadormirvol         equ 50

debut:       

             lea.l     pile,sp              ;absolu !!!!


debutbatii:  
             lea.l     pile,a0
             lea.l     fast,a1
c:           
             clr.l     (a0)+
             cmpa.l    a0,a1
             bgt.s     c

             .IF boot=1
             move.w    d0,_nflops

             sub.l     memadrchip,d1
             move.l    d1,memlongchip
             clr.l     memlongfast
             tst.l     d6
             beq       pascaracteristi
             move.b    d6,jehan+perc_p
             move.b    d6,jehan+perc_c
             lsr.l     #8,d6
             move.b    d6,jehan+refl_p
             move.b    d6,jehan+refl_c
             lsr.l     #8,d6
             move.b    d6,jehan+inte_p
             move.b    d6,jehan+inte_c
             lsr.l     #8,d6
             move.b    d6,jehan+forc_p
             move.b    d6,jehan+forc_c

             move.b    d7,jehan+vita_p
             move.b    d7,jehan+vita_c
             lsr.l     #8,d7
             move.b    d7,jehan+char_p
             move.b    d7,jehan+char_c


pascaracteristi:       
             .ENDIF 

             .IF boot=0
             lea.l     pile,sp
             clr.l     -(sp)                ;passer en superviseur
             move.w    #$20,-(sp)
             trap      #1
             addq.l    #6,sp
             move.l    d0,ex_pile
             move.w    $4a6,_nflops
             move.l    $28,exlinea
             .ENDIF 

             move.l    #linea,$28

             .IF protege
             move.w    sr,d5

             move.w    #$2700,sr
             move.b    #14,$ff8800

loop:        
             bclr      #4,$ff8802           ;DTR +12V

             move.w    #5000,d0             ;           move.w   #26,d0
b0000:       
             nop                            ;le condensateur se charge
             dbra      d0,b0000

             move.b    $fffa01,d7
             andi.w    #%1000110,d7
             cmpi.w    #%1000010,d7
             bne       fin

             bset      #4,$ff8802           ;le condensateur se decharge

             nop       
             nop       
             nop       
             nop       
             nop       

             move.b    $fffa01,d6
             andi.w    #%1000110,d6
             cmp.w     d6,d7
             bne       fin

             bclr      #4,$ff8802           ;DTR +12V

             move.w    #5000,d0
b0000x:      
             nop                            ;le condensateur se charge
             dbra      d0,b0000x


             move.w    d5,sr

             .ENDIF 

             move.l    #bombes2,$8
             move.l    #bombes3,$c
             move.l    #bombes4,$10

             .IF boot=0
             move.w    #3,-(sp)
             trap      #14                  ;xbios(3)
             addq.l    #2,sp
             move.l    d0,sys00
             move.l    d0,sys01
             move.l    d0,exphy
             .ENDIF 

             .IF protege
             jsr       implantdiv0
             .ENDIF 

             move.l    #ecran,d0
             addi.l    #255,d0
             andi.w    #$ff00,d0
             move.l    d0,sys01

             addi.l    #32000,d0
             jsr       chphy

             moveq.l   #20,d0
             jsr       effalignebob
             moveq.l   #14,d0
             jsr       effalignebob
             moveq.l   #8,d0
             jsr       effalignebob
             moveq.l   #2,d0
             jsr       effalignebob
             moveq.l   #0,d0
             jsr       effalignebob

             lea.l     memtable,a0
             move.w    #memnbblocmax-1,d7
             moveq.l   #0,d0
cm0x:        
             clr.l     (a0)
             lea.l     16(a0),a0
             dbra      d7,cm0x


;---------------------------------------------------------------

             .IF disquedur=1


             .IF _tubular
             move.w    #4001,d0             ;tubular
             jsr       loadov
             move.w    #904,d0              ;tubular
             jsr       load

             .ENDIF 

             .IF _chidam
             move.w    #4000,d0             ;chidam
             jsr       loadov
             move.w    #901,d0              ;chidam
             jsr       load
             .ENDIF 

             .IF _quattro
             move.w    #4002,d0             ;quattro
             jsr       loadov
             move.w    #903,d0              ;quattro
             jsr       load
             .ENDIF 

             .IF _simu
             move.w    #4003,d0
             jsr       loadov
             move.w    #6001,d0
             lea.l     nomsimu1,a0
             jsr       loaddata
             move.w    #6002,d0
             lea.l     nomsimu2,a0
             jsr       loaddata
             move.w    #6003,d0
             lea.l     nomsimu3,a0
             jsr       loaddata
             move.w    #6004,d0
             lea.l     nomsimu4,a0
             jsr       loaddata
             .ENDIF 

             move.w    #6020,d0
             lea.l     nomdial,a0
             jsr       loaddata


             .IF _via
             move.w    #4004,d0             ;via
             jsr       loadov
             move.w    #906,d0              ;via 1
             jsr       load
             move.w    #910,d0              ;via 2
             jsr       load
             .ENDIF 

             .IF _combat
             move.w    #4007,d0             ;combats
             jsr       loadov
             move.w    #909,d0              ;combat
             jsr       load
             move.w    #6005,d0
             lea.l     nomsimu5,a0
             jsr       loaddata
             .ENDIF 

             .IF _glad
             move.w    #4005,d0             ;glad
             jsr       loadov
             move.w    #907,d0
             jsr       load
             move.w    #932,d0
             jsr       load
             move.w    #933,d0
             jsr       load
             move.w    #934,d0
             jsr       load
             .ENDIF 

             .IF nbload<>-1
             moveq.l   #0+nbload,d7
bl:          
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #100+nbload,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl
             .ENDIF 

             .IF nbload2<>-1
             moveq.l   #0+nbload2,d7
bl0:         
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #200+nbload2,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl0
             .ENDIF 

             .IF nbload3<>-1
             moveq.l   #0+nbload3,d7
bl03:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #300+nbload3,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl03
             .ENDIF 

             .IF nbload4<>-1
             moveq.l   #0+nbload4,d7
bl04:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #400+nbload4,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl04
             .ENDIF 

             .IF nbload5<>-1
             moveq.l   #0+nbload5,d7
bl05:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #500+nbload5,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl05
             .ENDIF 

             .IF nbload6<>-1
             moveq.l   #0+nbload6,d7
bl06:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #600+nbload6,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl06
             .ENDIF 


             .IF nbload7<>-1
             moveq.l   #0+nbload7,d7
bl07:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #700+nbload7,d0
             sub.w     d7,d0
             jsr       load
             addq.l    #1,contvbl
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,bl07
             .ENDIF 

             .IF _interchap
             move.w    #951,d0
             jsr       load
             move.w    #952,d0
             jsr       load
             move.w    #953,d0
             jsr       load
             move.w    #954,d0
             jsr       load
             move.w    #955,d0
             jsr       load
             move.w    #957,d0
             jsr       load
             move.w    #958,d0
             jsr       load
             .ENDIF 


             .IF _bob
             move.w    #902,d0              ;bob
             jsr       load
             .ENDIF 

             move.w    #900,d0              ;inventaire
             jsr       load


             move.w    #911,d0              ;interpel
             jsr       load


             .ENDIF 




;---------------------------------------------------------------

             move.l    #bsour,adrbsour

             jsr       mfp_1
             bclr      #4,$fffa09           ;td coupe
             bclr      #5,$fffa09           ;tc coupe
             bclr      #0,$fffa07           ;tb coupe

             addq.w    #1,semait            ;ne pas remplacer en jsr multitacheoff!
             jsr       souri_1

             clr.w     souri_10



             jsr       initache

             movea.l   #pilet0,sp

             jsr       setsnd
             jsr       checksortieson

             move.w    #$2700,sr
             move.l    #timer_a3,$134
             bset      #5,$fffa13
             bset      #5,$fffa07
             move.b    #1,$fffa19
             move.b    #69-6,$fffa1f        ;69-> kHz

             bclr      #6,$fffa09           ;on coupe it clavier

             move.w    #$2300,sr

             clr.w     souri_10


             bra       newtache0
             nop       


fin:         
             .IF boot=0
             jsr       isdiskok
             bne       fin

             move.l    sys00,sys01

             move.l    exphy,d0
             jsr       chphy


             clr.b     $fffa19
             jsr       souri_2              ;deselection
             jsr       mfp_2
             bset      #5,$fffa09           ;timer c on

quit:        
             move.w    #$777,$ff8240+15*2

             move.l    exlinea,$28


             move.l    ex_pile,-(sp)        ;user
             move.w    #$20,-(sp)
             trap      #1
             addq.l    #6,sp

             clr.w     -(sp)
             trap      #1                   ;fin
             .ENDIF 


implantdiv0: 
             move.l    #div0,$14
             rts       

;---------------------------------------------------------------
;
; linea
;

linea:       
             subq.l    #4,sp                ;on laisse de la place pour l'adresse du sous prog

             move.w    4(sp),(sp)           ;on deplace SR
             addq.l    #2,6(sp)             ;PC=PC+2 on passe a l'instruction suivante


             movem.l   d0/a0,-(sp)
             movea.l   14(sp),a0            ;a0=PC+2
             move.w    -2(a0),d0            ;code line A
             andi.w    #$fff,d0
             lsl.w     #2,d0                ;*4 pour pointer dans table des sous prog
             lea.l     lineaprg,a0
             movea.l   0(a0,d0.w),a0        ;adresse du prog
             move.l    a0,10(sp)
             movem.l   (sp)+,d0/a0
             rte                            ;on saute au sous prog


lineaprg:    .DC.l textx,pbox,rnd,puttcx,ecrswap,relache,boite,linea007
             .DC.l scenatstbit,scenasetbit,affinterpel,_aff,memfindbloc
             .DC.l traiteexp

linea007:    
             lea.l     menutxlst,a1
             rts       

;---------------------------------------------------------------
;
; swaplove
;
; echange 'evilove' et 'evilovel7'
;

swaplove:    
             lea.l     evi,a0
swaplove0:   
             cmpi.w    #-1,(a0)
             beq       swaplove1
             move.b    evilove(a0),d0
             move.b    evilovel7(a0),evilove(a0)
             move.b    d0,evilovel7(a0)

             lea.l     evisize(a0),a0
             bra       swaplove0
swaplove1:   
             lea.l     marchand,a0
swaplove2:   
             cmpi.w    #-1,(a0)
             beq       swaplove3
             move.b    marlove(a0),d0
             move.b    marlovel7(a0),marlove(a0)
             move.b    d0,marlovel7(a0)

             lea.l     marsize(a0),a0
             bra       swaplove2
swaplove3:   
;on detruit le groupe

             lea.l     evi,a0
             lea.l     listegroupe,a1
             lea.l     missiongroupe,a2
             moveq.l   #5-1,d0
swdg0:       
             move.w    (a1)+,d1
             blt       swdg1

             move.w    #-1,-2(a1)           ;vire du groupe
             clr.l     (a2)
             move.w    #4,4(a2)

             mulu.w    #evisize,d1
             move.w    nocour,evilieudst(a0,d1.w) ;on le place dans l'image courante
             move.b    #-1,evileader(a0,d1.w)

swdg1:       
             addq.l    #6,a2
             dbra      d0,swdg0

             rts       

;---------------------------------------------------------------
;
; traiteexp
;
; entree:     d0 numero du bit de l'action
;

traiteexp:   
             lea.l     tableexp,a0
             jmp       setbitfield


;---------------------------------------------------------------
;
; boite
;
; entree:     initialiser la liste de textes dans MENUTXLST
;             d0 type de boite 0=sans reponse
;                              1=oui non
; retour:     (si oui/non) d0 numero du bloc (-1=rien)
;

boite:       
             lea.l     -18(sp),sp
             movea.l   sp,a6

             movem.l   d0-d7/a0-a6,-(sp)

             move.w    d0,-(sp)
             move.w    #128,menul
             move.w    #8+8*5,menuh
             jsr       initmenunbl
             clr.w     menuoffset

             jsr       menucentre
             jsr       affmenufond
             jsr       affmenutx2
             move.w    (sp)+,d0
             beq       boite0

             LEA_MENUTXLSTA1 
             move.l    #txboioui,(a1)+
             move.l    #-1,(a1)+
             move.w    #1,menunbl

             addi.w    #16,menux
             addi.w    #20+4,menuy

             move.w    #48,menul
             move.w    #8+8*1,menuh
             jsr       affmenufond
             jsr       affmenutx2
             addi.w    #48,menux
             LEA_MENUTXLSTA1 
             move.l    #txboinon,(a1)+
             move.l    #-1,(a1)+
             jsr       affmenufond
             jsr       affmenutx2
boite0:      
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6


             move.w    menux,d0
             move.w    menuy,d1
             subi.w    #48,d0
             move.w    d0,(a6)+
             move.w    d1,(a6)+
             addi.w    #48,d0
             addi.w    #16,d1
             move.w    d0,(a6)+
             move.w    d1,(a6)+
             subi.w    #16,d1
             move.w    d0,(a6)+
             move.w    d1,(a6)+
             addi.w    #48,d0
             addi.w    #16,d1
             move.w    d0,(a6)+
             move.w    d1,(a6)+
             move.w    #-1,(a6)+

             move.w    souri_11,-(sp)
             move.w    #sourismenu,souri_11
             JSR_RELACHE 
ab0:         
             cmpi.w    #1,souri_5
             bne       ab0

             lea.l     -18(a6),a0
             moveq.l   #-1,d7
ab4:         
             addq.w    #1,d7
             move.w    (a0)+,d0
             blt       ab1
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    souri_7,d4
             move.w    souri_8,d5

             movem.w   d7,-(sp)             ;attention ne pas remplacer movem par move
             jsr       inbloc
             movem.w   (sp)+,d7             ;n'affecte pas  XNZVC
             bne.s     ab4
             bra       ab2
ab1:         
             moveq.l   #-1,d7
ab2:         
             JSR_RELACHE 
             move.w    (sp)+,souri_11
             lea.l     18(sp),sp
             move.w    d7,d0
             rts       


;---------------------------------------------------------------
;
; newtache1
;

newtache1:   
             .IF boot=0
             tst.w     souri_10
             bne       fin
             .ENDIF 

             jsr       persoprinc
             jsr       bob_exec

             lea.l     evi,a0
             move.l    contvbl,d7
nt10:        
             cmpi.w    #-1,(a0)
             beq       nt1f

             move.l    d7,d0
             sub.l     evivblsrc(a0),d0
             cmpi.l    #764,d0
             blt       nt11

             move.w    evilieudst(a0),d0    ;destination
             move.w    d0,evilieusrc(a0)    ;dans lieu courant

             cmpi.w    #9999,d0
             beq       nt11                 ;si evi dans poubelle, on passe a evi suivant

; gestion des objets des evi

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #probaramasser,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       geobev0

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    evilieusrc(a0),d0
             addi.w    #2000,d0
             jsr       objalea
             movem.l   (sp)+,d1-d7/a0-a6
             tst.w     d0
             blt       geobev0
             bsr       geobev00

geobev0:     
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #probaperdre,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       geobev1

             movem.l   d1-d7/a0-a6,-(sp)
             move.l    a0,d0
             subi.l    #evi,d0
             divu.w    #evisize,d0
             addi.w    #3000,d0
             jsr       objalea
             movem.l   (sp)+,d1-d7/a0-a6
             tst.w     d0
             blt       geobev1

             lsl.w     #3,d0
             lea.l     objstruc,a6
             adda.w    d0,a6
             move.w    evilieusrc(a0),d0
             addi.w    #2000,d0
             move.w    d0,objpere(a6)
geobev1:     
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #probadepoub,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       geobev2

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    #9999,d0
             jsr       objalea
             movem.l   (sp)+,d1-d7/a0-a6
             tst.w     d0
             blt       geobev2
             bsr       geobev00


geobev2:     

; apprendre une nouvelle phrase

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #probaapprendre,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       apnoph0

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    #192-1,d0
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     evisavoir(a0),a0
             jsr       setbitfield
             movem.l   (sp)+,d0-d7/a0-a6



apnoph0:     

; l'info des flics se propage

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #19,d0
             JSR_RND 
             lea.l     evi,a0
             mulu.w    #evisize,d0
             tst.b     evilove(a0,d0.w)
             movem.l   (sp)+,d0-d7/a0-a6
             bne       inflpr0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       prevenirflic
             movem.l   (sp)+,d0-d7/a0-a6

inflpr0:     
             tst.b     evilove(a0)
             beq       suivreattaque

             move.l    a0,d0
             subi.l    #evi,d0
             divu.w    #evisize,d0

             movem.l   d0-d7/a0-a5,-(sp)
             jsr       eviingroupe
             movea.l   a0,a6
             movem.l   (sp)+,d0-d7/a0-a5
             beq       eviami
             bra       dephasard

geobev00:    
             lsl.w     #3,d0
             lea.l     objstruc,a6
             adda.w    d0,a6
             move.l    a0,d0
             subi.l    #evi,d0
             divu.w    #evisize,d0
             addi.w    #3000,d0
             move.w    d0,objpere(a6)
             rts       

eviami:      
             suba.l    #listegroupe,a6
             move.w    a6,d0
             mulu.w    #3,d0
             lea.l     missiongroupe,a6
             adda.w    d0,a6
             cmpi.w    #-1,(a6)
             bne       autremission         ;mission en cours
amimissionok:          
             cmpi.w    #4,4(a6)
             bne       autrelieurdv
;mission=rejoindre

             move.w    nocour,d0
             cmp.w     evilieusrc(a0),d0
             bne       suivrejehan

amiisback:   
             clr.w     (a6)                 ;reintegre dans le groupe
             clr.w     2(a6)
             move.w    #4,4(a6)
             move.w    #9999,evilieudst(a0)
             bra       nt11                 ;on passe a l'evi suivant

autrelieurdv:          
             move.w    4(a6),d0             ;lieu de rdv
             add.w     d0,d0
             lea.l     rdvtable,a5
             move.w    0(a5,d0.w),d0
             cmp.w     evilieusrc(a0),d0
             bne       dephasardmais
             cmp.w     nocour,d0
             beq       amiisback
             bra       nt11                 ;on fait les cent pas...

rdvtable:    .DC.w 521,101,117,108

dephasardmais:         
             swap.w    d0
             clr.w     d0
             swap.w    d0
             divu.w    #100,d0              ;numero de secteur souhaite

;on a 'rdvprobadep' chances d'aller dans la bonne direction
;sinon tant pis...

             move.w    evilieusrc(a0),d0
             moveq.l   #rdvprobadep-1,d7
dhm0:        
             movem.l   d0-d7/a0-a5,-(sp)
             bsr       fromto
             movem.l   (sp)+,d0-d7/a0-a5
             move.w    (a6),evilieudst(a0)  ;nouvelle destination
             moveq.l   #0,d1
             move.w    (a6),d1
             divu.w    #100,d1
             cmp.w     d0,d1
             beq       depsuite
             dbra      d7,dhm0


             bra       depsuite

autremission:          
             cmpi.w    #2,(a6)
             beq       missionapp
; trouver objet

             move.w    2(a6),d1             ;type de l'objet a trouver

             move.w    evilieusrc(a0),d0
             addi.w    #2000,d0             ;par terre

             movem.l   d0-d7/a0-a4/a6,-(sp)
             jsr       findobjtype
             movea.l   a6,a5
             movem.l   (sp)+,d0-d7/a0-a4/a6
             bne       dephasard

             move.l    a0,d0
             subi.l    #evi,d0
             divu.w    #evisize,d0
             addi.w    #6000,d0
             move.w    d0,objpere(a5)

             move.w    #-1,(a6)             ;mission accomplie !
             bra       amimissionok


missionapp:  
             moveq.l   #0,d1
             move.b    eviintel(a0),d1
             divu.w    #25,d1

             movem.l   d1-d7/a0-a6,-(sp)
             moveq.l   #100,d0
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6

             cmp.w     d0,d1
             blt       dephasard

             move.w    2(a6),d7             ;numero de sujet
             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge

             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    4(a0),a0
             movea.l   a0,a1
             movem.l   (sp)+,d0-d7/a1-a6

             moveq.l   #0,d0                ;no de phrase
mapp0:       
             cmpi.w    #-1,(a1)
             beq       mapp1

             movea.l   a1,a2
             adda.w    (a1)+,a2             ;adresse de la phrase suivante
             cmp.w     (a1),d7
             bne       mapp2


             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     evisavoir(a0),a0
             jsr       setbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             beq       dephasard

mapp2:       
             movea.l   a2,a1
             addq.w    #1,d0
             bra       mapp0

mapp1:       
             move.w    #-1,(a6)             ;mission accomplie !
             bra       amimissionok


; si un evi deteste le joueur (evilove=0), il essaye de le suivre pour l'attaquer
suivreattaque:         
             cmp.w     nocour,d0
             beq       eviattaque

suivrejehan: 
             lea.l     dynooffset,a6
t1dox:       
             cmp.w     (a6)+,d0
             beq.s     t1do1x
             addq.l    #2,a6
             bra.s     t1dox
t1do1x:      
;a6 pointe sur 'dyno???'
             move.w    nocour,d0
adjasuite:   
             addq.l    #4,a6
             move.w    -4(a6),d1
             blt       dephasard            ;Jehan pas trouve dans lieu adjacent
             cmp.w     d0,d1
             bne       adjasuite
             move.w    d0,evilieudst(a0)    ;nouvelle destination
             bra       depsuite



;deplacement au hasard

;---------------------------------------------------------------
;remarque:
;
; pour la version PC, on pourrait envisager une gestion plus complexe
; des deplacements... avec une recherche de lieu 'but', de proche en
; proche... eventuellement de facon recursive...
;

;---------------------------------------------------------------
;
; fromto
;
; entree:     d0 numero de lieu de depart
;
; retour:     a6 pointe sur le resultat
;

fromto:      
             lea.l     dynooffset,a6
t1do:        
             cmp.w     (a6)+,d0
             beq.s     t1do1
             addq.l    #2,a6
             bra.s     t1do
t1do1:       

             moveq.l   #0,d0
             move.w    (a6),d0              ;offset
             addi.l    #dyno,d0             ;adresse
             movea.l   d0,a6
t1do2:       
             tst.w     (a6)+
             bge.s     t1do2

             suba.l    d0,a6
             subq.w    #2+1,a6

             exg.l     d0,a6


             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6
             bclr      #0,d0
             bclr      #1,d0
             adda.w    d0,a6
             rts       

;---------------------------------------------------------------
;
; dephasard
;

dephasard:   
             move.w    evilieusrc(a0),d0
             bsr       fromto
             move.w    (a6),evilieudst(a0)  ;nouvelle destination
depsuite:    
             move.w    nocour,d1
             cmp.w     evilieusrc(a0),d1
             bne       nt11                 ;le perso n'arrive pas dans le lieu courant

             tst.w     doaffperso
             bne       nt11                 ;il y a deja quelqu'un d'affiche dans ce lieu
             move.w    2(a6),d0
             cmpi.w    #pasvisible,d0
             beq       nt11
             move.w    d0,senspersocour

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       compoperso2
             movem.l   (sp)+,d0-d7/a0-a6

nt11:        
             lea.l     evisize(a0),a0
             bra       nt10
nt1f:        
;nt1suite:              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
             tst.w     stoptache1
             beq       newtache1
             moveq.l   #0,d0
             jsr       allertache
             bra       newtache1

compoperso:  
             tst.w     senspersocour
             beq       mm0
             bset      #30,d0
mm0:         
             bset      #31,d0


             jsr       makeperso
             jsr       clipoff
             lea.l     perso,a0
             lea.l     perso48a,a1
             move.w    persogroupdecal,d0
             moveq.l   #0,d1
             moveq.l   #32,d2
             moveq.l   #62,d3
             moveq.l   #48/2,d4
             jmp       puttcx


compoperso2: 
             move.l    evicodegen(a0),d0
             move.l    d0,codegenetique

             suba.l    #evi,a0
             move.l    a0,d7
             divu.w    #evisize,d7
             move.w    d7,evicourt1

             lea.l     perso48a,a0

             moveq.l   #62-1,d7
bcp0:        
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+

             dbra      d7,bcp0

             clr.w     persogroupdecal
             lea.l     evi,a0
             move.w    evicourt1,d0
compop0:     
             cmpi.w    #-1,(a0)
             beq       compop1

             cmp.b     evileader(a0),d0
             bne       compop2

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    evicodegen(a0),d0
             bsr       compoperso
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #2,persogroupdecal
compop2:     
             lea.l     evisize(a0),a0
             bra       compop0

compop1:     
             move.l    codegenetique,d0
             bsr       compoperso
             jsr       makeperso2


             lea.l     evi,a0
             move.w    evicourt1,d0
             mulu.w    #evisize,d0
             move.l    contvbl,evivblsrc(a0,d0.w)

             move.w    #-1,doaffperso
             rts       

eviattaque:  
             tst.w     psy
             beq       eviattaque1
             move.w    #-1,flashcol0
eviattaque1: 

             subq.w    #1,semait            ;debut SECTION CRITIQUE
             tst.l     attaqueprem
             bne       eviattaque0

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    contvbl,d0
             addi.l    #vblattaque,d0
             move.l    d0,attaqueprem
             suba.l    #evi,a0
             move.l    a0,d0
             divu.w    #evisize,d0
             move.w    d0,attaqueprem+4
             movem.l   (sp)+,d0-d7/a0-a6




eviattaque0: 
             addq.w    #1,semait            ;fin SECTION CRITIQUE
             bra       nt11


;---------------------------------------------------------------
;
; eviingroupe
;
; recherche si un evi fait partie du groupe
;
; entree:     d0 numero de l'evi
;
; retour:     Z=1 si la condition est vraie
;             si Z=1 a0 pointe sur LISTEGROUPE+offsetevi
;

eviingroupe: 
             lea.l     listegroupe,a0
             moveq.l   #5-1,d7
vprc0:       
             cmp.w     (a0)+,d0
             beq       eviig0
             dbra      d7,vprc0
             moveq.l   #-1,d0               ;Z=0
             rts       
eviig0:      
             subq.l    #2,a0
             rts                            ;Z=1 car pas modifie

;---------------------------------------------------------------
;
; newtache0
;

newtache0:   

;on loue le manoir de mantoue pour 8 jours
             move.l    #4194304,marvbl+marchand

             move.w    #0,coinx
             move.w    #yorg,coiny
             move.w    #20,xaff
             move.w    #10,yaff

; traitement du cas du disque B

             .IF disquedur=0
             move.w    #-1,disquecourb
             cmpi.w    #1,_nflops
             beq       diskb0

             LEA_MENUTXLSTA1 
             move.l    #txboi86,(a1)+
             move.l    #txboi87,(a1)+
             move.l    #txboi88,(a1)+
             move.l    #txboi89,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             move.w    #2,disquecourb       ;disk physique no 2,logique=no 3
diskb0:      
             .ENDIF 

             .IF disquedur=0
             .IF boot=0
             moveq.l   #0,d0
             jsr       demandedisque
             .ENDIF 
             .ENDIF 

             .IF disquedur=0
             moveq.l   #1,d0
             moveq.l   #9,d1
             lea.l     mapping,a0
             jsr       readi
             jsr       waitdiskok
             .ENDIF 



             move.l    #21846*heuredebutjeu,contvbl         ; 19 heure 00 min
             move.w    #-1,souri_11

             move.w    #6020,d0
             jsr       findloaddata


             move.w    #911,nocour
             jsr       biitempoprog
;        move.l   adrbiicour,adrbii911
;       move.l   adrdicour,adrdi911

             move.w    #911,d0
             jsr       memmasterkill

             lea.l     palette,a0
             jsr       degraon

             move.w    #-1,doaffperso
             move.w    #imagedebut,nocour
             jsr       biitempoprog
             jsr       inipic
             jsr       inichf
             jsr       inibloc

             lea.l     palette,a0
             jsr       degraoff


             jsr       animinit


             lea.l     evi,a0
             move.w    #204,d0
             jsr       bioinitevi
             lea.l     evi,a0
             move.w    #200,d0
             jsr       biocreerevi

             lea.l     evi,a0
             adda.w    #200*evisize,a0

; creature senex 1 (no 200)

             move.b    #128,evilove(a0)
             move.b    #128,evilovel7(a0)

             move.l    #$01002225,evicodegen(a0)
             move.b    #-1,evileader(a0)
             move.b    #100,evipotvie(a0)
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)
             move.b    #75,eviforce(a0)
             move.b    #50,eviintel(a0)
             move.b    #55,evireflex(a0)
             move.b    #60,evivital(a0)
             move.b    #40,evipercep(a0)
             move.b    #10,evicharis(a0)
             move.l    #"BIBA",evinom(a0)
             move.l    #"Z'HO",evinom+4(a0)
             move.w    #"K ",evinom+8(a0)
             clr.b     evinom+10(a0)

             lea.l     evisize(a0),a0

; creature senex 2 (no 201)

             move.b    #128,evilove(a0)
             move.b    #128,evilovel7(a0)

             move.l    #$01005441,evicodegen(a0)
             move.b    #200,evileader(a0)
             move.b    #100,evipotvie(a0)
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)
             move.b    #65,eviforce(a0)
             move.b    #40,eviintel(a0)
             move.b    #45,evireflex(a0)
             move.b    #50,evivital(a0)
             move.b    #30,evipercep(a0)
             move.b    #15,evicharis(a0)
             move.l    #"ZABI",evinom(a0)
             move.l    #"B'NI",evinom+4(a0)
             move.w    #"LI",evinom+8(a0)
             clr.b     evinom+10(a0)

             lea.l     evisize(a0),a0

; attentat welco 1 (no 202)

             move.b    #128,evilove(a0)
             move.b    #128,evilovel7(a0)

             move.l    #$00001244,evicodegen(a0)
             move.b    #-1,evileader(a0)
             move.b    #100,evipotvie(a0)
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)
             move.b    #65,eviforce(a0)
             move.b    #60,eviintel(a0)
             move.b    #45,evireflex(a0)
             move.b    #50,evivital(a0)
             move.b    #40,evipercep(a0)
             move.b    #20,evicharis(a0)
             move.l    #"NUMI",evinom(a0)
             move.l    #"TOR ",evinom+4(a0)
             move.w    #"  ",evinom+8(a0)
             clr.b     evinom+10(a0)

             lea.l     evisize(a0),a0

; attentat welco 2 (no 203)

             move.b    #128,evilove(a0)
             move.b    #128,evilovel7(a0)

             move.l    #$00002143,evicodegen(a0)
             move.b    #202,evileader(a0)
             move.b    #100,evipotvie(a0)
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)
             move.b    #80,eviforce(a0)
             move.b    #25,eviintel(a0)
             move.b    #55,evireflex(a0)
             move.b    #40,evivital(a0)
             move.b    #30,evipercep(a0)
             move.b    #10,evicharis(a0)
             move.l    #"ZIPH",evinom(a0)
             move.l    #" IRG",evinom+4(a0)
             move.w    #"OO",evinom+8(a0)
             clr.b     evinom+10(a0)


             moveq.l   #100-1,d7
fairegroupe: 
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       faireungroupe
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,fairegroupe


             jsr       initson

             jsr       initecran
             jsr       runanimstat


             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 

             lea.l     palette,a0
             jsr       degraon

             move.w    #-1,souri_11

             move.l    contvbl,d0
             move.l    d0,soifvbl
             move.l    d0,faimvbl
             move.l    d0,sommeilvbl
             move.l    d0,potvievbl
             move.l    d0,etatvbl
             move.l    d0,bobconsvbl


             subq.w    #1,semait
             moveq.l   #1,d0
             jsr       allertache


newtache0loop:         
             tst.w     pausetache0
             bgt       pt0dec

             tst.w     souri_5
             bne       clic

nt00:        
             .IF boot=0
             tst.w     souri_10
             bne       fin
             .ENDIF 

             tst.w     jehan+potvie
             beq       jehanmort

             moveq.l   #partiegagnee,d0
             JSR_SCENATSTBIT 
             bne       jehangagne


             jsr       allercombat
             jsr       testpartie3
             jsr       majfenetreevi
             jsr       casparticulier
             jsr       gestionperso
             jsr       runanimstat
             jsr       scroll

             moveq.l   #1,d0
             jsr       allertache

             .IF protege
             moveq.l   #0,d1
             divu.w    d1,d0
             .ENDIF 

             bra       newtache0loop

pt0dec:      
             subq.w    #1,pausetache0
             bne       nt00
             move.w    #-1,souri_11
             bra       nt00

;---------------------------------------------------------------
;
; allercombat
;

allercombat: 
             move.l    attaqueprem,d0
             beq       rts                  ;pas de combat prevu
             cmp.l     contvbl,d0
             bgt       rts                  ;combat prevu mais pas l'heure...

             jsr       multitacheoff
             clr.l     attaqueprem
             clr.w     flashcol0
             move.w    attaqueprem+4,evicour
             move.w    #-1,marchandcour

             jsr       savescreen
             move.w    #1,combatfuite

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill
             move.w    #6020,d0
             jsr       deverouille

             jsr       combattre2

             jsr       biitempoprog
             move.w    #6020,d0
             jsr       findloaddata

             jsr       animinit

             jsr       inichf
             jsr       inibloc

             jsr       initecran
             jsr       restorescreen

             move.w    #-1,souri_11

             jsr       multitacheon
             rts       

;---------------------------------------------------------------
;
; testpartie3
;

testpartie3: 
             jsr       partie
             cmpi.w    #2,d0
             bne       nt01
             moveq.l   #partie2fin,d0
             JSR_SCENATSTBIT 
             beq       nt01

;on passe a la troisieme partie

             jsr       multitacheoff
             moveq.l   #partie3,d0
             JSR_SCENASETBIT 

             move.w    #954,nocour
             jsr       biitempoprog
             lea.l     palette,a0
             jsr       degraoff

             jsr       hidemouse
             jsr       transimginter


             lea.l     palette954,a0
             jsr       degraon
             jsr       waitclic
             move.w    #954,d0
             jsr       memmasterkill
             move.w    #1954,d0
             jsr       memmasterkill
             move.w    #955,nocour
             jsr       biitempoprog


             lea.l     palette954,a0
             jsr       degraoff


             lea.l     partie2a,a0
             moveq.l   #18,d0
             jsr       scrolltx

             lea.l     partie2b,a0
             moveq.l   #1,d0
             jsr       afftx88

             jsr       transimginter

             lea.l     palette955,a0
             jsr       degraon
             jsr       waitclic
             move.w    #955,d0
             jsr       memmasterkill
             move.w    #1955,d0
             jsr       memmasterkill
             lea.l     palette955,a0
             jsr       degraoff

             lea.l     partie2c,a0
             move.w    #144,d0
             jsr       scrolltx

             jsr       initecran

             lea.l     palette,a0
             jsr       degraon

             lea.l     objstruc,a0
             move.w    #47,43*8(a0)         ;contrat tueur
             move.w    #47,922*8(a0)        ;carte de credit JM


             move.w    #101,newnocour
             addq.l    #4,sp                ;(a cause du jsr)
             bra       clic2

nt01:        
             rts       

;---------------------------------------------------------------
;
; casparticulier
;

casparticulier:        
             cmpi.w    #634,nocour
             beq       coffrekoshan
             cmpi.w    #304,nocour
             beq       rixeprison

             cmpi.w    #128,nocour
             bne       rts
             cmpi.w    #-1,animfin+2        ;animation no 1
             bne       rts
;sylvia
             move.w    sujetdujour,d0
             cmpi.w    #915,d0
             bgt       rts
             subi.w    #913-messagesylvia1,d0
             JSR_SCENATSTBIT 
             bne       rts

             jsr       stockoffset
             jsr       multitacheoff
             move.w    #21,marchandcour
             move.w    #-1,evicour
             move.w    #1,intertype

             move.l    codegenetique,-(sp)

             move.w    marchandcour,d0
             mulu.w    #marsize,d0
             lea.l     marchand,a0
             adda.w    d0,a0

             move.l    a0,adrevicour

             jsr       majhumeur

             move.l    marcodegen(a0),codegenetique
             bsr       sylvia
             move.l    (sp)+,codegenetique
             clr.l     adrevicour
             clr.w     flashcol0
             jsr       multitacheon
             rts       

;---------------------------------------------------------------
;
; majfenetreevi
;

majfenetreevi:         
             lea.l     listegroupe,a0
             lea.l     exlistemission,a1
             moveq.l   #10-1,d0
             moveq.l   #0,d1                ;les 2 listes sont identiques
majfe0:      
             cmpm.l    (a0)+,(a1)+
             beq       majfe1
             moveq.l   #-1,d1
majfe1:      
             move.l    -4(a0),-4(a1)
             dbra      d0,majfe0
             tst.w     d1
             beq       rts
             jsr       multitacheoff
             jsr       affpersogroupe
             JSR_ECRSWAP 
             jsr       affpersogroupe
             jmp       multitacheon

;---------------------------------------------------------------
;
; miseengroupe
;
; entree:     d0 numero de l'evi concerne
;             d1 numero de son futur leader
;

miseengroupe:          
             lea.l     evi,a0
             mulu.w    #evisize,d0
             adda.w    d0,a0
             move.b    d1,evileader(a0)
             move.w    #9999,evilieudst(a0)
             rts       

;---------------------------------------------------------------
;
; faireungroupe
;

faireungroupe:         
             move.w    #199,d0
             JSR_RND 
             cmpi.w    #29,d0
             bgt       fug0
             cmpi.w    #19,d0
             bgt       rts                  ;c'est un technicien -> pas de groupe
fug0:        
             move.w    d0,d1
             mulu.w    #evisize,d1
             lea.l     evi,a0
             adda.w    d1,a0
             move.l    evicodegen(a0),d1
             swap.w    d1
             andi.w    #$0200,d1
             cmpi.w    #$0200,d1
             beq       rts                  ;c'est un ilyen->pas leader

             cmpi.b    #-1,evileader(a0)
             bne       rts                  ;l'evi n'est pas libre

             lea.l     evi,a6
fug2:        
             cmpi.w    #-1,(a6)
             beq       fug3
             cmp.b     evileader(a6),d0
             beq       rts                  ;le leader est deja un leader

             lea.l     evisize(a6),a6
             bra.s     fug2

fug3:        
             cmpi.w    #20,d0
             blt       fug1                 ;c'est un flic

             moveq.l   #4-1,d7
fug00:       
             movem.l   d0-d5/d7/a0-a6,-(sp)
             move.w    #199-30,d0
             JSR_RND 
             addi.w    #30,d0               ;ni flic ni technicien
             move.w    d0,d6
             movem.l   (sp)+,d0-d5/d7/a0-a6

             cmp.w     d0,d6
             beq       fug01                ;on ne peut pas etre leader de sois-meme

             move.w    d6,d5
             mulu.w    #evisize,d5
             lea.l     evi,a1
             adda.w    d5,a1
             cmpi.b    #-1,evileader(a1)
             bne       fug01                ;deja pris...
             move.b    d0,evileader(a1)
             move.w    #9999,evilieusrc(a1)
             move.w    #9999,evilieudst(a1)
fug01:       
             dbra      d7,fug00
             rts       
fug1:        
             moveq.l   #4-1,d7
fug10:       
             movem.l   d0-d5/d7/a0-a6,-(sp)
             moveq.l   #19,d0
             JSR_RND 
             move.w    d0,d6
             movem.l   (sp)+,d0-d5/d7/a0-a6
             cmp.w     d0,d6
             beq       fug11                ;on ne peut pas etre leader de sois-meme
             move.w    d6,d5
             mulu.w    #evisize,d5
             lea.l     evi,a1
             adda.w    d5,a1
             cmpi.b    #-1,evileader(a1)
             bne       fug11                ;deja pris...
             move.b    d0,evileader(a1)
             move.w    #9999,evilieusrc(a1)
             move.w    #9999,evilieudst(a1)
fug11:       
             dbra      d7,fug10
             rts       

;---------------------------------------------------------------
;
; rixeprison
;

rixeprison:  
             moveq.l   #combatprison,d0
             JSR_SCENATSTBIT 
             beq       rts

             movea.l   animdebut,a0
             move.l    a0,animpc
             move.l    #animcodenop,(a0)
             clr.w     animfin

             moveq.l   #mitar,d0
             jsr       scenaclrbit
             bne       prisonmitar

             rts       

prisonmitar: 
             moveq.l   #combatprison,d0
             jsr       scenaclrbit

             jsr       multitacheoff
             addq.l    #4,sp
             move.w    #306,newnocour
             addq.l    #4,sp
             bra       clic2

;---------------------------------------------------------------
;
; partie
;
; retour:     d0 numero de la partie courante
;

partie:      
             moveq.l   #partie3,d0
             JSR_SCENATSTBIT 
             bne       partiertr3
             moveq.l   #partie2,d0
             JSR_SCENATSTBIT 
             bne       partiertr2
             moveq.l   #1,d0
             rts       

partiertr3:  
             moveq.l   #3,d0
             rts       
partiertr2:  
             moveq.l   #2,d0
             rts       


;---------------------------------------------------------------
;
; coffrekoshan
;

coffrekoshan:          
             move.l    contvbl,d0
             cmp.l     vblkocomb,d0
             blt       coko0

             moveq.l   #0,d1
             move.b    jehan+inte_c,d1
             add.b     jehan+refl_c,d1
             lsl.w     #2,d1
             add.l     d1,d0
             move.l    d0,vblkocomb
coko1:       
             moveq.l   #15,d0
             JSR_RND 
             move.w    d0,ledcoffre+6
             jsr       calculcoffre
             move.l    ledcoffre+2,d0
             add.l     d0,d0
             swap.w    d0
             andi.w    #$000f,d0
             cmpi.w    #$f,d0
             beq       coko1
coko0:       
             moveq.l   #33-1,d0
bcoko:       
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     ledcoffre,a0
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6

             seq       d1
             addq.w    #1,d1
             ext.w     d1
             ext.l     d1
             move.w    d0,d2
             lsl.w     #2,d2
             lea.l     animdebut,a0
             movea.l   0(a0,d2.w),a0
             move.l    d1,(a0)
             dbra      d0,bcoko

gfabug11     equ 28*4
             movea.l   animdebut+gfabug11,a0
             move.w    ledcoffre+6,d0
             ext.l     d0
             move.l    d0,(a0)


             rts       

;---------------------------------------------------------------
;
; jehanmort
;

jehanmort:   
             jsr       multitacheoff
             move.w    #951,nocour
             jsr       biitempoprog
             lea.l     palette,a0
             jsr       degraoff
             jsr       hidemouse

             jsr       transimginter

             lea.l     palettemort,a0
             jsr       degraon

mortloop:    
             nop       
             bra.s     mortloop

;---------------------------------------------------------------
;
; jehangagne
;

jehangagne:  
             jsr       multitacheoff
             move.w    #957,nocour
             jsr       biitempoprog
             lea.l     palette,a0
             jsr       degraoff
             jsr       hidemouse
             jsr       transimginter

             lea.l     palette957,a0
             jsr       degraon
             jsr       waitclic
             move.w    #957,d0
             jsr       memmasterkill
             move.w    #1957,d0
             jsr       memmasterkill

             move.w    #958,nocour
             jsr       biitempoprog

             lea.l     palette957,a0
             jsr       degraoff

             lea.l     obseques,a0
             moveq.l   #36,d0
             jsr       scrolltx

             jsr       transimginter


             lea.l     palette958,a0
             jsr       degraon
             jsr       waitclic

             lea.l     palette958,a0
             jsr       degraoff

             lea.l     txtfin,a0
             moveq.l   #1,d0
             jsr       afftx88


             move.w    #958,d0
             jsr       memmasterkill
             move.w    #1958,d0
             jsr       memmasterkill

             bra       mortloop

;---------------------------------------------------------------
;
; waitclic
;

waitclic:    
             JSR_RELACHE 
waitclic0:   
             tst.w     souri_5
             beq       waitclic0
             rts       


;---------------------------------------------------------------
;
; ordredujour
;

ordredujour: 

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #27,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             bsr       sylvia
             bra       finclicm

sylvia:      
             move.w    #1,intertype
             move.l    contvbl,-(sp)
             move.w    #sourismenu,souri_11
             jsr       debloc
             move.w    #2,tetecour

             jsr       savescreen

             lea.l     topogroupeadr,a0
             lea.l     marchand,a1
             lea.l     marsize*21(a1),a1
             clr.l     (a0)+
             clr.l     (a0)+
             move.l    a1,(a0)+
             clr.l     (a0)+
             clr.l     (a0)+

             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             JSR_RELACHE 
             jsr       affinternom


             move.w    sujetdujour,d0
             bsr       dissujetsimple


             bsr       relache
             jsr       restorescreen
             jsr       inibloc
             move.w    #-1,souri_11

             move.l    (sp)+,contvbl

             move.w    sujetdujour,d0
             subi.w    #913-messagesylvia1,d0
             cmpi.w    #messagesylvia3,d0
             bgt       sylvia4
             JSR_SCENASETBIT 

sylvia4:     

;donner tous les objets de sylvia au joueur

             lea.l     objstruc,a0
sylvia0:     
             move.w    objpere(a0),d0
             blt.s     sylvia1
             cmpi.w    #5021,d0
             bne       sylvia2
             move.w    #47,objpere(a0)
sylvia2:     
             addq.l    #8,a0
             bra.s     sylvia0
sylvia1:     
             rts       

;---------------------------------------------------------------
;
; dissujetsimple
;
; entree:     d0 numero du sujet
;

dissujetsimple:        
             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges

             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max

             bsr       dissujet

             lea.l     100+128(sp),sp
             rts       

;---------------------------------------------------------------
;
; div0
;

div0:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.b    $fffa01,d7
             btst      #2,d7
             bne       bombes2
             movem.l   (sp)+,d0-d7/a0-a6
             rte       

;---------------------------------------------------------------
;
; runanimstat
;

runanimstat: 
             movea.l   adrbiicour,a6
             move.w    14(a6),d0
             beq.s     pasanimstatique

             jsr       runanimall

pasanimstatique:       
             rts       


;---------------------------------------------------------------
;
; affhautecran
;

affhautecran:          
             jsr       affcontourhb

             moveq.l   #0,d0
             moveq.l   #0,d1
             move.w    #319,d2
             move.w    #29,d3
             moveq.l   #1,d4
             JSR_PBOX 

             moveq.l   #4,d0
             moveq.l   #4,d1
             move.w    #157,d2
             moveq.l   #29,d3
             moveq.l   #0,d4
             jsr       box

             move.w    #162,d0
             moveq.l   #4,d1
             move.w    #315,d2
             moveq.l   #29,d3
             moveq.l   #0,d4
             jsr       box

             moveq.l   #5,d0
             moveq.l   #5,d1
             move.w    #156,d2
             moveq.l   #28,d3
             moveq.l   #2,d4
             JSR_PBOX 

             move.w    #163,d0
             moveq.l   #5,d1
             move.w    #314,d2
             moveq.l   #28,d3
             moveq.l   #9,d4
             JSR_PBOX 

             move.w    #312,d0
             moveq.l   #7,d1
             move.w    #312,d2
             moveq.l   #27,d3
             moveq.l   #8,d4
             jsr       ligne
             move.w    #166,d0
             moveq.l   #27,d1
             move.w    #312,d2
             moveq.l   #27,d3
             moveq.l   #8,d4
             jsr       ligne

             move.w    #165,d0
             moveq.l   #6,d1
             move.w    #311,d2
             moveq.l   #6,d3
             moveq.l   #10,d4
             jsr       ligne
             move.w    #165,d0
             moveq.l   #6,d1
             move.w    #165,d2
             moveq.l   #26,d3
             moveq.l   #10,d4
             jmp       ligne

;---------------------------------------------------------------
;
; bobmain
;

bobmain:     
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #31,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       multitacheon
             jsr       outdyno1

             move.w    #sourissablier,souri_11

             move.w    #902,nocour
             jsr       biitempoprog

             clr.w     souri_11

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6


             movea.l   sys00,a1
             movea.l   sys01,a2
             movea.l   adrdicour,a0
             move.w    #8000-1,d0
bb:          
             move.l    (a0)+,d7
             move.l    d7,(a1)+
             move.l    d7,(a2)+
             dbra      d0,bb

             lea.l     souri_13,a0
             move.w    #0,(a0)+
             move.w    #0,(a0)+
             move.w    #319-16,(a0)+
             move.w    #199-16,(a0)+

             move.w    #-1,souri_14

             move.w    #sourisbob,souri_11

             lea.l     palettebob,a0
             jsr       degraon

             jsr       bobprogress
             jsr       bobexp

             jsr       bobprog

             lea.l     palettebob,a0
             jsr       degraoff

             jsr       initecran



             .IF protege
             divu.w    d0,d1
             .ENDIF 

             clr.w     souri_11
             jmp       intodynos

;---------------------------------------------------------------
;
; bobexp
;

bobexp:      
             moveq.l   #0,d7
             lea.l     tableexp,a0
             moveq.l   #99,d0
bobexp0:     
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             beq.s     bobexp1
             addq.w    #1,d7
bobexp1:     
             dbra      d0,bobexp0
             mulu.w    #3,d7
             move.w    d7,experience
             rts       

;---------------------------------------------------------------
;
; bobprogress
;
; calcule la valeur de la variable PROGRESSION
;

bobprogress: 
             clr.w     progression
             lea.l     progresstab,a0

             moveq.l   #30-1,d7
bps0:        
             move.w    (a0)+,d6
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #30-1,d0
             sub.w     d7,d0
             jsr       scenatstbit
             movem.l   (sp)+,d0-d7/a0-a6
             beq.s     bps1
             add.w     d6,progression
bps1:        
             dbra      d7,bps0
             rts       

progresstab: 
             .DC.w 1   ;0
             .DC.w 1   ;1
             .DC.w 1   ;2
             .DC.w 5   ;3
             .DC.w 10  ;4             total:18
             .DC.w 7   ;5
             .DC.w 5   ;6             30
             .DC.w 1   ;7
             .DC.w 7   ;8
             .DC.w 2   ;9
             .DC.w 2   ;10
             .DC.w 10  ;11            52
             .DC.w 2   ;12
             .DC.w 0   ;13
             .DC.w 1   ;14
             .DC.w 3   ;15            58
             .DC.w 15  ;16            73
             .DC.w 1   ;17
             .DC.w 5   ;18
             .DC.w 1   ;19            80
             .DC.w 11  ;20
             .DC.w 1   ;21
             .DC.w 1   ;22
             .DC.w 1   ;23
             .DC.w 1   ;24
             .DC.w 1   ;25
             .DC.w 1   ;26
             .DC.w 1   ;27
             .DC.w 1   ;28
             .DC.w 1   ;29            100 pour 100 !!!

;---------------------------------------------------------------
;
; initecran
;

initecran:   
             jsr       affhautecran
             jsr       affpersogroupe
             jsr       apb0
             JSR_ECRSWAP 
             jsr       affhautecran
             jsr       affpersogroupe
             jmp       apb0

;---------------------------------------------------------------
;
; overrelog
;
; relogement d'un programme en overlay
;
; entree:     a0 adresse du programme
;

overrelog:   
             move.l    2(a0),d0             ;taille du segment text
             move.l    6(a0),d1             ;taille du segment data
             move.l    10(a0),d2            ;taille du segment bss

             moveq.l   #28,d7
             add.l     a0,d7                ;adresse de relocation

             adda.l    d0,a0
             adda.l    d1,a0
             lea.l     28(a0),a0            ;adresse de la table de relocation

             move.l    d0,d3
             add.l     d1,d3
             add.l     d2,d3
             subi.l    #16*60,d3            ;adresse de debut du segment overlay

             movea.l   (a0)+,a1

             cmpa.l    #0,a1
             beq       orfin                ;programme relogeable

             clr.l     -4(a0)

             adda.l    d7,a1                ;premiere adresse a modifier

             bsr       relog_a1

             moveq.l   #0,d0
or0:         
             move.b    (a0)+,d0
             beq       orfin

             clr.b     -1(a0)               ;efface table

             cmpi.w    #1,d0
             beq       or254

             adda.w    d0,a1

             bsr       relog_a1
             bra       or0
orfin:       
             rts       
or254:       
             lea.l     254(a1),a1
             bra       or0

relog_a1:    
             move.l    (a1),d6
             cmp.l     d3,d6
             blt       ra0
             sub.l     d3,d6

             move.w    d6,d5
             andi.w    #$f,d5               ;offset
             lsr.w     #4,d6                ;numero
             lsl.w     #2,d6                ;numero*4
             lea.l     overadr,a6
             movea.l   0(a6,d6.w),a6
             adda.w    d5,a6
             move.l    a6,(a1)
             rts       
ra0:         
             add.l     d7,(a1)
             rts       

;---------------------------------------------------------------
;
; transanim
;
; transfert de donnees pour animation
;
; entree:     a0 adresse de la source
;             d0 nombre d'octets de large (source)
;             d1 nombre de lignes
;
;             a1 adresse de la destination
;             d2 largeur en octet de la destination
;             d3 x
;             d4 y
;

transanim:   
             .IF protege
             divu.w    d7,d5
             .ENDIF 

             mulu.w    d2,d4
             adda.w    d4,a1
             lsr.w     #1,d3
             adda.w    d3,a1

             sub.w     d0,d2                ;d2= nombre d'octets a sauter en fin de ligne
             subq.w    #1,d1
             blt       rts
             lsr.w     #3,d0
             subq.w    #1,d0

taby:        
             move.w    d0,d7
tabx:        
             move.l    (a0)+,(a1)+
             move.l    (a0)+,(a1)+
             dbra      d7,tabx
             adda.w    d2,a1
             dbra      d1,taby

             rts       

;---------------------------------------------------------------
;
; affcontourhb
;
; affichage des contours haut et bas (en dehors de l'image)
;

affcontourhb:          
             movea.l   sys01,a0
             adda.w    #(yorg-5)*160,a0
             move.w    #(160/8)-1,d7
bacbh:       
             move.w    #-1,160(a0)
             clr.w     160+2(a0)
             clr.l     160+4(a0)
             move.w    #-1,160*2(a0)
             clr.w     160*2+2(a0)
             clr.l     160*2+4(a0)
             move.w    #-1,160*3(a0)
             clr.w     160*3+2(a0)
             clr.l     160*3+4(a0)
             clr.l     160*4(a0)
             clr.l     160*4+4(a0)

             clr.l     165*160(a0)
             clr.l     165*160+4(a0)
             move.w    #-1,(165+1)*160(a0)
             clr.w     (165+1)*160+2(a0)
             clr.l     (165+1)*160+4(a0)
             move.w    #-1,(165+2)*160(a0)
             clr.w     (165+2)*160+2(a0)
             clr.l     (165+2)*160+4(a0)
             move.w    #-1,(165+3)*160(a0)
             clr.w     (165+3)*160+2(a0)
             clr.l     (165+3)*160+4(a0)
             move.w    #-1,(165+4)*160(a0)
             clr.w     (165+4)*160+2(a0)
             clr.l     (165+4)*160+4(a0)

             move.w    #-1,(a0)+
             clr.w     (a0)+
             clr.l     (a0)+
             dbra      d7,bacbh

             movea.l   sys01,a0
             move.w    #$f000,(yorg-1)*160(a0)
             move.w    #$f,(yorg-1)*160+160-8(a0)
             move.w    #$f000,(yorg+160)*160(a0)
             move.w    #$f,(yorg+160)*160+160-8(a0)
             rts       


;---------------------------------------------------------------
;                                                      |
; affcontour                                           0
;                                                      |
; les segments sont numerotes de la facon suivante: -1-+-2-
;                                                      |
;                                                      3
;                                                      |
;

affcontour:  
             moveq.l   #-1,d6               ;constante ne pas modifier d6 jusqu'a
;                                      la fin de la routine !
             moveq.l   #0,d0
             move.w    quart1no,d1
             move.w    quart2no,d2
             move.w    quart3no,d3
             move.w    quart4no,d4
             cmp.w     d1,d2
             beq       passeg0
             bset      #0,d0
passeg0:     
             cmp.w     d1,d3
             beq       passeg1
             bset      #1,d0

passeg1:     
             cmp.w     d2,d4
             beq       passeg2
             bset      #2,d0
passeg2:     
             cmp.w     d3,d4
             beq       passeg3
             bset      #3,d0
passeg3:     
             movea.l   sys01,a0
             adda.w    #yorg*160,a0
             lea.l     152(a0),a1
             move.w    #160-1,d7
             move.l    #$07ff07ff,d1
             move.l    #$ffe0ffe0,d2
bacbv:       
             and.w     d1,(a0)
             and.w     d2,(a1)
             ori.w     #$f000,(a0)+
             ori.w     #$000f,(a1)+
             and.w     d1,(a0)+
             and.w     d2,(a1)+
             and.l     d1,(a0)+
             and.l     d2,(a1)+
             lea.l     160-8(a0),a0
             lea.l     160-8(a1),a1
             dbra      d7,bacbv

             movea.l   sys01,a0
             clr.w     (yorg-1)*160+80-8(a0)
             clr.w     (yorg-1)*160+80(a0)
             clr.w     (yorg+160)*160+80-8(a0)
             clr.w     (yorg+160)*160+80(a0)


seg0:        
             btst      #0,d0
             beq       seg1

             movea.l   sys01,a0
             adda.w    #yorg*160+80-8,a0
             move.l    #$fff8fff8,d1
             move.l    #$1fff1fff,d2
             moveq.l   #80-1,d7
bseg0:       
             and.w     d1,(a0)
             ori.w     #$3,(a0)+
             and.w     d1,(a0)+
             and.l     d1,(a0)+
             and.w     d2,(a0)
             ori.w     #$c000,(a0)+
             and.w     d2,(a0)+
             and.l     d2,(a0)+
             lea.l     160-16(a0),a0
             dbra      d7,bseg0

             movea.l   sys01,a0
             adda.w    #(yorg-1)*160+80-8,a0
             move.w    #$3,(a0)
             move.w    #$c000,8(a0)

seg1:        
             btst      #1,d0
             beq       seg2



             movea.l   sys01,a0
             adda.w    #(yorg+80-3)*160,a0
             moveq.l   #80/8-1,d7
bseg1:       
             clr.l     (a0)
             clr.l     4(a0)
             move.w    d6,160(a0)
             clr.w     162(a0)
             clr.l     164(a0)

             move.w    d6,160+160(a0)
             clr.w     160+162(a0)
             clr.l     160+164(a0)
             move.w    d6,160*2+160(a0)
             clr.w     160*2+162(a0)
             clr.l     160*2+164(a0)
             move.w    d6,160*3+160(a0)
             clr.w     160*3+162(a0)
             clr.l     160*3+164(a0)

             move.w    d6,160*4+160(a0)
             clr.w     160*4+162(a0)
             clr.l     160*4+164(a0)

             clr.l     160*5(a0)
             clr.l     160*5+4(a0)

             addq.l    #8,a0
             dbra      d7,bseg1

             movea.l   sys01,a0
             adda.w    #(yorg+80-3)*160,a0
             move.w    #$f000,(a0)
             move.w    #$f000,160*5(a0)

seg2:        
             btst      #2,d0
             beq       seg3



             movea.l   sys01,a0
             adda.w    #(yorg+80-3)*160+80,a0
             moveq.l   #80/8-1,d7
bseg2:       
             clr.l     (a0)
             clr.l     4(a0)
             move.w    d6,160(a0)
             clr.w     162(a0)
             clr.l     164(a0)

             move.w    d6,160+160(a0)
             clr.w     160+162(a0)
             clr.l     160+164(a0)
             move.w    d6,160*2+160(a0)
             clr.w     160*2+162(a0)
             clr.l     160*2+164(a0)
             move.w    d6,160*3+160(a0)
             clr.w     160*3+162(a0)
             clr.l     160*3+164(a0)

             move.w    d6,160*4+160(a0)
             clr.w     160*4+162(a0)
             clr.l     160*4+164(a0)

             clr.l     160*5(a0)
             clr.l     160*5+4(a0)

             addq.l    #8,a0
             dbra      d7,bseg2

             movea.l   sys01,a0
             adda.w    #(yorg+80-3)*160+160-8,a0
             move.w    #$f,(a0)
             move.w    #$f,160*5(a0)


seg3:        
             btst      #3,d0
             beq       finseg

             movea.l   sys01,a0
             adda.w    #(yorg+80)*160+80-8,a0
             moveq.l   #80-1,d7
             move.l    #$fff8fff8,d1
             move.l    #$1fff1fff,d2
bseg3:       
             and.w     d1,(a0)
             ori.w     #$3,(a0)+
             and.w     d1,(a0)+
             and.l     d1,(a0)+
             and.w     d2,(a0)
             ori.w     #$c000,(a0)+
             and.w     d2,(a0)+
             and.l     d2,(a0)+
             lea.l     160-16(a0),a0
             dbra      d7,bseg3

             movea.l   sys01,a0
             adda.w    #(yorg+160)*160+80-8,a0
             move.w    #$3,(a0)
             move.w    #$c000,8(a0)


finseg:      
             movea.l   sys01,a0
             adda.w    #(yorg+77)*160+80-8,a0

             cmpi.w    #7,d0
             beq       seg7
             cmpi.w    #11,d0
             beq       seg11
             cmpi.w    #12,d0
             beq       seg12
             cmpi.w    #13,d0
             beq       seg13
             cmpi.w    #14,d0
             beq       seg14
             cmpi.w    #15,d0
             beq       seg15

finseg2:     
             rts       

seg7:        
             move.w    #$3,(a0)
             move.w    #$c000,8(a0)
             bra       finseg2

seg11:       
             move.w    #$3,(a0)
             move.w    d6,160*3(a0)
             move.w    d6,160*4(a0)
             bra       finseg2
seg12:       
             move.l    #$fff8fff8,d7
             and.l     d7,(a0)
             and.l     d7,4(a0)
             and.l     d7,160(a0)
             and.l     d7,160+4(a0)
             and.l     d7,160*2(a0)
             and.l     d7,160*2+4(a0)
             ori.w     #$3,160(a0)
             ori.w     #$3,160*2(a0)
             move.w    d6,160*3+8(a0)
             move.w    d6,160*4+8(a0)
             bra       finseg2

seg13:       
             move.w    #$c000,8(a0)
             move.w    d6,160*3+8(a0)
             move.w    d6,160*4+8(a0)
             bra       finseg2
seg14:       
             move.w    d6,160*3(a0)
             move.w    d6,160*4(a0)
             move.w    d6,160*3+8(a0)
             move.w    d6,160*4+8(a0)
             bra       finseg2
seg15:       
             move.w    #$3,(a0)
             move.w    #$c000,8(a0)
             bra       seg14


;---------------------------------------------------------------
;
; noirbleu
;

noirbleu::   
             move.w    #$2700,sr
             move.w    #$0000,$ff8240
             move.w    #$0007,$ff8240
             bra.s     noirbleu
;---------------------------------------------------------------
;
; noirvert
;

noirvert::   
             move.w    #$2700,sr
             move.w    #$0000,$ff8240
             move.w    #$0070,$ff8240
             bra.s     noirvert
;---------------------------------------------------------------
;
; noirrouge
;

noirrouge::  
             move.w    #$2700,sr
             move.w    #$0000,$ff8240
             move.w    #$0700,$ff8240
             bra.s     noirrouge
;---------------------------------------------------------------
;
; violetturquoise
;

violetturquoise::      
             move.w    #$2700,sr
             move.w    #$0707,$ff8240
             move.w    #$0077,$ff8240
             bra.s     violetturquoise
;---------------------------------------------------------------
;
; jaunebleu
;

jaunebleu::  
             move.w    #$2700,sr
             move.w    #$0770,$ff8240
             move.w    #$0007,$ff8240
             bra.s     jaunebleu

;---------------------------------------------------------------
;
; noirviolet
;

noirviolet:: 
             move.w    #$2700,sr
             move.w    #$0000,$ff8240
             move.w    #$0707,$ff8240
             bra.s     noirviolet
;---------------------------------------------------------------
;
; noirjaune
;

noirjaune::  
             move.w    #$2700,sr
             move.w    #$0000,$ff8240
             move.w    #$0770,$ff8240
             bra.s     noirjaune


;---------------------------------------------------------------
;
; findmapping
;
; entree:  d0 numero du fichier
;
; retour:  a0 pointe sur le descriptif dans MAPPING
;

findmapping: 
             lea.l     mapping,a0
fm0:         
             move.w    (a0),d7
             blt       aaaaaz
             cmp.w     d7,d0
             beq       rts
             lea.l     10(a0),a0
             bra.s     fm0
aaaaaz:      
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       print
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6



             subq.w    #1,$ff8240
             bra       aaaaaz
             rts       

;---------------------------------------------------------------
;
; biitempoprog
;
; entree:     nocour numero de l'image courante
;
;

biitempoprog:          
             move.w    souri_11,-(sp)
             move.w    #sourissablier,souri_11

             move.w    nocour,d0
             addi.w    #1000,d0
             JSR_MEMFINDBLOC 
             bne       biidejapret

             move.w    nocour,d0
             JSR_MEMFINDBLOC 
             bne       btp0

             .IF disquedur=1
             move.w    #630,d0
             JSR_MEMFINDBLOC 
             bne       cas630_1
             move.w    #631,d0
             JSR_MEMFINDBLOC 
             bne       cas630_1
             move.w    #632,d0
             JSR_MEMFINDBLOC 
             bne       cas630_1
             move.w    #633,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge
cas630_1:    
             move.w    nocour,memtypebloc(a0)
             bra       btp0
             .ENDIF 

             .IF disquedur=0
             move.w    nocour,d0
             cmpi.w    #631,d0
             blt       cas630_0
             cmpi.w    #633,d0
             bgt       cas630_0
             move.w    #630,d0
cas630_0:    
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loaddisk
             movem.l   (sp)+,d0-d7/a0-a6

             JSR_MEMFINDBLOC 
             move.w    nocour,memtypebloc(a0)
             .ENDIF 

             .IF protege
             swap.w    d6
             clr.w     d6
             swap.w    d6
             divs.w    d7,d6
             .ENDIF 

btp0:        
             bset      #3,memetatbloc+1(a0)
             move.l    contvbl,memagebloc(a0)     ;on rafraichi l'age du bloc

             movea.l   a0,a6                ;520

             movea.l   memadrbloc(a0),a0
             move.l    a0,adrbiicour

             moveq.l   #0,d0
             move.w    8(a0),d0             ;offset sur donnees image

             move.l    d0,d1                ;520

             move.w    2(a0,d0.l),d0        ;taille des donnees decompactees
             addi.l    #31,d0
             andi.w    #$ffe0,d0            ;multiple de 32


             add.l     d1,d0                ;520

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    nocour,d1
             addi.w    #1000,d1
             jsr       memallocchip
             bne       memerr0              ;;;;;;;;
             movea.l   memadrbloc(a0),a1
             bset      #3,memetatbloc+1(a0)
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movea.l   memadrbloc(a6),a0    ;a cause de REORGMEM
             move.l    a0,adrbiicour        ;a cause de REORGMEM



             .IF disquedur=0
             bclr      #3,memetatbloc+1(a6) ;520
             .ENDIF 

             movea.l   adrbiicour,a6        ;520
             move.l    a1,adrbiicour        ;520
             lsr.w     #1,d1                ;520
             subq.w    #1,d1                ;520
m520:        
             move.w    (a6)+,(a1)+          ;520
             dbra      d1,m520              ;520



             move.l    a1,adrdicour         ;520


             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #0,d0
             move.w    8(a0),d0
             lea.l     2(a0,d0.l),a0        ;adresse donnees image
             jsr       dcpti
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)

             cmpi.w    #900,nocour
             bge       rema2
             lea.l     remaplunoc,a1
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #47,d0               ;pere
             moveq.l   #82,d1               ;type lunette
             jsr       findobjtypepere
             movem.l   (sp)+,d0-d7/a0-a6
             beq       remapext             ;avec les lunettes, on voit la nuit

rema2:       
             lea.l     remapjour,a1
             move.w    2(a0),d0
             btst      #0,d0
             beq       remapext             ;1=ext 0=int
             tst.w     hypercep
             bne       remapext             ;si hyperpeception, on voit la nuit





             movem.l   d0-d6/a0-a6,-(sp)
             jsr       jhm
             move.w    d1,d7
             movem.l   (sp)+,d0-d6/a0-a6

             lea.l     remapjour,a1
             cmpi.w    #906,nocour
             beq.s     rema1
             cmpi.w    #910,nocour
             beq.s     rema1
             bra.s     rema0
rema1:       
             lea.l     remapvia0,a1
rema0:       
             lea.l     heureremap,a2
             move.b    0(a2,d7.w),d7
             lsl.w     #5,d7

             adda.w    d7,a1
remapext:    
             moveq.l   #0,d0
             move.w    18(a0),d0
             adda.l    d0,a0                ;table remap bii
             jsr       makebufremap
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    nocour,d0
             addi.w    #1000,d0
             JSR_MEMFINDBLOC 
             beq       memerr

             move.l    memtaillebloc(a0),d0
             moveq.l   #0,d1
             movea.l   adrbiicour,a0
             move.w    8(a0),d1
             sub.l     d1,d0

             movea.l   adrdicour,a0         ;source
             movea.l   a0,a1                ;destination

             lsr.w     #3,d0                ;taille/8

             lea.l     bufremap+32,a2
             moveq.l   #15,d7
btremap:     
             cmp.w     -(a2),d7
             bne.s     doremap
             dbra      d7,btremap
             bra.s     paslapeine
doremap:     
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     bufremap,a2
             jsr       remap
             movem.l   (sp)+,d0-d7/a0-a6

paslapeine:  
             cmpi.w    #100,nocour
             blt       pasfloue
             cmpi.w    #799,nocour
             bgt       pasfloue

             cmpi.w    #60,_sommeil
             bgt       pasfloue

             movea.l   adrbiicour,a6
             move.w    4(a6),d0
             lsr.w     #2,d0
             move.w    6(a6),d1             ;nb lignes
             movea.l   adrdicour,a0
             lea.l     palette,a1
             jsr       floue


pasfloue:    
             move.w    (sp)+,souri_11

             move.w    nocour,d0
             cmpi.w    #631,d0
             blt       rts
             cmpi.w    #633,d0
             bgt       rts

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       animinit
             movem.l   (sp)+,d0-d7/a0-a6

             subi.w    #630,d0
             move.w    d0,animstatcour
             moveq.l   #0,d0                ;etape 0
             jsr       affanim
             rts       

biidejapret: 
             movea.l   memadrbloc(a0),a1
             move.l    a1,adrbiicour
             moveq.l   #0,d0
             move.w    8(a1),d0
             adda.l    d0,a1
             move.l    a1,adrdicour

             bset      #3,memetatbloc+1(a0)
             move.l    contvbl,memagebloc(a0)
             move.w    (sp)+,souri_11
             rts       

;---------------------------------------------------------------
;
; loaddisk
;
; entree:     d0 numero du fichier
;

loaddisk:    
             jsr       findmapping

             movea.l   a0,a6
             move.w    2(a6),d7             ;numero de disquette et checksum
             move.w    d7,d6
             andi.w    #$fff8,d6            ;3 bits
             andi.w    #$7,d7               ;3 bits

             moveq.l   #0,d5                ;lecteur A

             cmp.w     disquecour,d7
             beq       paschdisk
             cmp.w     disquecourb,d7
             bne       mauvaisdisque

             bset      #15,d5               ;lecteur B

             bra       paschdisk
mauvaisdisque:         
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d0
             jsr       demandedisque
             movem.l   (sp)+,d0-d7/a0-a6

paschdisk:   

             move.w    8(a6),d0             ;taille memoire
             mulu.w    #512,d0
             move.w    (a6),d1



             movem.l   d0-d7/a1-a6,-(sp)
             jsr       memallocfast
             bne       memerr0
             movem.l   (sp)+,d0-d7/a1-a6

             bset      #3,memetatbloc+1(a0)

             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   memadrbloc(a0),a0
             move.w    4(a6),d0
             or.w      d5,d0                ; lecteur A ou B
             move.w    6(a6),d1             ;taille disque
             jsr       readi
             jsr       waitdiskok
             movem.l   (sp)+,d0-d7/a0-a6

             .IF protege
             divu.w    d2,d4
             .ENDIF 


             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   memadrbloc(a0),a1
             move.w    6(a6),d7
             lsl.w     #4,d7                ; lsr.l    #5,d7
             subq.w    #1,d7
             moveq.l   #0,d0
mvdsk:       
             .REPT 16
             add.w     (a1)+,d0
             .ENDR 
             dbra      d7,mvdsk

             andi.w    #$fff8,d0            ;3 bits

             cmp.w     d0,d6
             movem.l   (sp)+,d0-d7/a0-a6
             beq       checksumok

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d1,d0
             jsr       memmasterkill
             movem.l   (sp)+,d0-d7/a0-a6


             bra       mauvaisdisque
checksumok:  
             rts       

;---------------------------------------------------------------
;
; demandedisque
;
; entree:     d0 numero du disque (0,1,2,3 ou 4)
;

demandedisque:         
             move.w    d0,d7
             move.w    d7,disquecour

             addi.w    #sourisdisque1,d0
             move.w    d0,souri_11

             JSR_RELACHE 
menuloop0:   
             tst.w     souri_5
             beq       menuloop0
             rts       



;---------------------------------------------------------------
;
; waitkey
;

waitkey:     
             clr.w     souri_10
wk:          
             tst.w     souri_10
             beq       wk
             rts       


;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
; GESTION DYNAMIQUE DE LA MEMOIRE
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;---------------------------------------------------------------
;
; deverouille
;
; entree:     d0 numero du bloc
;
; deverouille un bloc
;

deverouille: 
             .IF disquedur=0
             JSR_MEMFINDBLOC 
             beq       rts
             bclr      #3,memetatbloc+1(a0)
             .ENDIF 
             rts       

;---------------------------------------------------------------
;
; verouille
;
; entree:     d0 numero du bloc
;
; verouille un bloc
;

verouille:   
             JSR_MEMFINDBLOC 
             beq       rts
             bset      #3,memetatbloc+1(a0)
             rts       

             .IF 0
;---------------------------------------------------------------
;
; memfindchipfast
;
; trouve le bloc present en chip qui doit etre transfere en fast
;
; entree:     d0.l taille du plus grand libre en fast
;
; retour:     a0 pointe sur la structure du bloc a deplacer
;             Z=1 si aucun bloc n'a ete trouve
;

memfindchipfast:       
             move.w    #memnbblocmax-1,d7
             lea.l     memtable,a6
             clr.l     a5                   ;adresse du bloc trouve
             moveq.l   #0,d5                ;taille du bloc a deplacer
fcf0:        
             move.w    memetatbloc(a6),d6
             btst      #3,d6
             bne       fcf1                 ;verouille
             btst      #2,d6
             beq       fcf1                 ;pas de tranfert en fast possible
             move.l    memtaillebloc(a6),d4
             cmp.l     d4,d0
             blt       fcf1                 ;pas assez de place
             cmp.l     d4,d5
             bgt       fcf1                 ;on deplace le plus grand bloc possible
             move.l    d4,d5
             movea.l   a6,a5
fcf1:        
             lea.l     16(a6),a6
             dbra      d7,fcf0
             cmpa.l    #0,a5
             beq       rts                  ;pas de bloc trouve Z=1
             movea.l   a5,a0                ;adresse du bloc trouve
             moveq.l   #-1,d0               ;Z=0
             rts       
             .ENDIF 

;---------------------------------------------------------------
;
; memkillson
;
; entree:     a0 pointe sur la structure du bloc
;

memkillson:  
             move.w    memtypebloc(a0),d1
             cmpi.w    #nosondebut,d1
             blt       rts
             cmpi.w    #nosonfin,d1
             bgt       rts
             subi.w    #nosondebut,d1
             move.w    d1,d0
             lsl.w     #2,d1
             lea.l     table_sons,a0
             clr.l     0(a0,d1.w)

checksoncour:          
             cmp.w     soncour1,d0
             beq.s     mks0
             cmp.w     soncour2,d0
             bne       rts

; joue un son silence sur la voie 2

             clr.w     noinst
             move.w    #2,novoie
             clr.w     noson1
             jsr       play_son
             bra       checksoncour

; joue un son silence sur la voie 1
mks0:        
             clr.w     noinst
             move.w    #1,novoie
             clr.w     noson1
             jsr       play_son
             bra       checksoncour


;---------------------------------------------------------------
;
; memmasterkill
;
; efface un bloc meme si il est verouille
;
; entree:     d0 type de bloc
;

memmasterkill:         
             JSR_MEMFINDBLOC 
             beq       rts                  ;le bloc n'exsite pas

             clr.l     memtaillebloc(a0)
             bra       memkillson

;---------------------------------------------------------------
;
; memkillbloc
;
; efface un bloc
;
; entree:     d0 type de bloc
;
; retour:     Z=1 si operation impossible
;

memkillbloc: 

             JSR_MEMFINDBLOC 
             beq       rts                  ;le bloc n'exsite pas
             move.w    memetatbloc(a0),d0
             btst      #3,d0
             bne       mkb0
             clr.l     memtaillebloc(a0)
             bsr       memkillson
             moveq.l   #-1,d0               ;Z=0
             rts       
mkb0:        
             moveq.l   #0,d0                ;Z=1
             rts       



;---------------------------------------------------------------
;
; memkilloldest
;
; efface le plus vieux bloc
;
; entree:     d0 type de memoire (1=chip 2=fast 3=chip ou fast)
;
; retour:     Z=1 si l'operation n'est pas possible
;

memkilloldest:         
             lea.l     memtable,a0
             move.w    #memnbblocmax-1,d7
             move.l    #$40000000,d6        ;date de naissance du plus vieux
mko0:        
             tst.l     memtaillebloc(a0)
             beq       mko1
             move.w    memetatbloc(a0),d5
             btst      #3,d5
             bne       mko1                 ;bloc verouille
             and.w     d0,d5
             beq       mko1                 ;pas le bon type de memoire
             move.l    memagebloc(a0),d5
             cmp.l     d5,d6
             blt       mko1                 ;le bloc est trop jeune
             move.l    d5,d6                ;date de naissance du plus vieux
             movea.l   a0,a1                ;adresse de l'en-tete du plus ancien bloc
mko1:        
             lea.l     16(a0),a0
             dbra      d7,mko0
             cmpi.l    #$40000000,d6
             beq       rts                  ;Z=1

             clr.l     memtaillebloc(a1)
             movea.l   a1,a0
             bsr       memkillson
             moveq.l   #-1,d0               ;Z=0
             rts       

;---------------------------------------------------------------
;
; memfindbloc
;
; entree:     d0 type du bloc
;
; retour:     a0 pointe sur la structure du bloc
;             Z=1 si le bloc n'existe pas
;

memfindbloc: 
             move.w    #memnbblocmax-1,d7
             lea.l     memtable,a0
fb0:         
             tst.l     memtaillebloc(a0)
             beq       fb2                  ;bloc efface
             cmp.w     memtypebloc(a0),d0
             beq       fb1
fb2:         
             lea.l     16(a0),a0
             dbra      d7,fb0
             moveq.l   #0,d0                ;Z=1
             rts       
fb1:         
             moveq.l   #-1,d0               ;Z=0
             rts       

;---------------------------------------------------------------
;
; memallocchip
;
; entree:     d0.l taille
;             d1 type de bloc
;
; retour:     a0 adresse du descripteur du bloc
;             Z=1 operation effectuee
;

memallocchip:          
             moveq.l   #typechip,d6         ;->memetatbloc
mac4:        
             movem.l   d0-d6/a1-a6,-(sp)
             moveq.l   #typechip,d0
             jsr       memfindmaxfree
             move.l    d0,d7
             movem.l   (sp)+,d0-d6/a1-a6

             cmp.l     d0,d7
             blt       mac0

             move.w    #memnbblocmax-1,d7
             lea.l     memtable,a6
mac1:        
             tst.l     memtaillebloc(a6)
             beq       mac3
             lea.l     16(a6),a6
             dbra      d7,mac1
             bra       mac5                 ;plus de descripteur de libre
mac3:        
; attribution du bloc
             move.l    d0,memtaillebloc(a6)
             move.l    a0,memadrbloc(a6)
             move.w    d6,memetatbloc(a6)
             move.l    contvbl,memagebloc(a6)
             move.w    d1,memtypebloc(a6)
             movea.l   a6,a0

             moveq.l   #0,d0                ;Z=1
             rts       
mac0:        
mac5:        
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #typechip,d0
             jsr       memkilloldest
             movem.l   (sp)+,d0-d7/a0-a6
             beq       reorgmem             ;operation impossible
             bra       mac4

allocpasok:  
             moveq.l   #-1,d0               ;Z=0
             rts       

;---------------------------------------------------------------
;
; reorgmem
;

reorgmem:    
             movem.l   d0/d1,-(sp)
             moveq.l   #typechip,d0
             bsr       memtriprog

             subq.w    #1,d5
             lea.l     memtri,a1
             movea.l   memadrchip,a0
rm100:       
             movea.l   (a1)+,a2             ;adresse du bloc
             move.w    (a1)+,d7             ;numero du bloc

             cmpa.l    a0,a2
             bne       rm101
             lea.l     memtable,a6
             lsl.w     #4,d7
             adda.l    memtaillebloc(a6,d7.w),a0

             dbra      d5,rm100
             movem.l   (sp)+,d0/d1
             bra       allocpasok

rm101:       
             movem.l   (sp)+,d0/d1

             lea.l     memtable,a3
             lsl.w     #4,d7                ;numero *16
             adda.w    d7,a3

             move.l    memtaillebloc(a3),d7
             move.l    a0,memadrbloc(a3)
             lsr.l     #1,d7
rm003:       
             move.w    (a2)+,(a0)+
             subq.l    #1,d7
             bne.s     rm003


             move.w    nocour,d7
             addi.w    #1000,d7
             cmp.w     memtypebloc(a3),d7
             bne       memallocchip

;on a deplace le bloc courant (nocour+1000)

             move.l    adrbiicour,d7
             sub.l     memadrbloc(a3),d7
             sub.l     d7,adrbiicour
             sub.l     d7,adrdicour

             lea.l     animdebut,a0
             lea.l     animpc,a1
             move.w    #nbanimstatmax-1,d7
reorganim:   
             sub.l     d7,(a0)+
             sub.l     d7,(a1)+

             dbra      d7,reorganim


             bra       memallocchip





;---------------------------------------------------------------

memerr0:     
             lea.l     memtable,a0
             move.w    #memnbblocmax-1,d7
             moveq.l   #0,d1
             moveq.l   #0,d2
             moveq.l   #0,d3
me00:        
             add.l     memtaillebloc(a0),d1
             tst.l     memtaillebloc(a0)
             beq       me01
             addq.w    #1,d2
             btst      #3,memetatbloc+1(a0)
             beq       me01
             addq.w    #1,d3
             move.w    memtypebloc(a0),-(sp)
me01:        
             lea.l     16(a0),a0
             dbra      d7,me00


             move.l    (sp)+,d0
             move.l    (sp)+,d1
             move.w    (sp)+,d2
             swap.w    d2
             move.w    d3,d2

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       print
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       print
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       relache
             jsr       waitclic

             lea.l     memtable,a0
             moveq.l   #0,d0
             moveq.l   #9,d1
             jsr       writi9

memerr:      
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       print
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6


             not.w     $ff8240
             bra       memerr

;---------------------------------------------------------------
;
; memallocfast
;
; entree:     d0.l taille
;             d1 type de bloc
;
; retour:     a0 adresse du descripteur du bloc
;

memallocfast:          bra                  memallocchip    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

             .IF 0
maf4:        
             movem.l   d0-d6/a1-a6,-(sp)
             moveq.l   #typefast,d0
             jsr       memfindmaxfree
             move.l    d0,d7
             movem.l   (sp)+,d0-d6/a1-a6

             cmp.l     d0,d7
             blt       maf0

             move.w    #memnbblocmax-1,d7
             lea.l     memtable,a6
maf1:        
             tst.l     memtaillebloc(a6)
             beq       maf3
             lea.l     16(a6),a6
             dbra      d7,maf1
             bra       maf0                 ;plus de descripteur de libre
maf3:        
; attribution du bloc
             move.l    d0,memtaillebloc(a6)
             move.l    a0,memadrbloc(a6)
             move.w    #typefast,memetatbloc(a6)
             move.l    contvbl,memagebloc(a6)
             move.w    d1,memtypebloc(a6)
             movea.l   a6,a0
             rts       
maf0:        
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #typefast,d0
             jsr       memkilloldest
             movem.l   (sp)+,d0-d7/a0-a6
             bne       maf4                 ;operation possible
             moveq.l   #typechip+fastpossible,d6
             bra       mac4

             .ENDIF 

;---------------------------------------------------------------
;
; memfindmaxfree
;
; trouve le plus grand bloc libre
;
; entree:     d0 type de memoire (1=chip 2=fast)
;
; retour:     d0.l taille du bloc
;             a0 adresse du bloc
;

memfindmaxfree:        

             bsr       memtriprog



; on recherche le plus grand bloc vide


             cmpi.w    #typefast,d0
             beq       mf6
             move.l    memadrchip,d6
             movea.l   d6,a6                ;adresse du debut de la mem
             add.l     memlongchip,d6
             bra       mf7
mf6:         
             move.l    memadrfast,d6
             movea.l   d6,a6                ;adresse du debut de la mem
             add.l     memlongfast,d6
mf7:         
             move.l    d6,(a4)              ;on place l'adresse de fin de memoire en fin de table

             lea.l     memtri,a0
             move.l    (a0),d7
             sub.l     a6,d7                ;d7= taille du plus grand bloc

             tst.w     d5
             beq       mf10                 ;0 bloc

             lea.l     memtable,a1
             move.w    d5,d0                ;nombre de bloc
             subq.w    #1,d0

mf8:         
             movea.l   (a0),a5
             move.w    4(a0),d4
             lsl.w     #4,d4
             adda.l    memtaillebloc(a1,d4.w),a5  ;adresse debut
             move.l    6(a0),d5             ;adresse fin
             sub.l     a5,d5                ;taille
             cmp.l     d7,d5
             ble       mf9                  ;le bloc n'est pas plus grand
             movea.l   a5,a6
             move.l    d5,d7
mf9:         
             addq.l    #6,a0
             dbra      d0,mf8

mf10:        
             movea.l   a6,a0                ;adresse debut
             move.l    d7,d0                ;taille
             .IF protege
             divs.w    d1,d7
             .ENDIF 
             rts       

;---------------------------------------------------------------
;
; memtriprog
;
; entree:     d0 type de bloc (1=chip, etc...)
;
; retour:     d5 nombre de blocs
;

memtriprog:  

; on place dans le buffer memtri toutes les adresse des blocs existants
; pour le type de memoire concidere

             moveq.l   #0,d5
             moveq.l   #0,d6
             move.w    #memnbblocmax-1,d7
             lea.l     memtable,a0
             lea.l     memtri,a1
mf0:         
             tst.l     memtaillebloc(a0)
             beq.s     mf1
             move.w    memetatbloc(a0),d4
             and.w     d0,d4
             beq.s     mf1

             move.l    memadrbloc(a0),(a1)+
             move.w    d6,(a1)+
             addq.w    #1,d5                ;nombre de bloc
mf1:         
             lea.l     16(a0),a0
             addq.w    #1,d6
             dbra      d7,mf0

             movea.l   a1,a4                ;adresse de la fin de la liste

; on tri les adresses en ordre croissant


             move.w    d5,d4
             lea.l     memtri,a0

             subq.w    #2,d4                ;nombre d'elements a trier
             blt.s     mfpastri
mf4:         
             movea.l   a0,a1
             move.w    d4,d1
mf2:         
             move.l    (a1),d6
             move.l    6(a1),d7
             cmp.l     d6,d7
             bge.s     mf3
             move.l    d7,(a1)
             move.l    d6,6(a1)
             move.w    4(a1),d7
             move.w    10(a1),4(a1)
             move.w    d7,10(a1)
mf3:         
             addq.l    #6,a1
             dbra      d1,mf2
             dbra      d4,mf4
mfpastri:    
             rts       


;---------------------------------------------------------------
;---------------------------------------------------------------

;---------------------------------------------------------------
;
; symx8014
;
; symetrie selon x pour un bloc de 80*14 pixels
;
; entree:     a0 source
;             a1 destination
;
; remarque:   source et destination peuvent etre confondues
;

symx8014:    
             lea.l     (80*(14-1))/2(a0),a2
             lea.l     (80*(14-1))/2(a1),a3
sx0:         
             .REPT 10
             move.l    (a2)+,d0
             move.l    (a0)+,(a3)+
             move.l    d0,(a1)+
             .ENDR 
             lea.l     -80*2/2(a2),a2
             lea.l     -80*2/2(a3),a3
             cmpa.l    a0,a2
             bgt.s     sx0
             rts       

;---------------------------------------------------------------
;
; symy80
;
; effectue la symetrie selon l'axe y pour une image 4 plans
; de 80 pixels de large
;
; entree:     d0 nombre de lignes
;             a0 adresse de la source
;             a1 adresse de la destination
;
; remarque:   source et destination peuvent etre confondues
;

symy80:      
             movea.w   d0,a6
sy0:         
             .REPT 4
             move.w    (a0),d0
             swap.w    d0
             move.w    8(a0),d0
             move.w    16(a0),d1
             swap.w    d1
             move.w    24(a0),d1
             move.w    32(a0),d2

             addq.l    #2,a0

             .REPT 32
             add.l     d0,d0
             roxr.l    #1,d5
             add.l     d1,d1
             roxr.l    #1,d4
             add.l     d2,d2
             roxr.l    #1,d3
             .ENDR 

             swap.w    d3
             move.w    d3,(a1)
             move.w    d4,16(a1)
             swap.w    d4
             move.w    d4,8(a1)
             move.w    d5,32(a1)
             swap.w    d5
             move.w    d5,24(a1)

             addq.l    #2,a1

             .ENDR 

             lea.l     80/2-8(a0),a0
             lea.l     80/2-8(a1),a1

             subq.w    #1,a6
             cmpa.w    #0,a6
             bgt       sy0

             rts       

;---------------------------------------------------------------
;
; makebufremap
;
; entree:     a0 adresse table remapcpt (dans BII)
;             a1 adresse table remap but (jour, nuit...)
;
; retour:     bufremap est mis a jour
;
; algorythme: soit T1 la table de remap (dans BII)
;             soit T2 la table de but (jour, soir, nuit)
;             soit T3 la table de resultat
;             soit I de 0 a 15
;
;             T3[I]=T2[T1[I]]
;

makebufremap:          
             lea.l     bufremap,a2
             moveq.l   #15,d0
bmbr:        
             move.w    (a0)+,d1

             add.w     d1,d1
             move.w    0(a1,d1.w),(a2)+

             dbra      d0,bmbr
             rts       



waitdiskok:  
             jsr       isdiskok
             bne       waitdiskok
             rts       


;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                             MENUS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;---------------------------------------------------------------
;
; findsujet
;
; entree: d0 sujet
;
; retour:     a0 adresse du contenu de la phrase
;

findsujet:   
             moveq.l   #0,d6                ;laisser passer d6 sujets
findsujet2:  
             move.w    #900,d7              ;je ne sais pas
fsf:         
             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge

             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    4(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             moveq.l   #0,d1                ;numero de la phrase
fs0:         
             tst.w     (a0)
             blt       fs2
             cmp.w     2(a0),d0
             beq       fs1
fs0b:        
             adda.w    (a0),a0
             addq.w    #1,d1
             bra.s     fs0
fs1:         
             tst.w     d6
             beq       fsx0
             subq.w    #1,d6
             bra       fs0b
fsx0:        

             cmpi.w    #900,d0
             bge       fs4                  ;sujets > a 900 sont forcement connus



             movem.l   d0-d2/d5-d7/a0-a2/a4-a6,-(sp)
             move.w    evicour,d3
             move.w    marchandcour,d4
             movea.l   adrevicour,a3
             move.l    evicodegen(a3),d0
             andi.l    #$0f000000,d0
             cmpi.l    #$02000000,d0
             movem.l   (sp)+,d0-d2/d5-d7/a0-a2/a4-a6
             beq       fs0b                 ;c'est un ilyen... il ne sait rien

             move.w    4(a0),d5             ;condition
             lsl.w     #2,d5
             lea.l     dialcond,a5
             movea.l   0(a5,d5.w),a5

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       (a5)
             movem.l   (sp)+,d0-d7/a0-a6
             bne       fs0b








             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   adrevicour,a0
             lea.l     evisavoir(a0),a0
             move.w    d1,d0
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             beq       fs0b                 ;phrase inconnue

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     phraseepuisee,a0
             move.w    d1,d0
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             bne       fs0c                 ;sujet deja utilise

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     phraseepuisee,a0
             move.w    d1,d0
             jsr       setbitfield
             movem.l   (sp)+,d0-d7/a0-a6

fs4:         
             addq.l    #6,a0
             rts       
fs2:         
             move.w    d7,d0                ;plus ou pas de connaissance sur ce sujet
             movem.l   d0-d5/d7/a0-a6,-(sp)
             moveq.l   #2,d0
             JSR_RND 
             move.w    d0,d6
             movem.l   (sp)+,d0-d5/d7/a0-a6
             bra       fsf

fs0c:        
             move.w    #901,d7              ;deja dit

             bra       fs0b

;---------------------------------------------------------------
;
; affinterpel
;

affinterpel: 
             jsr       restorescrlog

             cmpi.w    #3,intertype
             bge       affintervideo




             move.w    #interpelx,menux
             move.w    #interpely,menuy
             move.w    #176,menul
             move.w    #118+8+20-2,menuh
             jsr       affmenufond

             move.w    #128+16-32-32,menul
             move.w    #4*2+8*1,menuh
             move.w    #48+32+16+16,menux
             move.w    #39,menuy
             move.w    #1,menunbl
             clr.w     menuoffset

             LEA_MENUTXLSTA1 
             cmpi.w    #2,intertype
             bne       affint0
             move.l    #grouptx,(a1)+
             bra       affint1
affint0:     
             move.l    #intertx,(a1)+
affint1:     
             move.l    #-1,(a1)+
             jsr       affmenufond
             jsr       affmenutx2


             move.w    #48+16,menux
             move.w    #50-20+15,menuy
             move.w    #176,menul
             move.w    #118+8+10-2,menuh

             moveq.l   #5-1,d7

             moveq.l   #4,d0
             moveq.l   #15,d1

             lea.l     topogroupeadr,a6
bat0:        
             move.w    d7,d6
             neg.w     d6
             addq.w    #4,d6
             moveq.l   #marronfonce,d2
             cmp.w     tetecour,d6
             bne       bat20
             moveq.l   #rouge,d2
bat20:       
             moveq.l   #-1,d3
             move.l    (a6)+,d6
             beq       bat21
             movea.l   d6,a5
             move.l    evicodegen(a5),d3
bat21:       
             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affitete
             movem.l   (sp)+,d0-d7/a0-a6
             addi.w    #34,d0
             dbra      d7,bat0

             rts       

affintervideo:         
             jmp       affvideo

;---------------------------------------------------------------
;
; affitete
;
; entree:     d0 x relatif (au coin)
;             d1 y relatif
;             d2 couleur du fond
;             d3.l code genetique de la tete (-1 si pas de tete)
;

affitete:    
             add.w     menux,d0
             add.w     menuy,d1
affitete2:   
             move.l    d3,d7
             move.w    d2,d4

             move.w    d0,d2
             move.w    d1,d3

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #31,d2
             addi.w    #31,d3
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #31,d2
             moveq.l   #11,d4
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #31,d3
             moveq.l   #11,d4
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #31,d1
             addi.w    #31,d2
             addi.w    #31,d3
             moveq.l   #8,d4
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #31,d0
             addi.w    #31,d2
             addi.w    #31,d3
             moveq.l   #8,d4
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             tst.l     d7
             blt       rts

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    d7,d0
             jsr       makeperso
             movem.l   (sp)+,d0-d7/a0-a6

buggfa       equ 32/2*5

             jsr       clipoff
             lea.l     perso+buggfa,a0
             movea.l   sys01,a1
             move.w    #32,d2
             move.w    #30,d3
             move.w    #160,d4
             addq.w    #1,d1
             JSR_PUTTCX 
             rts       







;---------------------------------------------------------------
;
; interpel
;

interpel:    
             jsr       debloc
             move.l    codegenetique,d0
             jsr       findevi
             move.w    d0,evicour
             move.w    #-1,marchandcour
             move.w    d0,d1
             mulu.w    #evisize,d1
             lea.l     evi,a0
             adda.w    d1,a0
             move.l    a0,adrevicour

             jsr       eviingroupe
             beq       specialgroupe

             clr.w     intertype

             move.l    contvbl,-(sp)
             move.l    adrevicour,aecleader

             move.w    #sourismenu,souri_11
             jsr       debloc
             move.w    #2,tetecour

             jsr       savescreen

             jsr       pasdejaparle

             lea.l     evi,a0
             lea.l     topogroupeadr,a6
             clr.l     (a6)+
             clr.l     (a6)+
             clr.l     (a6)+
             clr.l     (a6)+
             clr.l     (a6)+
             lea.l     -20(a6),a6

             move.w    evicour,d0
             mulu.w    #evisize,d0
             lea.l     0(a0,d0.w),a1
             move.l    a1,8(a6)             ;adresse du leader


             move.w    #-1,-(sp)
             move.w    #0,-(sp)             ;offsets dans topogroupeadr
             move.w    #16,-(sp)
             move.w    #4,-(sp)
             move.w    #12,-(sp)

             lea.l     evi,a0
             move.w    evicour,d0
topo0:       
             cmpi.w    #-1,(a0)
             beq       topo2
             cmp.b     evileader(a0),d0
             bne       topo1
             move.w    (sp)+,d7
             move.l    a0,0(a6,d7.w)
topo1:       
             lea.l     evisize(a0),a0
             bra       topo0
topo2:       
             tst.w     (sp)+                ;depile jusqu'au -1 inclu
             bge.s     topo2

ip0:         
             movea.l   adrevicour,a0

             jsr       majhumeur
;ip0g

             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             JSR_RELACHE 

             jsr       affinternom

             move.w    #128+16-32-32,menul
             move.w    #4*2+8*7,menuh
             move.w    #48+32+16+16,menux
             move.w    #118,menuy
             move.w    #7,menunbl
             clr.w     menuoffset

             LEA_MENUTXLSTA1 
             move.l    #intertx0,(a1)+
             move.l    #intertx1,(a1)+
             move.l    #intertx2,(a1)+
             move.l    #intertx3,(a1)+
             move.l    #intertx4,(a1)+
             move.l    #intertx5,(a1)+
             move.l    #intertx6,(a1)+
             move.l    #-1,(a1)+

             bsr       traitemenu
             bsr       changetete
             beq       ip0

             move.w    menuval,d0
             blt       fininterpel

;si un evi a pour evilove une valeur < a 10
;il attaque le joueur des qu'il est interpele.

             movea.l   adrevicour,a0
             cmpi.b    #10,evilove(a0)
             bcs       combattre

             tst.w     d0
             beq       discuterevi
             cmpi.w    #1,d0
             beq       donner
             cmpi.w    #2,d0
             beq       enroler
             cmpi.w    #3,d0
             beq       acheter
             cmpi.w    #4,d0
             beq       vendre
             cmpi.w    #5,d0
             beq       voler
             cmpi.w    #6,d0
             beq       combattre


fininterpel: 
             bsr       relache
             jsr       restorescreen
             jsr       inibloc
             move.w    #-1,souri_11

             movea.l   aecleader,a0         ;adrevicour du leader
             move.l    (sp)+,d0             ;contvbl a l'entree dans l'interpel
             sub.l     evivblsrc(a0),d0
             move.l    contvbl,d1
             sub.l     d0,d1
             move.l    d1,evivblsrc(a0)


             clr.l     adrevicour
             clr.w     flashcol0

             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             bra       newtache0loop

aecleader:   .DC.l 0


discuterevi: 
             movem.l   d0-d7/a0-a6,-(sp)


             moveq.l   #8,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             bsr       discuter
             bra       ip0

;---------------------------------------------------------------
;
; changetete
;

changetete:  
             move.w    souri_7,d0
             move.w    souri_8,d1
             subi.w    #interpelx,d0
             subi.w    #interpely,d1
             cmpi.w    #4,d0
             blt       chteteexit
             cmpi.w    #4+34*5-1,d0
             bgt       chteteexit
             cmpi.w    #15,d1
             blt       chteteexit
             cmpi.w    #15+32,d1
             bgt       chteteexit
             subq.w    #4,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0
             divu.w    #34,d0
             move.w    d0,d1
             lsl.w     #2,d0
             lea.l     topogroupeadr,a0
             move.l    0(a0,d0.w),d0
             beq       chteteok
             move.l    d0,adrevicour
             subi.l    #evi,d0
             divu.w    #evisize,d0
             move.w    d0,evicour
             move.w    #-1,marchandcour

             move.w    d1,tetecour
             move.w    #-1,negoprec         ;la negociation reprend a zero
             jsr       pasdejaparle
chteteok:    
             moveq.l   #0,d0                ;Z=1 changement ok
             rts       
chteteexit:  
             moveq.l   #-1,d0               ;Z=0 changement rate
             rts       

;---------------------------------------------------------------
;
; pasdejaparle
;
; initialise les info comme quoi l'interlocuteur ne vous a rien dit
; pour le moment
;

pasdejaparle:          
             lea.l     phraseepuisee,a0
             .REPT 6
             clr.l     (a0)+                ;aucune phrase n'a deja ete prononcee
             .ENDR 
             rts       

;---------------------------------------------------------------
;
; interpelmar
;

interpelmar: 
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #22,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             bsr       interpelmar2
             bra       finclicm

interpelmar2:          
             move.w    #1,intertype
             move.l    contvbl,-(sp)
             move.w    #sourismenu,souri_11
             jsr       debloc
             move.w    #2,tetecour

             jsr       savescreen

             jsr       debloc

             jsr       pasdejaparle


             lea.l     topogroupeadr,a6
             clr.l     (a6)+
             clr.l     (a6)+
             move.l    adrevicour,(a6)+
             clr.l     (a6)+
             clr.l     (a6)+


ip0m:        
             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             JSR_RELACHE 
             jsr       affinternom
             bsr       discuter


fininterpelm:          
             bsr       relache
             jsr       restorescreen
             jsr       inibloc
             move.w    #-1,souri_11

             addq.l    #4,sp                ;ronan le 5/2/92              move.l   (sp)+,contvbl
             rts       
;---------------------------------------------------------------
;
; sublove
;
; entree:     a0 adresse de debut de la structure d'un evi
;             d0 quantite a soustraire
;
;             aucun registre modifie
;

sublove:     
             cmp.b     evilove(a0),d0
             bhi       sl0                  ;contexte non-signe
             sub.b     d0,evilove(a0)
             rts       
sl0:         
             clr.b     evilove(a0)
             rts       
;---------------------------------------------------------------
;
; addlove
;
; entree:     a0 adresse de debut de la structure d'un evi
;             d0 quantite a additionner
;
;             aucun registre modifie
;

addlove:     
             moveq.l   #0,d1
             move.b    evilove(a0),d1
             add.w     d0,d1
             cmpi.w    #255,d1
             bgt       al0
             move.b    d1,evilove(a0)
             rts       
al0:         
             move.b    #255,evilove(a0)
             rts       

;---------------------------------------------------------------
;
; majhumeur
;
; entree:     a0 adresse de debut de la structure d'un evi
;
;             a0 n'est pas altere
;

lovefleurmin           equ 192
lovenormalmin          equ 64
lovepiquemin           equ 32

majhumeur:   
             moveq.l   #0,d0
             lea.l     humeur,a6
             move.b    evilove(a0),d0
             cmpi.w    #lovefleurmin,d0
             bge       love0
             cmpi.w    #lovenormalmin,d0
             bge       love1
             cmpi.w    #lovepiquemin,d0
             bge       love2
             move.w    #3,(a6)
             rts       

love0:       
             clr.w     (a6)
             rts       
love1:       
             move.w    #1,(a6)
             rts       
love2:       
             move.w    #2,(a6)
             rts       


;---------------------------------------------------------------
;
; discuter
;

discuter:    
             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges

             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max
             clr.w     menuoffset
discont:     
             JSR_RELACHE 

             move.w    menuoffset,-(sp)
             move.w    #128+16-32-32,menul
             move.w    #4*2+8*1,menuh
             move.w    #48+32+16+16,menux
             move.w    #39,menuy
             move.w    #1,menunbl
             clr.w     menuoffset

             cmpi.w    #3,intertype
             bge       disco0

             lea.l     menutxlst,a0
             move.l    #intertx0,(a0)+
             move.l    #-1,(a0)+
             jsr       affmenufond
             jsr       affmenutx2
             JSR_ECRSWAP 
             jsr       affmenufond
             jsr       affmenutx2
disco0:      
             jsr       affinternom


             move.w    #128+16,menul
             move.w    #4*2+8*7,menuh
             move.w    #48+32,menux
             move.w    #118,menuy
             move.w    #7,menunbl

             jsr       makesujetmenu
             move.w    (sp)+,menuoffset

             bsr       traitemenu
             JSR_RELACHE 

             move.w    menuoffset,-(sp)
             move.w    menuval,d0
             blt       disend
             add.w     d0,d0
             lea.l     sujetliste,a0
             move.w    0(a0,d0.w),d0        ;sujet
             bsr       dissujet
             move.l    adrpilebulle,adrpbcour


             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR_AFFINTERPEL 
             move.w    (sp)+,menuoffset

             bra       discont

disend:      
             move.w    (sp)+,menuoffset
             lea.l     100(sp),sp
             lea.l     128(sp),sp
             rts       

;---------------------------------------------------------------
;
; affinternom
;

affinternom: 
             move.w    #128+16-32-32,menul
             move.w    #4*2+8*1,menuh
             move.w    #48+32+16+16,menux
             move.w    #100-1-10+8,menuy
             move.w    #1,menunbl
             clr.w     menuoffset

             move.w    tetecour,d0
             lsl.w     #2,d0
             lea.l     topogroupeadr,a0
             movea.l   0(a0,d0.w),a0
             lea.l     evinom(a0),a1

             lea.l     menutxlst,a0
             move.l    a1,(a0)+
             move.l    #-1,(a0)+
             jsr       affmenufond
             jsr       affmenutx2
             JSR_ECRSWAP 
             jsr       affmenufond
             jmp       affmenutx2


;---------------------------------------------------------------
;
; donner
;

donner:      
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #9,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    #4000,racineobj
             move.w    #3,inventtype
             jsr       inventairem
             move.w    #sourismenu,souri_11
             bra       ip0

;---------------------------------------------------------------
;
; enroler
;

enroler:     
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #10,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    evicour,d0
             cmpi.w    #30,d0
             blt       enroler0             ;on n'enrole pas les flic et les tech

             movea.l   adrevicour,a0
             cmpi.b    #enrolerlove,evilove(a0)
             bcs       enroler0
             lea.l     listegroupe,a1
             lea.l     missiongroupe,a2
             moveq.l   #5-1,d7
enroler1:    
             cmpi.w    #-1,(a1)+
             beq       enroler2
             addq.l    #6,a2
             dbra      d7,enroler1
enroler0:    
;pas enroler
             move.w    #917,d0
             jsr       dissujetsimple
             bra       ip0

enroler2:    
;l'evi veut bien etre enroler et le groupe n'est pas complet
             move.w    evicour,-2(a1)
             clr.l     (a2)                 ;pas de mission
             move.w    #4,4(a2)
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)

             move.b    #jehanleader,evileader(a0)

             move.w    evicour,d0
             lea.l     evi,a0
enroler3:    
             cmpi.w    #-1,(a0)
             beq       enroler4
             cmp.b     evileader(a0),d0
             bne       enroler5

             move.w    nocour,evilieusrc(a0)
             move.w    nocour,evilieudst(a0)

enroler5:    
             lea.l     evisize(a0),a0
             bra       enroler3
enroler4:    
             move.w    #918,d0
             jsr       dissujetsimple
             bra       fininterpel


;---------------------------------------------------------------
;
; acheter
;

acheter:     
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #11,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    evicour,d0
             addi.w    #3000,d0             ;racine evi

             bsr       fairecorps



             move.w    #4,inventtype
             jsr       inventairem


             bsr       defairecorps

             move.w    #sourismenu,souri_11

             bra       ip0

fairecorps:  
             move.w    d0,racineobj
             lea.l     objstruc,a0
acheter0:    
             move.w    objpere(a0),d1
             blt       acheter1
             cmp.w     d0,d1
             bne       acheter2
             move.w    #1005,objpere(a0)
acheter2:    
             addq.l    #8,a0
             bra.s     acheter0
acheter1:    
             lea.l     objstruc,a0
             move.w    d0,1005*8+objpere(a0)
             rts       

defairecorps:          
             move.w    racineobj,d0
             lea.l     objstruc,a0
acheter00:   
             move.w    objpere(a0),d1
             blt       acheter10
             cmpi.w    #1005,d1
             bne       acheter20
             move.w    d0,objpere(a0)
acheter20:   
             addq.l    #8,a0
             bra.s     acheter00
acheter10:   
             lea.l     objstruc,a0
             move.w    #9998,1005*8(a0)
             rts       

;---------------------------------------------------------------
;
; vendre
;
; le joueur choisi l'objet dans sa boite d'inventaire
; on construit ensuite un menu proposant sept prix differents
; P/2.5 P/2 P/1.5 P P*1.5 P*2 P*2.5
; pour eviter des problemes de redites, le prix minimal est fixe a 6
;
; equation pour fixer le prix max de l'acheteur (evi)
;
; soit P=prix reel de l'objet
; soit X=Cj+Ij+Pj+EVILOVE-Ce-Ie-Pe-128
; soit Y=prix d'achat
;
; C=Charisme, I=Intelligence, P=perception
; j=joueur, e=evi
;
; SI X<0
; y=2PX/(428*3) +P
;
; SI X>0
; y=2PX/428 +P
;
; SI X=0 Y=P
;

vendre:      
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #12,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    #4000,racineobj
             move.w    #5,inventtype
             jsr       inventairem
             move.w    #sourismenu,souri_11
             move.w    evicour,d0
             addi.w    #3000,d0
             jsr       comptefils
             cmpi.w    #5,d0
             bge       vendrepasi

             move.w    objget,d0
             blt       ip0
             jsr       prixobj
             tst.l     d0
             beq       vendrepasi

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #probavendrecher,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             beq       grandprix

             cmpi.l    #5000,d0
             bgt       vendrepasi


grandprix:   
; on ne traite pas les prix de plus de 16 bits

             cmpi.l    #$ffff,d0
             bgt       vendrepasi

; on determine le prix d'achat (evi)

             lea.l     jehan,a0
             lea.l     evi,a1
             move.w    evicour,d1
             mulu.w    #evisize,d1
             adda.w    d1,a1
             moveq.l   #0,d1
             moveq.l   #0,d2
             move.b    char_c(a0),d2
             add.w     d2,d1
             move.b    inte_c(a0),d2
             add.w     d2,d1
             move.b    perc_c(a0),d2
             add.w     d2,d1
             move.b    evilove(a1),d2
             add.w     d2,d1
             move.b    evicharis(a1),d2
             sub.w     d2,d1
             move.b    eviintel(a1),d2
             sub.w     d2,d1
             move.b    evipercep(a1),d2
             sub.w     d2,d1
             subi.w    #128,d1              ;d1=X
             tst.w     d1
             beq       vendreyp
             blt       vendrexneg
             add.l     d1,d1                ;X*2

             movem.l   d0/d2-d7/a0-a6,-(sp)
             jsr       muls3232
             move.l    d0,d1
             move.l    #428*3,d0
             jsr       divu32
             move.l    d0,d1
             movem.l   (sp)+,d0/d2-d7/a0-a6

             add.l     d0,d1                ;d1=2P/(428*3) +P
             move.l    d1,prix
             bra       vendreyok
vendrexneg:  
             neg.l     d1                   ;abs(X)
             add.l     d1,d1                ;X*2

             movem.l   d0/d2-d7/a0-a6,-(sp)
             jsr       muls3232
             move.l    d0,d1
             move.l    #428,d0
             jsr       divu32
             move.l    d0,d1
             movem.l   (sp)+,d0/d2-d7/a0-a6

             neg.l     d1
             add.l     d0,d1                ;d1=2P/428 +P
             move.l    d1,prix


             bra       vendreyok
vendreyp:    
             move.l    d0,prix              ;X=0 Y=P
vendreyok:   
             cmpi.w    #6,d0
             bcc       vendrepmok
             moveq.l   #6,d0
vendrepmok:  
             lea.l     listeprix,a2
             move.l    d0,-(sp)
             add.l     d0,d0
             divu.w    #5,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0
             move.l    d0,(a2)+
             lea.l     txprix0,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P/2.5
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             lsr.l     #1,d0
             move.l    d0,(a2)+
             lea.l     txprix1,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P/2
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             add.l     d0,d0
             divu.w    #3,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0
             move.l    d0,(a2)+
             lea.l     txprix2,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P/1.5
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             move.l    d0,(a2)+
             lea.l     txprix3,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             mulu.w    #3,d0
             lsr.l     #1,d0
             move.l    d0,(a2)+
             lea.l     txprix4,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P*1.5
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             add.l     d0,d0
             move.l    d0,(a2)+
             lea.l     txprix5,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P*2
             move.l    (sp)+,d0

             move.l    d0,-(sp)
             mulu.w    #5,d0
             lsr.l     #1,d0
             move.l    d0,(a2)+
             lea.l     txprix6,a0
             jsr       vendreclrtx
             subq.w    #10-6,a0
             jsr       bintoascii2          ;P*2.5
             move.l    (sp)+,d0


vendrecont:  

             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             JSR_RELACHE 

             jsr       affinternom


             move.w    #128+16-32-32,menul
             move.w    #4*2+8*7,menuh
             move.w    #48+32+16+16,menux
             move.w    #118,menuy
             move.w    #7,menunbl
             clr.w     menuoffset

             lea.l     menutxlst,a0
             move.l    #txprix0,(a0)+
             move.l    #txprix1,(a0)+
             move.l    #txprix2,(a0)+
             move.l    #txprix3,(a0)+
             move.l    #txprix4,(a0)+
             move.l    #txprix5,(a0)+
             move.l    #txprix6,(a0)+
             move.l    #-1,(a0)+


             bsr       traitemenu
             move.w    menuval,d0
             blt       ip0
             lsl.w     #2,d0
             lea.l     listeprix,a0
             move.l    0(a0,d0.w),d0        ;prix

             move.l    prix,d1
             cmp.l     d0,d1
             bgt       vendreok

             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges
             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max

             moveq.l   #2,d0
             JSR_RND 
             move.w    d0,d6
             move.w    #911,d0              ;c'est trop cher
             jsr       dissujet2

             lea.l     100+128(sp),sp
             JSR_RELACHE 
             bra       vendrecont

vendreok:    
             add.l     d0,argent

             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges
             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max

             moveq.l   #2,d0
             JSR_RND 
             move.w    d0,d6
             move.w    #910,d0
             jsr       dissujet2

             lea.l     100+128(sp),sp

             move.w    #3000,d1
             add.w     evicour,d1

             lea.l     objstruc,a0
             move.w    objget,d0
             lsl.w     #3,d0
             move.w    d1,objpere(a0,d0.w)

             bra       ip0



vendrepasi:  


             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges
             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max

             moveq.l   #2,d0
             JSR_RND 
             move.w    d0,d6
             move.w    #912,d0
             jsr       dissujet2

             lea.l     100+128(sp),sp

             bra       ip0

vendreclrtx: 
             .REPT 6
             move.b    #" ",(a0)+
             .ENDR 
             subq.w    #6,a0
             rts       

;---------------------------------------------------------------
;
; voler
;

voler:       
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #13,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    #3000,d0
             add.w     evicour,d0
             jsr       existfils
             bne       ip0                  ;rien a voler

             movea.l   adrevicour,a0

             movem.l   a0,-(sp)             ;movem!!!
             jsr       biovoler
             movem.l   (sp)+,a0             ;movem!!!
             bne       volerrate

;le vol est reussi, on cherche quel objet voler

             move.w    #3000,d0
             add.w     evicour,d0

             jsr       objalea





             move.w    d0,objget
             jsr       inventairev
             move.w    #sourismenu,souri_11
             bra       ip0

volerrate:   
             cmpi.b    #40,evilove(a0)
             bls       volr0

             move.b    #40+15,evilove(a0)

volr0:       
             moveq.l   #15,d0
             jsr       sublove
             jsr       majhumeur
             cmpi.b    #20,evilove(a0)
             bcs       combattre


             move.w    #909,d0
             jsr       dissujetsimple
             bra       ip0

;---------------------------------------------------------------
;
; objalea
;
; renvoie le numero d'un objet pris au hasard dans les objets
; d'un pere precis
;
; entree:     d0 numero du pere de l'objet
;
; retour:     d0 numero de l'objet (-1 si aucun objet dispo)
;


objalea:     
             move.w    d0,d6
             moveq.l   #0,d7
             lea.l     objstruc,a0
             movea.l   sp,a6
voler0:      
             move.w    objpere(a0),d0
             blt       voler1
             cmp.w     d6,d0
             bne       voler2
             addq.w    #1,d7
             pea       (a0)
voler2:      
             addq.l    #8,a0
             bra       voler0
voler1:      
             move.w    d7,d0
             subq.w    #1,d0
             blt       objalearien

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6

             lsl.w     #2,d0
             movea.l   0(sp,d0.w),a0
             movea.l   a6,sp

             suba.l    #objstruc,a0
             move.w    a0,d0
             lsr.w     #3,d0                ;numero de l'objet
             rts       

objalearien: 
             moveq.l   #-1,d0
             rts       

;---------------------------------------------------------------
;
; combattre
;

combattre2:  
             jsr       playsilence

;recherche des enemis

             move.w    evicour,d0
             moveq.l   #-1,d1
             moveq.l   #-1,d2

             lea.l     evi,a0
             move.w    d0,d7
             mulu.w    #evisize,d7
             moveq.l   #0,d6
             move.b    evileader(a0,d7.w),d6
             cmpi.b    #-1,d6
             beq       leaderd0
             move.w    d6,d0                ;d0 est le leader
leaderd0:    
             cmpi.w    #-1,(a0)
             beq       leaderd00

             cmp.b     evileader(a0),d0
             bne       leaderd01
             cmpi.w    #-1,d1
             bne       leaderd02
             move.l    a0,d1
             subi.l    #evi,d1
             divu.w    #evisize,d1
             bra       leaderd01
leaderd02:   
             move.l    a0,d2
             subi.l    #evi,d2
             divu.w    #evisize,d2
             bra       leaderd00
leaderd01:   
             lea.l     evisize(a0),a0
             bra       leaderd0

leaderd00:   
             addq.w    #1,d0
             addq.w    #1,d1
             addq.w    #1,d2

;recherche des amis
             movem.l   d0-d2,-(sp)

             lea.l     -5*2(sp),sp
             movea.l   sp,a2

             move.l    #-1,(a2)+            ;5 valeurs
             move.l    #-1,(a2)+
             move.w    #-1,(a2)+
             lea.l     -5*2(a2),a2

             lea.l     listegroupe,a0
             lea.l     missiongroupe,a1
             moveq.l   #5-1,d0
combrechami0:          
             move.w    (a0)+,d1
             btst      #15,d1
             bne       combrechami1
             tst.w     (a1)
             bne       combrechami1

             move.w    d1,(a2)+             ;un ami trouve
combrechami1:          
             addq.l    #6,a1
             dbra      d0,combrechami0

             move.w    (sp)+,d3
             move.w    (sp)+,d4
             move.w    (sp)+,d5
             move.w    (sp)+,d6
             move.w    (sp)+,d7

             addq.w    #1,d3
             addq.w    #1,d4
             addq.w    #1,d5
             addq.w    #1,d6
             addq.w    #1,d7

             movem.l   (sp)+,d0-d2

             movea.w   combatfuite,a3       ;fuite autorisee (a3=1 fuite interdite)
             clr.w     a1
             tst.w     cfcbta
             beq.s     combatstrat
             movea.w   #1,a1                ;strategie=0/arcade=1
combatstrat: 
             jsr       combatmain
             rts       


combattre:   
             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill
             move.w    #6020,d0
             jsr       deverouille


             moveq.l   #14,d0
             JSR_TRAITEEXP 

             clr.w     combatfuite
             jsr       combattre2

             jsr       biitempoprog

             jsr       animinit

             jsr       inichf
             jsr       inibloc

;              jsr      restorescrlog
;              JSR_AFFINTERPEL
;              JSR_ECRSWAP
;              jsr      restorescrlog
;              JSR_AFFINTERPEL

             jsr       initecran

             move.w    #6020,d0
             jsr       findloaddata

             bra       fininterpel

;---------------------------------------------------------------
;
; makesujetmenu
;
; initialise la structure MENUTXLST avec les textes des sujets
; connus par le joueur
;
; retour: d0 nombre de lignes de menu
;

makesujetmenu:         
             moveq.l   #0,d7                ;mode discution
makesujetm2: 
             moveq.l   #0,d0
             lea.l     menutxlst,a0

             lea.l     sujetliste,a1
             lea.l     adrsujetliste,a2
dis5:        
             moveq.l   #0,d5
             move.w    (a1)+,d5
             blt       dis6

             tst.w     d7
             beq       dis51
             lea.l     sujetobjetliste,a3
dis52:       
             move.w    (a3)+,d6
             blt       dis5
             cmp.w     d5,d6
             bne       dis52
dis51:       
             add.w     d5,d5
             move.w    0(a2,d5.w),d5

             addi.l    #sujet0,d5
             move.l    d5,(a0)+
             addq.w    #1,d0
             bra.s     dis5
dis6:        
             move.l    #-1,(a0)+
             rts       

;---------------------------------------------------------------
;
; makesujetobjet
;

makesujetobjet:        
             moveq.l   #-1,d7
             bra       makesujetm2

;---------------------------------------------------------------
;
; dissujet2
;
; entree:     d0 numero du sujet
;             d6 nombre de phrases a sauter
;

dissujet2:   
             jsr       findsujet2
             bra       dis3b

;---------------------------------------------------------------
;
; dissujet
;
; entree: d0 numero du sujet
;
; retour: d0 code selectionne (-1=rien)
;

dissujet:    
             jsr       findsujet
dis3b:       
             move.l    a0,adrphrasecour

             movea.l   adrpbcour,a1
             move.l    a0,-(a1)
             subq.l    #4,adrpbcour
dis3:        
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       formatph
             jsr       restorescrlog
             movem.l   (sp)+,d0-d7/a0-a6

             cmpi.w    #5,tetecour
             bge       dis3x
             JSR_AFFINTERPEL 
             bra       dis3xb
dis3x:       
             jsr       affinvfond
             jsr       affinventaire
dis3xb:      
             move.w    #100-15+4-10+8,d1
             move.w    tetecour,d0
             mulu.w    #34,d0
             add.w     menux,d0
             addi.w    #20,d0
             cmpi.w    #5,tetecour
             bne       dis3w
             move.w    #194,d0
             move.w    #105,d1
             bra       dis3w0
dis3w:       
             cmpi.w    #3,intertype
             blt       dis3w0
             move.w    #videox+55,d0
             move.w    #videoy+32,d1
dis3w0:      
             jsr       affphrase

             JSR_ECRSWAP 
dis2:        
             JSR_RELACHE 
dis0:        
             move.w    souri_5,d0
             beq.s     dis0
             cmpi.w    #2,d0
             beq       disdepile

             movea.l   adrlocalbulle,a0
dis4:        
             move.w    (a0)+,d0
             blt       dis1
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             addq.l    #2,a0
             move.w    souri_7,d4
             move.w    souri_8,d5
             jsr       inbloc
             bne.s     dis4

             move.w    -(a0),d0             ;code
             bclr      #15,d0
             bne       dissujet
             cmpi.w    #2000,d0
             bge       disout
             jsr       findadrphrase
             bra       dis3b
dis1:        
             moveq.l   #-1,d0
             rts       
disout:      
             subi.w    #2000,d0
             rts       

disdepile:   
             movea.l   adrpbcour,a0
             addq.l    #4,a0
             cmpa.l    adrpilebulle,a0
             beq       dis2

             movea.l   (a0),a0              ;adresse de la phrase precedente
             addq.l    #4,adrpbcour
             move.l    a0,adrphrasecour
             bra       dis3

;---------------------------------------------------------------
;
; congiguration
;

configuration:         
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #3,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       savescreen
             jsr       debloc

             lea.l     -128(sp),sp
             move.l    sp,adrlocalconfig
             bsr       menuconfig
             lea.l     128(sp),sp

             jsr       restorescreen

             jsr       inichf
             jsr       inibloc
             move.w    #-1,souri_11
             bra       menumainexit


;---------------------------------------------------------------
;
; chargerpartie
;

chargerpartie:         
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #0,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             LEA_MENUTXLSTA1 
             move.l    #txboi82,(a1)+
             move.l    #txboi83,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       menumainexit

             LEA_MENUTXLSTA1 
             move.l    #txboi77,(a1)+
             move.l    #txboi78,(a1)+
             move.l    #txboi79,(a1)+
             move.l    #txboi80,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             moveq.l   #0,d0
             moveq.l   #1,d1
             lea.l     buf512,a0
             jsr       readi9
             jsr       waitdiskok


             jsr       menuscpar



             move.w    #128,menul
             move.w    #8+8*7,menuh
             move.w    #7,menunbl
             clr.w     menuoffset

             jsr       menucentre
             jsr       traitemenu

             move.w    menuval,d0
             blt       menumainexit

             move.w    d0,d7
             lsl.w     #2,d7
             lea.l     buf512,a0
             cmpi.l    #"BAT2",0(a0,d7.w)
             bne       menumainexit

;             move.w   #-1,stoptache1
;              moveq.l  #1,d0
;             jsr      allertache
;             clr.w    stoptache1


             jsr       stockoffset

             move.w    nocour,-(sp)

             move.w    menuval,d0

             mulu.w    #128,d0              ;128 secteurs par sauvegarde
             addi.w    #10,d0               ;10 secteurs d'en-tete

             lea.l     savedata,a0
             move.l    #savedate,d1
             sub.l     a0,d1
             addi.l    #511,d1
             divu.w    #512,d1

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       readi9
             jsr       waitdiskok
             movem.l   (sp)+,d0-d7/a0-a6

             add.w     d1,d0
             lea.l     savebss,a0
             move.l    #savebsse,d1
             sub.l     a0,d1
             addi.l    #511,d1
             divu.w    #512,d1
             jsr       readi9
             jsr       waitdiskok

             jsr       checksortieson

             move.w    nocour,newnocour
             move.w    (sp)+,nocour

             addq.l    #4,sp                ; move.l   (sp)+,contvbl

             bra       clic2

tabscptx:    .DC.l scpar0,scpar1,scpar2,scpar3,scpar4,scpar5,scpar6
             .DC.l scpar7,scpar8,scpar9
tabscptxv:   .DC.l scparv0,scparv1,scparv2,scparv3,scparv4,scparv5,scparv6
             .DC.l scparv7,scparv8,scparv9

menuscpar:   
             lea.l     buf512,a0
             LEA_MENUTXLSTA1 
             lea.l     tabscptx,a2
             lea.l     tabscptxv,a3

             moveq.l   #10-1,d7
scp0:        
             cmpi.l    #"BAT2",(a0)+
             beq.s     scp1
             move.l    (a3),(a1)+
             bra.s     scp2
scp1:        
             move.l    (a2),(a1)+
scp2:        
             addq.l    #4,a2
             addq.l    #4,a3
             dbra      d7,scp0
             move.l    #-1,(a1)+
             rts       

;---------------------------------------------------------------
;
; multitacheoff
;

multitacheoff:         
             addq.w    #1,semait
             move.l    contvbl,d7
             move.w    #-1,stoptache1
             moveq.l   #1,d0
             jsr       allertache
             clr.w     stoptache1
mo0:         
             cmp.l     contvbl,d7
             beq.s     mo0
             rts       

;---------------------------------------------------------------
;
; multitacheon
;

multitacheon:          
             subq.w    #1,semait
             rts       

;---------------------------------------------------------------
;
; sauverpartie
;

sauverpartie:          
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #1,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             LEA_MENUTXLSTA1 
             move.l    #txboi75,(a1)+
             move.l    #txboi76,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       menumainexit

             LEA_MENUTXLSTA1 
             move.l    #txboi77,(a1)+
             move.l    #txboi78,(a1)+
             move.l    #txboi79,(a1)+
             move.l    #txboi80,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             moveq.l   #0,d0
             moveq.l   #1,d1
             lea.l     buf512,a0
             jsr       readi9
             jsr       waitdiskok

             jsr       menuscpar

             move.w    #128,menul
             move.w    #8+8*7,menuh
             move.w    #7,menunbl
             clr.w     menuoffset

             jsr       menucentre
             jsr       traitemenu
             tst.w     menuval
             blt       menumainexit

;              move.w   #-1,stoptache1
;             moveq.l  #1,d0
;            jsr      allertache
;           clr.w    stoptache1

             move.w    menuval,d0

             move.w    d0,d7
             lsl.w     #2,d7
             lea.l     buf512,a0
             move.l    #"BAT2",0(a0,d7.w)
             moveq.l   #0,d0
             moveq.l   #1,d1
;              lea.l    buf512,a0
             jsr       writi9
             jsr       waitdiskok



             move.w    menuval,d0
             mulu.w    #128,d0              ;128 secteurs par sauvegarde
             addi.w    #10,d0               ;10 secteurs d'en-tete

             lea.l     savedata,a0
             move.l    #savedate,d1
             sub.l     a0,d1
             addi.l    #511,d1
             divu.w    #512,d1

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       writi9
             jsr       waitdiskok
             movem.l   (sp)+,d0-d7/a0-a6

             add.w     d1,d0
             lea.l     savebss,a0
             move.l    #savebsse,d1
             sub.l     a0,d1
             addi.l    #511,d1
             divu.w    #512,d1
             jsr       writi9
             jsr       waitdiskok

             bra       menumainexit


;---------------------------------------------------------------
;
; dormir
;

dormir:      
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #4,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #sourissablier,souri_11
             clr.w     varbobprev

             cmpi.w    #12*60-1,_sommeil
             bgt       dormirexit
             addq.w    #1,_sommeil
             addi.l    #365,contvbl

             moveq.l   #12-1,d0             ;on execute 12 lignes de prog a chaque minute (taille max d'un prog bob)
bbexec:      
             move.w    d0,-(sp)
             jsr       bob_exec
             clr.w     textbobplein
             move.w    (sp)+,d0
             dbra      d0,bbexec

             move.l    contvbl,sommeilvbl

             move.l    contvbl,(sp)         ;contvbl
             tst.w     varbobprev
             bne       dormirexit
             bra       dormir
;---------------------------------------------------------------
;
; passer1heure
;

passer1heure:          
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #6,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             addi.l    #21846,contvbl
             move.l    contvbl,(sp)         ;contvbl

             bra       passer1exit


;---------------------------------------------------------------
;
; pause
;

pause:       
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #5,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
;              movem.l  d0-d7/a0-a6,-(sp)
             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 
;              movem.l  (sp)+,d0-d7/a0-a6

             move.w    #-1,souri_11
             JSR_RELACHE 
pauseloop:   
             tst.w     souri_5
             beq       pauseloop
             JSR_RELACHE 

             move.l    (sp)+,contvbl
             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache

             bra       newtache0loop

;---------------------------------------------------------------
;
; affcfgtx
;

affcfgtx:    
             lea.l     configdata,a6
             movea.l   adrlocalconfig,a5
             moveq.l   #-1,d7               ;ancien no de ligne
             moveq.l   #0,d6
act0:        
             move.w    (a6)+,d1             ;numero de ligne
             blt       actfin
             move.w    (a6)+,d2             ;etat
             move.w    (a6)+,d3             ;attribu
             movea.l   (a6)+,a0             ;adresse text

             cmp.w     d1,d7
             beq       act1
             moveq.l   #0,d6

act1:        
             move.w    d1,d7

             movem.l   d1-d7/a0-a6,-(sp)
             tst.w     d3
             beq       act2
             moveq.l   #11,d3               ;couleur parametres
             bra       act3
act2:        
             moveq.l   #8,d3                ;couleur titres
act3:        
             mulu.w    #8,d1
             move.w    d1,d2
             move.w    menux,d1
             addq.w    #4,d1
             add.w     d6,d1

             add.w     menuy,d2
             addq.w    #4,d2

             move.w    #160,d4
             movea.l   sys01,a1
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d6
             addi.w    #15,d6

             tst.w     d3
             beq       pascroix

             mulu.w    #8,d1
             move.w    d1,d5
             add.w     menuy,d5
             addq.w    #4-1,d5

             move.w    menux,d1
             subi.w    #10,d1
             add.w     d6,d1

             move.w    d1,(a5)+             ; x
             move.w    d5,(a5)+             ; y
             move.w    d2,(a5)+             ; etat
pascroix:    
             bra       act0
actfin:      

             move.w    #-1,(a5)+            ;fin de liste
             rts       

;---------------------------------------------------------------
;
; affconfig
;

affconfig:   
             jsr       affmenufond
             jsr       affcfgtx
             jsr       affconfigcroix
             JSR_ECRSWAP 
             rts       

;---------------------------------------------------------------
;
; menuconfig
;

menuconfig:  
             JSR_RELACHE 
             move.w    #16*11-16*3,menul
             move.w    #135-50,menuh
             move.w    #48+16*3,menux
             move.w    #50+30,menuy

menuconfigloop:        
             jsr       affconfig


             tst.w     souri_5
             beq       menuconfigloop

             move.w    menux,d0
             move.w    menuy,d1
             move.w    d0,d2
             move.w    d1,d3
             add.w     menul,d2
             add.w     menuh,d3
             subq.w    #1,d2
             subq.w    #1,d3
             move.w    souri_7,d4
             move.w    souri_8,d5
             jsr       inbloc
             bne       rts                  ;on clic a l'exterieur de la boite

             movea.l   adrlocalconfig,a0
mc0:         
             move.w    (a0)+,d0
             blt       mcrelache
             move.w    (a0)+,d1
             move.w    (a0)+,d7
             move.w    d0,d2
             move.w    d1,d3
             addq.w    #6,d2
             addq.w    #6,d3
             move.w    souri_7,d4
             move.w    souri_8,d5
             jsr       inbloc
             bne       mc0

             suba.l    adrlocalconfig,a0
             move.l    a0,d0
             divu.w    #6,d0
             subq.w    #1,d0                ;numero de la touche

             lea.l     configdata-10,a0
mc1:         
             lea.l     10(a0),a0
             tst.w     4(a0)
             beq       mc1
             dbra      d0,mc1

             move.w    2(a0),d1             ;etat
             move.w    4(a0),d2             ;attribu
             bge       mc2

             not.w     2(a0)
             bra       mcrelache

mc2:         
             tst.w     d1
             blt       mcrelache

             lea.l     configdata-10,a6
mc3:         
             lea.l     10(a6),a6
             tst.w     (a6)
             blt       mc4
             cmp.w     4(a6),d2
             bne       mc3
             clr.w     2(a6)
             bra       mc3
mc4:         
             move.w    #-1,2(a0)
mcrelache:   
             jsr       checksortieson
             jsr       affconfig
             JSR_RELACHE 
             bra       menuconfigloop


clipoff:     
             clr.w     puttc_1
             clr.w     puttc_2
             move.w    #319,puttc_3
             move.w    #199,puttc_4
             rts       

;---------------------------------------------------------------
;
; affconfigcroix
;

affconfigcroix:        
             movea.l   adrlocalconfig,a0

             jsr       clipoff
acfc0:       
             move.w    (a0)+,d0
             blt       rts
             move.w    (a0)+,d1
             lea.l     menucarrevide,a1
             move.w    (a0)+,d2
             beq       acfc1
             lea.l     menucarreplein,a1
acfc1:       
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       puttc
             movem.l   (sp)+,d0-d7/a0-a6

             bra       acfc0

;---------------------------------------------------------------
;
; mainmenu
;
; menu principal
;

mainmenu:    
             move.l    contvbl,-(sp)
             JSR_RELACHE 
             move.w    #sourismenu,souri_11



             jsr       menu
             move.w    menuval,d0
             beq       chargerpartie
             cmpi.w    #1,d0
             beq       sauverpartie
             cmpi.w    #2,d0
             beq       inventaire
             cmpi.w    #3,d0
             beq       configuration
             cmpi.w    #4,d0
             beq       dormir
             cmpi.w    #5,d0
             beq       pause
             cmpi.w    #6,d0
             beq       passer1heure
             cmpi.w    #7,d0
             beq       videophone

menumainexit:          
             move.l    (sp)+,contvbl
             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 




             JSR_RELACHE 

             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             move.w    #-1,souri_11
             bra       newtache0loop

dormirexit:  
             move.w    #probadormirvol,d0
             JSR_RND 
             bne       passer1exit

;on se fait voler... si quelqu'un est la...

             move.w    nocour,d0
             lea.l     evi,a0
dorex0:      
             cmpi.w    #-1,(a0)
             beq       passer1exit
             cmp.w     evilieusrc(a0),d0
             bne       dorex1
             suba.l    #evi,a0
             move.l    a0,d1
             divu.w    #evisize,d1          ;d0= numero d'evi
             addi.w    #3000,d1

             movem.l   d1-d7/a0-a6,-(sp)
             moveq.l   #47,d0
             jsr       objalea
             cmpi.w    #-1,d0
             movem.l   (sp)+,d1-d7/a0-a6
             beq       passer1exit
             lea.l     objstruc,a0
             lsl.w     #3,d0
             move.w    d1,objpere(a0,d0.w)
             bra       passer1exit

dorex1:      
             lea.l     evisize(a0),a0
             bra       dorex0

passer1exit: 
             move.l    (sp)+,contvbl
             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 

             JSR_RELACHE 
             move.w    nocour,newnocour
             jmp       clic2

;---------------------------------------------------------------
;
; videophone
;

videox       equ 100-4
videoy       equ 50

videophone:  
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #7,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       savescreen
             jsr       debloc

             clr.l     adrevicour

             move.w    #videox,d0
             move.w    #videoy,d1
             jsr       affvideo
             JSR_ECRSWAP 
             move.w    #videox,d0
             move.w    #videoy,d1
             jsr       affvideo
vp0a:        
             JSR_RELACHE 
             bsr       affvideono
vp0:         

             tst.w     souri_5
             beq       vp0

             move.w    souri_7,d0
             subi.w    #videox,d0
             move.w    souri_8,d1
             subi.w    #videoy,d1
             lea.l     videopbox,a0
             jsr       findinlist2
             tst.w     d7
             blt       videopfin

             cmpi.w    #9,d7
             bgt       vp1
             move.b    videochaine+1,videochaine
             move.b    videochaine+2,videochaine+1
             move.b    videochaine+3,videochaine+2
             addi.b    #'0',d7
             move.b    d7,videochaine+3
             bra       vp0a
vp1:         
             cmpi.w    #10,d7
             beq       vpok
             cmpi.w    #11,d7
             beq       vpversm
             cmpi.w    #12,d7
             beq       vpdem
             cmpi.w    #13,d7
             beq       vpback

vp2:         
             JSR_RELACHE 
             bra       vp0
videopfin:   
             clr.l     adrevicour

             jsr       restorescreen
             jsr       inibloc
             bra       menumainexit

vpok:        
             jsr       videochtodec
             moveq.l   #0,d7                ;numero de l'objet
             lea.l     objstruc,a0
vpok0:       
             cmpi.w    #-1,(a0)
             beq       vpok2
             cmpi.w    #84,objtype(a0)      ;videophone ?
             bne       vpok1
             cmp.w     objdivers1(a0),d0    ;numero d'appel
             beq       vpok3
vpok1:       
             addq.l    #8,a0
             addq.w    #1,d7
             bra.s     vpok0
vpok2:       
             bra       vp20                 ;le numero n'existe pas


affvideono:  
             bsr       clrvideo
             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx0,a0
             movea.l   sys01,a1

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     videochaine,a0
             JSR_TEXTX 

             JSR_ECRSWAP 
             bsr       clrvideo
             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx0,a0
             movea.l   sys01,a1

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     videochaine,a0
             JSR_TEXTX 
             rts       



vpok3:       
             move.w    d7,d0
             jsr       findobjracine

             cmpi.w    #4000,d0
             beq       vp21                 ;occupe
             cmpi.w    #9999,d0
             beq       vp20                 ;pas de reponse



             subi.w    #3000,d0
             move.w    d0,evicour
             move.w    #-1,marchandcour

             mulu.w    #evisize,d0
             lea.l     evi,a0
             adda.w    d0,a0
             move.l    a0,adrevicour

             jsr       majhumeur

             move.w    #2,tetecour
             lea.l     topogroupeadr,a6
             clr.l     (a6)+
             clr.l     (a6)+
             move.l    a0,(a6)+
             clr.l     (a6)+
             clr.l     (a6)+

             jsr       affvideo
             JSR_ECRSWAP 
             jsr       affvideo

; on recherche si le correspondant fait partie du groupe

             move.w    evicour,d0
             jsr       eviingroupe
             addq.l    #2,a0                ;ne modifie pas Z
             beq       videogroupe



             move.w    #3,intertype


             bsr       discuter

             jsr       restorescrlog
             jsr       affvideo
             JSR_ECRSWAP 
             jsr       restorescrlog
             jsr       affvideo


             bra       vp0a

vp20:        
             bsr       clrvideo
             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx1,a0
             movea.l   sys01,a1
             JSR_TEXTX 
             JSR_ECRSWAP 
             bsr       clrvideo


             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx1,a0
             movea.l   sys01,a1
             JSR_TEXTX 
             bra       vp2

vp21:        
             bsr       clrvideo


             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx2,a0
             movea.l   sys01,a1
             JSR_TEXTX 
             JSR_ECRSWAP 
             bsr       clrvideo


             move.w    #107,d1
             move.w    #80-12,d2
             move.w    #0,d3
             move.w    #160,d4
             lea.l     videotx2,a0
             movea.l   sys01,a1
             JSR_TEXTX 
             bra       vp2


vpversm:     
             jsr       videochtodec
             movea.l   videoobjadr,a0
             move.w    d0,objdivers2(a0)

             bra       vp0a
vpdem:       
             movea.l   videoobjadr,a0
             moveq.l   #0,d0
             move.w    objdivers2(a0),d0
             lea.l     videochaine+4,a0
             .REPT 3
             divu.w    #10,d0
             swap.w    d0
             addi.b    #"0",d0
             move.b    d0,-(a0)
             clr.w     d0
             swap.w    d0
             .ENDR 
             addi.b    #"0",d0
             move.b    d0,-(a0)

             bra       vp0a
vpback:      
             lea.l     videochaine,a0
             move.b    2(a0),3(a0)
             move.b    1(a0),2(a0)
             move.b    (a0),1(a0)
             move.b    #"0",(a0)

             bra       vp0a

clrvideo:    
             lea.l     vpbecran,a0
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    (a0)+,d4
             addi.w    #videox,d0
             addi.w    #videox,d2
             addi.w    #videoy,d1
             addi.w    #videoy,d3

             jmp       pbox


videochaine: .DC.b "0000",0,0

;---------------------------------------------------------------
;
; videogroupe
;

videogroupe: 
             suba.l    #listegroupe+2,a0
             move.w    a0,d0
             lsr.w     #1,d0
             move.w    d0,topogroupe+4      ;offset pour tetecour=2

             move.w    #4,intertype

videog0:     
             jsr       restorescrlog
             jsr       affvideo
             JSR_ECRSWAP 
             jsr       restorescrlog
             jsr       affvideo

             jsr       affinternom


             move.w    #128+16,menul
             move.w    #48+32,menux
             move.w    #4*2+8*4,menuh
             move.w    #118,menuy
             move.w    #4,menunbl
             clr.w     menuoffset

             lea.l     menutxlst,a0
             move.l    #grouptx0,(a0)+
             move.l    #grouptx1,(a0)+
             move.l    #grouptx2,(a0)+
             move.l    #grouptx3,(a0)+
             move.l    #-1,(a0)+

             JSR_RELACHE 

             bsr       traitemenu

             pea       videog0              ;adresse de retour

             move.w    menuval,d0
             beq       amitrouver
             cmpi.w    #1,d0
             beq       amiapprendre
             cmpi.w    #2,d0
             beq       amirdv
             cmpi.w    #3,d0
             beq       amidiscuter

             addq.l    #4,sp

             jsr       restorescrlog
             jsr       affvideo
             JSR_ECRSWAP 
             jsr       restorescrlog
             jsr       affvideo

             bra       vp2

;---------------------------------------------------------------
;
; videogroupeauto
;
; entree:     a0 adresse de LISTEGROUPE+offsetevi+2
;

videogroupeauto:       
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    -2(a0),d0
             move.w    d0,evicour
             move.w    #-1,marchandcour

             mulu.w    #evisize,d0
             lea.l     evi,a0
             adda.w    d0,a0
             move.l    a0,adrevicour

             jsr       majhumeur

             move.w    #2,tetecour
             lea.l     topogroupeadr,a6
             clr.l     (a6)+
             clr.l     (a6)+
             move.l    a0,(a6)+
             clr.l     (a6)+
             clr.l     (a6)+


             jsr       savescreen
             jsr       debloc

             move.w    #videox,d0
             move.w    #videoy,d1
             jsr       affvideo
             JSR_ECRSWAP 
             move.w    #videox,d0
             move.w    #videoy,d1
             jsr       affvideo
             JSR_RELACHE 
             movem.l   (sp)+,d0-d7/a0-a6

             move.l    contvbl,-(sp)        ;pour etre homogene avec sortie MAINMENU
             bra       videogroupe

;---------------------------------------------------------------
;
; videochtodec
;
; converti VIDEOCHAINE en decimal
;
; retour:     d0 valeur ascii de VIDEOCHAINE
;

videochtodec:          
             lea.l     videochaine,a0
             moveq.l   #0,d0
             move.b    (a0)+,d0
             subi.b    #"0",d0
             mulu.w    #1000,d0
             move.w    d0,d1
             moveq.l   #0,d0
             move.b    (a0)+,d0
             subi.b    #"0",d0
             mulu.w    #100,d0
             add.w     d0,d1

             moveq.l   #0,d0
             move.b    (a0)+,d0
             subi.b    #"0",d0
             mulu.w    #10,d0
             add.w     d0,d1

             moveq.l   #0,d0
             move.b    (a0)+,d0
             subi.b    #"0",d0
             add.w     d0,d1
             move.w    d1,d0
             rts       


;---------------------------------------------------------------
;
; menu
;
; gestion d'un menu
;

menu:        
             move.w    #64+32,menul
             move.w    #4*2+8*6,menuh
             move.w    #6,menunbl
             clr.w     menuoffset
             lea.l     menutxlst,a0
             move.l    #mainmtx0,(a0)+
             move.l    #mainmtx1,(a0)+
             move.l    #mainmtx2,(a0)+
             move.l    #mainmtx3,(a0)+
             move.l    #mainmtx4,(a0)+
             move.l    #mainmtx5,(a0)+
             move.l    #mainmtx7,(a0)+

             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #4000,d0
             moveq.l   #84,d1               ;type videophone
             jsr       findobjtype
             movem.l   (sp)+,d0-d7/a0-a5
             bne       menuv0
             move.l    a6,videoobjadr
             move.l    #mainmtx6,(a0)+
menuv0:      
             move.l    #-1,(a0)+
             bsr       menucentre

traitemenu:  
menuloop:    
             jsr       affmenufond
             jsr       affmenutx

             addq.w    #1,traitebob12
             andi.w    #$3,traitebob12
             bne       menuloop12

             jsr       bob_exec
             jsr       affpetitbob
menuloop12:  

             JSR_ECRSWAP 

             tst.w     souri_5
             beq.s     menuloop
             rts       

traitebob12: .DC.w 0


;---------------------------------------------------------------
;
;menucentre
;

menucentre:  
             move.w    xaff,d0
             lsl.w     #4,d0
             sub.w     menul,d0
             lsr.w     #1,d0
             add.w     coinx,d0
             addq.w    #8,d0
             andi.w    #$fff0,d0
             move.w    d0,menux

             move.w    yaff,d0
             lsl.w     #4,d0
             sub.w     menuh,d0
             lsr.w     #1,d0
             add.w     coiny,d0
             move.w    d0,menuy
             rts       


;---------------------------------------------------------------
;
; affmenufond
;
; affiche le fond d'un menu
;
; entree:  menux x (multiple de 16)
;          menuy y
;          menul largeur (multiple de 16, minimum 48)
;          menuh nombre de lignes
;

affmenufond: 
             move.w    menux,d0
             move.w    menuy,d1
             move.w    menul,d2
             move.w    menuh,d3

             movea.l   sys01,a0
             mulu.w    #160,d1
             adda.l    d1,a0
             lsr.w     #1,d0
             adda.w    d0,a0

             lea.l     160(a0),a1
             lea.l     160(a1),a2
             lea.l     480(a0),a6

             lsr.w     #4,d2
             subq.w    #3,d2
             move.w    d2,d7


             lea.l     menuhg0,a3
             lea.l     menuhg1,a4
             lea.l     menuhg2,a5
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+

             lea.l     menuh0,a3
             lea.l     menuh1,a4
             lea.l     menuh2,a5
amf0:        
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+
             dbra      d7,amf0

             lea.l     menuhd0,a3
             lea.l     menuhd1,a4
             lea.l     menuhd2,a5
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+

             subq.w    #7,d3                ;nb ligne -3-3 -1(dbra)
             movea.l   a6,a5
             lea.l     menum,a4
             move.l    (a4)+,d5
             move.l    (a4)+,d6
amfx:        
             move.l    menug,(a5)+
             move.l    menug+4,(a5)+

             move.w    d2,d7
amfx2:       
             move.l    d5,(a5)+
             move.l    d6,(a5)+
             dbra      d7,amfx2

             move.l    menud,(a5)+
             move.l    menud+4,(a5)+

             lea.l     160(a6),a6
             movea.l   a6,a5
             dbra      d3,amfx

             movea.l   a6,a0
             lea.l     160(a6),a1
             lea.l     160(a1),a2

             move.w    d2,d7


             lea.l     menubg0,a3
             lea.l     menubg1,a4
             lea.l     menubg2,a5
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+

             lea.l     menub0,a3
             lea.l     menub1,a4
             lea.l     menub2,a5
amf1:        
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+
             dbra      d7,amf1

             lea.l     menubd0,a3
             lea.l     menubd1,a4
             lea.l     menubd2,a5
             move.l    (a3),(a0)+
             move.l    4(a3),(a0)+
             move.l    (a4),(a1)+
             move.l    4(a4),(a1)+
             move.l    (a5),(a2)+
             move.l    4(a5),(a2)+
             rts       

;---------------------------------------------------------------
;
; affmenutx
;

affmenutx:   
             clr.w     menusouris
affmenutx1:  
             move.w    #-1,menuvalr
             moveq.l   #0,d5
             lea.l     menutxlst,a0
             move.w    menuoffset,d4
             lsl.w     #2,d4
             adda.w    d4,a0

             move.w    menunbl,d4
             subq.w    #1,d4

             move.w    menux,d0
             move.w    menuy,d1
             move.w    d0,d2
             move.w    d1,d3
             addq.w    #4,d0
             addq.w    #4,d1

             add.w     menul,d2
             subq.w    #5,d2
             addi.w    #11,d3
amt0:        
             move.l    (a0)+,d7

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    souri_7,d4
             move.w    souri_8,d5
             jsr       inbloc
             movem.l   (sp)+,d0-d7/a0-a6
             bne.s     cde
             tst.w     menusouris
             blt       cde

             move.w    d5,menuvalr          ;selection
             moveq.l   #8,d6

             movem.l   d0-d7/a0-a6,-(sp)
             addq.w    #1,d3
             moveq.l   #10,d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             bra.s     cde2
cde:         
             moveq.l   #10,d6
cde2:        
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d6,d3
             move.w    d1,d2
             move.w    d0,d1
             addq.w    #2,d1
             addq.w    #2,d2
             movea.l   sys01,a1
             movea.l   d7,a0
             move.w    #160,d4
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #8,d1
             addq.w    #8,d3
             addq.w    #1,d5                ;numero du texte
             dbra      d4,amt0              ;              bra      amt0
amt1:        
             tst.w     menuvalr
             bne       amt4
             tst.w     menuoffset
             beq       amt4
             subq.w    #1,menuoffset
             move.w    souri_8,d7
             addq.w    #7,d7
             move.w    d7,wy_souri
amt4:        
             move.w    menunbl,d0
             subq.w    #1,d0
             cmp.w     menuvalr,d0
             bne       amt2
             add.w     menuoffset,d0

             addq.w    #1,d0
             lsl.w     #2,d0
             lea.l     menutxlst,a0
             tst.l     0(a0,d0.w)
             blt       amt2
             addq.w    #1,menuoffset
             move.w    souri_8,d7
             subq.w    #7,d7
             move.w    d7,wy_souri

amt2:        
             move.w    #-1,menuval
             move.w    menuvalr,d0
             blt       amt3
             add.w     menuoffset,d0
             move.w    d0,menuval
amt3:        
             rts       

affmenutx2:  
             move.w    #-1,menusouris
             bra       affmenutx1




;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                   OBJETS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

objpere      equ 0
objtype      equ 2
objdivers1   equ 4
objdivers2   equ 6

objmotif     equ 0
objetat      equ 2
objtypecont  equ 4
objvolume    equ 6
objpoids     equ 10
objvolumein  equ 14
objpoidsin   equ 18
objnom       equ 22
objdiversi1  equ 26
objdiversi2  equ 28
objprix      equ 30

objtypesize  equ 32


;---------------------------------------------------------------
;
; reappro
;

reappro:     

;on traite le cas particulier du journal local
;qui apparait dans le stock de l'agence de voyage a l'instant T
;et disparait lorsqu'il a ete lu

             move.w    #-1,stckjournal
             cmpi.l    #vbljournal,contvbl
             blt.s     rap00
             move.w    #44,stckjournal
             moveq.l   #journallu,d0
             JSR_SCENATSTBIT 
             beq       rap00
             move.w    #-1,stckjournal
rap00:       

; procedure normale de reappro

             lea.l     objstruc,a0
             lea.l     marchand,a1
rap0:        
             move.w    objpere(a0),d0
             blt       rap1
             cmpi.w    #9999,d0
             bne       rap2
             move.w    objtype(a0),d1
             move.w    #nombremarchand-1,d0

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #marsize,d0
             cmpi.b    #2,marmetier(a1,d0.w)      ;marchand/vendeur
             beq.s     rap30
             cmpi.b    #9,marmetier(a1,d0.w)      ;opticien
             bne.s     rap2
rap30:       

             movea.l   maradrstock(a1,d0.w),a2
rap3:        
             move.w    (a2)+,d2
             blt       rap2
             cmp.w     d1,d2
             bne       rap3
             move.w    marstock(a1,d0.w),objpere(a0)
             move.w    objtype(a0),d7

             cmpi.w    #84,d7
             beq       rap2                 ;cas du videophone

             mulu.w    #objtypesize,d7
             lea.l     objtypedata,a6
             adda.w    d7,a6
             move.w    objdiversi1(a6),objdivers1(a0)       ;remise a
             move.w    objdiversi2(a6),objdivers2(a0)       ;neuf

rap2:        
             addq.l    #8,a0
             bra.s     rap0
rap1:        
             rts       

;---------------------------------------------------------------
;
; comptefils
;
; entree:     d0 numero de l'objet
;
; retour:     d0 nombre de fils de l'objet
;

comptefils:  
             move.w    d0,d7
             moveq.l   #0,d0
             lea.l     objstruct,a0
cf0:         
             move.w    (a0),d1
             blt       rts
             cmp.w     d1,d7
             bne.s     cf1
             addq.w    #1,d0
cf1:         
             addq.l    #8,a0                ;              lea.l    32(a0),a0
             bra.s     cf0

;---------------------------------------------------------------
;
; objlnourriture
;
; liste des types d'objets pouvant etre mange
; -1=fin
;

objlnourriture:        
;              .DC.w 5,6,27,29,31,73,74,75,76,77,78,79,80,81,83,-1
             .DC.w 73,74,75,77,78,29,27,5,6,31,79,80,81,76,83,-1
objlboisson: 
;              .DC.w 1,2,3,4,8,12,17,25,30,32,34,39,-1
             .DC.w 39,34,25,3,32,101,33,95,17,4,-1

;---------------------------------------------------------------
;
; objdecal
;
; affiche 2 objets avec decalage horizontal
;
; entree:     a0 adresse du motif du sprite gauche
;             a1 adresse du motif du sprite droit
;             d0 nombre de decalages
;

objdecal:    
             move.w    coinx,d2
             addi.w    #32,d2
             lsr.w     #st1ag3,d2
             move.w    coiny,d1
             addi.w    #34,d1
             mulu.w    #st160ag40,d1
             movea.l   sys01,a2
             adda.w    d1,a2
             adda.w    d2,a2                ;adresse ecran

             moveq.l   #32,d6
             sub.w     d0,d6                ;complement de decalage

             moveq.l   #31,d7
od0:         
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    (a0)+,d4
             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    (a0)+,d4
             lsl.l     d0,d1
             lsl.l     d0,d2
             lsl.l     d0,d3
             lsl.l     d0,d4
             move.w    d1,8(a2)
             move.w    d2,10(a2)
             move.w    d3,12(a2)
             move.w    d4,14(a2)
             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4
             move.w    d1,(a2)
             move.w    d2,2(a2)
             move.w    d3,4(a2)
             move.w    d4,6(a2)

             move.w    (a1)+,d1
             move.w    (a1)+,d2
             move.w    (a1)+,d3
             move.w    (a1)+,d4
             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4
             move.w    (a1)+,d1
             move.w    (a1)+,d2
             move.w    (a1)+,d3
             move.w    (a1)+,d4
             lsr.l     d6,d1
             lsr.l     d6,d2
             lsr.l     d6,d3
             lsr.l     d6,d4
             or.w      d1,8(a2)
             or.w      d2,10(a2)
             or.w      d3,12(a2)
             or.w      d4,14(a2)
             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4
             or.w      d1,(a2)+
             or.w      d2,(a2)+
             or.w      d3,(a2)+
             or.w      d4,(a2)+

             lea.l     160-8(a2),a2
             dbra      d7,od0
             rts       

;---------------------------------------------------------------
;
; scrollobj
;
; scrolling d'objets
;
; entree:  d2 numero obj source
;          d3 numero obj destination
;          d4 sens du scrolling:
;                                     0 haut vers bas
;                                     1 bas vers haut
;                                     2 gauche vers droite
;                                     3 droite vers gauche
;

scrollobj:   
             lea.l     objstruct,a6
             lsl.w     #3,d2
             lsl.w     #3,d3
             move.w    objtype(a6,d2.w),d2  ;type
             move.w    objtype(a6,d3.w),d3  ;type

             lea.l     objtypedata,a6
             mulu.w    #objtypesize,d2
             mulu.w    #objtypesize,d3

             move.w    objmotif(a6,d2.w),d2 ;type graphique
             move.w    objmotif(a6,d3.w),d3 ;type graphique

;attention: le poids fort de d2 et d3 est a 0

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #1900,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d7
             move.w    8(a0),d7
             lea.l     0(a0,d7.l),a1        ;adresse donnees graphiques
             move.w    14(a0),d7            ;offset sur anim stat
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0          ;on passe 8 anim
             move.w    8(a0),d7             ;offset sur donnees graphique
             adda.l    d7,a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             moveq.l   #9,d7
             lsl.w     d7,d2
             lsl.w     d7,d3
             lea.l     0(a1,d3.l),a0        ;adresse obj dst
             lea.l     0(a1,d2.l),a1        ;adresse obj src

             tst.w     d4
             beq       sohb
             cmpi.w    #1,d4
             beq       sobh
             cmpi.w    #2,d4
             beq       sogd
             cmpi.w    #3,d4
             beq       sodg
             rts       

;---------------------------------------------------------------
sogd:        
             moveq.l   #32,d0
sogd0:       
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       objdecal
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             dbra      d0,sogd0

             moveq.l   #0,d0
             jsr       objdecal
             rts       

;---------------------------------------------------------------
sodg:        
             exg.l     a0,a1
             moveq.l   #32,d0
sogd1:       
             movem.l   d0-d7/a0-a6,-(sp)
             neg.w     d0
             addi.w    #32,d0
             jsr       objdecal
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             dbra      d0,sogd1

             moveq.l   #32,d0
             jsr       objdecal
             rts       


;---------------------------------------------------------------
sohb:        
             moveq.l   #32,d7
sohb0:       
             movem.l   d0-d7/a0-a6,-(sp)
             neg.w     d7
             addi.w    #32,d7
             jsr       sov
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,sohb0

             moveq.l   #32,d7
             jsr       sov
             rts       

;---------------------------------------------------------------
sobh:        
             exg.l     a0,a1
             moveq.l   #32,d7
sobh0:       
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       sov
             movem.l   (sp)+,d0-d7/a0-a6
             dbra      d7,sobh0

             moveq.l   #0,d7
             jsr       sov
             rts       


;---------------------------------------------------------------
;
; sov
;

sov:         
             moveq.l   #16,d0

             move.w    #160,d2
             move.w    coinx,d3
             addi.w    #32,d3
             move.w    coiny,d4
             addi.w    #34,d4

             moveq.l   #32,d6
             sub.w     d7,d6

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d1
             lsl.w     #4,d6
             adda.w    d6,a0                ;on saute d6 lignes
             movea.l   sys01,a1
             jsr       transanim
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   a1,a0
             move.w    d6,d1
             add.w     d7,d4
             movea.l   sys01,a1
             jsr       transanim
             JSR_ECRSWAP 
             rts       


;---------------------------------------------------------------
;
; existfils
;
; entree:  d0 numero du pere
;
; retour:  z=1 si le pere possede des fils
;          z=0 si le pere ne possede pas de fils
;

existfils:   
             lea.l     objstruct,a0
p000:        
             move.w    (a0),d7
             blt.s     p000x
             cmp.w     d7,d0
             beq       rts                  ;le bit z est a 1
             addq.l    #8,a0
             bra.s     p000
p000x:       
             moveq.l   #1,d7                ;le bit z est mis a 0
             rts       

;---------------------------------------------------------------
;
; findfils
;
; cree le buffer de tous les fils du pere (freres entre eux)
;
; entree:  d0 numero du pere
;

findfils:    
             lea.l     objstruct,a0
             lea.l     freresobj,a1
             move.w    #-1,(a1)+
p001:        
             move.w    (a0),d7
             blt.s     p001x
             cmp.w     d7,d0
             bne.s     p002
             move.l    a0,d6
             subi.l    #objstruc,d6
             lsr.w     #3,d6                ; /8
             move.w    d6,(a1)+
p002:        
             addq.l    #8,a0                ;              lea.l    32(a0),a0
             bra.s     p001
p001x:       
             move.w    #-1,(a1)+
             rts       

;---------------------------------------------------------------
;
; reduobj
;
; reduit un objet 32*32 en 16*16 et le place dans le motif de souris 10
;
; entree:  d0 numero de l'objet
;

reduobj:     
             lea.l     objstruct,a0
             lsl.w     #3,d0
             move.w    objtype(a0,d0.w),d0  ;type
             lea.l     objtypedata,a0
             mulu.w    #objtypesize,d0
             move.w    objmotif(a0,d0.w),d0 ;numero du motif

             lsl.w     #8,d0
             add.w     d0,d0

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1900,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d7
             move.w    8(a0),d7
             lea.l     0(a0,d7.l),a1        ;adresse donnees graphiques
             move.w    14(a0),d7            ;offset sur anim stat
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0          ;on passe 8 anim
             move.w    8(a0),d7             ;offset sur donnees graphique
             adda.l    d7,a1
             movea.l   a1,a0
             movem.l   (sp)+,d0-d7/a1-a6

             swap.w    d0
             clr.w     d0
             swap.w    d0
             adda.l    d0,a0                ;adresse du motif obj

             lea.l     -128(sp),sp          ;buffer temporaire 128 octets
             movea.l   sp,a1

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       redu3216
             movem.l   (sp)+,d0-d7/a0-a6

gfabug10     equ (sourislibre-1)*4
             movea.l   souri_15+gfabug10,a2 ;adresse du motif souris
             move.w    #1,(a2)+             ;nb etape

             moveq.l   #15,d7
ro1:         
             move.w    #-1,(a2)+
             move.l    (a1)+,(a2)+
             move.l    (a1)+,(a2)+

             dbra      d7,ro1

             lea.l     128(sp),sp
             rts       

;---------------------------------------------------------------
;
; redu3216
;
; reduit un motif 32*32 en motif 16*16
;
; entree:     a0 adresse de la source
;             a1 adresse de la destination (128 octets)
;


redu3216:    

             moveq.l   #15,d7
p009:        
             .REPT 4
             move.w    (a0)+,d0
             .REPT 8
             add.w     d0,d0
             add.l     d0,d0
             .ENDR 
             move.w    6(a0),d0
             .REPT 8
             add.w     d0,d0
             add.l     d0,d0
             .ENDR 
             swap.w    d0
             move.w    d0,(a1)+
             .ENDR 

             lea.l     24(a0),a0
             dbra      d7,p009
             rts       

;---------------------------------------------------------------
;
; poids
;
; calcule le poids d'un objet (recursif)
;
; entree:     d0 numero de l'objet
;
; retour:     d7.l poids en grammes
;

poids:       
             lea.l     objstruct,a0
             move.w    d0,d1
             lsl.w     #3,d1
             move.w    objtype(a0,d1.w),d7
             mulu.w    #objtypesize,d7
             lea.l     objtypedata,a0
             move.l    objpoids(a0,d7.w),d7 ;poids vide
             lea.l     objstruct,a0

             moveq.l   #0,d2
p030:        
             move.w    (a0),d1
             blt       rts
             cmp.w     d1,d0
             bne.s     p031

             move.l    d7,-(sp)

             movem.l   d0-d2/a0,-(sp)
             move.w    d2,d0
             jsr       poids
             movem.l   (sp)+,d0-d2/a0

             add.l     d7,(sp)
             move.l    (sp)+,d7

p031:        
             addq.l    #8,a0
             addq.w    #1,d2                ;numero de l'objet examine
             bra.s     p030
             rts       

;---------------------------------------------------------------
;
; findobjracine
;
; trouve la racine d'un objet
;
; entree:     d0 numero de l'objet
;
; retour:     d0 numero de la racine de l'objet
;

findobjracine:         
             lea.l     objstruc,a0
for0:        
             lsl.w     #3,d0
             move.w    objpere(a0,d0.w),d0
             cmpi.w    #2000,d0
             blt.s     for0
             rts       


;---------------------------------------------------------------
;
; findobj
;
; teste la presence d'un objet dans une arborescence precise (recursif)
;
; entree:     d0 numero de la racine
;             d1 numero de l'objet recherche (ne pas confondre avec son type)
;
; retour:     z=1 objet trouve
;             z=0 objet pas trouve
;             a6 pointe sur le premier objet trouve
;

findobj:     
             lea.l     objstruct,a0
fo0:         
             move.w    objpere(a0),d2
             blt       fo2
             cmp.w     d2,d0
             bne.s     fo1

             movem.l   d0/d2/a0,-(sp)
             move.l    a0,d0
             subi.l    #objstruc,d0
             lsr.w     #3,d0
             cmp.w     d0,d1
             beq       fo3
             jsr       findobj
             bra.s     fo4
fo3:         
             movea.l   a0,a6                ;obj trouve
             moveq.l   #-1,d1
fo4:         
             movem.l   (sp)+,d0/d2/a0

fo1:         
             addq.l    #8,a0
             bra.s     fo0
fo2:         
             cmpi.w    #-1,d1
             beq       rts                  ;z=1
             moveq.l   #1,d3                ;z=0
             rts       

;---------------------------------------------------------------
;
; findobjtypepere
;
; teste la presence d'un type d'objet ayant un pere precis
;
; entree:     d0 numero du pere
;             d1 numero du type recherche
;
; retour:     z=1 objet trouve
;             z=0 objet pas trouve
;             a6 pointe sur le premier objet trouve
;

findobjtypepere:       
             lea.l     objstruc,a6
fotp0:       
             tst.w     (a6)
             blt       fotp1
             cmp.w     objtype(a6),d1
             bne       fotp2
             cmp.w     objpere(a6),d0
             bne       fotp2
             moveq.l   #0,d0                ;Z=1
             rts       
fotp2:       
             addq.l    #8,a6
             bra       fotp0


fotp1:       
             moveq.l   #-1,d0               ;Z=0
             rts       



;---------------------------------------------------------------
;
; findobjtype
;
; teste la presence d'un type d'objet dans une arborescence precise (recursif)
;
; entree:     d0 numero de la racine
;             d1 numero du type recherche
;
; retour:     z=1 objet trouve
;             z=0 objet pas trouve
;             a6 pointe sur le premier objet trouve
;

findobjtype: 
             lea.l     objstruct,a0
fo0t:        
             move.w    objpere(a0),d2
             blt       fo2t
             cmp.w     d2,d0
             bne.s     fo1t

             movem.l   d0/d2/a0,-(sp)
             move.l    a0,d0
             subi.l    #objstruc,d0
             lsr.w     #3,d0

             cmp.w     objtype(a0),d1
             beq       fo3t
             jsr       findobjtype
             bra.s     fo4t
fo3t:        
             movea.l   a0,a6                ;obj trouve
             moveq.l   #-1,d1
fo4t:        
             movem.l   (sp)+,d0/d2/a0

fo1t:        
             addq.l    #8,a0
             bra.s     fo0t
fo2t:        
             cmpi.w    #-1,d1
             beq       rts                  ;z=1
             moveq.l   #1,d3                ;z=0
             rts       

;---------------------------------------------------------------
;
; volumein
;
; calcule le volume contenu par un objet
;
; entree:     d0 numero de l'objet
;
; retour:     d7.l volume en cm cube
;

volumein:    
             lea.l     objstruct,a0
             moveq.l   #0,d7

             moveq.l   #0,d2
p03000:      
             move.w    (a0),d1
             blt.s     rtsvi
             cmp.w     d1,d0
             bne.s     p03100               ;on saute les objets qui n'appartiennent pas a l'objet courant

             move.l    d7,-(sp)

             movem.l   d0-d2/a0,-(sp)
             move.w    d2,d0
             jsr       volume
             movem.l   (sp)+,d0-d2/a0

             add.l     d7,(sp)
             move.l    (sp)+,d7

p03100:      
             addq.l    #8,a0                ;              lea.l    32(a0),a0
             addq.w    #1,d2                ;numero de l'objet examine
             bra.s     p03000
rtsvi:       rts       

;---------------------------------------------------------------
;
; poidsin
;
; calcule le poids contenu par un objet
;
; entree:     d0 numero de l'objet
;
; retour:     d7.l poids en grammes
;

poidsin:     
             lea.l     objstruct,a0
             moveq.l   #0,d7

             moveq.l   #0,d2
p03000x:     
             move.w    (a0),d1
             blt.s     rtspi
             cmp.w     d1,d0
             bne.s     p03100x              ;on saute les objets qui n'appartiennent pas a l'objet courant

             move.l    d7,-(sp)

             movem.l   d0-d2/a0,-(sp)
             move.w    d2,d0
             jsr       poids
             movem.l   (sp)+,d0-d2/a0

             add.l     d7,(sp)
             move.l    (sp)+,d7

p03100x:     
             addq.l    #8,a0                ;              lea.l    32(a0),a0
             addq.w    #1,d2                ;numero de l'objet examine
             bra.s     p03000x
rtspi:       rts       

;---------------------------------------------------------------
;
; volume
;
; calcule le volume d'un objet (recursif)
;
; entree:     d0 numero de l'objet
;
; retour:     d7.l volume en cm cube
;

volume:      
             lea.l     objstruct,a0
             move.w    d0,d1
             lsl.w     #3,d1

             move.w    objtype(a0,d1.w),d6
             mulu.w    #objtypesize,d6
             lea.l     objtypedata,a1

             move.l    objvolume(a1,d6.w),d7      ;volume propre de l'objet

             btst      #1,objetat+1(a1,d6.w)
             bne       rts                  ;l'objet est rigide->pas d'autres volumes pris en compte

             moveq.l   #0,d2
p0300:       
             move.w    (a0),d1
             blt.s     rtsv
             cmp.w     d1,d0
             bne.s     p0310

             move.l    d7,-(sp)

             movem.l   d0-d2/a0,-(sp)
             move.w    d2,d0
             jsr       volume
             movem.l   (sp)+,d0-d2/a0

             add.l     d7,(sp)
             move.l    (sp)+,d7

p0310:       
             addq.l    #8,a0                ;              lea.l    32(a0),a0
             addq.w    #1,d2                ;numero de l'objet examine
             bra.s     p0300
rtsv:        rts       

;---------------------------------------------------------------
;
; inbranche
;
; recherche si un objet est dans une branche de l'arbre
;
; entree:  d0 extremite de la branche
;          d1 numero de l'objet a rechercher
;
; retour:  z=1 si l'objet est dans la branche
;

inbranche:   
             cmp.w     d0,d1
             beq.s     inbz1
             lea.l     objstruct,a0
             move.w    racineobj,d7
inbb:        
             lsl.w     #3,d0
             move.w    objpere(a0,d0.w),d0
             cmp.w     d7,d0
             beq.s     inbz0
             cmp.w     d0,d1
             bne.s     inbb
inbz1:       
             moveq.l   #0,d0                ;z=1
             rts       
inbz0:       
             moveq.l   #1,d0                ;z=0
             rts       

;---------------------------------------------------------------
;
; volumebrok
;
; verifie si le volume de contenance de chaque objet
; de la branche est ok
;
; entree:  d0 numero de l'objet du debut de branche (extremite)
;
; retour:  z=1 si le volume est ok
;

volumebrok:  
             lea.l     objstruct,a0
q001:        
             move.w    d0,d1
             lsl.w     #3,d1

             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1

             move.l    objvolumein(a1,d2.w),d5    ;volume de contenance de l'objet courant

             movem.l   d0-d6/a0-a6,-(sp)
             jsr       volumein
             movem.l   (sp)+,d0-d6/a0-a6

             cmp.l     d5,d7
             bgt.s     q002                 ;l'objet deborde...

             move.w    0(a0,d1.w),d0        ;numero du proprietaire
             cmp.w     racineobj,d0
             bne.s     q001

             moveq.l   #0,d0                ;z=1
             rts       
q002:        
             moveq.l   #1,d0                ;z=0
             rts       

;---------------------------------------------------------------
;
; poidsbrok
;
; verifie si le poids de contenance de chaque objet
; de la branche est ok
;
; entree:  d0 numero de l'objet du debut de branche (extremite)
;
; retour:  z=1 si le poids est ok
;

poidsbrok:   
             lea.l     objstruct,a0
q001x:       
             move.w    d0,d1
             lsl.w     #3,d1

             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1

             move.l    objpoidsin(a1,d2.w),d5     ;poids de contenance de l'objet courant

             movem.l   d0-d6/a0-a6,-(sp)
             jsr       poidsin
             movem.l   (sp)+,d0-d6/a0-a6

             cmp.l     d5,d7
             bgt.s     q002x                ;l'objet depasse le poids

             move.w    0(a0,d1.w),d0        ;numero du proprietaire
             cmp.w     racineobj,d0
             bne.s     q001x

             moveq.l   #0,d0                ;z=1
             rts       
q002x:       
             moveq.l   #1,d0                ;z=0
             rts       

;---------------------------------------------------------------
;
; affobjpere
;

affobjpere:  
             moveq.l   #0,d0
             move.w    objcour,d0
             lsl.w     #3,d0
             lea.l     objstruct,a0
             move.w    objpere(a0,d0.w),d0  ;numero du pere
             cmp.w     racineobj,d0
             beq       rts
             lsl.w     #3,d0
             move.w    objtype(a0,d0.w),d1
             mulu.w    #objtypesize,d1
             lea.l     objtypedata,a1


             move.w    objmotif(a1,d1.w),d0 ;numero du motif du pere
             lsl.w     #8,d0
             add.w     d0,d0

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1900,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d7
             move.w    8(a0),d7
             lea.l     0(a0,d7.l),a1        ;adresse donnees graphiques
             move.w    14(a0),d7            ;offset sur anim stat
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0          ;on passe 8 anim
             move.w    8(a0),d7             ;offset sur donnees graphique
             adda.l    d7,a1
             movea.l   a1,a0
             movem.l   (sp)+,d0-d7/a1-a6

             lea.l     0(a0,d0.l),a0        ;adresse du motif

             lea.l     -128(sp),sp
             movea.l   sp,a1

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       redu3216
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   sys01,a2
             move.w    coinx,d7
             addi.w    #32,d7
             lsr.w     #st1ag3,d7
             adda.w    d7,a2
             move.w    coiny,d7
             addi.w    #16,d7
             mulu.w    #st160ag40,d7
             adda.w    d7,a2

             moveq.l   #15,d7
aop0:        
             .REPT 4
             moveq.l   #0,d0
             move.w    (a1)+,d0
             lsl.l     #8,d0
             andi.w    #$ff,8(a2)
             or.w      d0,8(a2)
             swap.w    d0
             andi.w    #$ff00,(a2)
             or.w      d0,(a2)+
             .ENDR 
             lea.l     160-8(a2),a2
             dbra      d7,aop0

             lea.l     128(sp),sp
             rts       

makeadrobj:  
             movea.l   adrbiicour,a0
             moveq.l   #0,d7
             move.w    14(a0),d7
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0
             move.w    8(a0),d7
             movea.l   adrdicour,a1
             adda.l    d7,a1
             move.l    a1,adrobj
             rts       

;---------------------------------------------------------------
;
; objets
;

objets:      
             move.w    racineobj,d0
             move.w    d0,objcour
             jsr       findfils
             lea.l     freresobj+2,a6       ;pointe sur la structure des freres
             move.l    a6,adrfrere
             move.w    (a6),d0
             move.w    d0,objcour

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfond
             jsr       affinventaire
             JSR_ECRSWAP 
             jsr       affinvfond
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6
             bra       objbas

o020b:       
             lea.l     objstruc,a0
             adda.w    #856*8,a0
             cmpi.w    #46,objpere(a0)      ;si pere tablette=bob
             bne       o020b0

             movem.l   d0-d7/a0-a6,-(sp)    ;cas particulier
             moveq.l   #tablettedecodee,d0  ;tablette mem->bob
             JSR_SCENASETBIT 
             movem.l   (sp)+,d0-d7/a0-a6
             beq       decotablette

o020b0:      
             tst.w     souri_5
             beq       o020b

             move.w    souri_6,d6           ;numero du bloc
             subq.w    #1,d6                ;-1 pour bloc interpelle

             ble       invrts

             movea.l   adrbiicour,a0
             moveq.l   #0,d0
             move.w    10(a0),d0
             adda.l    d0,a0                ;a0 pointe sur changement forme

             subq.w    #1,d6
             mulu.w    #14,d6
             move.w    2+10(a0,d6.w),d0     ;direction
;              cmpi.w   #0,d0
             beq       objhaut
             cmpi.w    #2,d0
             beq       objdroit
             cmpi.w    #3,d0
             beq       objbas
             cmpi.w    #1,d0
             beq       objgauche
             cmpi.w    #4,d0
             beq       getputobj
             cmpi.w    #5,d0
             beq       objmanger
             cmpi.w    #6,d0
             beq       objposer
             cmpi.w    #7,d0
             beq       objchercher
             cmpi.w    #8,d0
             beq       objinfo

o020:        
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             JSR_ECRSWAP 
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6

repeat:      
             bra       o020b

o020r:                 ;te
             JSR_RELACHE 
             bra       o020

invrts:      
             rts       

getputobj:   
             tst.w     objget
             bge       put
             move.w    objcour,d0
             move.w    d0,d1
             lsl.w     #3,d1
             lea.l     objstruct,a0
             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1

             move.w    objetat(a1,d2.w),d1  ;etat
             btst      #0,d1
             bne       o020                 ;l'objet est lie a son pere
             move.w    d0,objget

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       reduobj
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #sourislibre,souri_11
             JSR_RELACHE 
             bra       o020

put:         
             moveq.l   #-1,d6               ;scrolling vertical, objcour->objget

             lea.l     objstruct,a0
             move.w    objget,d0

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objcour,d0
             move.w    objget,d1
             jsr       inbranche
             movem.l   (sp)+,d0-d7/a0-a6
             beq       exitput              ;on a voulu mettre l'objet dans lui meme

             lsl.w     #3,d0
             move.w    objcour,d1

             lsl.w     #3,d1
             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1

             btst      #3,objetat+1(a1,d2.w)      ;etat de l'objet contenant
             beq       p099                 ;pas perce ...

             move.w    0(a0,d1.w),d1        ;on remonte d'un niveau
             move.w    objcour,d6           ;srcolling horizontal ex objcour->objget
             move.w    d1,objcour
             lsl.w     #3,d1

p099:        
;on regarde si l'objets peut contenir plusieurs objets

             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1
             btst      #4,objetat+1(a1,d2.w)
             beq       p099b

;l'objet ne peut contenir qu'un seul objet

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objcour,d0
             jsr       existfils
             movem.l   (sp)+,d0-d7/a0-a6
             beq       o020                 ;l'objets contient deja un objet

p099b:       

; on regarde si le deplacement d'objet est possible vis a vis du volume
; de contenance de l'objet courant

             move.w    0(a0,d0.w),d7        ;ancien proprietaire de objget
             move.w    objcour,0(a0,d0.w)

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objget,d0
             jsr       volumebrok
             movem.l   (sp)+,d0-d7/a0-a6
             beq       q000                 ;c'est bon...

             move.w    d7,0(a0,d0.w)        ;on remet dans l'etat anterieure

             bra       o020
q000:        

             move.w    d7,0(a0,d0.w)        ;on remet dans l'etat anterieure

; on regarde si le deplacement d'objet est possible vis a vis du poids
; de contenance de l'objet courant

             move.w    0(a0,d0.w),d7        ;ancien proprietaire de objget
             move.w    objcour,0(a0,d0.w)

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objget,d0
             jsr       poidsbrok
             movem.l   (sp)+,d0-d7/a0-a6
             beq       q000x                ;c'est bon...

             move.w    d7,0(a0,d0.w)        ;on remet dans l'etat anterieure

             bra       o020
q000x:       

             move.w    d7,0(a0,d0.w)        ;on remet dans l'etat anterieure


; on regarde si l'objet courant peut contenir le type
; d'objet dont fait parti l'objet en main

             move.w    objtype(a0,d1.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1
             move.w    objtypecont(a1,d2.w),d2    ;contenance selective
             blt       put0                 ;on peut contenir n'importe quoi

             move.w    objtype(a0,d0.w),d3  ;type de l'objet pris
             cmp.w     d3,d2
             bne       o020                 ;l'objet n'est pas le type autorise
put0:        
             move.w    objcour,0(a0,d0.w)   ;l'objet get obtient comme pere l'objet courant

             move.w    #-1,souri_11

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objcour,d0
             jsr       findfils
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     freresobj+2,a6
             move.l    a6,adrfrere
             move.w    objget,d7
p010:        
             cmp.w     (a6)+,d7
             bne       p010
             subq.l    #2,a6
             move.l    a6,adrfrere

             tst.w     d6
             blt       p101
             move.w    d6,d2
             moveq.l   #2,d4
             bra       p102
p101:        
             move.w    objcour,d2
             moveq.l   #1,d4
p102:        
             move.w    d7,d3
             move.w    d7,objcour

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       scrollobj
             movem.l   (sp)+,d0-d7/a0-a6

exitput:     
             move.w    #-1,souri_11
             move.w    #-1,objget
             JSR_RELACHE 
             bra       o020

;---------------------------------------------------------------
;
; objmanger
;

objmanger:   
             tst.w     inventtype
             bne       o020
             move.w    objget,d0
             blt       o020                 ;aucun objet selectionne
             lea.l     objstruct,a1
             move.w    d0,d1
             lsl.w     #3,d1
             adda.w    d1,a1
             move.w    objtype(a1),d1       ;type de l'objet

             lea.l     objlnourriture,a0
om0:         
             move.w    (a0)+,d7
             blt       boire
             cmp.w     d1,d7
             bne       om0

;manger l'objet

             move.w    objdivers1(a1),d0
             add.w     faim,d0
             cmpi.w    #4500,d0
             bgt       beurk
             move.w    d0,faim

             jsr       objracine

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       partie
             cmpi.w    #2,d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       manger000

             move.w    #9997,(a1)
             bra.s     manger00
manger000:   
             move.w    #9999,(a1)           ;poubelle...
manger00:    

             move.w    #-1,souri_11
             move.w    #-1,objget
             bra       o020

boire:       
             lea.l     objlboisson,a0
om1:         
             move.w    (a0)+,d7
             blt.s     beurk
             cmp.w     d1,d7
             bne.s     om1

             move.w    objdivers1(a1),d0
             add.w     soif,d0
             cmpi.w    #4000,d0
             bgt       beurk
             move.w    d0,soif

             jsr       objracine

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       partie
             cmpi.w    #2,d0
             movem.l   (sp)+,d0-d7/a0-a6
             bne       boire000

             move.w    #9997,(a1)
             bra.s     boire00
boire000:    
             move.w    #9999,(a1)           ;poubelle...
boire00:     

             move.w    #-1,souri_11
             move.w    #-1,objget
             bra       o020

beurk:       
             bra       o020

;---------------------------------------------------------------
;
; objposer
;

objposer:    
             move.w    objget,d0
             blt       o020                 ;aucun objet n'est selectionne

             cmpi.w    #6,inventtype
             beq       opprendre
             cmpi.w    #5,inventtype
             beq       invrts
             cmpi.w    #3,inventtype
             beq       opdonner
             tst.w     inventtype
             bne       o020


             lea.l     objstruc,a0
             lsl.w     #3,d0

             jsr       objracine

             tst.w     inventtype
             beq       inventjoueur

             move.w    #47,d1               ;corps
             bra       inventstock
inventjoueur:          
             move.w    exnocour,d1
             addi.w    #2000,d1
inventstock: 
             move.w    d1,objpere(a0,d0.w)

oprtr:       
             move.w    #-1,souri_11
             move.w    #-1,objget
             bra       o020

opprendre:   
             jsr       objracine

             move.w    objget,d7
             lsl.w     #3,d7
             lea.l     objstruc,a0
             adda.w    d7,a0
             move.w    #47,objpere(a0)

             bra       oprtr

opdonner:    
             move.w    evicour,d0
             addi.w    #3000,d0
             move.w    objget,d7
             lsl.w     #3,d7
             lea.l     objstruc,a0
             adda.w    d7,a0
             move.w    d0,objpere(a0)
             move.w    objget,d0
             jsr       prixobj
             divu.w    #50,d0
             bvs       prixfou
             addq.w    #1,d0
opd0:        
             move.w    evicour,d7
             mulu.w    #evisize,d7
             lea.l     evi,a0
             adda.w    d7,a0
             jsr       addlove
             jsr       majhumeur
             bra       oprtr

prixfou:     
             move.w    #255,d0
             bra.s     opd0

objracine:   
             movem.l   d0-d7/a0-a6,-(sp)

             move.w    objget,d0
             jsr       findobjracine
             cmp.w     racineobj,d0
             bne       objrx                ;l'objet n'est pas au pere de l'inventaire...

             move.w    objget,d0
             lsl.w     #3,d0
             lea.l     objstruc,a0
             move.w    objpere(a0,d0.w),d0

             movem.l   d0-d7/a0-a6,-(sp)
             lsl.w     #3,d0
             lea.l     objstruc,a0
             move.w    objpere(a0,d0.w),d0

             jsr       findfils
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     freresobj+2,a6

objup000:    
             cmp.w     (a6)+,d0
             bne.s     objup000
             subq.l    #2,a6

             move.l    a6,adrfrere
             move.w    (a6),objcour

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6
objrx:       
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

;---------------------------------------------------------------
;
; objacheter
;

objacheter:  
             tst.w     objget
             blt       o020
             cmpi.w    #2,inventtype
             beq       objvoler

             move.w    souri_11,-(sp)
             move.w    #sourismenu,souri_11
             move.w    objget,d0
             lsl.w     #3,d0
             lea.l     objstruc,a0
             move.w    objtype(a0,d0.w),d0

             cmp.w     negotype,d0
             beq       oa000
             move.w    #-1,negoprec
             move.w    d0,negotype
oa000:       

             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges
             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max


             move.w    #5,tetecour

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    4(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

oa2:         
             move.w    (a0),d0              ;offset sur phrase suivante
             lea.l     0(a0,d0.w),a1        ;phrase suivante
             addq.l    #6,a0
oa0:         
             tst.w     (a0)
             blt       oa1                  ;fin de phrase
             cmpi.w    #3000,2(a0)
             beq       oa3
             addq.l    #4,a0
             bra       oa0

oa1:         
             movea.l   a1,a0
             bra       oa2
oa3:         
             moveq.l   #0,d0
             move.w    (a0),d0

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge

             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    (a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             adda.l    d0,a0
             move.w    negoprec,d1

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    objget,d0
             jsr       prixobj
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d6/a0-a6,-(sp)
             lea.l     evi,a0
             move.w    evicour,d2
             cmpi.w    #4,inventtype
             beq       aote

             lea.l     marchand,a0
             move.w    marchandcour,d2
aote:        
             jsr       biomarchander
             clr.w     negoprec
             movem.l   (sp)+,d0-d6/a0-a6



             move.l    d7,d0
             movem.l   d7/a0,-(sp)
             jsr       bintoascii3
             movem.l   (sp)+,d7/a0




             movem.l   d1-d7/a0-a6,-(sp)
             cmp.l     negoprix,d7
             beq       oadernier
             moveq.l   #1,d0
             JSR_RND 
             move.w    d0,d6                ;2 reponses possibles
             move.w    #906,d0
             jsr       dissujet2
             bra.s     oad0
oadernier:   
             move.w    #907,d0
             jsr       dissujet
oad0:        
             movem.l   (sp)+,d1-d7/a0-a6

             move.l    d7,negoprix

             tst.w     d0
             bne       oa5

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    d7,d0
             jsr       assezargent
             movem.l   (sp)+,d0-d7/a0-a6
             bne       oatropcher



             sub.l     d7,argent

             move.w    objget,d0
             lsl.w     #3,d0
             lea.l     objstruc,a0
             jsr       objracine
             move.w    #47,objpere(a0,d0.w)
             move.w    #-1,objget
             move.w    #-1,228(sp)          ;remplacer souri_11
             move.w    #12345,negotype

oa5:         
             lea.l     100+128(sp),sp

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       restorescrlog
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       restorescrlog
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    (sp)+,souri_11
             JSR_RELACHE 
             bra       o020

oatropcher:  
             move.w    #908,d0
             jsr       dissujet
             bra       oa5

;---------------------------------------------------------------
;
; assezargent
;
; entree:     d0.l argent necessaire
;
; retour:     Z=1 assez d'argent
;

assezargent: 
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             move.w    #922,d1
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             bne       assezargentf

             cmp.l     argent,d0
             bgt       assezargentf
             moveq.l   #0,d0                ;Z=1
             rts       
assezargentf:          
             move.w    #4000,d0
             move.w    #88,d1
             jsr       findobjtype
             bne       assezargentf0
             jsr       prevenirflic

assezargentf0:         
             moveq.l   #-1,d0               ;z=0
             rts       

;---------------------------------------------------------------
;
; prevenirflic
;

prevenirflic:          
             moveq.l   #19,d0
             JSR_RND 
             mulu.w    #evisize,d0
             lea.l     evi,a0
             clr.b     evilove(a0,d0.w)
             rts       

;---------------------------------------------------------------
;
; biovoler
;
; entree:     a0 adresse de la structure de l'evi concerne
;
; retour:     Z=1 vol reussi
;             Z=0 vol rate
;

biovoler:    
             lea.l     jehan,a2
             moveq.l   #0,d1                ;J
             add.b     inte_c(a2),d1
             add.b     perc_c(a2),d1
             moveq.l   #0,d2                ;M
             add.b     marintel(a0),d2
             add.b     marpercep(a0),d2

             move.w    #150,d0
             add.w     d2,d0

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6
             cmp.w     d0,d1
             ble       biovolrate
             moveq.l   #0,d0                ;Z=1
             rts       
biovolrate:  
             moveq.l   #-1,d0               ;Z=0
             rts       

;---------------------------------------------------------------
;
; objvoler
;
; equation pour un vol reussi ou non
;
; M=perception+intelligence du marchand
; J=perception+intelligence du joueur
; on tire un chiffre tel que a=0 a M+150
; si J>a le vol a reussi
;

objvoler:    
             movea.l   adrevicour,a0
             jsr       biovoler
             bne       volrate


;reussi
             lea.l     objstruc,a0
             move.w    objget,d0
             lsl.w     #3,d0                ;*8
             jsr       objracine
             move.w    #47,objpere(a0,d0.w)
             move.w    #-1,souri_11
             move.w    #-1,objget

             JSR_RELACHE 
             bra       o020

volrate:     
             movea.l   adrevicour,a0
             moveq.l   #20,d0
             jsr       sublove
             jsr       majhumeur
             cmpi.w    #3,humeur
             bne.s     volrate0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       prevenirflic
             movem.l   (sp)+,d0-d7/a0-a6
volrate0:    
             move.w    #5,tetecour
             lea.l     -128(sp),sp
             move.l    sp,adrlocalbulle     ;buffer local pour coordo mots rouges
             move.l    sp,adrpilebulle
             move.l    sp,adrpbcour
             lea.l     -100(sp),sp          ;25 niveau de profondeur max

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    humeur,d0
             bne       vr0
             moveq.l   #1,d0
vr0:         
             addi.w    #903-1,d0

             jsr       dissujet
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     100+128(sp),sp

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       restorescrlog
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       restorescrlog
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             JSR_RELACHE 
             bra       o020

;---------------------------------------------------------------
;
; objchercher
;

objchercher: 
             cmpi.w    #3,inventtype
             beq       o020
             cmpi.w    #5,inventtype
             beq       o020
             cmpi.w    #6,inventtype
             beq       o020
             tst.w     inventtype
             bne       objacheter

             tst.w     objget
             bge       o020

             jsr       pileouface
             beq       o020r

             move.w    exnocour,d0
             addi.w    #2000,d0
             jsr       objalea
             tst.w     d0
             blt       o020r

             move.w    d0,objget

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       reduobj
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #sourislibre,souri_11
;              JSR_RELACHE
             bra       o020r

;---------------------------------------------------------------
;
; objinfo
;

objinfo:     
             tst.w     objget
             blt       o020

             move.w    objget,d0
             cmpi.w    #21,d0
             beq       lirelivre

             lsl.w     #3,d0
             lea.l     objstruc,a0
             cmpi.w    #44,objtype(a0,d0.w)
             beq       lirejournal

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affobjinfo
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affobjinfo
             movem.l   (sp)+,d0-d7/a0-a6

             JSR_RELACHE 

oi1:         
             tst.w     souri_5
             beq       oi1


             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             JSR_ECRSWAP 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfond
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinventaire
             movem.l   (sp)+,d0-d7/a0-a6


             JSR_RELACHE 
             bra       o020

;---------------------------------------------------------------
;
; affobjinfo
;

affobjinfo:  
             move.w    coinx,d0
             move.w    coiny,d1
             move.w    d0,d2
             move.w    d1,d3
             addi.w    #96,d0
             addi.w    #17,d1
             addi.w    #166,d2
             addi.w    #83,d3
             moveq.l   #9,d4

             JSR_PBOX 

             move.w    coinx,d1
             move.w    coiny,d2
             addi.w    #96,d1               ;x
             addi.w    #19,d2               ;y

             moveq.l   #11,d3               ;couleur
             move.w    #160,d4              ;160 octets par ligne
             movea.l   sys01,a1             ;adresse logique

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    objget,d0
             jsr       prixobj
             movem.l   (sp)+,d1-d7/a0-a6
             tst.l     d0
             beq       aoi6

             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii3
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa1,a0



             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #7,d2
aoi6:        

             movem.l   d1-d7/a0-a6,-(sp)
             move.w    objget,d0
             jsr       comptefils
             movem.l   (sp)+,d1-d7/a0-a6

             tst.w     d0
             beq       aoi0

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     aa,a0
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa2,a0

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #7,d2

aoi0:        
             addq.w    #7,d2

             lea.l     objstruc,a0
             move.w    objget,d7
             lsl.w     #3,d7
             adda.w    d7,a0
             move.l    objdivers1(a0),d6
             move.w    objtype(a0),d7

             lea.l     spoitab,a0
aoi1:        
             move.w    (a0)+,d0
             blt       aoi2                 ;fin de table
aoi4:        
             cmp.w     d0,d7
             beq       aoi3
             move.w    (a0)+,d0
             blt       aoi5                 ;fin de ligne
             bra       aoi4
aoi2:        
             rts       
aoi5:        
             addq.l    #4,a0                ;on saute l'adresse du sous prog
             bra       aoi1
aoi3:        
             tst.w     (a0)+
             bpl       aoi3
             movea.l   (a0),a0
             jmp       (a0)

aa:          .DC.l 0,0,0,0,0

spoi1:       
             lea.l     oit1,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit2,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2

             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     oit3,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0

             JSR_TEXTX 
             rts       
spoi2:       
             lea.l     oit4,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d1-d7/a0-a6,-(sp)
             lea.l     oit5,a0
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #7,d2
             addq.w    #7,d2
             lea.l     oit6,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2


             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     oit7,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             jmp       textx
spoi3:       
             tst.l     d6
             bne       spoi3_1
             lea.l     oit8,a0
             JSR_TEXTX 
             rts       
spoi3_1:     
             lea.l     oit9,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit10,a0
             JSR_TEXTX 
             rts       
spoi4:       
             lea.l     oit11,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d1-d7/a0-a6,-(sp)
             lea.l     oit12,a0
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #7,d2
             addq.w    #7,d2

             lea.l     oit13,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2


             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     oit14,a0
             JSR_TEXTX 
             rts       
spoi5:       
             tst.l     d6
             bne       spoi5_1
             lea.l     oit15,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit16,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit17,a0
             JSR_TEXTX 
             rts       
spoi5_1:     
             lea.l     oit18,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit19,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit20,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit21,a0
             jmp       textx
spoi6:       
             lea.l     oit22,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit23,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit24,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2

             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     oit25,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     aa,a0
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
spoi7:       
             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d1-d7/a0-a6,-(sp)
             lea.l     oit26,a0
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             mulu.w    #6,d0
             add.w     d0,d1
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #7,d2
             lea.l     oit27,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2

             move.w    objget,d0
             lsl.w     #3,d0
             lea.l     objstruc,a0
             move.w    objtype(a0,d0.w),d0
             mulu.w    #objtypesize,d0
             lea.l     objtypedata,a0
             move.w    objdiversi1(a0,d0.w),d0
             swap.w    d6                   ;valeur courante
             mulu.w    #100,d6
             divu.w    d0,d6                ;d6=(valeur courante/valeur initiale)*100
             lea.l     oit28,a0             ;hs
             tst.w     d6
             beq       spoi7_1
             lea.l     oit29,a0             ;mediocre
             cmpi.w    #30,d6
             blt       spoi7_1
             lea.l     oit30,a0             ;moyen
             cmpi.w    #60,d6
             blt       spoi7_1
             lea.l     oit31,a0             ;bon
             cmpi.w    #90,d6
             blt       spoi7_1
             lea.l     oit32,a0             ;neuf
spoi7_1:     
             JSR_TEXTX 
             rts       
spoi8:       
             lea.l     oit33,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             move.l    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii3
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa,a0
             tst.b     (a0)
             bne.s     spoi800
             move.b    #"0",(a0)
             clr.b     1(a0)
spoi800:     
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     oit34,a0
             jmp       textx
spoi9:       
             addq.w    #7,d2
             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     oit35,a0
             jmp       textx
spoi10:      
             lea.l     oit36,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             lea.l     oit37,a0
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             addq.w    #7,d2
             addq.w    #7,d2

             swap.w    d6
             move.w    d6,d0
             lea.l     aa,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       bintoascii
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     aa,a0
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             add.w     d0,d1
             lea.l     oit38,a0
             jmp       textx
             rts       

spoitab:     
typeprot:    .DC.w 66,67,68,69,70,71,72,102,103,105,-1
             .DC.l spoi1
             .DC.w 84,-1
             .DC.l spoi2
             .DC.w 10,-1
             .DC.l spoi3
             .DC.w 3,4,17,25,32,33,34,39,95,101,-1
             .DC.l spoi4
             .DC.w 19,-1
             .DC.l spoi5
typemuni:    .DC.w 56,57,58,59,60,61,62,63,64,65,-1         ;munitions
             .DC.l spoi6
typearme:    .DC.w 46,47,48,49,50,51,52,53,54,55,-1         ;armes
             .DC.l spoi7
             .DC.w 14,88,89,-1
             .DC.l spoi8
             .DC.w 9,-1
             .DC.l spoi9
             .DC.w 5,6,27,29,31,73,74,75,76,77,78,79,80,81,83,-1
             .DC.l spoi10
             .DC.w -1

;---------------------------------------------------------------
;
; prixobj
;
; entree:     d0 numero de l'objet
;
; retour:     d0.l prix de l'objet courant
;

prixobj:     
             jsr       prixobjr
             move.l    d7,d0
             rts       

;---------------------------------------------------------------
;
; prixobjr
;
; calcule le prix d'un objet (recursif)
;
; entree:     d0 numero de l'objet
;
; retour:     d7.l prix
;

prixobjr:    
             lea.l     objstruct,a0
             move.w    d0,d1
             lsl.w     #3,d1
             adda.w    d1,a0
             move.w    objtype(a0),d5
             cmpi.w    #typetitrepro,d5
             beq       prixtp
             move.w    d5,d6
             mulu.w    #objtypesize,d6
             lea.l     objtypedata,a1
             adda.w    d6,a1
             moveq.l   #0,d7
             move.w    objprix(a1),d7       ;prix vide

             lea.l     typemuni,a2
prixmuni:    
             move.w    (a2)+,d6
             blt       prixtp00
             cmp.w     d5,d6
             beq       prixetat2
             bra.s     prixmuni
prixtp00:    
             lea.l     typearme,a2
prixarme:    
             move.w    (a2)+,d6
             blt       prixtp000
             cmp.w     d5,d6
             beq       prixetat2
             bra.s     prixarme
prixtp000:   
             lea.l     typeprot,a2
prixprot:    
             move.w    (a2)+,d6
             blt       prixtp0
             cmp.w     d5,d6
             beq       prixetat1
             bra.s     prixprot


prixtp0:     
             lea.l     objstruct,a0





             moveq.l   #0,d2
p030p:       
             move.w    (a0),d1
             blt       rts
             cmp.w     d1,d0
             bne.s     p031p

             move.l    d7,-(sp)

             movem.l   d0-d2/a0,-(sp)
             move.w    d2,d0
             jsr       prixobjr
             movem.l   (sp)+,d0-d2/a0

             add.l     d7,(sp)
             move.l    (sp)+,d7

p031p:       
             addq.l    #8,a0
             addq.w    #1,d2                ;numero de l'objet examine
             bra.s     p030p
             rts       

prixtp:      
             move.w    objdivers1(a0),d7
             mulu.w    objdivers2(a0),d7
             bra       prixtp0

prixetat2:   
             movem.l   d0-d6/a0-a6,-(sp)

             move.l    d7,d0
             moveq.l   #0,d1
             move.w    objdivers2(a0),d1

             movem.l   d1-d7/a0-a6,-(sp)
             jsr       muls3232
             movem.l   (sp)+,d1-d7/a0-a6

             move.l    d0,d1
             move.w    objdiversi2(a1),d0
             movem.l   d1-d7/a0-a6,-(sp)
             jsr       divu32
             movem.l   (sp)+,d1-d7/a0-a6
             move.l    d0,d7
             movem.l   (sp)+,d0-d6/a0-a6
             bra       prixtp0

prixetat1:   
             movem.l   d0-d6/a0-a6,-(sp)

             move.l    d7,d0
             moveq.l   #0,d1
             move.w    objdivers1(a0),d1

             movem.l   d1-d7/a0-a6,-(sp)
             jsr       muls3232
             movem.l   (sp)+,d1-d7/a0-a6

             move.l    d0,d1
             move.w    objdiversi1(a1),d0
             movem.l   d1-d7/a0-a6,-(sp)
             jsr       divu32
             movem.l   (sp)+,d1-d7/a0-a6
             move.l    d0,d7
             movem.l   (sp)+,d0-d6/a0-a6
             bra       prixtp0

;---------------------------------------------------------------
;
; objhaut
;

objhaut:     
             bsr       objhautsp
             bra       o020

objhautsp:   
             move.w    objcour,d2
             move.w    d2,d0
             lsl.w     #3,d0
             lea.l     objstruct,a0
             move.w    0(a0,d0.w),d7        ;numero du pere de l'objet courant
             cmp.w     racineobj,d7
             beq       o020                 ;on est a la racine

             move.w    d7,d0
             lsl.w     #3,d0
             move.w    0(a0,d0.w),d0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       findfils             ;le pere du pere cree la table fils
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     freresobj+2,a6
p004:        
             cmp.w     (a6)+,d7
             bne       p004

             subq.l    #2,a6
             move.l    a6,adrfrere
             move.w    (a6),objcour

             move.w    objcour,d3
             moveq.l   #0,d4

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       scrollobj
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

objbas:      
             move.w    objcour,d0
             jsr       existfils
             bne       o020

             move.w    objcour,d2

             movea.l   adrfrere,a6
             move.w    (a6),objcour

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    (a6),d0
             jsr       findfils
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     freresobj+2,a6
             move.l    a6,adrfrere
             move.w    (a6),objcour

             move.w    objcour,d3
             moveq.l   #1,d4

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       scrollobj
             movem.l   (sp)+,d0-d7/a0-a6

             bra       o020

objgauche:   
             movea.l   adrfrere,a6
             tst.w     -2(a6)
             blt       o020

             move.w    objcour,d2
             subq.l    #2,adrfrere
             move.w    -(a6),objcour
             move.w    objcour,d3
             moveq.l   #2,d4

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       scrollobj
             movem.l   (sp)+,d0-d7/a0-a6

             bra       o020

objdroit:    
             movea.l   adrfrere,a6
             tst.w     2(a6)
             blt       o020

             move.w    objcour,d2
             addq.l    #2,adrfrere
             addq.l    #2,a6
             move.w    (a6),objcour
             move.w    objcour,d3
             moveq.l   #3,d4

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       scrollobj
             movem.l   (sp)+,d0-d7/a0-a6

             bra       o020

;---------------------------------------------------------------
;
; combatinv
;
; acces a l'inventaire a partir des combats...
;

combatinv:   
             move.w    #4000,racineobj
             clr.w     inventtype
             move.w    #-1,objget

             move.w    coinx,-(sp)
             move.w    coiny,-(sp)

             jsr       inventaire3b
             move.w    (sp)+,coiny
             move.w    (sp)+,coinx
             rts       


;---------------------------------------------------------------
;
; inventaire
;

inventaire:  
             moveq.l   #2,d0
             JSR_TRAITEEXP 

             move.w    #4000,racineobj
             clr.w     inventtype
             jsr       savescreen
             clr.w     souri_11

             move.w    #-1,objget
             bsr       inventaire2

             jsr       restorescreen



             move.w    #-1,souri_11
             bra       menumainexit

;---------------------------------------------------------------
;
; inventairev
;

inventairev: 
             move.w    #4000,racineobj
             clr.w     inventtype
             clr.w     souri_11

             bsr       inventaire4

             move.w    #-1,souri_11
             rts       

inventairem: 
             clr.w     souri_11
             move.w    #-1,objget
             bsr       inventaire4

             move.w    #-1,souri_11
             rts       
inventairem2:          
             clr.w     souri_11
             move.w    #-1,objget
             bsr       inventaire2

             move.w    #-1,souri_11
             rts       

inventaire2: 
             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,exnocour
             move.w    offsetx,-(sp)
             move.w    offsety,-(sp)
             move.w    tetecour,-(sp)

             jsr       inventaire3

             move.w    exnocour,nocour

             jsr       biitempoprog         ;12/2


             jsr       initson

             jsr       inipic
             jsr       inichf
             jsr       inibloc

             jsr       animinit


             move.w    (sp)+,tetecour
             move.w    (sp)+,offsety
             move.w    (sp)+,offsetx
             rts       




inventaire3: 
             move.w    #3*16+16,coinx
             move.w    #50+15,coiny

             clr.w     offsetx
             clr.w     offsety

             move.w    #900,nocour
             jsr       biitempoprog
             jsr       inichf
             jsr       debloc

             bsr       makeadrobj
             move.w    #-1,souri_11
             move.w    objget,d0
             blt       i30
             jsr       reduobj
             move.w    #sourislibre,souri_11
i30:         
             jsr       objets

             clr.w     souri_5

             move.w    #1900,d0
             jsr       memmasterkill
             .IF disquedur=0
             move.w    #900,d0
             jsr       deverouille
             .ENDIF 
             rts       

inventaire3b:          
             move.w    #3*16+16,coinx
             move.w    #50+15,coiny

             clr.w     offsetx
             clr.w     offsety

             move.w    #900,nocour
             jsr       biitempoprog
             jsr       inichf
             jsr       debloc

             bsr       makeadrobj
             move.w    #-1,souri_11
             move.w    objget,d0
             blt       i30b
             jsr       reduobj
             move.w    #sourislibre,souri_11
i30b:        
             jsr       objets

             clr.w     souri_5
             rts       

inventaire4: 
             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,exnocour
             move.w    offsetx,-(sp)
             move.w    offsety,-(sp)
             move.w    tetecour,-(sp)

             jsr       inventaire3

             move.w    exnocour,nocour

             jsr       biitempoprog

             jsr       initson
             jsr       inipic
             jsr       inichf
             jsr       animinit


             move.w    (sp)+,tetecour
             move.w    (sp)+,offsety
             move.w    (sp)+,offsetx
             rts       




;---------------------------------------------------------------
;
; affinventaire
;

affinventaire:         
             movea.l   adrbiicour,a5
             moveq.l   #0,d0
             move.w    14(a5),d0
             lea.l     2(a5,d0.l),a5        ;adresse anim statique

;on affiche les fleches

             move.w    objcour,d0
             lsl.w     #3,d0
             lea.l     objstruct,a0
             move.w    0(a0,d0.w),d0        ;numero du pere
             cmp.w     racineobj,d0
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfleche
             movem.l   (sp)+,d0-d7/a0-a6


             lea.l     16(a5),a5
             movea.l   adrfrere,a6
             cmpi.w    #-1,-2(a6)
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfleche
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     16(a5),a5
             movea.l   adrfrere,a6
             cmpi.w    #-1,2(a6)
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       affinvfleche
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     16(a5),a5
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    objcour,d0
             jsr       existfils
             movem.l   (sp)+,d0-d7/a0-a6
             jsr       affinvfleche

;on affiche l'objet

             moveq.l   #0,d0
             move.w    objcour,d0
             lsl.w     #3,d0
             lea.l     objstruc,a0
             move.w    objtype(a0,d0.w),d2
             mulu.w    #objtypesize,d2
             lea.l     objtypedata,a1
             moveq.l   #0,d0
             move.w    objmotif(a1,d2.w),d0

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #1900,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d7
             move.w    8(a0),d7
             lea.l     0(a0,d7.l),a1        ;adresse donnees graphiques
             move.w    14(a0),d7            ;offset sur anim stat
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0          ;on passe 8 anim
             move.w    8(a0),d7             ;offset sur donnees graphique
             adda.l    d7,a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             moveq.l   #9,d7
             lsl.w     d7,d0
             lea.l     0(a1,d0.l),a0        ;adresse obj dst
             movea.l   a0,a1
             moveq.l   #0,d0
             jsr       objdecal


;on affiche le pere

             jsr       affobjpere

;affichage du nom

             move.w    coinx,d0
             move.w    coiny,d1
             addi.w    #10-1,d0
             addi.w    #98,d1
             move.w    d0,d2
             move.w    d1,d3
             addi.w    #26*6,d2
             addi.w    #7,d3

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #9,d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    d1,d2
             move.w    d0,d1
             moveq.l   #11,d3
             move.w    #160,d4
             movea.l   sys01,a1

             move.w    objcour,d0
             lsl.w     #3,d0
             lea.l     objstruct,a0
             move.w    objtype(a0,d0.w),d7
             mulu.w    #objtypesize,d7
             lea.l     objtypedata,a5
             movea.l   objnom(a5,d7.w),a0   ;adresse du nom

             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6



             rts       

;---------------------------------------------------------------
;
; affinvfleche
;
; affichage des fleches de l'inventaire
;
; entree:     a5 pointe sur l'animation
;             Z=1 fleche normale
;             Z=0 fleche grisee
;

affinvfleche:          
             beq       aif0
             lea.l     4*16(a5),a5
aif0:        
             movea.l   adrdicour,a0
             adda.w    8(a5),a0
             move.w    4(a5),d0
             lsr.w     #1,d0
             move.w    6(a5),d1
             movea.l   sys01,a1
             move.w    #st160ag40,d2
             move.w    (a5),d3
             move.w    2(a5),d4
             add.w     coinx,d3
             add.w     coiny,d4
             jsr       transanim
             rts       

;---------------------------------------------------------------
;
; affinvfond
;

affinvfond:  
             movea.l   adrdicour,a0
             movea.l   adrbiicour,a6
             move.w    4(a6),d0
             lsr.w     #st1ag3,d0
             move.w    6(a6),d1

             movea.l   sys01,a1
             move.w    #st160ag40,d2
             move.w    coinx,d3
             move.w    coiny,d4
             jsr       transanim

             tst.w     inventtype
             beq       rts
             cmpi.w    #3,inventtype
             beq       if3
             cmpi.w    #4,inventtype
             beq       if4
             cmpi.w    #5,inventtype
             beq       if3
             cmpi.w    #6,inventtype
             beq       if3

             moveq.l   #0,d0
             moveq.l   #8,d1
             add.w     inventtype,d1
             jsr       affanimlog

             bsr       ifsp




             lea.l     marchand,a6
             move.w    marchandcour,d7
             mulu.w    #marsize,d7
             move.l    marcodegen(a6,d7.w),d3     ;code genetique

             addi.w    #116,d0
             addi.w    #17,d1
             moveq.l   #rouge,d2
             jsr       affitete2
             rts       

if3:         
             move.w    coinx,d0
             move.w    coiny,d1
             addi.w    #100-3,d0
             addi.w    #20-2,d1
             move.w    d0,d2
             move.w    d1,d3
             addi.w    #32-1,d2
             addi.w    #32-3,d3
             moveq.l   #marron,d4
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    coiny,d1
             addi.w    #20-2+35,d1
             move.w    d1,d3
             addi.w    #32-3,d3
             JSR_PBOX 
             cmpi.w    #6,inventtype
             bne       rts
             moveq.l   #0,d0
             moveq.l   #11,d1
             jsr       affanimlog
             rts       

if4:         
             moveq.l   #0,d0
             moveq.l   #9,d1
             jsr       affanimlog


             bsr       ifsp

             lea.l     evi,a6
             move.w    evicour,d7
             mulu.w    #evisize,d7
             move.l    evicodegen(a6,d7.w),d3     ;code genetique

             addi.w    #116,d0
             addi.w    #17,d1
             moveq.l   #rouge,d2
             jsr       affitete2
             rts       

ifsp:        
             move.w    coinx,d0
             move.w    coiny,d1
             move.w    d0,d2
             move.w    d1,d3

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #98-2,d0
             addi.w    #17,d1
             addi.w    #164+2,d2
             addi.w    #48,d3
             moveq.l   #9,d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #11,d4

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #116,d0
             addi.w    #17,d1
             addi.w    #147,d2
             move.w    d1,d3
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #116,d0
             addi.w    #17,d1
             move.w    d0,d2
             addi.w    #48,d3
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #8,d4

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #116,d0
             addi.w    #48,d1
             addi.w    #147,d2
             move.w    d1,d3
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #147,d0
             addi.w    #17,d1
             move.w    d0,d2
             addi.w    #48,d3
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #116+1,d0
             addi.w    #17+1,d1
             addi.w    #147-1,d2
             addi.w    #48-1,d3
             moveq.l   #14,d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                   ANIMATIONS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;---------------------------------------------------------------
;
; runanim
;
; entree:  a0 pointe sur animdebut courant
;          a1 pointe sur animpc courant
;          a2 pointe sur animfin courant
;          a3 pointe sur animpause courant
;          a4 pointe sur anima courant
;

runanim:     
             tst.w     (a2)
             blt       rts
             tst.w     (a3)
             bne       animinpause
             movea.l   (a1),a5
             addq.l    #4,(a1)              ;pc+4
             move.l    (a5),d0              ;code operatoire

             move.w    d0,d1
             move.w    d1,d2
             andi.w    #$ff,d2
             lsr.w     #8,d1
             moveq.l   #24,d7
             lsr.l     d7,d0

             tst.w     d0
             beq       animcode0
             cmpi.w    #1,d0
             beq       animcode1
             cmpi.w    #2,d0
             beq       animcode2
             cmpi.w    #3,d0
             beq       animcode3
             cmpi.w    #4,d0
             beq       animcode4
             cmpi.w    #5,d0
             beq       animcode5
             cmpi.w    #6,d0
             beq       animcode6
             cmpi.w    #7,d0
             beq       animcode7
             cmpi.w    #8,d0
             beq       animcode8
             cmpi.w    #9,d0
             beq       animcode9

             bra       violetturquoise
             rts                            ;ne doit jamais passer par la...

;---------------------------------------------------------------
;
; animinpause
;

animinpause: 
             subq.w    #1,(a3)
             rts       


;---------------------------------------------------------------
;
; animcode0
;
; $000000##         afficher #
;

animcode0:   
             move.w    d2,d0
             jmp       affanim

;---------------------------------------------------------------
;
; animcode1
;
; $01000000         afficher A
;
animcode1:   
             move.w    (a4),d0
             jmp       affanim

;---------------------------------------------------------------
;
; animcode2
;
; $020000##         pause #
;
animcode2:   
             subq.w    #1,d2
             move.w    d2,(a3)
             rts       

;---------------------------------------------------------------
;
; animcode3
;
; $03000000         pause A
;
animcode3:   
             move.w    (a4),d0
             subq.w    #1,d0
             blt       runanim
             move.w    d0,(a3)
             rts       

;---------------------------------------------------------------
;
; animcode4
;
; $0400XXYY         A aleatoire entre X et Y inclus
;
animcode4:   
             move.w    d2,d0
             sub.w     d1,d0

             tst.w     d0
             blt       jaunebleu
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6

             add.w     d1,d0
             move.w    d0,(a4)
             bra       runanim

;---------------------------------------------------------------
;
; animcode5
;
; $050000##         si A=0 aller ligne #
;
animcode5:   
             tst.w     (a4)
             bne       runanim
;---------------------------------------------------------------
;
; animcode6
;
; $060000##         aller ligne #
;
animcode6:   
             lsl.w     #2,d2
             movea.l   (a0),a5
             adda.w    d2,a5
             move.l    a5,(a1)
             bra       runanim

;---------------------------------------------------------------
;
; animcode7
;
; $07000000         animation terminee
;
animcode7:   
             move.w    #-1,(a2)
             rts       

;---------------------------------------------------------------
;
; animcode8
;
; $08000000         NOP
;
animcode8:   
             bra       runanim

;---------------------------------------------------------------
;
; animcode9
;
; $090000##         jouer son #
;
animcode9:   
             movem.l   d0-d7/a0-a6,-(sp)
             clr.w     noinst
             move.w    d2,noson1
             move.w    #1,novoie
             jsr       play_son
             movem.l   (sp)+,d0-d7/a0-a6

             bra       runanim

;---------------------------------------------------------------
;
; runanimall
;
; execute une instruction pour chaque animation statique
;

runanimall:  
             lea.l     animdebut,a0
             lea.l     animpc,a1
             lea.l     animfin,a2
             lea.l     animpause,a3
             lea.l     anima,a4

             clr.w     animstatcour

             move.w    animstatnb,d7
             subq.w    #1,d7
             blt       rts
raa0:        
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       runanim
             movem.l   (sp)+,d0-d7/a0-a6

             addq.w    #1,animstatcour
             addq.l    #4,a0
             addq.l    #4,a1
             addq.l    #2,a2
             addq.l    #2,a3
             addq.l    #2,a4

             dbra      d7,raa0
             rts       

;---------------------------------------------------------------
;
; animinit
;

animinit:    
             lea.l     animdebut,a0
             lea.l     animpc,a1
             lea.l     animfin,a2
             lea.l     animpause,a3
             lea.l     anima,a4

             movea.l   adrbiicour,a5
             moveq.l   #0,d0
             move.w    14(a5),d0
             beq       ai1

             adda.l    d0,a5
             move.w    (a5)+,d7
             move.w    d7,animstatnb
             subq.w    #1,d7
             moveq.l   #0,d0                ;groupes
ai0:         
             lea.l     16(a5),a6
             move.l    a6,(a1)+             ;pc
             move.l    a6,(a0)+             ;pc
             clr.w     (a3)+                ;anim pause

             move.w    #-1,(a2)+            ;anim fin=-1 (pas d'anim)
             move.w    12(a5),d1            ;type d'apparition
             blt       ai3                  ;toujours present
             cmpi.w    #1000,d1
             bge       ai3

             btst      d1,d0
             bne       ai2                  ;groupe deja utilise

             jsr       pileouface
             beq.s     ai2
ai4:         
             bset      d1,d0
ai3:         
             clr.w     -2(a2)               ;anim presente
ai2:         
             move.w    14(a5),d6            ;nb ligne prog
             lsl.w     #2,d6
             lea.l     16(a5,d6.w),a5
             dbra      d7,ai0
             rts       
ai1:         
             clr.w     animstatnb
             rts       

;---------------------------------------------------------------
;
; affanim
;
; affiche l'animation courante (animstatcour), etape d0
;
; entree:  d0 numero de l'etape
;

affanim:     
             movea.l   adrbiicour,a6
             move.w    4(a6),d2
             lsr.w     #1,d2

             move.w    animstatcour,d1
             lsl.w     #2,d1
             lea.l     animdebut,a6
             movea.l   0(a6,d1.w),a6
             lea.l     -16(a6),a6           ;pc-16=debut structure

             move.w    4(a6),d1
             mulu.w    6(a6),d1
             lsr.w     #1,d1                ;taille en octets de l'animation
             mulu.w    d0,d1
             moveq.l   #0,d7
             move.w    8(a6),d7
             add.l     d7,d1
             movea.l   adrdicour,a0
             adda.l    d1,a0
             move.w    4(a6),d0
             lsr.w     #1,d0
             move.w    6(a6),d1
             movea.l   adrdicour,a1
             move.w    (a6),d3
             move.w    2(a6),d4
             jmp       transanim



;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

affanimlog:  
             movea.l   adrbiicour,a6
             move.w    #st160ag40,d2
             moveq.l   #0,d7
             move.w    14(a6),d7
             lea.l     2(a6,d7.l),a6        ;adr anim stat

             subq.w    #1,d1
             blt       aaa0
aaa1:        
             move.w    14(a6),d7
             lsl.w     #2,d7
             lea.l     16(a6,d7.w),a6
             dbra      d1,aaa1
aaa0:        
             move.w    4(a6),d1
             mulu.w    6(a6),d1
             lsr.w     #1,d1                ;taille en octets de l'animation
             mulu.w    d0,d1
             moveq.l   #0,d7
             move.w    8(a6),d7
             add.l     d7,d1
             movea.l   adrdicour,a0
             adda.l    d1,a0
             move.w    4(a6),d0
             lsr.w     #1,d0
             move.w    6(a6),d1
             movea.l   sys01,a1
             move.w    coinx,d3
             move.w    coiny,d4
             add.w     (a6),d3
             add.w     2(a6),d4
             jmp       transanim



;---------------------------------------------------------------
;
; findbloc
;
; trouve le numero du bloc auquel apartiennent les coordonees
;
; entree:     a0 pointe sur le descripteur de bloc (se termine par -1)
;             d0 x
;             d1 y
;
; retour:     d0 numero du bloc (-1 si aucun)
;

findbloc:    
             moveq.l   #-1,d7
blocx:       
             move.w    (a0)+,d2
             blt       exib
             move.w    (a0)+,d3
             move.w    (a0)+,d4
             move.w    (a0)+,d5
             addq.w    #1,d7
             cmp.w     d0,d2
             bgt.s     blocx
             cmp.w     d0,d4
             blt.s     blocx
             cmp.w     d1,d3
             bgt.s     blocx
             cmp.w     d1,d5
             blt.s     blocx
             bra       exitbloc
exib:        
             moveq.l   #-1,d7
exitbloc:    
             move.w    d7,d0
             rts       




;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                           BIO-GAME
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

bio:         

evisize      equ 64

evinom       equ 0
evipotvie    equ 11
eviforce     equ 12
eviintel     equ 13
evireflex    equ 14
evivital     equ 15
evipercep    equ 16
evicharis    equ 17
evilieusrc   equ 18
evilieudst   equ 20
evivblsrc    equ 22
evicodegen   equ 26
evileader    equ 30
evilove      equ 31
evisavoir    equ 32

evilovel7    equ 64-4-1

;marlove
;---------------------------------------------------------------
;
; findevi
;
; recherche du numero d'un evi
;
; entree:     d0.l code genetique
;
; retour:     d0 numero de l'evi
;

findevi:     
             lea.l     evi,a0
fe0:         
             cmpi.w    #-1,(a0)
             beq       findevierr
             cmp.l     evicodegen(a0),d0
             beq.s     fe1

             lea.l     evisize(a0),a0
             bra.s     fe0

fe1:         
             suba.l    #evi,a0
             move.l    a0,d0
             divu.w    #evisize,d0
             rts       

findevierr:  
             moveq.l   #0,d0
             rts       

;---------------------------------------------------------------
;
; affpersogroupe
;

affpersogroupe:        
             moveq.l   #5,d0
             moveq.l   #5,d1
             move.w    #160-4,d2
             move.w    #yorg-7,d3
             moveq.l   #bleuclair,d4
             JSR_PBOX 

             lea.l     listegroupe,a0
             lea.l     missiongroupe,a1
             moveq.l   #6,d6
             moveq.l   #5-1,d7
affpg0:      
             move.w    (a0)+,d0
             cmpi.w    #-1,d0
             beq       affpg3
             bclr      #15,d0
             beq       affpg1
             mulu.w    #marsize,d0
             lea.l     marchand,a2
             move.l    marcodegen(a2,d0.w),d0
             moveq.l   #-1,d2
             cmpi.w    #128,nocour
             bne       affpg2
             moveq.l   #0,d2
             bra       affpg2
affpg1:      
             mulu.w    #evisize,d0
             lea.l     evi,a2
             move.l    evicodegen(a2,d0.w),d0
             move.w    (a1),d2
affpg2:      

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       makeperso
             jsr       makepersoma
             movem.l   (sp)+,d0-d7/a0-a6


             move.w    d6,d0
             moveq.l   #5,d1

             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affpersotete
             movem.l   (sp)+,d0-d7/a0-a6

affpg3:      
             addq.l    #6,a1
             addi.w    #30,d6
             dbra      d7,affpg0

             rts       

;---------------------------------------------------------------
;
; affpersotete
;
; affiche une tete de personnage du groupe
;
; entree:     le buffer de personnage doit etre construit
;             d0 x
;             d1 y
;             d2=0 normal, d2<>0 trame
;
; attention, cette routine est exclusivement ST
; ne pas chercher a l'adapter... mais la repenser en fonction de la machine
; cible!
;

tetedeltay   equ 4
ombredeltay  equ 4
ombredeltax  equ 4

affpersotete:          
             move.w    #5,puttc_1
             move.w    #5,puttc_2
             move.w    #160-4,puttc_3
             move.w    #yorg-7,puttc_4


             move.w    d2,trame

             lea.l     -582(sp),sp          ;buffer local de 24 ligne de 48 pixels +entete
             movea.l   sp,a6
             movem.l   d0-d7/a0-a6,-(sp)


             lea.l     persoma,a0

             lea.l     32/4/2*tetedeltay(a0),a0
             lea.l     32/4/2*ombredeltay(a0),a4
             lea.l     perso,a2
             lea.l     32/2*(tetedeltay+ombredeltay)(a2),a2
             lea.l     persoma,a3
             lea.l     32/4/2*(tetedeltay+ombredeltay)(a3),a3

             move.w    #48-1,(a6)
             move.w    #24-1,2(a6)
             move.w    #4,4(a6)
             lea.l     6(a6),a1

             moveq.l   #24-1,d7
apg0:        
             clr.l     (a1)
             clr.l     4(a1)
             clr.l     8(a1)
             clr.l     12(a1)
             clr.l     16(a1)
             clr.l     20(a1)

             move.l    (a0)+,d0
             not.l     d0
             tst.w     trame
             beq       agp01
             move.l    (a4)+,d6
             not.l     d6
             btst      #0,d7
             beq       agp00
             andi.l    #%10101010101010101010101010101010,d6
             bra       agp02
agp00:       
             andi.l    #%01010101010101010101010101010101,d6
             bra       agp02
agp01:       
             moveq.l   #0,d6
agp02:       
             move.l    d0,d2
             lsr.l     #ombredeltax,d0
             move.w    d0,d1
             swap.w    d0
             swap.w    d2
             clr.w     d2
             lsr.l     #ombredeltax,d2
             move.w    d0,d3
             move.w    d1,d4
             move.w    d2,d5
             not.w     d3
             not.w     d4
             not.w     d5

             or.w      d0,4(a1)
             or.w      d1,4+8(a1)
             or.w      d2,4+8*2(a1)

             swap.w    d6
             move.w    d6,d2
             not.w     d2

             move.w    (a3)+,d0

             and.w     d0,(a1)
             move.w    (a2)+,d1
             or.w      d6,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             or.w      d6,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             and.w     d2,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             and.w     d2,d1
             or.w      d1,(a1)+

             swap.w    d6                   ;registre pour OR
             move.w    d6,d2
             not.w     d2                   ;registre pour AND

             move.w    (a3)+,d0

             and.w     d0,(a1)
             move.w    (a2)+,d1
             or.w      d6,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             or.w      d6,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             and.w     d2,d1
             or.w      d1,(a1)+
             and.w     d0,(a1)
             move.w    (a2)+,d1
             and.w     d2,d1
             or.w      d1,(a1)+


             addq.l    #8,a1
;              addq.l   #2,a0
;              addq.l   #2,a4
;              addq.l   #2,a3

             dbra      d7,apg0
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   a6,a1
             jsr       puttc

             lea.l     582(sp),sp
             rts       

;---------------------------------------------------------------
;
; makeperso
;
; entree:     d0.l code genetique du personnage
;             Bit 31=0 face
;             Bit 31=1 profil
;             Bit 30=0 regarde vers la gauche
;             bit 30=1 regarde vers la droite
;
; codegenetique: $0abcdefg
;             a=race 0 humain, 1 shedish, 2 ilyen
;             b=sexe 0 homme, 1 femme
;             c=moustace 0=aucune
;             d=cheveux 0=aucun
;             e=menton
;             f=front
;             g=buste (0 pour ilyen seulement)
;

makeperso:   
             lea.l     perso,a1
             moveq.l   #62-1,d7
mp0:         
             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+
             dbra      d7,mp0

             move.l    d0,d7                ;code genetique

             move.l    d7,d3
             swap.w    d3
             move.w    d3,d4
             andi.w    #$f00,d3
             lsr.w     #8,d3                ;race
             move.w    d3,d0
             lsr.w     #1,d0
             bclr      #1,d3
             or.w      d0,d3                ;shedish=ylien

             andi.w    #$f0,d4
             lsr.w     #4,d4                ;sexe

             add.w     d3,d3
             add.w     d4,d3
             lsl.w     #4,d3
             lea.l     tableperso,a0
             adda.w    d3,a0

             move.w    (a0)+,d0             ;numero animation
             move.w    (a0)+,d2             ;1ere ligne

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d1
             andi.w    #$f,d1
             jsr       transperso           ;corps
             movem.l   (sp)+,d0-d7/a0-a6


             move.w    (a0)+,d0             ;numero animation
             move.w    (a0)+,d2             ;1ere ligne

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d1
             andi.w    #$f0,d1
             lsr.w     #4,d1
             btst      #31,d7
             beq.s     frontface
             addq.w    #5,d1
frontface:   
             jsr       transperso
             movem.l   (sp)+,d0-d7/a0-a6



             move.w    (a0)+,d0             ;numero animation
             move.w    (a0)+,d2             ;1ere ligne

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d1
             andi.w    #$f00,d1
             lsr.w     #8,d1
             btst      #31,d7
             beq.s     mentonface
             addq.w    #5,d1
mentonface:  
             jsr       transperso
             movem.l   (sp)+,d0-d7/a0-a6






             move.w    (a0)+,d0             ;numero animation
             move.w    (a0)+,d2             ;1ere ligne

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d7,d1
             andi.w    #$f000,d1
             beq       chauve
             lsr.w     #8,d1
             lsr.w     #4,d1
             subq.w    #1,d1
             btst      #31,d7
             beq.s     cheveuxface
             addq.w    #5,d1
             cmpi.w    #11,d0
             beq       cheveuxplus1
             cmpi.w    #10,d0
             bne       cheveuxface
cheveuxplus1:          
             addq.w    #1,d1                ;une etape de plus pour les humain male (casque)
cheveuxface: 
             jsr       transperso
chauve:      
             movem.l   (sp)+,d0-d7/a0-a6





             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #14,d0

             move.l    d7,d1
             swap.w    d1
             andi.w    #$f,d1
             beq       pasmoustache
             subq.w    #1,d1
             moveq.l   #21,d2
             btst      #31,d7
             beq.s     moustacheface
             addq.w    #3,d1
moustacheface:         
             jsr       transperso
pasmoustache:          
             movem.l   (sp)+,d0-d7/a0-a6

             btst      #30,d7
             beq       regardgauche
;on retourne le personnage

             lea.l     perso,a0
             movea.l   a0,a1
             movea.w   #62,a6
rp0:         
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             swap.w    d0
             swap.w    d1
             swap.w    d2
             swap.w    d3
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3

             movea.w   #32,a5
rp1:         
             add.l     d0,d0
             roxr.l    #1,d4
             add.l     d1,d1
             roxr.l    #1,d5
             add.l     d2,d2
             roxr.l    #1,d6
             add.l     d3,d3
             roxr.l    #1,d7

             subq.w    #1,a5
             cmpa.w    #0,a5
             bne       rp1

             addq.l    #8,a1
             move.w    d4,(a1)+
             move.w    d5,(a1)+
             move.w    d6,(a1)+
             move.w    d7,(a1)+
             swap.w    d4
             swap.w    d5
             swap.w    d6
             swap.w    d7
             lea.l     -16(a1),a1
             move.w    d4,(a1)+
             move.w    d5,(a1)+
             move.w    d6,(a1)+
             move.w    d7,(a1)+
             addq.l    #8,a1

             subq.w    #1,a6
             cmpa.w    #0,a6
             bne       rp0

regardgauche:          
             rts       

;---------------------------------------------------------------
;
; makepersoma
;

makepersoma: 
             lea.l     perso,a0
             lea.l     persoma,a1
             move.w    #62*2-1,d7

             jmp       p0

makeperso2:  
             lea.l     perso48a,a0
             lea.l     perso48ma,a1
             bsr       persomasque

             lea.l     perso48b,a0
             moveq.l   #62-1,d0
mp2clr:      
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+

             dbra      d0,mp2clr

             jsr       clipoff
             lea.l     perso48a,a0
             lea.l     perso48b,a1
             moveq.l   #8,d0                ;decalage de 8
             moveq.l   #0,d1
             moveq.l   #48,d2
             moveq.l   #62,d3
             moveq.l   #48/2,d4
             JSR_PUTTCX 

             lea.l     perso48b,a0
             lea.l     perso48mb,a1
             bsr       persomasque
             rts       


;---------------------------------------------------------------
;
; persomasque
;
; calcule le masque d'un personnage
;
; entree:     a0 adresse du buffer perso
;             a1 adresse du buffer masque
;

persomasque: 
             move.w    #62*3-1,d7
p0:          
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3

             move.w    d0,d4
             or.w      d1,d4
             or.w      d2,d4
             or.w      d3,d4
             not.w     d4
             move.w    d4,(a1)+
             dbra      d7,p0
             rts       

tableperso:            ;torse,front,menton,cheveux (no motif,no 1ere ligne)
             .DC.w 0,23,3,5,7,19,11,0       ;humain male
             .DC.w 1,28,5,5,9,19,13,0       ;humain femelle
             .DC.w 0,23,2,5+3,6,19,10,0+5   ;shedish male
             .DC.w 1,28,4,5+4+5,8,19+5,12,3 ;shedish femelle


;---------------------------------------------------------------
;
; transperso
;
; affichage transparent pour la creation du personnage
;
; entree:     d0 numero de l'animation
;             d1 numero de l'etape
;             d2 numero de la ligne de destination
;

transperso:  
             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             beq       noirvert
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d0
             move.w    8(a0),d0
             adda.l    d0,a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge
             movea.l   memadrbloc(a0),a6
             movem.l   (sp)+,d0-d7/a0-a5

             moveq.l   #0,d7
             move.w    14(a6),d7
             adda.l    d7,a6

             cmp.w     (a6),d0
             bge       errperso

             addq.l    #2,a6
             lsl.w     #4,d0
             adda.w    d0,a6

             cmp.w     10(a6),d1
             bge       errperso


             move.w    6(a6),d0             ;nombre de ligne
             move.w    d0,d7
             lsl.w     #4,d0                ;32 pixels de large soit 16 octets
             mulu.w    d1,d0                ;taille etape*no etape
             adda.w    d0,a0
             moveq.l   #0,d0
             move.w    8(a6),d0             ;offset
             adda.l    d0,a0

             lea.l     perso,a1
             lsl.w     #4,d2
             adda.w    d2,a1

             add.w     d7,d7
             subq.w    #1,d7
tp0:         
             move.w    (a0)+,d0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3

             move.w    d0,d4
             or.w      d1,d4
             or.w      d2,d4
             or.w      d3,d4
             not.w     d4

             and.w     d4,(a1)
             or.w      d0,(a1)+
             and.w     d4,(a1)
             or.w      d1,(a1)+
             and.w     d4,(a1)
             or.w      d2,(a1)+
             and.w     d4,(a1)
             or.w      d3,(a1)+

             dbra      d7,tp0
             rts       

errperso:    
             move.l    codegenetique,d0
             move.l    testevi,d1
             jsr       print
             JSR_ECRSWAP 
errperso2:   
             addq.w    #1,$ff8240
             bra       errperso2

;---------------------------------------------------------------
;
; jhm
;
; Calcule le jour, l'heure, la minute, la seconde en fonction
; de contvbl.
;
; 1 Jour      =        2^19 soit 524288 VBL
; 1 Heure     =                   21846 VBL
; 1 Minute    =                     365 VBL
;
; retour:     d0 Jours
;             d1 Heures
;             d2 Minutes
;

jhm::        
             move.l    contvbl,d0
             move.l    d0,d2
             moveq.l   #19,d6
             lsr.l     d6,d0
             andi.l    #$7ffff,d2
             divu.w    #21846,d2
             move.w    d2,d1
             clr.w     d2
             swap.w    d2
             divu.w    #365,d2
             rts       

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                           B.O.B
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

;---------------------------------------------------------------
;
; affpetitbob
;

affpetitbob: 
             tst.w     scrolltextbob
             beq       stb0
             subq.w    #1,scrolltextbob
             move.w    #1,petitbob2aff_
apb0:        
             lea.l     ecranpetitbob,a0
             moveq.l   #6,d0
             sub.w     scrolltextbob,d0
             mulu.w    #80,d0
             adda.w    d0,a0

             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #80,d0               ;80 octets de large
             moveq.l   #20,d1               ;20 lignes
             movea.l   sys01,a1
             move.w    #160,d2              ;160 octets de large
             move.w    #160,d3              ;x
             moveq.l   #7,d4                ;y
             jsr       transanim
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #80,d0               ;80 octets de large
             moveq.l   #20,d1               ;20 lignes
             movea.l   sys00,a1
             move.w    #160,d2              ;160 octets de large
             move.w    #160,d3              ;x
             moveq.l   #7,d4                ;y
             jsr       transanim


             rts       

stb0:        
             tst.w     textbobplein
             bne       newtextbob
             tst.w     petitbob2aff_
             beq       rts
             clr.w     petitbob2aff_
             bra       apb0

newtextbob:  
             lea.l     ecranpetitbob,a0
             lea.l     80*6(a0),a1
             move.w    #20*10-1,d7
bstb:        
             move.l    (a1)+,(a0)+
             move.l    (a1)+,(a0)+
             dbra      d7,bstb

             moveq.l   #20,d0
             jsr       effalignebob

             lea.l     buftextbob,a0
             lea.l     ecranpetitbob,a1
             moveq.l   #24,d0
             moveq.l   #7,d1
             moveq.l   #20,d2
             moveq.l   #11,d3
             moveq.l   #80,d4
             JSR_TEXTX 

             move.w    #7,scrolltextbob
             clr.w     textbobplein
             bra       affpetitbob

petitbob2aff_:         .DC.w 0

;affpb12:      .DC.w 0

;---------------------------------------------------------------
;
; effalignebob
;
; efface une ligne texte du petit ecran de bob
; (1 ligne texte = 6 lignes image)
;
; entree:     d0 numero de la "ligne image" de debut (de 0 a 20)
;

effalignebob:          
             mulu.w    #80,d0
             lea.l     ecranpetitbob,a0
             adda.w    d0,a0
             moveq.l   #5,d7

belb0:       
             move.l    #$dbff0400,(a0)+
             move.l    #$00001fff,(a0)+

             moveq.l   #8-1,d6
belb1:       
             move.w    #-1,(a0)+
             clr.l     (a0)+
             move.w    #-1,(a0)+
             dbra      d6,belb1

             move.l    #$ff6f0000,(a0)+
             move.l    #$0000ffe0,(a0)+
             dbra      d7,belb0
             rts       

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                           DYNORAMA
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------



;---------------------------------------------------------------
;
; inibloc
;

inibloc:     

; on definit la zone de blocage de la souris

             move.w    coinx,d1
             move.w    coiny,d2
             move.w    xaff,d0
             lsl.w     #4,d0
             add.w     coinx,d0
             subi.w    #16,d0
             move.w    d0,d3
             move.w    yaff,d0
             lsl.w     #4,d0
             add.w     coiny,d0
             subi.w    #16,d0
             move.w    d0,d4

; on corrige en fonction des contours

             tst.w     d1
             bne       zb000
             addq.w    #2,d1
zb000:       
             addq.w    #3,d1
             cmpi.w    #yorg,d2
             beq       zb001
             addq.w    #3,d2
zb001:       
             cmpi.w    #320-16,d3
             bne       zb002
             subq.w    #2,d3
zb002:       
             subq.w    #3,d3
             cmpi.w    #yorg+160-16,d4
             beq       zb003
             subq.w    #3,d4
zb003:       

; on stocke le resultat

             lea.l     souri_13,a0
             move.w    d1,(a0)+
             move.w    d2,(a0)+
             move.w    d3,(a0)+
             move.w    d4,(a0)+

;on positionne la souris au centre de l'ecran courant

             move.w    xaff,d0
             lsl.w     #3,d0                ;*16/2
             add.w     coinx,d0
             move.w    d0,wx_souris
             move.w    yaff,d0
             lsl.w     #3,d0                ;*16/2
             add.w     coiny,d0
             move.w    d0,wy_souris
             rts       

;---------------------------------------------------------------
;
; scroll
;

scroll:      
             move.w    souri_7,d2
             move.w    souri_8,d3
             lea.l     souri_13,a0
             cmp.w     (a0),d2
             beq       offxmoins
             cmp.w     4(a0),d2
             beq       offxplus

a000:        
             JSR__AFF 
             rts       

offxmoins:   
             move.w    offsetx,d0
             clr.w     d1
             subq.w    #1,d0
             jsr       maxs
             cmp.w     offsetx,d0
             beq.s     a000
             move.w    d0,offsetx
             jsr       inichf
             bra.s     a000

offxplus:    
             move.w    offsetx,d0
             move.w    offmaxx,d1
             addq.w    #1,d0
             jsr       mins
             cmp.w     offsetx,d0
             beq.s     a000
             move.w    d0,offsetx
             jsr       inichf
             bra.s     a000

;---------------------------------------------------------------
;
; mins
;
; place dans d0 le minimum entre d0 et d1 (16 bits signe)
;

mins:        
             cmp.w     d0,d1
             bgt.s     mins0
             move.w    d1,d0
mins0:       
             rts       
;---------------------------------------------------------------
;
; min
;
; place dans d0 le minimum entre d0 et d1 (16 bits non-signe)
;

min:         
             cmp.w     d0,d1
             bhi.s     min0
             move.w    d1,d0
min0:        
             rts       

;---------------------------------------------------------------
;
; maxs
;
; place dans d0 le maximum entre d0 et d1 (16 bits signe)
;

maxs:        
             cmp.w     d1,d0
             bgt.s     maxs0
             move.w    d1,d0
maxs0:       
             rts       

             .IF debug
checkmem:    
             lea.l     memtable,a0
             move.w    #memnbblocmax-1,d7
             moveq.l   #0,d0
cm0:         
             add.l     (a0),d0
             lea.l     16(a0),a0
             dbra      d7,cm0
             move.l    memadrchip,d1

             move.w    volx1,d0
             move.w    volx2,d1

             jsr       print
             rts       
             .ENDIF 

;---------------------------------------------------------------
;
; _aff
;
; affichage du morceau d'ecran courant
;

_aff:        
             jsr       aff2
             jsr       _affperso
             jsr       affcontour
             jmp       affpetitbob


aff2:        
             movea.l   sys01,a1
             move.w    coiny,d0
             mulu.w    #160,d0
             adda.l    d0,a1

             movea.l   adrdicour,a0
             move.w    offsety,d0
             lsl.w     #4,d0
             mulu.w    #160,d0
             adda.l    d0,a0
             move.w    coinx,d0
             lsr.w     #1,d0
             lea.l     0(a1,d0.w),a1

             movea.l   a1,a2

             move.w    yaff,d7
             lsl.w     #4,d7
             subq.w    #1,d7

             move.w    offsetx,d5
             lsl.w     #3,d5
             lea.l     0(a0,d5.w),a0

             movea.l   adrbiicour,a6
             move.w    4(a6),d4
             lsr.w     #4,d4                ;largeur/16
             sub.w     xaff,d4
             lsl.w     #3,d4

             cmpi.w    #20,xaff
             bne       baff2

baff:        
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     40(a1),a1
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     40(a1),a1
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     40(a1),a1
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     40(a1),a1

             lea.l     0(a0,d4.w),a0
             dbra      d7,baff
             bra       aff2fin

;              rts

baff2:       
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     40(a1),a1
             movem.l   (a0)+,d0-d3/d5/d6/a2-a5
             movem.l   d0-d3/d5/d6/a2-a5,(a1)
             lea.l     0(a0,d4.w),a0
             lea.l     120(a1),a1
             dbra      d7,baff2

aff2fin:     
             rts       


gestionperso:          
             move.l    codegenetique,d0
             lea.l     evi,a0
ap00:        
             cmp.l     evicodegen(a0),d0
             bne       ap1
             move.l    contvbl,d7
             sub.l     evivblsrc(a0),d7
             lsr.w     #4,d7
             lsl.w     #3,d7
             bra       ap2
ap1:         
             lea.l     evisize(a0),a0
             bra       ap00
ap2:         
             move.w    d7,xperso
             move.l    a0,adrperso
             .IF protege
             divu.w    d7,d6
             .ENDIF 
             rts       

;---------------------------------------------------------------
;
; _affperso
;

_affperso:   
             tst.w     doaffperso
             beq       pasaffperso

             movea.l   adrperso,a0
             move.w    xperso,d7
             move.w    nocour,d0
             cmp.w     evilieusrc(a0),d0
             bne       clrdoaffperso

             lea.l     perso48a,a0
             lea.l     perso48ma,a2
             movea.l   sys01,a1
             move.w    yaff,d1
             lsl.w     #4,d1

             subi.w    #64,d7

             tst.w     senspersocour
             bne       ap20
             neg.w     d7
             addi.w    #320-64,d7
ap20:        
             move.w    d7,d0                ;              add.w    d7,d0
             move.w    offsetx,d5
             lsl.w     #4,d5
             sub.w     d5,d0


             moveq.l   #62-1,d7
             btst      #3,d0
             beq       persomodulo16
             bclr      #3,d0
             lea.l     perso48b,a0
             lea.l     perso48mb,a2
             addq.w    #3,d1
             subq.w    #3,d7
persomodulo16:         

             move.w    xaff,d6
             lsl.w     #4,d6

             cmp.w     d6,d0
             bge       rts
             cmpi.w    #-32,d0
             blt       rts
             bne       aps0
             moveq.l   #0,d0
             lea.l     16(a0),a0
             addq.l    #4,a2
             moveq.l   #1,d6
             bra       aps10
aps0:        
             cmpi.w    #-16,d0
             bne       aps1
             moveq.l   #0,d0
             addq.l    #8,a0
             addq.l    #2,a2
             moveq.l   #2,d6
             bra       aps10
aps1:        
             subi.w    #16,d6
             cmp.w     d0,d6
             bne       aps2
             moveq.l   #1,d6
             bra       aps10
aps2:        
             subi.w    #16,d6
             cmp.w     d0,d6
             bne       aps3
             moveq.l   #2,d6
             bra       aps10
aps3:        
             moveq.l   #3,d6

aps10:       

             add.w     coinx,d0
             move.w    d0,d4
             lsr.w     #1,d0
             adda.w    d0,a1

             move.w    coiny,d5
             add.w     d1,d5
             subi.w    #62,d5
             move.w    d5,d0
             mulu.w    #160,d0
             adda.w    d0,a1

             lea.l     souri_14,a6
             move.w    d4,(a6)+
             move.w    d5,(a6)+
             addi.w    #31,d4
             addi.w    #61,d5
             move.w    d4,(a6)+
             move.w    d5,(a6)+
             move.w    #sourisinterpel,(a6)+

             move.w    xperso,exxperso
             cmpi.w    #1,d6
             beq       affperso1
             cmpi.w    #2,d6
             beq       affperso2
             cmpi.w    #3,d6
             beq       affperso3
             rts       

pasaffperso: 
             lea.l     souri_14,a0          ;plus de zone de selection pour interpel
             move.l    #400*65536+400,d0
             move.l    d0,(a0)+
             move.l    d0,(a0)+
             rts       

;---------------------------------------------------------------
;
; affperso3
;
; affichage du personage avec 3 mots de large (48 pixels)
;
; entree:     d7 nombre de ligne-1
;             a0 adresse du motif
;             a1 adresse ecran
;             a2 adresse du masque
;

affperso3:   
             swap.w    d7
             movem.l   (a0)+,d0-d5

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d0,(a1)+
             and.l     d6,(a1)
             or.l      d1,(a1)+

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d2,(a1)+
             and.l     d6,(a1)
             or.l      d3,(a1)+

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d4,(a1)+
             and.l     d6,(a1)
             or.l      d5,(a1)+

             lea.l     160-24(a1),a1
             swap.w    d7
             dbra      d7,affperso3
             rts       

;---------------------------------------------------------------
;
; affperso2
;
; affichage du personage avec 2 mots de large (32 pixels)
;
; entree:     d7 nombre de ligne-1
;             a0 adresse du motif
;             a1 adresse ecran
;             a2 adresse du masque
;

affperso2:   
             swap.w    d7
             movem.l   (a0)+,d0-d3
             addq.l    #8,a0

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d0,(a1)+
             and.l     d6,(a1)
             or.l      d1,(a1)+

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d2,(a1)+
             and.l     d6,(a1)
             or.l      d3,(a1)+

             addq.l    #2,a2

             lea.l     160-16(a1),a1
             swap.w    d7
             dbra      d7,affperso2
             rts       


;---------------------------------------------------------------
;
; affperso1
;
; affichage du personage avec 1 mot de large (16 pixels)
;
; entree:     d7 nombre de ligne-1
;             a0 adresse du motif
;             a1 adresse ecran
;             a2 adresse du masque
;

affperso1:   
             swap.w    d7
             move.l    (a0)+,d0
             move.l    (a0)+,d1
             lea.l     16(a0),a0

             move.w    (a2)+,d6
             move.w    d6,d7
             swap.w    d6
             move.w    d7,d6

             and.l     d6,(a1)
             or.l      d0,(a1)+
             and.l     d6,(a1)
             or.l      d1,(a1)+


             addq.l    #4,a2
             lea.l     160-8(a1),a1
             swap.w    d7
             dbra      d7,affperso1
             rts       


doaffperso:  .DC.w 0

clrdoaffperso:         
             clr.w     doaffperso
             rts       


;---------------------------------------------------------------
;
; relache
;

relache:     
             tst.w     souri_5
             bne.s     relache
             rts       

;---------------------------------------------------------------
;
; inichf
;
; initialise les zones de changement de forme de la souris
;

inichf:      
             movea.l   adrbiicour,a0
             lea.l     souri_14,a1
             moveq.l   #0,d0
             move.w    10(a0),d0
             adda.l    d0,a0                ;adresse changement forme

             move.w    (a0)+,d7             ;nombre de blocs
             beq       e005

             subq.w    #1,d7

             move.w    #255,(a1)+           ;la priorite max est
             move.w    #255,(a1)+           ;reservee pour
             move.w    #255,(a1)+           ;les interpels
             move.w    #255,(a1)+
             move.w    #sourisinterpel,(a1)+

b000:        
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    (a0)+,d4

             bsr       addoffsetclip

             move.w    d1,(a1)+
             move.w    d2,(a1)+
             move.w    d3,(a1)+
             move.w    d4,(a1)+
             move.w    (a0)+,(a1)+
             addq.l    #4,a0                ;on saute le numero de la destination et sous prog test
             dbra      d7,b000
e005:        
; on traite le cas des marchands

             lea.l     marchandlst,a6
             movea.l   adrbiicour,a0
             moveq.l   #0,d0
             move.w    14(a0),d0
             beq       e005x
             adda.l    d0,a0
             move.w    (a0)+,d0             ;nombre de bloc statiques
             subq.w    #1,d0

icf0:        
             move.w    12(a0),d7
             cmpi.w    #1000,d7
             blt       ifc1                 ;ce n'est pas un marchand

;              movem.l  d0-d7/a0-a6,-(sp)
;              subi.w   #1000,d7
;              move.w   d7,d0
;              jsr      marpresent
;              movem.l  (sp)+,d0-d7/a0-a6
;              bne      ifc1

             move.w    (a0),d1              ;x
             move.w    2(a0),d2             ;y
             move.w    d1,d3
             move.w    d2,d4
             add.w     4(a0),d3             ;x+largeur
             add.w     6(a0),d4             ;y+hauteur

             addi.w    #16,d1
             addi.w    #16,d2
             subi.w    #16,d3
             subi.w    #16,d4

             movem.l   d0/d5-d7/a0-a6,-(sp)
             bsr       addoffsetclip
             movem.l   (sp)+,d0/d5-d7/a0-a6


             move.w    d1,(a1)+
             move.w    d2,(a1)+
             move.w    d3,(a1)+
             move.w    d4,(a1)+
             move.w    d7,d6
             subi.w    #1000,d6
             mulu.w    #marsize,d6
             lea.l     marchand,a5
             moveq.l   #0,d5
             move.b    marmetier(a5,d6.w),d5
             add.w     d5,d5
             lea.l     metiericone,a5
             move.w    0(a5,d5.w),(a1)+
             move.w    d7,(a6)+
ifc1:        
             move.w    14(a0),d7            ;nb ligne du prog d'anim
             lsl.w     #2,d7                ;1 instruction =4 octets
             lea.l     16(a0,d7.w),a0
             dbra      d0,icf0
e005x:       
             move.w    #-1,(a1)+            ;fin de la table
rts:         rts       


;---------------------------------------------------------------
;
; addoffsetclip
;

addoffsetclip:         
             move.w    offsetx,d5
             lsl.w     #4,d5
             neg.w     d5
             add.w     coinx,d5
             add.w     d5,d1
             add.w     d5,d3

             move.w    offsety,d5
             lsl.w     #4,d5
             neg.w     d5
             add.w     coiny,d5
             add.w     d5,d2
             add.w     d5,d4

             clr.w     d0
             jsr       maxs
             move.w    d0,d5
             move.w    d2,d1
             clr.w     d0
             jsr       maxs
             move.w    d0,d2
             move.w    d5,d1
             rts       


;---------------------------------------------------------------
;
; inipic
;

inipic:      
             movea.l   adrbiicour,a0
             move.w    4(a0),d0
             lsr.w     #4,d0                ;largeur/16
             cmpi.w    #20,d0
             blt       e000
             move.w    #20,xaff
             bra       e001
e000:        
             move.w    #10,xaff
e001:        
             move.w    6(a0),d1
             lsr.w     #4,d1                ;hauteur/16
             cmpi.w    #10,d1
             blt       e002
             move.w    #10,yaff
             bra       e003
e002:        
             move.w    #5,yaff
e003:        
             sub.w     xaff,d0
             move.w    d0,offmaxx
             lsr.w     #1,d0
             move.w    d0,offsetx           ;position milieu
             sub.w     yaff,d1
             move.w    d1,offmaxy
             lsr.w     #1,d1
             move.w    d1,offsety           ;position milieu

;recherche de la zone d'ecran propice a l'affichage

;on recherche si le lieu n'apparait pas deja sur l'ecran

             moveq.l   #3,d0
             lea.l     quart1no,a0
             move.w    nocour,d1
             moveq.l   #-1,d7
a031:        
             cmp.w     (a0),d1
             bne       a032
             move.w    d0,d7
a032:        
             addq.l    #8,a0
             dbra      d0,a031

             tst.w     d7
             blt       a033

             move.w    d7,d6
             neg.w     d6
             addq.w    #3,d6                ;numero du quart
             lea.l     quart1coin,a0
             lsl.w     #3,d6
             move.w    2(a0,d6.w),offsetx
             move.w    4(a0,d6.w),offsety
             move.w    0(a0,d6.w),d6        ;numero du quart d'ecran du coin
             subq.w    #1,d6                ;(de 0 a 3)

a033:        

;le lieu n'existe pas sur l'ecran, on recherche la meilleur place

             addq.w    #1,ancienc
             move.w    ancienc,d0
             moveq.l   #0,d1
             moveq.l   #0,d2
             moveq.l   #0,d3
             moveq.l   #0,d4
             lea.l     ancien1,a0
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             move.w    (a0)+,d4

             cmpi.w    #10,xaff
             bne       a005                 ;largeur totale
             cmpi.w    #5,yaff
             bne       a008

;                   quart d'ecran 1 ou 2 ou 3 ou 4

             tst.w     d7
             bge       a034                 ;le quart d'ecran est impose

             moveq.l   #100,d5              ;min
             moveq.l   #3,d7
             lea.l     ancien1,a0
a011:        
             move.w    (a0)+,d1
             cmp.w     d5,d1
             bhi       a013

             move.w    d1,d5
             move.w    d7,d6
a013:        
             dbra      d7,a011

             neg.w     d6
             addq.w    #3,d6                ;numero du quart d'ecran le plus ancien

a034:        
             tst.w     d6
             beq       a014
             cmpi.w    #1,d6
             beq       a015
             cmpi.w    #2,d6
             beq       a016

             move.w    d0,ancien4
             move.w    #160,coinx
             move.w    #80+yorg,coiny

             move.w    nocour,quart4no
             move.w    #4,quart4coin
             bra       a007

a014:        
             move.w    d0,ancien1
             clr.w     coinx
             move.w    #yorg,coiny

             move.w    nocour,quart1no
             move.w    #1,quart1coin
             bra       a007
a015:        
             move.w    d0,ancien2
             move.w    #160,coinx
             move.w    #yorg,coiny

             move.w    nocour,quart2no
             move.w    #2,quart2coin
             bra       a007
a016:        
             move.w    d0,ancien3
             clr.w     coinx
             move.w    #80+yorg,coiny

             move.w    nocour,quart3no
             move.w    #3,quart3coin
             bra       a007

a008:                  ;demi ecran vertical 13 ou 24
             tst.w     d7
             blt       a035                 ;le demi ecran n'est pas impose

             tst.w     d6
             beq       a010
             cmpi.w    #1,d6
             beq       a036
             cmpi.w    #2,d6
             beq       a010
             cmpi.w    #3,d6
             beq       a036

a035:        
             add.l     d1,d3
             add.l     d2,d4
             cmp.l     d3,d4
             bgt       a010
a036:        
;                   24 est le plus vieux
             lea.l     ancien2,a0
             move.w    d0,(a0)
             move.w    d0,4(a0)
             move.w    #160,coinx
             move.w    #yorg,coiny

             move.w    nocour,quart2no
             move.w    #2,quart2coin
             move.w    nocour,quart4no
             move.w    #2,quart4coin
             bra       a007
a010:        
;                   13 est le plus vieux

             lea.l     ancien1,a0
             move.w    d0,(a0)
             move.w    d0,4(a0)
             clr.w     coinx
             move.w    #yorg,coiny

             move.w    nocour,quart1no
             move.w    #1,quart1coin
             move.w    nocour,quart3no
             move.w    #1,quart3coin
             bra       a007
a005:        
             cmpi.w    #5,yaff
             bne       a006

;                   demi ecran horizontal 12 ou 34
             tst.w     d7
             blt       a037                 ;le demi ecran n'est pas impose
             tst.w     d6
             beq       a009
             bra       a038

a037:        

             add.l     d1,d2
             add.l     d3,d4
             cmp.l     d2,d4
             bgt       a009

a038:        
;                   34 est plus vieux

             lea.l     ancien3,a0
             move.w    d0,(a0)+
             move.w    d0,(a0)+
             clr.w     coinx
             move.w    #80+yorg,coiny

             move.w    nocour,quart3no
             move.w    #3,quart3coin
             move.w    nocour,quart4no
             move.w    #3,quart4coin
             bra       a007
a009:                  ;12 est plus vieux

             lea.l     ancien1,a0
             move.w    d0,(a0)+
             move.w    d0,(a0)+
             clr.w     coinx
             move.w    #yorg,coiny

             move.w    nocour,quart1no
             move.w    #1,quart1coin
             move.w    nocour,quart2no
             move.w    #1,quart2coin
             bra       a007
a006:                  ;plein ecran ->1234
             clr.w     ancienc
             clr.w     d0
             clr.w     coinx
             move.w    #yorg,coiny
             lea.l     ancien1,a0
             move.w    d0,(a0)+
             move.w    d0,(a0)+
             move.w    d0,(a0)+
             move.w    d0,(a0)+

             move.w    nocour,d0
             moveq.l   #1,d1
             lea.l     quart1no,a0
             swap.w    d0
             move.w    d1,d0

             .REPT 4
             move.l    d0,(a0)+             ;no/coin
             clr.l     (a0)+                ;offset x et y
             .ENDR 
a007:        
             rts       


             .IF disquedur=1
;---------------------------------------------------------------
;
; loaddata
;
;
; entree:  d0 numero du fichier (pour structure memoire)
;          a0 adresse du nom
;


loaddata:    
             move.l    a0,ldadr
             move.w    d0,ldno

             clr.w     -(sp)                ;fsfirst
             move.l    ldadr,-(sp)          ;              pea      (a0)
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp
             tst.l     d0
             blt       memerr

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             addq.l    #1,d5
             andi.w    #$fffe,d5

             clr.w     -(sp)                ;lecture seule
             move.l    ldadr,-(sp)          ;              pea      (a0)
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    d5,d0                ;taille
             move.w    ldno,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             rts       

ldadr:       .DC.l 0
ldno:        .DC.w 0

;---------------------------------------------------------------
;
; load
;
; charge un fichier DYNO
;
; entree:  d0 numero du fichier
;

load:        
             movem.l   d0-d7/a0-a6,-(sp)

             move.w    d0,d7

             divu.w    #10,d0
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomno+2
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             addi.w    #"0",d0
             move.b    d0,nomno
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomno+1


             clr.w     -(sp)                ;fsfirst
             pea       nom0
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp
             tst.l     d0
             blt       loadexit

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       nom0                 ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    d5,d0                ;taille
             move.w    d7,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0
             move.l    a0,adrbiicour
             movem.l   (sp)+,d0-d7/a1-a6

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp

loadexit:    
             movem.l   (sp)+,d0-d7/a0-a6

             .IF son
             jsr       loadsndseq
             .ENDIF 
             rts       

             .ENDIF 

;---------------------------------------------------------------
;
; loadsndseq
;

loadsndseq:  
             movea.l   adrbiicour,a6

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #0,d0
             move.w    14(a6),d0
             beq       lsspasanim

             lea.l     0(a6,d0.l),a0
             move.w    (a0)+,d6             ;nombre d'animation statique
lssloop:     
             lea.l     16(a0),a1
             move.w    14(a0),d1
             beq       lsspasprog           ;0 ligne de prog
             subq.w    #1,d1

lss0:        

             move.l    (a1)+,d7
             moveq.l   #0,d0
             move.b    d7,d0
             swap.w    d7
             andi.w    #$ff00,d7
             cmpi.w    #$0900,d7
             bne       lss1

             movea.l   adrbiicour,a5        ;#####

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #nosondebut,d0
             jsr       loadsnd
             movem.l   (sp)+,d0-d7/a0-a6

             cmpa.l    adrbiicour,a5        ;#####
             beq.s     lss1                 ;#####
             suba.l    adrbiicour,a5        ;#####
             suba.l    a5,a0                ;#####
             suba.l    a5,a1                ;#####

lss1:        
             dbra      d1,lss0

lsspasprog:  
             movea.l   a1,a0
             dbra      d6,lssloop
lsspasanim:  

             movem.l   (sp)+,d0-d7/a0-a6
             movea.l   adrbiicour,a6        ;#####
             moveq.l   #0,d0
             move.w    20(a6),d0
             beq       rts
             lea.l     0(a6,d0.l),a0

;a0=adresse de la sequence

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loadsndseq2
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   adrbiicour,a6        ;#####
             moveq.l   #0,d0
             move.w    22(a6),d0
             beq       rts
             lea.l     0(a6,d0.l),a0

;a0=adresse de la sequence

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loadsndseq2
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

loadsndseq2: 
             moveq.l   #1,d0                ;numero du son courant
             moveq.l   #6,d1                ;numero du bit courant
             move.w    #256-1-1,d7
lsloop0:     
             btst      d1,(a0)
             beq       ls00

             movea.l   adrbiicour,a6        ;#####

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #nosondebut,d0
             jsr       loadsnd
             movem.l   (sp)+,d0-d7/a0-a6

             cmpa.l    adrbiicour,a6        ;#####
             beq.s     ls00                 ;#####
             suba.l    adrbiicour,a6        ;#####
             suba.l    a6,a0                ;#####

ls00:        
             subq.w    #1,d1
             bge       ls10
             moveq.l   #7,d1
             addq.l    #1,a0
ls10:        
             addq.w    #1,d0
             dbra      d7,lsloop0

             rts       


;---------------------------------------------------------------
;
; loadsnd
;
; charge un fichier son
;
; entree:  d0 numero du fichier
;

loadsnd:     
             tst.w     sonon
             beq       rts
             cmpi.w    #nosondebut,d0
             beq       rts

             movem.l   d0-d7/a1-a6,-(sp)
             JSR_MEMFINDBLOC 
             movem.l   (sp)+,d0-d7/a1-a6
             bne       sndinmem

             .IF disquedur=0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loaddisk
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a1-a6,-(sp)
             JSR_MEMFINDBLOC 
             movem.l   (sp)+,d0-d7/a1-a6

             bclr      #3,memetatbloc+1(a0)

             movea.l   memadrbloc(a0),a0
             lea.l     table_sons,a6
             subi.w    #nosondebut,d0
             lsl.w     #2,d0
             move.l    a0,0(a6,d0.w)
             .ENDIF 

             .IF disquedur=1
             swap.w    d0
             clr.w     d0
             swap.w    d0

             move.w    d0,d7
             subi.w    #nosondebut,d0

             divu.w    #10,d0
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomsndno+2
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             addi.w    #"0",d0
             move.b    d0,nomsndno
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomsndno+1


             clr.w     -(sp)                ;fsfirst
             pea       nomsnd
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp
             tst.l     d0
             blt       rts

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       nomsnd               ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    d5,d0                ;taille
             addq.l    #1,d0
             andi.l    #$fffffffe,d0
             move.w    d7,d1
             jsr       memallocchip
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             lea.l     table_sons,a6
             subi.w    #nosondebut,d7
             lsl.w     #2,d7
             move.l    a0,0(a6,d7.w)

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             .ENDIF 

             rts       
sndinmem:    
             move.l    contvbl,memagebloc(a0)     ;on rafraichi l'age du bloc
             rts       

;---------------------------------------------------------------
;
; loadov
;
             .IF disquedur=1

loadov:      
             move.w    d0,d7

             subi.w    #4000,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0

             divu.w    #10,d0
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomprog2+2
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             addi.w    #"0",d0
             move.b    d0,nomprog2
             swap.w    d0
             addi.w    #"0",d0
             move.b    d0,nomprog2+1

             clr.w     -(sp)                ;fsfirst
             pea       nomprog
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       nomprog              ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    #300000,d0           ;taille fictive (il faudra gerer le segment BSS)
             move.w    d7,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0

             move.w    #64000/4-1,d0
             movea.l   a0,a6
dezs:        
;              clr.l    (a6)+
             dbra      d0,dezs
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0-a6,-(sp)

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       overrelog
             rts       
             .ENDIF 

             .IF disquedur=1
;---------------------------------------------------------------
;
; loadov2
;

loadov2:     
             clr.w     -(sp)                ;fsfirst
             pea       tubular
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       tubular              ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    #64000,d0            ;taille fictive (il faudra gerer le segment BSS)
             move.w    #4001,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0

             move.w    #64000/4-1,d0
             movea.l   a0,a6
dezs0:       
             clr.l     (a6)+
             dbra      d0,dezs0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0-a6,-(sp)

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       overrelog
             rts       
;---------------------------------------------------------------
;
; loadov3
;

loadov3:     
             clr.w     -(sp)                ;fsfirst
             pea       simu
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       simu                 ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    #350000,d0           ;taille fictive (il faudra gerer le segment BSS)
             move.w    #4003,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             move.l    a0,adrsimu

             movem.l   d0-d7/a0-a6,-(sp)

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       overrelog
             rts       

adrsimu:     .DC.l 0

;---------------------------------------------------------------
;
; loadov4
;

loadov4:     
             clr.w     -(sp)                ;fsfirst
             pea       via
             move.w    #$4e,-(sp)
             trap      #1
             addq.l    #8,sp

             move.w    #$2f,-(sp)           ;fgetdta
             trap      #1
             addq.l    #2,sp
             movea.l   d0,a0                ;a0 adresse dta

             move.l    26(a0),d5            ;taille

             clr.w     -(sp)                ;lecture seule
             pea       via                  ;adresse nom
             move.w    #$3d,-(sp)           ;open
             trap      #1
             addq.l    #8,sp
             move.w    d0,d6                ;identificateur fichier


             movem.l   d0-d7/a1-a6,-(sp)
             move.l    #200000,d0           ;taille fictive (il faudra gerer le segment BSS)
             move.w    #4004,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0) ;bloc verouille
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6


             movem.l   d0-d7/a0-a6,-(sp)

             move.l    a0,-(sp)             ;adr mem

             move.l    d5,-(sp)             ;taille
             move.w    d6,-(sp)             ;identificateur
             move.w    #$3f,-(sp)
             trap      #1                   ;fread
             adda.l    #12,sp

             move.w    d6,-(sp)
             move.w    #$3e,-(sp)
             trap      #1                   ;close
             addq.l    #4,sp
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       overrelog
             rts       
             .ENDIF 

;---------------------------------------------------------------
;
; chphy
;

chphy:       
             move.l    d0,sys00
             lsr.l     #8,d0
             movea.l   #$ff8201,a0
             .DC.l $01880000                ;movep.w  d0,0(a0)
             rts       


bombes2:     
             move.w    #$2700,sr
             move.w    #$700,$ff8240
             move.l    2(sp),d0             ;adresse ayant provoquee l'erreur
             move.l    10(sp),d1            ;adresse du prog (+2 a 10)
             move.w    tachecour,d2
             jsr       print
             JSR_ECRSWAP 

             bra       bombes
bombes3:     
             move.w    #$2700,sr
             move.w    #$0070,$ff8240
             move.l    2(sp),d0             ;adresse ayant provoquee l'erreur
             move.l    10(sp),d1            ;adresse du prog (+2 a 10)
             move.w    tachecour,d2
             jsr       print
             JSR_ECRSWAP 
             bra       bombes
bombes4:     
             move.w    #$2700,sr
             move.w    #$7,$ff8240
;              bra      bombes


bombes:      
             nop       
             .IF boot=0
qsd:         
             cmpi.b    #$39,$fffc02
             bne       qsd

             move.w    #$2300,sr
             jmp       fin
             .ENDIF 
             .IF boot=1
             bra       bombes
             .ENDIF 



;---------------------------------------------------------------
;
; initache
;
; initialisation des taches
;

initache:    
             clr.w     tachecour
             lea.l     ppile,a0
             move.l    #pilet0,(a0)+

             lea.l     pilet1,a1

             move.l    #newtache1,-(a1)     ;pc
             move.w    #$2300,-(a1)         ;sr
             lea.l     -60(a1),a1           ;emplacement pour 15 registres
             move.l    a1,(a0)+

             rts       


;---------------------------------------------------------------
;
; outdyno
;
; on quitte le dynorama
;

outdyno1:    
             jsr       multitacheoff
             jsr       stockoffset

             move.w    nocour,d0
             move.w    d0,exnocour
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,d0
             jsr       deverouille

             bsr       savescreen
             rts       


outdyno2:    
             lea.l     palette,a0
             jsr       degraoff
             rts       

savescreen:  


             move.l    #160*160,d0
             move.w    #6000,d1
             jsr       memallocfast
             bne       memerr0

             bset      #3,memetatbloc+1(a0)

             movea.l   memadrbloc(a0),a1
             movea.l   sys01,a0
             adda.w    #yorg*160,a0

             move.w    #160*160/4-1,d0
bod0:        
             move.l    (a0)+,(a1)+
             dbra      d0,bod0
             rts       
savescreen0: 
             bset      #3,memetatbloc+1(a0)
             rts       

restorescreen:         
             move.w    #6000,d0
             JSR_MEMFINDBLOC 
             beq       clearecran160
             movea.l   memadrbloc(a0),a0

             move.w    souri_11,d6
             jsr       hidemouse

             movea.l   sys00,a1
             movea.l   sys01,a2
             adda.w    #yorg*160,a1
             adda.w    #yorg*160,a2

             move.w    #160*160/4-1,d0
id0:         
             move.l    (a0)+,d7
             move.l    d7,(a1)+
             move.l    d7,(a2)+
             dbra      d0,id0

             move.w    d6,souri_11

             move.w    #6000,d0
             jmp       memmasterkill

restorescrlog:         
             move.w    #6000,d0
             JSR_MEMFINDBLOC 
             beq       clearecran160
             movea.l   memadrbloc(a0),a0
             movea.l   sys01,a2
             adda.w    #yorg*160,a2

             move.w    #160*160/4-1,d0
id0l:        
             move.l    (a0)+,d7
             move.l    d7,(a2)+
             dbra      d0,id0l
             rts       

;---------------------------------------------------------------
;
; intodyno
;

intodyno:    
             jsr       checksortieson

             clr.w     souri_11

             jsr       initecran

             lea.l     palette,a0
             jsr       degraon

             move.w    exnocour,newnocour
             bra       clic2

;---------------------------------------------------------------
;
; intodynos
;

intodynos:   
             jsr       checksortieson

             clr.w     souri_11

             jsr       initecran

             bsr       restorescreen

             lea.l     palette,a0
             jsr       degraon

             move.w    exnocour,newnocour
             bra       clic2


;---------------------------------------------------------------
;
; clic
;

clic:        
             jsr       stockoffset
             cmpi.w    #2,souri_5
             beq       clicdroit

             jsr       multitacheoff

             jsr       hidemouse

             movea.l   sys00,a0
             movea.l   sys01,a1
             move.w    #7999,d1
phylogloop:  
             move.l    (a0)+,(a1)+
             dbra      d1,phylogloop

             move.w    #-1,souri_11
             move.w    souri_6,d6           ;numero du bloc

             subq.w    #1,d6                ;-1 pour bloc interpelle

             beq       interpel
             blt       mainmenu

             movea.l   adrbiicour,a0
             moveq.l   #0,d0
             move.w    10(a0),d0
             adda.l    d0,a0                ;a0 pointe sur changement forme

             move.w    (a0),d7              ;nb de changement de formes

             cmp.w     d7,d6
             bgt       clicmarchand


             move.w    d6,d7
             subq.w    #1,d7
             mulu.w    #14,d7
             move.w    2+10(a0,d7.w),d0     ;direction
             move.w    2+12(a0,d7.w),d1     ;condition
             lsl.w     #2,d1
             lea.l     biicondition,a6
             movea.l   0(a6,d1.w),a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       (a6)
             movem.l   (sp)+,d0-d7/a0-a6
             bne       pointintero

             cmpi.w    #900,d0
             bge       specialbii

             movea.l   adrbiicour,a0
             moveq.l   #0,d0
             move.w    10(a0),d0
             adda.l    d0,a0                ;a0 pointe sur changement forme

             subq.w    #1,d6
             mulu.w    #14,d6
             move.w    2+10(a0,d6.w),d0
             move.w    d0,newnocour

;on quite l'image courante


clic2:       
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       reappro
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill        ;jsr      deverouille    ;on rend effacable l'ancien fichier

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    newnocour,nocour
             jsr       biitempoprog
             movem.l   (sp)+,d0-d7/a0-a6


             jsr       initson

             jsr       inipic
             jsr       inichf
             jsr       inibloc

             jsr       animinit

             clr.w     doaffperso
             move.w    nocour,d0
             lea.l     evi,a0
c000:        
             tst.w     (a0)
             blt       c001
             move.w    evilieusrc(a0),d1
             cmp.w     d0,d1
             bne       c002

             move.w    evilieudst(a0),d1    ;destination

             lea.l     dynooffset,a6
t1doxx:      
             cmp.w     (a6)+,d0
             beq.s     t1do1xx
             addq.l    #2,a6
             bra.s     t1doxx
t1do1xx:     
             moveq.l   #0,d0
             move.w    (a6),d0              ;offset
             addi.l    #dyno,d0             ;adresse
             movea.l   d0,a6

c004:        
             cmp.w     (a6),d1
             beq       c005
             addq.l    #4,a6
             bra       c004
c005:        
             move.w    2(a6),d0
             cmpi.w    #pasvisible,d0
             beq       c001
             move.w    d0,senspersocour
             jsr       compoperso2

             move.w    #-1,doaffperso
             bra       c001
c002:        
             lea.l     evisize(a0),a0
             bra       c000
c001:        

             jsr       runanimstat
             jsr       gestionperso
             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 

;a030:
             JSR_RELACHE 
             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             move.w    #-1,souri_11
             bra       newtache0loop

pointintero: 
             move.w    #sourispointi,souri_11
             move.w    #20,pausetache0
             JSR_RELACHE 
             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             bra       newtache0loop


clrbufperso: 
             lea.l     perso48a,a0
             lea.l     perso48b,a1

             moveq.l   #62-1,d7
bcp0x:       
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+

             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+
             clr.l     (a1)+

             dbra      d7,bcp0x
             rts       

;---------------------------------------------------------------
;
; initson
;

initson:     
             .IF son
             movem.l   d0-d7/a0-a6,-(sp)


             movea.l   adrbiicour,a6


             moveq.l   #0,d0
             move.w    20(a6),d0
             beq       passeq
             lea.l     0(a6,d0.l),a0

             lea.l     bufseq1,a6
             move.w    #320/4-1,d7
copyseq1:    
             move.l    (a0)+,(a6)+
             dbra      d7,copyseq1
             move.l    #bufseq1,ad_seq

             move.w    #1,novoie
             jsr       play_seq

             movea.l   adrbiicour,a6

             moveq.l   #0,d0
             move.w    22(a6),d0
             beq       passeq
             lea.l     0(a6,d0.l),a0

             lea.l     bufseq2,a6
             move.w    #320/4-1,d7
copyseq2:    
             move.l    (a0)+,(a6)+
             dbra      d7,copyseq2
             move.l    #bufseq2,ad_seq

             move.w    #2,novoie
             jsr       play_seq

             bra.s     seqok
passeq:      
             jsr       playsilence

seqok:       
             movem.l   (sp)+,d0-d7/a0-a6
             .ENDIF 




             .IF disquedur=0
             .IF son=1
             jsr       loadsndseq
             .ENDIF 
             .ENDIF 
             rts       

;---------------------------------------------------------------
;
; clicdroit
;

clicdroit:   
             jsr       multitacheoff
             jsr       fulldebloc
             move.w    #sourismenu,souri_11
clicdrtr:    
             JSR_RELACHE 
             jsr       waitclic
             cmpi.w    #2,souri_5
             beq       clicdend
             JSR_RELACHE 

             cmpi.w    #yorg,souri_8
             bgt       clicdend
             cmpi.w    #160,souri_7
             bgt       bobmain
             bra       fenetreevi


clicdend:    
             JSR_RELACHE 
             move.w    #-1,souri_11
             jsr       inibloc

             jsr       multitacheon
             bra       newtache0loop

;---------------------------------------------------------------
;
; specialgroupe
;

specialgroupe:         
;              move.w   evicour,d0
;             move.w   d0,d1
;            mulu.w   #evisize,d1
;           lea.l    evi,a0
;          adda.w   d1,a0
             lea.l     topogroupeadr,a1
             clr.l     (a1)+
             clr.l     (a1)+
             move.l    adrevicour,(a1)+     ;              move.l   a0,(a1)+
             clr.l     (a1)+
             clr.l     (a1)+

             lea.l     listegroupe,a0
spegrp0:     
             cmp.w     (a0)+,d0
             bne       spegrp0
             suba.l    #listegroupe+2,a0
             lea.l     topogroupe,a1
             move.w    a0,d0
             lsr.w     #1,d0
             clr.l     (a1)+
             move.w    d0,(a1)+
             clr.l     (a1)+
             bra       fenetreevi2


;---------------------------------------------------------------
;
; fenetreevi
;

fenetreevi:  
             moveq.l   #0,d0
             move.w    souri_7,d0
             subq.w    #5,d0
             blt       clicdrtr
             divu.w    #30,d0
             cmpi.w    #4,d0
             bgt       clicdrtr

             move.w    d0,d1
             add.w     d1,d1
             lea.l     listegroupe,a0
             tst.w     0(a0,d1.w)
             blt       fevis0

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             moveq.l   #84,d1               ;type videophone
             jsr       findobjtype
             movem.l   (sp)+,d0-d7/a0-a6
             bne       fevis0               ;le joueur n'a pas de videophone

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    0(a0,d1.w),d0        ;no d'evi
             addi.w    #3000,d0
             moveq.l   #84,d1               ;type videophone
             jsr       findobjtype
             movem.l   (sp)+,d0-d7/a0-a6
             bne       fevis0               ;l'evi n'a pas de videophone

             lea.l     2(a0,d1.w),a0

             mulu.w    #6,d0
             lea.l     missiongroupe,a1
             tst.w     0(a1,d0.w)
             bne       videogroupeauto      ;en mission...
fevis0:      
             lea.l     listegroupe,a0
             lea.l     topogroupeadr,a1
             lea.l     evi,a2
             moveq.l   #0,d6                ;nb evi presents
             moveq.l   #5-1,d7

             .REPT 5
             clr.l     (a1)+
             .ENDR 
             lea.l     -20(a1),a1

             move.w    #-1,-(sp)
             move.w    #0,-(sp)             ;offsets dans topogroupeadr
             move.w    #16,-(sp)
             move.w    #4,-(sp)
             move.w    #12,-(sp)
             move.w    #8,-(sp)

fevi:        
             move.w    (a0)+,d0
             blt       fevi0
             move.w    d7,d1
             neg.w     d1
             addq.w    #4,d1
             move.w    d1,d4
             mulu.w    #6,d1
             lea.l     missiongroupe,a3
             tst.w     0(a3,d1.w)
             bne       fevi0                ;en mission

             mulu.w    #evisize,d0
             lea.l     0(a2,d0.w),a3
             move.w    (sp)+,d5
             move.l    a3,0(a1,d5.w)
             lea.l     topogroupe,a3
             lsr.w     #1,d5
             move.w    d4,0(a3,d5.w)
             addq.w    #1,d6
fevi0:       
             dbra      d7,fevi

fevi1:       
             tst.w     (sp)+
             bge       fevi1

             tst.w     d6
             beq       clicdrtr             ;personne...


fenetreevi2: 

             move.w    #2,intertype

             move.l    contvbl,-(sp)
             move.w    #sourismenu,souri_11
             jsr       debloc
             move.w    #2,tetecour
             move.l    topogroupeadr+8,d0
             move.l    d0,adrevicour
             subi.l    #evi,d0
             divu.w    #evisize,d0
             move.w    d0,evicour
             move.w    #-1,marchandcour

             jsr       savescreen


             jsr       pasdejaparle

ip0g:        
             lea.l     evi,a0
             move.w    evicour,d0
             mulu.w    #evisize,d0
             adda.w    d0,a0

             move.l    a0,adrevicour

             jsr       majhumeur

             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             JSR_RELACHE 

             jsr       affinternom

             move.w    #128+16,menul
             move.w    #4*2+8*7,menuh
             move.w    #48+32,menux
             move.w    #118,menuy
             move.w    #7,menunbl
             clr.w     menuoffset

             lea.l     menutxlst,a0
             move.l    #grouptx0,(a0)+
             move.l    #grouptx1,(a0)+
             move.l    #grouptx2,(a0)+
             move.l    #grouptx3,(a0)+
             move.l    #grouptx4,(a0)+
             move.l    #grouptx5,(a0)+
             move.l    #grouptx6,(a0)+
             move.l    #-1,(a0)+

             bsr       traitemenu

             pea       ip0g

             move.w    menuval,d0
             beq       amitrouver
             cmpi.w    #1,d0
             beq       amiapprendre
             cmpi.w    #2,d0
             beq       amirdv
             cmpi.w    #3,d0
             beq       amidiscuter
             cmpi.w    #4,d0
             beq       amidonner
             cmpi.w    #5,d0
             beq       amiprendre
             cmpi.w    #6,d0
             beq       amichasser

             addq.l    #4,sp

             bsr       changetete
             beq       ip0g
fininterpelg:          
             bsr       relache
             jsr       restorescreen
             jsr       inibloc
             move.w    #-1,souri_11

             addq.l    #4,sp                ;ronan le 5/2/92              move.l   (sp)+,contvbl

             clr.l     adrevicour
             clr.w     flashcol0

             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             jmp       newtache0loop


;---------------------------------------------------------------
;
; amitrouver
;

amitrouver:  
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #15,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             jsr       affinternom


             jsr       makesujetobjet
             tst.w     d0
             beq       rts

             moveq.l   #7,d1
             jsr       mins
             move.w    d0,menunbl
             move.w    #118+7*4,menuy
             lsl.w     #2,d0
             sub.w     d0,menuy
             add.w     d0,d0
             addq.w    #8,d0
             move.w    d0,menuh
             move.w    #128+16,menul
             move.w    #48+32,menux

             clr.w     menuoffset

             JSR_RELACHE 
             bsr       traitemenu
             move.w    menuval,d0
             blt       rts

             lsl.w     #2,d0
             lea.l     menutxlst,a0
             move.l    0(a0,d0.w),d0        ;adresse du texte
             subi.l    #sujet0,d0
             lea.l     adrsujetliste,a0
amit0:       
             cmp.w     (a0)+,d0
             bne       amit0

             suba.l    #adrsujetliste+2,a0
             move.w    a0,d0
             lsr.w     #1,d0                ;numero de sujet
             lea.l     sujetobjetliste,a0
             lea.l     objettypeliste,a1
amit1:       
             cmp.w     (a0),d0
             beq       amit2
             addq.l    #2,a0
             addq.l    #2,a1
             bra       amit1
amit2:       
             move.w    (a1),d7              ;type d'objet
             move.w    tetecour,d0
             add.w     d0,d0
             lea.l     topogroupe,a0
             move.w    0(a0,d0.w),d0        ;offset
             mulu.w    #6,d0
             lea.l     missiongroupe,a0
             move.w    #1,0(a0,d0.w)        ;trouver objet
             move.w    d7,2(a0,d0.w)        ;type d'objet
             move.w    #4,4(a0,d0.w)        ;rejoindre

             move.w    evicour,d0
             mulu.w    #evisize,d0
             lea.l     evi,a0
             move.w    nocour,evilieudst(a0,d0.w)
             move.w    nocour,evilieusrc(a0,d0.w)

             rts       

;---------------------------------------------------------------
;
; amiapprendre
;

amiapprendre:          
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #16,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #128+16,menul
             move.w    #4*2+8*7,menuh
             move.w    #48+32,menux
             move.w    #118,menuy
             move.w    #7,menunbl
             clr.w     menuoffset

             jsr       makesujetmenu

             JSR_RELACHE 
             bsr       traitemenu
             move.w    menuval,d0
             blt       rts

             add.w     d0,d0
             lea.l     sujetliste,a0

             move.w    0(a0,d0.w),d7        ;numero de sujet

             move.w    tetecour,d0
             add.w     d0,d0
             lea.l     topogroupe,a0
             move.w    0(a0,d0.w),d0        ;offset
             mulu.w    #6,d0
             lea.l     missiongroupe,a0
             adda.w    d0,a0
             move.w    #2,(a0)              ;apprendre
             move.w    d7,2(a0)             ;numero de sujet
             move.w    #4,4(a0)             ;rejoindre

             move.w    evicour,d0
             mulu.w    #evisize,d0
             lea.l     evi,a0
             move.w    nocour,evilieudst(a0,d0.w)
             move.w    nocour,evilieusrc(a0,d0.w)
             rts       
;---------------------------------------------------------------
;
; amirdv
;

amirdv:      
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #17,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    tetecour,d0
             add.w     d0,d0
             lea.l     topogroupe,a0
             move.w    0(a0,d0.w),d0        ;offset
             mulu.w    #6,d0
             lea.l     missiongroupe,a0
             tst.w     0(a0,d0.w)           ;mission?
             bgt       amirdv1
             move.w    #919,d0
             jmp       dissujetsimple

amirdv1:     
             JSR__AFF 
             JSR_AFFINTERPEL 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_AFFINTERPEL 

             jsr       affinternom


             move.w    #128+16,menul
             move.w    #4*2+8*6,menuh
             move.w    #48+32,menux
             move.w    #118+7*4-6*4,menuy
             move.w    #6,menunbl
             clr.w     menuoffset

             lea.l     menutxlst,a0
             move.l    #rdvtx0,(a0)+
             move.l    #rdvtx1,(a0)+
             move.l    #rdvtx2,(a0)+
             move.l    #rdvtx3,(a0)+
             move.l    #rdvtx4,(a0)+
             move.l    #rdvtx5,(a0)+
             move.l    #-1,(a0)+

             JSR_RELACHE 
             bsr       traitemenu
             move.w    menuval,d7
             blt       rts

             move.w    tetecour,d0
             add.w     d0,d0
             lea.l     topogroupe,a0
             move.w    0(a0,d0.w),d0        ;offset
             mulu.w    #6,d0
             lea.l     missiongroupe,a0
             cmpi.w    #5,d7
             bne       amirdv0

             adda.w    d0,a0
             move.w    #-1,(a0)             ;stopper mission
             clr.w     2(a0)
             move.w    #4,4(a0)             ;rejoindre
             rts       

amirdv0:     
             move.w    d7,4(a0,d0.w)        ;lieu de rdv

             rts       
;---------------------------------------------------------------
;
; amidiscuter
;

amidiscuter: 
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #18,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             bsr       discuter
             rts       
;---------------------------------------------------------------
;
; amidonner
;

amidonner:   
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #19,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #4000,racineobj
             move.w    #3,inventtype
             jsr       inventairem
             move.w    #sourismenu,souri_11
             rts       
;---------------------------------------------------------------
;
; amiprendre
;

amiprendre:  
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #20,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    evicour,d0
             addi.w    #6000,d0             ;racine evi
             bsr       fairecorps
             move.w    #6,inventtype
             jsr       inventairem
             bsr       defairecorps
             move.w    #sourismenu,souri_11
             rts       

;---------------------------------------------------------------
;
; amichasser
;

amichasser:  
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #21,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    evicour,d0
             mulu.w    #evisize,d0
             lea.l     evi,a0
             adda.w    d0,a0
             move.b    evilove(a0),d7
             lsr.b     #1,d7
             move.b    d7,evilove(a0)

             move.w    nocour,evilieudst(a0)      ;on le place dans l'image courante

             lea.l     listegroupe,a0
             move.w    evicour,d0
             moveq.l   #5-1,d7
amicha0:     
             cmp.w     (a0)+,d0
             beq       amicha1
             dbra      d7,amicha0
             bra       noirjaune

amicha1:     
             move.w    #-1,-2(a0)


             addq.l    #4,sp
             bra       fininterpelg

;---------------------------------------------------------------
;
; playsilence
;

playsilence: 
             move.l    #seq_silence,ad_seq
             move.w    #1,novoie
             jsr       play_seqs
             move.w    #2,novoie
             jmp       play_seqs


;---------------------------------------------------------------
;
; deverouilleson
;

deverouilleson:        
             lea.l     memtable,a0
             move.w    #memnbblocmax-1,d7
ds0:         
             move.w    memtypebloc(a0),d0
             cmpi.w    #nosondebut,d0
             blt.s     ds1
             cmpi.w    #nosonfin,d0
             bgt.s     ds1
             bclr      #3,memetatbloc+1(a0)
ds1:         
             lea.l     16(a0),a0
             dbra      d7,ds0
             rts       

;---------------------------------------------------------------
;
; clicmarchand
;

clicmarchand:          
             move.w    #12345,negotype

             sub.w     d7,d6
             subq.w    #1,d6

             add.w     d6,d6
             lea.l     marchandlst,a0
             move.w    0(a0,d6.w),d0        ;numero du marchand
             subi.w    #1000,d0
             move.w    d0,marchandcour
             move.w    #-1,evicour

             move.l    codegenetique,-(sp)

             mulu.w    #marsize,d0
             lea.l     marchand,a0
             adda.w    d0,a0
             move.l    a0,adrevicour

             cmpi.b    #20,marlove(a0)
             bcs       marpascopain




             move.l    #mtx3,metier0+8      ;louer chambre

             movem.l   d0-d7/a0-a6,-(sp)    ;si partie 3
             moveq.l   #partie3,d0          ;mantoue= complet
             JSR_SCENATSTBIT 
             movem.l   (sp)+,d0-d7/a0-a6
             bne       lc000

             movea.l   maradrstock(a0),a1
             move.w    (a1),d0              ;numero de la cle
             blt       lc000                ;ce n'est pas un receptionniste

             move.w    marchandcour,d1
             addi.w    #965,d1              ;numero du pere de la cle

             lea.l     objstruc,a1
             lsl.w     #3,d0
             cmp.w     objpere(a1,d0.w),d1
             bne       lc0001               ;le marchand n'a pas la cle, il ne peut pas relouer

             move.l    contvbl,d7
             cmp.l     marvbl(a0),d7
             bgt       lc000
lc0001:      
             move.l    #mtx4,metier0+8      ;prendre/laisser cle
lc000:       

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       majhumeur
             movem.l   (sp)+,d0-d7/a0-a6

             move.l    marcodegen(a0),codegenetique
             moveq.l   #0,d0
             move.b    marmetier(a0),d0

             lea.l     metier,a6
             lsl.w     #2,d0
             movea.l   0(a6,d0.w),a6
             move.l    a6,adrmetier

             tst.l     (a6)                 ;cas particulier 0 ligne de menu
             bge       cm1x
             movea.l   4(a6),a6
             jmp       (a6)
cm1x:        
             lea.l     menutxlst,a0
             moveq.l   #-1,d0
cm1:         
             addq.w    #1,d0                ;nb lignes
             move.l    (a6),(a0)+
             blt       cm0
             addq.l    #8,a6
             bra       cm1
cm0:         
             move.w    #80+48,menul

             move.w    d0,menunbl
             addq.w    #1,d0
             lsl.w     #3,d0
             move.w    d0,menuh
             jsr       menucentre
             clr.w     menuoffset

             JSR_RELACHE 

             move.w    #sourismenu,souri_11
             jsr       traitemenu
             move.w    #-1,souri_11

             move.w    menuval,d0
             blt       finclicm
             lsl.w     #3,d0
             movea.l   adrmetier,a0
             movea.l   4(a0,d0.w),a0
             jmp       (a0)
finclicm:    
             JSR_RELACHE 
             move.l    (sp)+,codegenetique

             clr.l     adrevicour
             clr.w     flashcol0

             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             jmp       newtache0loop

marpascopain:          
             LEA_MENUTXLSTA1 
             move.l    #txboi24,(a1)+
             move.l    #txboi25,(a1)+
             move.l    #txboi26,(a1)+
             move.l    #txboi27,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm



metier:      .DC.l metier0,metier1,metier2,metier3,metier4,metier5,metier6
             .DC.l metier7,metier8,metier9,metier10

metier0:     .DC.l mtx0,interpelmar,mtx3,louerchambre,-1
metier1:     .DC.l mtx5,douanier,-1
metier2:     .DC.l mtx0,interpelmar,mtx1,marchandacheter,mtx2,marchandvoler,-1
metier3:     .DC.l mtx0,interpelmar,mtx1,marchandacheter,-1
metier4:     .DC.l mtx0,interpelmar,mtx1,marchandacheter,-1
metier5:     .DC.l mtx0,interpelmar,mtx7,ordredujour,-1
metier6:     .DC.l mtx0,interpelmar,mtx6,prendrerdv,-1
metier7:     .DC.l mtx0,interpelmar,mtx1,marchandacheter,-1
metier8:     .DC.l -1,regarderbogli
metier9:     .DC.l mtx0,interpelmar,mtx1,marchandacheter,mtx2,marchandvoler
             .DC.l mtx17,commanderverres,-1
metier10:    .DC.l mtx0,interpelmar,mtx18,marchandtroquer,-1


metiericone: .DC.w souriscredit,sourisinterpel,souriscredit
             .REPT 5
             .DC.w sourisinterpel
             .ENDR 
             .DC.w sourisregarder,souriscredit,sourisinterpel

;---------------------------------------------------------------
;
; douanier
;

douanier:    
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #24,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   animdebut,a0
             move.l    #animcodefin,4(a0)

             moveq.l   #douaniervu,d0
             JSR_SCENATSTBIT 
             bne       finclicm

             move.w    #sourissablier,souri_11


             move.w    #4000,d0
             move.w    #28,d1               ;carte sirius
             jsr       findobj
             bne       doua0
             move.w    #33,d0               ;vetement sirius
             move.w    #28,d1               ;type fausse carte
             jsr       findobjtype
             bne       douaprison
             bra       doua1
doua0:       
             move.w    #4000,d0
             move.w    #31,d1               ;carte cubitus
             jsr       findobj
             bne       douaprison
             move.w    #36,d0               ;vetement cubitus
             move.w    #28,d1               ;type fausse carte
             jsr       findobjtype
             bne       douaprison
doua1:       
             lea.l     objstruc,a0
             cmpi.w    #32,27*8(a0)
             bne       douaprison
             cmpi.w    #34,29*8(a0)
             bne       douaprison
             cmpi.w    #35,30*8(a0)
             bne       douaprison

;on teste si les vetements sont bien dans le sauna...

             cmpi.w    #2629,32*8(a0)
             bne       douaprison
             cmpi.w    #2629,33*8(a0)
             bne       douaprison
             cmpi.w    #2629,34*8(a0)
             bne       douaprison
             cmpi.w    #2629,35*8(a0)
             bne       douaprison
             cmpi.w    #2629,36*8(a0)
             bne       douaprison

;on teste si le joueur possede des vetements de preteur

             move.w    #4000,d0
             moveq.l   #0,d1
             jsr       findobjtype
             bne       douaprison

             moveq.l   #douaniervu,d0
             JSR_SCENASETBIT 

             move.w    #-1,souri_11
             bra       finclicm

douaprison:  
             LEA_MENUTXLSTA1 
             move.l    #txboi67,(a1)+
             move.l    #txboi68,(a1)+
             move.l    #txboi69,(a1)+
             move.l    #txboi70,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             clr.w     jehan+potvie

             move.w    #-1,souri_11
             bra       finclicm



;---------------------------------------------------------------
;
; regarderbogli
;

regarderbogli:         
             LEA_MENUTXLSTA1 
             move.l    #txboi34,(a1)+
             move.l    #txboi35,(a1)+
             move.l    #txboi36,(a1)+
             move.l    #txboi37,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       finclicm


;---------------------------------------------------------------
;
; prendrerdv
;

prendrerdv:  
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #28,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    marchandcour,d0
             mulu.w    #marsize,d0
             lea.l     marchand,a0
             adda.w    d0,a0
             move.l    marvbl(a0),d0

             move.l    contvbl,d7
             cmp.l     d0,d7
             blt       prdv1
             addi.l    #30*365,d0           ;+30 minutes
             cmp.l     d0,d7
             bgt       prdv0
;c'est l'heure du rdv
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi18,(a1)+
             move.l    #txboi19,(a1)+
             move.l    #txboi20,(a1)+

             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm

prdv1:                 ;vous avez deja un rdv
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi21,(a1)+
             move.l    #txboi22,(a1)+
             move.l    #txboi23,(a1)+

             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm

prdv0:                 ;prendre un rdv
             clr.l     marvbl(a0)
             move.w    marpatron(a0),d0
             mulu.w    #marsize,d0
             lea.l     marchand,a1
             cmpi.b    #50,marlove(a1,d0.w)
             bcs       plusrdv              ;le patron est en colere
             LEA_MENUTXLSTA1 
             move.l    #txboi12,(a1)+
             move.l    #txboi13,(a1)+
             move.l    #-1,(a1)+
             jsr       jhm
             move.w    d1,d7                ;heures
             move.w    d2,d6                ;minutes
             add.w     marchandcour,d0
             eori.w    #$1234,d0
             move.w    d0,d1
             lsr.w     #3,d1
             add.w     d1,d0
             andi.w    #3,d0
             addi.w    #15,d0
             cmp.w     d0,d7
             bge       plusrdv
             lea.l     txboi131,a0

             movem.w   d0/d6/d7,-(sp)
             jsr       bintoascii

             move.b    #" ",txboi131+2

             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             movem.w   (sp)+,d0/d6/d7
             bne       finclicm

             sub.w     d7,d0
             mulu.w    #21846,d0
             mulu.w    #365,d6
             move.l    contvbl,d7
             sub.l     d6,d7
             add.l     d0,d7                ;vbl rdv

             move.w    marchandcour,d0
             mulu.w    #marsize,d0
             lea.l     marchand,a0
             move.l    d7,marvbl(a0,d0.w)
             bra       finclicm

plusrdv:     
             LEA_MENUTXLSTA1 
             move.l    #txboi14,(a1)+
             move.l    #txboi15,(a1)+
             move.l    #txboi16,(a1)+
             move.l    #txboi17,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm

;---------------------------------------------------------------
;
; commanderverres
;

commanderverres:       
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #29,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     marchand,a0
             adda.w    #20*marsize,a0
             move.l    marvbl(a0),d0
             beq       cver0                ;jamais commande
             move.l    contvbl,d1
             cmp.l     d0,d1
             blt       cver1                ;pas encore prets
             clr.l     marvbl(a0)
             LEA_MENUTXLSTA1 
             move.l    #txboi50,(a1)+       ;prets
             move.l    #txboi51,(a1)+
             move.l    #txboi52,(a1)+
             move.l    #txboi53,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             lea.l     objstruc,a0
             adda.w    #0*8,a0
             move.w    #965+20,objpere(a0)

             bra       finclicm



cver0:       
             move.w    #4000,d0
             move.w    #856,d1
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             bne       cver00               ;pas la tablette

             move.l    contvbl,d0
             addi.l    #524000,d0
             move.l    d0,marvbl(a0)

             LEA_MENUTXLSTA1 
             move.l    #txboi38,(a1)+
             move.l    #txboi39,(a1)+
             move.l    #txboi40,(a1)+
             move.l    #txboi41,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             lea.l     objstruc,a0
             adda.w    #856*8,a0
             move.w    #9998,objpere(a0)

             bra       finclicm

cver1:       
             LEA_MENUTXLSTA1 
             move.l    #txboi46,(a1)+
             move.l    #txboi47,(a1)+
             move.l    #txboi48,(a1)+
             move.l    #txboi49,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm
cver00:      
             LEA_MENUTXLSTA1 
             move.l    #txboi42,(a1)+
             move.l    #txboi43,(a1)+
             move.l    #txboi44,(a1)+
             move.l    #txboi45,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             bra       finclicm

;---------------------------------------------------------------
;
; louerchambre
;

louerchambre:          
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #23,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6
             JSR_RELACHE 
             cmpi.w    #2,marchandcour
             beq       lccomplet
             tst.w     marchandcour
             bne       louerc0
             moveq.l   #partie3,d0
             JSR_SCENATSTBIT 
             bne       lccomplet

louerc0:     
             cmpi.l    #mtx4,metier0+8
             beq       lcplaisser

             move.w    souri_11,-(sp)
             move.w    #sourismenu,souri_11
             LEA_MENUTXLSTA1 
             move.l    #txboi4,(a1)+
             move.l    #txboi5,(a1)+
             move.l    #txboi6,(a1)+
             move.l    #txboi7,(a1)+
             move.l    #-1,(a1)+

             move.w    #8+8*4,menuh
             move.w    #128,menul
             move.w    #4,menunbl
             jsr       menucentre
             jsr       traitemenu
             move.w    (sp)+,souri_11

             move.w    menuval,d1
             blt       finclicm

             moveq.l   #1,d0
             lsl.w     d1,d0
             mulu.w    #100,d0
             move.l    d0,prix

             move.w    #4000,d0
             move.w    #922,d1
             jsr       findobj
             bne       lcpaspayer

             move.l    prix,d0
             lea.l     txboi81,a0
             jsr       bintoascii

             LEA_MENUTXLSTA1 
             move.l    #txboi8,(a1)+
             move.l    #txboi9,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       finclicm
             move.l    prix,d0
             cmp.l     argent,d0
             bgt       lcpaspayer
             sub.l     d0,argent

             move.w    marchandcour,d0
             addi.w    #965,d0
             lea.l     objstruc,a0
lc00:        
             move.w    objpere(a0),d7
             blt       pascleenstock        ;ne doit jamais se produire
             cmp.w     d0,d7
             beq.s     lc01
             addq.l    #8,a0
             bra.s     lc00
lc01:        
             move.w    #47,objpere(a0)
pascleenstock:         
             move.l    prix,d0
             mulu.w    #525,d0              ;524288 vbl=1 jour
             addi.l    #300000,d0           ;plus une demi journee
             add.l     contvbl,d0
             move.w    marchandcour,d7
             mulu.w    #marsize,d7
             lea.l     marchand,a0
             adda.w    d7,a0
             move.l    d0,marvbl(a0)

;vider les objets de la chambre


             move.w    marchambre(a0),d7
             addi.w    #2000,d7
             lea.l     objstruc,a0
lc001:       
             move.w    objpere(a0),d0
             blt       lc002
             cmp.w     d0,d7
             bne.s     lc003
             move.w    #9999,objpere(a0)
lc003:       
             addq.l    #8,a0
             bra.s     lc001
lc002:       

             bra       finclicm

lccomplet:   
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi0,(a1)+
             move.l    #txboi1,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       finclicm
lcpaspayer:  
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi10,(a1)+
             move.l    #txboi11,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       finclicm

lcplaisser:  
             move.w    marchandcour,d0
             mulu.w    #marsize,d0
             lea.l     marchand,a0
             adda.w    d0,a0
             movea.l   maradrstock(a0),a1
             move.w    (a1),d1              ;numero de la cle
             move.w    d1,d7
             lsl.w     #3,d7
             lea.l     objstruc,a0
             lea.l     objpere(a0,d7.w),a0
             move.w    #965,d7
             add.w     marchandcour,d7

             move.w    #4000,d0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             beq       lcclejoueur

             cmp.w     (a0),d7
             bne       finclicm             ;personne n'a la cle !?
             move.w    #47,(a0)

             bra       finclicm

lcclejoueur: 
             move.w    d7,(a0)
             bra       finclicm

;---------------------------------------------------------------
;
; initmenunbl
;

initmenunbl: 
             lea.l     menutxlst,a0
imbl0:       
             cmpi.l    #-1,(a0)+
             bne.s     imbl0
             suba.l    #menutxlst+4,a0
             move.w    a0,d0
             lsr.w     #2,d0
             move.w    d0,menunbl
             rts       

;---------------------------------------------------------------
;
; marchandtroquer
;

marchandtroquer:       
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #30,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             lea.l     objstruc,a0
             cmpi.w    #5033,42*8(a0)
             bne       finclicm

             move.w    #4000,d0
             move.w    #75,d1
             jsr       findobjtype
             bne       finclicm
             move.w    #9999,objpere(a6)
             move.w    #42,objget           ;sonde de douleur
             jsr       inventairev
             bra       finclicm


;---------------------------------------------------------------
;
; marchandacheter
;

marchandacheter:       
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #25,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #1,inventtype        ;marchan

             move.w    #-1,negoprec
             move.w    #-1,negotype

             move.w    marchandcour,d0
             addi.w    #5000,d0
             move.w    d0,racineobj

             jsr       savescreen
             jsr       inventairem2
             jsr       restorescreen
             bra       finclicm

marchandvoler:         
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #26,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #2,inventtype        ;marchan

             move.w    marchandcour,d0
             addi.w    #5000,d0
             move.w    d0,racineobj

             jsr       savescreen
             jsr       inventairem2
             jsr       restorescreen

             bra       finclicm


;---------------------------------------------------------------
;
; hidemouse
;

hidemouse::  
             clr.w     souri_11
pasencorecachee:       
             tst.w     souri_9
             bne.s     pasencorecachee
             rts       

;---------------------------------------------------------------
;
; stockoffset
;

stockoffset: 
             move.w    nocour,d7

             moveq.l   #3,d0                ;on stocke
             lea.l     quart1no,a0          ;l'offset
b999:        
             cmp.w     (a0),d7              ;de l'image
             bne       b998                 ;que l'on
             move.w    offsetx,4(a0)        ;quitte
             move.w    offsety,6(a0)
b998:        
             addq.l    #8,a0
             dbra      d0,b999
             rts       


;---------------------------------------------------------------
;
; specialbii
;
; traitement d'un lieu special
;
; entree:     d0 numero du lieu
;

specialbii:  
             jsr       multitacheon
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       playsilence
             jsr       deverouilleson
             movem.l   (sp)+,d0-d7/a0-a6

             cmpi.w    #901,d0
             beq       chidammain
             cmpi.w    #903,d0
             beq       quattromain
             cmpi.w    #904,d0
             beq       tubularmain
             cmpi.w    #905,d0
             beq       simutaxi
             cmpi.w    #906,d0
             beq       viamain
             cmpi.w    #907,d0
             beq       gladmain
             cmpi.w    #917,d0
             beq       simuentretient
             cmpi.w    #918,d0
             beq       simuespace
             cmpi.w    #919,d0
             beq       simuforeuse

             cmpi.w    #920,d0
             beq       cai
             cmpi.w    #921,d0
             beq       tableaupreteurs

             cmpi.w    #930,d0
             beq       mangerenprison
             cmpi.w    #932,d0
             beq       boireenprison

;             9999= sortie

             jsr       multitacheoff
specialbiifin:         
             jsr       multitacheon

             jmp       newtache0loop

;---------------------------------------------------------------
;
; mangerenprison
;

mangerenprison:        
             jsr       multitacheoff
             moveq.l   #rationprison,d0
             JSR_SCENASETBIT 
             bne       specialbiifin        ;une seule ration par repas

             lea.l     objstruc,a0
mep0:        
             move.w    objpere(a0),d0
             blt       specialbiifin
             cmpi.w    #9997,d0
             bne       mep3
             cmpi.w    #75,objtype(a0)
             bne       mep3
             suba.l    #objstruc,a0
             move.l    a0,d0
             lsr.w     #3,d0
             move.w    d0,objget

             jsr       savescreen

             jsr       inventairev

             jsr       restorescreen
             jsr       inibloc

             bra       specialbiifin

mep3:        
             addq.l    #8,a0
             bra       mep0
mep2:        

             bra       specialbiifin

;---------------------------------------------------------------
;
; boireenprison
;

boireenprison:         
             jsr       multitacheoff
             lea.l     objstruc,a0
bmep0:       
             move.w    objpere(a0),d0
             blt       specialbiifin
             cmpi.w    #9997,d0
             bne       bmep3
             cmpi.w    #4,objtype(a0)       ;eau
             bne       bmep3
             suba.l    #objstruc,a0
             move.l    a0,d0
             lsr.w     #3,d0
             move.w    d0,objget

             jsr       savescreen

             jsr       inventairev

             jsr       restorescreen
             jsr       inibloc

             bra       specialbiifin

bmep3:       
             addq.l    #8,a0
             bra       bmep0

;---------------------------------------------------------------
;
; tableaupreteurs
;

tableaupreteurs:       
             jsr       multitacheoff
             move.w    #sourisregarder,souri_11

             lea.l     txpretd,a0
             lea.l     txpretf,a6
             bsr       decot1

             move.w    #-1,souri_11


             JSR__AFF 
             JSR_ECRSWAP 
             JSR__AFF 
             JSR_RELACHE 
             bra       specialbiifin

;---------------------------------------------------------------
;
; cai
;

cai:         
             jsr       multitacheoff
             move.l    sys01,-(sp)
             move.l    adrdicour,sys01

             moveq.l   #34-4,d0
             moveq.l   #27-10,d1
             move.w    #280+6+4,d2
             move.w    #130,d3
             moveq.l   #vertfonce,d4
             JSR_PBOX 
             move.w    #34+20-6,d0
             move.w    #130,d1
             move.w    #280+6-20+4,d2
             move.w    #150-5,d3
             moveq.l   #vertfonce,d4
             JSR_PBOX 

             lea.l     txcaid1,a0
             lea.l     txcaif1,a6
             tst.w     pagecai
             beq       cai1
             lea.l     txcaid2,a0
             lea.l     txcaif2,a6

cai1:        
             not.w     pagecai
             movea.l   adrdicour,a1
             moveq.l   #34,d1
             moveq.l   #27,d2
             moveq.l   #rouge,d3
             move.w    #160,d4

cai0:        
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             lea.l     1(a0,d0.w),a0

             addq.w    #7,d2

             cmpa.l    a6,a0
             blt       cai0


             JSR_RELACHE 
             move.l    (sp)+,sys01

             moveq.l   #messagesylvia1,d0
             JSR_SCENASETBIT 

             jsr       multitacheon
             moveq.l   #1,d0
             jsr       allertache
             jmp       newtache0loop

;---------------------------------------------------------------
;
; decotablette
;

decotablette:          
             move.w    #sourisregarder,souri_11

             lea.l     txbobd1,a0
             lea.l     txbobf1,a6
             bsr       decot1

             lea.l     txbobd2,a0
             lea.l     txbobf2,a6
             bsr       decot1
             move.w    #-1,souri_11
             bra       invrts

decot1:      
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #5-1,d0
             move.w    #yorg-1,d1
             move.w    #319-5+1,d2
             move.w    #yorg+160,d3
             moveq.l   #noir,d4
             JSR_PBOX 

             moveq.l   #5+1-1,d0
             move.w    #yorg-1+1,d1
             move.w    #319-5-1+1,d2
             move.w    #yorg+160-1,d3
             moveq.l   #marron,d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   sys01,a1
             moveq.l   #9,d1
             moveq.l   #yorg+2,d2
             moveq.l   #marronfonce,d3
             move.w    #160,d4

decot0:      
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d1-d7/a0-a6

             lea.l     1(a0,d0.w),a0

             addq.w    #7,d2

             cmpa.l    a6,a0
             blt       decot0
             JSR_ECRSWAP 
             JSR_RELACHE 

decot2:      
             tst.w     souri_5
             beq       decot2
             rts       

;---------------------------------------------------------------
;
; lirejournal
;

lirejournal: 
             move.w    #sourisregarder,souri_11

             lea.l     txjourd,a0
             lea.l     txjourf,a6
             bsr       decot1

             moveq.l   #journallu,d0
             JSR_SCENASETBIT 


             move.w    #-1,souri_11
             bra       invrts

;---------------------------------------------------------------
;
; lirelivre
;

lirelivre:   
             move.w    #sourisregarder,souri_11

             lea.l     txbookd1,a0
             lea.l     txbookf1,a6
             bsr       decot1
             lea.l     txbookd2,a0
             lea.l     txbookf2,a6
             bsr       decot1

             moveq.l   #livrelu,d0
             JSR_SCENASETBIT 


             move.w    #-1,souri_11
             bra       invrts



;---------------------------------------------------------------
;
; chidammain
;

chidammain:  
             jsr       outdyno1

             clr.w     souri_11
             move.w    #901,nocour
             jsr       biitempoprog

             lea.l     souri_13,a0
             move.w    #0,(a0)+
             move.w    #0,(a0)+
             move.w    #319-16,(a0)+
             move.w    #199-16,(a0)+

             move.w    #-1,souri_14

             move.w    #-1,souri_11

             JSR_RELACHE 



             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4000,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6



             move.w    gainchidam,d0
             jsr       (a0)
             move.w    d0,gainchidam

             clr.w     souri_10

             lea.l     palettechidam,a0
             jsr       degraoff

             move.w    #901,d0
             jsr       deverouille
             move.w    #1901,d0
             jsr       memmasterkill
             jmp       intodynos

;---------------------------------------------------------------
;
; findloadprg
;
; entree: d0 numero du fichier
;
; retour: a0 pointe sur la structure
;

findloadprg: 
             movem.l   d0-d7/a1-a6,-(sp)
             JSR_MEMFINDBLOC 
             movem.l   (sp)+,d0-d7/a1-a6
             bne       rts

             .IF disquedur=0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loaddisk
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a1-a6,-(sp)
             JSR_MEMFINDBLOC 
             movem.l   (sp)+,d0-d7/a1-a6


             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   memadrbloc(a0),a0
             jsr       overrelog
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

             .ENDIF 



;---------------------------------------------------------------
;
; findloaddata
;
; entree: d0 numero du fichier
;
; retour: a0 pointe sur la structure
;

findloaddata:          
             movem.l   d0-d7/a1-a6,-(sp)
             JSR_MEMFINDBLOC 
             movem.l   (sp)+,d0-d7/a1-a6
             bne       verouille

             .IF disquedur=0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       loaddisk
             movem.l   (sp)+,d0-d7/a0-a6

             JSR_MEMFINDBLOC 
             .ENDIF 
             rts       


simupalette: .DC.w $0000,$777,$0000,$344,$233,$221,$110,$566
             .DC.w $765,$543,$321,$210,$420,$531,$400,$332


;---------------------------------------------------------------
;
; clearecran
;

clearecran:  
             move.w    souri_11,d6
             jsr       hidemouse

             movea.l   sys00,a0
             movea.l   sys01,a1
             move.w    #8000-1,d0
bclearecran: 
             clr.l     (a0)+
             clr.l     (a1)+
             dbra      d0,bclearecran

             move.w    d6,souri_11
             rts       

;---------------------------------------------------------------
;
; clearecran160
;

clearecran160:         
             move.w    souri_11,d6
             jsr       hidemouse

             movea.l   sys00,a0
             movea.l   sys01,a1
             lea.l     yorg*160(a0),a0
             lea.l     yorg*160(a1),a1

             move.w    #320*160/2/4-1,d0
bclearecran160:        
             clr.l     (a0)+
             clr.l     (a1)+
             dbra      d0,bclearecran160

             move.w    d6,souri_11

             lea.l     quart1no,a0
             moveq.l   #4-1,d0
             move.w    nocour,d7
bcq:         
             cmp.w     (a0),d7
             beq       bcq0
             clr.w     (a0)
bcq0:        
             addq.l    #8,a0
             dbra      d0,bcq
             rts       

;---------------------------------------------------------------
;
; simutaxi
;

simutaxi:    
             jsr       multitacheoff

             LEA_MENUTXLSTA1 
             move.l    #txboi30,(a1)+
             move.l    #txboi32,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       taximanuel
             LEA_MENUTXLSTA1 
             move.l    #txboi30,(a1)+
             move.l    #txboi33,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       specialbiifin
             move.l    #950,d0

             jsr       assezargent
             beq       taxia0

taxi00:      
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi10,(a1)+
             move.l    #txboi11,(a1)+
             move.l    #txboi3,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       specialbiifin
taxia0:      
             move.w    #sourismenu,souri_11
             lea.l     menutxlst,a0
             move.l    #mtx8,(a0)+
             move.l    #mtx9,(a0)+
             move.l    #mtx10,(a0)+
             move.l    #mtx11,(a0)+
             move.l    #mtx12,(a0)+
             move.l    #mtx13,(a0)+
             move.l    #mtx14,(a0)+
             move.l    #mtx15,(a0)+
             move.l    #mtx16,(a0)+
             move.l    #-1,(a0)+
             move.w    #9,menunbl
             move.w    #8*9+8,menuh
             clr.w     menuoffset
             move.w    #128,menul
             jsr       menucentre
             jsr       traitemenu
             move.w    #sourissablier,souri_11

             move.w    menuval,d0
             blt       specialbiifin
             addq.w    #1,d0
             add.w     d0,d0
             lea.l     simutable,a0
             move.w    0(a0,d0.w),newnocour

             subi.l    #950,argent
             bra       clic2

taximanuel:  
             LEA_MENUTXLSTA1 
             move.l    #txboi30,(a1)+
             move.l    #txboi31,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       specialbiifin
             move.l    #400,d0

             jsr       assezargent
             bne       taxi00

             jsr       hidemouse

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill
             move.w    nocour,d0
             jsr       deverouille

             move.w    #6020,d0
             jsr       deverouille
             move.w    #1911,d0
             jsr       deverouille

             move.w    nocour,d1
             lea.l     simutable,a6
sm0:         
             cmp.w     (a6)+,d1
             bne.s     sm0

             suba.l    #simutable+2,a6
             move.w    a6,d1
             lsr.w     #1,d1

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6001,d0
             jsr       findloaddata
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4003,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6001,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6




             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             lea.l     simupalette,a0
             jsr       degraon
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0/d1/d3-d7/a0-a6,-(sp)
             jsr       jhm
             lea.l     heureremap,a0
             moveq.l   #0,d2
             move.b    0(a0,d1.w),d2        ;0=jour 1=soir 2=nuit
             movem.l   (sp)+,d0/d1/d3-d7/a0-a6




             move.l    sys01,-(sp)
             moveq.l   #1,d0
             moveq.l   #-1,d3
             jsr       (a0)
             move.l    (sp)+,sys01


             add.w     d3,d3
             lea.l     simutable,a0
             move.w    0(a0,d3.w),exnocour

             move.w    #4003,d0
             jsr       memmasterkill        ;on detruit le prog apres utilisation
             move.w    #6001,d0
             jsr       memmasterkill

             move.w    nocour,-(sp)
             move.w    #911,nocour
             jsr       biitempoprog
             move.w    #6020,d0
             jsr       findloaddata
             move.w    (sp)+,nocour


             clr.w     souri_10
             clr.w     souri_5
             jsr       clearecran

             jmp       intodyno

;---------------------------------------------------------------
;
; simuentretient
;

simuentretient:        
             cmpi.w    #619,nocour
             beq       setm4
             cmpi.w    #631,nocour
             bne       simutaxi
setm4:       
             jsr       multitacheoff

             jsr       hidemouse

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,d0
             jsr       deverouille

             move.w    #6020,d0
             jsr       deverouille
             move.w    #1911,d0
             jsr       deverouille


             move.w    nocour,d1
             cmpi.w    #619,d1
             beq       setm2
             lea.l     simutable,a6
sm0x:        
             cmp.w     (a6)+,d1
             bne.s     sm0x

             suba.l    #simutable+2,a6
             move.w    a6,d1
             lsr.w     #1,d1

             bra.s     setm3
setm2:       
             moveq.l   #5,d1
             moveq.l   #-1,d4
setm3:       
             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6002,d0
             jsr       findloaddata
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4003,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6002,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             lea.l     simupalette,a0
             jsr       degraon
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0/d1/d3-d7/a0-a6,-(sp)
             jsr       jhm
             lea.l     heureremap,a0
             moveq.l   #0,d2
             move.b    0(a0,d1.w),d2        ;0=jour 1=soir 2=nuit
             movem.l   (sp)+,d0/d1/d3-d7/a0-a6

             move.l    sys01,-(sp)
             moveq.l   #2,d0
             moveq.l   #-1,d3
             jsr       (a0)
             move.l    (sp)+,sys01

             cmpi.w    #-1,d4
             beq       setm0

             add.w     d3,d3
             lea.l     simutable,a0
             move.w    0(a0,d3.w),exnocour
             bra.s     setm1
setm0:       
             move.w    #619,exnocour
setm1:       
             jsr       clearecran

             move.w    #4003,d0
             jsr       memmasterkill        ;on detruit le prog apres utilisation
             move.w    #6002,d0
             jsr       memmasterkill

             move.w    nocour,-(sp)
             move.w    #911,nocour
             jsr       biitempoprog
             move.w    #6020,d0
             jsr       findloaddata
             move.w    (sp)+,nocour

             clr.w     souri_10
             clr.w     souri_5

             jmp       intodyno

;---------------------------------------------------------------
;
; simuespace
;

simuespace:  
             jsr       multitacheoff
             cmpi.w    #100,nocour
             bne       espace00

             LEA_MENUTXLSTA1 
             move.l    #txboi65,(a1)+
             move.l    #txboi66,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       specialbiifin
             move.l    #5000,d0

             jsr       assezargent
             beq       espace0

             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi10,(a1)+
             move.l    #txboi11,(a1)+
             move.l    #txboi3,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       specialbiifin
espace0:     
             subi.l    #5000,argent

espace00:    
             jsr       hidemouse

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,d0
             jsr       deverouille

             move.w    #6020,d0
             jsr       deverouille
             move.w    #1911,d0
             jsr       deverouille



             move.w    nocour,d1
             lea.l     simutable,a6
sm0xx:       
             cmp.w     (a6)+,d1
             bne.s     sm0xx

             suba.l    #simutable+2,a6
             move.w    a6,d1
             lsr.w     #1,d1

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6003,d0
             jsr       findloaddata
;REORG MEM;              movea.l  memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4003,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             lea.l     simupalette,a0
             jsr       degraon
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0/d1/d3-d7/a0-a6,-(sp)
             jsr       jhm
             lea.l     heureremap,a0
             moveq.l   #0,d2
             move.b    0(a0,d1.w),d2        ;0=jour 1=soir 2=nuit
             movem.l   (sp)+,d0/d1/d3-d7/a0-a6

             moveq.l   #0,d3

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             move.w    #861,d1
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             bne       simue2
             moveq.l   #-1,d3
simue2:      

             movem.l   d0-d7/a0/a2-a6,-(sp) ;REORG MEM
             move.w    #6003,d0             ;REORG MEM
             JSR_MEMFINDBLOC                ;REORG MEM
             movea.l   memadrbloc(a0),a1    ;REORG MEM
             movem.l   (sp)+,d0-d7/a0/a2-a6 ;REORG MEM




             move.l    sys01,-(sp)
             moveq.l   #3,d0
             jsr       (a0)
             move.l    (sp)+,sys01

             cmpi.w    #-1,d4
             bne       simue0
             clr.w     jehan+potvie         ;on est mort dans l'espace
             bra       simue1
simue0:      
             add.w     d3,d3
             lea.l     simutable,a0
             move.w    0(a0,d3.w),exnocour
simue1:      
             jsr       clearecran

             move.w    #4003,d0
             jsr       memmasterkill        ;on detruit le prog apres utilisation
             move.w    #6003,d0
             jsr       memmasterkill

             move.w    nocour,-(sp)
             move.w    #911,nocour
             jsr       biitempoprog
             move.w    #6020,d0
             jsr       findloaddata
             move.w    (sp)+,nocour

             clr.w     souri_10
             clr.w     souri_5

             jmp       intodyno

;---------------------------------------------------------------
;
; simuforeuse
;

simuforeuse: 
             jsr       multitacheoff

             jsr       hidemouse

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill
             move.w    nocour,d0
             JSR_MEMFINDBLOC 
             bclr      #3,memetatbloc+1(a0)

             move.w    #6020,d0
             jsr       deverouille
             move.w    #1911,d0
             jsr       deverouille

             move.w    nocour,d1
             lea.l     simutable,a6
sm0xxx:      
             cmp.w     (a6)+,d1
             bne.s     sm0xxx

             suba.l    #simutable+2,a6
             move.w    a6,d1
             lsr.w     #1,d1

foreusepuit: 


             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6004,d0
             jsr       findloaddata
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4003,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0/a2-a6,-(sp)
             move.w    #6004,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a1
             movem.l   (sp)+,d0-d7/a0/a2-a6


             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     palette,a0
             jsr       degraoff

             jsr       clearecran

             lea.l     simupalette,a0
             jsr       degraon
             movem.l   (sp)+,d0-d7/a0-a6

             move.l    sys01,-(sp)
             moveq.l   #4,d0
             moveq.l   #0,d2
             moveq.l   #-1,d3
             jsr       (a0)
             move.l    (sp)+,sys01

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4003,d0
             jsr       memmasterkill        ;on detruit le prog apres utilisation
             movem.l   (sp)+,d0-d7/a0-a6

             cmpi.w    #13,d3
             beq       puitbanafoosh

             add.w     d3,d3
             lea.l     simutable,a0
             move.w    0(a0,d3.w),exnocour

             move.w    nocour,-(sp)
             move.w    #911,nocour
             jsr       biitempoprog
             move.w    #6020,d0
             jsr       findloaddata
             move.w    (sp)+,nocour


             clr.w     souri_10
             clr.w     souri_5
             jsr       clearecran

             jmp       intodyno

puitbanafoosh:         
             move.w    #952,nocour
             jsr       biitempoprog
             lea.l     palette,a0
             jsr       degraoff
             jsr       hidemouse

             jsr       transimginter


             lea.l     palette952,a0
             jsr       degraon
             jsr       waitclic
             lea.l     palette952,a0
             jsr       degraoff
             move.w    #952,d0
             jsr       memmasterkill
             move.w    #1952,d0
             jsr       memmasterkill

             moveq.l   #puittrouve,d0
             JSR_SCENASETBIT 
             bne       puit0

;on place les titres dans l'inventaire du joueur
             lea.l     objstruc,a0
             move.w    #47,861*8(a0)


             lea.l     banafoosh,a0
             moveq.l   #7,d0
             jsr       afftx88
puit0:       
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     palette,a0
             jsr       degraoff
             jsr       clearecran
             lea.l     simupalette,a0
             jsr       degraon
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #13,d1
             bra       foreusepuit

transimginter:         
             movea.l   adrdicour,a0
             movea.l   sys00,a1
             movea.l   sys01,a2
             move.w    #32000/4-1,d0
jmort0x:     
             move.l    (a0),(a1)+
             move.l    (a0)+,(a2)+
             dbra      d0,jmort0x
             rts       

;---------------------------------------------------------------
;
; combatmain
;

combatmain:  
             move.w    nocour,-(sp)


             cmpi.l    #512000,memlongchip
             bgt.s     combat1040

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #1911,d0
             jsr       deverouille
             move.w    #6000,d0
             jsr       deverouille
             movem.l   (sp)+,d0-d7/a0-a6
combat1040:  




             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #0,d0
             move.w    nocour,d0
             divu.w    #100,d0
             movea.l   adrbiicour,a0
             move.w    2(a0),d1             ;int/ext
             lsl.w     #8,d1
             move.b    d0,d1
             move.w    d1,combat_a0
             movem.l   (sp)+,d0-d7/a0-a6



             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #900,nocour
             jsr       biitempoprog
             move.w    #909,nocour
             jsr       biitempoprog
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #6005,d0
             jsr       findloaddata
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6


             movea.w   combat_a0,a0

             movea.w   #1,a4                ;(0=mode 1040, a5 pointe sur un buffer de 15000 octets) 1=mode 520
             cmpi.l    #512000,memlongchip
             blt.s     combat520
             clr.w     a4

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    #15000,d0
             move.w    #7000,d1
             jsr       memallocchip
             movem.l   (sp)+,d0-d7/a0-a6

combat520:   

             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #4007,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a6
             movem.l   (sp)+,d0-d7/a0-a5

             movem.l   d0-d7/a0/a1/a3-a6,-(sp)
             move.w    #6005,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a2
             movem.l   (sp)+,d0-d7/a0/a1/a3-a6

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #1900,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d7
             move.w    8(a0),d7
             lea.l     0(a0,d7.l),a1        ;adresse donnees graphiques
             move.w    14(a0),d7            ;offset sur anim stat
             lea.l     2(a0,d7.l),a0
             lea.l     16*8(a0),a0          ;on passe 8 anim
             move.w    8(a0),d7             ;offset sur donnees graphique
             adda.l    d7,a1
             move.l    a1,adrobj
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a4/a6,-(sp)
             move.w    #7000,d0
             JSR_MEMFINDBLOC 
             beq       combat520_1
             movea.l   memadrbloc(a0),a5
combat520_1: 
             movem.l   (sp)+,d0-d7/a0-a4/a6



             jsr       (a6)

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             movem.l   (sp)+,d0-d7/a0-a6

;retour: d0=0 le joueur n'a pas fuit d0=1 le joueur a fuit

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #7000,d0
             jsr       memmasterkill
             move.w    #1900,d0
             jsr       memmasterkill
             move.w    #1909,d0
             jsr       memmasterkill
             move.w    #900,d0
             jsr       deverouille
             move.w    #909,d0
             jsr       deverouille
             move.w    #4007,d0
             jsr       memmasterkill
             move.w    #6005,d0
             jsr       memmasterkill

             clr.w     souri_10
             clr.w     souri_5
             movem.l   (sp)+,d0-d7/a0-a6


; gestion des personnages morts, devenus ennemis etc...

             subq.w    #1,d0
             subq.w    #1,d1
             subq.w    #1,d2
             subq.w    #1,d3
             subq.w    #1,d4
             subq.w    #1,d5
             subq.w    #1,d6
             subq.w    #1,d7

             jsr       checkevicombat
             move.w    d1,d0
             jsr       checkevicombat
             move.w    d2,d0
             jsr       checkevicombat
             move.w    d3,d0
             jsr       checkevicombat
             move.w    d4,d0
             jsr       checkevicombat
             move.w    d5,d0
             jsr       checkevicombat
             move.w    d6,d0
             jsr       checkevicombat
             move.w    d7,d0
             jsr       checkevicombat

             clr.w     doaffperso           ;#####

             jsr       debloc

             lea.l     palette,a0
             jsr       degraon

             move.w    #911,nocour
             jsr       biitempoprog
             move.w    (sp)+,nocour


             move.w    #6000,d0
             jsr       verouille

             rts       

;---------------------------------------------------------------
;
; checkevicombat
;
; entree:     d0 numero de l'evi qui sort d'un combat
;

checkevicombat:        
             tst.w     d0
             blt       rts

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     evi,a0
             move.w    d0,d7
             mulu.w    #evisize,d0
             adda.w    d0,a0

             tst.b     evipotvie(a0)
             beq       cec4
             cmpi.b    #20,evilove(a0)
             bhi       cec3
cec4:        
             lea.l     listegroupe,a1
             moveq.l   #5-1,d1
cec1:        
             cmp.w     (a1)+,d7
             beq       cec2

             dbra      d1,cec1
             bra       cec3
cec2:        
             move.w    #-1,-2(a1)           ;ne fait plus partie du groupe
             move.w    nocour,evilieusrc(a0)
             move.w    nocour,evilieudst(a0)
             move.b    #-1,evileader(a0)
cec3:        
             tst.b     evipotvie(a0)
             bne       cec0
             move.w    #9999,evilieusrc(a0)
             move.w    #9999,evilieudst(a0)


             move.w    d7,d0                ;ancien pere
             addi.w    #3000,d0
             move.w    nocour,d1
             addi.w    #2000,d1             ;nouveau pere=lieu courant
             jsr       changepereobj

cec0:                  ; evi pas mort

             movem.l   (sp)+,d0-d7/a0-a6
             rts       

;---------------------------------------------------------------
;
; changepereobj
;
; entree:     d0 numero de l'ancien pere
;             d1 numero du nouveau pere
;

changepereobj:         
             lea.l     objstruc,a0
cpo0:        
             cmpi.w    #-1,(a0)
             beq       rts
             cmp.w     objpere(a0),d0
             bne.s     cpo2
             move.w    d1,objpere(a0)
cpo2:        
             addq.l    #8,a0
             bra.s     cpo0

;---------------------------------------------------------------
;
; gladmain
;

gladmain:    
             jsr       outdyno1

             cmpi.l    #512000,memlongchip
             bgt       glad1040
             move.w    #1911,d0
             jsr       deverouille
             move.w    #6020,d0
             jsr       deverouille
             move.w    #6000,d0
             jsr       deverouille
glad1040:    

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    #932,nocour
             jsr       biitempoprog

             move.w    #933,nocour
             tst.w     tarene
             bne.s     gladmain0
             addq.w    #1,nocour
gladmain0:   
             jsr       biitempoprog

             move.w    #907,nocour
             jsr       biitempoprog

             moveq.l   #0,d0                ;0=520 (1=1040 ,a4 pointe sur un buffer de 22960 octets)
             cmpi.l    #512000,memlongchip
             blt       glad520

             movem.l   d0-d7/a0-a6,-(sp)
             move.l    #22960,d0
             move.w    #7000,d1
             jsr       memallocchip
             movem.l   (sp)+,d0-d7/a0-a6

glad520:     


             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #4005,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a6
             movem.l   (sp)+,d0-d7/a0-a5


             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a0-a3/a5/a6,-(sp)
             move.w    #7000,d0
             JSR_MEMFINDBLOC 
             beq       glad520_1

             movea.l   memadrbloc(a0),a4
glad520_1:   
             movem.l   (sp)+,d0-d7/a0-a3/a5/a6

             movem.l   d0-d7/a2-a6,-(sp)
             move.w    #1932,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d0
             move.w    8(a0),d0
             lea.l     0(a0,d0.l),a1
             movem.l   (sp)+,d0-d7/a2-a6

             movem.l   d0-d7/a0/a1/a4-a6,-(sp)
             move.w    #1933,d0
             JSR_MEMFINDBLOC 
             bne.s     glad1933
             move.w    #1934,d0
             JSR_MEMFINDBLOC 

glad1933:    
             movea.l   memadrbloc(a0),a2
             moveq.l   #0,d0
             move.w    8(a2),d0
             lea.l     0(a2,d0.l),a3
             movem.l   (sp)+,d0-d7/a0/a1/a4-a6


             jsr       (a6)

             tst.w     d0
             beq       gladok
             clr.w     jehan+potvie
             bra       glad00
gladok:      
             cmpi.w    #-1,d1
             beq       glad00

             move.w    #20,xaff
             move.w    #10,yaff
             clr.w     coinx
             move.w    #yorg,coiny

             jsr       debloc

glad01:      
             LEA_MENUTXLSTA1 
             move.l    #txboi84,(a1)+
             move.l    #txboi85,(a1)+
             move.l    #-1,(a1)+

             moveq.l   #1,d0

             movem.l   d1-d7/a0-a6,-(sp)
             JSR_BOITE 
             movem.l   (sp)+,d1-d7/a0-a6
             tst.w     d0
             blt       glad01
             cmp.w     d0,d1
             beq       glad00
             addi.w    #20,popu
glad00:      
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       clearecran
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #303,exnocour
             clr.w     souri_10
             clr.w     souri_5

             move.w    #7000,d0
             jsr       memmasterkill

             move.w    #907,d0
             jsr       deverouille

             move.w    #932,d0
             jsr       deverouille
             move.w    #1932,d0
             jsr       memmasterkill
             move.w    #933,d0
             jsr       deverouille
             move.w    #1933,d0
             jsr       memmasterkill
             move.w    #934,d0
             jsr       deverouille
             move.w    #1934,d0
             jsr       memmasterkill

             move.w    #4005,d0
             jsr       memmasterkill

             lea.l     palette,a0
             jsr       degraon

             move.w    #6020,d0
             jsr       findloaddata

             move.w    nocour,-(sp)
             move.w    #911,nocour
             jsr       biitempoprog
             move.w    (sp)+,nocour

             cmpi.w    #1000,popu
             blt       glad02
             move.w    #4000,d0
             move.w    #42,d1
             jsr       findobj
             bne       glad02
             moveq.l   #partie2fin,d0
             JSR_SCENASETBIT 
glad02:      
             jsr       checksortieson

             clr.w     souri_11

             jsr       initecran

             bsr       restorescreen



             move.w    exnocour,newnocour
             bra       clic2

;---------------------------------------------------------------
;
; viamain
;

viamain:     
             movem.l   d0-d7/a0-a6,-(sp)

             moveq.l   #32,d0
             JSR_TRAITEEXP 
             movem.l   (sp)+,d0-d7/a0-a6

             jsr       multitacheoff
             LEA_MENUTXLSTA1 
             move.l    #txboi28,(a1)+
             move.l    #txboi29,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #1,d0
             JSR_BOITE 
             tst.w     d0
             bne       specialbiifin
             move.l    #300,d0
             jsr       assezargent
             beq       viamain0

             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi10,(a1)+
             move.l    #txboi11,(a1)+
             move.l    #txboi3,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             bra       specialbiifin
viamain0:    
             jsr       multitacheon

             jsr       multitacheoff
             jsr       stockoffset

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    nocour,d0
             jsr       deverouille



;10/2/92              move.w   #4004,d0
;10/2/92              jsr      findloadprg
;10/2/92              movea.l  memadrbloc(a0),a6

             move.w    nocour,d0
             lea.l     viatable,a0
vm0:         
             cmp.w     (a0)+,d0
             bne.s     vm0

             suba.l    #viatable+2,a0
             move.w    a0,d0
             lsr.w     #1,d0

             movem.l   d0-d7/a2-a6,-(sp)
             move.w    #910,nocour
             jsr       biitempoprog
;              movea.l  adrbiicour,a0
;              movea.l  adrdicour,a1

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #906,nocour
             jsr       biitempoprog
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   (sp)+,d0-d7/a2-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #0,d2                ;laissez-passer
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             moveq.l   #7,d1                ;laissez-passer TA
             jsr       findobjtype
             movem.l   (sp)+,d0-d7/a0-a6
             bne       viapermis0
             addq.w    #1,d2
viapermis0:  
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             moveq.l   #16,d1               ;laissez-passer RX
             jsr       findobjtype
             movem.l   (sp)+,d0-d7/a0-a6
             bne       viapermis1
             addq.w    #2,d2
viapermis1:  
             movem.l   d0-d7/a0-a5,-(sp)    ;10/2/92
             move.w    #4004,d0             ;10/2/92
             jsr       findloadprg          ;10/2/92
             movea.l   memadrbloc(a0),a6    ;10/2/92
             movem.l   (sp)+,d0-d7/a0-a5    ;10/2/92

             movem.l   d0-d7/a2-a6,-(sp)    ;10/2/92
             move.w    #1910,d0             ;10/2/92
             JSR_MEMFINDBLOC                ;10/2/92
             movea.l   memadrbloc(a0),a0    ;10/2/92
             moveq.l   #0,d0                ;10/2/92
             move.w    8(a0),d0             ;10/2/92
             lea.l     0(a0,d0.l),a1        ;10/2/92
             movem.l   (sp)+,d0-d7/a2-a6    ;10/2/92



             jsr       (a6)

             add.w     d0,d0
             lea.l     viatable,a0
             move.w    0(a0,d0.w),exnocour

             jsr       clearecran

             clr.w     souri_10
             clr.w     souri_5

             move.w    #906,d0
             jsr       deverouille
             move.w    #1906,d0
             jsr       memmasterkill
             move.w    #910,d0
             jsr       deverouille
             move.w    #1910,d0
             jsr       memmasterkill

             move.w    #4004,d0
             jsr       memmasterkill

             cmpi.w    #303,exnocour        ;prison ???
             bne       intodyno
             addi.l    #21000*24,contvbl
             jmp       intodyno


viatable:    .DC.w 0,101,500,407,401,300,300,633,630,631,632,301,215,202,215,303
simutable:   .DC.w 0,631,633,630,632,616,600,613,623,628,100,707,710

;---------------------------------------------------------------
;
; tubularmain
;

tubularmain: 
             jsr       outdyno1
             clr.w     souri_11

             lea.l     souri_13,a0
             move.w    #0,(a0)+
             move.w    #0,(a0)+
             move.w    #319-16,(a0)+
             move.w    #199-16,(a0)+

             move.w    #-1,souri_14

             move.w    #-1,souri_11

             move.w    #904,nocour
             jsr       biitempoprog



             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4001,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             jsr       (a0)

             move.w    #1904,d0
             jsr       memmasterkill
             move.w    #904,d0
             jsr       deverouille
             move.w    #4001,d0
             jsr       deverouille

             clr.w     souri_10

             jmp       intodynos
;---------------------------------------------------------------
;
; quattromain
;

quattromain: 
             jsr       outdyno1
             clr.w     souri_11

             jsr       fulldebloc

             move.w    #-1,souri_14

             move.w    #-1,souri_11

             move.w    #903,nocour
             jsr       biitempoprog



             movem.l   d0-d7/a0-a6,-(sp)
             jsr       outdyno2
             movem.l   (sp)+,d0-d7/a0-a6

             moveq.l   #1,d0
             tst.w     cfqx
             beq.s     quaxy
             moveq.l   #0,d0
quaxy:       
             .IF disquedur=0
             .IF son=1
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    nocour,d0
             jsr       loadsndseq
             movem.l   (sp)+,d0-d7/a0-a6
             .ENDIF 
             .ENDIF 

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #4002,d0
             jsr       findloadprg
             movea.l   memadrbloc(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             jsr       (a0)

             move.w    #1903,d0
             jsr       memmasterkill
             move.w    #903,d0
             jsr       deverouille
             move.w    #4002,d0
             jsr       deverouille

             clr.w     souri_10

             jmp       intodynos


;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                              DIALOGUES
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

largeurbulle           equ 21               ;largeur d'une bulle en caracteres
couleuron    equ rouge
couleuroff   equ marrontresfonce
couleuronr   equ blanc
couleuroffr  equ marron



;---------------------------------------------------------------
;
; addsujet
;
; entree:     d0 numero du sujet
;

addsujet:    
             lea.l     sujetliste,a0
as0:         
             move.w    (a0)+,d7
             blt       as1
             cmp.w     d0,d7
             beq       rts
             bra.s     as0
as1:         
             move.w    d0,-(a0)
             move.w    #-1,2(a0)
             rts       

;---------------------------------------------------------------
;
; findadrphrase
;
; trouve l'adresse d'une phrase secondaire
;
; entree:     d0 numero de la phrase
;
; retour:     a0 pointe sur les donnees de la phrase
;

findadrphrase:         
             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    8(a0),a0
             movem.l   (sp)+,d0-d7/a1-a6

             subq.w    #1,d0
             blt       fap0
fap1:        
             adda.w    (a0),a0
             dbra      d0,fap1
fap0:        
             addq.l    #2,a0
             rts       

noirrouge0:  
             jmp       noirrouge

;---------------------------------------------------------------
;
; formatph
;
; formatage d'une phrase (initialise 'formatphd')
;
; entree: adrphrasecour pointe sur la structure de la phrase
;

formatph:    
             movea.l   adrphrasecour,a0
             lea.l     formatphd,a5
;     lea.l    dico,a6
             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge0

             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    (a0),a0
             movea.l   a0,a6
             movem.l   (sp)+,d0-d7/a0-a5

             moveq.l   #0,d1                ;nombre de mots
             moveq.l   #0,d2                ;nombre de lettres de la phrase
fp0:         
             move.w    (a0),d0
             blt.s     fp1                  ;fin de phrase
             addq.l    #4,a0
             addq.w    #1,d1
             lea.l     0(a6,d0.w),a1        ;adresse du mot

             movem.l   d0-d7/a0/a2-a6,-(sp)
             movea.l   a1,a0
             jsr       motfeminin
             movea.l   a0,a1
             movem.l   (sp)+,d0-d7/a0/a2-a6

             movea.l   a1,a2
fp2:         
             tst.b     (a1)+
             bne.s     fp2
             suba.l    a2,a1                ;a1=nombre de caractere du mot (0 y compris)

             add.w     a1,d2
             cmpi.w    #largeurbulle,d2
             blt.s     fp0

             sub.w     a1,d2                ;nb caractere
             subq.w    #1,d1
             move.w    #largeurbulle,d0
             sub.w     d2,d0
             mulu.w    #3,d0                ;              lsr.w    #1,d0
             move.w    d0,(a5)+             ;dx
             move.w    d1,(a5)+             ;nb mots

             moveq.l   #0,d1
             moveq.l   #0,d2
             subq.l    #4,a0                ;retour au mot precedent
             bra.s     fp0
fp1:         
             move.w    #largeurbulle,d0
             sub.w     d2,d0
             mulu.w    #3,d0                ;              lsr.w    #1,d0
             move.w    d0,(a5)+             ;dx
             move.w    d1,(a5)+             ;nb mots
             move.w    #-1,(a5)+
             rts       

;---------------------------------------------------------------
;
; affphrase
;
; entree:     adrphrasecour pointe sur la structure de la phrase
;             d0 x
;             d1 y
;

affphrase:   
             move.w    #couleuron,coltxton
             move.w    #couleuroff,coltxtoff
             cmpi.w    #3,humeur
             bne       apf00
             move.w    #couleuronr,coltxton
             move.w    #couleuroffr,coltxtoff
apf00:       
             lea.l     formatphd,a0
             moveq.l   #1,d7                ;nombre de lignes*7+1
apf0:        
             tst.w     (a0)
             blt       apf1
             addq.l    #4,a0
             addq.w    #7,d7
             bra.s     apf0
apf1:        
             subq.w    #2,d1
             move.w    d7,d2                ;h

             movem.l   d0-d6/a0-a6,-(sp)
             jsr       affbulle
             movem.l   (sp)+,d0-d6/a0-a6

             add.w     d7,d1                ;delta y
             addi.w    #20-59,d0
             addi.w    #12+8,d1

             movea.l   adrphrasecour,a0
             move.w    d0,d7                ;x
             move.w    d1,d2
             move.w    #160,d4
             movea.l   sys01,a1

;      lea.l    dico,a6
             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #6020,d0
             JSR_MEMFINDBLOC 
             beq       noirrouge0
             movea.l   memadrbloc(a0),a0
             lea.l     28(a0),a0
             adda.l    (a0),a0
             movea.l   a0,a6
             movem.l   (sp)+,d0-d7/a0-a5

             lea.l     formatphd,a5
             movea.l   a0,a4
             movea.l   adrlocalbulle,a3
app0:        
             move.w    d7,d1
             move.w    (a5)+,d6             ;dx
             blt       app4
             add.w     d6,d1
             move.w    (a5)+,d6             ;nb mots
             subq.w    #1,d6
app1:        
             move.w    (a4)+,d5             ;offset
             lea.l     0(a6,d5.w),a0        ;adresse du mot

             movem.l   d0-d7/a1-a6,-(sp)
             jsr       motfeminin
             movem.l   (sp)+,d0-d7/a1-a6

             move.w    coltxtoff,d3
             move.w    (a4)+,d5             ;code
             beq.s     app2
             btst      #15,d5
             beq.s     app1b

             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d5,d0
             bclr      #15,d0
             jsr       addsujet
             movem.l   (sp)+,d0-d7/a0-a6
app1b:       
             cmpi.w    #3000,d5
             bge       app2
             cmpi.w    #2000,d5
             bge       app2x
             cmpi.w    #1000,d5             ;traduire par bob
             bge       app2
app2x:       
             move.w    coltxton,d3
app2:        
             movem.l   d1-d7/a0-a6,-(sp)
             jsr       textxcrypt
             movem.l   (sp)+,d1-d7/a0-a6

             mulu.w    #6,d0
             cmp.w     coltxtoff,d3
             beq.s     app3
             move.w    d1,(a3)+
             move.w    d2,(a3)+
             move.w    d1,(a3)
             add.w     d0,(a3)+
             move.w    d2,(a3)
             addq.w    #6,(a3)+
             move.w    d5,(a3)+             ;code
app3:        
             add.w     d0,d1
             addq.w    #6,d1

             dbra      d6,app1
             addq.w    #7,d2
             bra       app0
app4:        
             move.w    #-1,(a3)+
             rts       

;---------------------------------------------------------------
;
; motfeminin
;
; entree:     a0 adresse du mot a analyser
;
; retour:     a0 adresse du mot traite
;

motfeminin:  
             movea.l   a0,a1
motfem0:     
             cmpi.b    #'Ý',(a1)
             beq       motfem1
             tst.b     (a1)+
             bne       motfem0
             rts                            ; mot asexue
motfem1:     
             movea.l   adrevicour,a6
             move.l    evicodegen(a6),d6
             andi.l    #$00f00000,d6
             beq       motfem2              ;c'est un homme
             lea.l     1(a1),a0
             rts       

motfem2:     
             lea.l     bufmotsex,a2
motfem3:     
             move.b    (a0)+,(a2)+
             cmpa.l    a0,a1
             bne.s     motfem3
             clr.b     (a2)
             lea.l     bufmotsex,a0
             rts       

;---------------------------------------------------------------
;
; textxcrypt
;

textxcrypt:  
             tst.w     btraduc
             bne       textx
             movea.l   adrevicour,a6
             cmpi.b    #60,eviintel(a6)
             bhi       textx                ;sufisament inteligent pour parler romain
             move.l    evicodegen(a6),d0
             andi.l    #$0f000000,d0
             beq       textx                ;c'est un romain

             lea.l     -100(sp),sp
             movea.l   sp,a6
tcry1:       
             move.b    (a0)+,d7
             beq       tcry0
             cmpi.b    #'A',d7
             bcs       tcry2

             addi.b    #'a'-'A',d7
             move.b    d7,(a6)+
             bra.s     tcry1
tcry0:       
             clr.b     (a6)+
             movea.l   sp,a0
             JSR_TEXTX 
             lea.l     100(sp),sp
             rts       
tcry2:       
             move.b    #" ",(a6)+
             bra       tcry1

;---------------------------------------------------------------
;
; affbulle
;
; entree:     d0 x
;             d1 y
;             d2 hauteur (en pixels)
;             +HUMEUR (0=cool 3=hot)
;
; retour:     d7 delta y
;

affbulle:    
             move.w    humeur,d3
             addq.w    #8,d1
             subi.w    #59,d0

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d0
             move.w    8(a0),d0
             adda.l    d0,a0
             movem.l   (sp)+,d0-d7/a1-a6

             movem.l   d0-d7/a0-a5,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a6
             movem.l   (sp)+,d0-d7/a0-a5

             moveq.l   #0,d7
             move.w    14(a6),d7
             adda.l    d7,a6
             addq.l    #2,a6
             adda.w    #16*16,a6            ;16=no de l'anim
             mulu.w    #3*16,d3
             adda.w    d3,a6
             move.w    8(a6),d7
             adda.l    d7,a0

             swap.w    d2
             clr.w     d2
             swap.w    d2
             subq.w    #8,d2
             divu.w    #9,d2
             swap.w    d2
             move.w    d2,d4
             swap.w    d2
             move.w    d2,d7
             addq.w    #1,d7
             mulu.w    #9,d7


             lea.l     -80*14/2(sp),sp
             movea.l   sp,a1


             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #14,d0
             jsr       symy80
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   a1,a0

             addi.w    #80,d0

             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       symx8014
             movem.l   (sp)+,d0-d7/a0-a6

             addi.w    #14,d1
             add.w     d7,d1

             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #14,d0
             jsr       symy80
             movem.l   (sp)+,d0-d7/a0-a6


             subi.w    #80,d0

             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6


             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d0
             move.w    8(a0),d0
             adda.l    d0,a0
             movem.l   (sp)+,d0-d7/a1-a6

             lea.l     -16(a6),a6
             moveq.l   #0,d6
             move.w    8(a6),d6
             adda.l    d6,a0

             sub.w     d7,d1

             movem.l   d0-d7/a0-a6,-(sp)
             addi.w    #60-1,d0
             subi.w    #9-1+14,d1

             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a1-a6,-(sp)
             move.w    #1911,d0
             JSR_MEMFINDBLOC 
             movea.l   memadrbloc(a0),a0
             moveq.l   #0,d0
             move.w    8(a0),d0
             adda.l    d0,a0
             movem.l   (sp)+,d0-d7/a1-a6

             lea.l     2*16(a6),a6
             moveq.l   #0,d6
             move.w    8(a6),d6
             adda.l    d6,a0

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       abm0
             movem.l   (sp)+,d0-d7/a0-a6

             addi.w    #80,d0

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #9,d0
             jsr       symy80
             movem.l   (sp)+,d0-d7/a0-a6

             movea.l   a1,a0
             jsr       abm0

             lea.l     80*14/2(sp),sp
             moveq.l   #9,d7
             sub.w     d4,d7
             lsr.w     #1,d7                ;delta y
             rts       

abm0:        
             movem.l   d0-d7/a0-a6,-(sp)
             movea.l   sys01,a1
             move.w    4(a6),d2
             move.w    6(a6),d3
             move.w    #160,d4
             jsr       clipoff
             JSR_PUTTCX 
             movem.l   (sp)+,d0-d7/a0-a6
             addi.w    #9,d1
             dbra      d2,abm0
             rts       


;---------------------------------------------------------------
;
; print
;
; sous programme d'affichage d'un nombre en hexa
;
; entree: d0 nombre a afficher
;


print::      
             .IF 0

             movem.l   d0-d7/a0-a6,-(sp)
             clr.w     d0
             clr.w     d1
             moveq.l   #70,d2
             moveq.l   #50,d3
             clr.w     d4
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)

             lea.l     poly2,a0
             moveq.l   #28,d2
             moveq.l   #7,d3
pbou:        
             move.l    d0,d1
             lsr.l     d2,d1
             andi.w    #$f,d1
             cmpi.w    #10,d1
             bge       alph1
             addi.w    #"0",d1
             bra       contx1
alph1:       
             addi.w    #"A"-10,d1
contx1:      
             move.b    d1,(a0)+
             subq.w    #4,d2
             dbra      d3,pbou

             lea.l     poly2,a0
             moveq.l   #8,d0
             moveq.l   #10,d1
             moveq.l   #10,d2
             moveq.l   #1,d3

             jsr       text
             movem.l   (sp)+,d0-d7/a0-a6

             movem.l   d0-d7/a0-a6,-(sp)

             move.l    d1,d0
             lea.l     poly2,a0
             moveq.l   #28,d2
             moveq.l   #7,d3
pbou1:       
             move.l    d0,d1
             lsr.l     d2,d1
             andi.w    #$f,d1
             cmpi.w    #10,d1
             bge       alph11
             addi.w    #"0",d1
             bra       contx11
alph11:      
             addi.w    #"A"-10,d1
contx11:     
             move.b    d1,(a0)+
             subq.w    #4,d2
             dbra      d3,pbou1

             lea.l     poly2,a0
             moveq.l   #8,d0
             moveq.l   #10,d1
             moveq.l   #20,d2
             moveq.l   #5,d3
             jsr       cd009
             movem.l   (sp)+,d0-d7/a0-a6

             move.l    d2,d0
             lea.l     poly2,a0
             moveq.l   #28,d2
             moveq.l   #7,d3
pbou2:       
             move.l    d0,d1
             lsr.l     d2,d1
             andi.w    #$f,d1
             cmpi.w    #10,d1
             bge       alph12
             addi.w    #"0",d1
             bra       contx12
alph12:      
             addi.w    #"A"-10,d1
contx12:     
             move.b    d1,(a0)+
             subq.w    #4,d2
             dbra      d3,pbou2

             lea.l     poly2,a0
             moveq.l   #8,d0
             moveq.l   #10,d1
             moveq.l   #30,d2
             moveq.l   #5,d3
             jsr       cd009
             rts       
             .ENDIF 










;---------------------------------------------------------------
;
; overlay
;

overadr:     .DC.l souri_5,souri_7,souri_8,souri_11,rnd,puttc,sys01,ecrswap
             .DC.l souri_13,sys00,puttcx,pbox,cd009,adrdicour,degraon
             .DC.l degraoff,palettechidam,souri_18,bsour,adrbsour,contvbl
             .DC.l souri_10,polyl_1,polyl_2,polyl_4,polyl,ad_seq,novoie
             .DC.l play_seq,table_sons,seq_silence,adrbiicour,polyl_5,polyl_6
             .DC.l box,puttc_1,puttc_2,puttc_3,puttc_4,objstruc,evi,objtypedata
             .DC.l makeperso,perso,wx_souri,wy_souri,adrobj,combatinv
             .DC.l quattrotx,argent,gain_qua,tubutx,gain_tubu,viatx
             .DC.l gladtx,tarene,popu,combtx,jehan,chidamtx

;---------------------------------------------------------------
;
; degraon
;

degraon::    
             moveq.l   #0,d0
             jsr       degra
             rts       

;---------------------------------------------------------------
;
; degraoff
;

degraoff::   
             moveq.l   #-1,d0
             jsr       degra
             rts       

;---------------------------------------------------------------
;
; degra
;
; entree:     d0 sens du de grade (0 noir->blanc) (1 blanc->noir)
;             a0 adresse de la palette
;

degra:       
             move.w    d0,d6
             swap.w    d6
             move.w    #7,d6
degra0:      
             move.l    contvbl,d7
             addq.l    #3,d7
degra1:      
             cmp.l     contvbl,d7
             bgt       degra1

             move.w    d6,d0

             swap.w    d6
             tst.w     d6
             beq.s     e00

             neg.w     d0
             addq.w    #7,d0
e00:         
             swap.w    d6

             move.w    d0,d1
             lsl.w     #4,d1
             move.w    d1,d2
             lsl.w     #4,d2

             moveq.l   #15,d7
             movea.l   #$ff8240,a6
             movea.l   a0,a1
b00:         
             move.w    (a1)+,d3
             move.w    d3,d4
             move.w    d3,d5
             andi.w    #$f,d3
             andi.w    #$f0,d4
             andi.w    #$f00,d5
             sub.w     d0,d3
             bge       e01
             clr.w     d3
e01:         
             sub.w     d1,d4
             bge       e02
             clr.w     d4
e02:         
             sub.w     d2,d5
             bge       e03
             clr.w     d5
e03:         
             or.w      d5,d3
             or.w      d4,d3
             move.w    d3,(a6)+
             dbra      d7,b00
             dbra      d6,degra0
             rts       

sens:        .DC.w 0

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                      SONS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
sons:        


;---------------------------------------------------------------
;
; checksortieson
;
; initialise la sortie du son en mode MV16 ou MONITEUR
;

checksortieson:        
             tst.w     sonon
             bne.s     checkss1
             jsr       playsilence
checkss1:    
             move.w    sr,-(sp)
             move.w    #$2700,sr
             lea.l     sonmv16,a0
             lea.l     sonmv16e,a1
             .IF son
             move.b    #63,$fffa1f          ;63-> kHz
             .ENDIF 

             lea.l     sortieson,a2
             tst.w     cfsmv16
             bne       checkss0
             lea.l     sonatari,a0
             lea.l     sonatarie,a1
             .IF son
             move.b    #87,$fffa1f          ;63*1.37=87 la sortie moniteur est 1,37 fois plus lente que la sortie mv16
             .ENDIF 
checkss0:    
             move.w    (a0)+,(a2)+
             cmpa.l    a0,a1
             bne.s     checkss0
             move.w    (sp)+,sr
             rts       


rte:         rte       

timer_a3:    
             move.l    d0,-(sp)
             move.w    d1,-(sp)
             move.l    a0,-(sp)

; prends un octet du son de la voie 1

octetvoie1:  
             clr.w     d0
ad1:         move.b    silence_data,d0
             beq       rebouclages1
             addq.l    #1,ad1+2

;prends un octet du son de la voie2

octetvoie2:  
             clr.w     d1
ad2:         move.b    silence_data,d1
             beq       rebouclages2
             addq.l    #1,ad2+2

; sort les deux octets (voies 1+2) sur le port cartouche

octetvoie12: 
; souris (cf franck)
             btst      #0,$fffc00
             beq.s     vide3
             movea.l   adrbsour,a0
             move.b    $fffc02,(a0)+
             move.l    a0,adrbsour
vide3:       


sonauto1:    lsl.w     #3,d0
sonauto2:    lsl.w     #3,d1

             add.w     d1,d0
sonauto3:    addi.w    #0,d0

sortieson:   .DCB.b 160,0



sonmv16:     
             movea.l   #$fa0000,a0
             adda.w    d0,a0                ; data preleves sur adresses du port cartouche
             tst.w     (a0)                 ; lecture -> sortie sur port cartouche
             movea.l   (sp)+,a0
             move.w    (sp)+,d1
             move.l    (sp)+,d0
             rte       
sonmv16e:    


sonatari:    
             move.l    a1,-(sp)

             movea.l   #$ff8802,a1          ;SOUND CHIP CNTRL REG

             lsr.w     #5,d0
             lea.l     table1,a0
             adda.w    d0,a0

             move.b    #8,-2(a1)

             move.b    (a0),(a1)
             move.b    #9,-2(a1)
             move.b    table2-table1(a0),(a1)
             move.b    #10,-2(a1)
             move.b    table3-table1(a0),(a1)

             movea.l   (sp)+,a1
satari0:     
             movea.l   (sp)+,a0
             move.w    (sp)+,d1
             move.l    (sp)+,d0
             rte       
sonatarie:   



;*******************************************
; definition d'un son : SILENCE

silence:     
             .DC.w 2000                     ; periode
             .DC.w 72  ; No de note
silence_loop:          
             .DC.l 20,4
             .DC.l 0,0
silence_data:          
             .REPT 100
             .DC.b 127
             .ENDR 
             .DC.b 127,127,127,127,127,127,127,127,0
             .EVEN 



;*******************************************
; definition d'une sequence de SILENCE

seq_silence: 
             .REPT 42
             .DC.b 0
             .ENDR 
             .DC.w 0,0 ; play_snd,son silence
             .DC.w 3000,0,0                 ; 3000 fois

             .DC.w 3,0,0,0,0                ; reboucle





;*****************************************
; TABLE DES ADRESSES DES SONS
table_sons:  
             .DC.l silence
             .DCB.l 255,0


zero:        .DC.w 0


table1:      
             .DC.b 0,1,2,3,3,4,4,5
             .DC.b 5,5,6,6,6,6,6,6
             .DC.b 7,7,7,7,7,7,8,8
             .DC.b 8,8,8,8,8,8,8,9
             .DC.b 9,9,9,9,9,9,9,9
             .DC.b 9,9,9,10,10,10,10,10
             .DC.b 10,10,10,10,10,10,10,10
             .DC.b 10,10,10,10,10,11,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,11,11,11,12,12,12
             .REPT 21
             .DC.b 12,12,12,12,12,12,12,12
             .ENDR 

table2:      

             .DC.b 0,1,1,0,1,1,2,1
             .DC.b 2,2,1,2,2,3,4,4
             .DC.b 1,2,2,3,4,4,0,1
             .DC.b 2,3,3,4,4,5,5,1
             .DC.b 2,3,3,4,4,5,5,5
             .DC.b 6,6,6,1,2,2,3,3
             .DC.b 4,4,5,5,6,6,6,6
             .DC.b 6,6,7,7,7,1,2,2
             .DC.b 3,4,4,5,5,5,6,6
             .DC.b 6,6,6,6,7,7,7,7
             .DC.b 7,7,7,8,8,0,1,2
             .DC.b 3,3,4,4,5,5,5,6
             .DC.b 6,6,6,6,6,7,7,7
             .DC.b 7,7,7,8,8,8,8,8
             .DC.b 8,8,8,8,9,9,9,9
             .DC.b 9,9,9,9,9,9,9,9
             .DC.b 10,10,10,10,10,10,10,10
             .DC.b 10,10,10,10,10,10,10,10
             .DC.b 10,10,11,11,11,11,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,12,12,12,12,12,12
             .REPT 10
             .DC.b 12,12,12,12,12,12,12,12
             .ENDR 

table3:      
             .DC.b 0,1,1,0,2,1,1,0
             .DC.b 0,2,1,1,2,2,1,2
             .DC.b 1,1,2,2,1,2,0,2
             .DC.b 2,1,2,1,2,1,2,1
             .DC.b 1,0,2,1,2,1,2,3
             .DC.b 2,2,3,1,1,2,1,2
             .DC.b 2,2,2,2,1,2,3,3
             .DC.b 4,4,1,2,3,1,1,2
             .DC.b 2,1,2,0,2,3,1,2
             .DC.b 3,3,4,4,1,2,3,3
             .DC.b 4,4,5,2,2,0,2,2
             .DC.b 0,2,1,2,1,2,3,2
             .DC.b 2,3,4,4,5,2,2,3
             .DC.b 4,4,5,0,2,3,3,4
             .DC.b 4,5,5,6,2,2,3,4
             .DC.b 4,5,5,5,6,6,6,6
             .DC.b 1,2,3,3,4,4,5,5
             .DC.b 6,6,6,6,7,7,7,7
             .DC.b 7,7,2,2,3,4,4,5
             .DC.b 5,5,6,6,6,6,7,7
             .DC.b 7,7,7,7,8,8,8,8
             .DC.b 8,8,0,2,2,3,4,4
             .DC.b 5,5,6,6,6,6,6,7
             .DC.b 7,7,7,7,7,8,8,8
             .DC.b 8,8,8,8,8,9,9,9
             .DC.b 9,9,9,9,9,9,9,10
             .DC.b 10,10,10,10,10,10,10,10
             .DC.b 10,10,10,10,10,10,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,11,11,11,11,11,11
             .DC.b 11,11,11,12,12,12,12,12
             .DC.b 12,12,12,12,12,12,12,12


setsnd:      move.b    #0,screg             ;CHANNEL A
             move.b    #0,scdata
             move.b    #1,screg
             move.b    #0,scdata

             move.b    #2,screg             ;CHANNEL B
             move.b    #0,scdata
             move.b    #3,screg
             move.b    #0,scdata

             move.b    #4,screg             ;CHANNEL C
             move.b    #0,scdata
             move.b    #5,screg
             move.b    #0,scdata

             move.b    #7,screg             ;SET UP CHANNEL MIXING & PORT 'A' I/O
             move.b    #$ff,scdata

             move.b    #8,screg             ;SET ALL VOLUMES TO ZERO
             move.b    #0,scdata
             move.b    #9,screg
             move.b    #0,scdata
             move.b    #10,screg
             move.b    #0,scdata
             rts       

;*******************************************************************************
; FORMAT D'UN SON
;
; 0000:              xxxx.W periode d'enregistrement du son
; 0002:              xxxx.W No de note d'origine sur le clavier midi du son
; 0004:         xxxx xxxx.L depart du 1er rebouclage (a partir de 0000)
; 0008:         xxxx xxxx.L longeur du 1er rebouclage
; 0012:         xxxx xxxx.L ...
; 0016:         xxxx xxxx.L ...
; 0004+(N-1)*8: xxxx xxxx.L depart du Nieme rebouclage
; 0008+(N-1)*8: xxxx xxxx.L longeur du Nieme rebouclage
; 0012+(N-1)*8: xxxx xxxx.L 0
; 0016+(N-1)*8: datas du son
;*******************************************************************************



;*******************************************************************************
; SEQUENCES
;
; formats :
;
;
;  / reg1(.W) / No son min(.W)   / No son max (.W)  /
;  / reg2(.W) / nb fois min (.W) / nb fois max (.W) / frequence (.W) / volume (.W)
;
; reg1=  2 -> sequence finie, joue seq_silence
;        3 -> sequence reboucle au debut
;        1 -> sequence joue un son aleatoire ( entre son min et son max )
;        0 -> joue un son normalement (son min)
;
; reg2=  0 -> nb fois fixe (nb fois min)
;        1 -> nb fois aleatoire (entre nb fois min et max)
;
;******************************************************************************


;************************************************
; equivalences utilisees par les routines de SON

;voie1         equ 1
;voie2         equ 2

; commandes d'une sequence

play_snd     equ 0
play_rnd     equ 1
stop_seq     equ 2
loop_seq     equ 3
time_rnd     equ 0
_if          equ 6
_endif       equ 16


; parametres de l'en-tete d'un son

per_snd      equ 0
note_snd     equ 2
loop_snd     equ 4






;**************************************************
;                     VOIE 1
;**************************************************

;**************************************************
; gestion des rebouclages d'un son de la voie 1

rebouclages1:          
             move.l    d0,-(sp)
; ad_loop1 contient l'adresse du prochain rebouclage a jouer
             movea.l   ad_loop1,a0
             move.l    (a0)+,d0
             beq.s     son_voie1_fini

; adresse du prochain rebouclage -> d0
             add.l     ad_son1,d0
             move.l    d0,ad1+2             ; pointe sur les datas du son
             addq.l    #4,a0                ; passe la longueur


; passe au donnees du rebouclage suivant
             move.l    a0,ad_loop1
             move.l    (sp)+,d0
             move.w    #127,d0
             bra       octetvoie2


volv1:       .DC.w 3
volv2:       .DC.w 3
volx1:       .DC.w 0
volx2:       .DC.w 0


;***************************************************
; le son de la voie 1 est fini
; on teste si on doit rejouer le son plusieurs fois

son_voie1_fini:        
             move.l    (sp)+,d0
             subq.w    #1,nb_fois1
             beq       seq1


; oui, restore l'adresse de depart du
; premier rebouclage
             movea.l   ad_son1,a0           ; pointe sur le son
             lea.l     loop_snd(a0),a0      ; pointe sur les datas du 2eme"loop"
             move.l    a0,ad_loop1
             move.w    #127,d0
             bra       octetvoie2



;***************************************************
; gere les sequences sonores de la voie 1
; le son de la voie 1 est totalement termine
; on passe a la sequence sonore suivante

seq1:        
             move.l    a1,-(sp)
; le premier mot d'une sequence contient la commande
             movea.l   ad_seq1,a0
             move.w    (a0)+,d0
             cmpi.w    #19,d0
             bgt       bleublancrouge
             lea.l     table_inst1,a1
             move.w    d0,d1
             add.w     d1,d1
             add.w     d1,d1
             movea.l   0(a1,d1.w),a1
             jmp       (a1)

table_inst1: .DC.l seq1_play
             .DC.l seq1_play
             .DC.l seq1_finie
             .DC.l seq1_loop
             .DC.l seq1_a_rnd
             .DC.l seq1_b_rnd
             .DC.l seq1_if_a_egal
             .DC.l seq1_if_b_egal
             .DC.l seq1_if_a_inf
             .DC.l seq1_if_b_inf
             .DC.l seq1_if_a_sup
             .DC.l seq1_if_b_sup
             .DC.l seq1_if_a_dif
             .DC.l seq1_if_b_dif
             .DC.l seq1_if_a_entre
             .DC.l seq1_if_b_entre
             .DC.l seq1_endif
             .DC.l seq1_goto
             .DC.l seq1_goto_a
             .DC.l seq1_goto_b

             .DC.l seq1_finie
             .DC.l seq1_finie
             .DC.l seq1_finie
             .DC.l seq1_finie
             .DC.l seq1_finie
             .DC.l seq1_finie
             .DC.l seq1_finie


bleublancrouge:        
             move.w    #$2700,sr
             move.w    #$7,$ff8240
             move.w    #$777,$ff8240
             move.w    #$700,$ff8240
             bra.s     bleublancrouge

;****************************************************
; 1: joue un son sur la voie 1

seq1_play:   

; No de son (si d0=1, le No de son est aleatoire)
             move.w    (a0)+,d1             ; No de son (si fixe)
             tst.w     d0
             beq.s     no_son_fixe1         ; le No de son est fixe
             move.w    var_a1,d1            ; -> No de son
no_son_fixe1:          
             move.w    d1,soncour1

; recherche du nbre de fois
             move.w    (a0)+,nb_fois1       ; =0 -> var_b1 est le nbre de fois
             bne.s     nb_fois1_fixe1
             move.w    var_b1,nb_fois1      ; -> nb_fois1
nb_fois1_fixe1:        
             addq.l    #2,a0                ; passe la frequence

             move.l    d0,-(sp)
             move.w    (a0)+,d0             ;volume de 0 a 63
             move.w    d0,volx1
             lsr.w     #4,d0                ;0,1,2 ou 3
             andi.w    #$7,d0
             bne.s     volpas0
             moveq.l   #1,d0
volpas0:     
             cmpi.w    #3,d0
             blt.s     volinf3
             moveq.l   #3,d0
volinf3:     
             move.w    d0,volv1

             bsr       traitevol
             move.l    (sp)+,d0

             move.l    a0,ad_seq1           ; ad_seq1 = prochaine sequence

             add.w     d1,d1
             add.w     d1,d1
             lea.l     table_sons,a0
             movea.l   0(a0,d1.w),a0
             cmpa.l    #0,a0
             bne       noerradrson1
             movea.l   #silence,a0
             clr.w     soncour1
noerradrson1:          
             move.l    a0,ad_son1           ; pointe sur le son (sur l'en-tete)
             lea.l     loop_snd(a0),a0
             move.l    a0,ad_loop1          ; pointe sur le 1er rebouclage
             move.w    #127,d0
             movea.l   (sp)+,a1
             bra       octetvoie2




;****************************************************
; 2: la sequence est finie, on va jouer une sequence
; de silence maintenant

seq1_finie:  

; adresse de la sequence = seq_silence (pas de son)
             move.l    #seq_silence+42,ad_seq1
             move.l    #seq_silence+42,aad_seq1
             move.w    #1,nb_fois1
             move.w    #127,d0
             movea.l   (sp)+,a1
             bra       octetvoie2




;**********************************************************
; 3: la sequence reboucle : on restaure l'adresse de depart

seq1_loop:   
             move.l    aad_seq1,ad_seq1
             move.w    #1,nb_fois1
             move.w    #127,d0
             movea.l   (sp)+,a1
             bra       octetvoie2




;**********************************************************
; 4: genere une valeur aleatoire dans var_a1

seq1_a_rnd:  
             move.w    (a0)+,d1             ; min
             move.w    (a0)+,d0             ; max
             sub.w     d1,d0                ; ecart
             jsr       rnd_son
             add.w     d1,d0
             move.w    d0,var_a1
             lea.l     4(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2

;**********************************************************
; 5: genere une valeur aleatoire dans var_b1

seq1_b_rnd:  
             move.w    (a0)+,d1             ; min
             move.w    (a0)+,d0             ; max
             sub.w     d1,d0                ; ecart
             jsr       rnd_son
             add.w     d1,d0
             move.w    d0,var_b1
             lea.l     4(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2






;*********************************************************
; 6: ou 7: execute une instruction suivant
;          la contition var_a ou var_b (egal)

seq1_if_a_egal:        
             move.w    var_a1,d0
             bra.s     a1_lue0

seq1_if_b_egal:        
             move.w    var_b1,d0

a1_lue0:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             bne.s     search_endif1
             lea.l     6(a0),a0             ; pointe sur la ligne de sequence suivante
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2




search_endif1:         
             move.w    #1,nb_endif          ; nombre de ENDIF a chercher
             lea.l     6(a0),a0
l_endif1:    
             cmpi.w    #_endif,(a0)
             beq.s     endif1
             cmpi.w    #_if,(a0)
             blt.s     pas_endif1
             addq.w    #1,nb_endif
pas_endif1:  
             lea.l     10(a0),a0
             bra.s     l_endif1

endif1:      subq.w    #1,nb_endif
             bne.s     l_endif1
             lea.l     10(a0),a0
             move.l    a0,ad_seq1

; les adresses du son

             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2





;*********************************************************
; 8: ou 9: execute une instruction suivant
;          la contition var_a1 ou var_b1 (inf)

seq1_if_a_inf:         
             move.w    var_a1,d0
             bra.s     a1_lue1

seq1_if_b_inf:         
             move.w    var_b1,d0

a1_lue1:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             bge       search_endif1
             lea.l     6(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2


;*********************************************************
; 10: ou 11: execute une instruction suivant
;           la contition var_a1 ou var_b1 (sup)

seq1_if_a_sup:         
             move.w    var_a1,d0
             bra.s     a1_lue2

seq1_if_b_sup:         
             move.w    var_b1,d0

a1_lue2:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             ble       search_endif1
             lea.l     6(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2


;*********************************************************
; 12: ou 13: execute une instruction suivant
;           la contition var_a1 ou var_b1 (dif)

seq1_if_a_dif:         
             move.w    var_a1,d0
             bra.s     a1_lue3

seq1_if_b_dif:         
             move.w    var_b1,d0

a1_lue3:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             beq       search_endif1
             lea.l     6(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2



;*********************************************************
; 14: ou 15: execute une instruction suivant
;           la contition var_a1 ou var_b1 (compris entre)

seq1_if_a_entre:       
             move.w    var_a1,d0
             bra.s     a1_lue4

seq1_if_b_entre:       
             move.w    var_b1,d0

a1_lue4:     move.w    (a0)+,d1             ; valeur min a comparer
             cmp.w     d1,d0
             ble       search_endif1
             move.w    (a0),d1
             cmp.w     d1,d0
             bge       search_endif1
             lea.l     6(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2


;*********************************************************
; 16: ENDIF
;

seq1_endif:  
             lea.l     8(a0),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2



;*********************************************************
; 17: continue la sequence a un numero de ligne

seq1_goto:   
             move.w    (a0)+,d0
             move.w    d0,d1
             movea.l   aad_seq1,a0
             lsl.w     #3,d0
             add.w     d1,d1
             add.w     d1,d0
             lea.l     0(a0,d0.w),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2


;*********************************************************
; 18: ou 19: continue la sequence a un numero de ligne
;            contenu dans var_a ou var_b

seq1_goto_a: 
             move.w    var_a1,d0
             bra.s     a1_lue5
seq1_goto_b: 
             move.w    var_b1,d0
a1_lue5:     
             move.w    d0,d1
             movea.l   ad_seq1,a0
             lsl.w     #3,d0
             add.w     d1,d1
             add.w     d1,d0
             lea.l     0(a0,d0.w),a0
             move.l    a0,ad_seq1
             move.w    #127,d0
             movea.l   (sp)+,a1
             move.w    #1,nb_fois1
             bra       octetvoie2



traitevol:   
             movem.l   d0-d2,-(sp)
             move.w    #%1111000111111111,d1
             moveq.l   #9,d2
             and.w     d1,sonauto1
             and.w     d1,sonauto2
             move.w    volv1,d0
             lsl.w     d2,d0
             or.w      d0,sonauto1

             move.w    volv2,d0
             lsl.w     d2,d0
             or.w      d0,sonauto2

             moveq.l   #16,d2
             moveq.l   #1,d1
             move.w    volv1,d0
             lsl.w     d0,d1                ;d1=2^d0
             sub.w     d1,d2
             moveq.l   #1,d1
             move.w    volv2,d0
             lsl.w     d0,d1                ;d1=2^d0
             sub.w     d1,d2
             lsl.w     #7,d2
             move.w    d2,sonauto3+2
             movem.l   (sp)+,d0-d2
             rts       






;**************************************************
;                     VOIE 2
;**************************************************

;**************************************************
; gestion des rebouclages d'un son de la voie 2

rebouclages2:          
             move.l    d0,-(sp)
; ad_loop2 contient l'adresse du prochain rebouclage a jouer
             movea.l   ad_loop2,a0
             move.l    (a0)+,d0
             beq.s     son_voie2_fini

; adresse du prochain rebouclage -> d1
             add.l     ad_son2,d0
             move.l    d0,ad2+2             ; pointe sur les datas du son
             addq.l    #4,a0



; passe au donnees du rebouclage suivant
             move.l    a0,ad_loop2
             move.l    (sp)+,d0
             move.w    #127,d1
             bra       octetvoie12



;***************************************************
; le son de la voie 2 est fini
; on teste si on doit rejouer le son plusieurs fois

son_voie2_fini:        
             subq.w    #1,nb_fois2
             beq       seq2

; oui, restore l'adresse de depart du
; premier rebouclage
             movea.l   ad_son2,a0           ; pointe sur le son
             lea.l     loop_snd(a0),a0      ; pointe sur les datas du 1er "loop"
             move.l    a0,ad_loop2
             move.w    #127,d1
             move.l    (sp)+,d0
             bra       octetvoie12



;***************************************************
; gere les sequences sonores de la voie 2
; le son de la voie 2 est totalement termine
; on passe a la sequence sonore suivante

seq2:        

             move.l    a1,-(sp)
; le premier mot d'une sequence contient la commande
             movea.l   ad_seq2,a0
             move.w    (a0)+,d0
             cmpi.w    #19,d0
             bgt       bleublancrouge
             lea.l     table_inst2,a1
             move.w    d0,d1
             add.w     d1,d1
             add.w     d1,d1
             movea.l   0(a1,d1.w),a1
             jmp       (a1)




table_inst2: .DC.l seq2_play
             .DC.l seq2_play
             .DC.l seq2_finie
             .DC.l seq2_loop
             .DC.l seq2_a_rnd
             .DC.l seq2_b_rnd
             .DC.l seq2_if_a_egal
             .DC.l seq2_if_b_egal
             .DC.l seq2_if_a_inf
             .DC.l seq2_if_b_inf
             .DC.l seq2_if_a_sup
             .DC.l seq2_if_b_sup
             .DC.l seq2_if_a_dif
             .DC.l seq2_if_b_dif
             .DC.l seq2_if_a_entre
             .DC.l seq2_if_b_entre
             .DC.l seq2_endif
             .DC.l seq2_goto
             .DC.l seq2_goto_a
             .DC.l seq2_goto_b

             .DC.l seq2_finie
             .DC.l seq2_finie
             .DC.l seq2_finie
             .DC.l seq2_finie
             .DC.l seq2_finie
             .DC.l seq2_finie
             .DC.l seq2_finie




;****************************************************
; 1: joue un son sur la voie 2

seq2_play:   

; No de son (si d0=1, le No de son est aleatoire)
             move.w    (a0)+,d1             ; No de son (si fixe)
             tst.w     d0
             beq.s     no_son_fixe2         ; le No de son est fixe
             move.w    var_a2,d1            ; -> No de son
no_son_fixe2:          
             move.w    d1,soncour2
; recherche du nbre de fois
             move.w    (a0)+,nb_fois2       ; =0 -> var_b2 est le nbre de fois
             bne.s     nb_fois2_fixe1
             move.w    var_b2,nb_fois2      ; -> nb_fois2
nb_fois2_fixe1:        
             addq.l    #2,a0                ; passe la frequence et le volume

             move.l    d0,-(sp)
             move.w    (a0)+,d0             ;volume de 0 a 63
             move.w    d0,volx2
             lsr.w     #4,d0                ;0,1,2 ou 3
             andi.w    #$7,d0
             bne.s     volpas00
             moveq.l   #1,d0
volpas00:    
             cmpi.w    #3,d0
             blt.s     volinf30
             moveq.l   #3,d0
volinf30:    
             move.w    d0,volv2

             bsr       traitevol
             move.l    (sp)+,d0

             move.l    a0,ad_seq2           ; ad_seq2 = prochaine sequence

             add.w     d1,d1
             add.w     d1,d1
             lea.l     table_sons,a0
             movea.l   0(a0,d1.w),a0
             cmpa.l    #0,a0
             bne.s     noerradrson2
             movea.l   #silence,a0
             clr.w     soncour2
noerradrson2:          
             move.l    a0,ad_son2           ; pointe sur le son (sur l'en-tete)
             lea.l     loop_snd(a0),a0
             move.l    a0,ad_loop2          ; pointe sur le 1er rebouclage
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             bra       octetvoie12




;****************************************************
; 2: la sequence est finie, on va jouer une sequence
; de silence maintenant

seq2_finie:  

; adresse de la sequence = seq_silence (pas de son)
             move.l    #seq_silence+42,ad_seq2
             move.l    #seq_silence+42,aad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12




;**********************************************************
; 3: la sequence reboucle : on restaure l'adresse de depart

seq2_loop:   
             move.l    aad_seq2,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12




;**********************************************************
; 4: genere une valeur aleatoire dans var_a2

seq2_a_rnd:  
             move.w    (a0)+,d1             ; min
             move.w    (a0)+,d0             ; max
             sub.w     d1,d0                ; ecart
             jsr       rnd_son
             add.w     d1,d0
             move.w    d0,var_a2
             lea.l     4(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12

;**********************************************************
; 5: genere une valeur aleatoire dans var_b2

seq2_b_rnd:  
             move.w    (a0)+,d1             ; min
             move.w    (a0)+,d0             ; max
             sub.w     d1,d0                ; ecart
             jsr       rnd_son
             add.w     d1,d0
             move.w    d0,var_b2
             lea.l     4(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12






;*********************************************************
; 6: ou 7: execute une instruction suivant
;          la contition var_a ou var_b (egal)

seq2_if_a_egal:        
             move.w    var_a2,d0
             bra.s     a2_lue0

seq2_if_b_egal:        
             move.w    var_b2,d0

a2_lue0:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             bne.s     search_endif2
             lea.l     6(a0),a0             ; pointe sur la ligne de sequence suivante
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12




search_endif2:         
             move.w    #1,nb_endif          ; nombre de ENDIF a chercher
             lea.l     6(a0),a0
l_endif2:    
             cmpi.w    #_endif,(a0)
             beq.s     endif2
             cmpi.w    #_if,(a0)
             blt.s     pas_endif2
             addq.w    #1,nb_endif
pas_endif2:  
             lea.l     10(a0),a0
             bra.s     l_endif2

endif2:      subq.w    #1,nb_endif
             bne.s     l_endif2
             lea.l     10(a0),a0
             move.l    a0,ad_seq2

; les adresses du son
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12




;*********************************************************
; 8: ou 9: execute une instruction suivant
;          la contition var_a2 ou var_b2 (inf)

seq2_if_a_inf:         
             move.w    var_a2,d0
             bra.s     a2_lue1

seq2_if_b_inf:         
             move.w    var_b2,d0

a2_lue1:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             bge       search_endif2
             lea.l     6(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12


;*********************************************************
; 10: ou 11: execute une instruction suivant
;           la contition var_a2 ou var_b2 (sup)

seq2_if_a_sup:         
             move.w    var_a2,d0
             bra.s     a2_lue2

seq2_if_b_sup:         
             move.w    var_b2,d0

a2_lue2:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             ble       search_endif2
             lea.l     6(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12


;*********************************************************
; 12: ou 13: execute une instruction suivant
;           la contition var_a2 ou var_b2 (dif)

seq2_if_a_dif:         
             move.w    var_a2,d0
             bra.s     a2_lue3

seq2_if_b_dif:         
             move.w    var_b2,d0

a2_lue3:     move.w    (a0)+,d1             ; valeur a comparer
             cmp.w     d1,d0
             beq       search_endif2
             lea.l     6(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12



;*********************************************************
; 14: ou 15: execute une instruction suivant
;           la contition var_a2 ou var_b2 (compris entre)

seq2_if_a_entre:       
             move.w    var_a2,d0
             bra.s     a2_lue4

seq2_if_b_entre:       
             move.w    var_b2,d0

a2_lue4:     move.w    (a0)+,d1             ; valeur min a comparer
             cmp.w     d1,d0
             ble       search_endif2
             move.w    (a0),d1
             cmp.w     d1,d0
             bge       search_endif2
             lea.l     6(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12


;*********************************************************
; 16: ENDIF
;

seq2_endif:  
             lea.l     8(a0),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12



;*********************************************************
; 17: continue la sequence a un numero de ligne

seq2_goto:   
             move.w    (a0)+,d0
             move.w    d0,d1
             movea.l   aad_seq2,a0
             lsl.w     #3,d0
             add.w     d1,d1
             add.w     d1,d0
             lea.l     0(a0,d0.w),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12


;*********************************************************
; 18: ou 19: continue la sequence a un numero de ligne
;            contenu dans var_a ou var_b

seq2_goto_a: 
             move.w    var_a2,d0
             bra.s     a2_lue5
seq2_goto_b: 
             move.w    var_b2,d0
a2_lue5:     
             move.w    d0,d1
             movea.l   ad_seq2,a0
             lsl.w     #3,d0
             add.w     d1,d1
             add.w     d1,d0
             lea.l     0(a0,d0.w),a0
             move.l    a0,ad_seq2
             move.w    #127,d1
             movea.l   (sp)+,a1
             move.l    (sp)+,d0
             move.w    #1,nb_fois2
             bra       octetvoie12





;**********************************************************
; joue une sequence sur la voie 1 ou 2
;
; -> ad_seq: adresse de la sequence
; -> novoie: No de la voie (1 ou 2)
;

play_seq:    
             tst.w     sonon
             beq       playsilence
play_seqs:   

             cmpi.w    #1,novoie
             bne       play_seq_voie2

; sequence sur la voie 1

             movea.l   ad_seq,a0
             lea.l     42(a0),a0
             move.l    a0,ad_seq1
             move.l    a0,aad_seq1
             move.w    #1,nb_fois1
             movea.l   #silence,a0          ; pointe sur le son silence
             lea.l     loop_snd(a0),a0      ; pointe sur les datas du 1er "loop"
             lea.l     8(a0),a0             ; pointe sur le 2eme "loop" (=0)
             move.l    a0,ad_loop1          ; (a0)=0, donc a la prochaine IT on ira initialiser
; les adresses du son

             move.l    #silence_data,ad1+2
             move.l    #silence,ad_son1

             rts       


; sequence sur la voie 2

play_seq_voie2:        
; sequence sur la voie 2

             movea.l   ad_seq,a0
             lea.l     42(a0),a0
             move.l    a0,ad_seq2
             move.l    a0,aad_seq2
             move.w    #1,nb_fois2
             movea.l   #silence,a0          ; pointe sur le son silence
             lea.l     loop_snd(a0),a0      ; pointe sur les datas du 1er "loop"
             lea.l     8(a0),a0             ; pointe sur le 2eme "loop" (=0)
             move.l    a0,ad_loop2          ; (a0)=0, donc a la prochaine IT on ira initialiser


             move.l    #silence_data,ad2+2
             move.l    #silence,ad_son2

; les adresses du son

             rts       


;******************************************************
; creation d'un nombre aleatoire pour les SONS
; -> d0 : borne maxi
;
; <- d0 : valeur aleatoire sur 16 bits
rnd_son:     
             move.l    d6,-(sp)
             move.w    d2,-(sp)
             move.w    d1,-(sp)

             move.w    d0,d1
             move.l    #$10000,d6
             addq.w    #1,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0
             divu.w    d0,d6

             move.w    contvbl+2,d0
             eori.w    #$1234,d0
             move.w    exalea_son,d2
             addq.w    #1,d2
             mulu.w    d2,d0
             lsr.l     #4,d0
             move.w    d0,exalea_son

             swap.w    d0
             clr.w     d0
             swap.w    d0
             swap.w    d6
             clr.w     d6
             swap.w    d6
             divu.w    d6,d0
             cmp.w     d0,d1
             bge.s     bugaleason
             move.w    d1,d0
bugaleason:  
             move.w    (sp)+,d1
             move.w    (sp)+,d2
             move.l    (sp)+,d6
             rts       


borne_maxi:  .DC.w 0
exalea_son:  .DC.w $1234




;*********************************************
; joue un SON sur la voie 1 ou 2
;
;
; -> noinst : No de l'instruction (0: normal / 1: aleatoire)
; -> novoie : No de la voie (1 ou 2)
; -> noson1 : No du son 1
; -> noson2 : No du son 2 (utilise si aleatoire)
;
; <- noson1: No du son joue (si on demandait un aleatoire)
; <- err_son = 1 : instruction inconuue
;              2 : son pas trouve


play_son:    
             movem.l   d0-d2,-(sp)
             clr.w     err_son
; teste l'instruction choisie
             tst.w     noinst
             beq.s     play_son_normal
             cmpi.w    #1,noinst
             beq.s     play_son_rnd
; instruction inconnue
             move.w    #1,err_son
             movem.l   (sp)+,d0-d2
             rts       

;********************************************
; joue un son aleatoire

play_son_rnd:          

;              move.w   noson1,d1      ; mini
;              move.w   noson2,d0      ; maxi
;              sub.w    d1,d0
;              jsr      rnd_son
;              add.w    d1,d0
;              move.w   d0,noson1      ; No du son a jouer

;********************************************

play_son_normal:       

; calcule l'adresse du son
             move.w    noson1,d1
             move.w    d1,d0
             lea.l     table_sons,a0
             add.w     d1,d1
             add.w     d1,d1
             movea.l   0(a0,d1.w),a0


; teste le No de voie
             cmpi.w    #1,novoie
             bne.s     play_son_voie2

; teste si le son existe
             cmpa.l    #0,a0
             beq       finplay_son0


; on lance le son sur la voie 1

             move.w    d0,soncour1

             move.l    a0,ad_son1
; calcule l'adresse des datas du 1er rebouclage
             move.l    loop_snd(a0),ad1+2
; calcule l'adresse du rebouclage (dans l'en-tete)
             lea.l     loop_snd(a0),a0
             move.l    a0,ad_loop1
; joue le bruitage 1 fois
             move.w    #1,nb_fois1
finplay_son: 
             movem.l   (sp)+,d0-d2
             rts       
finplay_son0:          
             clr.w     soncour1
             movem.l   (sp)+,d0-d2
             rts       

; on lance le son sur la voie 2

play_son_voie2:        

; teste si le son existe
             cmpa.l    #0,a0
             beq       finplay_son20

             move.w    d0,soncour2

             move.l    a0,ad_son2
; calcule l'adresse des datas du 1er rebouclage
             move.l    loop_snd(a0),ad2+2
; calcule l'adresse du rebouclage (dans l'en-tete)
             lea.l     loop_snd(a0),a0
             move.l    a0,ad_loop2
; joue le bruitage 1 fois
             move.w    #1,nb_fois2
             movem.l   (sp)+,d0-d2
             rts       
finplay_son20:         
             clr.w     soncour2
             movem.l   (sp)+,d0-d2
             rts       

;---------------------------------------------------------------
;
; play_son_bob
;
; entree:     a0 adresse du son
;

play_son_bob::         

; on lance le son sur la voie 1

             move.l    a0,ad_son1
; calcule l'adresse des datas du 1er rebouclage
             move.l    loop_snd(a0),ad1+2
; calcule l'adresse du rebouclage (dans l'en-tete)
             lea.l     loop_snd(a0),a0
             move.l    a0,ad_loop1
; joue le bruitage 1 fois
             move.w    #3,nb_fois1
             rts       





ad_seq:      .DC.l 0
noinst:      .DC.w 0
novoie:      .DC.w 0
noson1:      .DC.w 0
noson2:      .DC.w 0
err_son:     .DC.w 0






;*******************************************
;

ad_son1:     .DC.l silence
ad_seq1:     .DC.l seq_silence+42
ad_loop1:    .DC.l silence_loop
aad_seq1:    .DC.l seq_silence+42
nb_fois1:    .DC.w 1

var_a1:      .DC.w 0
var_b1:      .DC.w 0


ad_son2:     .DC.l silence
ad_seq2:     .DC.l seq_silence+42
ad_loop2:    .DC.l silence_loop
aad_seq2:    .DC.l seq_silence+42
nb_fois2:    .DC.w 1

var_a2:      .DC.w 0
var_b2:      .DC.w 0

nb_endif:    .DC.w 0



;---------------------------------------------------------------
;
; putclip
;
; entree:  a0 pointe sur le motif
;          a1 pointe sur la memoire
;

putclip:     
             cmp.w     coinx,d7
             blt       rts
             move.w    xaff,d4
             lsl.w     #4,d4
             add.w     coinx,d4
             cmp.w     d4,d7
             bge       rts

             move.b    (a0),d0
             move.b    2(a0),d1
             move.b    4(a0),d2
             move.b    6(a0),d3
             move.w    d0,d4
             or.w      d1,d4
             or.w      d2,d4
             or.w      d3,d4
             not.w     d4

             and.b     d4,(a1)
             and.b     d4,2(a1)
             and.b     d4,4(a1)
             and.b     d4,6(a1)

             or.b      d0,(a1)
             or.b      d1,2(a1)
             or.b      d2,4(a1)
             or.b      d3,6(a1)
             rts       


;---------------------------------------------------------------
;
; pileouface
;
; place le Bit Z alealatoirement a 0 ou 1
;
; tous les registres sont sauvegardes
;

pileouface:  
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #1,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

;---------------------------------------------------------------
;
; findinlist
;
; trouve si un point est contenu dans une liste de rectangles
;
; entree:     d0 x
;             d1 y
;             a0 adresse de la liste (x1,y1,x2,y2,...,-1)
;
; retour:     d7 numero du bloc (-1 si aucun)
;

findinlist:  
             move.w    d0,d4
             move.w    d1,d5
             moveq.l   #0,d7
fil0:        
             move.w    (a0)+,d0
             blt.s     fil1
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       inbloc
             movem.l   (sp)+,d0-d7/a0-a6
             beq       rts
             addq.w    #1,d7
             bra.s     fil0
fil1:        
             moveq.l   #-1,d7
             rts       
;---------------------------------------------------------------
;
; findinlist2
;
; trouve si un point est contenu dans une liste de rectangles
;
; entree:     d0 x
;             d1 y
;             a0 adresse de la liste (x1,y1,x2,y2,c,...,-1)
;
; retour:     d7 numero du bloc (-1 si aucun)
;

findinlist2: 
             move.w    d0,d4
             move.w    d1,d5
             moveq.l   #0,d7
fil0x:       
             move.w    (a0)+,d0
             blt.s     fil1x
             move.w    (a0)+,d1
             move.w    (a0)+,d2
             move.w    (a0)+,d3
             cmpi.w    #10,(a0)+            ;couleur
             bne       fil0x

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       inbloc
             movem.l   (sp)+,d0-d7/a0-a6
             beq       rts
             addq.w    #1,d7
             bra.s     fil0x
fil1x:       
             moveq.l   #-1,d7
             rts       

;videopbox

;---------------------------------------------------------------
;
; inbloc
;
; recherche si le point x',y' est contenu dans le rctange x1,y1,x2,y2
;
; entree:     d0 x1
;             d1 y1
;             d2 x2
;             d3 y2
;             d4 x'
;             d5 y'
;
; retour:     Z=1 si le point est contenu
;

inbloc:      
             cmp.w     d0,d4
             blt.s     outbloc
             cmp.w     d2,d4
             bgt.s     outbloc
             cmp.w     d1,d5
             blt.s     outbloc
             cmp.w     d3,d5
             bgt.s     outbloc
             moveq.l   #0,d0
             rts       
outbloc:     
             moveq.l   #-1,d0
             rts       

;---------------------------------------------------------------
;
; bintoascii
;
; converti un nombre 16bits en une chaine ascii de taille variable
; (les '0' de debut sont supprimes)
; la chaine se termine par 0
;
; entree:     d0 nombre
;             a0 adresse de la chaine
;

bintoascii:  
             swap.w    d0
             clr.w     d0
             swap.w    d0

             divu.w    #10,d0
             swap.w    d0
             move.w    d0,d1                ;unites
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             swap.w    d0
             move.w    d0,d2                ;dizaine
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             swap.w    d0
             move.w    d0,d3                ;centaine
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             swap.w    d0
             move.w    d0,d4                ;millier
             clr.w     d0
             swap.w    d0
             divu.w    #10,d0
             swap.w    d0
             move.w    d0,d5                ;dix-mille

             tst.w     d5
             bne.s     bta5
             tst.w     d4
             bne.s     bta4
             tst.w     d3
             bne.s     bta3
             tst.w     d2
             bne.s     bta2
             bra.s     bta1

bta5:        
             addi.b    #'0',d5
             move.b    d5,(a0)+
bta4:        
             addi.b    #'0',d4
             move.b    d4,(a0)+
bta3:        
             addi.b    #'0',d3
             move.b    d3,(a0)+
bta2:        
             addi.b    #'0',d2
             move.b    d2,(a0)+
bta1:        
             addi.b    #'0',d1
             move.b    d1,(a0)+
             clr.b     (a0)+                ;fin de chaine
             rts       

;---------------------------------------------------------------
;
; bintoascii2
;
; converti un nombre 32bits en une chaine ascii de taille variable
; (les '0' de debut sont supprimes)
; la chaine est justifiee a droite (10 caracteres)
;
; entree:     d0.l nombre
;             a0 adresse de la chaine
;
; ne pas effacer a2
;

bintoascii2: 
             moveq.l   #0,d7
             moveq.l   #9,d1
             lea.l     tabrang(pc),a1
rang:        move.l    (a1)+,d3
             move.l    #$d0,d2
soust1:      sub.l     d3,d0
             dbmi      d2,soust1
             neg.b     d2
             cmpi.b    #'0',d2
             beq.s     bta20
bta22:       
             moveq.l   #-1,d7               ;ne plus effacer les 0
             move.b    d2,(a0)+
bta21:       
             add.l     d3,d0
             dbra      d1,rang
             rts       
bta20:       
             tst.w     d7
             blt       bta22
             addq.w    #1,a0
             bra.s     bta21

;---------------------------------------------------------------
;
; bintoascii3
;
; converti un nombre 32bits en une chaine ascii de taille variable
; (les '0' de debut sont supprimes)
; la chaine est justifiee a gauche
; un 0 (/n) est place en fin de chaine
;
; entree:     d0.l nombre
;             a0 adresse de la chaine
;

bintoascii3: 
             moveq.l   #0,d7
             moveq.l   #9,d1
             lea.l     tabrang(pc),a1
rang3:       move.l    (a1)+,d3
             move.w    #$d0,d2
soust13:     sub.l     d3,d0
             dbmi      d2,soust13
             neg.b     d2
             cmpi.b    #'0',d2
             beq.s     bta203
bta223:      
             moveq.l   #-1,d7               ;ne plus effacer les 0
             move.b    d2,(a0)+
bta213:      
             add.l     d3,d0
             dbra      d1,rang3
             clr.b     (a0)+
             rts       
bta203:      
             tst.w     d7
             blt       bta223
             bra.s     bta213

tabrang:     
             .DC.l 1000000000
             .DC.l 100000000
             .DC.l 10000000
             .DC.l 1000000
             .DC.l 100000
             .DC.l 10000
             .DC.l 1000
             .DC.l 100
             .DC.l 10
             .DC.l 1







;**********************************************************
;*** PERSOPRINC                                         ***
;***                     Gestion du perso joueur        ***
;***                                                    ***
;**********************************************************

persoprinc:  

;gestion de la duree d'action des substances

             lea.l     substance,a0
             lea.l     substvbl,a1
             moveq.l   #5-1,d7
ppsubl:      
             tst.w     (a0)
             beq       ppsub0
             tst.l     (a1)
             bne       ppsub1
;la substance est a '1' et vbl=0

;la substance passe a '1'

             move.l    contvbl,(a1)
             addi.l    #vblsubstance,(a1)
             cmpa.l    #morphvbl,a1
             bne       ppsub200
             jsr       swaplove
             bra       ppsub2
ppsub200:    
             cmpa.l    #ats34vbl,a1
             bne       ppsub2
;sommeil+1heure
             move.w    _sommeil,d0
             addi.w    #60,d0
             move.w    #12*60,d1
             jsr       min
             move.w    d0,_sommeil
             bra       ppsub2

ppsub0:      
;la substance est a '0'

             tst.l     (a1)
             beq       ppsub2               ;rien a faire...

;la substance passe a '0'


             clr.l     (a1)
             cmpa.l    #morphvbl,a1
             bne       ppsub201

             jsr       swaplove
             bra       ppsub2
ppsub201:    
             cmpa.l    #ats34vbl,a1
             bne       ppsub2
;sommeil -2heures
             move.w    _sommeil,d0
             subi.w    #120,d0
             moveq.l   #0,d1
             jsr       maxs
             move.w    d0,_sommeil
             bra       ppsub2
ppsub1:      
;la substance est a '1' et vbl<>0

             move.l    contvbl,d0
             cmp.l     (a1),d0
             blt       ppsub2               ;rien a changer, substance tjs active

;la substance passe  a '0'

             clr.l     (a1)
             clr.w     (a0)
             cmpa.l    #morphvbl,a1
             bne       ppsub202
             jsr       swaplove
             bra       ppsub2

ppsub202:    
             cmpa.l    #ats34vbl,a1
             bne       ppsub2
;sommeil -2heures
             move.w    _sommeil,d0
             subi.w    #120,d0
             moveq.l   #0,d1
             jsr       maxs
             move.w    d0,_sommeil

             bra       ppsub2
ppsub2:      

             addq.l    #2,a0
             addq.l    #4,a1

             dbra      d7,ppsubl


; gestion des consommations

;bob
             move.l    contvbl,d0
             sub.l     bobconsvbl,d0
             mulu.w    bobcons,d0
             divu.w    #21846,d0
             bvs       overflow
             tst.w     d0
             beq.s     bobc0

             lea.l     faim,a0
             bsr       sousd0

             move.l    contvbl,bobconsvbl
bobc0:       

;soif

             move.l    contvbl,d0
             sub.l     soifvbl,d0
             add.l     d0,d0                ;*2
             divu.w    #21*24,d0
             bvs       overflow
             cmpi.w    #10,d0
             blt       sensib0              ;pas assez de variation: on ne fait rien
             bsr       modifconso
             lea.l     soif,a0
             bsr       sousd0
             move.l    contvbl,soifvbl
sensib0:     

;faim

             move.l    contvbl,d0
             sub.l     faimvbl,d0
             move.l    d0,d1
             add.l     d0,d0
             add.l     d1,d0                ;*3
             divu.w    #21*24,d0
             bvs       overflow
             cmpi.w    #10,d0
             blt       sensib1              ;pas assez de variation: on ne fait rien
             bsr       modifconso
             lea.l     faim,a0
             bsr       sousd0
             move.l    contvbl,faimvbl
sensib1:     

;sommeil

             move.l    contvbl,d0
             sub.l     sommeilvbl,d0
             divu.w    #1400,d0
             bvs       overflow
             cmpi.w    #10,d0
             blt       sensib2              ;pas assez de variation: on ne fait rien
             bsr       modifconso
             lea.l     _sommeil,a0
             bsr       sousd0
             move.l    contvbl,sommeilvbl
sensib2:     


;calcul de la force

             bsr       nbbitetat

             addq.w    #4,d0
             mulu.w    #2059,d0             ;d0.w = diviseur

             moveq.l   #0,d1
             move.b    jehan+forc_p,d1
             mulu.w    soif,d1
             lsr.l     #4,d1
             mulu.w    faim,d1
             lsr.l     #6,d1
             lsr.l     #6+2,d1

             move.w    vitcardinit,d2
             lsr.w     #1,d2                ;1,2 ou 3
             mulu.w    d2,d1

             mulu.w    _sommeil,d1
             lsr.l     #3-2,d1


             divu.w    d0,d1

             moveq.l   #0,d2
             move.b    jehan+forc_p,d2
             cmp.w     d1,d2
             bgt       fpsfc                ;force potentielle > a force courante
             move.w    d2,d1
fpsfc:       
             addq.w    #1,forcdiv16
             andi.w    #$f,forcdiv16
             bne.s     fpsfc0

             cmp.b     jehan+forc_c,d1
             beq.s     fpsfc0
             bhi.s     fplus

             subq.b    #1,jehan+forc_c

             bra.s     fpsfc0
fplus:       
             addq.b    #1,jehan+forc_c

fpsfc0:      

;calcul de l'intelligence

             moveq.l   #0,d0
             move.b    jehan+inte_p,d0
             move.w    _sommeil,d1
             addi.w    #3*60,d1
             mulu.w    d0,d1
             divu.w    #6*60,d1

             moveq.l   #0,d2
             move.b    jehan+inte_p,d2
             cmp.w     d1,d2
             bgt       ffpsfc0
             move.w    d2,d1
ffpsfc0:     
             move.b    d1,jehan+inte_c


;calcul des reflexes

             moveq.l   #0,d7
             move.b    jehan+refl_p,d7

             move.w    _sommeil,d0
             addi.w    #90,d0
             move.w    #6*60,d1
             jsr       min
             mulu.w    d0,d7
             lsr.l     #1,d7

             move.w    vitcardinit,d0
             lsr.w     #1,d0
             mulu.w    d0,d7
             lsr.l     #1,d7

             move.w    faim,d0
             addi.w    #1000,d0
             move.w    #3000,d1
             jsr       min
             mulu.w    d0,d7
             lsr.l     #6,d7
             lsr.l     #6,d7

             move.w    soif,d0
             addi.w    #700,d0
             move.w    #2000,d1
             jsr       min

             mulu.w    d0,d7
             lsr.l     #4,d7
             divu.w    #16479,d7

             moveq.l   #0,d2
             move.b    jehan+refl_p,d2
             cmp.w     d7,d2
             bgt       fpsfc1
             move.w    d2,d7
fpsfc1:      
             addq.w    #1,refldiv16
             andi.w    #$f,refldiv16
             bne.s     rfpsfc0
             cmp.b     jehan+refl_c,d7
             beq.s     rfpsfc0
             bhi.s     rfplus

             subq.b    #1,jehan+refl_c

             bra.s     rfpsfc0
rfplus:      
             addq.b    #1,jehan+refl_c
rfpsfc0:     

;calcul de la vitalite

             move.b    jehan+vita_p,jehan+vita_c

;calcul de la perception

             moveq.l   #0,d7
             move.b    jehan+perc_p,d7

             move.w    _sommeil,d0
             addi.w    #90,d0
             move.w    #6*60,d1
             jsr       min
             mulu.w    d0,d7
             lsr.l     #1,d7

;              move.w   vitcardinit,d0
;             lsr.w    #1,d0
;            mulu.w   d0,d7
;           lsr.l    #1,d7

             move.w    faim,d0
             addi.w    #1000,d0
             move.w    #3000,d1
             jsr       min
             mulu.w    d0,d7
             lsr.l     #6,d7
             lsr.l     #6,d7

             move.w    soif,d0
             addi.w    #700,d0
             move.w    #2000,d1
             jsr       min

             mulu.w    d0,d7
             lsr.l     #4,d7
             divu.w    #16479,d7

             moveq.l   #0,d2
             move.b    jehan+perc_p,d2
             cmp.w     d7,d2
             bgt       fpsfc2
             move.w    d2,d7
fpsfc2:      
             move.b    d7,jehan+perc_c

;calcul du charisme

             move.b    jehan+char_p,jehan+char_c


; on modifie les 6 caracteristiques en fonction des implants

             tst.w     hypercep
             beq       mo6ca0

             moveq.l   #0,d0
             move.b    jehan+refl_c,d0
             add.w     d0,d0
             moveq.l   #100,d1
             jsr       min
             move.b    d1,jehan+refl_c

             moveq.l   #0,d0
             move.b    jehan+perc_c,d0
             add.w     d0,d0
             moveq.l   #100,d1
             jsr       min
             move.b    d1,jehan+perc_c


mo6ca0:      
             tst.w     morphol7
             beq       mo6ca1

             moveq.l   #0,d0
             move.b    jehan+char_c,d0
             add.w     d0,d0
             moveq.l   #100,d1
             jsr       min
             move.b    d1,jehan+char_c

mo6ca1:      
             tst.w     psy
             beq       mo6ca2

             moveq.l   #0,d0
             move.b    jehan+inte_c,d0
             add.w     d0,d0
             moveq.l   #100,d1
             jsr       min
             move.b    d1,jehan+inte_c

mo6ca2:      

;on fait baisser potvie

             bsr       nbbitetat
             lea.l     jehan+forc_c,a0
             moveq.l   #6-1,d7
mo6ca3:      
             tst.b     (a0)+
             bne       mo6ca4
             addq.w    #1,d0
mo6ca4:      
             dbra      d7,mo6ca3

             move.w    d0,d1
             move.l    contvbl,d0
             sub.l     potvievbl,d0
             mulu.w    d1,d0

             divu.w    #21000,d0
             bvs       overflow
             tst.w     d0
             beq       sensib10

             lea.l     jehan+potvie,a0
             bsr       sousd0
             move.l    contvbl,potvievbl
sensib10:    


; on calcule le nombre de bits soignes (ETAT)

             move.l    contvbl,d0
             sub.l     etatvbl,d0
             lsr.l     #8,d0
             moveq.l   #0,d1
             move.b    jehan+vita_c,d1
             mulu.w    d1,d0
             divu.w    #24609,d0
             tst.w     d0
             beq       sensib11
             move.l    contvbl,etatvbl
             tst.w     fibrine
             beq.s     oncano0
             add.w     d0,d0
oncano0:     
             move.w    jehan+etat_evi,d6
             moveq.l   #16-1,d7
oncano1:     
             bclr      d7,d6
             beq.s     oncano2
             subq.w    #1,d0
             beq.s     oncano3
oncano2:     
             dbra      d7,oncano1
oncano3:     
             move.w    d6,jehan+etat_evi

sensib11:    

             rts       

;---------------------------------------------------------------
;
; sousd0
;

sousd0:      
             cmp.w     (a0),d0
             blt       sousd00
             clr.w     (a0)
             rts       
sousd00:               ;te
             sub.w     d0,(a0)
             rts       




overflow:    
             jmp       noirjaune

;---------------------------------------------------------------
;
; nbbitetat
;
; retour: d0 = nombre de bits a 1 dans ETAT
;
; tous les registres sont sauvegardes
;

nbbitetat:   
             movem.l   d1-d7/a0-a6,-(sp)
             move.w    jehan+etat_evi,d7
             moveq.l   #0,d0
             moveq.l   #16-1,d6
nbbi0:       
             btst      d6,d7
             beq.s     nbbi1
             addq.w    #1,d0
nbbi1:       
             dbra      d6,nbbi0
             movem.l   (sp)+,d1-d7/a0-a6
             rts       

;---------------------------------------------------------------
;
; modifconso
;
; entree:     d0 consommation
;
; retour:     d0 consommation*coef
;
; tous les registres sont sauvegardes
;

modifconso:  
             movem.l   d1-d7/a0-a6,-(sp)

             move.w    vitcardinit,d7
             lsr.w     #1,d7                ; 1,2 ou 3

             lea.l     substance,a0
             moveq.l   #5-1,d6
moco0:       
             tst.w     (a0)+
             beq.s     moco1
             addq.w    #1,d7
moco1:       
             dbra      d6,moco0

             mulu.w    d7,d0
             lsr.w     #1,d0                ;valeur nominale rythme=2
             movem.l   (sp)+,d1-d7/a0-a6

             rts       


; ********************************************************
; *                                                      *
; *                DONNEES du BIOGAME                    *
; *                                                      *
; *         Copyrights 1991 Computer's Dream             *
; *                                                      *
; *                                                      *
; ********************************************************
;
; - "nom"      (.B): Nom de l'evi , 10 cartacteres
;
; - "racesexe" (.B):  |   b7   |   b6 .. b0  |
;                        Sexe        Race
;                   0=male,1=femelle
;
; - "age"      (.B): age en années terrestres
;
; - "posevi"   (.W):
;
; - "calories" (.W): consommation en calories par jour
;                    varit de 0 à 4000 cal
;
; - "hygro"    (.W): deshydratation par jour
;                    varit de 0 à 4000 millilitre
;
; - "sommeil"  (.W): besoin en repos en minutes par jour
;                    varit de 0 à 12 heures (720 mn)
;
; - "potvie"   (.W): Potentiel de vie 0% à 99%
;
; - "etat_evi" (.W): Inventaire des organes touchés
;                    |b15 .. b7| b6 | b5 | b4 | b3 | b2 |b1 | b0 |
;                     inutilisé   |    |    |    |    |   |    |
;                             j.gauche |    |    |    |   |    |
;                                  j.droite |    |    |   |    |
;                                       b.gauche |    |   |    |
;                                             b.droit |   |    |
;                                                  Abdomen|    |
;                                                       Torse  |
;                                                             Tete
;
; Caracteristique potentielle de l'EVI
; --------------------------------------
; C'est la caracteristique maximale qu'un individu peut atteindre
; par rapport à ses propres capacités.
;
; Caracteristique courante de l'EVI
; -----------------------------------
; C'est la caracteristique variant de 0 à la caracteristique
; potentielle.
;
;
;
; -------------------------------------------------
; Definition de la structure EVI du joueur
;
nom          equ 0     ; nom (10 caracteres)racesexe:  equ     10              ; sexe (b7) / race (b6-b0)
racesexe     equ 10
age          equ 11
posevi       equ 12
calories     equ 14    ; (cal / jour)
hygro        equ 16    ; (mil / jour)
sommeil      equ 18    ; (min / jour) de repos
potvie       equ 20    ; 0 à 99
; caracteristiques potentielles
forc_p       equ 22
inte_p       equ 23
vita_p       equ 24
perc_p       equ 25
refl_p       equ 26
char_p       equ 27
; caracteristiques courantes
forc_c       equ 28
inte_c       equ 29
vita_c       equ 30
perc_c       equ 31
refl_c       equ 32
char_c       equ 33
; etat de l'EVI
etat_evi     equ 34









;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;                      DIVERS
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------

scenatstbit: 
             lea.l     scenario,a0
;---------------------------------------------------------------
;
; tstbitfield
;
; teste un bit dans un champ de bits
;
; entree:     d0 numero du bit
;             a0 adresse de debut du champ
;
; retour:     Z=1 si le bit est a 0
;             Z=0 si le bit est a 1
;

tstbitfield: 
             move.w    d0,d1
             andi.w    #$7,d0               ;reste de la division par 8
             lsr.w     #3,d1
             adda.w    d1,a0
             neg.w     d0
             addq.w    #7,d0
             btst      d0,(a0)
             rts       


scenasetbit: 
             lea.l     scenario,a0
;---------------------------------------------------------------
;
; setbitfield
;
; positionne et teste un bit dans un champ de bits
;
; entree:     d0 numero du bit
;             a0 adresse de debut du champ
;
; retour:     Z=1 si le bit etait a 0
;             Z=0 si le bit etait a 1
;

setbitfield: 
             move.w    d0,d1
             andi.w    #$7,d0               ;reste de la division par 8
             lsr.w     #3,d1
             adda.w    d1,a0
             neg.w     d0
             addq.w    #7,d0
             bset      d0,(a0)
             rts       



scenaclrbit: 
             lea.l     scenario,a0
;---------------------------------------------------------------
;
; clrbitfield
;
; efface et teste un bit dans un champ de bits
;
; entree:     d0 numero du bit
;             a0 adresse de debut du champ
;
; retour:     Z=1 si le bit etait a 0
;             Z=0 si le bit etait a 1
;

clrbitfield: 
             move.w    d0,d1
             andi.w    #$7,d0               ;reste de la division par 8
             lsr.w     #3,d1
             adda.w    d1,a0
             neg.w     d0
             addq.w    #7,d0
             bclr      d0,(a0)
             rts       

scenachgbit: 
             lea.l     scenario,a0
;---------------------------------------------------------------
;
; chgbitfield
;
; inverse et teste un bit dans un champ de bits
;
; entree:     d0 numero du bit
;             a0 adresse de debut du champ
;
; retour:     Z=1 si le bit etait a 0
;             Z=0 si le bit etait a 1
;

chgbitfield: 
             move.w    d0,d1
             andi.w    #$7,d0               ;reste de la division par 8
             lsr.w     #3,d1
             adda.w    d1,a0
             neg.w     d0
             addq.w    #7,d0
             bchg      d0,(a0)
             rts       

;---------------------------------------------------------------
;
; debloc
;

debloc:      
             lea.l     souri_13,a0
             move.w    #0,(a0)+
             move.w    #yorg,(a0)+
             move.w    #319-16,(a0)+
             move.w    #yorg+160-16,(a0)+
             rts       
;---------------------------------------------------------------
;
; fulldebloc
;

fulldebloc:  
             lea.l     souri_13,a0
             move.w    #0,(a0)+
             move.w    #0,(a0)+
             move.w    #319-16,(a0)+
             move.w    #yorg+160-16,(a0)+
             rts       

;---------------------------------------------------------------
;
; affvideo
;
; entree:     d0 x
;             d1 y
;

affvideo:    
             move.w    #videox,d0
             move.w    #videoy,d1

             move.w    d0,d6
             move.w    d1,d7
             lea.l     videopbox,a6
av0:         
             move.w    (a6)+,d0
             blt       av1
             move.w    (a6)+,d1
             move.w    (a6)+,d2
             move.w    (a6)+,d3
             move.w    (a6)+,d4
             add.w     d6,d0
             add.w     d6,d2
             add.w     d7,d1
             add.w     d7,d3

             movem.l   d0-d7/a0-a6,-(sp)
             JSR_PBOX 
             movem.l   (sp)+,d0-d7/a0-a6
             bra.s     av0
av1:         
             lea.l     videoligne0,a6
             moveq.l   #0,d4
av2:         
             move.w    (a6)+,d0
             blt       av3
             move.w    (a6)+,d1
             move.w    (a6)+,d2
             move.w    (a6)+,d3
             add.w     d6,d0
             add.w     d6,d2
             add.w     d7,d1
             add.w     d7,d3

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6
             bra.s     av2
av3:         
             lea.l     videoligne6,a6
             moveq.l   #6,d4
av4:         
             move.w    (a6)+,d0
             blt       av5
             move.w    (a6)+,d1
             move.w    (a6)+,d2
             move.w    (a6)+,d3
             add.w     d6,d0
             add.w     d6,d2
             add.w     d7,d1
             add.w     d7,d3

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6
             bra.s     av4
av5:         
             lea.l     videotxy,a6
             lea.l     videot,a5
             moveq.l   #1,d3
             move.w    #160,d4
             movea.l   sys01,a1
av6:         
             move.w    (a6)+,d1
             blt       av7
             move.w    (a6)+,d2
             add.w     d6,d1
             add.w     d7,d2

             movea.l   a5,a0
             addq.l    #2,a5
             movem.l   d0-d7/a0-a6,-(sp)
             JSR_TEXTX 
             movem.l   (sp)+,d0-d7/a0-a6
             bra.s     av6
av7:         
             lea.l     videoligne15,a6
             moveq.l   #15,d4
av8:         
             move.w    (a6)+,d0
             blt       av9
             move.w    (a6)+,d1
             move.w    (a6)+,d2
             move.w    (a6)+,d3
             add.w     d6,d0
             add.w     d6,d2
             add.w     d7,d1
             add.w     d7,d3

             movem.l   d0-d7/a0-a6,-(sp)
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6
             bra.s     av8
av9:         
             move.l    adrevicour,d0
             beq       rts
             movea.l   d0,a0
             move.l    evicodegen(a0),d0

             jsr       makeperso

;buggfa        equ 32/2*5

             jsr       clipoff
             lea.l     perso+buggfa,a0
             movea.l   sys01,a1
             move.w    #32,d2
             move.w    #30,d3
             move.w    #160,d4

             move.w    #videox+40,d0
             move.w    #videoy+7,d1
             jmp       puttcx





videopbox:   .DC.w 2,2,109,117,5
vpbecran:    .DC.w 10,7,102,36,2
             .DC.w 66,70,76,80,10           ;0
             .DC.w 21,55,31,65,10           ;1
             .DC.w 36,55,46,65,10           ;2
             .DC.w 51,55,61,65,10           ;3
             .DC.w 21,70,31,80,10           ;4
             .DC.w 36,70,46,80,10           ;5
             .DC.w 51,70,61,80,10           ;6
             .DC.w 21,85,31,95,10           ;7
             .DC.w 36,85,46,95,10           ;8
             .DC.w 51,85,61,95,10           ;9

             .DC.w 66,85,91,95,10           ;ok
             .DC.w 66,55,76,65,10           ;>m
             .DC.w 81,55,91,65,10           ;<m
             .DC.w 81,70,91,80,10           ;<-
             .DC.w -1
videoligne0: 
             .DC.w 0,0,111,0,0,0,0,119,0,119,111,119,111,0,111,119
             .DC.w 9,6,102,6,9,6,9,36,9,43,102,43,9,43,9,108,20,54,32,54
             .DC.w 20,54,20,66,35,54,47,54,35,54,35,66,50,54,62,54
             .DC.w 50,54,50,66,65,54,77,54,65,54,65,66,80,54,92,54,80,54,80,66
             .DC.w 20,69,32,69,20,69,20,81,35,69,47,69,35,69,35,81,50,69,62,69
             .DC.w 50,69,50,81,65,69,77,69,65,69,65,81,80,69,92,69,80,69,80,81
             .DC.w 20,84,32,84,20,84,20,96,35,84,47,84,35,84,35,96,50,84,62,84
             .DC.w 50,84,50,96,65,84,92,84,65,84,65,96,-1

videoligne6: 
             .DC.w 3,3,107,3,3,3,3,115,8,5,102,5,8,5,8,37,8,42,102,42,8,42,8,108
             .DC.w 10,44,102,44,10,44,10,108,110,1,110,118,1,118,110,118,-1

videotxy:    
             .DC.w 24,58,39,58,54,58,24,73,39,73,54,73,24,88,39,88,54,88,69,73
             .DC.w 73,88,79,88
             .DC.w 66,58,72,58,81,58,87,58,84,73,86,73,-1

videot:      
             .DC.b '1',0
             .DC.b '2',0
             .DC.b '3',0
             .DC.b '4',0
             .DC.b '5',0
             .DC.b '6',0
             .DC.b '7',0
             .DC.b '8',0
             .DC.b '9',0
             .DC.b '0',0
             .DC.b "O",0
             .DC.b "K",0
             .DC.b ">",0
             .DC.b "M",0
             .DC.b "<",0
             .DC.b "M",0
             .DC.b "<",0
             .DC.b "-",0

videoligne15:          
             .DC.w 1,1,109,1,1,1,1,117,103,7,103,37,10,37,103,37,102,45,102,108
             .DC.w 103,44,103,109,11,108,102,108,10,109,103,109,108,4,108,116,4,116,108,116
             .DC.w 32,55,32,66,21,66,32,66,47,55,47,66,36,66,47,66,62,55,62,66
             .DC.w 51,66,62,66,77,70,77,81,77,55,77,66,66,66,77,66,92,55,92,66
             .DC.w 81,66,92,66,32,70,32,81,21,81,32,81,47,70,47,81,36,81,47,81
             .DC.w 62,70,62,81,51,81,62,81,92,70,92,81,66,81,77,81,32,85,32,96
             .DC.w 21,96,32,96,47,85,47,96,36,96,47,96,62,85,62,96,51,96,62,96
             .DC.w 92,85,92,96,66,96,92,96,-1

;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------


;******************************************************************
;*** BIOINITEVI                                                  ***
;***                     Initialisation de la base EVI           ***
;***     Entrée:                                                 ***
;***             A0.l : adr de base                              ***
;***             D0.w : Nb evis                                  ***
;******************************************************************

bioinitevi:  
             moveq.l   #0,d7                ;numero de l'evi traite

             swap.w    d0
             clr.w     d0
             swap.w    d0

             move.l    d0,d1
             divu.w    #10,d1
             move.w    d1,ili
             move.w    d1,d2
             swap.w    d1
             add.w     d1,ili
             swap.w    d1
             mulu.w    #6,d1
             move.w    d1,hum
             mulu.w    #3,d2
             move.w    d2,shed

             subq.w    #1,d0
loop_initevi:          
             move.w    d0,-(sp)

;*** initialise le potentiel vie a 0 ***

             clr.b     evipotvie(a0)        ; l'evi est mort...
             move.b    #-1,evileader(a0)    ;ni dieu ni maitre

init_evi:    
;*** initialiser A ***

             moveq.l   #0,d1
             moveq.l   #2,d0
             jsr       rnd2
             move.w    d0,d1
             lsl.w     #8,d1
             swap.w    d1

             cmpi.w    #19+10,d7
             bgt       pasflic0
             andi.l    #$01000000,d1        ;humain ou shedish mais pas ilyen

pasflic0:    

;*** initialiser B ***

             moveq.l   #0,d2

             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #1,d0
             JSR_RND 
             tst.w     d0
             movem.l   (sp)+,d0-d7/a0-a6
             beq.s     bie0
             bset      #4+16,d2
bie0:        

             cmpi.w    #19+10,d7
             bgt       pasflic1
             moveq.l   #0,d2                ;homme

pasflic1:    


;*** INITIALISER G ***

             moveq.l   #0,d0
             cmpi.l    #$02000000,d1
             beq       buste_ylien

             moveq.l   #4,d0
             jsr       rnd2
             addq.w    #1,d0
             swap.w    d0
             clr.w     d0
             swap.w    d0

buste_ylien: 

             or.l      d1,d0
             or.l      d2,d0

             move.l    d0,evicodegen(a0)

init_nom:    

;*** initialiser le nom ***

             tst.l     d1                   ; un humain ?
             bne       tstshedish
             tst.l     d2
             bne       humainf
             move.l    #nbhh,d0
             lea.l     hh,a1
             tst.w     hum
             beq       init_evi
             lea.l     hum,a6
             bra       search_nom
humainf:     
             move.l    #nbhf,d0
             lea.l     hf,a1
             tst.w     hum
             beq       init_evi
             lea.l     hum,a6
             bra       search_nom

tstshedish:  
             cmpi.l    #$01000000,d1        ; un shedish ?
             bne       tstilyen
             tst.l     d2
             bne       shedisf
             move.l    #nbsh,d0
             lea.l     sh,a1
             tst.w     shed
             beq       init_evi
             lea.l     shed,a6
             bra       search_nom
shedisf:     
             move.l    #nbsf,d0
             lea.l     sf,a1
             tst.w     shed
             beq       init_evi
             lea.l     shed,a6
             bra       search_nom

tstilyen:    
             tst.l     d2
             bne       ilyenf
             move.l    #nbih,d0
             lea.l     ih,a1
             tst.w     ili
             beq       init_evi
             lea.l     ili,a6
             bra       search_nom
ilyenf:      
             move.l    #nbif,d0
             lea.l     ilf,a1
             tst.w     ili
             beq       init_evi
             lea.l     ili,a6

search_nom:  
             jsr       rnd2
             mulu.w    #12,d0
             adda.w    d0,a1
             tst.b     11(a1)
             bne       init_evi
             move.b    #-1,11(a1)
             subq.w    #1,(a6)
             move.l    (a1)+,evinom(a0)
             move.l    (a1)+,evinom+4(a0)
             move.w    (a1)+,evinom+8(a0)


             moveq.l   #10-1,d1
loopsavoir:  

             move.w    #192-1,d0
             jsr       rnd2

             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     evisavoir(a0),a0
             jsr       setbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             bne       loopsavoir

             dbra      d1,loopsavoir

             move.w    (sp)+,d0
             lea.l     evisize(a0),a0
             addq.w    #1,d7
             dbra      d0,loop_initevi

             move.w    #-1,(a0)
             rts       

hum:         .DC.w 0
shed:        .DC.w 0
ili:         .DC.w 0

;******************************************************************
;*** BIOCREEREVI                                                 ***
;***                     Liberation d'un ou plusieurs EVI        ***
;***     Entrée:                                                         ***
;***             A0.l : adr de base                              ***
;***             D0.w : Nb evis                                  ***
;******************************************************************

biocreerevi: 
             moveq.l   #0,d7                ;numero d'evi courant
             subq.w    #1,d0
loop_creer_evi:        

             move.l    d0,-(sp)

;*** initialise les caracteristiques ***


             lea.l     eviforce(a0),a1
             moveq.l   #6-1,d1
loop_init_cara:        

             moveq.l   #90-40,d0
             jsr       rnd2
             addi.w    #40,d0
             move.b    d0,(a1)+

             dbra      d1,loop_init_cara

             move.l    evicodegen(a0),d0
             swap.w    d0
             andi.w    #$0f00,d0
             cmpi.w    #$0200,d0
             bne       pasilyen
             move.b    #20,eviintel(a0)     ;ilyen= bete
pasilyen:    

;*** place le lieu de naissance ***

             cmpi.w    #20,d7
             blt       pastech0
             cmpi.w    #29,d7
             bgt       pastech0
             move.w    #700,evilieusrc(a0)
             move.w    #700,evilieudst(a0)

             bra       pastech1
pastech0:    
             move.w    evicodegen(a0),d0
             andi.w    #$0f00,d0
             beq       pastech01
             move.w    #403,evilieusrc(a0)
             move.w    #403,evilieudst(a0)
             bra       pastech1
pastech01:   
             moveq.l   #11,d0
             jsr       rnd2
             lea.l     tb_naitre,a1
             lsl.w     #1,d0
             move.w    0(a1,d0.w),evilieusrc(a0)
             move.w    0(a1,d0.w),evilieudst(a0)

pastech1:    

;*** initialise les points de vie ***

             move.b    #100,evipotvie(a0)




creer_evi:   
             andi.l    #$0ff0000f,evicodegen(a0)
             tst.w     evicodegen(a0)       ;0=humain, homme
             bne       no_moustache


;*** initialiser C ***

             movem.l   d1-d7/a0-a6,-(sp)
             moveq.l   #3,d0
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6
             or.w      d0,evicodegen(a0)

no_moustache:          

;*** initialiser D ***

             moveq.l   #5,d0
             jsr       rnd2
             lsl.w     #8,d0
             lsl.w     #4,d0
             or.w      d0,evicodegen+2(a0)

;*** initialiser E ***

             moveq.l   #4,d0
             jsr       rnd2
             lsl.w     #8,d0
             or.w      d0,evicodegen+2(a0)

;*** initilaiser F ***

             moveq.l   #4,d0
             jsr       rnd2
             lsl.w     #4,d0
             or.w      d0,evicodegen+2(a0)

;*** initialiser leader ***

             move.b    #-1,evileader(a0)

;*** initialser love ***


             move.b    #128,evilove(a0)
             move.b    #128,evilovel7(a0)

             cmpi.w    #19,d7
             bgt       evipasflic

             move.l    evicodegen(a0),d1
             andi.l    #$01000ff0,d1
             ori.w     #$6006,d1            ;casque+uniforme
             move.l    d1,evicodegen(a0)
             bra       evipastech
evipasflic:  
             cmpi.w    #29,d7
             bgt       evipastech

             move.l    evicodegen(a0),d1
             andi.l    #$010f0ff0,d1
             ori.w     #$6,d1               ;uniforme
             move.l    d1,evicodegen(a0)
evipastech:  

;*** jumeaux interdits ***

             lea.l     marchand,a1
             move.l    evicodegen(a0),d1
             andi.l    #$ffff0,d1
loop_jumeauxm:         
             cmpi.w    #-1,(a1)
             beq       no_jumeauxm
             move.l    marcodegen(a1),d0
             andi.l    #$ffff0,d0
             cmp.l     d1,d0
             beq       creer_evi
jumeaux_suitem:        
             lea.l     marsize(a1),a1
             bra       loop_jumeauxm

no_jumeauxm: 

             move.l    (sp)+,d0
             lea.l     evisize(a0),a0
             addq.w    #1,d7
             dbra      d0,loop_creer_evi


             rts       


tb_naitre:   
             .DC.w 101,202,215,300,301,401,407,500,600,613,616,628

;**************************************************************************
;*** BIOMARCHANDER                                                       ***
;***                     Negociation d'un objet avec un evi              ***
;***     Entr‚e:                                                                 ***
;***             D0.l : prix reel de l'objet                             ***
;***             D1.w : Evenement precedent                              ***
;***                     0 le joueur a repondu non                       ***
;***                     -1 nouvelle nego                                ***
;***             A0.l : Adr de la structure de l'evi vendeur             ***
;***     Sortie:                                                                 ***
;***             D7.l : Prix propos‚                                     ***
;**************************************************************************

biomarchander:         

;*************************
;*** test de l'origine ***
;*************************

             cmpi.w    #-1,d1               ; nouvelle nego ?
             bne       suite_nego           ; non

             move.l    d0,prixnego
             bra       intraitable

suite_nego:  

             moveq.l   #0,d6
             move.b    evilove(a0),d6
             cmpi.w    #64,d6
             ble       intraitable

;**************************
;*** calcul de fnegv     ***
;**************************

             moveq.l   #0,d3
             moveq.l   #0,d4
             moveq.l   #0,d5
             move.b    eviforce(a0),d3
             move.b    eviintel(a0),d4
             add.w     d4,d4
             add.w     d4,d3
             moveq.l   #0,d4
             move.b    evicharis(a0),d4
             mulu.w    #3,d4
             add.w     d4,d3
             divu.w    #6,d3

;**************************
;*** d3=fnegv            ***
;*** calcul de fnegj     ***
;**************************

             lea.l     jehan,a0
             moveq.l   #0,d4
             moveq.l   #0,d5
             move.b    forc_c(a0),d4
             move.b    inte_c(a0),d5
             add.w     d5,d5
             add.w     d5,d4
             moveq.l   #0,d5
             move.b    char_c(a0),d5
             mulu.w    #3,d5
             add.w     d5,d4
             divu.w    #6,d4

;**************************
;*** d4=fnegj            ***
;**************************

             move.w    d4,d5

;******************************************************************
;*** ici on tient compte de evilove pour influencer la force du  ***
;*** et la force du vendeur                                      ***
;******************************************************************

             cmpi.w    #128,d6
             beq       calc_vdec            ; le vendeur est neutre pas d'influence
; sur le prix de base
             blt       vendeur_plus         ; le prix de base est augment‚

;************************************************
;*** ici evilove influence une baisse de prix ***
;************************************************

vendeur_moins:         

             move.l    d6,d7
             subi.l    #129,d7              ; % … calculer sur D0...
             move.l    d0,-(sp)
             move.l    d3,d0
             move.l    d7,d1                ; ... dans d1
             jsr       pourcent
             exg.l     d0,d7                ; pourcentage d7 sur d0
             move.l    (sp)+,d0

             sub.l     d7,d3                ; le vendeur est moins fort
             cmpi.l    #0,d3
             bge       ok_vmoins
             moveq.l   #0,d3
ok_vmoins:   
             bra       calc_vdec

;******************************************************
;*** ici evilove influence une augmentation de prix ***
;******************************************************

vendeur_plus:          

             move.l    #127,d7
             sub.l     d6,d7                ; % … calculer sur D0...
             move.l    d0,-(sp)
             move.l    d3,d0
             move.l    d7,d1                ; ... dans d1
             jsr       pourcent
             exg.l     d0,d7                ; pourcentage d7 sur d0
             move.l    (sp)+,d0

             add.l     d7,d3                ; le vendeur est moins fort
             cmpi.w    #100,d3
             ble       ok_vplus
             move.l    #100,d3
ok_vplus:    

;**************************
;*** calcul de vdec      ***
;**************************

calc_vdec:   
             sub.w     d3,d5                ; difference nego joueur/vendeur
             ble       intraitable          ; non, le vendeur ne negocie pas !!
; oui, d5=% de gain sur prix de base

;**********************************************************
;*** ici le joueur est plus fort que le vendeur          ***
;*** d5=vdec (% de gain possible sur le prix r‚Šl        ***
;**********************************************************

             cmpi.l    #2,d0                ; prix<2 ?
             blt       intraitable          ; oui, le vendeur est intraitable

;*************************
;*** calcul de prixmin ***
;*************************

             move.l    d0,-(sp)

             move.l    d5,d1
             jsr       pourcent
             move.l    d0,d7                ; d7 contient le gain maxi possible !!!

             move.l    (sp)+,d0

             move.l    d0,d4
             sub.l     d7,d4

;***********************************
;*** ici d4 contient le prix min ***
;***********************************

             move.l    prixnego,d7
             sub.l     d4,d7                ; d7=gain maxi possible...
             ble       intraitable          ; ...0 ou inferieur !

;************************************
;*** ici une nego peut avoir lieu ***
;************************************

nego:        
             moveq.l   #0,d5

             move.l    d7,-(sp)
             clr.w     d7
             swap.w    d7
             move.l    d7,d0
             jsr       rnd2                 ; valeur sur le poids fort
             move.w    d0,d5
             swap.w    d5
             move.l    (sp)+,d7

             swap.w    d7
             clr.w     d7
             swap.w    d7
             move.w    d7,d0
             jsr       rnd2                 ; valeur sur le poids faible
             move.w    d0,d5                ; valeur totale sur 32 bits
             move.l    prixnego,d7          ; recuperer le prix negoci‚
             sub.l     d5,d7                ; nouveau prix propos‚ !
             move.l    d7,prixnego          ; sauver le prix negoci‚


intraitable: 
             move.l    prixnego,d7          ; sur le prix negoci‚ precedemment

             rts       

prixmin:     .DC.l 0
prixnego:    .DC.l 0


;**************************************************************************
;*** POURCENT                                                            ***
;***             Renvois la valeur de d1% sur 32 bits                    ***
;***     Entr‚es:                                                        ***
;***             D0.l : valeur de base                                   ***
;***             D1.l : pourcentage sur d0 (ex 10%)                      ***
;***     Sorties:                                                        ***
;***             D0.l : valeur retour (pourcentage)                      ***
;**************************************************************************

pourcent:    

             movem.l   d1-d7/a0-a6,-(sp)

             moveq.l   #0,d3
             moveq.l   #0,d7

;*****************************
;*** gestion du poids fort ***
;*****************************

             move.l    d0,d3
             clr.w     d3                   ; pour ne pas tenir compte du pfaible
             swap.w    d3                   ; dans la division
             divu.w    #100,d3              ; ex #100
             move.l    d3,d7

;***********************************************
;*** ici on traite le resultat du poids fort ***
;***********************************************

             mulu.w    d1,d3                ; ex d5,d3

             swap.w    d7
             mulu.w    d1,d7                ; ex d5,d7
             divu.w    #100,d7
             add.w     d7,d3

             swap.w    d3

;*******************************
;*** gestion du poids faible ***
;*******************************

             move.l    d0,d7
             swap.w    d7
             clr.w     d7
             swap.w    d7
             divu.w    #100,d7              ; ex d1,d7
             move.l    d7,d6

;*************************************************
;*** ici on traite le resultat du poids faible ***
;*************************************************

             mulu.w    d1,d7                ; ex d5,d7

             swap.w    d6
             mulu.w    d1,d6                ; ex d5,d6
             divu.w    #100,d6              ; ex d1,d6

             add.w     d6,d7
             or.l      d3,d7                ; recompose le resulstat msb-lsb

             move.l    d7,d0

             movem.l   (sp)+,d1-d7/a0-a6
             rts       




humains:     

hh:          
; Creatures Extra-Terrestres (5)
             .DC.b "CHUBILOK  ",0,0
             .DC.b "TOT       ",0,0
             .DC.b "TUT       ",0,0
; Hommes humains non romains (14)
             .DC.b "JOS YEKADI",0,0         ; prisonnier ami du joueur
             .DC.b "BORIS VORF",0,0
             .DC.b "JUAN PERES",0,0
             .DC.b "RICHARD FO",0,0
             .DC.b "ZU LIN FU ",0,0
; Hommes humains romains (100)
             .DC.b "ACCIUS    ",0,0
             .DC.b "AGRIPPA   ",0,0
             .DC.b "ALEXANDRE ",0,0
             .DC.b "AMBROISE  ",0,0
             .DC.b "AMMIEN    ",0,0
             .DC.b "ANCUS     ",0,0
             .DC.b "ANTOINE   ",0,0
             .DC.b "ANTONIN   ",0,0
             .DC.b "APPIUS    ",0,0
             .DC.b "AUGUSTE   ",0,0
             .DC.b "AUGUSTIN  ",0,0
             .DC.b "AURELIEN  ",0,0
             .DC.b "BATHYLLE  ",0,0
             .DC.b "BRUTUS    ",0,0
             .DC.b "CARACALLA ",0,0
             .DC.b "CATON     ",0,0
             .DC.b "CESAR     ",0,0
             .DC.b "CICERON   ",0,0
             .DC.b "CINNA     ",0,0
             .DC.b "CLAUDE    ",0,0
             .DC.b "CLAUDIEN  ",0,0
             .DC.b "CLODIUS   ",0,0
             .DC.b "CONSTANTIN",0,0
             .DC.b "CRASSUS   ",0,0
             .DC.b "CYPRIEN   ",0,0
             .DC.b "DECIUS    ",0,0
             .DC.b "DIDON     ",0,0
             .DC.b "DIOCLETIEN",0,0
             .DC.b "DOMITIEN  ",0,0
             .DC.b "DUILIUS   ",0,0
             .DC.b "ENNIUS    ",0,0
             .DC.b "FABIUS    ",0,0
             .DC.b "FLAMININUS",0,0
             .DC.b "FLAMINIUS ",0,0
             .DC.b "FLORUS    ",0,0
             .DC.b "GALIEN    ",0,0
             .DC.b "GERMANICUS",0,0
             .DC.b "HADRIEN   ",0,0
             .DC.b "HAMILCAR  ",0,0
             .DC.b "HANNIBAL  ",0,0
             .DC.b "HILAIRE   ",0,0
             .DC.b "HORACE    ",0,0
             .DC.b "HORATIUS  ",0,0
             .DC.b "JEROME    ",0,0
             .DC.b "JESUS     ",0,0
             .DC.b "JULES     ",0,0
             .DC.b "JULIEN    ",0,0
             .DC.b "JUSTIN    ",0,0
             .DC.b "JUSTINIEN ",0,0
             .DC.b "LIVIUS    ",0,0
             .DC.b "LUCULLUS  ",0,0
             .DC.b "LYGDAMUS  ",0,0
             .DC.b "MANILIUS  ",0,0
             .DC.b "MARCELLUS ",0,0
             .DC.b "MARIOS    ",0,0
             .DC.b "MARTIAL   ",0,0
             .DC.b "MAXENCE   ",0,0
             .DC.b "MAXIMIEN  ",0,0
             .DC.b "MUCIUS    ",0,0
             .DC.b "NAEVIUS   ",0,0
             .DC.b "NERON     ",0,0
             .DC.b "OCTAVE    ",0,0
             .DC.b "OTHON     ",0,0
             .DC.b "PAUL      ",0,0
             .DC.b "PAUL EMILE",0,0
             .DC.b "PLINE     ",0,0
             .DC.b "POMPEE    ",0,0
             .DC.b "POMPONIUS ",0,0
             .DC.b "PROBUS    ",0,0
             .DC.b "PYRRHUS   ",0,0
             .DC.b "QUINTILIEN",0,0
             .DC.b "REGULUS   ",0,0
             .DC.b "REMUS     ",0,0
             .DC.b "ROMULUS   ",0,0
             .DC.b "RUTILIUS  ",0,0
             .DC.b "SALLUSTE  ",0,0
             .DC.b "SAPOR     ",0,0
             .DC.b "SCIPION   ",0,0
             .DC.b "SEJAN     ",0,0
             .DC.b "SIDOINE   ",0,0
             .DC.b "SILIUS    ",0,0
             .DC.b "SPARTACUS ",0,0
             .DC.b "SYLLA     ",0,0
             .DC.b "TARQUIN   ",0,0
             .DC.b "TERENCE   ",0,0
             .DC.b "TERTULIEN ",0,0
             .DC.b "THEODORE  ",0,0
             .DC.b "TIBERE    ",0,0
             .DC.b "TIBULLE   ",0,0
             .DC.b "TITUS     ",0,0
             .DC.b "TRAJAN    ",0,0
             .DC.b "TULLUS    ",0,0
             .DC.b "VALERIUS  ",0,0
             .DC.b "VESPASIEN ",0,0
             .DC.b "VIRGILE   ",0,0
             .DC.b "VINIUS    ",0,0

gfabug2      equ hf-hh
gfabug2b     equ gfabug2/12
nbhh         equ 103   ;!gfabug2b-1
hf:          
; Femmes humaines non romaines (6)
             .DC.b "LUCIE PIK ",0,0
             .DC.b "JENNA HORT",0,0
             .DC.b "MARY HEART",0,0
             .DC.b "MAY LIN   ",0,0
             .DC.b "MARTHA    ",0,0
; Femmes humaines romaines (40)
             .DC.b "AGAPE     ",0,0
             .DC.b "AGRICOLA  ",0,0
             .DC.b "AGRIPPINE ",0,0
             .DC.b "ALEXANDRA ",0,0
             .DC.b "AURELIE   ",0,0
             .DC.b "CAMILLE   ",0,0
             .DC.b "CATILINA  ",0,0
             .DC.b "CLELIE    ",0,0
             .DC.b "CLEOPATRE ",0,0
             .DC.b "COLUMELLE ",0,0
             .DC.b "CONSTANTE ",0,0
             .DC.b "ENEE      ",0,0
             .DC.b "EUTROPE   ",0,0
             .DC.b "EVANDRE   ",0,0
             .DC.b "GALBA     ",0,0
             .DC.b "JUGURTHA  ",0,0
             .DC.b "JUSTINE   ",0,0
             .DC.b "LEPIDE    ",0,0
             .DC.b "LIVIE     ",0,0
             .DC.b "LUCILIUS  ",0,0
             .DC.b "LUCRECE   ",0,0
             .DC.b "MASSINISSA",0,0
             .DC.b "MESSALA   ",0,0
             .DC.b "MESSALINE ",0,0
             .DC.b "MITHRIDATE",0,0
             .DC.b "NARCISSE  ",0,0
             .DC.b "NERVA     ",0,0
             .DC.b "OCTAVIE   ",0,0
             .DC.b "PHEDRE    ",0,0
             .DC.b "POLYBE    ",0,0
             .DC.b "POPPEE    ",0,0
             .DC.b "PORSENA   ",0,0
             .DC.b "PROPERCE  ",0,0
             .DC.b "PRUDENCE  ",0,0
             .DC.b "RHEA      ",0,0
             .DC.b "SIBYLLE   ",0,0
             .DC.b "SULPICE   ",0,0
             .DC.b "VALERIA   ",0,0
             .DC.b "VESTA     ",0,0
             .DC.b "VIRGINIE  ",0,0
             .DC.b "VISIA     ",0,0

gfabug3      equ sh-hf
gfabug3b     equ gfabug3/12
nbhf         equ 45    ;!(gfabug3b)-1

shedishs:    

sh:          

; Hommes Shedish (25)
             .DC.b "BAZUR'KA  ",0,0
             .DC.b "BILOK'JUL ",0,0
             .DC.b "BOUZIG'IKA",0,0
             .DC.b "CIRCA'AZI ",0,0
             .DC.b "CIRCA'UZ  ",0,0
             .DC.b "KIRK'KA   ",0,0
             .DC.b "OSZOL'JUL ",0,0
             .DC.b "VOZOUL'UZ ",0,0
             .DC.b "AMARA'ZIMB",0,0
             .DC.b "OCCAZ'LI  ",0,0
             .DC.b "ZEO'ERAK  ",0,0
             .DC.b "TWIN'PUK  ",0,0
             .DC.b "TOO'MUCH  ",0,0
             .DC.b "DAO'VOZU  ",0,0
             .DC.b "ZIST'VELU ",0,0
             .DC.b "PANAM'MOCH",0,0
             .DC.b "ACPMON'ZSI",0,0
             .DC.b "VIZ'KKO   ",0,0
             .DC.b "DIR'DACKU ",0,0
             .DC.b "EZOG'BRAMI",0,0
             .DC.b "FOOK'FIK  ",0,0
             .DC.b "GARUL'KOOK",0,0
             .DC.b "INOR'WISK ",0,0
             .DC.b "ZIGUS'BOLI",0,0
             .DC.b "ZOK'KOOK  ",0,0
             .DC.b "ZUR'LEPON ",0,0
             .DC.b "ZOU'LEPON ",0,0
             .DC.b "DAV'YGNON ",0,0
             .DC.b "MEK'TUPU  ",0,0
             .DC.b "OU'SAYTI  ",0,0
             .DC.b "QUIL'AI   ",0,0
             .DC.b "HUM'MOISA ",0,0

gfabug4      equ sf-sh
gfabug4b     equ gfabug4/12
nbsh         equ 31    ;!(gfabug4b)-1

sf:          
; Femmes Shedish (15)
             .DC.b "AK'BEN'IR ",0,0
             .DC.b "BAL'AMIN  ",0,0
             .DC.b "BI'BABELOU",0,0
             .DC.b "TOMAT'OKET",0,0
             .DC.b "KET'CHUP  ",0,0
             .DC.b "MART'TZARA",0,0
             .DC.b "PALI'PICA ",0,0
             .DC.b "ZUZI'KOOL ",0,0
             .DC.b "SUS'MALA  ",0,0
             .DC.b "CROSA'LOLA",0,0
             .DC.b "JEM'LOLAII",0,0
             .DC.b "ANEK'TIRU ",0,0
             .DC.b "HOHI'HAHA ",0,0
             .DC.b "ROLIUS'NEM",0,0
             .DC.b "ALLA'HLOK ",0,0
             .DC.b "TOT'NTARIK",0,0
             .DC.b "ZOL'NTARIK",0,0
             .DC.b "ZAL'NEM   ",0,0
             .DC.b "ZIM'OKARA ",0,0
             .DC.b "ZOB'AKIL  ",0,0
             .DC.b "ZOU'LAT   ",0,0
             .DC.b "ZOU'TYOM  ",0,0
             .DC.b "ZAY'CHIA  ",0,0
             .DC.b "TAR'MALAK ",0,0
             .DC.b "EROS'MAKI ",0,0
             .DC.b "MOULA'GOFR",0,0
             .DC.b "POT'DBUR  ",0,0
             .DC.b "ERA'DIKA  ",0,0
             .DC.b "ZAL'AMI   ",0,0

gfabug5      equ ih-sf
gfabug5b     equ gfabug5/12
nbsf         equ 28    ;(gfabug5b)-1

ilyens:      

ih:          
; Hommes Ilyens (20)
             .DC.b "IEMEN GOR ",0,0
             .DC.b "IEMEN KOLO",0,0
             .DC.b "IEMEN ZOU ",0,0
             .DC.b "IEMEN BOR ",0,0
             .DC.b "IEMEN VILU",0,0
             .DC.b "IEMEN CROK",0,0
             .DC.b "IEMEN ENOR",0,0
             .DC.b "IEMEN GIGA",0,0
             .DC.b "IEMEN OLOR",0,0
             .DC.b "IEMEN OHAK",0,0
             .DC.b "IEMEN ADIK",0,0
             .DC.b "IEMEN KUKU",0,0
             .DC.b "IEMEN DAMI",0,0
             .DC.b "IEMEN HUS ",0,0
             .DC.b "IEMEN KYLE",0,0
             .DC.b "IEMEN ZEN ",0,0
             .DC.b "IEMEN MANU",0,0
             .DC.b "IEMEN MOKT",0,0
             .DC.b "IEMEN LINO",0,0
             .DC.b "IEMEN PAKO",0,0
             .DC.b "IEMEN TOK ",0,0

gfabug6      equ ilf-ih
gfabug6b     equ gfabug6/12
nbih         equ 20    ;(gfabug6b)-1

ilf:         
; Femmes Ilyennes (15)
             .DC.b "IEMEN KIR ",0,0
             .DC.b "IEMEN KALI",0,0
             .DC.b "IEMEN ANAK",0,0
             .DC.b "IEMEN LIZA",0,0
             .DC.b "IEMEN BEKA",0,0
             .DC.b "IEMEN DRKA",0,0
             .DC.b "IEMEN FERZ",0,0
             .DC.b "IEMEN MIRA",0,0
             .DC.b "IEMEN ZORA",0,0
             .DC.b "IEMEN DITI",0,0
             .DC.b "IEMEN GORA",0,0
             .DC.b "IEMEN ZULI",0,0
             .DC.b "IEMEN POKI",0,0
             .DC.b "IEMEN LOLA",0,0
             .DC.b "IEMEN ORKA",0,0

end_noms:    

nbif         equ 14



rnd2:        
             movem.l   d1-d7/a0-a6,-(sp)
             JSR_RND 
             movem.l   (sp)+,d1-d7/a0-a6
             rts       



;---------------------------------------------------------------
;
; dialc?
;
; d3 numero evi (-1 si marchand)
; d4 numero marchand (-1 si evi)
; a3 pointe la structure de l'interlocuteur
;


dialc1:      
             cmpi.b    #60,eviintel(a3)
             bcs       condfalse
             moveq.l   #0,d0                ;Z=1
             rts       
dialc2:      
             move.l    evicodegen(a3),d0
             andi.l    #$0f000000,d0
             cmpi.l    #$01000000,d0
             rts       

dialc3:      
             cmpi.b    #40,eviintel(a3)
             bcc       condfalse
             moveq.l   #0,d0                ;Z=1
             rts       
dialc4:      
             cmpi.w    #38,d4
             rts       
dialc5:      
             cmpi.w    #13,d4
             bne       condfalse
             move.w    #5013,d0
             move.w    #856,d1
             jmp       findobj


;est-ce un technicien?

dialc6:      
             cmpi.w    #20,d3
             blt       condfalse
             cmpi.w    #29,d3
             bgt       condfalse
             bra       condtrue

dialc7:      
             moveq.l   #0,d0
             move.b    eviintel(a3),d0
             add.b     evicharis(a3),d0
             cmpi.w    #100,d0
             bgt       condfalse
             moveq.l   #0,d0
             rts       

dialc8:      
             cmpi.w    #20,d4
             rts       

dialc9:      
             cmpi.b    #100,evilove(a3)
             bcc       condfalse
             moveq.l   #0,d0
             rts       

condfalse:   
             moveq.l   #-1,d0
             rts       
dialc0:      
biic0:       
condtrue:    
             moveq.l   #0,d0
             rts       


biic1:       
             move.w    #4000,d0             ;sortie mantoue
             move.w    #929,d1
             jsr       findobj
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             rts       

biic2:                 ;entree/sortie chambre mantoue

             moveq.l   #messagesylvia1,d0
             JSR_SCENATSTBIT 
             bne       biic2s0
             move.w    #913,sujetdujour
             bra       biic2s
biic2s0:     
             moveq.l   #messagesylvia2,d0
             JSR_SCENATSTBIT 
             bne       biic2s1

             moveq.l   #massigliavu,d0
             JSR_SCENATSTBIT 
             beq       biic2s1

             move.w    #914,sujetdujour
             bra       biic2s

biic2s1:     
             moveq.l   #messagesylvia3,d0
             JSR_SCENATSTBIT 
             bne       biic2s2

             moveq.l   #livrelu,d0
             JSR_SCENATSTBIT 
             beq       biic2s2


             move.w    #915,sujetdujour
             bra       biic2s

biic2s2:     
             move.w    #916,sujetdujour     ;rien de neuf...
biic2s:      
             move.w    #4000,d0             ;entree/sortie chambre mantoue
             move.w    #929,d1
             jsr       findobj
             bne       condfalse
;
; ATTENTION ceci est un cas particulier pour forcer l'affichage
;           de la tete de sylvia (premiere partie uniquement)

             not.w     missiongroupe

             bra       condtrue

biic3:       
             move.w    #4000,d0             ;entree/sortie chambre cite
             move.w    #928,d1
             jmp       findobj
biic4:       
             move.w    #4000,d0             ;sortie hotel cite
             move.w    #928,d1
             jsr       findobj
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             rts       


biic5:       
             lea.l     marchand,a0          ;entree jugh'ahih
             lea.l     23*marsize(a0),a0
             move.l    marvbl(a0),d0
             move.l    contvbl,d7
             cmp.l     d0,d7
             blt       biifalse
             addi.l    #30*365,d0           ;+30 minutes
             cmp.l     d0,d7
             bgt       biifalse

; si on est en j+1 les titres vont a la poubelle

             cmpi.l    #524288,contvbl
             blt       biic5s0
             lea.l     objstruc,a0
             adda.w    #858*8,a0
             cmpi.w    #965+28,objpere(a0)
             bne       biic5s0
             move.w    #9998,objpere(a0)
biic5s0:     
             moveq.l   #0,d0                ;z=1
             rts       

biifalse:    
             moveq.l   #-1,d0               ;z=0
             rts       

biic6:       
             lea.l     marchand,a0          ;entree massiglia
             lea.l     22*marsize(a0),a0
             move.l    marvbl(a0),d0
             move.l    contvbl,d7
             cmp.l     d0,d7
             blt       biifalse
             addi.l    #30*365,d0           ;+30 minutes
             cmp.l     d0,d7
             bgt       biifalse

             moveq.l   #massigliavu,d0
             JSR_SCENASETBIT 

;enregistrer voix massiglia sur bande
             move.w    #sourissablier,souri_11
             lea.l     objstruc,a0
biic60:      
             move.w    objpere(a0),d0
             blt       condtrue
             move.w    objtype(a0),d1
             cmpi.w    #10,d1               ;type bande=10
             bne       biic62
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             move.l    a0,d1
             subi.l    #objstruc,d1
             lsr.w     #3,d1
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             bne       biic62               ;cette bande ne nous appartient pas!
             lsl.w     #3,d0
             lea.l     objstruc,a1
             cmpi.w    #20,objtype(a1,d0.w) ;type resvocal=20
             bne       biic62               ;la bande n'est pas dans un restitueur
             move.w    #-1,objdivers1(a0)
biic62:      
             addq.l    #8,a0
             bra.s     biic60

biic7:       
             move.w    #4000,d0             ;entree CAI
             move.w    #23,d1
             jmp       findobjtype
biic8:       
             clr.w     pagecai
             moveq.l   #0,d0                ;Z=1
             rts       

biic9:       
             moveq.l   #boglimortvu,d0
             JSR_SCENASETBIT 
             moveq.l   #0,d0                ;Z=1
             rts       
biic10:                ;attaque welco
             moveq.l   #boglimortvu,d0
             JSR_SCENATSTBIT 
             beq       biic10s

             moveq.l   #attaquewelco,d0
             JSR_SCENASETBIT 
             bne       condtrue

             lea.l     evi,a0
             adda.w    #202*evisize,a0
             clr.b     evilove(a0)
             move.w    #203,evilieudst(a0)
             move.l    contvbl,evivblsrc(a0)
biic10s:     
             moveq.l   #0,d0                ;Z=1
             rts       

biic11:                ;entree welco
             moveq.l   #boglimortvu,d0
             jmp       scenatstbit

biic12:      
             move.w    #4000,d0             ;entree/sortie chambre s5
             move.w    #1004,d1
             jmp       findobj
biic13:      
             move.w    #4000,d0             ;sortie hotel s5
             move.w    #1004,d1
             jsr       findobj
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             rts       

biic14:                ;le senex possede la tablette
             move.w    #5013,d0
             move.w    #856,d1
             jmp       findobj

biic15:                ;attaque senex
             move.w    #4000,d0
             move.w    #856,d1
             jsr       findobj              ;le joueur possede la tablette
             bne       biic15s

             moveq.l   #attaquesenex,d0
             JSR_SCENASETBIT 
             bne       biic15s

             lea.l     evi,a0
             adda.w    #200*evisize,a0
             clr.b     evilove(a0)
             move.w    #516,evilieudst(a0)
             move.l    contvbl,evivblsrc(a0)


biic15s:     
             moveq.l   #0,d0                ;Z=1
             rts       

biic16:                ;entree opticien
             lea.l     marchand,a0
             adda.w    #20*marsize,a0
             move.l    marvbl(a0),d0
             beq       biic16s
             cmp.l     contvbl,d0
             bgt       biic16s
             lea.l     objstruc,a0
             adda.w    #0*8,a0
             cmpi.w    #9998,objpere(a0)
             bne       biic16s
             move.w    #965+20,objpere(a0)
biic16s:     
             moveq.l   #0,d0
             rts       

biic17:                ;perser le mur d'ozonore (carmenta)
             move.w    #4000,d0
             moveq.l   #41,d1               ;systeme axial
             jsr       findobjtype
             bne       condfalse
             moveq.l   #murcarperce,d0
             JSR_SCENATSTBIT 
             bne       biic170

             move.w    #4000,d0
             moveq.l   #8,d1                ;ditroxyl
             jsr       findobjtype
             bne       condfalse

biic170:     
             movea.l   animdebut,a0
             move.l    #animcodenop,(a0)
             move.l    a0,animpc
             clr.w     animfin

             moveq.l   #murcarperce,d0
             JSR_SCENASETBIT 
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             rts       

biic18:                ;sortie hold-up
             move.w    #4000,d0
             moveq.l   #41,d1               ;systeme axial
             jmp       findobjtype

biic19:      
             move.w    #sourissablier,souri_11
             lea.l     objstruc,a0
biic60x:     
             move.w    objpere(a0),d0
             blt       condfalse
             move.w    objtype(a0),d1
             cmpi.w    #10,d1               ;type bande=10
             bne       biic62x
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    #4000,d0
             move.l    a0,d1
             subi.l    #objstruc,d1
             lsr.w     #3,d1
             jsr       findobj
             movem.l   (sp)+,d0-d7/a0-a6
             bne       biic62x              ;cette bande ne nous appartient pas!
             lsl.w     #3,d0
             lea.l     objstruc,a1
             cmpi.w    #20,objtype(a1,d0.w) ;type resvocal=20
             bne       biic62x              ;la bande n'est pas dans un restitueur
             cmpi.w    #-1,objdivers1(a0)
             beq       rts                  ;bande enregistree dans restitueur
biic62x:     
             addq.l    #8,a0
             bra.s     biic60x



biic20:                ;verre codeur ou grille
             move.w    #4000,d0
             moveq.l   #42,d1
             jsr       findobjtype
             beq       rts

             LEA_MENUTXLSTA1 
             move.l    #txboi54,(a1)+
             move.l    #txboi55,(a1)+
             move.l    #txboi56,(a1)+
             move.l    #txboi57,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi58,(a1)+
             move.l    #txboi59,(a1)+
             move.l    #txboi60,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 
             JSR__AFF 

             clr.w     jehan+potvie
             moveq.l   #-1,d0               ;Z=0
             rts       


biic21:                ;ouvrir coffre massiglia
             moveq.l   #coffremasperce,d0
             JSR_SCENATSTBIT 
             bne       biic210

             move.w    #4000,d0
             moveq.l   #8,d1                ;ditroxyl
             jsr       findobjtype
             bne       condfalse

;mettre le contenu du coffre par terre

             lea.l     objstruc,a0
             cmpi.w    #965+16,857*8(a0)
             bne       biic211
             move.w    #2000+622,857*8(a0)  ;si titres chez massiglia->titres par terre
biic211:     
             cmpi.w    #9998,831*8(a0)
             bne       biic212
             move.w    #2000+622,831*8(a0)  ;chemise massiglias->par terre
biic212:     
             cmpi.w    #9998,771*8(a0)
             bne       biic213
             move.w    #2000+622,771*8(a0)  ;sacoche massiglias->par terre
biic213:     
             lea.l     marchand+evilove,a0
             move.b    #10,marsize*16(a0)   ;evilove massiglia=10
biic210:     
             movea.l   animdebut,a0
             move.l    #animcodenop,(a0)
             move.l    a0,animpc
             clr.w     animfin

             moveq.l   #coffremasperce,d0
             JSR_SCENASETBIT 
             seq       d0                   ;inverse le
             tst.b     d0                   ;bit Z
             rts       

biic22:                ;escalader maison de zist honor
             moveq.l   #journallu,d0
             JSR_SCENATSTBIT 
             beq       condfalse

             moveq.l   #serrurezohs,d0
             JSR_SCENATSTBIT 
             bne       biic221
             move.w    #4000,d0
             moveq.l   #8,d1
             jsr       findobjtype
             bne       condfalse
biic221:     
             move.b    jehan+forc_c,d0
             add.b     jehan+refl_c,d0
             cmpi.b    #150,d0
             bcc       biic222              ;si reflexe+force>150 on peut grimper sans corde
             move.w    #4000,d0
             moveq.l   #85,d1
             jsr       findobjtype
             bne       condfalse
biic222:     
             moveq.l   #serrurezohs,d0
             JSR_SCENASETBIT 
             moveq.l   #0,d0                ;Z=1
             rts       

biic23:                ;bouger la statuette
             moveq.l   #portezoopen,d0
             JSR_SCENASETBIT 
             bne       biic231
             movea.l   animdebut,a0
             move.l    #animcodenop,(a0)
             move.l    a0,animpc
             clr.w     animfin
             movea.l   animdebut+4,a0
             move.l    #animcodenop,(a0)
             move.l    a0,animpc+4
             clr.w     animfin+2
biic231:     
             moveq.l   #0,d0                ;Z=1
             rts       
biic24:                ;entree piece secrete
             moveq.l   #portezoopen,d0
             JSR_SCENATSTBIT 
             seq       d0
             tst.b     d0                   ; inverse bit Z
             rts       

biic25:                ;sortie piece secrete
             movea.l   animdebut,a0
             move.l    #animcodefin,(a0)
             move.l    a0,animpc
             clr.w     animfin
             movea.l   animdebut+4,a0
             move.l    #animcodefin,(a0)
             move.l    a0,animpc+4
             clr.w     animfin+2
             moveq.l   #portezoopen,d0
             jsr       scenaclrbit
             moveq.l   #0,d0                ;Z=1
             rts       

;---------------------------------------------------------------


biic26:                ;sortie astroport->declenchement 2eme partie
             moveq.l   #partie2,d0
             JSR_SCENATSTBIT 
             bne       condtrue

             lea.l     objstruc,a0
             moveq.l   #0,d0                ;nombre de titres
             cmpi.w    #965+16,857*8(a0)
             beq       biic261
             addi.w    #50,d0
biic261:     
             cmpi.w    #965+28,858*8(a0)
             beq       biic262
             cmpi.w    #9998,858*8(a0)
             beq       biic262
             addi.w    #10,d0
biic262:     
             cmpi.w    #3202,859*8(a0)      ;NUMITOR est proprietaire ???
             beq       biic263
             addi.w    #25,d0
biic263:     
             cmpi.w    #21,860*8(a0)
             beq       biic264
             addi.w    #85,d0
             bra.s     biic265
biic264:     
             cmpi.w    #2410,21*8(a0)
             beq.s     biic265
             addi.w    #85,d0
biic265:     
             cmpi.w    #9998,861*8(a0)
             beq       biic266
             addi.w    #100,d0
biic266:     
             cmpi.w    #220,d0

             blt       condtrue

             moveq.l   #partie2,d0
             JSR_SCENASETBIT 

             jsr       jeterobjets

;jeter groupe

             lea.l     listegroupe,a0
             lea.l     missiongroupe,a1
             moveq.l   #5-1,d7
jetergroupe0:          
             move.w    (a0),d0
             move.w    #-1,(a0)+
             clr.l     (a1)+
             move.w    #4,(a1)+

             tst.w     d0
             blt       jetergroupe1
             mulu.w    #evisize,d0
             lea.l     evi,a6
             adda.w    d0,a6
             move.b    #-1,evileader(a6)
             move.w    #100,evilieudst(a6)

jetergroupe1:          
             dbra      d7,jetergroupe0

             move.w    nocour,d0
             addi.w    #1000,d0
             jsr       memmasterkill

             move.w    #953,nocour
             jsr       biitempoprog
             lea.l     palette,a0
             jsr       degraoff
             jsr       hidemouse

             jsr       transimginter


             lea.l     palette953,a0
             jsr       degraon
             jsr       waitclic
             lea.l     palette953,a0
             jsr       degraoff
             move.w    #953,d0
             jsr       memmasterkill
             move.w    #1953,d0
             jsr       memmasterkill

             lea.l     txpartie1,a0
             moveq.l   #24,d0
             jsr       scrolltx

             jsr       initecran

             lea.l     palette,a0
             jsr       degraon

             addq.l    #4,sp                ;a cause du jsr
             movem.l   (sp)+,d0-d7/a0-a6

             move.w    #303,newnocour
             jmp       clic2


biic27:                ;douanier vu avec papiers en regle
             moveq.l   #douaniervu,d0
             JSR_SCENATSTBIT 
             bne       condtrue

             movea.l   animdebut,a0
             move.l    #animcodenop,4(a0)
             move.l    a0,animpc
             clr.w     animfin
             bra       condfalse

biic28:                ;passe de la porte sur le toit de la koshan
             moveq.l   #partie3,d0
             JSR_SCENATSTBIT 
             beq       condfalse
             jsr       jhm
             cmpi.w    #4,d1
             bgt       condfalse            ;si il est plus de 4 heures du matin on ne peut pas rentrer

             move.l    contvbl,d0
             addi.l    #delaikoshan,d0
             move.l    d0,vblkoshan
             moveq.l   #0,d0                ;Z=1
             rts       

biic29:                ;manette baissee ?
             moveq.l   #manettekoshan,d0
             JSR_SCENATSTBIT 
             bne       condtrue
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi71,(a1)+
             move.l    #txboi72,(a1)+
             move.l    #txboi3,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             clr.w     jehan+potvie
             moveq.l   #-1,d0               ;Z=0
             rts       

biic30:      
             moveq.l   #manettekoshan,d0
             jsr       scenachgbit
biic301:     
             sne       d0
             addq.b    #1,d0
             ext.w     d0
             ext.l     d0
             movea.l   animdebut,a0
             move.l    d0,(a0)
             move.l    a0,animpc
             clr.w     animfin
             JSR_RELACHE 
             bra       condtrue

biic31:      
             moveq.l   #manettekoshan,d0
             JSR_SCENATSTBIT 
             bra       biic301

biic32:      
             move.l    contvbl,d0
             cmp.l     vblkoshan,d0
             bge       biic321

             moveq.l   #0,d0
             move.w    souri_8,d0
             subi.w    #yorg+29,d0
             blt       biic322
             add.w     d0,d0
             divu.w    #15,d0
             cmpi.w    #15,d0
             bgt       biic322
             lea.l     ledcoffre,a0
             jsr       chgbitfield

             bsr       calculcoffre

             move.l    ledcoffre+2,d0
             add.l     d0,d0
             swap.w    d0
             andi.w    #$000f,d0
             cmpi.w    #$f,d0
             bne       biic322

             move.w    #4000,d0
             move.w    #43,d1
             jsr       findobjtype
             bne       biic322

             moveq.l   #partiegagnee,d0
             JSR_SCENASETBIT 

biic322:     
             JSR_RELACHE 
             bra       condtrue

biic321:     
             LEA_MENUTXLSTA1 
             move.l    #txboi3,(a1)+
             move.l    #txboi73,(a1)+
             move.l    #txboi74,(a1)+
             move.l    #txboi3,(a1)+
             move.l    #-1,(a1)+
             moveq.l   #0,d0
             JSR_BOITE 

             clr.w     jehan+potvie
             moveq.l   #-1,d0               ;Z=0
             rts       

biic33:                ;prison->refectoire
             jsr       partie
             cmpi.w    #2,d0
             bne       condfalse

             jsr       jhm
             cmpi.w    #12,d1
             beq       biic331
             cmpi.w    #20,d1
             bne       condfalse
biic331:     
             moveq.l   #rationprison,d0
             jsr       scenaclrbit
             moveq.l   #9,d0
             JSR_RND 
             tst.w     d0
             bne       condtrue

             lea.l     objstruc,a0
             cmpi.w    #5033,42*8(a0)
             bne       condtrue             ;la sonde n'est plus dans le stock de JOS

             moveq.l   #combatprison,d0
             JSR_SCENASETBIT 
             bra       condtrue

biic34:                ;prison->arene
             jsr       partie
             cmpi.w    #2,d0
             bne       condfalse

             jsr       jhm
             cmpi.w    #17,d1
             bne       rts
             addi.l    #22000,contvbl
             bra       condtrue

biic35:                ; rixe dans la prison
             moveq.l   #combatprison,d0
             JSR_SCENATSTBIT 
             beq       condfalse

             moveq.l   #mitar,d0
             JSR_SCENASETBIT 

             move.l    contvbl,d0
             addi.l    #21000*24,d0
             move.l    d0,vblmitar

             bra       condtrue

biic36:                ;sortie mitar
             move.l    contvbl,d0
             cmp.l     vblmitar,d0
             blt       condfalse

             bra       condtrue


biic37:      
             addi.l    #22000,contvbl
             bra       condtrue

;sortie prison pour partie <>2

biic38:      
             jsr       partie
             cmpi.w    #2,d0
             beq       condfalse
             bra       condtrue

;---------------------------------------------------------------
;
; calculcoffre
;

calculcoffre:          
; 1er etage

             moveq.l   #0,d0
             moveq.l   #1,d1
             moveq.l   #16,d2
             jsr       setegale
             moveq.l   #2,d0
             moveq.l   #3,d1
             moveq.l   #17,d2
             jsr       setegale
             moveq.l   #4,d0
             moveq.l   #5,d1
             moveq.l   #18,d2
             jsr       setdifferent
             moveq.l   #6,d0
             moveq.l   #7,d1
             moveq.l   #19,d2
             jsr       setdifferent
             moveq.l   #8,d0
             moveq.l   #9,d1
             moveq.l   #20,d2
             jsr       setdifferent
             moveq.l   #10,d0
             moveq.l   #11,d1
             moveq.l   #21,d2
             jsr       setegale
             moveq.l   #12,d0
             moveq.l   #13,d1
             moveq.l   #22,d2
             jsr       setdifferent
             moveq.l   #14,d0
             moveq.l   #15,d1
             moveq.l   #23,d2
             jsr       setegale

; 2eme etage

             moveq.l   #16,d0
             moveq.l   #17,d1
             moveq.l   #24,d2
             jsr       setdifferent
             moveq.l   #18,d0
             moveq.l   #19,d1
             moveq.l   #25,d2
             jsr       setdifferent
             moveq.l   #20,d0
             moveq.l   #21,d1
             moveq.l   #26,d2
             jsr       setdifferent
             moveq.l   #22,d0
             moveq.l   #23,d1
             moveq.l   #27,d2
             jsr       setegale

; 3eme etage

             moveq.l   #24,d0
             moveq.l   #63,d1
             moveq.l   #29,d2
             jsr       setegale
             moveq.l   #25,d0
             moveq.l   #62,d1
             moveq.l   #30,d2
             jsr       setdifferent
             moveq.l   #26,d0
             moveq.l   #61,d1
             moveq.l   #31,d2
             jsr       setegale
             moveq.l   #27,d0
             moveq.l   #60,d1
             moveq.l   #32,d2
             jmp       setegale


;---------------------------------------------------------------
;
; setegale
;
; entree:     d0,d1 numeros des bits d'entree
;             d2 numero du bit de sortie
;

setegale:    
             bsr       setdifegale
             move.w    d2,d0
             cmp.b     d6,d7
             beq       setbitfield
             bra       clrbitfield

setdifegale: 
             lea.l     ledcoffre,a0
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             seq       d7
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d1,d0
             jsr       tstbitfield
             movem.l   (sp)+,d0-d7/a0-a6
             seq       d6
             rts       
;---------------------------------------------------------------
;
; setdifferent
;
; entree:     d0,d1 numeros des bits d'entree
;             d2 numero du bit de sortie
;

setdifferent:          
             bsr       setdifegale
             move.w    d2,d0
             cmp.b     d6,d7
             bne       setbitfield
             bra       clrbitfield


;---------------------------------------------------------------
;
; jeterobjets
;

jeterobjets: 
             lea.l     objstruc,a0
jo0:         
             move.w    objpere(a0),d0
             blt       rts
             cmpi.w    #47,d0
             bne       jo2
             move.w    objtype(a0),d0
             lea.l     objtypedata,a1
             mulu.w    #objtypesize,d0
             btst      #0,objetat+1(a1,d0.w)      ;bit lie/paslie
             bne       jo4
             move.w    #9998,objpere(a0)    ;objet pas lie->poubelle
             bra.s     jo4
jo2:         
             cmpi.w    #44,d0
             bne       jo3
             move.w    #9998,objpere(a0)
jo3:         
             cmpi.w    #45,d0
             bne       jo4
             move.w    #9998,objpere(a0)

jo4:         
             addq.l    #8,a0
             bra.s     jo0

;---------------------------------------------------------------
;
; muls3232
;
; entree:     d0.L
;             d1.L
;
; retour:     d1.L poids fort (64 bits)
;             d0.L poids faible (64 bits)
;

muls3232:    
             move.l    d0,d2
             move.l    d1,d3
             move.l    d1,d4
             move.l    d2,d5
             move.l    d1,d6
             moveq.l   #0,d7
             swap.w    d4
             swap.w    d5
             mulu.w    d2,d1
             mulu.w    d4,d2
             mulu.w    d5,d3
             mulu.w    d5,d4
             swap.w    d1
             add.w     d2,d1
             addx.l    d7,d4
             add.w     d3,d1
             addx.l    d7,d4
             swap.w    d1
             clr.w     d2
             clr.w     d3
             swap.w    d2
             swap.w    d3
             add.l     d3,d2
             add.l     d4,d2
             swap.w    d5
             tst.l     d6
             bpl.s     chk2
             sub.l     d5,d2
chk2:        tst.l     d5
             bpl.s     done
             sub.l     d6,d2
done:        
             move.l    d2,d0
             exg.l     d0,d1
             rts       

;---------------------------------------------------------------
;
; divu32
;
; entree:     d0 diviseur
;             d1.L dividande
;
; retour:     d0.L quotient
;

;il y a moyen de faire mieux en testant V (debordement)
;decaler a droite tant qu'il y a debordement...

divu32:      
             swap.w    d0
             clr.w     d0
             swap.w    d0

             moveq.l   #0,d2
divu32cont:  
             swap.w    d1
             tst.w     d1
             beq.s     divpossible
             swap.w    d1
             lsr.l     #1,d1
             addq.w    #1,d2
             bra.s     divu32cont
divpossible: 
             swap.w    d1
             divu.w    d0,d1
             swap.w    d1
             clr.w     d1
             swap.w    d1
             lsl.l     d2,d1
             move.l    d1,d0
             rts       










             .DATA 

data:        

pagecai:     .DC.w 0

nomprog:     .DC.b "biiprog\bii4"
nomprog2:    .DC.b "000.prg",0
             .EVEN 
chidamov:    .DC.b "chidam\chidamov.prg",0
             .EVEN 
tubular:     .DC.b "tubular\tubular.prg",0
             .EVEN 
simu:        .DC.b "3d\simu3d1.prg",0
             .EVEN 
via:         .DC.b "via\via.prg",0
             .EVEN 



palettebob:: 
             .DC.w $0,$777,$765,$654,$543,$432,$321,$210,$200,$555,$444
             .DC.w $333,$222,$630,$63,$26



semait::     .DC.w 0
divtache:    .DC.w 0


indentdata:  .DC.b "DATA_BAT_2  "           ;identificateur pour disquette bat 2/data

mess1:       .DC.b "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

palette:     
             .DC.w $0,$777,$677,$344,$233,$221,$110,$122,$765,$543,$321,$210
             .DC.w $420,$531,$500,$332

palettechidam:         
             .DC.w 0,$777,$566,$344,$233,$221,$110,$122,$765,$543,$321
             .DC.w $210,$420,$531,$500,$332

palette951:  .DC.w $0,$777,$776,$775,$764,$731,$742,$621,$735,$610,$500,$400,$300,$200,$100,$0
palette952:  .DC.w $0,$777,$766,$765,$665,$655,$654,$544,$543,$433,$432,$421,$321,$311,$210,$100
palette953:  .DC.w $0,$0777,$0211,$0677,$0667,$0657,$0656,$0546,$0545,$0534,$0433,$0100,$0423,$0322,$0200,$0311
palette954:  .DC.w $0,$0777,$0677,$0667,$0566,$0556,$0455,$0445,$0344,$0334,$0233,$0223,$0122,$0112,$0011,$0001
palette955:  .DC.w $0,$0777,$0767,$0757,$0655,$0645,$0644,$0543,$0532,$0421,$0321,$0311,$0210,$0100,$0422,$0332
palette957:  .DC.w $0,$0677,$0677,$0667,$0667,$0556,$0655,$0544,$0544,$0433,$0434,$0322,$0322,$0321,$0211,$0777
palette958:  .DC.w $0,$0777,$0767,$0656,$0557,$0456,$0446,$0445,$0234,$0223,$0113,$0210,$0110,$0100,$0344


;---------------------------------------------------------------
;
; heureremap
;
; numero de la table de remap a utiliser en fonction de l'heure qu'il est
; 0h,1h,2h,3h etc...
;

heureremap:  .DC.b 2,2,2,2,2,1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1,2,2

remapjour:   .DC.w 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15    ;conserver l'ordre
remapsoir:   .DC.w 0,3,4,4,7,6,0,6,9,10,11,6,10,12,10,5     ;jour,soir,
remapnuit:   .DC.w 0,7,7,7,6,0,0,0,10,11,6,0,6,11,6,6       ;nuit.


remapvia0:   .DC.w 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15    ;conserver l'ordre
remapvia1:   .DC.w 0,4,2,7,3,6,2,6,13,9,15,12,15,15,14,5
remapvia2:   .DC.w 0,3,2,6,7,2,2,2,15,9,6,15,5,5,14,6

remaplunoc:  .DC.w 0,1,2,3,4,5,6,7,3,15,5,6,5,15,14,15


sensgauche   equ 0
sensdroit    equ 1
pasvisible   equ 2

dyno:        
dyno100:     .DC.w 101,sensgauche,102,sensdroit,-1
dyno101:     .DC.w 100,sensgauche,106,sensdroit,202,sensgauche,500,sensgauche,600,sensgauche,-1
dyno102:     .DC.w 103,sensdroit,104,sensdroit,105,sensdroit,106,sensgauche,100,sensgauche,-1
dyno103:     .DC.w 102,sensgauche,-1
dyno104:     .DC.w 102,sensdroit,-1
dyno105:     .DC.w 102,sensgauche,125,sensdroit,126,sensgauche,-1
dyno106:     .DC.w 102,sensdroit,107,sensdroit,111,sensgauche,101,sensgauche,-1
dyno107:     .DC.w 106,sensgauche,109,sensdroit,108,sensgauche,-1
dyno108:     .DC.w 129,sensgauche,107,sensdroit,-1
dyno109:     .DC.w 112,sensgauche,113,sensgauche,114,sensdroit,107,sensgauche,118,sensdroit,-1
dyno110:     
dyno111:     .DC.w 106,sensdroit,-1
dyno112:     .DC.w 109,sensgauche,-1
dyno113:     .DC.w 115,sensgauche,114,sensdroit,109,sensgauche,131,sensgauche,-1
dyno114:     .DC.w 113,sensgauche,109,sensgauche,118,sensdroit,133,sensdroit,-1
dyno115:     .DC.w 113,sensdroit,130,sensgauche,-1
dyno116:     
dyno117:     .DC.w 130,0,-1
dyno118:     .DC.w 119,sensdroit,122,sensgauche,123,sensgauche,124,sensgauche,120,sensdroit,121,sensdroit,109,sensdroit,114,sensgauche,-1
dyno119:     .DC.w 118,0,-1
dyno120:     .DC.w 118,sensgauche,-1
dyno121:     .DC.w 118,0,-1
dyno122:     .DC.w 118,0,-1
dyno123:     .DC.w 118,0,-1
dyno124:     .DC.w 118,0,-1
dyno125:     .DC.w 105,sensgauche,127,sensdroit,-1
dyno126:     .DC.w 105,sensdroit,-1
dyno127:     .DC.w 125,0,-1
dyno128:     .DC.w -1
dyno129:     .DC.w 108,sensgauche,-1
dyno130:     .DC.w 117,sensgauche,115,sensdroit,-1
dyno131:     .DC.w 113,sensgauche,132,sensgauche,-1
dyno132:     .DC.w 131,0,-1
dyno133:     .DC.w 114,pasvisible,-1

dyno200:     
dyno201:     .DC.w 215,sensgauche,208,sensdroit,214,sensgauche,-1
dyno202:     .DC.w 208,sensgauche,101,sensdroit,-1
dyno203:     
dyno204:     
dyno205:     
dyno206:     
dyno207:     
dyno208:     .DC.w 201,sensgauche,210,sensdroit,209,sensdroit,202,sensgauche,-1
dyno209:     .DC.w 208,sensgauche,-1
dyno210:     .DC.w 208,sensgauche,215,sensdroit,213,sensgauche,-1
dyno211:     
dyno212:     
dyno213:     .DC.w 210,sensdroit,-1
dyno214:     .DC.w 201,sensgauche,-1
dyno215:     .DC.w 201,sensdroit,210,sensgauche,300,sensdroit,-1

dyno300:     .DC.w 301,sensdroit,215,sensgauche,-1
dyno301:     .DC.w 300,sensgauche,401,sensdroit,-1
dyno302:     

dyno400:     .DC.w 401,sensdroit,-1
dyno401:     .DC.w 400,sensgauche,402,sensdroit,301,sensdroit,-1
dyno402:     .DC.w 401,sensgauche,403,sensgauche,404,sensdroit,-1
dyno403:     .DC.w 402,sensdroit,-1
dyno404:     .DC.w 402,sensgauche,405,sensdroit,-1
dyno405:     .DC.w 404,sensgauche,406,sensdroit,-1
dyno406:     .DC.w 405,sensgauche,407,sensgauche,408,sensdroit,-1
dyno407:     .DC.w 406,sensdroit,500,sensgauche,-1
dyno408:     .DC.w 406,sensgauche,-1
dyno409:     
dyno410:     

dyno500:     .DC.w 501,sensdroit,407,sensgauche,101,sensgauche,-1
dyno501:     .DC.w 500,sensgauche,504,sensgauche,502,sensdroit,524,sensdroit,-1
dyno502:     .DC.w 501,sensgauche,-1
dyno503:     .DC.w -1
dyno504:     .DC.w 501,sensdroit,505,sensgauche,506,sensdroit,-1
dyno505:     .DC.w 504,sensdroit,-1
dyno506:     .DC.w 504,sensgauche,511,sensgauche,510,sensgauche,512,sensdroit,507,sensdroit,-1
dyno507:     .DC.w 506,sensgauche,509,sensdroit,-1
dyno508:     .DC.w 509,sensgauche,-1
dyno509:     .DC.w 508,sensdroit,507,sensgauche,-1
dyno510:     .DC.w 506,sensdroit,-1
dyno511:     .DC.w 506,sensdroit,-1
dyno512:     .DC.w 513,sensgauche,506,sensgauche,514,sensdroit,-1
dyno513:     .DC.w 512,sensdroit,-1
dyno514:     .DC.w 512,sensgauche,515,sensgauche,518,sensdroit,-1
dyno515:     .DC.w 514,sensdroit,516,sensgauche,-1
dyno516:     .DC.w 515,sensdroit,-1
dyno517:     
dyno518:     .DC.w 514,sensgauche,519,sensdroit,-1
dyno519:     .DC.w 518,sensgauche,523,sensdroit,520,sensdroit,-1
dyno520:     .DC.w 519,sensgauche,521,sensdroit,-1
dyno521:     .DC.w 520,sensgauche,522,sensdroit,-1
dyno522:     .DC.w 521,sensgauche,-1
dyno523:     .DC.w 524,sensgauche,519,sensdroit,-1
dyno524:     .DC.w 523,sensdroit,525,sensdroit,501,sensgauche,-1
dyno525:     .DC.w 524,sensgauche,-1

dyno600:     .DC.w 601,sensgauche,101,sensdroit,613,sensdroit,-1
dyno601:     .DC.w 602,sensgauche,600,sensdroit,605,sensdroit,-1
dyno602:     .DC.w 601,pasvisible,603,pasvisible,-1
dyno603:     .DC.w 602,sensdroit,-1
dyno604:     
dyno605:     .DC.w 601,pasvisible,606,pasvisible,-1
dyno606:     .DC.w 605,sensdroit,607,sensgauche,609,sensdroit,-1
dyno607:     .DC.w 608,pasvisible,606,pasvisible,-1
dyno608:     .DC.w 607,sensdroit,-1
dyno609:     .DC.w 606,sensgauche,610,sensdroit,-1
dyno610:     .DC.w 609,sensgauche,611,sensdroit,-1
dyno611:     .DC.w 610,pasvisible,-1
dyno612:     
dyno613:     .DC.w 614,sensdroit,600,sensgauche,616,sensgauche,-1
dyno614:     .DC.w 613,sensgauche,-1
dyno615:     
dyno616:     .DC.w 617,sensdroit,613,sensgauche,628,sensgauche,-1
dyno617:     .DC.w 616,sensgauche,-1
dyno618:     
dyno619:     
dyno620:     
dyno621:     
dyno622:     
dyno623:     
dyno624:     
dyno625:     
dyno626:     
dyno627:     
dyno628:     .DC.w 616,pasvisible,630,pasvisible,-1
dyno629:     
dyno630:     .DC.w 628,sensdroit,631,sensgauche,-1
dyno631:     .DC.w 630,sensdroit,632,sensdroit,-1
dyno632:     .DC.w 631,sensdroit,633,sensgauche,-1
dyno633:     .DC.w 632,sensdroit,600,sensgauche,-1

dyno700:     .DC.w 701,pasvisible,-1
dyno701:     .DC.w 710,sensgauche,709,sensgauche,700,sensgauche,702,sensdroit,704,sensdroit,-1
dyno702:     .DC.w 703,pasvisible,701,pasvisible,-1
dyno703:     .DC.w 702,pasvisible,-1
dyno704:     .DC.w 701,pasvisible,705,pasvisible,-1
dyno705:     .DC.w 704,sensgauche,-1
dyno706:     
dyno707:     .DC.w 708,sensgauche,-1
dyno708:     .DC.w 707,sensdroit,709,sensgauche,-1
dyno709:     .DC.w 708,sensdroit,701,sensgauche,-1
dyno710:     .DC.w 701,sensdroit,-1

dyno9999:    .DC.w 9999,0,-1

dynooffset:  
             .DC.w 100,dyno100-dyno
             .DC.w 101,dyno101-dyno
             .DC.w 102,dyno102-dyno
             .DC.w 103,dyno103-dyno
             .DC.w 104,dyno104-dyno
             .DC.w 105,dyno105-dyno
             .DC.w 106,dyno106-dyno
             .DC.w 107,dyno107-dyno
             .DC.w 108,dyno108-dyno
             .DC.w 109,dyno109-dyno
             .DC.w 110,dyno110-dyno
             .DC.w 111,dyno111-dyno
             .DC.w 112,dyno112-dyno
             .DC.w 113,dyno113-dyno
             .DC.w 114,dyno114-dyno
             .DC.w 115,dyno115-dyno
             .DC.w 116,dyno116-dyno
             .DC.w 117,dyno117-dyno
             .DC.w 118,dyno118-dyno
             .DC.w 119,dyno119-dyno
             .DC.w 120,dyno120-dyno
             .DC.w 121,dyno121-dyno
             .DC.w 122,dyno122-dyno
             .DC.w 123,dyno123-dyno
             .DC.w 124,dyno124-dyno
             .DC.w 125,dyno125-dyno
             .DC.w 126,dyno126-dyno
             .DC.w 127,dyno127-dyno
             .DC.w 128,dyno128-dyno
             .DC.w 129,dyno129-dyno
             .DC.w 130,dyno130-dyno
             .DC.w 131,dyno131-dyno
             .DC.w 132,dyno132-dyno
             .DC.w 133,dyno133-dyno

             .DC.w 200,dyno200-dyno
             .DC.w 201,dyno201-dyno
             .DC.w 202,dyno202-dyno
             .DC.w 203,dyno203-dyno
             .DC.w 204,dyno204-dyno
             .DC.w 205,dyno205-dyno
             .DC.w 206,dyno206-dyno
             .DC.w 207,dyno207-dyno
             .DC.w 208,dyno208-dyno
             .DC.w 209,dyno209-dyno
             .DC.w 210,dyno210-dyno
             .DC.w 211,dyno211-dyno
             .DC.w 212,dyno212-dyno
             .DC.w 213,dyno213-dyno
             .DC.w 214,dyno214-dyno
             .DC.w 215,dyno215-dyno

             .DC.w 300,dyno300-dyno
             .DC.w 301,dyno301-dyno
             .DC.w 302,dyno302-dyno

             .DC.w 400,dyno400-dyno
             .DC.w 401,dyno401-dyno
             .DC.w 402,dyno402-dyno
             .DC.w 403,dyno403-dyno
             .DC.w 404,dyno404-dyno
             .DC.w 405,dyno405-dyno
             .DC.w 406,dyno406-dyno
             .DC.w 407,dyno407-dyno
             .DC.w 408,dyno408-dyno
             .DC.w 409,dyno409-dyno
             .DC.w 410,dyno410-dyno

             .DC.w 500,dyno500-dyno
             .DC.w 501,dyno501-dyno
             .DC.w 502,dyno502-dyno
             .DC.w 503,dyno503-dyno
             .DC.w 504,dyno504-dyno
             .DC.w 505,dyno505-dyno
             .DC.w 506,dyno506-dyno
             .DC.w 507,dyno507-dyno
             .DC.w 508,dyno508-dyno
             .DC.w 509,dyno509-dyno
             .DC.w 510,dyno510-dyno
             .DC.w 511,dyno511-dyno
             .DC.w 512,dyno512-dyno
             .DC.w 513,dyno513-dyno
             .DC.w 514,dyno514-dyno
             .DC.w 515,dyno515-dyno
             .DC.w 516,dyno516-dyno
             .DC.w 517,dyno517-dyno
             .DC.w 518,dyno518-dyno
             .DC.w 519,dyno519-dyno
             .DC.w 520,dyno520-dyno
             .DC.w 521,dyno521-dyno
             .DC.w 522,dyno522-dyno
             .DC.w 523,dyno523-dyno
             .DC.w 524,dyno524-dyno
             .DC.w 525,dyno525-dyno

             .DC.w 600,dyno600-dyno
             .DC.w 601,dyno601-dyno
             .DC.w 602,dyno602-dyno
             .DC.w 603,dyno603-dyno
             .DC.w 604,dyno604-dyno
             .DC.w 605,dyno605-dyno
             .DC.w 606,dyno606-dyno
             .DC.w 607,dyno607-dyno
             .DC.w 608,dyno608-dyno
             .DC.w 609,dyno609-dyno
             .DC.w 610,dyno610-dyno
             .DC.w 611,dyno611-dyno
             .DC.w 612,dyno612-dyno
             .DC.w 613,dyno613-dyno
             .DC.w 614,dyno614-dyno
             .DC.w 615,dyno615-dyno
             .DC.w 616,dyno616-dyno
             .DC.w 617,dyno617-dyno
             .DC.w 618,dyno618-dyno
             .DC.w 619,dyno619-dyno
             .DC.w 620,dyno620-dyno
             .DC.w 621,dyno621-dyno
             .DC.w 622,dyno622-dyno
             .DC.w 623,dyno623-dyno
             .DC.w 624,dyno624-dyno
             .DC.w 625,dyno625-dyno
             .DC.w 626,dyno626-dyno
             .DC.w 627,dyno627-dyno
             .DC.w 628,dyno628-dyno
             .DC.w 629,dyno629-dyno
             .DC.w 630,dyno630-dyno
             .DC.w 631,dyno631-dyno
             .DC.w 632,dyno632-dyno
             .DC.w 633,dyno633-dyno

             .DC.w 700,dyno700-dyno
             .DC.w 701,dyno701-dyno
             .DC.w 702,dyno702-dyno
             .DC.w 703,dyno703-dyno
             .DC.w 704,dyno704-dyno
             .DC.w 705,dyno705-dyno
             .DC.w 706,dyno706-dyno
             .DC.w 707,dyno707-dyno
             .DC.w 708,dyno708-dyno
             .DC.w 709,dyno709-dyno
             .DC.w 710,dyno710-dyno
             .DC.w 9999,dyno9999-dyno
dynooffsetfin:         


             .IF disquedur=1


nomsimu1:    .DC.b "biiprog\bii6001.dat",0
nomsimu2:    .DC.b "biiprog\bii6002.dat",0
nomsimu3:    .DC.b "biiprog\bii6003.dat",0
nomsimu4:    .DC.b "biiprog\bii6004.dat",0
nomsimu5:    .DC.b "biiprog\bii6005.dat",0

nomdial:     .DC.b "biiprog\bii6020.dat",0


             .EVEN 

nom0:        .DC.b "newbii\dyno"
nomno:       .DC.b "100.bii",0

             .EVEN 
nomsnd:      .DC.b "temposnd\snd_"
nomsndno:    .DC.b "000",0

             .EVEN 
astroext1:   .DC.b "sons\sequence\bii5004.se1",0
             .EVEN 
astroext2:   .DC.b "sons\sequence\bii5004.se2",0


             .EVEN 
arcade1:     .DC.b "sons\sequence\bii5008.se1",0
             .EVEN 
arcade2:     .DC.b "sons\sequence\bii5008.se2",0


             .EVEN 
oiseaux1:    .DC.b "sons\sequence\bii5006.se1",0
             .EVEN 
oiseaux2:    .DC.b "sons\sequence\bii5006.se2",0

             .EVEN 

             .ENDIF 

;---------------------------------------------------------------
;menus

menuhg0:     .DC.w $0,$0,$0,$ffff
menuhg1:     .DC.w $7fff,$0,$0,$ffff
menuhg2:     .DC.w $4000,$3fff,$0,$ffff
menug:       .DC.w $5fff,$2000,$0,$ffff

menubg0:     .DC.w $6000,$0,$0,$ffff
menubg1:     .DC.w $7fff,$0,$0,$ffff
menubd2:     
menubg2:     .DC.w $0,$ffff,$0,$ffff

menub0:      
menuh0:      .DC.w $0,$0,$0,$ffff

menum:       
menub1:      
menuh1:      .DC.w $ffff,$0,$0,$ffff

menub2:      
menuh2:      .DC.w $0,$ffff,$0,$ffff

menuhd0:     .DC.w $0,$0001,$0,$ffff
menuhd1:     .DC.w $fffe,$0001,$0,$ffff
menuhd2:     .DC.w $0006,$fff9,$0,$ffff
menud:       .DC.w $fffa,$0001,$0000,$ffff

menubd0:     .DC.w $0002,$0001,$0,$ffff
menubd1:     .DC.w $fffe,$0001,$0,$ffff

menucarreplein:        
             .DC.w $6,$6,$4,$200,$fc00,$0,$fe06,$7df0,$c406,$6,$fe04,$7c00
             .DC.w $a800,$0,$fe00,$7c00,$9000,$0,$fe00,$7c00,$a800,$0,$fe00
             .DC.w $7c00,$c400,$0,$fe00,$8000,$0,$0,$fe00
menucarrevide:         
             .DC.w $6,$6,$4,$200,$fc00
             .DC.w $0,$fe00,$7c00,$8006,$6,$fe04,$7c00,$8000,$0,$fe00,$7c00
             .DC.w $8000,$0,$fe00,$7c00,$8000,$0,$fe00,$7c00,$8000,$0,$fe00
             .DC.w $8000,$0,$0,$fe00


marsize      equ 64

marnom       equ 0
marpotvie    equ 11
marforce     equ 12
marintel     equ 13
marreflex    equ 14
marvital     equ 15
marpercep    equ 16
marcharis    equ 17
marstock     equ 18
marchambre   equ 20
marpatron    equ 20
maradrstock  equ 22
marcodegen   equ 26
;marleader     equ 30
marmetier    equ 30
marlove      equ 31
marsavoir    equ 32
marvbl       equ 60

marlovel7    equ 59

nombremarchand         equ 39



stck5000::   .DC.w 929,-1
stck5001::   .DC.w -1
stck5002::   .DC.w -1
stck5003::   .DC.w 1004,-1
stck5004::   .DC.w 4,17,95,-1               ;bar sans alcool 5004,5,6
stck5005::   .DC.w 4,17,95,-1               ;bar sans alcool 5004,5,6
stck5006::   .DC.w 4,17,95,-1               ;bar sans alcool 5004,5,6
stck5007::   .DC.w -1

;le stock 5008 est dans SAUVERPA car il est modifier par reappro

stck5009::   .DC.w 5,12,22,-1               ;pharmacie 5009
stck5010::   .DC.w 14,21,28,35,-1           ;farce et attrapes
stck5011::   .DC.w 4,17,95,32,33,101,-1     ;bar S5
stck5012::   .DC.w 4,17,31,73,74,76,77,78,81,83,95,-1       ;alim 120
stck5013::   .DC.w -1
stck5014::   .DC.w 4,17,95,32,3,-1          ;bar S2
stck5015::   .DC.w 21,35,46,47,48,49,53,54,55,56,57,58,59,60,61
             .DC.w 62,63,64,65,66,68,71,72,102,103,-1       ; armurier s5
stck5016::   .DC.w -1
stck5017::   .DC.w 928,-1
stck5018::   .DC.w 10,20,84,86,-1           ;electromenager s1
stck5019::   .DC.w 41,66,84,85,102,103,-1   ;bazar s2
stck5020::   .DC.w 82,5,22,-1
stck5021::   .DC.w -1
stck5022::   .DC.w -1
stck5023::   .DC.w -1
stck5024::   .DC.w 4,17,95,33,3,34,39,-1    ;bar S5 senex
stck5025::   .DC.w 4,17,95,25,34,39,101,80,-1     ;bar 408
stck5026::   .DC.w 5,12,22,8,-1             ;pharmacie 5026 s5
stck5027::   .DC.w 0,21,35,67,69,70,105,-1  ;vetements s1
stck5028::   .DC.w -1
stck5029::   .DC.w 4,25,27,34,39,73,74,76,77,78,79,80,81,83,86,-1     ;marchand s4
stck5030::   .DC.w 4,25,27,34,39,73,74,76,77,78,79,80,81,83,86,-1     ;marchand s4
stck5031::   .DC.w 4,25,27,34,39,73,74,76,77,78,79,80,81,83,86,-1     ;marchand s4
stck5032::   .DC.w 5,6,11,21,27,29,73,74,78,79,80,83,85,86,-1         ;marchand s5
stck5033::   .DC.w -1
stck5034::   .DC.w -1
stck5035::   .DC.w 16,21,23,24,35,47,0,67,85,-1   ;marchand s5
stck5036::   .DC.w 4,6,17,29,31,80,81,83,86,95,-1 ;kfet s1
stck5037::   .DC.w 27,29,31,76,79,83,86,95,4,-1   ;wac do
stck5038::   .DC.w 4,6,34,86,-1             ;pizza s3



biicondition:          .DC.l biic0,biic1,biic2,biic3,biic4,biic5,biic6,biic7
             .DC.l biic8,biic9,biic10,biic11,biic12,biic13,biic14
             .DC.l biic15,biic16,biic17,biic18,biic19,biic20,biic21
             .DC.l biic22,biic23,biic24,biic25,biic26,biic27
             .DC.l biic28,biic29,biic30,biic31,biic32,biic33,biic34
             .DC.l biic35,biic36,biic37,biic38


dialcond:    .DC.l dialc0,dialc1,dialc2,dialc3,dialc4,dialc5
             .DC.l dialc6,dialc7,dialc8,dialc9


pausetache0: .DC.w 0


palettemort: 
             .DC.w $0,$777,$776,$775,$764,$753,$742,$621,$731,$610,$500
             .DC.w $400,$300,$200,$100,$0


sujetobjetliste:       .DC.w 9,10,12,13,21,27,28,29,30,31,32,-1
objettypeliste:        .DC.w 20,28,41,8,0,16,7,24,23,10,12




;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------
;---------------------------------------------------------------



             .BSS 
bss:         

debutpile:   
             .DS.l 500
pile:        



;---------------------------------------------------------------
;gestion dynamique de la memoire

fastpossible           equ 4
typefast     equ 2
typechip     equ 1


memtaillebloc          equ 0
memadrbloc   equ 4
memetatbloc  equ 8
;                      bit 0-1: type de memoire 1=chip 2=fast
;                      bit 2:   1=bloc en chip pouvant etre deplace en fast
;                      bit 3:   1=verouille (en cours d'utilisation, ne
;                               peut etre efface.
memagebloc   equ 10
memtypebloc  equ 14

memnbblocmax           equ 200

memtri:      .DS.b 6*memnbblocmax
memtable:    .DS.b 16*memnbblocmax




;---------------------------------------------------------------

sect:        .DS.w 1
exc:         .DS.l 1

adrbsour::   .DS.l 1
bsour::      .DS.b 64  ;32

ex_pile:     .DS.l 1

sys00::      .DS.l 1   ;ecran physique
sys01::      .DS.l 1   ;ecran logique

exphy:       .DS.l 1
exlog:       .DS.l 1

;---------------------------------------------------------------
;animations

nbanimstatmax          equ 40

animstatcour:          .DS.w 1
animstatnb:  .DS.w 1   ;nombre d'animations statiques

animdebut:   .DS.l nbanimstatmax
animpc:      .DS.l nbanimstatmax
animfin:     .DS.w nbanimstatmax            ;-1=fini
animpause:   .DS.w nbanimstatmax
anima:       .DS.w nbanimstatmax


;---------------------------------------------------------------
;multi tache

tachecour::  .DS.w 1   ;numero de la tache courante

ppile::      .DS.l 5   ;emplacement pour les 5 pointeurs de pile


dpilet0:     
             .DS.l 1000
pilet0::     
             .DS.l 1000
pilet1::     

tacheon::    .DS.w 5
prio::       .DS.w 5
priocour::   .DS.w 1

;---------------------------------------------------------------
;ecran

ecran:       .DS.b 64256

quart1no:    .DS.w 1   ;numero de l'image affichee dans le 1er quart d'ecran
quart1coin:  .DS.w 1   ;(1 a 4) numero du quart d'ecran qui contient le coin de l'image affichee dans le quart d'ecran 1
quart1offsx: .DS.w 1   ;offset x de l'image affichee dans le quart d'ecran 1
quart1offsy: .DS.w 1   ;offset y      "             "
quart2no:    .DS.w 1
quart2coin:  .DS.w 1
quart2offsx: .DS.w 1
quart2offsy: .DS.w 1
quart3no:    .DS.w 1
quart3coin:  .DS.w 1
quart3offsx: .DS.w 1
quart3offsy: .DS.w 1
quart4no:    .DS.w 1
quart4coin:  .DS.w 1
quart4offsx: .DS.w 1
quart4offsy: .DS.w 1


ancien1:     .DS.w 1   ;1|2
ancien2:     .DS.w 1   ;-+-
ancien3:     .DS.w 1   ;3|4
ancien4:     .DS.w 1   ;date d'affichage du quart d'ecran

ancienc:     .DS.w 1   ;conpteur pour anciennete de l'ecran


exnocour::   .DS.w 1   ;on stocke ici le numero de l'ancienne image courante
adrbiicour:: .DS.l 1   ;adresse du bloc bii courant
adrdicour::  .DS.l 1   ;adresse des donnees image courantes

offsetx:     .DS.w 1   ;decalage horizontal en multiple de 16
offsety:     .DS.w 1   ;     "   vertcal ...
exoffsetx:   .DS.w 1   ;decalage horizontal en multiple de 16
exoffsety:   .DS.w 1   ;     "   vertcal ...
offmaxx:     .DS.w 1   ; decalage h max
offmaxy:     .DS.w 1   ; decalage v max
xaff:        .DS.w 1   ;largeur de la fenetre en multiple de 16 (10 ou 20)
yaff:        .DS.w 1   ;hauteur de la fenetre (5 ou 10)
coinx:       .DS.w 1   ;coordo x du coin de la fenetre
coiny:       .DS.w 1

;---------------------------------------------------------------
;bob

ecranpetitbob:         .DS.b 160/2*26
buftextbob:: .DS.b 24
textbobplein::         .DS.w 1
scrolltextbob:         .DS.w 1



;---------------------------------------------------------------
;bulles

formatphd:   .DS.w 10*2                     ;delta x,nb mots,delta x, etc...,-1
adrlocalbulle:         .DS.l 1              ;adresse des variables locales pour bulles
adrpilebulle:          .DS.l 1
adrpbcour:   .DS.l 1
adrphrasecour:         .DS.l 1              ;adresse du descripteur de la phrase courante
phraseepuisee:         .DS.l 6              ;6*32=192 phrases principales max

tetecour:    .DS.w 1   ;numero de la tete courante (de 0 a 4) 5=inv marchand 6=video

bufmotsex:   .DS.b 30

;---------------------------------------------------------------
;objets

nbobjfreresmax         equ 100

perce        equ 8
marche       equ 4
rigide       equ 2
lie          equ 1
unseul       equ 16

pasperce     equ 0
pasmarche    equ 0
pasrigide    equ 0
paslie       equ 0
plusieurs    equ 0

x16obj:      .DS.w 1   ;position x de l'objet /16
yobj:        .DS.w 1   ;position y
objcour:     .DS.w 1   ;numero de l'objet courant

freresobj:   .DS.w nbobjfreresmax+2         ;buffer pour objets du meme niveau
adrfrere:    .DS.l 1   ;pointe sur le frere courant

objget:      .DS.w 1   ;numero de l'objet qui est pris (-1 si aucun)
adrobj:      .DS.l 1   ;adresse des donnees graphiques de l'objet

racineobj:   .DS.w 1   ;numero du proprietaire de la racine de l'inventaire
;---------------------------------------------------------------
;menus

menunbtextmax          equ 40

menux:       .DS.w 1
menuy:       .DS.w 1
menul:       .DS.w 1   ;largeur en pixels (multiple de 16, minimuim 48)
menuh:       .DS.w 1   ;nombre de pixels de haut=8+menunbl*8
menunbl:     .DS.w 1   ;nombre de lignes du menu
menuval:     .DS.w 1   ;valeur du menu en sortie
menuvalr:    .DS.w 1   ;valeur du menu en sortie (relatif)

menutxlst:   .DS.l menunbtextmax+1          ;liste des adresses des textes (-1=fin)

adrlocalconfig:        .DS.l 1              ;adresse des variables locales pour config

menuoffset:  .DS.w 1


;---------------------------------------------------------------
;disque

mapping:     .DS.b 512*9
mappingend:  

buf512::     .DS.b 512





;---------------------------------------------------------------
;divers

xperso:      .DS.w 1
exxperso:    .DS.w 1
adrperso:    .DS.l 1
perso:       .DS.b 32*62/2
persoma:     .DS.b 32*62/2/4
perso48a:    .DS.b 48*62/2
perso48ma:   .DS.b 48*62/2/4
perso48b:    .DS.b 48*62/2
perso48mb:   .DS.b 48*62/2/4


;---------------------------------------------------------------
;divers

poly:        .DS.l 20  ;buffer pour points polygone et polyline
poly2:       .DS.l 20  ;buffer pour points polygone et polyline


bufremap:    .DS.w 16

etapeanim:   .DS.w 1

testevi:     .DS.l 1
senspersocour:         .DS.w 1
;adrbii911:    .DS.l 1
;adrdi911:     .DS.l 1

disquecour:  .DS.w 1
disquecourb: .DS.w 1



marchandlst: .DS.w 5   ;liste des marchands dans l'image courante
marchandcour:          .DS.w 1

inventtype:  .DS.w 1   ;0=normal 1=marchand acheter 2=marchand voler
;                       3=evi donner 4=evi acheter 5=evi vendre
;                       6=prendre (groupe)

intertype:   .DS.w 1   ;0=evi 1=marchand 2=groupe 3=video evi 4=video groupe

humeur:      .DS.w 1   ;0=fleurs 1=normal 2=piquants 3=piquants rouges
adrevicour:: .DS.l 1

coltxton:    .DS.w 1   ;couleur pour textes bulles
coltxtoff:   .DS.w 1   ;couleur pour textes bulles

adrmetier:   .DS.l 1
menusouris:  .DS.w 1

prix:        .DS.l 1
negotype:    .DS.w 1
negoprix:    .DS.l 1
negoprec:    .DS.w 1   ;etat de la nego precedente

listeprix:   .DS.l 7

newnocour:   .DS.w 1

stoptache1:  .DS.w 1

evicourt1:   .DS.w 1   ;evicour temporaire pour la tache 1
persogroupdecal:       .DS.w 1

topogroupeadr:         .DS.l 5              ;adresse des 5 evi du groupe (0=personne)
topogroupe:  .DS.w 5   ;offset en fonction de tetecour (0,1,2,3 ou 4)


trame:       .DS.w 1   ;utilise par affpersotete


exlistemission:        .DS.b 5*2+5*6

combatfuite: .DS.w 1

videoobjadr: .DS.l 1   ;adresse de l'objet videophone

combat_a0:   .DS.w 1

_nflops:     .DS.w 1

             .IF boot=0
exlinea:     .DS.l 1
             .ENDIF 


bufseq1:     .DS.b 320
bufseq2:     .DS.b 320

soncour1:    .DS.w 1
soncour2:    .DS.w 1


forcdiv16:   .DS.w 1
refldiv16:   .DS.w 1

varbobprev:: .DS.w 1   ;variable utilisee pour le reveil du joueur avec PREVENIR (BOB)


