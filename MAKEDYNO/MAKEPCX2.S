
;**************************************************************
;* Routine de compactage New Look                             *
;*                                                            *
;*  -les r‚p‚titions d'octets sont cod‚es:                    *
;*     $C0+n , V   ou n<$40                                   *
;*                                                            *
;*  -les r‚p‚titions de mots (pairs ou impairs) sont cod‚es:  *
;*     $80+n , V1 , V2   ou n<$40                             *
;*                                                            *
;*  -la valeur $80 utilis‚e en Toggle sert … indiquer des     *
;*   changements de contexte int‚rieur/ext‚rieur              *
;*                                                            *
;* ParamŠtres d'entr‚es/sorties :                             *
;*  A0 adresse source non compact‚e                           *
;*  D0 taille source                                          *
;*  A1 adresse destination compact‚e                          *
;* Variables locales :                                        *
;*  D1 registre lecteur de A0                                 *
;*  D2 registre offset int‚rieur/ext‚rieur ($00 ou $80)       *
;*  D3 registre compteur de r‚p‚tition                        *
;*  D4 registre lecteur secondaire secondaire de A0           *
;*  D5 interm‚diaire                                          *
;**************************************************************

;----NOTA---------
; Attention … l'utilisation un peu particuliŠre de DBF pour tester
; si il reste des octets … lire ...

             movea.l   a1,a6
             move.w    d0,(a1)+             ;stocke taille d‚compactee
             moveq.l   #0,d2                ;initialise flag ext/int
boucle:      
             move.b    (a0)+,d1             ;lit un octet
             dbf       d0,analyse
             bra       fin_compact
analyse:     

             move.b    d1,d5
             eor.b     d2,d5                ;changement de zone int/ext
             bpl       nochg_extint
             eori.b    #$80,d2              ;oui , alors changer le flag (Toggle)
             move.b    #$80,(a1)+           ;stocker dans destination
nochg_extint:          

             move.l    #$c2,d3              ;minimum 2 r‚p‚titions
             cmp.b     (a0),d1              ;rep‚tition simple ?
             bne       no_repeat_1
next_1:      dbf       d0,ok_1
             bra       out_1
ok_1:        addq.l    #1,d3
             addq.w    #1,a0                ;pointeur source
             tst.b     d3                   ;d3 ne peut d‚passer $FF
             beq       out_1
             cmp.b     (a0),d1
             beq       next_1
out_1:       subq.l    #1,d3                ;revenir en arriŠre sur compteur
             move.b    d3,(a1)+             ;le stocker
             sub.b     d2,d1
             move.b    d1,(a1)+             ;ainsi que la valeur r‚p‚t‚e
             bra       boucle
no_repeat_1: 

             cmpi.l    #3,d0                ;il faut au moins 3 autres octets sinon ...
             bcs       no_repeat_2
             move.b    (a0),d4              ;lit 2ø octet
             move.l    #$81,d3              ;fixe une repetition
next2:       cmp.b     1(a0),d1             ;comparaison faite en BYTE pour
             bne       out_2                ; ‚viter les problŠmes d'alignement
             cmp.b     2(a0),d4
             bne       out_2
             addq.w    #2,a0                ;OK donc pointeur ‚volue
             dbf       d0,ok_2              ;ainsi que compteur
             bra       out_2
ok_2:        dbf       d0,ok_3
             bra       out_2
ok_3:        addq.l    #1,d3                ;incremente compteur
             cmpi.w    #$bf,d3              ;63 repetition maxi (126 octets)
             bcs       next2
out_2:       cmpi.b    #$81,d3              ;il n'y a pas eu repetition ...
             beq       no_repeat_2
             move.b    d3,(a1)+             ;stocker compteur
             sub.b     d2,d1
             sub.b     d2,d4
             move.b    d1,(a1)+             ;stocker V1
             move.b    d4,(a1)+             ;stocker V2
             addq.w    #1,a0
             dbf       d0,boucle
             bra       fin_compact
no_repeat_2: 

             sub.b     d2,d1                ;valeur simple et unique
             move.b    d1,(a1)+
             bra       boucle

fin_compact: 
             cmpi.b    #$80,d2              ;si on ‚tait en toggle ext/int
             bne       okext                ;revenir … l'‚tat ant‚rieur
             move.b    #$80,(a1)+
okext:       
             suba.l    a6,a1
             move.l    a1,d0
             rts       

