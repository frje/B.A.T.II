             bra       etiq1
etiq:        
             lea.l     partie2b,a1
             move.w    #1,d6

afftx88::    
             movea.l   a0,a1
             move.w    d0,d6
;***********************************************************
;******     affichage d' un texte                  ********
;******       fonte 8*8*1                          ********
;* entrees:                                        ********
;*    a1.l pointe sur le texte                     ********
;*    d6.w nombre de ligne du texte                ********
;***********************************************************
affitx:      
nbwait1      equ 50*15
             bsr       effacement
;     effacement de la souris
             clr.w     souri_11


             movea.l   sys01,a0
             lea.l     160*100(a0),a0       ; milieu d'ecran
             move.w    d6,d5
             subq.w    #1,d6
             beq       effaffitx
             lsr.w     #1,d5
             mulu.w    #14*160,d5
             suba.w    d5,a0
effaffitx:   
             bsr       texte
             movem.l   d6/d7/a0/a1,-(sp)
             jsr       ecrswap
             movem.l   (sp)+,d6/d7/a0/a1
             lea.l     160*14(a0),a0        ; saute 14 lignes
             dbra      d6,effaffitx
             lea.l     palettetx,a0
             jsr       degraon
             bsr       attente1
             lea.l     palettetx,a0
             jsr       degraoff
             bsr       effacement
             rts       
;**********************************************
;**   SINCHRONISATION              ************
;**********************************************
attente1:    
             move.l    contvbl,d0
             addi.l    #nbwait1,d0
att11:       
             cmp.l     contvbl,d0
             tst.w     souri_5
             bne       att12
             bge       att11
att12:       
             rts       

etiq1::      
             lea.l     obseques,a1
             move.w    #36,d6

scrolltx::   
             movea.l   a0,a1
             move.w    d0,d6

;***********************************************************
;******     scrolling d' un texte                  ********
;******       fonte 8*8*1                          ********
;* entrees:                                        ********
;*    a1.l pointe sur le texte                     ********
;*    d6.w nombre de ligne du texte                ********
;***********************************************************


nbwait       equ 2
attenteq     equ 182
             subq.w    #2,d6
             movem.l   d6/a1,-(sp)
;     effacement de la souris
             clr.w     souri_11
;************ !  SOURI_9 N'EST PAS EN OVERLAY
;csou:
;                tst.w      souri_9
;               bne        csou

             bsr       effacement
             lea.l     palettetx,a0
             jsr       degraon

;      met a 1 les 3 derniers plans sur les 14 dernieres lignes
             move.w    #(560/2)-1,d7
             movea.l   sys00,a0
             lea.l     160*186(a0),a0
             move.l    #$0000ffff,d1
             move.l    #-1,d2
eff3:        
             move.l    d1,(a0)+
             move.l    d2,(a0)+
             dbra      d7,eff3
             move.w    #(560/2)-1,d7
             movea.l   sys01,a0
             lea.l     160*186(a0),a0
             move.l    #$0000ffff,d1
             move.l    #-1,d2
eff4:        
             move.l    d1,(a0)+
             move.l    d2,(a0)+
             dbra      d7,eff4
;   couleur du texte
             move.w    #$777,$ff8242
;   affichage de la 1' ligne
             movem.l   (sp)+,d6/a1
             move.w    #attenteq,varatt
             bsr       affuneligne
;***********    ne pas alterer a1   *************

lafftxt1:    
             move.w    #14-1,d7             ; scrole de 14 lignes
l_afftxt:    
             bsr       scrole1ligne
             tst.w     varatt
             bgt       fattentesouri
             bsr       attentesouri
fattentesouri:         
             bsr       attente
             cmpi.w    #3,souri_5
             beq       finsc
             movem.l   d6/d7/a1,-(sp)
             jsr       ecrswap
             movem.l   (sp)+,d6/d7/a1
             dbra      d7,l_afftxt
             bsr       affuneligne
             dbra      d6,lafftxt1
;                               efface l'ecran
             move.w    #14-1,d7
l_afftxt2:   
             bsr       scrole1ligne
             bsr       attente
             cmpi.w    #1,souri_5
             beq       finsc
             movem.l   d6/d7/a1,-(sp)
             jsr       ecrswap
             movem.l   (sp)+,d6/d7/a1
             dbra      d7,l_afftxt2
             bsr       attentesouri
finsc:       
             lea.l     palettetx,a0
             jsr       degraoff
             bsr       effacement
             rts       
;************************************************
;***  attente de clic apres une page       ****
;*************************************************
attentesouri:          
             move.w    #attenteq,varatt
             tst.w     souri_5
             beq       attentesouri
             rts       
;**********************************************
;**   SINCHRONISATION              ************
;**********************************************
attente:     
             move.l    contvbl,d0
             addi.w    #nbwait,d0
att1:        
             cmpi.w    #2,souri_5
             beq       fatt1
             cmp.l     contvbl,d0
             bge       att1
fatt1:       
             rts       
;************************************************
;**   effacement des deux ecrans              ***
;************************************************

effacement:  
;   efface les 4 plans des deux ecrans
             move.w    #8000-1,d7
             movea.l   sys00,a0
eff1:        
             move.l    #0,(a0)+
             dbra      d7,eff1
             move.w    #8000-1,d7
             movea.l   sys01,a0
eff2:        
             move.l    #0,(a0)+
             dbra      d7,eff2
             rts       

;***************************************************************
;******     affiche une ligne a la fin de l'ecran logique    ****
;***************************************************************
affuneligne: 
             movea.l   sys00,a0
             lea.l     186*160(a0),a0
             bsr       texte                ; 1'ligne
             rts       
;****************************************
;***    scroling de 1 ligne     *********
;****************************************
scrole1ligne:          
             movea.l   sys00,a0
             movea.l   sys01,a2
             adda.l    #160,a0
             move.w    #194-1,d0            ; -> ecra 320/214 4160
loopligne:   
             .REPT 20
             move.w    (a0)+,(a2)+
             addq.l    #6,a0
             addq.l    #6,a2
             .ENDR 
             dbra      d0,loopligne
             subi.w    #1,varatt
             rts       
;***************************************************************
;***************************************************************
; Affiche une ligne de texte sur 1 plan (fonte 8x8)
;
; -> a0 : adresse ecran
; -> a1 : adresse de la chaine
; -> l'adresse de la fonte est : "fonte"
; la chaine doit se terminer par un zero
; la fonte est sauvegardeee sous forme d'un sprite avec
; les lettres qui se suivent sur le dessin (code 33 a 103):
; 1er ligne lettre A, 1ere ligne lettre B ...
; 2eme ligne lettre A, 2eme ligne lettre B ...
;

; format du sprite
nblettres    equ 64    ; nbre lettres = nbre d'octets de large


texte:       
             movem.l   d0/d6/d7/a0/a2/a3,-(sp)
             moveq.l   #1,d7
             moveq.l   #7,d6
; recherche la longueur de la chaine
; pour la justifier sur 40 caracteres.
             movea.l   a1,a2
             moveq.l   #-1,d0
l_just0:     addq.l    #1,d0
             tst.b     (a2)+
             bne       l_just0
             move.w    #40,d1
             sub.w     d0,d1
             lsr.w     #1,d1
             move.w    d1,d0
             lsl.w     #2,d1
             lea.l     0(a0,d1.w),a0        ; decale a l'ecran suivant justification
             btst      #0,d0
             beq       riensaut
             subq.w    #3,a0
             exg.l     d6,d7
riensaut:    
; recupere un caractere
ltexte0:     
             moveq.l   #0,d0
             movea.l   a0,a3
             move.b    (a1)+,d0             ; caractere a afficher
             beq       fin_texte
             cmpi.w    #32,d0
             ble       espace
             subi.w    #32,d0
             lea.l     fonte8x8x1(pc),a2
             lea.l     0(a2,d0.w),a2        ; pointe sur le dessin de la fonte
; affiche la dessin de la fonte
             move.w    #7,d0
ltexte1:     move.b    (a2),(a3)            ; affiche une ligne
; passe a la ligne de dessin suivante
             lea.l     nblettres(a2),a2
             lea.l     160(a3),a3
             dbra      d0,ltexte1

espace:      
             adda.w    d7,a0                ; passe au caractere a droite
             exg.l     d6,d7
             bra       ltexte0

fin_texte:   
             movem.l   (sp)+,d0/d6/d7/a0/a2/a3
             rts       
;***************************************************************
fonte8x8x1:  
             .DC.w $18,$3614,$2,$18,$180c,$800,$0,$6,$0,$0,$0,$0,$0,$0,$0,$0
             .DC.w $8,$7c1c,$7c7e,$7e1c,$2218,$c62,$1041,$411c,$7c1c,$7c0c
             .DC.w $7e22,$4141,$262,$3e38,$301c,$0,$18,$1214,$1e24,$1c08,$3006
             .DC.w $1c00,$0,$c,$c06,$183c,$43c,$183c,$1818,$0,$0,$3c,$1c08
             .DC.w $3236,$3230,$3223,$6318,$c64,$3063,$6123,$3223,$3332,$1863
             .DC.w $6349,$6224,$4c30,$180c,$800,$18,$3e,$2854,$1410,$3006,$808
             .DC.w $0,$c,$161e,$2408,$c20,$3004,$242c,$0,$600,$3006,$221c,$3220
             .DC.w $3330,$3060,$6318,$c68,$3063,$7163,$3261,$3330,$1863,$625d
             .DC.w $3434,$830,$180c,$1400,$18,$14,$1828,$1800,$3006,$1c08,$0
             .DC.w $18,$3606,$2418,$1428,$380c,$1824,$1800,$1800,$c0c,$5d24
             .DC.w $3460,$3338,$3c60,$7f18,$c70,$3055,$5963,$3461,$361c,$1863
             .DC.w $3655,$1818,$1830,$c0c,$1400,$18,$7e,$c0a,$6e00,$3006,$83e
             .DC.w $1c,$18,$3606,$1c0c,$1414,$2418,$3c34,$c,$303e,$618,$653e
             .DC.w $3260,$3330,$3063,$6318,$c78,$3055,$4d63,$3061,$3406,$1863
             .DC.w $3c77,$2818,$3030,$c0c,$2200,$0,$28,$a15,$4f00,$3006,$8
             .DC.w $0,$30,$3406,$1004,$1e04,$2410,$240c,$0,$1800,$c00,$6762
             .DC.w $3222,$3230,$3062,$6318,$c6c,$3649,$4762,$302e,$3206,$1836
             .DC.w $3c63,$4c18,$2230,$60c,$0,$18,$28,$3c22,$3200,$3006,$8,$1800
             .DC.w $830,$1806,$3c38,$438,$3830,$1818,$180c,$63e,$3018,$5d43
             .DC.w $743c,$747e,$203e,$2210,$1866,$7c49,$431c,$3036,$313c,$181c
             .DC.w $1863,$4618,$7c30,$60c,$0,$0,$0,$0,$0,$180c,$0,$800,$0,$0
             .DC.w $0,$0,$0,$0,$4,$0,$0,$3e00,$0,$0,$6,$0,$3000,$0,$0,$3,$0
             .DC.w $0,$0,$0,$38,$1c,$3e


paltx::      
palettetx:   
             .DC.w 0,$777
             .DCB.w 14,0
varatt:      

