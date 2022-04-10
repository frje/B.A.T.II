;***************************************************************
;*                                                               *
;*               B.O.B  (Bio Ordinateur Bidirectionnel)          *
;*                                                               *
;*                         "Future World"                        *
;*                 Copyrights 1990 Computer's Dream              *
;*                                                               *
;****************************************************************

;MODIF POUR PERSOPRINC LE 31/1/92 SIGNALEES PAR $$$$$
;MODIF LE 4/2/92 &&&&&
;MODIF LE 6/2/92 !!!!!

;be_affi

;bio
;do_inc

;bobcomp111
;feuille
;moniteur

;bob_feuille
;do_aff ¨Erreur de syntaxe
;bob_exec

;table_fonc
;carac
;sante
;bio
;bob_editeur
;des_feuille_pro
;interac
;affialarm
;clignalarm
;do_lier
;affiche_heure
;dessine
;bob_zoom
;bob_comp ¨Erreur de syntaxe

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



             bra       debut


; -----------------------------------------------------
; equivalences

slarg        equ 160   ; largeur ecran en octet
nbpar1       equ 35    ; nbr parametres 1
; taille fenetre BOB
bobxd        equ 16
bobyd        equ 71
bobxf        equ 143
bobyf        equ 152
; zone de clipping de la souris
_clipxd      equ 20
_clipyd      equ 75
_clipxf      equ 250
_clipyf      equ 160
; taille feuille de shema
; cette taille est definitive, elle rentre
; entierement dans le zoom en 320x200
viewsheet_maxx         equ 18
viewsheet_maxy         equ 12
; compteur pour le clignotement de "alarme"
initalarm    equ 10
; codes
run          equ 36
_stop        equ 37
_end         equ 38
si_gauche    equ 39
si_droite    equ 40
si_bas       equ 41
alarme       equ 32
; equivalences du compilateur TOKEN
header_max   equ 5     ; 5 entrées max
body_max     equ 100   ; 50 instructions max
if_max       equ 40    ; 20 if max
crt_max      equ 40    ; 20 crt max

; couleurs
couleur_fond           equ 2
couleur_ecr  equ 5
couleur_ombre          equ 3
couleur_3d   equ 7-2
couleur_f_prog         equ 2
rouge        equ 13
blanc        equ 1

; equivalences du module d'execution
toklong      equ 10
; structure du Token
toksr        equ 0     ; etat du token
tokpc        equ 2     ; pointeur de programme
toklastrun   equ 6     ; adr dernier RUN
;
; ---------------------------------------------------------
; donnees initialisees par le programme
; principal
heure::      
             .DC.w 16
minute::     
             .DC.w 25



; ---------------------------------------------------------
;
; programme d'initialisation
debut:       
; programme principal (code 68000)
;
bobprog::    
             movea.l   adrbiicour,a0
             move.w    14(a0),d0            ;offset anim statique
             lea.l     2(a0,d0.w),a0

             moveq.l   #0,d1
             move.w    8(a0),d1
             movea.l   adrdicour,a1
             adda.l    d1,a1
             move.l    a1,adrfontbob


             move.w    14(a0),d1
             lsl.w     #2,d1
             lea.l     16(a0,d1.w),a0

             moveq.l   #0,d1
             move.w    8(a0),d1
             movea.l   adrdicour,a1
             adda.l    d1,a1

             move.l    a1,adrliaibob


             move.w    14(a0),d1
             lsl.w     #2,d1
             lea.l     16(a0,d1.w),a0

             moveq.l   #0,d1
             move.w    8(a0),d1
             movea.l   adrdicour,a1
             adda.l    d1,a1

             move.l    a1,adrfoncbob

             move.w    14(a0),d1
             lsl.w     #2,d1
             lea.l     16(a0,d1.w),a0

             moveq.l   #0,d1
             move.w    8(a0),d1
             movea.l   adrdicour,a1
             adda.l    d1,a1

             move.l    a1,adriconbob




             bsr       desmendep


bob_loop:    
             cmpi.w    #2,souri_5

             beq       bob_fin
             lea.l     zone_fonc_1,a0
             jsr       interac
             bra       bob_loop
bob_fin:     
             jsr       init_be
             rts       

; -----------------------------------------------------
; Dessiner le menu de depart
;
desmendep1:  
             jsr       clear
; ombre
             move.w    #bobxd+1+26,d0
             move.w    #bobyd+1+12,d1
             move.w    #bobxd+1+118,d2
             move.w    #bobyd+1+69,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
; dessine le premier plan
             move.w    #bobxd+26,d0
             move.w    #bobyd+12,d1
             move.w    #bobxd+118,d2
             move.w    #bobyd+69,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; affichage des icones
adicar       equ ((bobyd+5)*slarg)+4*4
adisan       equ ((bobyd+32)*slarg)+4*4
adibio       equ ((bobyd+62)*slarg)+4*4
adipro       equ ((bobyd+32)*slarg)+16*4
             movea.l   sys01,a0
             lea.l     adicar(a0),a0
             movea.l   adriconbob,a1        ;lea.l    icone_bob,a1
             jsr       put_16
             movea.l   sys01,a0
             lea.l     adisan(a0),a0
             movea.l   adriconbob,a1        ;lea.l    icone_bob,a1
             lea.l     128(a1),a1
             jsr       put_16
             movea.l   sys01,a0
             lea.l     adibio(a0),a0
             movea.l   adriconbob,a1        ;lea.l    icone_bob,a1
             lea.l     128*2(a1),a1
             jsr       put_16
             movea.l   sys01,a0
             lea.l     adipro(a0),a0
             movea.l   adriconbob,a1        ;lea.l    icone_bob,a1
             lea.l     128*3(a1),a1
             jsr       put_16
             bsr       affiche_heure
             move.l    #affiche_heure,real_time_ad

             rts       

desmendep:   
             jsr       desmendep1
             jsr       desmendep1
             rts       

adfh1        equ ((bobyd+32)*slarg)+6*4

cpt_running: 
             .DC.w 0
flag_running:          
             .DC.w 0
affiche_heure:         
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       jhm
             move.w    d1,heure
             move.w    d2,minute
; affichage des heures
             move.w    heure,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,d0
             subi.b    #'0',d0
             andi.l    #$ff,d0
             lsl.l     #7,d0
             movea.l   sys01,a0
             lea.l     adfh1(a0),a0
             movea.l   adrfontbob,a1        ;lea.l    fonte_bob,a1
             adda.l    d0,a1
             jsr       put_16
             move.b    chiffre+10,d0
             subi.b    #'0',d0
             andi.l    #$ff,d0
             lsl.l     #7,d0
             movea.l   sys01,a0
             lea.l     (adfh1+2*4)(a0),a0
             movea.l   adrfontbob,a1        ;lea.l    fonte_bob,a1
             adda.l    d0,a1
             jsr       put_16
             movea.l   sys01,a0
             lea.l     (adfh1+4*4)(a0),a0
             movea.l   adrfontbob,a1        ;lea.l    fonte_bob,a1
             lea.l     128*10(a1),a1
             jsr       put_16
; affichage des minutes
             move.w    minute,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,d0
             subi.b    #'0',d0
             andi.l    #$ff,d0
             lsl.l     #7,d0
             movea.l   sys01,a0
             lea.l     (adfh1+6*4)(a0),a0
             movea.l   adrfontbob,a1        ;lea.l    fonte_bob,a1
             adda.l    d0,a1
             jsr       put_16
             move.b    chiffre+10,d0
             subi.b    #'0',d0
             andi.l    #$ff,d0
             lsl.l     #7,d0
             movea.l   sys01,a0
             lea.l     (adfh1+8*4)(a0),a0
             movea.l   adrfontbob,a1        ;lea.l    fonte_bob,a1
             adda.l    d0,a1
             jsr       put_16
; ------------------------------
             tst.w     running              ; programme a executer ?
             beq.s     no_prog_run
             addq.w    #1,cpt_running
             move.w    #bobxd+34,d0
             move.w    #bobyd+17,d1
             move.w    #bobxd+94,d2
             move.w    #bobyd+27,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob              ; de toute maniere,effacement
             btst      #4,cpt_running+1
             beq.s     no_prog_run
             lea.l     ch_prog+32,a0
             cmpi.w    #1,running
             beq.s     prog_run
             lea.l     12(a0),a0
prog_run:    
             move.w    #bobxd+34,d1
             move.w    #bobyd+17,d2
             moveq.l   #couleur_ecr,d4
             jsr       write                ; de temps en temps,afficher
no_prog_run: 
             jsr       ecrswapbob
; ------------------------------
             movem.l   (sp)+,d0-d7/a0-a6
             rts       



; -----------------------------------------------------
; BOB_ANIME: (routine optionnelle).
; dans cette routine, on mettra les animations qui
; s'executent tout le temps (en dehors de l'ecran BOB)
; par exemple une veine qui se gonfle ou un doigt qui
; bouge...
;
bob_anime:   
             rts       






; -----------------------------------------------------
; lier les autres fonctions de BOB
;
;      include         work:batII/sources/bob/bob_carac.s ¨Nom de fichier non sp‚cifi‚
;     include         work:batII/sources/bob/bob_sante.s ¨Nom de fichier non sp‚cifi‚
;    include         work:batII/sources/bob/bob_bio.s ¨Nom de fichier non sp‚cifi‚
;   include         work:batII/sources/bob/bob_edit.s ¨Nom de fichier non sp‚cifi‚
;  include         work:batII/sources/bob/bob_comp.s ¨Nom de fichier non sp‚cifi‚
; include         work:batII/sources/bob/bob_mon.s ¨Nom de fichier non sp‚cifi‚
;  include         work:batII/sources/bob/bob_exec.s ¨Nom de fichier non sp‚cifi‚
; include         work:batII/sources/bob/bob_zoom.s ¨Nom de fichier non sp‚cifi‚

; *****************************************************
; *****************************************************
; *******                                       *******
; *******        ROUTINES GENERALES             *******
; *******                                       *******
; *****************************************************
; *****************************************************
; -----------------------------------------------------
; ecrire avec ombrage
write:       
             movem.l   d0-d7/a0-a6,-(sp)
             movem.l   d1-d4/a0,-(sp)
             addq.w    #1,d1
             addq.w    #1,d2
             moveq.l   #couleur_ombre,d4
             jsr       textbob
             movem.l   (sp)+,d1-d4/a0
             jsr       textbob
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
; -----------------------------------------------------
; fonction pour sortir
sort:        
             .DC.w 0
exit:        
             move.b    #255,sort
             rts       
; -----------------------------------------------------
; effacer l'ecran en degradant
clear:       
             move.w    #bobxd,d0
             move.w    #bobyd,d1
             move.w    #bobxf,d2
             move.w    #bobyf,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             rts       
;------------------------------------------------------
; conversion d'un chiffre hexa  32 bits
; en une chaine ASCII sur 10 caracteres
; pointée par CHIFFRE.
; le 1er caractere est le signe (+/-)
convasc:     
             movem.l   d0-d3/a0/a1,-(sp)
             lea.l     chiffre,a0
             moveq.l   #9,d1
             move.b    #$2b,(a0)
             tst.l     d0
             bge       capos
             move.b    #$2d,(a0)
             neg.l     d0
capos:       addq.w    #1,a0
             lea.l     tabrang,a1
rang:        move.l    (a1)+,d3
             move.l    #$d0,d2
soust1:      sub.l     d3,d0
             dbmi      d2,soust1
             neg.b     d2
             move.b    d2,(a0)+
             add.l     d3,d0
             dbra      d1,rang
             movem.l   (sp)+,d0-d3/a0/a1
             rts       
tabrang:     .DC.l 1000000000
             .DC.l 100000000
             .DC.l 10000000
             .DC.l 1000000
             .DC.l 100000
             .DC.l 10000
             .DC.l 1000
             .DC.l 100
             .DC.l 10
             .DC.l 1

; -----------------------------------------------------
;        * Teste les zones souris
;        * A0: adresse de la table des coordonées souris
;               La table est organisée comme suit XD,YD,
;               XF,YF,N°fonction,dans table_fonc,elle se
;               termine par $ffff.
;        * real_time_ad: hors 0,on saute à l'adresse
;                            contenue.
interac:     
; routine specifique a executer ?
             tst.l     real_time_ad
             beq.s     int_0
             movea.l   real_time_ad,a5
             jsr       (a5)                 ; l'executer
int_0:       
             jsr       bob_anime
int_novbl:   
             tst.w     souri_5              ; si rien de selectionner
             beq.s     interac
; fin de la boucle principale
             cmpi.w    #1,souri_5
             bne       fin_interac
anti_rebond: 
             tst.w     souri_5
             bne.s     anti_rebond
int_loop:    
             cmpi.w    #$ffff,(a0)
             beq       fin_interac
             move.w    (a0),d0
             cmp.w     souri_7,d0
             bpl       suitest
             move.w    4(a0),d0
             cmp.w     souri_7,d0
             bmi       suitest
             move.w    2(a0),d0
             cmp.w     souri_8,d0
             bpl       suitest
             move.w    6(a0),d0
             cmp.w     souri_8,d0
             bmi       suitest
;
             move.w    8(a0),d0
             lsl.w     #2,d0
             lea.l     table_fonc,a5
             movea.l   0(a5,d0.w),a5
             jsr       (a5)
             bra.s     fin_interac
suitest:     
             lea.l     10(a0),a0
             bra       int_loop
fin_interac: 
             rts       
real_time_ad:          
             .DC.l 0

; *****************************************************
; *****************************************************
; *******                                       *******
; *******                 DATA                  *******
; *******                                       *******
; *****************************************************
; *****************************************************
; -----------------------------------------------------
table_fonc:  
             .DC.l carac                    ; 0
             .DC.l sante                    ; 1
             .DC.l bio ; 2
             .DC.l bob_editeur              ; 3
             .DC.l exit                     ; 4
             .DC.l injecter                 ; 5
; fonctions 3d
             .DC.l droite                   ; 6
             .DC.l gauche                   ; 7
             .DC.l haut                     ; 8
             .DC.l bas ; 9
             .DC.l zoomp                    ; 10
             .DC.l zoomm                    ; 11
             .DC.l anglep                   ; 12
;
             .DC.l diagnostic               ; 13
; fonctions de l'editeur de programmation
             .DC.l bob_new                  ; 14
             .DC.l bob_feuille              ; 15
             .DC.l bob_bas                  ; 16
             .DC.l bob_haut                 ; 17
             .DC.l bob_gauche               ; 18
             .DC.l bob_droite               ; 19
             .DC.l bob_fonc                 ; 20
             .DC.l bob_par1                 ; 21
             .DC.l bob_par2                 ; 22
             .DC.l bob_lier                 ; 23
             .DC.l bob_effacer              ; 24
; fonctions de la boite de dialogue
             .DC.l db_oui                   ; 25
             .DC.l db_non                   ; 26
; fonctions de l'alarme
             .DC.l ra_hhigup                ; 27
             .DC.l ra_hlowup                ; 28
             .DC.l ra_mhigup                ; 29
             .DC.l ra_mlowup                ; 30
             .DC.l ra_hhigdn                ; 31
             .DC.l ra_hlowdn                ; 32
             .DC.l ra_mhigdn                ; 33
             .DC.l ra_mlowdn                ; 34
; -----------------------------------------------------
; blocs souris pour le menu principal
zone_fonc_1: 
             .DC.w bobxd+16,bobyd+5,bobxd+32,bobyd+21,0     ; caracteristique
             .DC.w bobxd+16,bobyd+32,bobxd+32,bobyd+48,1    ; sante
             .DC.w bobxd+16,bobyd+62,bobxd+32,bobyd+78,2    ; bio
             .DC.w bobxd+112,bobyd+32,bobxd+144,bobyd+48,3  ; programmation
             .DC.w $ffff
; blocs souris pour la fonction caracteristique
zone_fonc_2: 
             .DC.w bobxd+5,bobyf-20,bobxf-5,bobyf-5,4
             .DC.w $ffff
; blocs souris pour la fonction bio
zone_fonc_3: 
             .DC.w bobxd+5,bobyf-20,bobxf-5,bobyf-5,4
             .DC.w bobxd+5,bobyd+5,bobxf-5,bobyd+5+72,5
             .DC.w $ffff
; blocs souris pour la fonction sante
zone_fonc_4: 
             .DC.w bobxd+5,bobyd+65,bobxd+55,bobyd+75,4
             .DC.w bobxd+115,bobyd+6,bobxd+126,bobyd+13,6
             .DC.w bobxd+115,bobyd+14,bobxd+126,bobyd+21,7
             .DC.w bobxd+115,bobyd+22,bobxd+126,bobyd+29,8
             .DC.w bobxd+115,bobyd+30,bobxd+126,bobyd+37,9
             .DC.w bobxd+115,bobyd+38,bobxd+126,bobyd+45,10
             .DC.w bobxd+115,bobyd+46,bobxd+126,bobyd+53,11
             .DC.w bobxd+115,bobyd+54,bobxd+126,bobyd+61,12
             .DC.w bobxd+57,bobyd+65,bobxf-5,bobyd+75,13
             .DC.w $ffff
; blocs souris pour la fonction diagnostic
zone_fonc_5: 
             .DC.w bobxd+5,bobyd+68,bobxd+55,bobyd+78,4
             .DC.w $ffff
; blocs souris pour la fonction programmation
zone_fonc_6: 
             .DC.w bobxd+91,bobyf-10,bobxf-1,bobyf-1,4
             .DC.w bobxd+91,bobyf-21,bobxf-1,bobyf-12,14
             .DC.w bobxd,bobyd,bobxd+80,bobyf,15
             .DC.w bobxd+78,bobyf-10,bobxd+88,bobyf-0,16
             .DC.w bobxd+78,bobyf-20,bobxd+88,bobyf-11,17
             .DC.w bobxd+78,bobyf-30,bobxd+88,bobyf-21,18
             .DC.w bobxd+78,bobyf-40,bobxd+88,bobyf-31,19
             .DC.w bobxd+80,bobyd+16,bobxd+95,bobyd+16+15,20
             .DC.w bobxd+96,bobyd+16,bobxd+111,bobyd+16+15,21
             .DC.w bobxd+112,bobyd+16,bobxd+127,bobyd+16+15,22
             .DC.w bobxd+91,bobyf-32,bobxf-1,bobyf-23,23
             .DC.w bobxd+91,bobyf-43,bobxf-1,bobyf-34,24
             .DC.w $ffff
; blocs souris pour la fonction dialbox
zone_fonc_7: 
             .DC.w bobxd+5,bobyd+42,bobxd+35,bobyd+54,25
             .DC.w bobxd+45,bobyd+42,bobxd+75,bobyd+54,26
             .DC.w $ffff
; blocs souris pour la fonction alarme
zone_fonc_8: 
             .DC.w bobxd+25,bobyd+56,bobxd+56,bobyd+66,4    ; EXIT
             .DC.w bobxd+11,bobyd+38,bobxd+17,bobyd+43,27
             .DC.w bobxd+23,bobyd+38,bobxd+29,bobyd+43,28
             .DC.w bobxd+47,bobyd+38,bobxd+53,bobyd+43,29
             .DC.w bobxd+59,bobyd+38,bobxd+65,bobyd+43,30
             .DC.w bobxd+11,bobyd+44,bobxd+17,bobyd+50,31
             .DC.w bobxd+23,bobyd+44,bobxd+29,bobyd+50,32
             .DC.w bobxd+47,bobyd+44,bobxd+53,bobyd+50,33
             .DC.w bobxd+59,bobyd+44,bobxd+65,bobyd+50,34
             .DC.w $ffff
; definition de la courbe du cardiogramme
; les valeurs (ordonnees) varient de -10 a +9
c_cardio:    
             .DC.w 0,0,0,0,0,0,0,0,0,1
             .DC.w 2,2,2,1,0,0,0,0,0,0
             .DC.w -2,3,6,9,6,3,-3,-1,0,0
             .DC.w 0,0,0,0,0,1,1,2,2,2
             .DC.w 2,1,0,0,0,0,0,0,0,0
             .DC.w 0,0,0,0,0,0,0,0,0,0
c_cardiofin: 


; pour l'homme vectoriel
; n° des lignes dont la couleur change pour chaque
; organe. ( $ffff = fin )
tete:        
             .DC.w 1,38,36,37,$ffff
tors:        
             .DC.w 38,2,41,11,40,26,39,35,$ffff
brag:        
             .DC.w 39,27,28,29,30,31,32,33,34,$ffff
brad:        
             .DC.w 41,3,4,5,6,7,8,9,10,$ffff
abdo:        
             .DC.w 40,12,43,42,25,$ffff
jamg:        
             .DC.w 42,19,20,21,22,23,24,$ffff
jamd:        
             .DC.w 43,13,14,15,16,17,18,$ffff
; datas pour la programmation de BOB
; table de correspondance
if_p2_pointe_p1:       
             .DC.l p1_rien
             .DC.l p1_rien
             .DC.l p1_rien                  ;p1_prevenir
             .DC.l p1_rien                  ;p1_augmenter
             .DC.l p1_rien                  ;p1_diminuer
             .DC.l p1_rien                  ;p1_analyser
             .DC.l p1_joueur
             .DC.l p1_evi
             .DC.l p1_force
             .DC.l p1_intel
             .DC.l p1_vital
             .DC.l p1_perce
             .DC.l p1_refle
             .DC.l p1_chari
             .DC.l p1_rien                  ;           .DC.l p1_faim
             .DC.l p1_rien                  ;   .DC.l p1_soif
             .DC.l p1_rien                  ;      .DC.l p1_fatigue
             .DC.l p1_etat
             .DC.l p1_temp
             .DC.l p1_pres
             .DC.l p2_sub1
             .DC.l p2_sub2
             .DC.l p2_sub3
             .DC.l p2_sub4
             .DC.l p2_sub5
             .DC.l p1_rien                  ;p1_sub6
             .DC.l p1_heure
             .DC.l p2_rythme
             .DC.l p1_rien                  ;p1_fort
             .DC.l p1_rien                  ;p1_faible
             .DC.l p1_rien                  ;p1_normal
             .DC.l p1_rien                  ;p1_agressif
             .DC.l p1_rien                  ;p1_alarme
             .DC.l p1_rien                  ;p1_shedish
             .DC.l p1_rien                  ;p1_traduire
             .DC.l p1_rien
do_p2_pointe_p1:       
             .DC.l p1_rien
             .DC.l p1_afficher
             .DC.l p1_prevenir
             .DC.l p1_augmenter
             .DC.l p1_diminuer
             .DC.l p1_analyser
             .DC.l p1_rien                  ;p1_joueur
             .DC.l p1_rien                  ;p1_evi
             .DC.l p1_rien                  ;p1_force
             .DC.l p1_rien                  ;p1_intel
             .DC.l p1_rien                  ;p1_vital
             .DC.l p1_rien                  ;p1_perce
             .DC.l p1_rien                  ;p1_refle
             .DC.l p1_rien                  ;p1_chari
             .DC.l p1_rien                  ;p1_faim
             .DC.l p1_rien                  ;p1_soif
             .DC.l p1_rien                  ;p1_fatigue
             .DC.l p1_rien                  ;p1_etat
             .DC.l p1_rien                  ;p1_temp
             .DC.l p1_rien                  ;p1_pres
             .DC.l p1_sub1
             .DC.l p1_sub2
             .DC.l p1_sub3
             .DC.l p1_sub4
             .DC.l p1_sub5
             .DC.l p1_rien                  ;p1_sub6
             .DC.l p1_rien                  ;p1_heure
             .DC.l p1_rythme
             .DC.l p1_rien                  ;p1_fort
             .DC.l p1_rien                  ;p1_faible
             .DC.l p1_rien                  ;p1_normal
             .DC.l p1_rien                  ;p1_agressif
             .DC.l p1_rien                  ;p1_alarme
             .DC.l p1_rien                  ;p1_shedish
             .DC.l p1_traduire
             .DC.l p1_rien
; on pointe sur les variables possibles
; signification des codes de la table :
; l'ordre donne est aussi celui des icones...
;
;        00 =    rien
;        afficher
;        prevenir
;        augmenter
;        diminuer
;        analyser
; ------------ code des variables -------------
;        01 =    joueur
;        02 =    evi
;        03 =    force
;        04 =    intel
;        05 =    vital
;        06 =    perce
;        07 =    refle
;        08 =    chari
;        09 =    faim
;        10 =    soif
;        11 =    fatigue
;        12 =    etat
;        13 =    temp
;        14 =    pres
;        15 =    sub1
;        16 =    sub2
;        17 =    sub3
;        18 =    sub4
;        19 =    sub5
;        20 =           sub6
;        21 =    heure
;        22 =    rythme
;        23 =    fort
;        24 =    faible
;        25 =    normal
;        26 =    agressif
; ---------------------------------------------
;        run
;        _stop
;        _end
;        si gauche ........ pour la fonction si
;        si droite ........     ,,     ,,
;        si bas    ........     ,,     ,,
;
p1_rien:     
             .DC.w 0,$ffff
p1_afficher: 
             .DC.w 3,4,5,6,7,8,9,10,11,12,13,14
             .DC.w 15,16,17,18,19,21,22,$ffff
p1_prevenir: 
             .DC.w 1,$ffff
p1_augmenter:          
             .DC.w 15,16,17,18,19,22,$ffff
p1_diminuer: 
;;;;;              .DC.w 15,16,17,18,19,22,$ffff
             .DC.w 22,-1
p1_analyser: 
             .DC.w 1,2,$ffff
p1_joueur:   
             .DC.w 9,10,11,$ffff            ; faim,soif,fatigue
p1_evi:      
             .DC.w 9,10,11,26,28,$ffff
p1_force:    
             .DC.w 23,24,25,$ffff           ; fort,faible,normal
p1_intel:    
             .DC.w 23,24,25,$ffff
p1_vital:    
             .DC.w 23,24,25,$ffff
p1_perce:    
             .DC.w 23,24,25,$ffff
p1_refle:    
             .DC.w 23,24,25,$ffff
p1_chari:    
             .DC.w 23,24,25,$ffff
p1_faim:     
             .DC.w 23,24,25,$ffff
p1_soif:     
             .DC.w 23,24,25,$ffff
p1_fatigue:  
             .DC.w 23,24,25,$ffff
p1_etat:     
             .DC.w 23,24,25,$ffff
p1_temp:     
             .DC.w 23,24,25,$ffff
p1_pres:     
             .DC.w 23,24,25,$ffff
p1_sub1:     
             .DC.w 25,$ffff
p1_sub2:     
             .DC.w 25,$ffff
p1_sub3:     
             .DC.w 25,$ffff
p1_sub4:     
             .DC.w 25,$ffff
p1_sub5:     
             .DC.w 25,$ffff
p1_sub6:     
             .DC.w 25,$ffff
p1_heure:    
             .DC.w 27,$ffff
p1_rythme:   
             .DC.w 25,$ffff
p1_traduire: 
             .DC.w 30,$ffff
p2_sub1:     
             .DC.w 23,25,$ffff
p2_sub2:     
             .DC.w 23,25,$ffff
p2_sub3:     
             .DC.w 23,25,$ffff
p2_sub4:     
             .DC.w 23,25,$ffff
p2_sub5:     
             .DC.w 23,25,$ffff
p2_sub6:     
             .DC.w 23,25,$ffff
p2_rythme:   
             .DC.w 23,24,25,$ffff


; derniere instruction compilee
acjc:        
             .DC.l 0
; type de branche compilee
; 1 : branche IF
; 2 : branche CRT
typebranche: 
             .DC.w 0

; pour le module d'execution, tables de redirection
; vers les librairies (IF et DO)
; ex:
; "6,IF_JOUEUR" provoque l'execution de la routine
; IF_JOUEUR si le premier parametre de la fonction
; IF est egal à 6, etc...
exiflist:    
             .DC.w 6
             .DC.l if_joueur
             .DC.w 7
             .DC.l if_evi
             .DC.w 8
             .DC.l if_force
             .DC.w 9
             .DC.l if_intel
             .DC.w 10
             .DC.l if_vital
             .DC.w 11
             .DC.l if_perce
             .DC.w 12
             .DC.l if_refle
             .DC.w 13
             .DC.l if_chari
             .DC.w 14
             .DC.l if_faim
             .DC.w 15
             .DC.l if_soif
             .DC.w 16
             .DC.l if_fatig
             .DC.w 17
             .DC.l if_etat
             .DC.w 18
             .DC.l if_temp
             .DC.w 19
             .DC.l if_pres
             .DC.w 20
             .DC.l if_sub1
             .DC.w 21
             .DC.l if_sub2
             .DC.w 22
             .DC.l if_sub3
             .DC.w 23
             .DC.l if_sub4
             .DC.w 25
             .DC.l if_sub5
             .DC.w 26
             .DC.l if_heure
             .DC.w 27
             .DC.l if_rythme
             .DC.w $ffff
exdolist:    
             .DC.w 1
             .DC.l do_aff
             .DC.w 2
             .DC.l do_prev
             .DC.w 3
             .DC.l do_inc
             .DC.w 4
             .DC.l do_dec
             .DC.w 5
             .DC.l do_ana
             .DC.w 20
             .DC.l do_subn
             .DC.w 21
             .DC.l do_subn
             .DC.w 22
             .DC.l do_subn
             .DC.w 23
             .DC.l do_subn
             .DC.w 24
             .DC.l do_subn
             .DC.w 27
             .DC.l do_rythn
             .DC.w 34
             .DC.l do_trad
             .DC.w $ffff
; pour le module d'execution, fonction IF
; "ifxxxtab" est une table qui donne le code de validite
; pour le parametre 2 (deuxieme chiffre ds la table)
; ex: 9,1 veut dire si D0=9 (par2) si vevi=1 la condition
; est vraie.

iffaim:      .DC.b 9,1,-1

ifsoif:      .DC.b 10,1,-1

iffatig:     .DC.b 11,1,-1

ifcartab:    
             .DC.b 23,4,24,5,25,6
             .DC.b $ff
ifheutab:    
             .DC.b 27,1
             .DC.b $ff
             .EVEN 


; *****************************************************************
; *****************************************************************
; *********************                  **************************
; *********************    ****  ***     **************************
; *********************      *   *  *    **************************
; *********************    ***   *  *    **************************
; *********************       *  *  *    **************************
; *********************    ***   ***     **************************
; *********************                  **************************
; *****************************************************************
; *****************************************************************

; sources 3D pour BOB (BAT II)

wlarg        equ 3     ; largeur fenetre 3d (144-80)/16
whigh        equ 60    ; hauteur fenetre 3d (130-75)

; * descripteur de la structure des objets

mxangl       equ 0
myangl       equ 2
mzangl       equ 4
dist         equ 6
ad_x         equ 8
ad_y         equ 12
ad_z         equ 16
ad_lin       equ 20
mnbrcoi      equ 24
mnbrlin      equ 26
x0           equ 28
y0           equ 30

;************************ librairie des routines *************************

; /* calcul le sinus de D0 dans D1 */
sin:         
             movea.l   #sintab,a1
             tst.w     d0
             bpl.s     sinsui1
             addi.w    #360,d0
sinsui1:     
             lsl.w     #1,d0
             move.w    0(a1,d0.w),d1
             rts       
sintab:      
             .DC.w 0,285,571,857,1142,1427,1712,1996,2280
             .DC.w 2563,2845,3126,3406,3685,3963,4240,4516,4790
             .DC.w 5062,5334,5603,5871,6137,6401,6663,6924,7182
             .DC.w 7438,7691,7943,8192,8438,8682,8923,9161,9397
             .DC.w 9630,9860,10086,10310,10531,10748,10963,11173,11381
             .DC.w 11585,11785,11982,12175,12365,12550,12732,12910,13084
             .DC.w 13254,13420,13582,13740,13894,14043,14188,14329,14466
             .DC.w 14598,14725,14848,14967,15081,15190,15295,15395,15491
             .DC.w 15582,15668,15749,15825,15897,15964,16025,16082,16135
             .DC.w 16182,16224,16261,16294,16321,16344,16361,16374,16381
             .DC.w 16384,16381,16374,16361,16344,16321,16294,16261,16224
             .DC.w 16182,16135,16082,16025,15964,15897,15825,15749,15668
             .DC.w 15582,15491,15395,15295,15190,15081,14967,14848,14725
             .DC.w 14598,14466,14329,14188,14043,13894,13740,13582,13420
             .DC.w 13254,13084,12910,12732,12550,12365,12175,11982,11785
             .DC.w 11585,11381,11173,10963,10748,10531,10310,10086,9860
             .DC.w 9630,9397,9161,8923,8682,8438,8192,7943,7691
             .DC.w 7438,7182,6924,6663,6401,6137,5871,5603,5334
             .DC.w 5062,4790,4516,4240,3963,3685,3406,3126,2845
             .DC.w 2563,2280,1996,1712,1427,1142,857,571,285
             .DC.w 0,-285,-571,-857,-1142,-1427,-1712,-1996,-2280
             .DC.w -2563,-2845,-3126,-3406,-3685,-3963,-4240,-4516,-4790
             .DC.w -5062,-5334,-5603,-5871,-6137,-6401,-6663,-6924,-7182
             .DC.w -7438,-7691,-7943,-8192,-8438,-8682,-8923,-9161,-9397
             .DC.w -9630,-9860,-10086,-10310,-10531,-10748,-10963,-11173,-11381
             .DC.w -11585,-11785,-11982,-12175,-12365,-12550,-12732,-12910,-13084
             .DC.w -13254,-13420,-13582,-13740,-13894,-14043,-14188,-14329,-14466
             .DC.w -14598,-14725,-14848,-14967,-15081,-15190,-15295,-15395,-15491
             .DC.w -15582,-15668,-15749,-15825,-15897,-15964,-16025,-16082,-16135
             .DC.w -16182,-16224,-16261,-16294,-16321,-16344,-16361,-16374,-16381
             .DC.w -16384,-16381,-16374,-16361,-16344,-16321,-16294,-16261,-16224
             .DC.w -16182,-16135,-16082,-16025,-15964,-15897,-15825,-15749,-15668
             .DC.w -15582,-15491,-15395,-15295,-15190,-15081,-14967,-14848,-14725
             .DC.w -14598,-14466,-14329,-14188,-14043,-13894,-13740,-13582,-13420
             .DC.w -13254,-13084,-12910,-12732,-12550,-12365,-12175,-11982,-11785
             .DC.w -11585,-11381,-11173,-10963,-10748,-10531,-10310,-10086,-9860
             .DC.w -9630,-9397,-9161,-8923,-8682,-8438,-8192,-7943,-7691
             .DC.w -7438,-7182,-6924,-6663,-6401,-6137,-5871,-5603,-5334
             .DC.w -5062,-4790,-4516,-4240,-3963,-3685,-3406,-3126,-2845
             .DC.w -2563,-2280,-1996,-1712,-1427,-1142,-857,-571,-285
             .DC.w 0

; /* retourne le sinus de D0 dans D1 et son cosinus dans D2 */
sincos:      
             tst.w     d0
             bpl.s     noaddi
             addi.w    #360,d0
noaddi:      
             movea.l   #sintab,a1
             move.l    d0,d2
             lsl.w     #1,d0
             move.w    0(a1,d0.w),d1
             cmpi.w    #270,d2
             blt       plus9
             subi.w    #270,d2
             bra       suitsin
plus9:       
             addi.w    #90,d2
suitsin:     
             lsl.w     #1,d2
             move.w    0(a1,d2.w),d2
             rts       

; /************************  DESSIN 3D **********************************/
; DESSINE:
; ce sous-programme execute le calcul de rotation, de perpspective,
; et dessine avec clipping un objet 3d (filaire ou plein sans faces
; cachees)
dessine:     
; -----------------------------------------------------
; effacer l'ecran virtuel
; effacer avec la couleur de fond ( 03 = %0011 )
; deux premiers plans a 1
             movea.l   sys01,a1
             lea.l     ((75*160)+40)(a1),a1
             move.w    #60-1,d0
desclear:    
             movea.l   a1,a2
             .REPT 3
             clr.w     (a2)+
             move.w    #$ffff,(a2)+
             clr.l     (a2)+
             .ENDR 
             lea.l     160(a1),a1
             dbra      d0,desclear
; -----------------------------------------------------
; maintenant c'est du bete code 68000...
; initialisation des donnees generales f(objet courant)
             movea.l   adr_obj,a0
             move.l    ad_x(a0),datx
             move.l    ad_y(a0),daty
             move.l    ad_z(a0),datz
             move.l    ad_lin(a0),linxy
             move.w    mnbrlin(a0),nbrlin
             move.w    mnbrcoi(a0),nbrcoi
             move.w    dist(a0),z
             move.w    x0(a0),xrec
             move.w    y0(a0),yrec
             move.w    mxangl(a0),xangl
             move.w    myangl(a0),yangl
             move.w    mzangl(a0),zangl
; /*************         animation autour du repere local        ********************/
             move.w    vitangle,d0
             add.w     d0,myangl(a0)
             cmpi.w    #360,myangl(a0)
             blt.s     no_depass_y
             subi.w    #360,myangl(a0)
no_depass_y: 
; /*************  Rotation (x,y,z) autour du repere local ********************/
; /* rotation autour d'un point du repere */
             move.w    rotbzx,d0
             move.w    rotbzy,d1
             move.w    rotbzz,d2
             move.w    d0,xoffs
             move.w    d1,yoffs
             move.w    d2,zoffs
             neg.w     d0
             neg.w     d1
             neg.w     d2
             move.w    d0,offx
             move.w    d1,offy
             move.w    d2,offz
; /* initialisation de la matrice neutre */
             clr.w     d1
             move.w    #16384,d2
             move.w    d2,matric11
             move.w    d1,matric12
             move.w    d1,matric13
             move.w    d1,matric21
             move.w    d2,matric22
             move.w    d1,matric23
             move.w    d1,matric31
             move.w    d1,matric32
             move.w    d2,matric33
; /* multiplication des matrices pour la rotation */
             move.w    yangl,d0
             jsr       sincos
             move.w    d1,siny
             move.w    d2,cosy
             move.w    d1,d3
             move.w    d2,d4
             muls.w    matric11,d2
             muls.w    matric13,d1
             add.l     d1,d2
             lsl.l     #2,d2
             swap.w    d2
             move.w    d2,rotx11
             move.w    d3,d1
             move.w    d4,d2
             muls.w    matric21,d2
             muls.w    matric23,d1
             add.l     d1,d2
             lsl.l     #2,d2
             swap.w    d2
             move.w    d2,rotx21
             move.w    d3,d1
             move.w    d4,d2
             muls.w    matric31,d2
             muls.w    matric33,d1
             add.l     d1,d2
             lsl.l     #2,d2
             swap.w    d2
             move.w    d2,rotx31
             neg.w     d3
             move.w    d3,d1
             move.w    d4,d2
             move.w    matric12,rotx12
             move.w    matric22,rotx22
             move.w    matric32,rotx32
             muls.w    matric11,d1
             muls.w    matric13,d2
             add.l     d1,d2
             lsl.l     #2,d2
             swap.w    d2
             move.w    d2,rotx13
             move.w    d3,d1
             move.w    d4,d2
             muls.w    matric21,d1
             muls.w    matric23,d2
             add.l     d1,d2
             lsl.l     #2,d2
             swap.w    d2
             move.w    d2,rotx23
             muls.w    matric31,d3
             muls.w    matric33,d4
             add.l     d3,d4
             lsl.l     #2,d4
             swap.w    d4
             move.w    d4,rotx33
             move.l    #8,d7
             movea.l   #rotx11,a1
             movea.l   #matric11,a2
yrotlop1:    
             move.w    (a1)+,(a2)+
             dbf       d7,yrotlop1
; /* Multiplication pour les rotations */
             move.w    nbrcoi,d0
             ext.l     d0
             subq.l    #1,d0
             movea.l   datx,a1
             movea.l   daty,a2
             movea.l   datz,a3
             movea.l   pointx,a4
             movea.l   pointy,a5
             movea.l   pointz,a6
rotit1:      
             move.w    (a1)+,d1
             add.w     offx,d1
             move.w    d1,d4
             move.w    (a2)+,d2
             add.w     offy,d2
             move.w    d2,d5
             move.w    (a3)+,d3
             add.w     offz,d3
             move.w    d3,d6
             muls.w    matric11,d1
             muls.w    matric21,d2
             muls.w    matric31,d3
             add.l     d1,d2
             add.l     d2,d3
             lsl.l     #2,d3
             swap.w    d3
             add.w     xoffs,d3
             move.w    d3,(a4)+
             move.w    d4,d1
             move.w    d5,d2
             move.w    d6,d3
             muls.w    matric12,d1
             muls.w    matric22,d2
             muls.w    matric32,d3
             add.l     d1,d2
             add.l     d2,d3
             lsl.l     #2,d3
             swap.w    d3
             add.w     yoffs,d3
             move.w    d3,(a5)+
             muls.w    matric13,d4
             muls.w    matric23,d5
             muls.w    matric33,d6
             add.l     d4,d5
             add.l     d5,d6
             lsl.l     #2,d6
             swap.w    d6
             add.w     zoffs,d6
             move.w    d6,(a6)+
             dbf       d0,rotit1
; /***************** transformee 3D / 2D ***************************/
rec          equ 250   ; recul de l'observateur
pfx          equ 112   ; Position x du point de fuite
pfy          equ 105   ; Position y
; /* calcul des coordonnees ecran */
             movea.l   pointx,a1
             movea.l   pointy,a2
             movea.l   pointz,a3
             movea.l   xplot,a4
             movea.l   yplot,a5
             move.w    nbrcoi,d4            ; nbr de points
             ext.l     d4
             subq.l    #1,d4
persloop:    
             move.w    (a1)+,d2
             move.w    (a2)+,d3
             move.w    (a3)+,d6
             sub.w     z,d6
             move.w    d3,d7
             move.w    d2,d5
             subi.w    #rec,d6
             neg.w     d6
             beq.s     infini
             muls.w    #rec,d3
             muls.w    #rec,d2
             divs.w    d6,d2
             bvs.s     infinix
             addi.w    #pfx,d2
persy:       
             divs.w    d6,d3
             bvs.s     infiniy
             neg.w     d3
             addi.w    #pfy,d3
             bra.s     finpers
infinix:     
             move.w    #$7fff,d2
             tst.w     d5
             bpl.s     persy
             addq.w    #1,d2
             bra.s     persy
infiniy:     
             move.w    #$7fff,d3
             tst.w     d2
             bmi.s     finpers
             addq.w    #1,d3
             bra.s     finpers
infini:      
             move.w    #$7fff,d2
             move.w    d2,d3
             tst.w     d7
             bpl.s     persinf1
             addq.w    #1,d2
persinf1:    
             tst.w     d7
             bmi.s     finpers
             addq.w    #1,d3
finpers:     
             add.w     xrec,d2
             move.w    d2,(a4)+
             add.w     yrec,d3
             move.w    d3,(a5)+
             dbf       d4,persloop
; dessiner l'objet filaire
             moveq.l   #0,d0
             movea.l   xplot,a4
             movea.l   yplot,a5
             move.w    nbrlin,d0
             subq.l    #1,d0
             movea.l   linxy,a6
dess_loop:   
             move.l    (a6)+,d1
             subq.w    #1,d1
             lsl.w     #1,d1
             move.w    0(a4,d1.w),d2
             move.w    0(a5,d1.w),d3
             swap.w    d1
             subq.w    #1,d1
             lsl.w     #1,d1
             movea.w   0(a4,d1.w),a2
             movea.w   0(a5,d1.w),a3
             addq.l    #2,a6                ; shunte la couleur
; /****** trace une ligne avec clipping (algorithme de Cohen-Sutherland) *****/
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    d2,d6
             move.w    d3,d7
             jsr       findsec              ;1er point dans fenetre ?
             move.w    d1,code1
             move.w    a2,d6
             move.w    a3,d7
             jsr       findsec              ;2 eme point ?
             move.w    d1,code2
             tst.w     d1                   ;point non visible ?
             bne       testw1               ;oui --> continuer test
             tst.w     code1                ;1er point visible ?
             beq       drawit2              ;oui --> dessiner les 2
; ligne partiellement visible ou invisible
testw1:      
             move.w    d1,d0
             and.w     code1,d0             ;on traverse la fenetre ?
             bne       drawend              ;non -> ligne invisible
; ligne partiellement visible
             movea.w   d2,a0
             movea.w   d3,a1
             movea.w   a2,a4
             movea.w   a3,a5
             tst.w     code2
             bne       testw2
             move.w    a2,droitex
             move.w    a3,droitey
             bra       testw3
testw2:      
             move.w    code1,p1code
             move.w    code2,p2code
             jsr       findpoin
             tst.w     p1code
             bne       drawend
             move.w    d2,droitex
             move.w    d3,droitey
testw3:      
             move.w    a4,d2
             move.w    a5,d3
             movea.w   a0,a2
             movea.w   a1,a3
             move.w    code2,p1code
             move.w    code1,p2code
             tst.w     p2code
             bne       testw4
             move.w    a2,gauchx
             move.w    a3,gauchy
             bra       drawit1
testw4:      
             jsr       findpoin
             move.w    d2,gauchx
             move.w    d3,gauchy
drawit1:     
             move.w    gauchx,d2
             move.w    gauchy,d3
             movea.w   droitex,a2
             movea.w   droitey,a3
; ligne visible
drawit2:     
; routine de trace de ligne rapide
             move.w    d2,d0
             ext.l     d0
             move.w    d3,d1
             ext.l     d1
             move.w    a2,d2
             ext.l     d2
             move.w    a3,d3
             ext.l     d3
             movea.l   adr_obj,a0
             move.w    -2(a6),d4
             cmpi.w    #90,myangl(a0)
             blt.s     drawwocol
             cmpi.w    #270,myangl(a0)
             bgt.s     drawwocol
             move.w    #couleur_3d,d4       ; recupere la couleur
drawwocol:   
             jsr       lignebob
drawend:     
             movem.l   (sp)+,d0-d7/a0-a6
; fin du trace de ligne avec clipping
             dbf       d0,dess_loop
             rts       
; determine dans D1 le secteur d'un point (x=D6 et y=D7)
findsec:     
             clr.l     d1
             move.w    d7,d1
             sub.w     clipyd,d1            ; positionne bit 31
             lsl.l     #1,d1                ; protege bit 31->bit30
             move.w    d7,d1
             sub.w     clipyf,d1
             neg.w     d1
             lsl.l     #1,d1
             move.w    d6,d1
             sub.w     clipxf,d1
             neg.w     d1
             lsl.l     #1,d1
             move.w    d6,d1
             sub.w     clipxd,d1
             lsl.l     #1,d1
             swap.w    d1
             rts       
; retrouve le point d'intersection entre la ligne de P1 vers P2
findpoin:    
             move.w    d2,d4
             move.w    d3,d5
             add.w     a2,d4
             ext.l     d4
             lsr.l     #1,d4
             add.w     a3,d5
             ext.l     d5
             lsr.l     #1,d5
             move.w    d4,d6
             move.w    d5,d7
             jsr       findsec
             move.w    p2code,d6
             and.w     d1,d6
             bne       fautre
             cmp.w     d4,d2
             bne       findw1
             cmp.w     d5,d3
             beq       ffin
findw1:      
             cmpa.w    d4,a2
             bne       findw2
             cmpa.w    d5,a3
             bne       findw2
             bra       ffin
findw2:      
             move.w    d4,d2
             move.w    d5,d3
             move.w    d1,p1code
             bra       findpoin
fautre:      
             cmpa.w    d4,a2
             bne       fautre1
             cmpa.w    d5,a3
             beq       ffin
fautre1:     
             cmp.w     d4,d2
             bne       fautre2
             cmp.w     d5,d3
             beq       ffin
fautre2:     
             tst.w     p1code
             beq       fautre3
             move.w    d1,d7
             and.w     p1code,d7
             bne       fexit
fautre3:     
             movea.w   d4,a2
             movea.w   d5,a3
             move.w    d1,p2code
             bra       findpoin
fexit:       
             move.w    #1,p1code
ffin:        
             rts       
; Données pour la rotation
rotbzx:      .DC.w 0
rotbzy:      .DC.w 0
rotbzz:      .DC.w 0
offx:        .DC.w 0
offy:        .DC.w 0
offz:        .DC.w 0
xoffs:       .DC.w 0
yoffs:       .DC.w 0
zoffs:       .DC.w 0
sinx:        .DC.w 0
sinz:        .DC.w 0
siny:        .DC.w 0
cosx:        .DC.w 0
cosy:        .DC.w 0
cosz:        .DC.w 0
xangl:       .DC.w 0
yangl:       .DC.w 0
zangl:       .DC.w 0
vitangle:    .DC.w 5
rotx11:      .DC.w 16384
rotx12:      .DC.w 0
rotx13:      .DC.w 0
rotx21:      .DC.w 0
rotx22:      .DC.w 16384
rotx23:      .DC.w 0
rotx31:      .DC.w 0
rotx32:      .DC.w 0
rotx33:      .DC.w 16384
matric11:    .DC.w 0
matric12:    .DC.w 0
matric13:    .DC.w 0
matric21:    .DC.w 0
matric22:    .DC.w 0
matric23:    .DC.w 0
matric31:    .DC.w 0
matric32:    .DC.w 0
matric33:    .DC.w 0
; /* données pour la transformation */
xrec:        .DC.w 0
yrec:        .DC.w 0
z:           .DC.w 0
; /* données pour le clipping */
gauchx:      .DC.w 0
gauchy:      .DC.w 0
droitex:     .DC.w 0
droitey:     .DC.w 0
p1code:      .DC.w 0
p2code:      .DC.w 0
code1:       .DC.w 0
code2:       .DC.w 0
clipxd:      .DC.w 80
clipyd:      .DC.w 75
clipxf:      .DC.w 127
clipyf:      .DC.w 134
ecran1:      .DC.l 0
ecran2:      .DC.l 0
xplot:       .DC.l 0
yplot:       .DC.l 0
linxy:       .DC.l 0
nbrcoi:      .DC.w 0
nbrlin:      .DC.w 0
pointx:      .DC.l 0
pointy:      .DC.l 0
pointz:      .DC.l 0
datx:        .DC.l 0
daty:        .DC.l 0
datz:        .DC.l 0
imagx:       .DC.w 112
imagy:       .DC.w 105


; ***************************************************************************

adr_obj:     .DC.l homme                    ; adresse de l'objet traité

;          include work:batII/sources/bob/bob_hom_1.s ¨Nom de fichier non sp‚cifi‚
; *****************************************************
; *****************************************************
; *******                                       *******
; *******                  BIO                  *******
; *******                                       *******
; *****************************************************
; *****************************************************
biodes:      
             jsr       clear
             clr.b     sort
; afficher touche EXIT
             move.l    #bobxd+5,d0
             move.l    #bobyd+5+(12*5),d1
             move.l    #bobxf-5,d2
             move.l    #bobyd+15+(12*5),d3
             movem.l   d0-d7/a0-a6,-(sp)
             addq.w    #1,d0
             addq.w    #1,d1
             addq.w    #1,d2
             addq.w    #1,d3
             moveq.l   #couleur_ombre,d4
             jsr       box
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #couleur_ecr,d4
             jsr       box
             movem.l   (sp)+,d0-d7/a0-a6
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     ch_bio,a0
             lea.l     18*5(a0),a0
             moveq.l   #couleur_ecr,d4
             move.w    d1,d2
             move.w    d0,d1
             addi.w    #14,d1
             addi.w    #3,d2
             jsr       write
             movem.l   (sp)+,d0-d7/a0-a6
             bsr       affisub
             rts       

; -----------------------------------------------------
; afficher les noms des implants sous forme de touche.
;
affisub:     
; affichage des touches substances
             lea.l     ch_bio,a0
             lea.l     substance,a1
             move.l    #bobxd+5,d0
             move.l    #bobyd+5,d1
             move.l    #bobxf-5,d2
             move.l    #bobyd+15,d3
             moveq.l   #5-1,d5
bio_affiloop:          
; afficher ombre des touches
             movem.l   d0-d7/a0-a6,-(sp)
             addq.w    #1,d0
             addq.w    #1,d1
             addq.w    #1,d2
             addq.w    #1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             movem.l   (sp)+,d0-d7/a0-a6
; afficher touches (rouge si implant actif...)
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #couleur_ecr,d4
             tst.w     (a1)
             beq.s     affisub0
             moveq.l   #rouge,d4
affisub0:    
             jsr       boxbob
             movem.l   (sp)+,d0-d7/a0-a6
; afficher nom de l'implant.
             movem.l   d0-d7/a0-a6,-(sp)
             moveq.l   #couleur_ecr,d4
             move.w    d1,d2
             move.w    d0,d1
             addi.w    #14,d1
             addi.w    #3,d2
             jsr       write
             movem.l   (sp)+,d0-d7/a0-a6
; implant suivant.
             addi.w    #12,d1
             addi.w    #12,d3
             addq.l    #2,a1
             lea.l     18(a0),a0
             dbra      d5,bio_affiloop
             rts       


bio:         
             jsr       biodes
             jsr       ecrswapbob
             jsr       biodes
; gestion des commandes
             clr.l     real_time_ad
bio_loop:    
             lea.l     zone_fonc_3,a0
             jsr       interac
             tst.b     sort
             beq.s     bio_loop
; sortir de la fonction bio
; reinitialisation des parametres du menu
; principal
             jsr       desmendep
             clr.b     sort
             rts       
; -----------------------------------------------------
; injection d'une substance dans le corps
;
injecter:    
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     substance,a0
             move.w    souri_8,d1
             ext.l     d1
             subi.w    #bobyd+5,d1
             divu.w    #12,d1
             lsl.w     #1,d1
             move.w    #1,0(a0,d1.w)
             bsr       affisub
             jsr       ecrswapbob
             bsr       affisub

             movem.l   (sp)+,d0-d7/a0-a6
             rts       

; *****************************************************
; *****************************************************
; *******                                       *******
; *******          CARACTERISTIQUES             *******
; *******                                       *******
; *****************************************************
; *****************************************************
; cette fonction de BOB affiche les caracteristiques
; courantes du joueur.
; L'experience correspond à la moyenne des caracteris-
; tiques potentielles.
; la progression correspond à l'avance du joueur vers
; la solution (%).
carac0:      
             jsr       clear
             clr.b     sort
; dessiner la touche EXIT
             move.w    #bobxd+5+1,d0
             move.w    #bobyf-20+1,d1
             move.w    #bobxf-5+1,d2
             move.w    #bobyf-5+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyf-20,d1
             move.w    #bobxf-5,d2
             move.w    #bobyf-5,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; ecriture de EXIT
             lea.l     ch_sante,a0
             move.w    #bobxd+52,d1
             move.w    #bobyd+66,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             jsr       caracaffi
             rts       
carac:       
             jsr       carac0
             jsr       carac0
; afficher les caracteristiques courantes
             move.l    #caracaffi,real_time_ad
carac_loop:  
             lea.l     zone_fonc_2,a0
             jsr       interac
             tst.b     sort
             beq.s     carac_loop
; sortir de la fonction caracteristique
; reinitialisation des parametres du menu
; principal
             jsr       desmendep
             clr.b     sort
             rts       
; -----------------------------------------------------
; routine d'affichage des caracteristiques
; courantes.
; Elle est executee de maniere tournante
; dans INTERAC.
caraflag:    
             .DC.w 0
caracaffi0:  
             move.l    a0,-(sp)
             lea.l     ch_carac,a0
             lea.l     jehan,a2
             lea.l     forc_c(a2),a1
             lea.l     forc_p(a2),a2
             move.l    #bobxd+5,d1
             move.l    #bobyd+5,d2
             moveq.l   #0,d5
             moveq.l   #5,d3
             addq.w    #1,caraflag          ;           not.w    caraflag       ; pour le clignotement
carac_0:     
             moveq.l   #couleur_ecr,d4
             moveq.l   #0,d0
             moveq.l   #0,d6
             move.b    (a1)+,d0
             move.b    (a2),d6
; somme pour la moyenne des car_cour
             add.b     (a2)+,d5
             lsr.b     #1,d6
; clignote si (car_cour) inf (car_tpot)/2
             cmp.b     d6,d0
             bge.s     carac_1
             btst      #2,caraflag+1        ;tst.w    caraflag
             bne.s     carac_1
             moveq.l   #rouge,d4
carac_1:     
; les affichages
             ext.l     d0
             jsr       convasc
             move.w    chiffre+8,16(a0)
             move.b    chiffre+10,18(a0)
             jsr       write
             lea.l     20(a0),a0
             addq.w    #7,d2
             dbra      d3,carac_0
; affichage de l'experience
             moveq.l   #couleur_ecr,d4
;!!!!!              divu.w   #6,d5
;!!!!!              move.w   d5,d0
             move.w    experience,d0        ;!!!!!
             ext.l     d0
             jsr       convasc
             move.w    chiffre+8,16(a0)
             move.b    chiffre+10,18(a0)
             jsr       write
; affichage de la progression
             moveq.l   #couleur_ecr,d4
             lea.l     20(a0),a0
             addq.w    #7,d2
             move.w    progression,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,17(a0)
             move.b    chiffre+10,18(a0)
             jsr       write
             movea.l   (sp)+,a0
caracaffi_fin:         
             rts       
caracaffi:   
             jsr       caracaffi0
             jsr       ecrswapbob
             rts       

; *****************************************************
; *****************************************************
; *******                                       *******
; *******             PROGRAMMATION             *******
; *******                                       *******
; *******              COMPILATEUR              *******
; *******                                       *******
; *****************************************************
; *****************************************************
;                   Compilateur TOKEN
; -----------------------------------------------------
;  Le compilateur TOKEN transforme la feuille de shema
; en une suite d'instructions  comprehensibles par le
; module d'execution.
;
;  Dans la feuille de shema, nous pouvons avoir plusieurs
; programmes cohabitants ensembles sans aucune liaison !
; Les points d'accès à ces programmes sont designés com-
; me des "STARTs".
;
;  Une composante d'un programme donné,est soit un etat
; (RUN,STOP ou END), soit une fonction (DO,IF) ou encore
; un saut dérivé ou pas (JMP ou CRT).
;
;  J'appelle un pointeur de programme un JETON (ou Token...)
; Chaque jeton est associe a une zone de variables locales.
; Un jeton est inséré a chaque start au debut de l'execution.
; Grace aux lignes de liaison dérivées, un jeton peut se
; multiplier (CRT).
;  Se multiplier,c'est inserer un nouveau jeton dans une liste
; A l'execution, chaque jeton de la liste sera executé conse-
; cutivement, on a donc a faire a un simulateur de LANGAGE
; PARALLELE !!!.
;
; Le programme compilé :
; ----------------------
;  Il est composé de deux parties, le HEADER (entetes) et
; le BODY (instructions du programme).
; Je mets dans le header les adresses des starts pour le
; demarrage.
;  Je mets (toujours moi...)  les instructions  compilées
; de la feuille de shema dans le body, et  evidemment de
; manière séquentielle...
;
;1) les instructions sont :
;   -----------------------
;         - (00) NOP       : (No OPeration) rien a faire...
;         - (01) RUN       : Genere un jeton et le propage PC+1
;         - (02) STOP      : Bloque un jeton a l'adresse PC
;         - (03) END       : Detruit un jeton ou le reboucle
;                            au dernier RUN
;         - (04) DO p1,p2  : Execute une fonction (initialise la
;                            table des variables)
;         - (05) IF p1,p2  : Teste une configuration de variables...
;                            Si le teste est faux, on saute a
;                            l'offset contenue par PC+6 sinon on
;                            saute a PC+8...
;         - (06) JMP xxxx  : (JUMP) pas de deviation = adresse
;                            suivante
;            ou  CRT xxxx  : (CReate Token) Inserer un nouveau jeton
;                            dans la liste
;
;
;2) Les STARTs :
;   ------------
;         Le START est la premiere fonction ou un jeton est insere.
;         Dans une feuille de shema, il peut y avoir plusieurs STARTs.
;
; -----------------------------------------------------
;
bob_compilateur:       
             clr.w     bobcons
             clr.w     running
             clr.l     error_ad
;
; nettoyer la memoire pour le programme compilé...
             lea.l     header,a0
bob_clearpg0:          
             cmpa.l    #body_end,a0
             beq.s     bob_clearpg1
             clr.w     (a0)+
             bra.s     bob_clearpg0
bob_clearpg1:          
;
; ** compiler que si qqchose a été édité **
             moveq.l   #0,d1
             lea.l     feuille,a0
             move.l    #(viewsheet_maxx*viewsheet_maxy)-1,d0
bobcomp:     
             add.w     (a0)+,d1
             dbra      d0,bobcomp
             tst.w     d1
             beq       bob_compil_fin       ; rien n'a ete edite...
; ** chercher les "starts"
; empiler un 0 pour detecter la fin
             clr.l     -(sp)
             lea.l     feuille,a0
             move.l    #(viewsheet_maxx*viewsheet_maxy)-1,d1
bobcomp0:    
; regles pour qu'une fonction soit un start:
;       - fonction RUN,STOP ou DO
;       - aucune fonction au dessus
;       - une fonction au dessous
             movea.l   a0,a1
             bsr       test_fonc
             tst.w     d0
             beq.s     bobcomp0_fin
; est-ce un RUN ?
             cmpi.w    #1,d0
             beq.s     bobcomp1
; est-ce un STOP ?
             cmpi.w    #2,d0
             beq.s     bobcomp1
; est-ce une fonction DO ?
             cmpi.w    #4,d0
             bne.s     bobcomp0_fin
bobcomp1:    
; il n'y a rien au dessus du start...
buggfa2      equ viewsheet_maxx*2
             cmpa.l    #feuille+buggfa2,a0  ; pas tester dessus si haut de la
             blt.s     bobcomp11            ; feuille
             tst.w     (-viewsheet_maxx*2)(a0)
             bne.s     bobcomp0_fin
bobcomp11:   
; il y a une instruction en dessous...
             tst.w     (viewsheet_maxx*2)(a0)
             beq.s     bobcomp0_fin
; il n'y a rien a gauche (ce n'est pas une fonction)
             cmpa.l    #feuille,a0
             beq.s     bobcomp111
             tst.w     -2(a0)               ; qqchose a gauche si
             bne.s     bobcomp0_fin
bobcomp111:  
; ici la fonction est bien un START
; l'empiler...
             move.w    #1,running           ; a priori,ca va marcher...
             pea       (a0)

bobcomp0_fin:          
             addq.l    #2,a0
             dbra      d1,bobcomp0

;
; partir de chaque START et compiler le(s) programme(s)
             lea.l     body,a6
bob_compil_loop:       
             move.l    (sp)+,d7
             beq.s     bob_compil_fin
             movea.l   d7,a0
             bsr       building_body
             bra.s     bob_compil_loop
bob_compil_fin:        
             rts       
; -----------------------------------------------------
; Renvoie le numero de la fonction a l'adresse A1
; dans D0.
; Numero   : 0   1   2    3   4  5  6
; Fonction : ?   RUN STOP END DO IF CRT ou JMP
test_fonc:   
             moveq.l   #0,d0
             tst.w     (a1)
             beq.s     test_fonc_fin
             cmpi.w    #128,(a1)            ; ok si sup 128
             blt.s     test_fonction
             moveq.l   #6,d0                ; JUMP ou CRT
             rts       
; -------------------------
; TESTER fonction RUN,STOP ou END
test_fonction:         
             cmpi.w    #_end,(a1)
             bgt.s     test_fonc_fin        ; pas ok si sup end et inf 128
; ici commencer les test
             cmpi.w    #run,(a1)
             blt.s     test_fonc0
; fonctions RUN,STOP ou END
             move.w    (a1),d0
             subi.w    #run-1,d0
             rts       
; -------------------------
; TESTER fonction IF
test_fonc0:  
             cmpi.w    #si_droite,4(a1)
             bne.s     test_fonc1
             cmpi.w    #si_bas,viewsheet_maxx*2(a1)
             bne.s     test_fonc1
; fonction SI
             moveq.l   #5,d0
             rts       
; -------------------------
; TESTER fonction DO
; il y a t-il un parametre ?
test_fonc1:  
             tst.w     2(a1)
             beq.s     test_fonc_fin
; ici on teste si la fonction est possible
             lea.l     do_p2_pointe_p1,a3
             move.w    (a1),d2
             lsl.w     #2,d2
             movea.l   0(a3,d2.w),a3
             cmpa.l    #p1_rien,a3
             beq.s     test_fonc_fin
; ici on teste si la variable est possible
             move.w    2(a1),d2
             subq.w    #5,d2                ; code variable
test_doloop: 
             cmpi.w    #$ffff,(a3)+
             beq.s     test_fonc_fin
             cmp.w     -2(a3),d2
             bne.s     test_doloop
; fonction DO
             moveq.l   #4,d0
test_fonc_fin:         
             rts       

; ----------------------------------------------------------
;
; TRACER pour CONSTRUIRE le BODY...
;         dans A0 : adresse du "start" dans la feuille.
;         dans A6 : adresse ou l'on met le programme compile.
building_body:         
             move.l    a6,d6                ;rajout 1
; fixer la pile des IFs
             lea.l     pile_if,a5
             lea.l     pile_crt,a4
             clr.l     -(a4)
             clr.l     -(a4)
             clr.l     -(a5)
             clr.l     -(a5)                ; empiler des 0 pour detecter la fin
; inserer un start
             lea.l     header,a2
building_is: 
             cmpa.l    #header_end,a2
             beq       compil_error         ; trop de programmes !
             tst.l     (a2)+
             bne.s     building_is
             move.l    a6,-4(a2)            ; on insere le start...
;
; et on compile les instructions consecutives au start
; jusqu'a ce qu'on rencontre un 'END'

build_body_loop:       
;              move.w   #0,$ff8240
             movea.l   a0,a1
             bsr       test_fonc
             tst.w     d0
             beq.s     compil_error
;             move.w   #$770,$ff8240
; quelle instruction a compiler ?
             cmpi.w    #2,d0
             ble       c_runstop
             cmpi.w    #3,d0
             beq.s     c_end
             cmpi.w    #4,d0
             beq       c_do
             cmpi.w    #5,d0
             beq       c_if
             cmpi.w    #6,d0
             beq       c_jumpcrt
; suite de la compilation
compil_next: 
             cmpa.l    #body_end,a6
             bge.s     compil_error         ; programme trop long
;              move.w   #$707,$ff8240

             tst.w     (a0)
             bne.s     build_body_loop      ; on recommence...
             bra.s     compil_error
; fin de la compilation d'un programme
trace_compfin:         
;rajout 2
             movea.l   d7,a0
             cmpi.w    #_stop,(a0)          ;pas de consommation
             beq.s     nostcons             ;si le prog est en stop
             move.l    a6,d0
             sub.l     d6,d0
             cmp.w     bobcons,d0
             blt.s     nostcons
             move.w    d0,bobcons
nostcons:    
;fin rajout 2
             rts       
; ----------------------------------------------------------
; positionne le flag "running" a l'etat erreur
compil_error:          
             move.l    a0,error_ad
             move.w    #2,running
             rts       
; ----------------------------------------------------------
; compiler la fonction END
c_end:       
             move.w    d0,(a6)+
; branche IF a compiler ?
c_end_iftest:          
             tst.l     (a5)
             beq.s     c_end_crtest
             movea.l   (a5),a3              ; recuperer adresse JUMP de IF
             move.l    a6,d0                ; calculer deplacement
             sub.l     (a5)+,d0             ; relatif
             move.w    d0,(a3)              ; stocke deplacement
             movea.l   (a5)+,a0             ; recupere adresse nlle compilation
             move.l    a0,acjc
             subq.l    #2,acjc              ; calculer PC-2
             move.w    #1,typebranche
             bra       compil_next
; branche CRT a compiler
c_end_crtest:          
             tst.l     (a4)
             beq.s     trace_compfin
             movea.l   (a4),a3              ; calculer et stocker
             move.l    a6,d0                ; deplacement relatif
             sub.l     (a4)+,d0
             move.w    (a3),d1              ; recuperer offset ancien PC
             ext.l     d1
             move.w    d0,(a3)
             movea.l   (a4)+,a0             ; calculer ancien PC
             move.l    a0,acjc
             add.l     d1,acjc
             move.w    #2,typebranche
             clr.w     wherecrt
             bra       compil_next

; ----------------------------------------------------------
; compiler les fonctions RUN ou STOP
c_runstop:   
             move.w    d0,(a6)+
; pointer sur l'instruction suivante
             move.l    a0,acjc
             lea.l     (viewsheet_maxx*2)(a0),a0
             bra       compil_next
; ----------------------------------------------------------
; compiler DO
c_do:        
             move.w    d0,(a6)+
             move.w    (a0),(a6)+
             move.w    2(a0),(a6)
             subq.w    #5,(a6)+             ; code variable
; pointer sur l'instruction suivante
             move.l    a0,acjc
             lea.l     (viewsheet_maxx*2)(a0),a0
             bra       compil_next
; ----------------------------------------------------------
; compiler IF
c_if:        
             move.w    d0,(a6)+
             move.w    (a0),(a6)+
             move.w    2(a0),(a6)
             subi.w    #5,(a6)+             ; code variable
             move.l    a0,-(a5)             ; prochain start
             addq.l    #6,(a5)              ; 6 octets plus loin
             move.l    a6,-(a5)             ; sauve adresse du JUMP
             move.w    #$0000,(a6)+         ; memoire pour le deplacement
; pointer sur l'instruction suivante
             move.l    a0,acjc
             lea.l     (viewsheet_maxx*2)*2(a0),a0
             bra       compil_next
; ----------------------------------------------------------
; compiler JUMP ou CRT
; Dans le cas d'une simple liaison (jump),on trace jusqu'a
; trouver l'adresse de la prochaine instruction.
; Dans le cas d'une deviation, on insere un CRT
c_jumpcrt:   
; JUMP ou CRT ?
             move.w    (a0),d0
             subi.w    #128,d0
             moveq.l   #3,d2
             moveq.l   #0,d1
cjc_loop:    
             lsr.w     #1,d0
             bcc.s     cjc_pass
             addq.w    #1,d1
cjc_pass:    
             dbra      d2,cjc_loop
             cmpi.w    #2,d1
             blt       compil_error         ; si c'est "1",erreur de liaison
             bgt       cjc_crt
;
; ----------------------------------
; | c'est un JUMP !                |
; | trouver l'instruction suivante |
; ----------------------------------
;
; on se deplace a l'instruction suivante (gauche,droite,haut,bas)
; Acjc   = adresse de la derniere instruction compilee
; [Acjc] = derniere instruction compilee
;         d0 ou (a0)      = Cc : code courant (le jump analysé)
;          -2(a0)         = Cg : code a gauche
;           2(a0)         = Cd : code a droite
; -(viewsheet_maxx*2)(a0) = Cu : code au dessus
; (viewsheet_maxx*2)(a0)  = Co : code au dessous
;            &            = operateur AND
;
;  ------------------------------------------------------------------
;  | REMARQUES:                                                      |
;  |             (1) : JUMP a droite avec une instruction  a droite  |
;  |                   genere une erreur de compilation  (ou JUMP a  |
;  |                   gauche avec un instruction a gauche, ou JUMP  |
;  |                   en haut avec une instruction en haut).        |
;  |             (2) : DONC, un JUMP  arrive  a une instruction PAR  |
;  |                   LE HAUT...                                    |
;  ------------------------------------------------------------------
;
;  J'introduis une nouvelle regle pour eviter les cas litigieux de
;  la compilation.En effet je n'ai pas trouvé d'algorithme simple
;  pour detecter les problemes de boucles imbriquees par des CRTs
;
;  Ex:              DO  p1,p2
;
;                   CRT aaaa
;
;                   DO  p3,p4
;
;           bbbb:   END
;
;           aaaa:   DO  p5,p6
;
;                   JMP bbbb
;
;   J'arrive toujours a des erreurs de compilation (en fait le
;   JMP bbbb est derive d'un CRT ou la branche du haut,rebouclee
;   sur le DO p3,p4, genere une erreur de compilation)
;
;   Pour eviter ce genre de problemes, j'ai decide que l'on ne
;   pouvait pas compiler vers le haut donc:
;
;   Une branche se propageant vers le haut n'est pas examinée
;   ---------------------------------------------------------
;
cjc_jmp:     
;         tester a gauche
             movea.l   acjc,a2
             movea.l   a0,a3
             lea.l     -2(a3),a3
             move.w    (a0),d1
             andi.w    #%0000000000001000,d1      ; SI (Cc & $8) dif 0
             beq.s     cjc_nogauche
             move.w    (a3),d1              ;   ET (Cg & $2) dif 0
             andi.w    #%0000000000000010,d1
             beq.s     cjc_nogauche         ;
             cmpa.l    a3,a2                ;     ET ( [Cg] dif [Acjc] )
             beq.s     cjc_nogauche         ;
             cmpi.w    #128,(a3)            ;         ET (Cg sup/eg 128)
             blt       compil_error         ; cf (1)
;         ok pour a gauche
cjc_gauche:  
             move.l    a0,acjc
             lea.l     -2(a0),a0
             move.w    (a0),d0
             movea.l   acjc,a3
             cmp.w     (a3),d0
             beq.s     cjc_gauche
             bra       compil_next
;
; tester a droite
cjc_nogauche:          
             movea.l   a0,a3
             lea.l     2(a3),a3
             move.w    (a0),d1
             andi.w    #%0000000000000010,d1      ; SI (Cc & $2) dif 0
             beq.s     cjc_nodroite
             move.w    (a3),d1              ;   ET (Cd &$8) dif 0
             andi.w    #%0000000000001000,d1
             beq.s     cjc_nodroite
             cmpa.l    a3,a2                ;     ET ( [Cd] dif [Acjc] )
             beq.s     cjc_nodroite
             cmpi.w    #128,(a3)            ;       ET (Cd sup/eg 128)
             blt       compil_error         ; cf (1)
; ok pour a droite
cjc_droite:  
             move.l    a0,acjc
             lea.l     2(a0),a0
             move.w    (a0),d0
             movea.l   acjc,a3
             cmp.w     (a3),d0
             beq.s     cjc_droite
             bra       compil_next
;
; tester au dessous
; petit changement : un JUMP dessous plus instruction est compilable
cjc_nodroite:          
             movea.l   a0,a3
             lea.l     (viewsheet_maxx*2)(a3),a3
             cmpa.l    #feuille_end,a3
             bgt       compil_error
             move.w    (a0),d1
             andi.w    #%0000000000000100,d1      ; SI (Cc & $4) dif 0
             beq       cjc_forgive          ; pas de possiblite au dessous !
             cmpi.w    #128,(a3)            ; cf (2)
             blt.s     cjc_dessous          ;   ET (Co sup/eg 128)
             move.w    (a3),d1
             andi.w    #%0000000000000001,d1      ;     ET (Co & $1) dif 0
             beq       compil_error         ; pas de possiblite du dessous !
             cmpa.l    a3,a2
             beq       compil_error         ;       ET ( [Co] dif [Acjc] )
; ok pour dessous
cjc_dessous: 
             move.l    a0,acjc
             lea.l     (viewsheet_maxx*2)(a0),a0
             move.w    (a0),d0
             movea.l   acjc,a3
             cmp.w     (a3),d0
             beq.s     cjc_dessous
             bra       compil_next
;
;
; ----------------------------------
; | c'est un CRT !                 |
; |                                |
; ----------------------------------
; On utilise le meme procédé que pour les JMP.
; Par contre, à chaque possibilité on insère un CRT (dddd)
; ou (dddd) = deplacement relatif  pour aller a la branche
; suivante...
;
; inserer les CRTs
cjc_crt:     
; -------------------------------
;       Transformation d'un CRT en JUMP ?
;  Ici, selon  la regle  de la non compilation
; remontante, on considere que si il y a trois
; possiblites dont l'une va vers le haut (bit0
; a 1) en a en fait que deux donc un JUMP.
;
; ne pas tester si la compilation est descendante
             movea.l   acjc,a2
             movea.l   a0,a3
             lea.l     -(viewsheet_maxx*2)(a3),a3
             cmpa.l    a3,a2
             beq.s     cjc_pass1
; dans le cas d'un if c'est plus haut...
             lea.l     -(viewsheet_maxx*2)(a3),a3
             cmpa.l    a3,a2
             beq.s     cjc_pass1
; transformer le CRT en JUMP
             move.w    (a0),d0
             btst.l    #0,d0
             beq.s     cjc_pass1
             cmpi.w    #3,d1
             ble       cjc_jmp
cjc_pass1:   
; -------------------------------
;         tester a gauche
             movea.l   acjc,a2
             movea.l   a0,a3
             lea.l     -2(a3),a3
             move.w    (a0),d1
             andi.w    #%0000000000001000,d1      ; SI (Cc & $8) dif 0
             beq.s     crt_nogauche
             move.w    (a3),d1              ;   ET (Cg & $2) dif 0
             andi.w    #%0000000000000010,d1
             beq.s     crt_nogauche         ;
             cmpa.l    a3,a2                ;     ET ( [Cg] dif [Acjc] )
             beq.s     crt_nogauche         ;
             cmpi.w    #128,(a3)            ;         ET (Cg sup/eg 128)
             blt       compil_error         ; cf (1)
;         ok pour a gauche
crt_gauche:  
             move.w    #6,(a6)+             ; code CRT
             move.l    a3,-(a4)             ; adresse prochain start
             move.l    a6,-(a4)             ; adresse deplacement
             move.w    #2,(a6)+             ; memoire pour le deplacement
;                                        ; avec code gauche
;         tester a droite
crt_nogauche:          
             movea.l   a0,a3
             lea.l     2(a3),a3
             move.w    (a0),d1
             andi.w    #%0000000000000010,d1      ; SI (Cc & $2) dif 0
             beq.s     crt_nodroite
             move.w    (a3),d1              ;   ET (Cd & $8) dif 0
             andi.w    #%0000000000001000,d1
             beq.s     crt_nodroite
             cmpa.l    a3,a2                ;     ET ( [Cd] dif [Acjc] )
             beq.s     crt_nodroite
             cmpi.w    #128,(a3)            ;       ET (Cd sup/eg 128)
             blt       compil_error         ; cf (1)
;         ok pour a droite
crt_droite:  
             move.w    #6,(a6)+             ; code CRT
             move.l    a3,-(a4)             ; adresse prochain start
             move.l    a6,-(a4)             ; adresse deplacement
             move.w    #-2,(a6)+            ; memoire pour le deplacement
;                                        ; avec code droite
;
; tester au dessous
; petit changement : un JUMP dessous plus instruction est compilable
crt_nodroite:          
             movea.l   a0,a3
             lea.l     (viewsheet_maxx*2)(a3),a3
             cmpa.l    #feuille_end,a3
             bgt       cjc_crt_fin
             move.w    (a0),d1
             andi.w    #%0000000000000100,d1      ; SI (Cc & $4) dif 0
             beq       cjc_crt_fin
             cmpi.w    #128,(a3)            ; cf (2)
             blt.s     crt_dessous          ;   ET (Co sup/eg 128)
             move.w    (a3),d1
             andi.w    #%0000000000000001,d1      ;     ET (Co & $1) dif 0
             beq       cjc_crt_fin          ; pas de possiblite du dessous !
             cmpa.l    a3,a2
             beq       compil_error         ;       ET ( [Co] dif [Acjc] )
;         ok pour dessous
crt_dessous: 
             move.w    #6,(a6)+             ; code CRT
             move.l    a3,-(a4)             ; adresse prochain start
             move.l    a6,-(a4)             ; adresse deplacement
             move.w    #-(viewsheet_maxx*2),(a6)+ ; memoire pour le deplacement
;                                        ; avec code dessous
; FIN de la compilation d'un CRT
; -------------------------------
; On depile le dernier token a inserer
; On l'enleve du programme car il va constituer
; la suite logique du programme.
cjc_crt_fin: 
             movea.l   (a4),a3              ; calculer et stocker
             move.l    (a4)+,d0             ; deplacement relatif
             sub.l     a6,d0
             move.w    (a3),d1              ; recuperer offset ancien PC
             ext.l     d1
             move.w    d0,(a3)
             movea.l   (a4)+,a0             ; calculer ancien PC
             move.l    a0,acjc
             add.l     d1,acjc
             clr.l     -4(a6)
             subq.l    #4,a6
             move.w    #2,typebranche
             move.w    #1,wherecrt
             bra       compil_next

wherecrt:    
             .DC.w 0

; lorsqu'une branche n'est pas valide
; on l'oublie et on remplace le code
; compile (un IF ou un CRT) par des NOPs...
; "typebranche" indique ce qu'il faut
; remplacer (IF ou CRT)...
cjc_forgive: 
             cmpi.w    #1,typebranche
             bne.s     cjc_forgive_crt
             movea.l   -8(a5),a3
             clr.w     -6(a3)               ; efface code IF
             clr.w     -4(a3)               ; efface code par1
             clr.w     -2(a3)               ; efface code par2
             clr.w     (a3)                 ; efface dddd
             bra       compil_error
cjc_forgive_crt:       
             cmpi.w    #2,typebranche
             bne       compil_error
             movea.l   -8(a4),a3
             clr.w     -2(a3)               ; efface code CRT
             clr.w     (a3)                 ; efface dddd
             cmpi.w    #1,wherecrt
             beq       cjc_crt_fin
             bra       c_end_crtest

; *****************************************************
; *****************************************************
; *******                                       *******
; *******             PROGRAMMATION             *******
; *******                                       *******
; *******                EDITEUR                *******
; *******                                       *******
; *****************************************************
; *****************************************************
; Cette partie de BOB permet d'automatiser des fonctions
; de l'ordinateur.
; Ici nous avons l'editeur et un module d'execution
; les affichages se font sur un petit ecran pendant
; le jeu.
;
; Au niveau de l'editeur de programmation:
; ---------------------------------------
; L'idee est de travailler sur une feuille de shema (sheet)
; (taille = viewsheet_maxx*viewsheet_maxy).
; C'est sur la partie visible de la feuille (viewsheet) que
; l'on compose une partie du programme (un scrolling 16x16)
; permet de se deplacer sur la feuille.
; L'ecran de BOB est separe en 3 zones (fig 1).
;
;              --------------------------
;              |            |           |
;              |  Zone 1    |   Zone 2  |
;              |            |           |
;              | ViewSheet  |-----------|
;              |            |           |
;              |            |   Zone 3  |
;              |            |           |
;              --------------------------
;
;       (Fig 1) Ecran de BOB en mode programmation
;
; Zone 1 : toute la partie gauche est reservee a la viewsheet
; Zone 2 : Cette zone contient la fonction active (quand on
;          clique dans la viewsheet, on insere la fonction
;          active dans le programme (feuille).
; Zone 3 : la partie en bas a droite (zone des commandes) permet
;          de controler l'ensemble du projet (Exit,New,Link)
; -----------------------------------------------------
;                       EDITEUR
;
bob_editdes: 
; les lignes des fonctions actives
             move.w    #bobxd+80,d0
             move.w    #bobyd+16,d1
             move.w    #bobxf,d2
             move.w    #bobyd+16,d3
             moveq.l   #couleur_f_prog,d4
             jsr       lignebob
             move.w    #bobxd+80,d0
             move.w    #bobyd+33,d1
             move.w    #bobxf,d2
             move.w    #bobyd+33,d3
             moveq.l   #couleur_f_prog,d4
             jsr       lignebob
; la ligne de droite
             move.w    #bobxd+80,d0
             move.w    #bobyd,d1
             move.w    #bobxd+80,d2
             move.w    #bobyf,d3
             moveq.l   #couleur_f_prog,d4
             jsr       lignebob
; la ligne du bas
             move.w    #bobxd,d0
             move.w    #bobyf,d1
             move.w    #bobxd+80,d2
             move.w    #bobyf,d3
             moveq.l   #couleur_f_prog,d4
             jsr       lignebob
; dessins de la touche Exit
             move.w    #bobxd+91+1,d0
             move.w    #bobyf-10+1,d1
             move.w    #bobxf,d2
             move.w    #bobyf,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+91,d0
             move.w    #bobyf-10,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-1,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             lea.l     ch_prog,a0
             move.w    #bobxd+91,d1
             move.w    #bobyf-8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; dessins de la touche New
             move.w    #bobxd+91+1,d0
             move.w    #bobyf-21+1,d1
             move.w    #bobxf,d2
             move.w    #bobyf-11,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+91,d0
             move.w    #bobyf-21,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-11-1,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             lea.l     ch_prog+8,a0
             move.w    #bobxd+91,d1
             move.w    #bobyf-11-8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; dessins de la touche link
             move.w    #bobxd+91+1,d0
             move.w    #bobyf-32+1,d1
             move.w    #bobxf,d2
             move.w    #bobyf-22,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+91,d0
             move.w    #bobyf-32,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-22-1,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             lea.l     ch_prog+56,a0
             move.w    #bobxd+91,d1
             move.w    #bobyf-22-8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; dessins de la touche delete
             move.w    #bobxd+91+1,d0
             move.w    #bobyf-43+1,d1
             move.w    #bobxf,d2
             move.w    #bobyf-33,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+91,d0
             move.w    #bobyf-43,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-33-1,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             lea.l     ch_prog+64,a0
             move.w    #bobxd+91,d1
             move.w    #bobyf-33-8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; affiche les fleches
             lea.l     ch_prog+16,a0
             move.w    #bobxd+84,d1
             move.w    #bobyf-8-30,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             lea.l     ch_prog+18,a0
             move.w    #bobxd+84,d1
             move.w    #bobyf-8-22,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             lea.l     ch_prog+20,a0
             move.w    #bobxd+85,d1
             move.w    #bobyf-8-11,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             lea.l     ch_prog+22,a0
             move.w    #bobxd+85,d1
             move.w    #bobyf-8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; dessiner la feuille de programmation
             bsr       des_feuilledes
; afficher le type de fonction
             clr.w     fonction
             bsr       bob_foncdes
; afficher les fonctions actives
             move.w    #$ffff,cpt_par1
             move.w    #$ffff,cpt_par2
             bsr       bob_par1
             rts       

bob_editeur: 
             jsr       clear
             clr.b     sort
             clr.w     flag_lier
             clr.w     flag_effacer
             jsr       ecrswapbob
             jsr       clear
             bsr       bob_editdes
             jsr       ecrswapbob
             bsr       bob_editdes

; gestion des erreurs, on repositionne la feuille
; de shema sur l'erreur.
             tst.l     error_ad
             beq       be_noerror
             move.l    error_ad,pviewsheet
; replacer le pointeur de la viewsheet
             subi.l    #viewsheet_maxx*4,pviewsheet
             move.l    error_ad,d0
             subi.l    #feuille,d0
             move.l    d0,d1
             divu.w    #viewsheet_maxx*2,d1
             swap.w    d1
             clr.w     d1
             swap.w    d1
             mulu.w    #viewsheet_maxx*2,d1
             sub.l     d1,d0
; tester a gauche et recentrer
             cmpi.l    #2,d0
             blt.s     be_error1
             subq.l    #2,pviewsheet
             cmpi.l    #4,d0
             blt.s     be_error1
             subq.l    #2,pviewsheet
; tester a droite et recentrer
be_error2:   
             cmpi.l    #30,d0
             ble.s     be_error1
             subq.l    #2,pviewsheet
             subq.l    #2,d0
             bra.s     be_error2
; tester en haut et recentrer
be_error1:   
             cmpi.l    #feuille,pviewsheet
             bge.s     be_error0
             move.l    #feuille,pviewsheet
; tester en bas et recentrer
be_error0:   
             move.l    pviewsheet,d0
             addi.l    #viewsheet_maxx*8,d0
             addq.l    #8,d0
             cmpi.l    #feuille_end,d0
             blt.s     be_error3
             subq.l    #2,pviewsheet
             bra.s     be_error0
be_error3:   
; recalculer les pointeurs cartésiens...
             move.l    pviewsheet,d0
             subi.l    #feuille,d0
             move.l    d0,d1
             divu.w    #viewsheet_maxx*2,d1
             move.w    d1,vsheet_y
             mulu.w    #viewsheet_maxx*2,d1
             sub.l     d1,d0
             lsr.w     #1,d0
             move.w    d0,vsheet_x
be_noerror:  


             move.l    #bob_zoom,real_time_ad
; boucle principale
prog_loop:   
             lea.l     zone_fonc_6,a0
             jsr       interac
             tst.b     sort
             beq.s     prog_loop
; en sortant de l'editeur,on compile le
; programme
             jsr       bob_compilateur
; sortir de la fonction programmation
; reinitialisation des parametres du menu
; principal
             jsr       desmendep
             clr.b     sort
             rts       

; -----------------------------------------------------
; routines pour lier des fonctions
bob_lier:    
             move.l    #bob_zoom,real_time_ad
             clr.w     flag_effacer
             moveq.l   #couleur_ecr,d4
             not.w     flag_lier
             beq.s     bob_lier_fin
             moveq.l   #rouge,d4
             clr.l     real_time_ad
bob_lier_fin:          
             move.l    d4,-(sp)
             jsr       bob_lierdes
             jsr       ecrswapbob
             move.l    (sp)+,d4
             jsr       bob_lierdes
             rts       
bob_lierdes: 
             move.l    d4,-(sp)
             moveq.l   #couleur_ecr,d4
             move.w    #bobxd+91,d0
             move.w    #bobyf-43,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-34,d3
             jsr       boxbob
             move.l    (sp)+,d4
             move.w    #bobxd+91,d0
             move.w    #bobyf-32,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-23,d3
             jsr       boxbob
             rts       
; -----------------------------------------------------
; routines pour effacer des fonctions
bob_effacer: 
             move.l    #bob_zoom,real_time_ad
             clr.w     flag_lier
             moveq.l   #couleur_ecr,d4
             not.w     flag_effacer
             beq.s     bob_effacer_fin
             clr.l     real_time_ad
             moveq.l   #rouge,d4
bob_effacer_fin:       
             move.l    d4,-(sp)
             jsr       bob_effacerdes
             jsr       ecrswapbob
             move.l    (sp)+,d4
             jsr       bob_effacerdes
             rts       

bob_effacerdes:        
             move.l    d4,-(sp)
             moveq.l   #couleur_ecr,d4
             move.w    #bobxd+91,d0
             move.w    #bobyf-32,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-23,d3
             jsr       boxbob
             move.l    (sp)+,d4
             move.w    #bobxd+91,d0
             move.w    #bobyf-43,d1
             move.w    #bobxf-1,d2
             move.w    #bobyf-34,d3
             jsr       boxbob
             rts       
; -----------------------------------------------------
; routines pour construire une fonction
; -----------------------------------------------------
; routines pour construire une fonction
; BOB_FONC selectionne le type de fonction Do,If
;          ex: Fonction Par1     Par2
;          ex:    If    Force    Normal
;          ex:    Do    Afficher Force
; BOB_PAR1 determine la premiere fonction
; BOB_PAR2 determine la deuxieme fonction
bob_fonc:    
             addq.w    #1,fonction
             cmpi.w    #5,fonction
             bne.s     bob_fonc_pass
             clr.w     fonction
bob_fonc_pass:         
; reinitialiser les parametres
             cmpi.w    #2,fonction
             bge.s     bob_fonc_fin
             move.w    #$ffff,cpt_par1
             bsr       bob_par1
bob_fonc_fin:          
             bsr       bob_foncdes
             jsr       ecrswapbob
             bsr       bob_foncdes
             rts       
; dessiner le type de fonction
bob_foncdes: 
; effacer la zone
             move.w    #bobxd+81,d0
             move.w    #bobyd+16,d1
             move.w    #bobxd+80+15,d2
             move.w    #bobyd+16+15,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
; choix et affichage de la fonction
             lea.l     ch_prog+24,a0
             tst.w     fonction
             beq.s     bob_fonc0
             cmpi.w    #1,fonction
             bne.s     bob_fonc_etat
             addq.l    #4,a0
bob_fonc0:   
             move.w    #bobxd+80+3,d1
             move.w    #bobyd+5+16,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             rts       
; afficher les fonctions d'etat (run,_stop,_end) du
; programme
bob_fonc_etat:         
             move.w    fonction,d0
             subi.w    #2,d0
             lsl.w     #7,d0
             movea.l   adrfoncbob,a1
             adda.w    #run*128,a1
             lea.l     0(a1,d0.w),a1
             movea.l   sys01,a0
             lea.l     12*4+(slarg*(16+71))(a0),a0
             jsr       put_16
             movea.l   adrfoncbob,a1        ;lea.l    fonc_bob,a1
             movea.l   sys01,a0
             lea.l     14*4+(slarg*(16+71))(a0),a0
             jsr       put_16
             movea.l   adrfoncbob,a1        ;lea.l    fonc_bob,a1
             movea.l   sys01,a0
             lea.l     16*4+(slarg*(16+71))(a0),a0
             jsr       put_16
             rts       
; -----------------------------------------------------
; routines pour incrementer le premier parametre
; de la fonction active
; incrementation sauvage
bob_par1:    
             cmpi.w    #1,fonction
             bgt       bob_par1_fin
bob_par1_start:        
             addi.w    #1,cpt_par1
             cmpi.w    #nbpar1,cpt_par1
             blt.s     bob_par1_0
             clr.w     cpt_par1
bob_par1_0:  
; teste si un deuxième paramŠtre est possible
; si non on cherche le suivant (premier paramètre)
             lea.l     do_p2_pointe_p1,a0
             cmpi.w    #1,fonction
             bne.s     bob_par1_do
             lea.l     if_p2_pointe_p1,a0
bob_par1_do: 
             move.w    cpt_par1,d0
             lsl.w     #2,d0
             movea.l   0(a0,d0.w),a0
             tst.w     (a0)
             beq.s     bob_par1_start
; affichage du sprite
             bsr       bob_par1des
             jsr       ecrswapbob
             bsr       bob_par1des
             jsr       ecrswapbob
; affichage du deuxieme parametre
             move.w    #$ffff,cpt_par2
             bsr       bob_par2
bob_par1_fin:          
             rts       
bob_par1des: 
; affichage du sprite
             movea.l   sys01,a0
             lea.l     14*4+(slarg*(16+71))(a0),a0
             movea.l   adrfoncbob,a1        ;lea.l    fonc_bob,a1
             move.w    cpt_par1,d0
             move.w    d0,param1
             lsl.w     #7,d0
             lea.l     0(a1,d0.w),a1
             jsr       put_16
             move.w    #bobxd+82,d0
             move.w    #bobyd+2,d1
             move.w    #bobxd+82+42,d2
             move.w    #bobyd+2+8,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             move.w    param1,d0
             lsl.w     #3,d0                ; modulo 8 octets
             lea.l     ch_nom_icone,a0
             lea.l     0(a0,d0.w),a0
             move.w    #bobxd+82,d1
             move.w    #bobyd+2,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             rts       
; -----------------------------------------------------
; routines pour incrementer le deuxieme parametre
; de la fonction active
; L'incrementation est fonction du premier parametre
; (voir tables if_p2_pointe_p1 ou do_p2_pointe_p1)
bob_par2:    
             cmpi.w    #1,fonction
             bgt       bob_par2_fin
             moveq.l   #0,d0
; pointer sur la table correspondant
; a la fonction (if ou do)
             lea.l     do_p2_pointe_p1,a0
             cmpi.w    #1,fonction
             bne.s     table_do
             lea.l     if_p2_pointe_p1,a0
table_do:    
; pointer maintenant sur la table qui indique
; les variables possibles selon la fonction choisie
             move.w    cpt_par1,d0
             lsl.w     #2,d0                ; x4 pour les .L
             movea.l   0(a0,d0.w),a0
             addi.w    #1,cpt_par2
             move.w    cpt_par2,d0          ; pointer sur la var en cours
             lsl.w     #1,d0
             cmpi.w    #$ffff,0(a0,d0.w)    ; fin des variables ?
             bne.s     display_par2
             clr.w     d0
             clr.w     cpt_par2
; afficher l'icone
display_par2:          
             move.w    0(a0,d0.w),d0
             beq.s     display_par2_0
; les variables commencent apres l'icone analyser
             addq.w    #5,d0
display_par2_0:        
             move.l    d0,-(sp)
             jsr       bob_par2des
             jsr       ecrswapbob
             move.l    (sp)+,d0
             jsr       bob_par2des
             jsr       ecrswapbob
bob_par2_fin:          
             rts       

bob_par2des: 
             move.w    d0,param2
             lsl.w     #7,d0
             movea.l   adrfoncbob,a1
             lea.l     0(a1,d0.w),a1
             movea.l   sys01,a0
             lea.l     16*4+(slarg*(16+71))(a0),a0
             jsr       put_16
; afficher le nom choisi
             move.w    #bobxd+82,d0
             move.w    #bobyd+10,d1
             move.w    #bobxd+82+42,d2
             move.w    #bobyd+10+5,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             move.w    param2,d0
             lsl.w     #3,d0                ; modulo 8 octets
             lea.l     ch_nom_icone,a0
             lea.l     0(a0,d0.w),a0
             move.w    #bobxd+82,d1
             move.w    #bobyd+10,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             rts       

; -----------------------------------------------------
; routines de scrolling
; Ce sous-programme scrolle la feuille
; vers la droite
bob_droite:  
             cmpi.w    #viewsheet_maxx-5,vsheet_x
             beq.s     bob_droite_fin
             addq.l    #2,pviewsheet
             addq.w    #1,vsheet_x
             bsr       des_feuille_pro      ; mis a jour de la viewsheet
bob_droite_fin:        
             rts       
; -----------------------------------------------------
; Ce sous-programme scrolle la feuille
; vers la gauche
bob_gauche:  
             tst.w     vsheet_x
             beq.s     bob_gauche_fin
             subq.l    #2,pviewsheet
             subq.w    #1,vsheet_x
             bsr       des_feuille_pro      ; mis a jour de la viewsheet
bob_gauche_fin:        
             rts       
; -----------------------------------------------------
; Ce sous-programme scrolle la feuille
; vers le haut
bob_haut:    
             tst.w     vsheet_y
             beq.s     bob_haut_fin
             subi.l    #viewsheet_maxx*2,pviewsheet
             subq.w    #1,vsheet_y
             bsr       des_feuille_pro      ; mis a jour de la viewsheet
bob_haut_fin:          
             rts       
; -----------------------------------------------------
; Ce sous-programme scrolle la feuille
; vers le bas
bob_bas:     
             cmpi.w    #viewsheet_maxy-5,vsheet_y
             beq.s     bob_bas_fin
             addi.l    #viewsheet_maxx*2,pviewsheet
             addq.w    #1,vsheet_y
             bsr       des_feuille_pro      ; mis a jour de la viewsheet
bob_bas_fin: 
             rts       
; -----------------------------------------------------
; Ce sous-programme permet d'effacer
; toute la feuille de schema
bob_new:     
             bsr       bob_dbox
             tst.w     dbchoix
             beq.s     pasbobnew
; effacer la feuille de shema
             lea.l     feuille,a0
             move.l    #viewsheet_maxx*viewsheet_maxy,d0    ; 100 mots a effacer
             subq.l    #1,d0
bob_new_loop:          
             clr.w     (a0)+
             dbra      d0,bob_new_loop
             clr.w     running
             clr.l     error_ad
pasbobnew:   
             bsr       des_feuille_pro
             rts       
; -----------------------------------------------------
; Ce sous-programme permet d'afficher une boite
; de dialogue
bob_dbox:    
             jsr       bob_dboxdes
             jsr       ecrswapbob
             jsr       bob_dboxdes
; afficher une boite de confirmation

; gestion interactive de la reponse
             clr.b     sort
bobdbl:      
             lea.l     zone_fonc_7,a0
             jsr       interac
             tst.b     sort
             beq.s     bobdbl
             clr.b     sort
             rts       
bob_dboxdes: 
; dessiner les boites
             move.w    #bobxd+2,d0
             move.w    #bobyd+24,d1
             move.w    #bobxd+78,d2
             move.w    #bobyd+56,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             move.w    #bobxd+1,d0
             move.w    #bobyd+23,d1
             move.w    #bobxd+78,d2
             move.w    #bobyd+57,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             move.w    #bobxd+5-1,d0
             move.w    #bobyd+42-1,d1
             move.w    #bobxd+35-1,d2
             move.w    #bobyd+54-1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyd+42,d1
             move.w    #bobxd+35,d2
             move.w    #bobyd+54,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
             move.w    #bobxd+45-1,d0
             move.w    #bobyd+42-1,d1
             move.w    #bobxd+75-1,d2
             move.w    #bobyd+54-1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+45,d0
             move.w    #bobyd+42,d1
             move.w    #bobxd+75,d2
             move.w    #bobyd+54,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; afficher les textes
             lea.l     dbafoui,a0
             move.w    #bobxd+11,d1
             move.w    #bobyd+45,d2
             move.w    #couleur_ecr,d4
             jsr       write
             lea.l     dbafnon,a0
             move.w    #bobxd+51,d1
             move.w    #bobyd+45,d2
             move.w    #couleur_ecr,d4
             jsr       write
             lea.l     dbafconf,a0
             move.w    #bobxd+5,d1
             move.w    #bobyd+30,d2
             move.w    #couleur_ecr,d4
             jsr       write
             rts       

dbchoix:     
             .DC.w 0
db_oui:      
             move.w    #-1,dbchoix
             move.b    #255,sort
             rts       
db_non:      
             clr.w     dbchoix
             move.b    #255,sort
             rts       
; -----------------------------------------------------
; BOB_FEUILLE:
; Ce sous-programme permet :
;
;            1 - D'attribuer un icone a une case
;                de la feuille de schema
;            2 - D'effacer une fonction de la
;                feuille de shema
;            3 - De connecter des cases entre elles
;                par liaison
;            4 - De régler l'alarme
;
bob_feuille: 
; Calculer l'adresse sur l'ecran dans A0
             movea.l   sys01,a0
             move.w    souri_7,d0
             ext.l     d0
             move.l    d0,d2
             move.w    souri_8,d1
             ext.l     d1
             move.l    d1,d3
             lsr.w     #4,d0                ; modulo 16
             lsl.w     #3,d0                ;   add.w    d0,d0          ; en octets
             adda.l    d0,a0
             subi.w    #bobyd,d1
             andi.w    #$fff0,d1            ; modulo 16
             addi.w    #bobyd,d1
             mulu.w    #slarg,d1
             adda.l    d1,a0
; Calculer l'adresse dans la feuille de schema dans A1
; je rappelle que la fenetre viewsheet (sur ecran BOB)
; est de taille 5x5 alors que la fenetre sheet est de
; taille viewsheet_maxx*viewsheet_maxy.
             movea.l   pviewsheet,a1
             subi.w    #bobyd,d3
             lsr.w     #4,d3
             mulu.w    #viewsheet_maxx*2,d3 ; pointe sur le debut de la ligne
             adda.l    d3,a1
             subi.w    #bobxd,d2
             lsr.w     #4,d2
             add.w     d2,d2
             adda.l    d2,a1
; (a1) contient le dernier icone insere dans la case
; selectionee.
             tst.w     flag_lier            ; fonction LIER enclenchee ?
             bne       lier_case
             tst.w     flag_effacer         ; fonction EFFACER enclenchee ?
             bne       effacer_fonct
;
; - icone alarme ?
;
             cmpi.w    #alarme,(a1)
             bne.s     no_alarme
             bsr       regler_alarme
no_alarme:   
; -----------------------------------------------------
; INSERER une fonction dans une case
; de la feuille de shema
;
; quelle fonction (if,do,etat) ?
;
             tst.w     fonction
             bne.s     insere_if
;
; - inserer fonction DO -
;

;rajout 3
             move.w    vsheet_x,d0
             cmpi.w    #viewsheet_maxx-5,d0
             bne.s     noborddox
             move.w    souri_7,d0
             cmpi.w    #bobxd+64,d0
             bge       no_insert
noborddox:   
;fin rajout 3

             tst.w     (a1)                 ; peut-on inserer la fonction
             bne       no_insert
             tst.w     param2               ; a t-on un deuxieme
             beq       no_insert            ; parametre ?
             tst.w     2(a1)
             bne       no_insert
             move.w    param1,(a1)          ; inserer parametre 1
             move.w    param2,2(a1)         ; inserer parametre 2
             bra       no_insert
; fonction if ?
insere_if:   
             cmpi.w    #1,fonction
             bne.s     insere_etat
;
; - inserer fonction IF -
;

;rajout 4
             move.w    vsheet_x,d0
             cmpi.w    #viewsheet_maxx-5,d0
             bne.s     nobordifx
             move.w    souri_7,d0
             cmpi.w    #bobxd+48,d0
             bge       no_insert
nobordifx:   
             move.w    vsheet_y,d0
             cmpi.w    #viewsheet_maxy-5,d0
             bne       nobordify
             move.w    souri_8,d0
             cmpi.w    #bobyf-16,d0
             bge       no_insert
nobordify:   
;fin rajout 4

             tst.w     (a1)                 ; peut-on inserer la fonction
             bne       no_insert
             tst.l     2(a1)                ; tester pour la fleche droite
             bne       no_insert            ; et le deuxieme parametre
             tst.w     viewsheet_maxx*2(a1)
             bne       no_insert            ; tester pour la fleche bas
             tst.w     param1
             beq       no_insert
             tst.w     param2
             beq       no_insert
             move.w    param1,(a1)
             move.w    param2,2(a1)
             move.w    #si_droite,4(a1)
             move.w    #si_bas,viewsheet_maxx*2(a1)
             bra       no_insert
;
; - inserer un etat RUN,STOP ou END -
;
insere_etat: 
             tst.w     2(a1)
             bne       no_insert
             tst.w     (a1)
             beq.s     ok_insere_etat
             cmpi.w    #run,(a1)            ; pas run ?
             blt       no_insert
             cmpi.w    #_stop,(a1)          ; pas stop ?
             bgt       no_insert
; ici on inverse l'etat du processus
; on met STOP si c'est RUN et inversement (END ne change pas)
             move.w    (a1),d0
             neg.w     d0
             addi.w    #run+_stop,d0
             move.w    d0,(a1)
             bra       no_insert
; ici,ok pour inserer la fonction d'etat choisie
ok_insere_etat:        
             move.w    #run-2,d0
             add.w     fonction,d0
             move.w    d0,(a1)
             bra       no_insert
; -----------------------------------------------------
; EFFACER une fonction de la feuille de shema
effacer_fonct:         
             tst.w     (a1)                 ; ya ti queqchose a effacer boudiou
             beq       no_insert
             cmpi.w    #run,(a1)
             beq       no_do_sur
             cmpi.w    #_stop,(a1)
             beq       no_do_sur
             cmpi.w    #_end,(a1)
             beq       no_do_sur
             cmpi.w    #128,(a1)
             bge       no_do_sur
; on teste si c'est une fonction SI a
; effacer
             cmpi.w    #si_droite,(a1)
             bne.s     no_fleche_droit
             clr.l     -6(a1)
             clr.l     -2(a1)
             clr.w     ((viewsheet_maxx*2)-4)(a1)
             bra       no_insert
no_fleche_droit:       
             cmpi.w    #si_bas,(a1)
             bne.s     no_fsi_apriori
             clr.w     (a1)
             clr.l     ((-viewsheet_maxx*2)-2)(a1)
             clr.l     ((-viewsheet_maxx*2)+2)(a1)
             bra       no_insert
no_fsi_apriori:        
             cmpi.w    #si_droite,2(a1)
             bne.s     no_fsi_apriori2
             clr.l     (a1)
             clr.w     -2(a1)
             clr.w     ((viewsheet_maxx*2)-2)(a1)
             bra       no_insert
no_fsi_apriori2:       
             cmpi.w    #si_droite,4(a1)
             bne.s     no_fsi_sur
             clr.l     (a1)
             clr.w     4(a1)
             clr.w     viewsheet_maxx*2(a1)
             bra       no_insert
; ici ce n'est pas une fonction SI
; a effacer, on teste alors si c'est
; une fonction do
no_fsi_sur:  
             tst.w     -2(a1)
             beq.s     doagauche
             cmpi.w    #si_droite,-2(a1)
             beq.s     doagauche


; tester la combinaison param2 a droite
             moveq.l   #0,d0
             move.w    -2(a1),d0
             lea.l     do_p2_pointe_p1,a0
             lsl.w     #2,d0
             movea.l   0(a0,d0.w),a0
             move.w    (a1),d0
             subq.w    #5,d0
; tester le deuxieme parametre
testdoad:    
             cmpi.w    #$ffff,(a0)+
             beq.s     doagauche            ; ds la cas ou il y a
             cmp.w     -2(a0),d0            ; un icone a droite et a gauche
             bne.s     testdoad
             clr.l     -2(a1)
             bra       no_insert
; tester la combinaison param2 a gauche
doagauche:   
             tst.w     2(a1)
             beq.s     no_do_sur
             moveq.l   #0,d0
             move.w    (a1),d0
             lea.l     do_p2_pointe_p1,a0
             lsl.w     #2,d0
             movea.l   0(a0,d0.w),a0
             move.w    2(a1),d0
             subq.w    #5,d0
; tester le deuxieme parametre
testdoag:    
             cmpi.w    #$ffff,(a0)+
             beq.s     no_do_sur
             cmp.w     -2(a0),d0
             bne.s     testdoag
             clr.l     (a1)
             bra.s     no_insert
; ici ce n'est pas une fonction do
no_do_sur:   
             clr.w     (a1)
             bra       no_insert
; -----------------------------------------------------
; LIER des cases de la feuille de shema
lier_case:   
             tst.l     real_time_ad         ; deja en cours
; de tracage ?
             bne.s     fin_lier_case
             move.w    souri_7,d0
             move.w    souri_8,d1
             subi.w    #bobxd,d0
             andi.w    #$fff0,d0
             addi.w    #bobxd+8,d0
             move.w    d0,base_x
             subi.w    #bobyd,d1
             andi.w    #$fff0,d1
             addi.w    #bobyd+8,d1
             move.w    d1,base_y
             move.l    a1,base_adr
             move.l    #do_lier,real_time_ad
             rts       
; connection achevee
fin_lier_case:         
             bsr       faire_chemin
             bsr       bob_lier
; -----------------------------------------------------
; FIN du sous-programme BOB_FEUILLE
no_insert:   
             bsr       des_feuille_pro
;        jsr      ecrswapbob
;         jsr      copy_sys01
             rts       
; -----------------------------------------------------
; REGLER_ALARME:
; fonction qui affiche et permet de règler l'alarme
;
regler_alarme:         
; afficher une boite de confirmation
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       regler_alarmdes
             jsr       ecrswapbob
             jsr       regler_alarmdes
; gestion interactive de la reponse
             clr.b     sort
             move.l    #clignalarm,real_time_ad
regall:      
             lea.l     zone_fonc_8,a0
             jsr       interac
             tst.b     sort
             beq.s     regall
             clr.l     real_time_ad
             clr.b     sort
             move.l    #bob_zoom,real_time_ad
             bsr       des_feuille_pro
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

regler_alarmdes:       
; dessiner les boites
             move.w    #bobxd+2,d0
             move.w    #bobyd+12,d1
             move.w    #bobxd+78,d2
             move.w    #bobyd+70,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             move.w    #bobxd+1,d0
             move.w    #bobyd+11,d1
             move.w    #bobxd+78,d2
             move.w    #bobyd+71,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; afficher la boite quit
             move.w    #bobxd+25-1,d0
             move.w    #bobyd+56-1,d1
             move.w    #bobxd+56-1,d2
             move.w    #bobyd+68-1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+25,d0
             move.w    #bobyd+56,d1
             move.w    #bobxd+56,d2
             move.w    #bobyd+68,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; afficher les textes
             lea.l     alarmaf+14,a0
             move.w    #bobxd+3,d1
             move.w    #bobyd+30,d2
             move.w    #couleur_ecr,d4
             jsr       write
             lea.l     14(a0),a0
             move.w    #bobxd+3,d1
             move.w    #bobyd+38,d2
             jsr       write
             lea.l     14(a0),a0
             addi.w    #8,d2
             jsr       write
             lea.l     14(a0),a0
             addi.w    #2,d1
             addi.w    #13,d2
             jsr       write
; affichage des chiffre
             bsr       affialarmdes
             rts       
; -----------------------------------------------------
; affichage de l'alarme
;
affialarm:   
             movem.l   d0-d7/a0-a6,-(sp)
             bsr       affialarmdes
             jsr       ecrswapbob
             bsr       affialarmdes
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

affialarmdes:          
; effacer la zone d'affichage
             move.w    #bobxd+14,d0
             move.w    #bobyd+30,d1
             move.w    #bobxd+32,d2
             move.w    #bobyd+36,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
; afficher l'heure
             moveq.l   #0,d0
             move.w    alarmh,d0
             divu.w    #10,d0               ; dizaines
             move.w    d0,-(sp)
             ext.l     d0
             jsr       convasc
             movea.l   #chiffre+10,a0
             move.w    #bobxd+14,d1
             move.w    #bobyd+30,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             move.w    alarmh,d0
             move.w    (sp)+,d1
             mulu.w    #10,d1
             sub.w     d1,d0                ; unités
             ext.l     d0
             jsr       convasc
             movea.l   #chiffre+10,a0
             move.w    #bobxd+26,d1
             move.w    #bobyd+30,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; afficher les minutes
             move.w    #bobxd+50,d0
             move.w    #bobyd+30,d1
             move.w    #bobxd+68,d2
             move.w    #bobyd+36,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             moveq.l   #0,d0
             move.w    alarmm,d0
             divu.w    #10,d0
             move.w    d0,-(sp)
             ext.l     d0
             jsr       convasc
             movea.l   #chiffre+10,a0
             move.w    #bobxd+50,d1
             move.w    #bobyd+30,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             move.w    alarmm,d0
             move.w    (sp)+,d1
             mulu.w    #10,d1
             sub.w     d1,d0
             ext.l     d0
             jsr       convasc
             movea.l   #chiffre+10,a0
             move.w    #bobxd+62,d1
             move.w    #bobyd+30,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             rts       
; -----------------------------------------------------
; incrementer la partie haute de l'heure
;
ra_hhigup:   
             movem.l   d0/d1,-(sp)
             move.w    alarmh,d0
             ext.l     d0
             move.w    d0,d1
             divu.w    #10,d0
             mulu.w    #10,d0
             sub.w     d0,d1
             addi.w    #10,d0
             cmpi.w    #20,d0
             bgt.s     no_hhu
             add.w     d1,d0
             move.w    d0,alarmh
             cmpi.w    #23,alarmh
             ble       no_hhu1
             move.w    #23,alarmh
no_hhu1:     
             bsr       affialarm
no_hhu:      
             movem.l   (sp)+,d0/d1
             rts       
; -----------------------------------------------------
; incrementer la partie basse de l'heure
;
ra_hlowup:   
             cmpi.w    #23,alarmh
             bge.s     hluok
             addq.w    #1,alarmh
             bsr       affialarm
hluok:       
             rts       
; -----------------------------------------------------
; incrementer la partie haute des minutes
;
ra_mhigup:   
             movem.l   d0/d1,-(sp)
             move.w    alarmm,d0
             ext.l     d0
             move.w    d0,d1
             divu.w    #10,d0
             mulu.w    #10,d0
             sub.w     d0,d1
             addi.w    #10,d0
             cmpi.w    #50,d0
             bgt.s     no_mhu
             add.w     d1,d0
             move.w    d0,alarmm
             bsr       affialarm
no_mhu:      
             movem.l   (sp)+,d0/d1
             rts       
; -----------------------------------------------------
; incrementer la partie basse des minutes
;
ra_mlowup:   
             cmpi.w    #59,alarmm
             bge.s     mluok
             addq.w    #1,alarmm
             bsr       affialarm
mluok:       
             rts       
; -----------------------------------------------------
; decrementer la partie haute des heures
;
ra_hhigdn:   
             movem.l   d0/d1,-(sp)
             move.w    alarmh,d0
             ext.l     d0
             move.w    d0,d1
             divu.w    #10,d0
             mulu.w    #10,d0
             sub.w     d0,d1
             subi.w    #10,d0
             bmi.s     no_hhd
             add.w     d1,d0
             move.w    d0,alarmh
             bsr       affialarm
no_hhd:      
             movem.l   (sp)+,d0/d1
             rts       
; -----------------------------------------------------
; decrementer la partie basse des heures
;
ra_hlowdn:   
             subq.w    #1,alarmh
             bmi.s     hldok
             bsr       affialarm
             rts       
hldok:       
             addq.w    #1,alarmh
             rts       
; -----------------------------------------------------
; decrementer la partie haute des minutes
;
ra_mhigdn:   
             movem.l   d0/d1,-(sp)
             move.w    alarmm,d0
             ext.l     d0
             move.w    d0,d1
             divu.w    #10,d0
             mulu.w    #10,d0
             sub.w     d0,d1
             subi.w    #10,d0
             bmi.s     no_mhd
             add.w     d1,d0
             move.w    d0,alarmm
             bsr       affialarm
no_mhd:      
             movem.l   (sp)+,d0/d1
             rts       
; -----------------------------------------------------
; decrementer la partie basse des minutes
;
ra_mlowdn:   
             subq.w    #1,alarmm
             bmi.s     mldok
             bsr       affialarm
             rts       
mldok:       
             addq.w    #1,alarmm
             rts       
; -----------------------------------------------------
; CLIGNALARM
; realise le clignotement de "alarme"
;
cptalarm:    
             .DC.w 0
clignalarm:  
             movem.l   d0-d7/a0-a6,-(sp)
             addq.w    #1,cptalarm
             btst      #4,cptalarm+1
             beq.s     noalarm
             lea.l     alarmaf,a0
             move.w    #bobxd+5,d1
             move.w    #bobyd+17,d2
             move.w    #couleur_ecr,d4
             jsr       write
             bra.s     fincal
noalarm:     
             move.w    #bobxd+5,d0
             move.w    #bobyd+17,d1
             move.w    #bobxd+77,d2
             move.w    #bobyd+23,d3
             move.w    #couleur_fond,d4
             jsr       pboxbob
fincal:      
             jsr       ecrswapbob
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
; -----------------------------------------------------
; DES_FEUILLE_PROG:
; affichage du cadriage de la feuille de
; programmation.
; si (error_ad) n'est pas nul, on entoure l'icone de
; rouge.
des_feuilledes:        
; afficher les icones (partie visible de la feuille)
             movea.l   sys01,a0
             lea.l     ((bobyd*slarg)+2*4)(a0),a0
             movea.l   pviewsheet,a2
             move.l    #bobyd,d1
             moveq.l   #4,d7
des_feu_loop2:         
             move.l    #bobxd,d0
             moveq.l   #4,d6
             pea       (a0)
             pea       (a2)
des_feu_loop3:         
             move.w    (a2),d5
             ext.l     d5
             movea.l   adrfoncbob,a1        ;lea.l    fonc_bob,a1
             btst.l    #7,d5                ; est-ce une liaison
             beq.s     des_feu_0
; -----------------------------
; dessiner une liaison
;
             movea.l   adrliaibob,a1        ;lea.l    liaison_bob,a1
             subi.w    #128+1,d5            ; pas de liaison a 0
; -----------------------------
; dessiner une fonction
;
des_feu_0:   
             lsl.l     #7,d5
             adda.l    d5,a1
             movem.l   d0-d7/a0-a2,-(sp)
             jsr       put_16
             movem.l   (sp)+,d0-d7/a0-a2
             cmpa.l    error_ad,a2
             bne.s     des_feu_00
; -----------------------------
; il y a une erreur a cette adresse
;
             movem.l   d0-d7/a0-a2,-(sp)
             move.l    d0,d2
             addi.w    #15,d2
             move.l    d1,d3
             addi.w    #15,d3
             moveq.l   #rouge,d4
             jsr       boxbob
             movem.l   (sp)+,d0-d7/a0-a2
; -----------------------------
; continuer l'affichage
;
des_feu_00:  
             addq.l    #2,a2
             addq.l    #2*4,a0
             addi.w    #16,d0
             dbra      d6,des_feu_loop3


             movea.l   (sp)+,a2
             movea.l   (sp)+,a0
             lea.l     16*slarg(a0),a0
             lea.l     (viewsheet_maxx*2)(a2),a2
             addi.w    #16,d1

             dbra      d7,des_feu_loop2
             rts       

des_feuille_pro:       
             jsr       des_feuilledes
             jsr       ecrswap
             jsr       des_feuilledes
             rts       

; -----------------------------------------------------
; DO_LIER:
; LIER des cases de la feuille de shema
; cette routine est executee par INTERAC
;
; codage de la direction de la liaison
; --------------------------------------
; le code de liaison (stocke dans la feuille de shema)
; est du type:
;
;          Code =   1  x   x   x   x   x   x   x
;                                    Bit 2   Bit 0
;                   |              |       |
;                liaison         Bit 3   Bit 1
;
; L'etat "1" code une possibilite de direction
;
;                      Bit 0 (possibilite vers le haut)
;                 ---------------
;                 |      |      |
;                 |      |      |
;                 |      |      |
;           Bit 3 |------+------| Bit 1
;(vers la gauche) |      |      | (possibilite vers la droite)
;                 |      |      |
;                 |      |      |
;                 ---------------
;                      Bit 2
;                 (...vers le bas)
;
; l'association de plusieurs codes devient possible :
; ex c1 = code 1011 (gauche+droite+haut) avec
;    c2 = code 1100 (gauche+bas)
;    c1 OR c2 donne le code 1111 (toutes les directions)
;
base_adr:    
             .DC.l 0
base_x:      
             .DC.w 0
base_y:      
             .DC.w 0
mouse_x:     
             .DC.w 0
mouse_y:     
             .DC.w 0
do_lier:     
             movem.l   d0-d7/a0-a6,-(sp)
             move.w    souri_7,d2
             move.w    souri_8,d3
             cmp.w     base_x,d2
             bne.s     do_lier_ligne
             cmp.w     base_y,d3
             beq       do_lier_fin
; tracer la ligne
do_lier_ligne:         
             movem.l   d2/d3,-(sp)
             bsr       des_feuilledes
             movem.l   (sp)+,d2/d3
             move.w    base_x,d0
             move.w    base_y,d1
             move.w    d2,mouse_x
             move.w    d3,mouse_y
;
; les déplacements en abscisse...
;
             cmpi.w    #bobxd+16,d2         ; evite les débordements à gauche
             bge.s     dlxmin
             move.w    #bobxd+8,d2
             tst.w     vsheet_x             ; évite des décalages intempestifs
             beq.s     dlxmin               ; de la base à droite (cf 1)
             cmpi.w    #bobxd+80-16,d0      ; cherche scrolling à gauche
             bgt.s     dlxmin
             addi.w    #16,d0               ; repositionne debut droite
             addi.w    #16,base_x           ; (1) repositionne base
             movem.l   d0-d3,-(sp)
             bsr       bob_gauche           ; scroller à gauche
             movem.l   (sp)+,d0-d3
;
dlxmin:      
             cmpi.w    #bobxd+75,d2
             ble.s     dlymax
             move.w    #bobxd+75,d2
             cmpi.w    #viewsheet_maxx-5,vsheet_x
             beq.s     dlymax
             cmpi.w    #bobxd+16,d0
             blt.s     dlymax
             subi.w    #16,d0
             subi.w    #16,base_x
             movem.l   d0-d3,-(sp)
             bsr       bob_droite
             movem.l   (sp)+,d0-d3
;
; les déplacements en ordonnée
;
dlymax:      
             cmpi.w    #bobyd+16,d3
             bge.s     dlymin
             move.w    #bobyd+8,d3
             tst.w     vsheet_y
             beq.s     dlymin
             cmpi.w    #bobyf-16,d1
             bgt.s     dlymin
             addi.w    #16,d1
             addi.w    #16,base_y
             movem.l   d0-d3,-(sp)
             bsr       bob_haut
             movem.l   (sp)+,d0-d3
;
dlymin:      
             cmpi.w    #bobyf-5,d3
             ble.s     dlyok
             move.w    #bobyf-5,d3
             cmpi.w    #viewsheet_maxy-5,vsheet_y
             beq.s     dlyok
             cmpi.w    #bobyd+16,d1
             blt.s     dlyok
             subi.w    #16,d1
             subi.w    #16,base_y
             movem.l   d0-d3,-(sp)
             bsr       bob_bas
             movem.l   (sp)+,d0-d3
dlyok:       
             movem.l   d0-d3,-(sp)
             subq.w    #2,d2
             addq.w    #3,d3
             moveq.l   #couleur_ecr,d4
             jsr       lignebob
             movem.l   (sp)+,d0-d3
             moveq.l   #rouge,d4
             jsr       lignebob

             jsr       ecrswapbob

do_lier_fin: 
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
; -----------------------------------------------------
;
faire_chemin:          
; calculer l'adresse de la base
             moveq.l   #0,d0
             moveq.l   #0,d1
             move.w    base_x,d0
             move.w    base_y,d1
             movea.l   pviewsheet,a0
             subi.w    #bobyd,d1
             lsr.w     #4,d1
             mulu.w    #viewsheet_maxx*2,d1 ; pointe sur le debut de la ligne
             adda.l    d1,a0
             subi.w    #bobxd,d0
             lsr.w     #4,d0
             add.w     d0,d0
             adda.l    d0,a0
;
; ici A0 pointe sur la case source du chemin
;
             andi.w    #$fff0,base_x        ; homogeniser les coords
             andi.w    #$fff0,base_y
             andi.w    #$fff0,mouse_x
             andi.w    #$fff0,mouse_y
             movea.l   a0,a2
             bsr       cherchex
             move.l    d1,d2
             bsr       cherchey
             add.l     d1,d2
             movea.l   a0,a2
             bsr       cherchey
             move.l    d1,d3
             bsr       cherchex
             add.l     d1,d3
; si c'est un if tracer en xy
             cmpi.w    #si_droite,(a0)
             beq.s     tracexy
             cmpi.w    #si_droite,2(a0)
             beq.s     tracexy
             cmpi.w    #si_droite,4(a0)
             beq.s     tracexy
; ici si D2 dif de 0 il y a intersection en xy
;   ,,   D3    ,,      ,,      ,,        en yx
             tst.w     d3
             beq.s     traceyx
             tst.w     d2
             beq.s     tracexy
; sinon tracer d'abord en y puis en x
traceyx:     
             movea.l   a0,a2
             bsr       trace_y
             bsr       trace_x
;      jsr      ecrswapbob
;       jsr      copy_sys01
             rts       
; tracer d'abord en x puis en y
tracexy:     
             movea.l   a0,a2
             bsr       trace_x
             bsr       trace_y
;      jsr      ecrswapbob
;      jsr      copy_sys01
             rts       

; checksum des valeurs en abscisse
;
cherchex:    
             moveq.l   #0,d1
             move.w    base_x,d0
chercheminx: 
             cmp.w     mouse_x,d0
             beq.s     chercheminxfin
             bmi.s     mxaprbx
             subi.w    #16,d0
             subq.l    #2,a2
             add.w     (a2),d1
             bra.s     chercheminx
mxaprbx:     
             addi.w    #16,d0
             addq.l    #2,a2
             add.w     (a2),d1
             bra.s     chercheminx
chercheminxfin:        
             sub.w     (a2),d1              ; ne pas comptabiliser la destination
             rts       

; checksum des valeurs en ordonnées
;
cherchey:    
             moveq.l   #0,d1
             move.w    base_y,d0
chercheminy: 
             cmp.w     mouse_y,d0
             beq.s     chercheminyfin
             bmi.s     myaprby
             subi.w    #16,d0
             suba.l    #viewsheet_maxx*2,a2
             add.w     (a2),d1
             bra.s     chercheminy
myaprby:     
             addi.w    #16,d0
             adda.l    #viewsheet_maxx*2,a2
             add.w     (a2),d1
             bra.s     chercheminy
chercheminyfin:        
             sub.w     (a2),d1
             rts       

;
;
trace_x:     
             move.w    base_x,d0
txloop:      
             cmp.w     mouse_x,d0
             beq.s     fintracex
             bmi.s     txneg
             tst.w     (a2)
             beq.s     tx1
             cmpi.w    #128,(a2)
             blt.s     tx2
tx1:         
             ori.w     #$88,(a2)
tx2:         
             subi.w    #16,d0
             subq.l    #2,a2
             tst.w     (a2)
             beq.s     tx11
             cmpi.w    #128,(a2)
             blt.s     tx22
tx11:        
             ori.w     #$82,(a2)
tx22:        
             bra.s     txloop
txneg:       
             tst.w     (a2)
             beq.s     tx4
             cmpi.w    #128,(a2)
             blt.s     tx5
tx4:         
             ori.w     #$82,(a2)
tx5:         
             addi.w    #16,d0
             addq.l    #2,a2
             tst.w     (a2)
             beq.s     tx44
             cmpi.w    #128,(a2)
             blt.s     tx55
tx44:        
             ori.w     #$88,(a2)
tx55:        
             bra.s     txloop
fintracex:   
             rts       

;
;
trace_y:     
             move.w    base_y,d0
tyloop:      
             cmp.w     mouse_y,d0
             beq.s     fintracey
             bmi.s     tyneg
             tst.w     (a2)
             beq.s     ty1
             cmpi.w    #128,(a2)
             blt.s     ty2
ty1:         
             ori.w     #$81,(a2)
ty2:         
             subi.w    #16,d0
             suba.l    #viewsheet_maxx*2,a2
             tst.w     (a2)
             beq.s     ty11
             cmpi.w    #128,(a2)
             blt.s     ty22
ty11:        
             ori.w     #$84,(a2)
ty22:        
             bra.s     tyloop
tyneg:       
             tst.w     (a2)
             beq.s     ty4
             cmpi.w    #128,(a2)
             blt.s     ty5
ty4:         
             ori.w     #$84,(a2)
ty5:         
             addi.w    #16,d0
             adda.l    #viewsheet_maxx*2,a2
             tst.w     (a2)
             beq.s     ty44
             cmpi.w    #128,(a2)
             blt.s     ty55
ty44:        
             ori.w     #$81,(a2)
ty55:        
             bra.s     tyloop
fintracey:   
             rts       



; *****************************************************
; *****************************************************
; *******                                       *******
; *******             PROGRAMMATION             *******
; *******                                       *******
; *******          MODULE  D'EXECUTION          *******
; *******                                       *******
; *****************************************************
; *****************************************************
;
; Introduction
; ------------------------------------------------
;
; Ce module contient deux sous-programmes:
; INIT_BE : il prépare l'execution du programme compilé.
;           il est appelé automatiquement à la sortie de
;           BOB.
; BOB_EXEC: C'est le sous-programme qu'il faudra appeler
;           régulièrement dans votre programme principal
;           Il sauvegarde ts les registres.
;
; Principe de fonctionnement du module d'execution
; ------------------------------------------------
; A chaque appel de BOB_EXEC on execute les instructions
; pointées par tous les token de la liste "tokenlist"
; et on incrémente les compteurs de programme.
; Les instructions sont décodées et on appelle la librairie
; correspondante.
;
; Remarque sur les librairies
; ---------------------------
; les librairies sont en fait des sous-programmes appelés
; par le module d'execution.
; Vous devez écrire une partie de celle-ci pour les interfacer
; convenablement avec votre programme (voir les commentaires
; de chacune d'elle pour plus d'information).
; elles sont séparées en trois groupes:
;
;                 les routines GENERALES
;                 les routines IF
;                 les routines DO
;
; les routines GENERALES:
;
;
;-----------------------------------------------------
; INIT_BE: initialise pour l'execution
;          effacer la liste, mettre les
;          starts.
init_be:     
             movem.l   d0-d7/a0-a6,-(sp)
; effacer la liste token
             lea.l     tokenlist,a1
tokencls:    
             clr.b     (a1)+
             cmpa.l    #tokenlfin,a1
             blt.s     tokencls
; initialiser la liste token c.a.d
; copier tous les starts (ds header) dans
; la tokenlist (+initialiser les toklastrun)
             lea.l     header,a0
             lea.l     tokenlist,a1
tokeninit0:  
             tst.l     (a0)
             beq.s     tokeninit1
             clr.w     toksr(a1)
             move.l    (a0),tokpc(a1)
             move.l    (a0)+,toklastrun(a1)
             lea.l     toklong(a1),a1
             cmpa.l    #header_end,a0
             blt.s     tokeninit0
tokeninit1:  
             movem.l   (sp)+,d0-d7/a0-a6
             move.l    #tokenlist,adtokcour
             rts       

;------------------------------------------------------
; BOB_EXEC: module d'execution.
;           l'appel de cette fonction lance une passe
;           chaque passe execute une instruction par
;           token.
;
;  en sortie: D0.W = 0 : l'execution est sans probleme
;                  = 1 : erreur due au compilateur
;                  = 2 : erreur de fonction DO
;                  = 3 : erreur de fonction IF
bob_exec::   
             tst.w     psy
             beq       bob_exec0
             move.l    adrevicour,d0
             beq       bob_exec0
             movea.l   d0,a0
             cmpi.b    #64,evilove(a0)
             bhi       bob_exec1
             move.w    #-1,flashcol0        ;flash 'on'
             bra       bob_exec0
bob_exec1:   
             clr.w     flashcol0            ;flash 'off'
bob_exec0:   
             movem.l   d1-d7/a0-a6,-(sp)
             tst.w     running
             beq       fin_bob_exec
             cmpi.w    #2,running
             beq       bob_comperr
;
; gestion de la liste token
;
;;;;;;;;;;;;              lea.l    tokenlist,a0
;;;;;;;;;;;;tokenloop:
;;;;;;;;;;;;              cmpa.l   #tokenlfin,a0  ; est la fin de liste token?
;;;;;;;;;;;;              bge      fin_bob_exec

             movea.l   adtokcour,a0
             bra.s     token1st
tokenloop:   
             cmpa.l    #tokenlfin,a0
             blt.s     token1st0
             lea.l     tokenlist,a0
token1st0:   
             cmpa.l    adtokcour,a0
             beq       fin_bob_exec

token1st:    

             tst.l     tokpc(a0)            ; est-ce vide?
             beq       exec_instr_fin
             movea.l   tokpc(a0),a1
; le token est-il en etat d'attente ?
             cmpi.w    #1,toksr(a0)
             beq       exec_instr_fin
; execution d'une instruction
; A0 pointe sur le token courant dans la tokenlist
; A1 pointe sur l'adresse de l'instruction
;
exec_instr:  
             tst.w     (a1)
             beq       exec_nop
             cmpi.w    #1,(a1)
             beq       exec_run
             cmpi.w    #2,(a1)
             beq       exec_stop
             cmpi.w    #3,(a1)
             beq       exec_end
             cmpi.w    #4,(a1)
             beq       exec_do
             cmpi.w    #5,(a1)
             beq       exec_if
             cmpi.w    #6,(a1)
             beq       exec_crt
;-----------------------------
; fonction NOP
exec_nop:    
             addq.l    #2,tokpc(a0)
             bra       exec_instr_fin
;-----------------------------
; fonction RUN
exec_run:    
             move.l    a1,toklastrun(a0)    ; modifier dernier run
             addq.l    #2,tokpc(a0)
             bra       exec_instr_fin
;-----------------------------
; fonction STOP
exec_stop:   
             clr.l     tokpc(a0)
             clr.l     toklastrun(a0)
             bra       exec_instr_fin
;-----------------------------
; fonction END
; ici on controle si un token
; ne possede pas un meme lastrun
; si oui on ne relance pas
exec_end:    
             lea.l     tokenlist,a2
             move.l    toklastrun(a0),d0
             move.l    tokpc(a0),d1
exend0:      
             tst.l     tokpc(a2)            ; pas de token ?
             beq.s     noexend1
             cmp.l     tokpc(a2),d1         ; le meme ?
             beq.s     noexend1
             cmp.l     toklastrun(a2),d0
             beq       exec_same            ; deja un token ds la branche
noexend1:    
             lea.l     toklong(a2),a2
             cmpa.l    #tokenlfin,a2
             blt.s     exend0
             move.l    toklastrun(a0),tokpc(a0)   ; sinon reinjecter
             bsr       tokenon
             bra       exec_instr_fin
; detruire le jeton
exec_same:   
             clr.w     toksr(a0)
             clr.l     tokpc(a0)
             clr.l     toklastrun(a0)
             bsr       tokenon
             bra       exec_instr_fin
;-----------------------------
; fonction DO
exec_do:     
             lea.l     exdolist,a2
             move.w    2(a1),d0             ; recupere parametre 1
exec_doloop: 
             cmp.w     (a2)+,d0             ; a t-on une fonction en librairie
             beq.s     exec_dok             ; de parametre 1 ?
             addq.l    #4,a2
             cmpi.w    #$ffff,(a2)
             bne.s     exec_doloop
             bra       bob_nodoerr          ; pas de fonction = erreur!
exec_dok:    
             move.w    4(a1),d0             ; recup parametre 2
             move.w    2(a1),d1             ; recup parametre 1
             movea.l   (a2),a2              ; recup adresse librairie
             clr.w     bobsemaaffi          ;voir commentaire plus bas
             pea       (a0)
             pea       (a1)
             jsr       (a2)
             movea.l   (sp)+,a1
             movea.l   (sp)+,a0
             tst.w     bobsemaaffi          ;voir commentaire
             bne       exec_instr_fin
             addq.l    #6,tokpc(a0)
             bra       exec_instr_fin

;
; EXPLICATION relative a BOBSEMAAFFI:
;
; ce semaphore est utiliser pour eviter que bob exec soit bloquant
; ('DEAD LOCK')
; En effet, lorsque le buffer BUFTEXTBOB est plein (TEXTBOBPLEIN<>0)
; un nouvel affichage n'est pas possible tant que le buffer n'a pas
; ete vide.
;
; ceci pose un certain nombre de problemes:
;
; si le multitache est stoppe et que l'on veut terminer la tache 1
; (biogame+bobexec), la tache 0 (tache principale+affichage) n'est plus
; executee et donc, le buffer n'est jamais vide...
; L'ensemble est donc bloque, chaque tache attendant l'autre!
;
; La solution retenue permet, en cas d'affichage impossible, de sortir
; de BOBEXEC sans deplacer le jeton concerne. (le prochain appel a BOBEXEC
; sera donc une nouvelle tentative d'affichage)
;


;-----------------------------
; fonction IF
exec_if:     
             lea.l     exiflist,a2
             move.w    2(a1),d0
exec_ifloop: 
             cmp.w     (a2)+,d0             ; a t-on une fonction en librairie
             beq.s     exec_ifk             ; de parametre 1 ?
             addq.l    #4,a2
             cmpi.w    #$ffff,(a2)
             bne.s     exec_ifloop
             bra       bob_noiferr          ; pas de fonction = erreur!
exec_ifk:    
             move.w    4(a1),d0             ; recup parametre 2
             movea.l   (a2),a2              ; recup adresse librairie
             pea       (a0)
             pea       (a1)
             jsr       (a2)
             movea.l   (sp)+,a1
             movea.l   (sp)+,a0
             tst.w     d0
             bne.s     exec_ddd
; si D0=0 (parametre faux) PC=PC+8
             addq.l    #8,tokpc(a0)
             bra       exec_instr_fin
exec_ddd:    
             moveq.l   #0,d0
             move.w    6(a1),d0
             addq.l    #6,tokpc(a0)         ; relatif à ddd
             add.l     d0,tokpc(a0)         ; additionner offset
             bra       exec_instr_fin
;-----------------------------
; fonction CRT
exec_crt:    
             lea.l     tokenlist,a2         ; il y a t-il une place de vide
execrt0:     
             cmpa.l    #tokenlfin,a2
             bge.s     bob_notok
             tst.l     tokpc(a2)
             beq.s     execrt1
             lea.l     toklong(a2),a2
             bra.s     execrt0
execrt1:     
             lea.l     2(a1),a3             ; calculer l'offset
             moveq.l   #0,d0
             move.w    2(a1),d0
             adda.l    d0,a3
             move.l    a3,tokpc(a2)         ; insere nouveau
             move.w    toksr(a0),toksr(a2)
             move.l    toklastrun(a0),toklastrun(a2)        ; token
bob_notok:   
             addq.l    #4,tokpc(a0)
;------------------------------
; instruction suivante...
exec_instr_fin:        
             lea.l     toklong(a0),a0       ; token suivant
             bra       tokenloop
; messages d'erreur
bob_noiferr: 
             move.w    #3,d0
             bra.s     bob_exec_error
bob_nodoerr: 
             move.w    #2,d0
             bra.s     bob_exec_error
bob_comperr: 
             move.w    #1,d0
;;;;;;;;         bra     bob_exec_error
bob_exec_error:        
             jsr       bob_err
             movem.l   (sp)+,d1-d7/a0-a6
             rts       
fin_bob_exec:          
             movea.l   adtokcour,a0
             lea.l     toklong(a0),a0
             cmpa.l    #tokenlfin,a0
             blt.s     fin_bob_exec0
             lea.l     tokenlist,a0
fin_bob_exec0:         
             move.l    a0,adtokcour

             moveq.l   #0,d0
             movem.l   (sp)+,d1-d7/a0-a6
             rts       
;-----------------------------
; TOKENOFF: met tous les tokens
;           en etat d'attente sauf
;           le token courant
; A0.L = adresse du token courant
;
tokenoff:    
             pea       (a1)
             lea.l     tokenlist,a1
tokenoff0:   
             cmpa.l    a0,a1
             beq.s     notokoff             ; pas le token courant
             move.w    #1,toksr(a1)
notokoff:    
             lea.l     toklong(a1),a1
             cmpa.l    #tokenlfin,a1
             blt.s     tokenoff0
             movea.l   (sp)+,a1
             rts       
;-----------------------------
; TOKENON: met tous les tokens
;          en etat d'execution
;
tokenon:     
             tst.w     bobsemaaffi          ;voir explications
             bne       rts
             pea       (a1)
             lea.l     tokenlist,a1
tokenon0:    
             clr.w     toksr(a1)
             lea.l     toklong(a1),a1
             cmpa.l    #tokenlfin,a1
             blt.s     tokenon0
             movea.l   (sp)+,a1
             rts       











; *****************************************************
; *             Librairie des routines                *
; *****************************************************
; -----------------------------------------------------
; 1) routines generales
; -----------------------------------------------------
; ------------------------------------------
; BOB_INITVAR
; en Entrée : "btypeevi" = 0 joueur
;                        = 1 evi
;
bob_initvar: 
             movem.l   d0-d7/a0-a6,-(sp)
             tst.w     btypeevi
             bne       bi_anaevi
; -----------------------------
; ANALYSE DU JOUEUR
;
; 1) dans "vfaim" mettre "1" si le
;    joueur à faim sinon "0"
;
;    dans "vsoif" mettre "1" si le
;    joueur à faim sinon "0"
;
;    dans "vfatig" mettre "1" si le
;    joueur à faim sinon "0"

;$$$$$              move.b   faim+1,vfaim
;$$$$$              andi.b   #1,vfaim
;$$$$$              move.b   soif+1,vsoif
;$$$$$              andi.b   #1,vsoif
;$$$$$              move.b   fatigue+1,d0
;$$$$$              lsr.b    #1,d0          ;(1,2 ou 3 ->1)  (0->0)
;$$$$$              move.b   d0,vfatig

             clr.b     vfaim                ;$$$$$
             clr.b     vsoif                ;$$$$$
             clr.b     vfatig               ;$$$$$
             cmpi.w    #3000,faim           ;$$$$$
             bgt       pp0                  ;$$$$$
             move.b    #1,vfaim             ;$$$$$
pp0:                   ;$$$$$
             cmpi.w    #2000,soif           ;$$$$$
             bgt       pp1                  ;$$$$$
             move.b    #1,vsoif             ;$$$$$

pp1:                   ;$$$$$
             cmpi.w    #6*60,_sommeil       ;$$$$$
             bgt       pp2                  ;$$$$$
             move.b    #1,vfatig            ;$$$$$
pp2:                   ;$$$$$


;
; 2) Variables des caracteristiques
;    variables "vforce" a "vchari"
;    il faut remplir ces variables
;    avec les codes 4,5,6 (fort,
;    faible, normal).
;
             lea.l     jehan+forc_c,a0
             lea.l     vforce,a1
             jsr       evaluer
             lea.l     jehan+inte_c,a0
             lea.l     vintel,a1
             jsr       evaluer
             lea.l     jehan+vita_c,a0
             lea.l     vvital,a1
             jsr       evaluer
             lea.l     jehan+perc_c,a0
             lea.l     vperce,a1
             jsr       evaluer
             lea.l     jehan+refl_c,a0
             lea.l     vrefle,a1
             jsr       evaluer
             lea.l     jehan+char_c,a0
             lea.l     vchari,a1
             jsr       evaluer

; 3) dans "vetat" mettre la valeur:
;         4 si l'etat est bon
;         5 si l'etat est mauvais
;         6 si l'etat est normal
;
             lea.l     jehan,a0
             adda.l    #potvie+1,a0
             lea.l     vetat,a1
             jsr       evaluer


; 4) dans "vtemp" mettre la valeur:
;         4 si la temperature est forte
;         5 si la temperature est faible
;         6 si la temperature est normale
;
             move.b    #6,vtemp

; 5) dans "vpress" mettre la valeur:
;         4 si la pression est forte
;         5 si la pression est faible
;         6 si la pression est normale
;
             move.b    #6,vpress

; 6) dans "vsub1" à "vsub5" mettre la valeur:
;         4 si le taux de substance est fort
;         (5 si le taux de substance est faible)
;         6 si le taux de substance est normal
;

             lea.l     substance,a0
             lea.l     vsub1,a1
             moveq.l   #5-1,d7
bobiimp0:    
             move.b    #6,(a1)+
             tst.w     (a0)+
             beq       bobiimp1
             move.b    #4,-1(a1)
bobiimp1:    
             dbra      d7,bobiimp0


; 7) dans "vrythm" mettre la valeur:
;         4 si le rythme est fort
;         5 si le rythme est faible
;         6 si le rythme est normal
;
             move.b    #6,vrythm
             move.w    vitcardinit,d0
             cmpi.w    #2,d0
             bne       birythm0
             move.b    #5,vrythm
birythm0:    
             cmpi.w    #6,d0
             bne       bi_autreana
             move.b    #4,vrythm

             bra       bi_autreana
bi_anaevi:   
; -----------------------------
; ANALYSE DE L'EVI LE + PROCHE
;
; 1) dans "vfaim" mettre "1" si
;    l'evi à faim sinon "0"

             clr.b     vfaim

;
;    dans "vsoif" mettre "1" si
;    l'evi à faim sinon "0"
;

             clr.b     vsoif

;    dans "vfatig" mettre "1" si
;    l'evi à faim sinon "0"
;

             clr.b     vfatig

;    dans "vevi" mettre la valeur:
;        13 si il est agressif
;        14 si il est shedish
;        15 si il est shedish+agressif

             lea.l     bvartab,a0
             clr.l     (a0)+                ;22 valeurs
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.l     (a0)+
             clr.w     (a0)+

             move.l    adrevicour,d0
             beq       bi_autreana0
             movea.l   d0,a6

             move.l    evicodegen(a6),d0
             andi.l    #$0f000000,d0
             beq       bobihumain
             move.b    #14,vevi
             cmpi.b    #64,evilove(a6)
             bhi       bobi0
             move.b    #15,vevi
             bra       bobi0
bobihumain:  
             clr.b     vevi
             cmpi.b    #64,evilove(a6)
             bhi       bobi0
             move.b    #13,vevi
bobi0:       

; 2) Variables des caracteristiques
;    variables "vforce" a "vchari"
;    il faut remplir ces variables
;    avec les codes 4,5,6 (fort,
;    faible, normal).
;
             movea.l   adrevicour,a6
             lea.l     eviforce(a6),a0
             lea.l     vforce,a1
             jsr       evaluer
             lea.l     eviintel(a6),a0
             lea.l     vintel,a1
             jsr       evaluer
             lea.l     evivital(a6),a0
             lea.l     vvital,a1
             jsr       evaluer
             lea.l     evipercep(a6),a0
             lea.l     vperce,a1
             jsr       evaluer
             lea.l     evireflex(a6),a0
             lea.l     vrefle,a1
             jsr       evaluer
             lea.l     evicharis(a6),a0
             lea.l     vchari,a1
             jsr       evaluer

; 3) dans "vetat" mettre la valeur:
;         4 si l'etat est bon
;         5 si l'etat est mauvais
;         6 si l'etat est normal
;
             movea.l   adrevicour,a6
             lea.l     evipotvie(a6),a0
             lea.l     vetat,a1
             jsr       evaluer
             bra       bi_autreana
bi_autreana0:          
             tst.l     attaqueprem
             beq       bi_autreana
             move.b    #13,vevi
bi_autreana: 
; -----------------------------
; ANALYSE DE L'HEURE
;
             jsr       jhm
             move.w    d1,heure
             move.w    d2,minute

             clr.b     vheure
             move.w    heure,d0
             cmp.w     alarmh,d0
             bne.s     binohida
             move.w    minute,d0
             cmp.w     alarmm,d0
             bne.s     binohida
             move.b    #1,vheure            ; heure alarme = heure jeu
binohida:    
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
; ------------------------------------------
; BOB_ERR
; en Entrée : D0 = 1 : erreur de compilation
;                  2 : trop de token insérés
;                  3 : DO non reconnu
;                  4 : IF non reconnu
bob_err:     
             lea.l     afboberr,a0
             bsr       be_affi
             rts       

; -----------------------------------------------------
; 2) routines IF
; -----------------------------------------------------
; toutes les routines recupèrent en entrée dans
; D0.W le n°de paramètre.
; en sortie D0.W = 0  : condition fausse
;           D0.W = -1 : condition vérifiée
; ------------------------------------------
;
if_joueur:   
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
; unqt faim,soif,fatigue.
             cmpi.w    #10,d0
             beq.s     if_jou_s
             cmpi.w    #11,d0
             beq.s     if_jou_d
if_jou_f:    
             lea.l     iffaim,a0
             lea.l     vfaim,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_jou_s:    
             lea.l     ifsoif,a0
             lea.l     vsoif,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_jou_d:    
             lea.l     iffatig,a0
             lea.l     vfatig,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
; ------------------------------------------
;
if_evi:      
             movem.l   d1/a0/a1,-(sp)
             move.w    #1,btypeevi
             jsr       bob_initvar
; cas faim,soif,fatigue
             cmpi.w    #9,d0
             beq.s     if_jou_f
             cmpi.w    #10,d0
             beq.s     if_jou_s
             cmpi.w    #11,d0
             beq.s     if_jou_d
             cmpi.w    #28,d0
             beq       if_shed
; cas agressif
             cmpi.w    #26,d0
             bne       if_evirts
             moveq.l   #-1,d0
             cmpi.b    #15,vevi
             beq       if_evirts
             cmpi.b    #13,vevi
             beq       if_evirts
             moveq.l   #0,d0
if_evirts:   
             movem.l   (sp)+,d1/a0/a1
             rts       
if_shed:     
             moveq.l   #-1,d0
             cmpi.b    #15,vevi
             beq       if_evirts
             cmpi.b    #14,vevi
             beq       if_evirts
             moveq.l   #0,d0
             bra       if_evirts

; ------------------------------------------
;
if_force:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vforce,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_intel:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vintel,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_vital:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vvital,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_perce:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vperce,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_refle:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vrefle,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_chari:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vchari,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_faim:     
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vfaim,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_soif:     
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vsoif,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_fatig:    
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vfatig,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_etat:     
             movem.l   d1/a0/a1,-(sp)
             lea.l     ifcartab,a0
             lea.l     vetat,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_temp:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi          ; que sur le joueur
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vtemp,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_pres:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vpress,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_sub1:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vsub1,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_sub2:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vsub2,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_sub3:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vsub3,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_sub4:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vsub4,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_sub5:     
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vsub5,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_rythme:   
             movem.l   d1/a0/a1,-(sp)
             move.w    #0,btypeevi
             jsr       bob_initvar
             lea.l     ifcartab,a0
             lea.l     vrythm,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
if_heure:    
             movem.l   d1/a0/a1,-(sp)
             jsr       bob_initvar
             lea.l     ifheutab,a0
             lea.l     vheure,a1
             jsr       testparam
             movem.l   (sp)+,d1/a0/a1
             rts       
testparam:   
testploop:   
             cmpi.b    #$ff,(a0)
             beq.s     testpend
             cmp.b     (a0)+,d0
             beq.s     testpptr
             addq.l    #1,a0
             bra.s     testploop
testpptr:    
             moveq.l   #0,d0
             move.b    (a0),d1
             cmp.b     (a1),d1
             bne.s     testpend
             moveq.l   #-1,d0
testpend:    
             rts       
; -----------------------------------------------------
; 3) routines DO
; -----------------------------------------------------
; ------------------------------------------
; DO_AFF
; en Entrée D0.W = Numero de la variable à afficher
;
do_aff:      

             jsr       bob_initvar
             movem.l   d0-d7/a0-a6,-(sp)
; afficher les caracteristiques
             cmpi.w    #8,d0
             ble       do_aff_car
; afficher faim,soif,fatigue
             cmpi.w    #11,d0
             ble       do_aff_fsf
; afficher etat
             cmpi.w    #12,d0
             beq       do_aff_eta
; afficher temperature
             cmpi.w    #13,d0
             beq       do_aff_tmp
; afficher pression
             cmpi.w    #14,d0
             beq       do_aff_prs
; afficher substance
             cmpi.w    #19,d0
             ble       do_aff_sub
; afficher heure
             cmpi.w    #21,d0
             beq       do_aff_heu
; afficher rythme
             cmpi.w    #22,d0
             beq       do_aff_ryt
do_aff_fin:  
             movem.l   (sp)+,d0-d7/a0-a6
             jsr       tokenon
             rts       
; pour les caractéristiques, les valeurs sont 4,5,6 (fort faible normal)
do_aff_car:  
             lea.l     tab_dac,a0
             move.w    d0,d1
             subq.w    #3,d0
             mulu.w    #12,d0
             lea.l     0(a0,d0.w),a0        ; pointer la carac.
             lea.l     bvartab,a1
             subq.w    #1,d1
             moveq.l   #0,d0
             move.b    0(a1,d1.w),d0
             beq       do_aff_fin
             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     0(a0,d0.w),a0        ; pointer le niveau de la carac.
             movea.l   (a0),a0              ; pointer le texte

             bsr       be_affi
             bra       do_aff_fin
; pour faim, soif, fatigue
do_aff_fsf:  
             lea.l     tab_daf,a0
             subi.w    #9,d0
             lsl.w     #2,d0
             movea.l   0(a0,d0.w),a0
             bsr       be_affi
             bra       do_aff_fin
; pour l'etat
do_aff_eta:  
             moveq.l   #0,d0
             move.b    vetat,d0
             beq       do_aff_fin

             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     tab_dae,a0
             movea.l   0(a0,d0.w),a0
             bsr       be_affi
             bra       do_aff_fin
; pour la temperature
do_aff_tmp:  
             moveq.l   #0,d0
             move.b    vtemp,d0
             beq       do_aff_fin
             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     tab_dat,a0
             movea.l   0(a0,d0.w),a0
             bsr       be_affi
             bra       do_aff_fin
; pour la pression
do_aff_prs:  
             moveq.l   #0,d0
             move.b    vpress,d0
             beq       do_aff_fin
             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     tab_dap,a0
             movea.l   0(a0,d0.w),a0
             bsr       be_affi
             bra       do_aff_fin
; pour les substances
do_aff_sub:  
             lea.l     tab_das,a0
             move.w    d0,d1
             subi.w    #15,d0
             mulu.w    #12,d0
             lea.l     0(a0,d0.w),a0        ; pointer la substance
             lea.l     bvartab,a1
             subq.w    #1,d1
             moveq.l   #0,d0
             move.b    0(a1,d1.w),d0
             beq       do_aff_fin
             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     0(a0,d0.w),a0        ; pointer le niveau de la sub.
             movea.l   (a0),a0              ; pointer le texte
             bsr       be_affi
             bra       do_aff_fin
; afficher heure
do_aff_heu:  
             jsr       jhm
             move.w    d1,heure
             move.w    d2,minute
;           cmp.w    exheure,d1
;            bne      doheu0
;             cmp.w    exminute,d2
;              beq      do_aff_fin
;doheu0:
;             move.w   d1,exheure
;            move.w   d2,exminute

             move.w    d1,d0
             ext.l     d0
             jsr       convasc

             move.b    chiffre+9,txhh
             move.b    chiffre+10,txhh+1

             move.w    minute,d0
             ext.l     d0
             jsr       convasc

             move.b    chiffre+9,txhm
             move.b    chiffre+10,txhm+1
             lea.l     txheure,a0
             jsr       be_affi
             bra       do_aff_fin



;exheure:      .DC.w 0
;exminute:     .DC.w 0

             .EVEN 

; afficher rythme
do_aff_ryt:  
             moveq.l   #0,d0
             move.b    vrythm,d0
             beq       do_aff_fin
             subq.w    #4,d0
             lsl.w     #2,d0
             lea.l     tab_dar,a0
             movea.l   0(a0,d0.w),a0
             bsr       be_affi
             bra       do_aff_fin
; ------------------------------------------
; DO_PREV
;
do_prev:     
;
; Declencher un BIP sonore
;
             jsr       tokenon
             movem.l   d0-d7/a0-a6,-(sp)
             lea.l     sonbip,a0
             jsr       play_son_bob
             lea.l     bobalerte,a0
             bsr       be_affi
             movem.l   (sp)+,d0-d7/a0-a6
             move.w    #-1,varbobprev       ;&&&&&

             rts       

; ------------------------------------------
; DO_INC
;
do_inc:      
             subi.w    #15,d0
;
; D0.W contient le numero de la substance
;      à incrementer (0=subst1 à 4=subst5)
;
             cmpi.w    #4,d0
             bgt       do_inc0
             add.w     d0,d0
             lea.l     substance,a0
             move.w    #1,0(a0,d0.w)
             bra       do_incfin
do_inc0:     
; Si D0 = 7 alors augmenter le rythme
; cardiaque d'un niveau
;


             cmpi.w    #7,d0
             bne       do_incfin
             move.w    #6,vitcardinit
do_incfin:   
             jsr       tokenon
             rts       
; ------------------------------------------
; DO_DEC
;
do_dec:      
             subi.w    #15,d0

; Si D0 = 7 alors diminuer le rythme
; cardiaque d'un niveau
;
             cmpi.w    #7,d0
             bne       do_decfin
             move.w    #2,vitcardinit
do_decfin:   
             jsr       tokenon
             rts       
; ------------------------------------------
; DO_ANA
; en Entrée : D0.W = 1 analyser joueur
;                  = 2 analyser evi
do_ana:      
             pea       (a0)
             jsr       tokenoff

             lea.l     anagent,a0
             move.w    #0,btypeevi
             cmpi.w    #2,d0
             bne.s     do_anafin
             lea.l     anaevi,a0
             move.w    #1,btypeevi
do_anafin:   

             jsr       be_affi
             jsr       bob_initvar
             movea.l   (sp)+,a0
             rts       
; ------------------------------------------
; DO_SUBN
;
do_subn:     
             subi.w    #20,d1
;
; D1.W contient le numero de la substance
;      à rendre normale (0=subst1 à 4=subst5)
;
             add.w     d1,d1
             lea.l     substance,a0
             clr.w     0(a0,d1.w)

             jsr       tokenon
             rts       
; ------------------------------------------
; DO_RYTHN
;
do_rythn:    
;
; mettre le rythme cardiaque en normal
;
             move.w    #4,vitcardinit
             jsr       tokenon
             rts       
; ------------------------------------------
; DO_TRAD
;
do_trad:     
             move.w    #1,btraduc
             jsr       tokenon
             rts       

; ------------------------------------------
; BE_AFFI:
; afficher un texte pointé par A0 et se terminant
; par un 0.
be_affi:     
             tst.w     textbobplein
             beq       do_affok
             move.w    #-1,bobsemaaffi      ;voir 'EXPLICATION sur BOBSEMAAFFI'
             rts       
do_affok:    

             moveq.l   #0,d0

             lea.l     buftextbob,a1
be_affi0:    
             cmpm.b    (a0)+,(a1)+
             bne       be_affi1

be_affi2:    
             move.b    -1(a0),-1(a1)
             bne.s     be_affi0
             move.w    d0,textbobplein      ;-1=afficher 0=ne rien faire
             rts       
be_affi1:    
             moveq.l   #-1,d0               ;les 2 chaines sont <>
             bra       be_affi2


; ------------------------------------------------------
; BAT II / 1990 computer's dream
; Definition Vectorielle
; humain

points       equ 37
lignes       equ 43
distance     equ -1100
c            equ couleur_3d

homme:                 ; Structure de l'objet
             .DC.w 0   ; angle x
             .DC.w 0   ; angle y
             .DC.w 0   ; angle z
             .DC.w distance                 ; distance initiale
             .DC.l homme_x                  ; adresse des points en x
             .DC.l homme_y                  ;    ,,      ,,         y
             .DC.l homme_z                  ;    ,,      ,,         z
             .DC.l homme_lin                ; adresse des lignes
             .DC.w points                   ; nombre de points
             .DC.w lignes                   ; nombre de lignes
             .DC.w -6  ; position X du repère central de l'objet
             .DC.w 0   ; position Y du repère central de l'objet
             .DC.w 1   ; nombre d'images ( 1 et plus)

homme_x:     
             .DC.w 10,8,30,42,51,50,45,46,41
             .DC.w 34,20,17,20,32,47,48,19,19,0
             .DC.w -19,-19,-48,-47,-32,-20,-17,-20,-34,-41
             .DC.w -46,-45,-50,-51,-42,-30,-8,-10
homme_y:     
             .DC.w -84,-63,-50,7,13,16,13,28,28
             .DC.w 8,-22,-13,7,88,90,95,95,87,15
             .DC.w 87,95,95,90,88,7,-13,-22,8,28
             .DC.w 28,13,16,13,7,-50,-63,-84

homme_lin:   
             .DC.w 1,2,c,2,3,c,3,4,c,4,5,c,5,6,c
             .DC.w 6,7,c,7,8,c,8,9,c,9,10,c,10,11,c
             .DC.w 11,12,c,12,13,c,13,14,c,14,15,c,15,16,c
             .DC.w 16,17,c,17,18,c,18,19,c,19,20,c,20,21,c
             .DC.w 21,22,c,22,23,c,23,24,c,24,25,c,25,26,c
             .DC.w 26,27,c,27,28,c,28,29,c,29,30,c,30,31,c
             .DC.w 31,32,c,32,33,c,33,34,c,34,35,c,35,36,c
             .DC.w 36,37,c,37,1,c,36,2,c,35,27,c
             .DC.w 26,12,c,11,3,c,25,19,c,19,13,c


; *****************************************************
; *****************************************************
; *******                                       *******
; *******                SANTE                  *******
; *******                                       *******
; *****************************************************
; *****************************************************
; Cette fonction fonctionne en deux ecrans
; Le premier ecran affiche un cardiogramme, un homme
; en vectoriel (avec indicateur de blessure), et les
; courbes de consommation (faim,soif,fatigue).
; Le deuxieme ecran  donne  un diagnostic general de
; l'etat du joueur.
sante:       
; inserer les nouvelles valeurs
             lea.l     cons_faim+2,a0
             lea.l     cons_soif+2,a1
             lea.l     cons_fati+2,a2
             move.w    #48,d0
consloop:    
             move.w    (a0),-2(a0)
             move.w    (a1),-2(a1)
             move.w    (a2),-2(a2)
             addq.l    #2,a0
             addq.l    #2,a1
             addq.l    #2,a2
             dbra      d0,consloop
; init de la faim
;$$$$$              lea.l    jehan,a3
;$$$$$              move.w   faim(a3),d0
;$$$$$              ext.l    d0
;$$$$$              divu.w   #400,d0
             moveq.l   #0,d0                ;$$$$$
             move.w    faim,d0              ;$$$$$
             divu.w    #450,d0              ;resultat de 0 a 10  $$$$$

             move.w    #10,-2(a0)
             sub.w     d0,-2(a0)
; init de la soif
;$$$$$              move.w   soif(a3),d0
;$$$$$              ext.l    d0
;$$$$$              divu.w   #400,d0
             moveq.l   #0,d0                ;$$$$$
             move.w    soif,d0              ;$$$$$
             divu.w    #400,d0              ;resultat de 0 a 10  $$$$$



             move.w    #10,-2(a1)
             sub.w     d0,-2(a1)
; init de la fatigue
;$$$$$              move.w   fatigue(a3),d0
;$$$$$              ext.l    d0
;$$$$$              divu.w   #72,d0
             moveq.l   #0,d0                ;$$$$$
             move.w    _sommeil,d0          ;$$$$$
             divu.w    #12*6,d0             ;resultat de 0 a 10  $$$$$


             move.w    #10,-2(a2)
             sub.w     d0,-2(a2)
; dessiner les infos
             jsr       dessine_sante
             jsr       ecrswapbob
             jsr       dessine_sante
; initialisation pour la 3d
             move.l    #viewx,pointx
             move.l    #viewy,pointy
             move.l    #viewz,pointz
             move.l    #ecranx,xplot
             move.l    #ecrany,yplot
             clr.w     rotbzx
             clr.w     rotbzy
             clr.w     rotbzz
; gestion des commandes
             move.l    #courbe,real_time_ad
sante_loop:  
             lea.l     zone_fonc_4,a0
             jsr       interac
             tst.b     sort
             beq.s     sante_loop
; sortir de la fonction sante
; reinitialisation des parametres du menu
; principal
             jsr       desmendep
             clr.b     sort
             rts       
; -----------------------------------------------------
; fonction qui etabli un diagnostic de l'etat du
; joueur
diagnostic:  
             jsr       diagnosticdes
             jsr       ecrswapbob
             jsr       diagnosticdes
; gestion des commandes
             clr.b     sort
             clr.l     real_time_ad
diag_loop:   
             lea.l     zone_fonc_5,a0
             jsr       interac
             tst.b     sort
             beq.s     diag_loop
; sortir de la fonction diagnostic
; reinitialisation des parametres du menu
; sante
             move.l    #courbe,real_time_ad
             jsr       dessine_sante
             jsr       ecrswapbob
             jsr       dessine_sante
             clr.b     sort
             rts       

diagnosticdes:         
             jsr       clear
; boite EXIT
             move.w    #bobxd+5+1,d0
             move.w    #bobyd+68+1,d1
             move.w    #bobxd+55+1,d2
             move.w    #bobyd+78+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyd+68,d1
             move.w    #bobxd+55,d2
             move.w    #bobyd+78,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; ecritures exit
             lea.l     ch_sante,a0
             move.w    #bobxd+5+13,d1
             move.w    #bobyd+71,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
; valeurs pour le diagnostic
; temperature
             lea.l     ch_diag,a0
             move.w    temperature,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,15(a0)
             move.b    chiffre+10,16(a0)
; pressions
             move.w    pression,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,37(a0)
             move.b    chiffre+10,38(a0)
             move.w    pression+2,d0
             ext.l     d0
             jsr       convasc
             move.b    chiffre+9,40(a0)
             move.b    chiffre+10,41(a0)
; etat corporel
; le potentiel de vie
; donne les etats suivants :
;            0 = danger      = potvie inf 25
;             1 = critique    = potvie sup 25 et inf 50
;             2 = preoccupant = potvie sup 50 et inf 75
;             3 = nominal     = potvie sup 75
             lea.l     jehan,a1
             moveq.l   #0,d2
             move.w    potvie(a1),d2
             divu.w    #25,d2
             andi.l    #$ffff,d2
; le joueur doit il se soigner ?
buggfa3      equ 132+66
             move.w    #'  ',ch_diag+buggfa3
             cmpi.w    #2,d2
             bge.s     diag_ss0
             move.w    #'**',ch_diag+buggfa3
diag_ss0:    
             mulu.w    #20,d2
             lea.l     ch_etat,a0
             move.l    2(a0,d2.w),ch_diag+90
             move.l    6(a0,d2.w),ch_diag+94
             move.l    10(a0,d2.w),ch_diag+98
             move.l    14(a0,d2.w),ch_diag+102
             move.w    18(a0,d2.w),ch_diag+106
;
; le joueur a t-il faim ?
             move.w    #'  ',ch_diag+132
             cmpi.w    #3000,faim           ;$$$$$              cmpi.w   #1000,faim(a1)
             bge.s     diag_f0
             move.w    #'**',ch_diag+132
diag_f0:     
; le joueur a t-il soif ?
             move.w    #'  ',ch_diag+154
             cmpi.w    #2000,soif           ;$$$$$              cmpi.w   #1000,soif(a1)
             bge.s     diag_f1
             move.w    #'**',ch_diag+154
diag_f1:     
; le joueur estil fatigue ?
             move.w    #'  ',ch_diag+176
             cmpi.w    #6*60,_sommeil       ;$$$$$              cmpi.w   #200,fatigue(a1)
             bge.s     diag_f2
             move.w    #'**',ch_diag+176
diag_f2:     
;
; affichage des textes du diagnostic
             lea.l     ch_diag,a0
             move.w    #bobxd+5,d1
             move.w    #bobyd+5,d2
             moveq.l   #11,d3
diag_0:      
             moveq.l   #couleur_ecr,d4
             cmpi.w    #'**',(a0)+
             bne.s     diag_1
             moveq.l   #rouge,d4
diag_1:      
             jsr       write
             lea.l     20(a0),a0
             addq.w    #7,d2
             cmpi.w    #bobyf-20,d2
             ble.s     diag_2
             addi.w    #56,d1
             move.l    #bobyd+5+42,d2
diag_2:      
             dbra      d3,diag_0
             rts       

; -----------------------------------------------------
; dessiner les boites, les textes de la   fonction
; sante.
dessine_sante:         
             jsr       clear
             clr.b     sort
; boite cardiogramme
             move.w    #bobxd+5+1,d0
             move.w    #bobyd+5+1,d1
             move.w    #bobxd+60+1,d2
             move.w    #bobyd+30+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyd+5,d1
             move.w    #bobxd+60,d2
             move.w    #bobyd+30,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; boite consommation
             move.w    #bobxd+5+1,d0
             move.w    #bobyd+35+1,d1
             move.w    #bobxd+60+1,d2
             move.w    #bobyd+55+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyd+35,d1
             move.w    #bobxd+60,d2
             move.w    #bobyd+55,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; dessiner les courbes des historiques de consommation
; Faim, Soif, Fatigue
; affichage des courbes
             move.w    #bobxd+5+2,d0
             move.w    #bobyd+35+2,d1
             move.w    #bobxd+60-1,d2
             move.w    #bobyd+55-1,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             lea.l     cons_faim,a0         ; courbe de faim en rouge
             lea.l     cons_soif,a1         ; courbe de soif en vert
             lea.l     cons_fati,a2         ; courbe de fatigue bleu
             move.l    #49,d5               ; 50 valeurs
             move.l    #bobxd+5+2,d0
cons_0:      
; courbe de faim
             movem.l   d0-d5,-(sp)
             move.w    (a0)+,d6
             ext.l     d6
             move.l    #bobyd+39,d1
             add.w     d6,d1
             pea       (a0)
             moveq.l   #rouge,d2
             jsr       pointbob
             movea.l   (sp)+,a0
             movem.l   (sp)+,d0-d5
; courbe de soif
             movem.l   d0-d5,-(sp)
             move.w    (a1)+,d6
             ext.l     d6
             move.l    #bobyd+40,d1
             add.w     d6,d1
             pea       (a0)
             move.w    #14,d2
             jsr       pointbob
             movea.l   (sp)+,a0
             movem.l   (sp)+,d0-d5
; courbe de fatigue
             movem.l   d0-d5,-(sp)
             move.w    (a2)+,d6
             ext.l     d6
             move.l    #bobyd+41,d1
             add.w     d6,d1
             pea       (a0)
             move.w    #15,d2
             jsr       pointbob
             movea.l   (sp)+,a0
             movem.l   (sp)+,d0-d5
             addq.w    #1,d0
             dbra      d5,cons_0
; pour l'homme vectoriel
             jsr       des_org
; boite EXIT
             move.w    #bobxd+5+1,d0
             move.w    #bobyd+65+1,d1
             move.w    #bobxd+55+1,d2
             move.w    #bobyd+75+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5,d0
             move.w    #bobyd+65,d1
             move.w    #bobxd+55,d2
             move.w    #bobyd+75,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; boite diagnostic
             move.w    #bobxd+5+52+1,d0
             move.w    #bobyd+65+1,d1
             move.w    #bobxf-5+1,d2
             move.w    #bobyd+75+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+5+52,d0
             move.w    #bobyd+65,d1
             move.w    #bobxf-2,d2
             move.w    #bobyd+75,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; boite commandes 3D
             move.w    #bobxd+112+1,d0
             move.w    #bobyd+5+1,d1
             move.w    #bobxd+126+1,d2
             move.w    #bobyd+63+1,d3
             moveq.l   #couleur_ombre,d4
             jsr       boxbob
             move.w    #bobxd+112,d0
             move.w    #bobyd+5,d1
             move.w    #bobxd+126,d2
             move.w    #bobyd+63,d3
             moveq.l   #couleur_ecr,d4
             jsr       boxbob
; textes des touches 3d
             lea.l     ch_sante+18,a0
             move.w    #bobxd+117,d1
             move.w    #bobyd+8,d2
             moveq.l   #couleur_ecr,d4
             jsr       write                ; fleche droite
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; fleche gauche
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; fleche haut
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; fleche bas
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; +
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; -
             lea.l     2(a0),a0
             addq.l    #8,d2
             jsr       write                ; angle
; ecritures exit & diagnostic
             lea.l     ch_sante,a0
             move.w    #bobxd+5+13,d1
             move.w    #bobyd+68,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             lea.l     ch_sante+6,a0
             move.w    #bobxd+5+15+42,d1
             move.w    #bobyd+68,d2
             moveq.l   #couleur_ecr,d4
             jsr       write
             rts       
; met les bonnes couleurs des lignes selon l'etat des
; organes
des_org:     
; mettre en rouge les organes touches
; clear de toutes les lignes
             movea.l   adr_obj,a0
             move.w    mnbrlin(a0),d0
             movea.l   ad_lin(a0),a1
             subq.l    #1,d0
ds_hv0:      
             move.w    #couleur_3d,4(a1)
             addq.l    #6,a1
             dbra      d0,ds_hv0
; les etats 1 sont indiques en rouge
; tete touchee ?
             moveq.l   #0,d0
             lea.l     jehan,a1
             move.w    etat_evi(a1),d1
             movea.l   ad_lin(a0),a1
; tete touchee ?
             btst.l    #0,d1
             beq.s     ds_hv1
             lea.l     tete,a0
             jsr       des_cc
; torse touche ?
ds_hv1:      
             btst.l    #1,d1
             beq.s     ds_hv2
             lea.l     tors,a0
             jsr       des_cc
; abdomen touche ?
ds_hv2:      
             btst.l    #2,d1
             beq.s     ds_hv3
             lea.l     abdo,a0
             jsr       des_cc
; bras gauche touche ?
ds_hv3:      
             btst.l    #4,d1
             beq.s     ds_hv4
             lea.l     brag,a0
             jsr       des_cc
; bras droit touche ?
ds_hv4:      
             btst.l    #3,d1
             beq.s     ds_hv5
             lea.l     brad,a0
             jsr       des_cc
; jambe gauche touche ?
ds_hv5:      
             btst.l    #6,d1
             beq.s     ds_hv6
             lea.l     jamg,a0
             jsr       des_cc
; jambe droite touche ?
ds_hv6:      
             btst.l    #5,d1
             beq.s     ds_hv7
             lea.l     jamd,a0
             jsr       des_cc
ds_hv7:      
             rts       
des_cc:      
             cmpi.w    #$ffff,(a0)+
             beq.s     des_cc_fin
             move.w    -2(a0),d0
             subq.w    #1,d0                ; calcul de l'offset pour adresser
             mulu.w    #6,d0                ; la bonne ligne
             move.w    #rouge,4(a1,d0.w)    ; change la couleur
             bra.s     des_cc
des_cc_fin:  
             rts       
; -----------------------------------------------------
; Ici on trouve toutes les routines de gestion des
; commandes 3D
; Fonction 3D
; deplacer l'objet a droite
droite:      
             movea.l   adr_obj,a0
             cmpi.w    #30,x0(a0)
             bge.s     droite_fin
             addq.w    #2,x0(a0)
droite_fin:  
             rts       
; Fonction 3D
; deplacer l'objet a gauche
gauche:      
             movea.l   adr_obj,a0
             cmpi.w    #-30,x0(a0)
             ble.s     gauche_fin
             subq.w    #2,x0(a0)
gauche_fin:  
             rts       
; Fonction 3D
; deplacer l'objet vers le haut
haut:        
             movea.l   adr_obj,a0
             cmpi.w    #-60,y0(a0)
             ble.s     haut_fin
             subq.w    #2,y0(a0)
haut_fin:    
             rts       
; Fonction 3D
; deplacer l'objet vers le bas
bas:         
             movea.l   adr_obj,a0
             cmpi.w    #60,y0(a0)
             bge.s     bas_fin
             addq.w    #2,y0(a0)
bas_fin:     
             rts       
; Fonction 3D
; deplacer l'objet vers l'avant
zoomp:       
             movea.l   adr_obj,a0
             cmpi.w    #-500,dist(a0)
             bge.s     zoomp_fin
             addi.w    #20,dist(a0)
zoomp_fin:   
             rts       
; Fonction 3D
; deplacer l'objet vers l'arriere
zoomm:       
             movea.l   adr_obj,a0
             cmpi.w    #-1500,dist(a0)
             ble.s     zoomm_fin
             subi.w    #20,dist(a0)
zoomm_fin:   
             rts       
; Fonction 3D
; incrementer l'angle de rotation y
anglep:      
             cmpi.w    #30,vitangle
             blt.s     anglep_0
             clr.w     vitangle
             rts       
anglep_0:    
             addi.w    #2,vitangle
             rts       
; -----------------------------------------------------
; dessine les courbes du cardiogramme et de la
; consommation
; dessine aussi l'homme 3d
p_cardio:    
             .DC.l c_cardio
courbe:      
             move.l    a0,-(sp)
; affichage du cardiogramme
             move.w    #bobxd+5+2,d0
             move.w    #bobyd+5+2,d1
             move.w    #bobxd+60-1,d2
             move.w    #bobyd+30-1,d3
             moveq.l   #couleur_fond,d4
             jsr       pboxbob
             movea.l   p_cardio,a0
             moveq.l   #50,d5
             move.w    #bobxd+5+2,d0
             moveq.l   #couleur_ecr,d2
courbe_0:    
             movem.l   d0-d5,-(sp)
             move.w    (a0)+,d6
             cmpa.l    #c_cardiofin,a0
             blt.s     courbe_1
             movea.l   #c_cardio,a0
             move.w    (a0)+,d6
courbe_1:    
             move.l    #bobyd+19,d1
             sub.w     d6,d1
             pea       (a0)
             jsr       pointbob
             movea.l   (sp)+,a0
             movem.l   (sp)+,d0-d5
             addi.w    #1,d0
             dbra      d5,courbe_0
; gestion de la vitesse = f(vitcardinit)
             movea.l   p_cardio,a0
             moveq.l   #0,d0
             move.w    vitcardinit,d0
             add.w     d0,d0
             adda.l    d0,a0
             cmpa.l    #c_cardiofin,a0
             blt.s     fin_cardio
             move.l    a0,d0
             subi.l    #c_cardiofin,d0
             addq.l    #2,d0
             lea.l     c_cardio,a0
             adda.l    d0,a0
fin_cardio:  
             move.l    a0,p_cardio
; affichage de l'homme 3D
             jsr       dessine
             jsr       ecrswapbob
             movea.l   (sp)+,a0

             rts       
; *****************************************************
; *****************************************************
; *******                                       *******
; *******             PROGRAMMATION             *******
; *******                                       *******
; *******                EDITEUR                *******
; *******                                       *******
; *******             FONCTION ZOOM             *******
; *******                                       *******
; *****************************************************
; *****************************************************
;
bobzxd       equ 16
bobzyd       equ 4
bobzxf       equ 303
bobzyf       equ 195
;
;
bob_zoom:    
             cmpi.w    #2,souri_5
             bne       no_bobz
bobz_ck0:    
             tst.w     souri_5
             bne.s     bobz_ck0
             movem.l   d0-d7/a0-a6,-(sp)
; tracer le bord blanc
             move.w    #bobzxd-4,d0
             move.w    #bobzyd-4,d1
             move.w    #bobzxf+4,d2
             move.w    #bobzyf+4,d3
             move.w    #blanc,d4
             jsr       pboxbob
; tracer le bord noir
             move.w    #bobzxd-1,d0
             move.w    #bobzyd-1,d1
             move.w    #bobzxf+1,d2
             move.w    #bobzyf+1,d3
             moveq.l   #0,d4
             jsr       pboxbob
; dessiner la feuille
             jsr       des_zoom
;
             jsr       ecrswapbob
; initialiser le clipping souris sur AMIGA
             move.w    #bobzxd,min_x
             move.w    #bobzyd,min_y
             move.w    #bobzxf,max_x
             move.w    #bobzyf,max_y
             move.l    sys01,-(sp)
             move.l    sys00,sys01
; initialisation pour le marqueur de
; la viewsheet
bobz_redraw: 
             move.w    vsheet_x,d0
             ext.l     d0
             lsl.w     #4,d0
             addi.w    #bobzxd,d0
             move.l    d0,d2
             addi.w    #5*16,d2
             subq.w    #1,d2
             move.w    vsheet_y,d1
             ext.l     d1
             lsl.w     #4,d1
             addi.w    #bobzyd,d1
             move.l    d1,d3
             addi.w    #5*16,d3
             subq.w    #1,d3
             moveq.l   #couleur_ecr,d4
; boucle principale
bobz_ck1:    
; dessiner le cadre de la viewsheet
             movem.l   d0-d4,-(sp)
             jsr       boxbob
             movem.l   (sp)+,d0-d4
bobz_sync:   
;
             cmpi.w    #1,souri_5
             beq.s     bobz_select
             cmpi.w    #2,souri_5
             beq       bobz_ck2
             bra.s     bobz_ck1
; ici on selectionne une nouvelle viewsheet
; sur la sheet principale donc on doit recalculer
; les pointeurs de la viewsheet
bobz_select: 
             move.w    souri_7,d0
             subi.w    #bobzxd,d0
             lsr.w     #4,d0
             subq.w    #2,d0
             bpl.s     bobz_s0
             clr.w     d0
bobz_s0:     
             cmpi.w    #viewsheet_maxx-5,d0
             ble.s     bobz_s00
             move.w    #viewsheet_maxx-5,d0
bobz_s00:    
             move.w    d0,vsheet_x
             move.w    souri_8,d0
             subi.w    #bobzyd,d0
             lsr.w     #4,d0
             subq.w    #2,d0
             bpl.s     bobz_s1
             clr.w     d0
bobz_s1:     
             cmpi.w    #viewsheet_maxy-5,d0
             ble.s     bobz_s11
             move.w    #viewsheet_maxy-5,d0
bobz_s11:    
             move.w    d0,vsheet_y
             move.l    #feuille,pviewsheet
             move.w    vsheet_y,d0
             mulu.w    #viewsheet_maxx*2,d0
             add.w     vsheet_x,d0
             add.w     vsheet_x,d0
             add.l     d0,pviewsheet
bobz_s2:     
             jsr       des_zoom
             bra       bobz_redraw
; anti rebond
bobz_ck2:    
             tst.w     souri_5
             bne.s     bobz_ck2
; sortir de la fonction zoom
; reinitialisation des parametres de
; l'editeur
             move.l    (sp)+,sys01
             clr.b     sort
;   move.w   #$ffff,masque  ; propre a l'AMIGA
             move.w    #_clipxd,min_x
             move.w    #_clipyd,min_y
             move.w    #_clipxf,max_x
             move.w    #_clipyf,max_y
             jsr       des_feuilledes
             jsr       ecrswapbob
             jsr       copy_sys01
             movem.l   (sp)+,d0-d7/a0-a6
no_bobz:     
             rts       
; -----------------------------------------------------
; DES_ZOOM:
; affichage du cadriage de la feuille totale de
; programmation.
; si (error_ad) n'est pas nul, on entoure l'icone de
; rouge.
des_zoom:    
; afficher les icones (partie visible de la feuille)
             movea.l   sys01,a0
             lea.l     ((bobzyd*160)+2*4)(a0),a0
             movea.l   #feuille,a2
             move.l    #bobzyd,d1
             moveq.l   #11,d7
des_zloop2:  
             move.l    #bobzxd,d0
             moveq.l   #17,d6
             pea       (a0)
             pea       (a2)
des_zloop3:  
             move.w    (a2),d5
             ext.l     d5
             movea.l   adrfoncbob,a1        ;lea.l    fonc_bob,a1
             btst.l    #7,d5                ; est-ce une liaison
             beq.s     des_z0
; -----------------------------
; dessiner une liaison
;
             movea.l   adrliaibob,a1        ;lea.l    liaison_bob,a1
             subi.w    #128+1,d5            ; pas de liaison a 0
; -----------------------------
; dessiner une fonction
;
des_z0:      
             lsl.l     #7,d5
             adda.l    d5,a1
             movem.l   d0-d7/a0-a2,-(sp)
             jsr       put_16
             movem.l   (sp)+,d0-d7/a0-a2
             cmpa.l    error_ad,a2
             bne.s     des_z00
; -----------------------------
; il y a une erreur a cette adresse
;
             movem.l   d0-d7/a0-a2,-(sp)
             move.l    d0,d2
             addi.w    #15,d2
             move.l    d1,d3
             addi.w    #15,d3
             moveq.l   #rouge,d4
             jsr       boxbob
             movem.l   (sp)+,d0-d7/a0-a2
; -----------------------------
; continuer l'affichage
;
des_z00:     
             addq.l    #2,a2
             addq.l    #2*4,a0
             addi.w    #16,d0
             dbra      d6,des_zloop3
             movea.l   (sp)+,a2
             movea.l   (sp)+,a0
             lea.l     16*slarg(a0),a0
             lea.l     (viewsheet_maxx*2)(a2),a2
             addi.w    #16,d1
             dbra      d7,des_zloop2
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
; - "faim"     (.W): consommation en calories par jour
;                    varit de 0 à 4000 cal
;
; - "soif"     (.W): deshydratation par jour
;                    varit de 0 à 4000 millilitre
;
; - "fatigue"  (.W): besoin en repos en minutes par jour
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
nom          equ 0     ; nom (10 caracteres)racesexe equ     10              ; sexe (b7) / race (b6-b0)
age          equ 11
posevi       equ 12
;$$$$$ faim          equ 14   ; (cal / jour)
;$$$$$ soif          equ 16   ; (mil / jour)
;$$$$$ fatigue       equ 18   ; (min / jour) de repos
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





textbob:     
             movem.l   d0-d7/a0-a6,-(sp)

             movea.l   sys01,a1
             move.w    d4,d3
             move.w    #160,d4
             jsr       textx
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

boxbob:      
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       box
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
put_16:      
             movem.l   d0-d7/a0-a6,-(sp)

             .REPT 16
             move.l    (a1)+,(a0)+
             move.l    (a1)+,(a0)+
             lea.l     160-8(a0),a0
             .ENDR 
             movem.l   (sp)+,d0-d7/a0-a6
             rts       
copy_sys01:  
             jsr       hidemouse            ;       clr.w    souri_11
             movea.l   sys00,a0
             movea.l   sys01,a1
             move.w    #8000-1,d0
wqw:         
             move.l    (a0)+,(a1)+
             dbra      d0,wqw
             move.w    #sourisbob,souri_11
             rts       

ecrswapbob:  
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       ecrswap
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

pboxbob:     
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       pbox
             movem.l   (sp)+,d0-d7/a0-a6
             rts       


;flagvbl:

lignebob:    
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       ligne
             movem.l   (sp)+,d0-d7/a0-a6
             rts       

pointbob:    
             movem.l   d0-d7/a0-a6,-(sp)
             jsr       point
             movem.l   (sp)+,d0-d7/a0-a6

             rts       
min_x:       .DC.w 0
min_y:       .DC.w 0
max_x:       .DC.w 319
max_y:       .DC.w 199

adriconbob:  .DC.l 0
adrfontbob:  .DC.l 0
adrfoncbob:  .DC.l 0
adrliaibob:  .DC.l 0







;---------------------------------------------------------------
;
; evaluer
;
; entree:     a0 pointe sur l'octet source
;             a1 pointe sur l'octet destination
;
; place 4,5,6 (fort,faible,normal) dans (a1).b
; en fonction de (a0).b (0 a 100)
;
;             d0 est modifie
;

evaluer:     
             move.b    (a0),d0
             move.b    #4,(a1)              ;fort
             cmpi.b    #65,d0
             bhi       rts
             move.b    #6,(a1)              ;normal
             cmpi.b    #40,d0
             bhi       rts
             move.b    #5,(a1)              ;faible
rts:         rts       



sonbip:      
             .DC.w $0,$0,$0,$14,$0,$3de,$0,$0,$0,$0,$8d60,$5c81,$aba6,$7f51
             .DC.w $588b,$bbad,$753f,$5094,$c9b6,$7436,$4690,$cfc3,$772c,$398d
             .DC.w $dbd5,$7f26,$267f,$dde3,$8e29,$196f,$d5ec,$9f34,$1560,$c8ea
             .DC.w $a941,$1956,$bce5,$b350,$2351,$add9,$b55b,$2f53,$a4ce,$b263
             .DC.w $3c59,$9cbe,$a966,$4764,$9db5,$9f65,$4f6f,$a2ae,$935d,$4e77
             .DC.w $afb6,$8c51,$4378,$b9c8,$9046,$336e,$bad5,$a150,$275a,$b0e0
             .DC.w $b95c,$193f,$a2e8,$d175,$1e26,$84df,$e793,$280f,$61cf,$f4b5
             .DC.w $460e,$41ae,$eecf,$6819,$2b8d,$dfdb,$8931,$2770,$c5d7,$9c47
             .DC.w $3063,$afcb,$a75d,$3f61,$a0bc,$a264,$4b68,$9baf,$9a68,$5673
             .DC.w $a0a7,$8c5e,$597e,$aba9,$8351,$5488,$bcb4,$7c3d,$4489,$c9be
             .DC.w $7f3b,$3f84,$cbcb,$8633,$2e7a,$cfd9,$9233,$206f,$d0e5,$9d35
             .DC.w $1762,$caec,$aa3d,$1455,$c3ed,$b749,$1548,$b0e5,$be58,$2148
             .DC.w $a6da,$bd62,$304d,$9ac7,$b46a,$4159,$99bb,$a86a,$4c66,$9aaf
             .DC.w $9762,$5577,$a6ab,$8956,$5483,$b6af,$7e45,$4988,$c7c4,$8136
             .DC.w $397e,$c8d1,$8f3a,$236a,$c9e9,$aa46,$114a,$b6f5,$c95d,$c2d
             .DC.w $9bf0,$e07e,$1a1a,$7bdf,$eb98,$2f12,$5fc9,$efb6,$4a13,$43ad
             .DC.w $e8c9,$6320,$3892,$d6cf,$8235,$377c,$bfc8,$8e49,$4273,$aebc
             .DC.w $9459,$5078,$a6ac,$8b5b,$597f,$a8a7,$8457,$5a87,$b2a9,$7c49
             .DC.w $508a,$c1ba,$7f3c,$4086,$cbc2,$833c,$387e,$c8d0,$8f3a,$2a73
             .DC.w $cadd,$9b3c,$1d62,$c5e6,$ab43,$1a58,$bde8,$b34c,$194c,$b2e5
             .DC.w $bc58,$2049,$a9dd,$bd5f,$2848,$9ed2,$bc68,$354e,$98c6,$b66d
             .DC.w $4258,$93b8,$a76d,$5069,$9bad,$9764,$5576,$a4a7,$8757,$5886
             .DC.w $b6ad,$7c44,$4f8e,$c8ba,$772f,$448e,$cfc7,$7f30,$2f7e,$d3dd
             .DC.w $9130,$1967,$cdf2,$b242,$945,$b8f8,$cd5a,$92a,$9bf3,$e67f
             .DC.w $1918,$76db,$eb9a,$3418,$5fc2,$e6b1,$4c22,$50aa,$d8b7,$6332
             .DC.w $4b96,$c9bb,$7440,$4f8b,$b7b0,$7b4c,$588a,$afa8,$7b52,$608f
             .DC.w $b09f,$734b,$6198,$bea4,$6d40,$5799,$c9b4,$6f2f,$4092,$d2c5
             .DC.w $7f37,$367f,$cad4,$933b,$256a,$c4e0,$a645,$1d5a,$b9e1,$b355
             .DC.w $1e49,$ace2,$bf5d,$1d41,$a3e0,$c869,$273c,$95d3,$c773,$3543
             .DC.w $8cc6,$be77,$3f4b,$8abb,$b576,$4b59,$8fb3,$a770,$5165,$95ac
             .DC.w $9a6a,$5776,$a3aa,$8a59,$5580,$b0ae,$804a,$4d85,$c1bd,$803c
             .DC.w $4580,$c0bf,$8540,$397d,$c6d0,$8f3e,$2a6d,$c3db,$a046,$205b
             .DC.w $b8e3,$b557,$1e45,$a2dc,$c56f,$2837,$89d2,$d087,$3930,$72bd
             .DC.w $ce9b,$4f36,$63a9,$c5a6,$6444,$6096,$b4a3,$7153,$6590,$a89d
             .DC.w $735d,$6c8e,$a093,$7260,$7294,$a38f,$6e5c,$7498,$aa91,$6950
             .DC.w $6c9b,$b79e,$6b4a,$6191,$b5a7,$774b,$5386,$b5b4,$8651,$4876
             .DC.w $aebc,$965a,$4166,$a1bf,$a46a,$4359,$93ba,$ac77,$4b54,$87b2
             .DC.w $ad80,$5355,$81aa,$aa82,$5b59,$7ea1,$a685,$6461,$7e9a,$9d82
             .DC.w $686a,$8196,$967f,$6c72,$8794,$8d77,$6c79,$8e95,$8770,$6a7e
             .DC.w $989a,$8366,$627f,$9e9e,$8465,$607d,$9da3,$8864,$5a78,$9da8
             .DC.w $8e66,$5672,$9aab,$946a,$546b,$95ab,$996f,$5566,$90ab,$9e77
             .DC.w $5861,$87a6,$a17f,$5e60,$809f,$a184,$6662,$7a96,$9d89,$6e66
             .DC.w $788f,$988a,$736b,$788b,$9288,$7670,$7c8b,$8e85,$7673,$7f8c
             .DC.w $8d81,$7372,$8090,$9081,$716d,$7e91,$9584,$726a,$798e,$988b
             .DC.w $7667,$7288,$9992,$7c68,$6c82,$9797,$836c,$687c,$9298,$8972
             .DC.w $6875,$8b97,$8e7a,$6b71,$8593,$8f7f,$7071,$808f,$9081,$7473
             .DC.w $7f8a,$8c82,$7876,$7f88,$8a81,$7979,$8086,$8680,$7a7b,$8186
             .DC.w $847f,$7a7e,$8386,$827c,$797f,$8688,$827a,$777f,$888a,$8278
             .DC.w $767f,$878a,$8379,$757d,$878c,$847a,$747b,$868b,$867c,$757a
             .DC.w $858b,$877d,$7679,$8289,$877f,$787a,$8188,$8780,$797a,$8086
             .DC.w $8680,$0

             .BSS 



chiffre:     .DS.b 16

; memoire pour empiler les adresses des conditions
; vraies des IF
pile_if_end: 
             .DS.l if_max
pile_if:     
; memoire pour empiler les adresses des CRT
pile_crt_end:          
             .DS.l crt_max
pile_crt:    

; tables de travail
viewx:       .DS.w 70  ; table des projections tridimensionelles
viewy:       .DS.w 70
viewz:       .DS.w 70
ecranx:      .DS.w 70  ; table des projections bidimentionelles
ecrany:      .DS.w 70

homme_z:     
             .DS.w points


bobsemaaffi: .DS.w 1

