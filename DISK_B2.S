
;****************************************************
;*   ACCES AU DMA ET AU FDC DE MANIERE DIRECTE      *
;*   Les fonctions fournies sont :                  *
;*       Seldr   : Selection du disque et face      *
;*       ChgFace : Passage … la face suivante       *
;*       restore : Retour en piste 00               *
;*       seek    : Positionnement de la tete        *
;*       Stepin  : Avance de la tete d'une piste    *
;*       Force   : Force l'arret d'une commande     *
;*       readi   : Rourine de lecture               *
;*       writi                                      *
;*       Supint  : Supprime l'interruption sur err  *
;*       IsDiskOK: Test ‚tat Pret du FDC            *
;*       GetDma  : R‚cupŠre l'adresse DMA courante  *
;****************************************************


dmadat       equ $ff8604
dmamode      equ $ff8606
dmahi        equ $ff8609
gpip         equ $fffa01
mfp          equ gpip

speed        equ 1     ;0=2 ms 1=3ms 2=5ms 3=6ms
verify       equ 4
motor        equ 0
multipl      equ $10

cmdseek      equ $10+speed+motor
cmdrestor    equ $00000000+speed+verify+motor
cmdstepin    equ $50+speed+motor
cmdstepou    equ $70+speed+motor
cmdread      equ $80+motor
cmdwrite     equ $a0+motor

             .TEXT 

;---------------------------------------------------------------
;
; readexp
;
; lecture de l'experience d'un personage bat I
; gere le disquettes simple et double faces en 9 et 10 secteurs
;
; retour:  d0 niveau -1 si erreur
;          d1 experience
;

readexp::    
             moveq.l   #0,d0
             moveq.l   #1,d1
             lea.l     buf512,a0
             jsr       readi                ;lecture du boot sector
             jsr       waitdiskok

             lea.l     buf512,a0
             move.b    $18(a0),nbsect+1
             move.b    $1a(a0),nbface+1

             moveq.l   #2,d0
             sub.w     nbface,d0
             mulu.w    #10,d0
             addi.w    #21,d0
             sub.w     nbsect,d0
             moveq.l   #1,d1
             movea.l   #buf512,a0

             moveq.l   #6,d7
bexp:        
             movem.l   d0-d7/a0-a5,-(sp)


             jsr       readi
             jsr       waitdiskok
             bsr       existf1
             movem.l   (sp)+,d0-d7/a0-a5
             beq       findf1

             addq.w    #1,d0
             dbra      d7,bexp

             not.w     $ff8240
             moveq.l   #-1,d0
             rts       

findf1:      
             lea.l     buf512,a0
             move.b    27(a0),d0
             lsl.w     #8,d0
             move.b    26(a0),d0            ;numero de cluster

             add.w     d0,d0
             addi.w    #14,d0               ;secteur logique

             moveq.l   #0,d1
             move.w    d0,d1
             divu.w    nbsect,d1            ;pistelog
             move.l    d1,d2
             swap.w    d2                   ;secteur-1
             swap.w    d1
             clr.w     d1
             swap.w    d1
             move.w    d1,d3
             divu.w    nbface,d1            ;piste
             andi.w    #1,d3
             move.w    nbface,d4
             subq.w    #1,d4
             mulu.w    d4,d3                ;face


             mulu.w    #20,d1
             mulu.w    #10,d3
             move.w    d2,d0
             add.w     d1,d0
             add.w     d3,d0

             moveq.l   #1,d1
             lea.l     buf512,a0
             jsr       readi
             jsr       waitdiskok

             lea.l     buf512,a0
             move.l    44(a0),d0

             rts       

nbsect:      .DC.w 0
nbface:      .DC.w 0



waitdiskok:  
             jsr       isdiskok
             bne       waitdiskok
             rts       

;---------------------------------------------------------------
;
; existf1
;
; recherche si f1.sav existe dans le catalogue
;
; retour: a6 pointe sur le debut du nom
;

existf1:     
             lea.l     buf512,a6
             moveq.l   #15,d7               ;16*32=512
bef1:        
             cmpi.l    #"F1  ",(a6)
             bne       bef
             cmpi.l    #"    ",4(a6)
             bne       bef
             cmpi.w    #"SA",8(a6)
             bne       bef
             cmpi.b    #"V",10(a6)
             beq       ouif1
bef:         
             lea.l     32(a6),a6
             dbra      d7,bef1
pasf1:       
             moveq.l   #1,d7                ;z=0
             rts       
ouif1:       
             moveq.l   #0,d7                ;z=1
             rts       


seldr::      
;***************************************************
;* Selection du disque et de la face               *
;* D5.W =  2(A:0) 3(A:1) 4(B:0) 5(B:1) 0(Unselect) *
;* D6.B est modifie par la routine                 *
;* Bit Z=1 pas d'erreur
;***************************************************
             tst.w     d5
             bne       unsel2
             movem.l   d0,-(sp)
             move.l    #$40000,d0
motor0:      
             move.w    #$80,dmamode
             move.w    dmadat,d6
             btst      #7,d6
             beq       unsel3
             subq.l    #1,d0
             bne       motor0

unsel3:      
             movem.l   (sp)+,d0
unsel2:      
             eori.b    #7,d5
             move.w    sr,-(sp)
             ori.w     #$700,sr
             move.b    #$e,$ff8800
             move.b    $ff8800,d6
             andi.b    #$f8,d6
             or.b      d5,d6
             move.b    d6,$ff8802
             move.w    (sp)+,sr
             eori.b    #7,d5
             move.w    d5,d6
             bclr      #0,d6
             cmp.w     drv,d6
             beq       fin
             move.w    d6,drv
             beq       fin
             bsr       restore
fin:         rts       

drv:         .DC.w 0

chgface:     
;****************************************************
;* Assure le changement de face et piste en continu *
;* Aucun registre n'est modifi‚                     *
;****************************************************

             move.w    d6,-(sp)
             move.w    sr,-(sp)             ;8

             ori.w     #$700,sr             ;20
             move.b    #$e,$ff8800          ;20
             move.b    $ff8800,d6           ;16
             bchg      #0,d6                ;12
             move.b    d6,$ff8802           ;16
             move.w    (sp)+,sr             ;8
             btst      #0,d6                ;10
             beq       e                    ;8/10
             bsr       stepin               ;42500
e:           move.w    (sp)+,d6

             rts                            ;16   = 21400  (2.675 ms)



restore::    
;****************************************************
;* Positionne la tete de lecture sur la piste 0     *
;* Aucun registre n'est affect‚                     *
;* Bit Z=1 pas d'erreur                             *
;****************************************************


             move.w    #$80,dmamode
             move.w    #cmdrestor,dmadat
wait:        
             move.l    d0,-(sp)
             move.l    #$c00000,d0
e0:          subq.l    #1,d0
             beq       err
             btst      #5,gpip
             bne       e0
             move.l    (sp)+,d0
             ori.w     #$0004,sr
             rts       

err:         move.w    #$80,dmamode
             move.w    dmadat,d6
             move.l    (sp)+,d0
             clr.w     drv
             andi.w    #$271b,sr
             rts       

seek::       
;****************************************************
;* Positionne la tete de lecture en piste D0.W      *
;* D0.W contient le nø de piste - Aucune modif.     *
;* Bit Z=1 pas d'erreur                             *
;****************************************************

             move.w    #$86,dmamode
             move.w    d0,dmadat
             move.w    #$80,dmamode
             move.w    #cmdseek,dmadat
             bra       wait
stepin:      
;****************************************************
;* Avance la tete de lecture d'une piste            *
;* Aucun registre modifi‚ ni r‚actualis‚            *
;****************************************************

             move.w    #$80,dmamode         ;16
             move.w    #cmdstepin,dmadat    ;16
             bra       wait
force:       
;****************************************************
;* Force l'arret de la commande en cours            *
;* Probablement inutile dans la librairie           *
;* D7.W detruit                                     *
;****************************************************

             move.w    #$80,dmamode
             move.w    #$d0,dmadat
             move.w    #500,d7
e000:        
             dbra      d7,e000
             rts       

readi::      
;****************************************************
;* Routine de lecture par interruption              *
;* En entree D0.W =nø logique de 1er secteur … lire *
;*           D1.W =nombre de secteurs … lire        *
;*           a0.L =adresse du tampon de rangement   *
;
; si bit 15 de d0=1, lecteur B
;
;* Destruction de D4.W D5.W D6.W                    *
;****************************************************
             move.l    a0,d2
             move.w    d1,nsec
             moveq.l   #2,d5
;             ext.l    d0
;            tst.w    d0
;           bpl      e001
;          neg.l    d0
             bclr      #15,d0
             beq       e001
             addq.w    #2,d5
e001:        
             ext.l     d0
             divu.w    #20,d0
             move.l    d0,d4
             swap.w    d4
             cmpi.w    #10,d4
             blt       e002
             addq.w    #1,d5
             subi.w    #10,d4
e002:        addq.w    #1,d4
             move.w    d4,secteur
             bsr       seldr
             bne       erreur
             bsr       seek
             bne       erreur
             clr.w     errdsk
             move.l    d2,adr
             move.l    #readint,$11c
             bset      #7,mfp+8
             bset      #7,mfp+20
             pea       retour
             move.w    sr,-(sp)
             bra       readint

retour:      rts       
erreur:      
             move.w    #1,errdsk
             rts       

nsec:        .DC.w 0
adr:         .DC.l 0
secteur:     .DC.w 0
errdsk::     .DC.w 0


readint:     
;****************************************************
;* partie interruption li‚e a readi                 *
;* aucun registre detruit                           *
;****************************************************


             addq.w    #1,semait


             bclr      #7,mfp+20


             move.w    #$2500,sr
             tst.w     nsec
             beq       supint
             subi.w    #1,nsec
             move.b    adr+3,dmahi+4
             move.b    adr+2,dmahi+2
             move.b    adr+1,dmahi
             cmpi.w    #11,secteur
             bne       e6

             bsr       chgface

             move.w    #1,secteur
e6:          move.w    #$84,dmamode
             move.w    secteur,dmadat
             move.w    #$90,dmamode
             move.w    #$190,dmamode
             move.w    #$90,dmamode
             move.w    #1,dmadat
             move.w    #$80,dmamode
             move.w    #cmdread,dmadat
             addi.l    #$200,adr
             addi.w    #1,secteur
             bclr      #7,mfp+12

             bset      #7,mfp+20
             subq.w    #1,semait
             rte       

supint:      bclr      #7,mfp+8
             bclr      #7,mfp+12

             bset      #7,mfp+20            ;;;;;;;;;;;;;;;;
             subq.w    #1,semait



rte:         rte       
writi::      
;****************************************************
;* Routine d'ecriture par interruption              *
;* En entree D0.W =nø logique de 1er secteur … ecri *
;*           D1.W =nombre de secteurs … ecrire      *
;*           a0.L =adresse du tampon … ecrire       *
;* Destruction de D4.W D5.W D6.W                    *
;****************************************************
             move.l    a0,d2
             move.w    d1,nsec
             moveq.l   #2,d5
             ext.l     d0
             tst.w     d0
             bpl       e003
             neg.l     d0
             addq.w    #2,d5
e003:        divu.w    #20,d0
             move.l    d0,d4
             swap.w    d4
             cmpi.w    #10,d4
             blt       e004
             addq.w    #1,d5
             subi.w    #10,d4
e004:        addq.w    #1,d4
             move.w    d4,secteur
             bsr       seldr
             bne       erreur
             bsr       seek
             bne       erreur
             clr.w     errdsk
             move.l    d2,adr
             move.l    #writint,$11c
             bset      #7,mfp+8
             bset      #7,mfp+20
             pea       retour0
             move.w    sr,-(sp)
             bra       writint
retour0:     rts       


writint:     
;****************************************************
;* partie interruption li‚e a readi                 *
;* aucun registre detruit                           *
;****************************************************

             bclr      #7,mfp+20            ;;;;;;;;;;;;
             move.w    #$2500,sr            ;;;;;;;;;;;;;;;
             tst.w     nsec
             beq       supint
             subi.w    #1,nsec
             move.b    adr+3,dmahi+4
             move.b    adr+2,dmahi+2
             move.b    adr+1,dmahi
             cmpi.w    #11,secteur
             bne       e005
             bsr       chgface
             move.w    #1,secteur
e005:        move.w    #$190,dmamode
             move.w    #$90,dmamode
             move.w    #$190,dmamode
             move.w    #1,dmadat
             move.w    #$184,dmamode
             move.w    secteur,dmadat

             move.w    #$180,dmamode
             move.w    #cmdwrite,dmadat
             addi.l    #$200,adr
             addi.w    #1,secteur
             andi.b    #$7f,mfp+12
             andi.b    #$7f,mfp+16
             bset      #7,mfp+20            ;;;;;;;;;;;;;;;;
             rte       

readi9::     
;****************************************************
;* Routine de lecture par interruption              *
;* En entree D0.W =nø logique de 1er secteur … lire *
;*           D1.W =nombre de secteurs … lire        *
;*           a0.L =adresse du tampon de rangement   *
;* Destruction de D4.W D5.W D6.W                    *
;****************************************************
             move.l    a0,d2
             move.w    d1,nsec9
             moveq.l   #2,d5
             ext.l     d0
             tst.w     d0
             bpl       e0019
             neg.l     d0
             addq.w    #2,d5
e0019:       divu.w    #18,d0
             move.l    d0,d4
             swap.w    d4
             cmpi.w    #9,d4
             blt       e0029
             addq.w    #1,d5
             subi.w    #9,d4
e0029:       addq.w    #1,d4
             move.w    d4,secteur9
             bsr       seldr
             bne       erreur9
             bsr       seek
             bne       erreur9
             clr.w     errdsk9
             move.l    d2,adr9
             move.l    #readint9,$11c
             bset      #7,mfp+8
             bset      #7,mfp+20
             pea       retour9
             move.w    sr,-(sp)
             bra       readint9

retour9:     rts       
erreur9:     
             move.w    #1,errdsk9
             rts       

nsec9:       .DC.w 0
adr9:        .DC.l 0
secteur9:    .DC.w 0
errdsk9::    .DC.w 0


readint9:    
;****************************************************
;* partie interruption li‚e a readi                 *
;* aucun registre detruit                           *
;****************************************************


             addq.w    #1,semait


             bclr      #7,mfp+20


             move.w    #$2500,sr
             tst.w     nsec9
             beq       supint9
             subi.w    #1,nsec9
             move.b    adr9+3,dmahi+4
             move.b    adr9+2,dmahi+2
             move.b    adr9+1,dmahi
             cmpi.w    #10,secteur9
             bne       e69

             bsr       chgface

             move.w    #1,secteur9
e69:         move.w    #$84,dmamode
             move.w    secteur9,dmadat
             move.w    #$90,dmamode
             move.w    #$190,dmamode
             move.w    #$90,dmamode
             move.w    #1,dmadat
             move.w    #$80,dmamode
             move.w    #cmdread,dmadat
             addi.l    #$200,adr9
             addi.w    #1,secteur9
             bclr      #7,mfp+12

             bset      #7,mfp+20
             subq.w    #1,semait
             rte       

supint9:     bclr      #7,mfp+8
             bclr      #7,mfp+12

             bset      #7,mfp+20            ;;;;;;;;;;;;;;;;
             subq.w    #1,semait



rte9:        rte       
writi9::     
;****************************************************
;* Routine d'ecriture par interruption              *
;* En entree D0.W =nø logique de 1er secteur … ecri *
;*           D1.W =nombre de secteurs … ecrire      *
;*           a0.L =adresse du tampon … ecrire       *
;* Destruction de D4.W D5.W D6.W                    *
;****************************************************
             move.l    a0,d2
             move.w    d1,nsec9
             moveq.l   #2,d5
             ext.l     d0
             tst.w     d0
             bpl       e0039
             neg.l     d0
             addq.w    #2,d5
e0039:       divu.w    #18,d0
             move.l    d0,d4
             swap.w    d4
             cmpi.w    #9,d4
             blt       e0049
             addq.w    #1,d5
             subi.w    #9,d4
e0049:       addq.w    #1,d4
             move.w    d4,secteur9
             bsr       seldr
             bne       erreur9
             bsr       seek
             bne       erreur9
             clr.w     errdsk9
             move.l    d2,adr9
             move.l    #writint9,$11c
             bset      #7,mfp+8
             bset      #7,mfp+20
             pea       retour09
             move.w    sr,-(sp)
             bra       writint9
retour09:    rts       


writint9:    
;****************************************************
;* partie interruption li‚e a readi                 *
;* aucun registre detruit                           *
;****************************************************

             addq.w    #1,semait
             bclr      #7,mfp+20            ;;;;;;;;;;;;
             move.w    #$2500,sr            ;;;;;;;;;;;;;;;
             tst.w     nsec9
             beq       supint9
             subi.w    #1,nsec9
             move.b    adr9+3,dmahi+4
             move.b    adr9+2,dmahi+2
             move.b    adr9+1,dmahi
             cmpi.w    #10,secteur9
             bne       e0059
             bsr       chgface
             move.w    #1,secteur9
e0059:       move.w    #$190,dmamode
             move.w    #$90,dmamode
             move.w    #$190,dmamode
             move.w    #1,dmadat
             move.w    #$184,dmamode
             move.w    secteur9,dmadat

             move.w    #$180,dmamode
             move.w    #cmdwrite,dmadat
             addi.l    #$200,adr9
             addi.w    #1,secteur9
;              andi.b   #$7f,mfp+12
;             andi.b   #$7f,mfp+16
             bclr      #7,mfp+12
             bset      #7,mfp+20            ;;;;;;;;;;;;;;;;
             subq.w    #1,semait
             rte       


;***************************************************
;* Interrogation operation de lecture readi finie  *
;* implant‚e sous forme de macro      writi        *
;* pas de registres modifies                       *
;***************************************************

isdiskok::   
             btst      #7,mfp+8
             rts       

;***************************************************
;* renvoie l'adresse DMA courante dans D7.L        *
;***************************************************
getdma::     
             move.b    dmahi+4,addma+3
             move.b    dmahi+2,addma+2
             move.b    dmahi,addma+1
             move.l    addma,d7
             rts       


addma:       .DC.l 0




             .END 

