;bss

;configdata
;substance
;jehan
;objstruc
;marchand
             .DATA 

;---------------------------------------------------------------
;a sauver (sauver partie)

;marchand

savedata::   

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

; ---------------------------------------------------------
; datas pour la programmation (a sauver )
; sauver entre "bobdatadebut" et "bobdatafin"
;
bobdatadebut:          
; variable "running":
; 0  : aucun programme est en execution
; 1  : le programme est execute
; 2  : le programme contient une erreur
running::    
             .DC.w 0
; adresse de l'erreur ds la feuille de shema
error_ad::   
             .DC.l 0
; type de fonction (If,Do)
fonction::   
             .DC.w 0
; parametres choisis
param1::     
             .DC.w 0
param2::     
             .DC.w 0
; numero des parametres courants de la fonction active
cpt_par1::   
             .DC.w 0
cpt_par2::   
             .DC.w 0
flag_lier::  
             .DC.w 0
flag_effacer::         
             .DC.w 0
; feuille de shema du programmateur
; taille de la feuille = viewsheet_maxx*viewsheet_maxy (.W)
pviewsheet:: 
             .DC.l feuille
vsheet_x::   
             .DC.w 0
vsheet_y::   
             .DC.w 0


btraduc::    
             .DC.w 0   ; 0 ne pas traduire, 1 traduire
btypeevi::   
             .DC.w 0   ; 0 = joueur, 1 = evi
;
; zone des variables de la librairie du module
; d'execution (remplie par BOB_INITVAR)
;
; codes utilisés(.b) : 0 = ok
;                      1 = faim
;                      2 = soif
;                      3 = fatigue
;                      4 = fort
;                      5 = faible
;                      6 = normal
;                      7 = force importante
;                      8 = intel importante
;                      9 = vital importante
;                     10 = perce importante
;                     11 = refle importante
;                     12 = chari importante
;                     13 = agressif
;                     14 = shedish
bvartab::    
vjoueur::    .DC.b 1
vevi::       .DC.b 7
vforce::     .DC.b 4
vintel::     .DC.b 0
vvital::     .DC.b 5
vperce::     .DC.b 0
vrefle::     .DC.b 6
vchari::     .DC.b 0
vfaim::      .DC.b 0
vsoif::      .DC.b 0
vfatig::     .DC.b 0
vetat::      .DC.b 0
vtemp::      .DC.b 0
vpress::     .DC.b 0
vsub1::      .DC.b 0
vsub2::      .DC.b 0
vsub3::      .DC.b 0
vsub4::      .DC.b 6
vsub5::      .DC.b 0
vsub6::      .DC.b 0   ; inutilise
vheure::     .DC.b 0
vrythm::     .DC.b 0
             .EVEN 
; variables pour la fonction d'alarme
alarmh::     
             .DC.w 12  ; valeur des heurs
alarmm::     
             .DC.w 0   ; valeur des minutes

bobcons::    .DC.w 0

adtokcour::  .DC.l tokenlist


bobdatafin:  

;----------------------------------------------------------------
;
; DONNEES POUR LE JOUEUR
;
;
progression::          .DC.w 0


jehan::      
; nom
             .DC.b 'JEHAN     '             ; 10 caracteres
             .DC.b 0
; age
             .DC.b 35
; ???
             .DC.w 0
; consommations
             .DC.w 2000                     ; (cal / jour)
             .DC.w 500 ; (hyd / jour)
             .DC.w 480 ; (min / jour) de repos
; points de vie
             .DC.w 99
; caracteristiques potentielles initiales
             .DC.b 80
             .DC.b 70
             .DC.b 65
             .DC.b 60
             .DC.b 65
             .DC.b 40
; caracteristiques courantes initiales
             .DC.b 80
             .DC.b 70
             .DC.b 65
             .DC.b 60
             .DC.b 65
             .DC.b 40
; etat
             .DC.w $0  ; etat
; --------------------------------------------------
; Caracteristiques speciales du joueur
;
; substances injectees
substance::  
ats34::      .DC.w 0   ; substance 1
fibrine::    .DC.w 0
hypercep::   .DC.w 0
morphol7::   .DC.w 0
psy::        .DC.w 0   ; a substance 5

substvbl::   
ats34vbl::   .DC.l 0   ; substance 1
fibrivbl::   .DC.l 0
hypervbl::   .DC.l 0
morphvbl::   .DC.l 0
psyvbl::     .DC.l 0   ; a substance 5

; definition des courbes de consommation
; les valeurs (ordonnees) varient de 0 a 10
; elles pourront etre eventuellement sauvegardees
; avec le personnage.
cons_faim::  
             .DC.w 0,0,0,0,0,0,0,0,0,0
             .DC.w 0,0,2,4,6,10,8,2,0,0
             .DC.w 0,0,0,0,0,0,0,0,0,0
             .DC.w 0,0,0,2,3,4,5,6,4,2
             .DC.w 0,0,0,0,0,0,0,0,0,0
cons_soif::  
             .DC.w 0,0,2,4,6,10,8,2,0,0
             .DC.w 0,0,0,0,0,0,0,0,0,0
             .DC.w 0,0,0,2,3,4,5,6,6,7
             .DC.w 7,7,8,8,8,8,8,9,9,9
             .DC.w 9,9,10,10,10,9,8,7,6,5
cons_fati::  
             .DC.w 0,0,0,2,3,4,5,6,4,2
             .DC.w 0,0,2,4,6,10,10,8,8,6
             .DC.w 6,4,4,4,3,3,3,2,2,2
             .DC.w 2,2,1,1,1,1,1,0,0,0
             .DC.w 0,0,0,0,0,0,0,0,0,0
; temperature du joueur (°celsius)
temperature::          
             .DC.w 37
; pressions
pression::   
             .DC.w 12,9
; valeurs pour le cardiogramme
;         0 = arret cardiaque
;         2 =  60 pulsations / mn
;         4 = 120      ,,
;         6 = 180      ,,
;         etc...
vitcardinit::          
             .DC.w 4




; ne pas changer l'ordre des 2 variables suivantes !!

listegroupe::          .DC.w $8000+21,-1,-1,-1,-1 ;+2^15=acteur -1=personne
missiongroupe::        
             .REPT 5
             .DC.w 0,0,0
             .ENDR 



vblmitar::   .DC.l 0
tarene::     .DC.w 0
popu::       .DC.w 50

vblkoshan::  .DC.l 0

gain_qua::   .DC.w 0
gain_tubu::  .DC.w 0
gainchidam:: .DC.w 0

scenario::   .DC.l 0,0,0,0

configdata:: 
             .DC.w 0,0,0                    ;sons
             .DC.l cfgtx1

             .DC.w 1
sonon::      .DC.w -1,10                    ;on
             .DC.l cfgtx2
             .DC.w 1,0,10                   ;off
             .DC.l cfgtx3

             .DC.w 2
cfsmv16::    .DC.w -1,1
             .DC.l cfgtx4
             .DC.w 2
cfsmon::     .DC.w 0,1
             .DC.l cfgtx5

             .DC.w 4,0,0                    ;combats
             .DC.l cfgtx6

             .DC.w 5
cfcbta::     .DC.w -1,2
             .DC.l cfgtx7
             .DC.w 5
cfcbts::     .DC.w 0,2
             .DC.l cfgtx8

             .DC.w 7,0,0                    ;quattro
             .DC.l cfgtx9

             .DC.w 8
cfqx::       .DC.w -1,3
             .DC.l cfgtx10
             .DC.w 8
cfqxy::      .DC.w 0,3
             .DC.l cfgtx11

             .DC.w -1  ;fin de la liste


             .IF 0
             .DC.w 10,0,0                   ;simulateurs
             .DC.l cfgtx12

             .DC.w 11,-1,4
             .DC.l cfgtx13
             .DC.w 11,0,4
             .DC.l cfgtx14

             .DC.w 12,-1,-1
             .DC.l cfgtx15

             .DC.w 14,0,0                   ;claviers
             .DC.l cfgtx16

             .DC.w 15,-1,5
             .DC.l cfgtx17
             .DC.w 15,0,5
             .DC.l cfgtx18
             .DC.w 15,0,5
             .DC.l cfgtx19

             .DC.w -1  ;fin de la liste
             .ENDIF 

marchand::   
             .DC.b "ACCUEIL   ",0           ;RECEPTION MANTOUE
             .DC.b 80  ;potvie
             .DC.b 50,60,30,40,50,60
             .DC.w 965+0,128                ;stock,chambre
             .DC.l stck5000
             .DC.l $00003302                ;code genetique
             .DC.b 0,150                    ;metier,love ???
             .DC.l %00110011010110011110111110101100        ;savoir
             .DC.l %11011110101010111011100011101001        ;savoir
             .DC.l %01010101110111011011011111010101        ;savoir
             .DC.l %10111011101101100011101111111101        ;savoir
             .DC.l %01010111011011101011111100101101        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0   ;marvbl

             .DC.b "GARDE     ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 90,70,75,80,75,60
             .DC.w 965+1,0                  ;stock, ???
             .DC.l stck5001
             .DC.l $00002045                ;code genetique
             .DC.b 1,128                    ;???,love ???
             .DC.l %00111001110011001011100001100000        ;savoir
             .DC.l %01100110011110111000111100110101        ;savoir
             .DC.l %10100111100110001111001111000111        ;savoir
             .DC.l %00011001100001110010110011100101        ;savoir
             .DC.l %10110011001000111100101100011100        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "ACCUEIL   ",0           ;RECEPTION PAS LIBRE
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+2,0                  ;stock, ???
             .DC.l stck5002
             .DC.l $00005231                ;code genetique
             .DC.b 0,128                    ;???,love ???
             .DC.l %00000001110111100011101111001101        ;savoir
             .DC.l %11111100000000111111000011100111        ;savoir
             .DC.l %11000111100011110011100110011100        ;savoir
             .DC.l %11111000110111000000011100111100        ;savoir
             .DC.l %00000000011011000111100111100111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "ACCUEIL   ",0           ;RECEPTION S5
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+3,503                ;stock,chambre
             .DC.l stck5003
             .DC.l $00010002                ;code genetique
             .DC.b 0,128                    ;???,love ???
             .DC.l %10000001111100011100110011010001        ;savoir
             .DC.l %11001111100111001110011100100111        ;savoir
             .DC.l %00011101111001111001111000110011        ;savoir
             .DC.l %11001110001110011111000001110011        ;savoir
             .DC.l %11100011000111000110001100111000        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;BAR 103
             .DC.b 80  ;potvie
             .DC.b 50,60,50,50,55,50
             .DC.w 965+4,0                  ;stock, ???
             .DC.l stck5004
             .DC.l $00001424                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00000000111000111100001111000000        ;savoir
             .DC.l %00001111001110011100111100111001        ;savoir
             .DC.l %00111000111001100011100011000011        ;savoir
             .DC.l %11100111001110000110011100011001        ;savoir
             .DC.l %00001100111001100011110001100001        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;BAR 111
             .DC.b 80  ;potvie
             .DC.b 70,30,50,50,50,50
             .DC.w 965+5,0                  ;stock, ???
             .DC.l stck5005
             .DC.l $00002333                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00000110110001111011100011111000        ;savoir
             .DC.l %11000111100011110001111000111001        ;savoir
             .DC.l %11100001111001110011011100001111        ;savoir
             .DC.l %11011100011101110000110111101101        ;savoir
             .DC.l %11001111100011000111001110000111        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;BAR 133
             .DC.b 80  ;potvie
             .DC.b 50,70,50,50,60,50
             .DC.w 965+6,0                  ;stock, ???
             .DC.l stck5006
             .DC.l $00000112                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %10001111110000011100111000110011        ;savoir
             .DC.l %11011100111100111100111001110001        ;savoir
             .DC.l %00011111111001111100111110001110        ;savoir
             .DC.l %11111100110011100111100011100111        ;savoir
             .DC.l %10011101111100111111001100001110        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BOGLI     ",0           ;bogli
             .DC.b 80  ;potvie
             .DC.b 0,100,0,0,100,0
             .DC.w 965+7,0                  ;stock, ???
             .DC.l stck5007
             .DC.l $00000000                ;code genetique
             .DC.b 8,128                    ;???,love ???
             .DC.l %00100110100001110001100011100111        ;savoir
             .DC.l %11000111100111111000111001110001        ;savoir
             .DC.l %00011111000111011110111111011101        ;savoir
             .DC.l %11110011001101110011110001100100        ;savoir
             .DC.l %10011100111001100011111001100101        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "HOTESSE   ",0           ;AGENCE DE VOYAGE
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,60,50
             .DC.w 965+8,0                  ;stock, ???
             .DC.l stck5008
             .DC.l $00101203                ;code genetique
             .DC.b 2,150                    ;???,love ???
             .DC.l %00110110111000111011101101101010        ;savoir
             .DC.l %00111000111001110011100001100101        ;savoir
             .DC.l %00001001101101101101110111011011        ;savoir
             .DC.l %11001101111000111000111000110000        ;savoir
             .DC.l %00110011000111001110001110011001        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "PHARMACIEN",0           ; PHARMACIE S1
             .DC.b 80  ;potvie
             .DC.b 50,90,50,50,60,50
             .DC.w 965+9,0                  ;stock, ???
             .DC.l stck5009
             .DC.l $00002222                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00011111000111100011110011001111        ;savoir
             .DC.l %11110001111110001110011111100011        ;savoir
             .DC.l %10011110001111000111000111000101        ;savoir
             .DC.l %00110011111001111100011001010011        ;savoir
             .DC.l %00011000110001100010000100001100        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "VENDEUR   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,15,50
             .DC.w 965+10,0                 ;stock, ???
             .DC.l stck5010
             .DC.l $00033133                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00011100010010001101100111001010        ;savoir
             .DC.l %00011001100111000011110011100110        ;savoir
             .DC.l %00001110001100111001100110010011        ;savoir
             .DC.l %00001100011001100100010011001000        ;savoir
             .DC.l %10000110110011100111001110000110        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;S5 505
             .DC.b 80  ;potvie
             .DC.b 50,30,50,50,30,50
             .DC.w 965+11,0                 ;stock, ???
             .DC.l stck5011
             .DC.l $00022415                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %11100011001110001111100111001100        ;savoir
             .DC.l %00111001100111100111001110011010        ;savoir
             .DC.l %11001100110011011001100100110110        ;savoir
             .DC.l %00101100110011011000011001110011        ;savoir
             .DC.l %00011001101001100101100110110011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "EPICIER   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,80,50
             .DC.w 965+12,0                 ;stock, ???
             .DC.l stck5012
             .DC.l $00011211                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00001110011001001110011100101101        ;savoir
             .DC.l %11000111100111011011001100110011        ;savoir
             .DC.l %10011100110011100111001110011010        ;savoir
             .DC.l %00111001100110110011100110110110        ;savoir
             .DC.l %01101011011000110011100110100110        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "LE SENEX  ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 60,80,40,40,60,20
             .DC.w 965+13,0                 ;stock, ???
             .DC.l stck5013
             .DC.l $00000442                ;code genetique
             .DC.b 3,100                    ;???,love ???

             .DC.l %01101110110111011011011101101101        ;savoir
             .DC.l %00000000000000000000000000100000        ;26
             .DC.l %00110101001101101101001100110111        ;savoir
             .DC.l %01100111010101100111001100110110        ;savoir
             .DC.l %00011001101101101101101101101101        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;213
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,40,50
             .DC.w 965+14,0                 ;stock, ???
             .DC.l stck5014
             .DC.l $00022323                ;code genetique
             .DC.b 2,128                    ;???,love ???

             .DC.l %01011100111100111111001111110110        ;savoir
             .DC.l %11111001111111110011011101110011        ;savoir
             .DC.l %10011001110011110011101100111011        ;savoir
             .DC.l %11001110011110011111011011101101        ;savoir
             .DC.l %10110101101100110011110001100110        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "ARMURIER  ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,35,50,50,95,50
             .DC.w 965+15,0                 ;stock, ???
             .DC.l stck5015
             .DC.l $00004114                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %01100111001110011011001100110011        ;savoir
             .DC.l %10110010111011011101101110110111        ;savoir
             .DC.l %00101101101110001100001100001011        ;savoir
             .DC.l %00111100101110111111100011100111        ;savoir
             .DC.l %10001110011101110011001100110011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "MASSIGLIA ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 40,90,30,40,30,70
             .DC.w 965+16,0                 ;stock, ???
             .DC.l stck5016
             .DC.l $00005335                ;code genetique
             .DC.b 4,80                     ;???,love ???
             .DC.l %00111001100110011001100110001011        ;savoir
             .DC.l %11001100110101101100110000000101        ;bit 25=0 a partir de la gauche

             .DC.l %00011010110111010101110110111011        ;savoir
             .DC.l %00110011001101101101100110110100        ;savoir
             .DC.l %10011001101100110000110011001101        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "ACCUEIL   ",0           ;602
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+17,604               ;stock,chambre
             .DC.l stck5017
             .DC.l $00005012                ;code genetique
             .DC.b 0,128                    ;???,love ???
             .DC.l %00000111000110011100011001100111        ;savoir
             .DC.l %11001100111001100110011100110011        ;savoir
             .DC.l %01101100110011001110001100110011        ;savoir
             .DC.l %10110011001100011100111001100111        ;savoir
             .DC.l %00000111000111001101100011100011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "VENDEUR   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,60,50,50,50,50
             .DC.w 965+18,0                 ;stock, ???
             .DC.l stck5018
             .DC.l $00001132                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %10011100001100111001110011000111        ;savoir
             .DC.l %00110011001101100110011001100100        ;savoir
             .DC.l %00110011001000110011100110011001        ;savoir
             .DC.l %10011001100000110000110000110011        ;savoir
             .DC.l %00110001100010011100011000001001        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "VENDEUR   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,80,50,50,60,50
             .DC.w 965+19,0                 ;stock, ???
             .DC.l stck5019
             .DC.l $00021345                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %10011000100110011001100110010000        ;savoir
             .DC.l %00110011001100111001100111011001        ;savoir
             .DC.l %10110011000100110011001100110001        ;savoir
             .DC.l %00000000110011001111001110011001        ;savoir
             .DC.l %10011100110011000110001100110000        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "OPTICIEN  ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,70,50,50,90,50
             .DC.w 965+20,0                 ;stock, ???
             .DC.l stck5020
             .DC.l $00003241                ;code genetique
             .DC.b 9,128                    ;???,love ???
             .DC.l %00001100011100110011100011001100        ;savoir
             .DC.l %11011011001110001100111011001000        ;savoir
             .DC.l %00110011100011100011111001001000        ;savoir
             .DC.l %01110011001100110011001100101000        ;savoir
             .DC.l %10010010010100100111010101110011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "SYLVIA    ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 70,80,70,70,90,70
             .DC.w 965+21,0                 ;stock, ???
             .DC.l stck5021
             .DC.l $00104244                ;code genetique
             .DC.b 5,200                    ;???,love LEADER !!!!
             .DC.l %00011001100011001000110001001001        ;savoir
             .DC.l %10010010011000110001100110010011        ;savoir
             .DC.l %00010110001100110011001100101010        ;savoir
             .DC.l %00011001110011001100110100101110        ;savoir
             .DC.l %00110011001100110011001001100101        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,200
             .DC.l 0

             .DC.b "SECRETAIRE",0           ;SECRETAIRE MASSIGLIA
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+22,16                ;stock,patron
             .DC.l stck5022
             .DC.l $01104445                ;code genetique
             .DC.b 6,128                    ;???,love ???
             .DC.l %00111100111111111000111100111111        ;savoir
             .DC.l %11011101111100011111110011100011        ;savoir
             .DC.l %00110110001100111001110010011010        ;savoir
             .DC.l %01100111001001110001101010001011        ;savoir
             .DC.l %00010100110001100011001100101000        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "SECRETAIRE",0           ;SECRETAIRE JUGH
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+23,28                ;stock,patron?
             .DC.l stck5023
             .DC.l $00103201                ;code genetique
             .DC.b 6,128                    ;???,love ???
             .DC.l %00011001100001110011100110010011        ;savoir
             .DC.l %00110011001100110001100110011001        ;savoir
             .DC.l %10010011011010011000110011000110        ;savoir
             .DC.l %00110011001100111000011001100101        ;savoir
             .DC.l %11010100110011000110011001100101        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;BAR 516
             .DC.b 80  ;potvie
             .DC.b 50,30,50,50,40,50
             .DC.w 965+24,0                 ;stock, ???
             .DC.l stck5024
             .DC.l $00012231                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %01010011001001100011001100100111        ;savoir
             .DC.l %10110011001100110011100110001110        ;savoir
             .DC.l %00110010011001100001100111001101        ;savoir
             .DC.l %10100011000110011001101001100001        ;savoir
             .DC.l %00110010010011001100100011001000        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "BARMAN    ",0           ;408
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,60,50
             .DC.w 965+25,0                 ;stock, ???
             .DC.l stck5025
             .DC.l $01003443                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00100100100110011100110010011010        ;savoir
             .DC.l %00111001011001100001100011001010        ;savoir
             .DC.l %01101101100111001100110011001011        ;savoir
             .DC.l %10110011001110011001100110011001        ;savoir
             .DC.l %01100110011001100100100110010110        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "PHARMACIEN",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,80,50,50,60,50
             .DC.w 965+26,0                 ;stock, ???
             .DC.l stck5026
             .DC.l $01005004                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00100110011000110011100001100110        ;savoir
             .DC.l %01100110110110011000110011011000        ;savoir
             .DC.l %10011001100011001100100110010011        ;savoir
             .DC.l %00110011100111000110100100111000        ;savoir
             .DC.l %00110011100110011011000110011001        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "VENDEUSE  ",0           ;123
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,40,50
             .DC.w 965+27,0                 ;stock, ???
             .DC.l stck5027
             .DC.l $00105422                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00100110011001100110011000010011        ;savoir
             .DC.l %00110010011001100110011001100111        ;savoir
             .DC.l %01100110001101100100110011001001        ;savoir
             .DC.l %10100100110010011001001100110010        ;savoir
             .DC.l %00110011000110001000110110101110        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "JUGH'AHIH ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,90,50,50,50,80
             .DC.w 965+28,0                 ;stock, ???
             .DC.l stck5028
             .DC.l $01004222                ;code genetique
             .DC.b 7,128                    ;???,love ???
             .DC.l %00110001100110011110111101110111        ;savoir
             .DC.l %00011011101001111011110111110111        ;savoir
             .DC.l %01100111011110110111001110011001        ;savoir
             .DC.l %01011000110001100110001100011001        ;savoir
             .DC.l %10110111011101110110111011011110        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "CAMELOT   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,60,50,50,60,50
             .DC.w 965+29,0                 ;stock, ???
             .DC.l stck5029
             .DC.l $01001335                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %01110001110000001100111000011111        ;savoir
             .DC.l %11011100111100111000011111100011        ;savoir
             .DC.l %11101111111000011111111000111111        ;savoir
             .DC.l %01111110001111111100011111000111        ;savoir
             .DC.l %00001111111000011111111111100011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "CAMELOT   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,60,50,50,60,50
             .DC.w 965+30,0                 ;stock, ???
             .DC.l stck5030
             .DC.l $01002111                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00000011111000000011110000000111        ;savoir
             .DC.l %00000111000000011100000011100011        ;savoir
             .DC.l %10001111100001111000011100000001        ;savoir
             .DC.l %00011100000011110011111001111000        ;savoir
             .DC.l %01111000011111100111101111111111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "CAMELOT   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,60,50,50,60,50
             .DC.w 965+31,0                 ;stock, ???
             .DC.l stck5031
             .DC.l $01005245                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00111001111110000111111000110111        ;savoir
             .DC.l %00001111000111111110011111111011        ;savoir
             .DC.l %00111111111100111111110001111111        ;savoir
             .DC.l %00011111100011111100001110000111        ;savoir
             .DC.l %11000011110000000111111000000111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "CAMELOT   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+32,0                 ;stock, ???
             .DC.l stck5032
             .DC.l $00003222                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00000111110000001111100000011111        ;savoir
             .DC.l %11000000111110000011111000001111        ;savoir
             .DC.l %00001111110001111111001110011100        ;savoir
             .DC.l %00110011100000111000111000110011        ;savoir
             .DC.l %00011100111000111000001110001100        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "J.YEKADINE",0           ;NEANT ST
             .DC.b 80  ;potvie
             .DC.b 30,30,30,30,30,30
             .DC.w 965+33,0                 ;stock, ???
             .DC.l stck5033
             .DC.l $00011220                ;code genetique
             .DC.b 10,128                   ;???,love ???
             .DC.l %00000000111111100011111100111111        ;savoir
             .DC.l %11111100000001111111000000111111        ;savoir
             .DC.l %11000000000111111111111111000011        ;savoir
             .DC.l %11111111111100000000000000011111        ;savoir
             .DC.l %11100000000000000011111111111111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "          ",0           ;NEANT ST
             .DC.b 80  ;potvie
             .DC.b 0,100,0,0,100,0
             .DC.w 965+34,0                 ;stock, ???
             .DC.l stck5034
             .DC.l $00000000                ;code genetique
             .DC.b 0,128                    ;???,love ???
             .DC.l %11111111111111111111111111111111        ;savoir
             .DC.l %11111111111111111111111111111111        ;savoir
             .DC.l %11111111111111111111111111111111        ;savoir
             .DC.l %11111111111111111111111111111111        ;savoir
             .DC.l %11111111111111111111111111111111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "MARCHAND  ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,60,50
             .DC.w 965+35,0                 ;stock, ???
             .DC.l stck5035
             .DC.l $00004031                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %11000011111100000001111000000111        ;savoir
             .DC.l %00001110001111000111100011100001        ;savoir
             .DC.l %10000011111000000111110000011000        ;savoir
             .DC.l %11000001111111000011111001111000        ;savoir
             .DC.l %00000001111000111000011100011111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "SERVEUR   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,25,50,50,30,50
             .DC.w 965+36,0                 ;stock, ???
             .DC.l stck5036
             .DC.l $00003412                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %11100011000111000001111110000111        ;savoir
             .DC.l %00111110001111000111100001111111        ;savoir
             .DC.l %00000000000000011111111111111111        ;savoir
             .DC.l %11000001111100000011110001110000        ;savoir
             .DC.l %00000001111111100011111110000111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "SERVEUR   ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,40,50,50,45,50
             .DC.w 965+37,0                 ;stock, ???
             .DC.l stck5037
             .DC.l $00004125                ;code genetique
             .DC.b 2,128                    ;???,love ???
             .DC.l %00111110000000111111000000000111        ;savoir
             .DC.l %11110000011111110000001111111000        ;savoir
             .DC.l %00000011111000000111111110000111        ;savoir
             .DC.l %11110000111111100000000000011111        ;savoir
             .DC.l %00000011111100000111111100001111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "PIZZAIOLO ",0           ;nom
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+38,0                 ;stock, ???
             .DC.l stck5038
             .DC.l $00000312                ;code genetique
             .DC.b 2,128                    ;???,love ???

             .DC.l %11001110001100011100011001100001        ;savoir
             .DC.l %00000000000000000000000010000000        ;24
             .DC.l %11000111000110011001110001100011        ;savoir
             .DC.l %00001111100011100011100011100001        ;savoir
             .DC.l %11000111000111100111001111000100        ;160 phrase max

             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

;acteurs speciaux/cas des jumeaux

             .DC.b "          ",0           ;bidon SENEX 1
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+38,0                 ;stock, ???
             .DC.l stck5038
             .DC.l $01002225                ;code genetique
             .DC.b 11,128                   ;metier 11=chomeur,love ???
             .DC.l %00000111000011100011100011000111        ;savoir
             .DC.l %11000110001110001110000111000111        ;savoir
             .DC.l %00001110000111000111000111100110        ;savoir
             .DC.l %11100111001110011100111110011110        ;savoir
             .DC.l %10011100111001100110001100111100        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "          ",0           ;bidon SENEX 2
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+38,0                 ;stock, ???
             .DC.l stck5038
             .DC.l $01005441                ;code genetique
             .DC.b 11,128                   ;metier 11=chomeur,love ???
             .DC.l %00000000000000000011111111111111        ;savoir
             .DC.l %11111111111111100000000000000000        ;savoir
             .DC.l %00011111100011111000011110011111        ;savoir
             .DC.l %11000111000111001111111001110000        ;savoir
             .DC.l %11110001111100011100111110000011        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "          ",0           ;bidon WELCO 1
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+38,0                 ;stock, ???
             .DC.l stck5038
             .DC.l $00001244                ;code genetique
             .DC.b 11,128                   ;metier 11=chomeur,love ???
             .DC.l %00011111100011111100001110000000        ;savoir
             .DC.l %11100000111111000011111000001111        ;savoir
             .DC.l %11111110000111111110000000111111        ;savoir
             .DC.l %11100000000111110000111111100000        ;savoir
             .DC.l %11111000000001111111100011100000        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0

             .DC.b "          ",0           ;bidon WELCO 2
             .DC.b 80  ;potvie
             .DC.b 50,50,50,50,50,50
             .DC.w 965+38,0                 ;stock, ???
             .DC.l stck5038
             .DC.l $00002143                ;code genetique
             .DC.b 11,128                   ;metier 11=chomeur,love ???
             .DC.l %00000000111110000000001111000111        ;savoir
             .DC.l %00000111111000011111100001111100        ;savoir
             .DC.l %00000000011111111111111100000000        ;savoir
             .DC.l %11111111100000000000000111111111        ;savoir
             .DC.l %11110000111111111111111000000111        ;160 phrase max
             .DC.l 0
             .DC.b 0,0,0,128
             .DC.l 0


             .DC.w -1  ;fin

objstruct::  
;0
;verrecod
             .DC.w 9998,42
             .DC.w 0,0
;1
;papierma                  papiers massiglia->chemise massiglia
             .REPT 10
             .DC.w 831,104
             .DC.w 0,0
             .ENDR 
;11
;journal
             .REPT 10
             .DC.w 9999,44
             .DC.w 0,0
             .ENDR 
;21
;livremem
             .DC.w 2000+410,18              ;dans lieu 410
             .DC.w 0,0
;22
;fc_pret
             .DC.w 3010,28
             .DC.w 0,0
             .DC.w 3020,28
             .DC.w 0,0
             .REPT 3
             .DC.w 9999,28
             .DC.w 0,0
             .ENDR 
;27
;cp_agam
             .DC.w 32,99
             .DC.w 0,0
;28
;cp_siriu
             .DC.w 33,98
             .DC.w 0,0
;29
;cp_bonum
             .DC.w 34,97
             .DC.w 0,0
;30
;cp_adelia
             .DC.w 35,96
             .DC.w 0,0
;31
;cp_kubit
             .DC.w 36,100
             .DC.w 0,0
;32
;vetpret
             .DC.w 2000+629,0
             .DC.w 0,0
             .DC.w 2000+629,0
             .DC.w 0,0
             .DC.w 2000+629,0
             .DC.w 0,0
             .DC.w 2000+629,0
             .DC.w 0,0
             .DC.w 2000+629,0
             .DC.w 0,0

             .DC.w 3030,0
             .DC.w 0,0
             .DC.w 3040,0
             .DC.w 0,0
             .REPT 3
             .DC.w 9999,0
             .DC.w 0,0
             .ENDR 
;42
;sdouleu
             .DC.w 5033,22                  ;dans le stock de Jos Yekadine
             .DC.w 0,0
;43
;ctueur
             .DC.w 9998,43
             .DC.w 0,0
;44
;main_d
             .DC.w 47,37
             .DC.w 0,0
;45
;main_g
             .DC.w 47,38
             .DC.w 0,0
;46
;bob
             .DC.w 47,45
             .DC.w 0,0
;47
;corps
             .DC.w 4000,36
             .DC.w 0,0

;48
;voktraso
             .DC.w 3100,46
             .DC.w 80,100
             .DC.w 3110,46
             .DC.w 80,100
             .DC.w 3120,46
             .DC.w 80,100
             .DC.w 3130,46
             .DC.w 80,100
             .DC.w 3140,46
             .DC.w 80,100

             .REPT 5
             .DC.w 9999,46
             .DC.w 80,100
             .ENDR 


;58
;beckmann
             .DC.w 3202,47
             .DC.w 100,1000
             .DC.w 3203,47
             .DC.w 100,1000

             .REPT 3
             .DC.w 9999,47
             .DC.w 100,1000
             .ENDR 
;63
;haas10
             .DC.w 3201,48
             .DC.w 130,1000

             .DC.w 3123,48
             .DC.w 130,1000
             .DC.w 3111,48
             .DC.w 130,1000

             .REPT 2
             .DC.w 9999,48
             .DC.w 130,1000
             .ENDR 
;68
;gladius
             .REPT 3
             .DC.w 9999,49
             .DC.w 70,500
             .ENDR 

;71
;pilumlas
             .DC.w 3000,50
             .DC.w 180,10000
             .DC.w 3002,50
             .DC.w 180,10000
             .DC.w 3004,50
             .DC.w 180,10000
             .DC.w 3006,50
             .DC.w 180,10000
             .DC.w 3008,50
             .DC.w 180,10000
             .DC.w 3010,50
             .DC.w 180,10000
             .DC.w 3012,50
             .DC.w 180,10000
             .DC.w 3014,50
             .DC.w 180,10000
             .DC.w 3016,50
             .DC.w 180,10000
             .DC.w 3018,50
             .DC.w 180,10000

;81
;asoa50
             .DC.w 3001,51
             .DC.w 250,200
             .DC.w 3003,51
             .DC.w 250,200
             .DC.w 3005,51
             .DC.w 250,200
             .DC.w 3007,51
             .DC.w 250,200
             .DC.w 3009,51
             .DC.w 250,200
             .DC.w 3011,51
             .DC.w 250,200
             .DC.w 3013,51
             .DC.w 250,200
             .DC.w 3015,51
             .DC.w 250,200
             .DC.w 3017,51
             .DC.w 250,200
             .DC.w 3019,51
             .DC.w 250,200
;91
;plasma
             .DC.w 751,52
             .DC.w 90,20000
;plasma
             .DC.w 9999,52
             .DC.w 90,20000
;93
;laskolt
             .DC.w 3200,53
             .DC.w 140,10000
             .REPT 2
             .DC.w 9999,53
             .DC.w 140,10000
             .ENDR 
;96
;hasta2
             .REPT 2
             .DC.w 9999,54
             .DC.w 220,10000
             .ENDR 
;98
;hasta1
             .REPT 3
             .DC.w 9999,55
             .DC.w 110,5000
             .ENDR 
;101
;lp12
             .DC.w 48,56
             .DC.w 4,10
             .DC.w 49,56
             .DC.w 4,10
             .DC.w 50,56
             .DC.w 4,10
             .DC.w 51,56
             .DC.w 4,10
             .DC.w 52,56
             .DC.w 4,10
             .DC.w 53,56
             .DC.w 4,10
             .DC.w 54,56
             .DC.w 4,10
             .DC.w 55,56
             .DC.w 4,10
             .DC.w 56,56
             .DC.w 4,10
             .DC.w 57,56
             .DC.w 4,10

             .DC.w 3199,56
             .DC.w 4,10
             .DC.w 3199,56
             .DC.w 4,10
             .DC.w 3199,56
             .DC.w 4,10
             .DC.w 3055,56
             .DC.w 4,10
             .DC.w 3056,56
             .DC.w 4,10

             .REPT 5
             .DC.w 9999,56
             .DC.w 4,10
             .ENDR 
;121
;lp57
             .DC.w 58,57
             .DC.w 5,25
             .DC.w 59,57
             .DC.w 5,25
             .DC.w 60,57
             .DC.w 5,25
             .DC.w 61,57
             .DC.w 5,25
             .DC.w 62,57
             .DC.w 5,25

             .REPT 5
             .DC.w 9999,57
             .DC.w 5,25
             .ENDR 
;131
;n29
             .DC.w 63,58
             .DC.w 5,5
             .DC.w 64,58
             .DC.w 5,5
             .DC.w 65,58
             .DC.w 5,5
             .DC.w 66,58
             .DC.w 5,5
             .DC.w 67,58
             .DC.w 5,5

             .REPT 5
             .DC.w 9999,58
             .DC.w 5,5
             .ENDR 
;141
;lp02
             .DC.w 68,59
             .DC.w 3,20
             .DC.w 69,59
             .DC.w 3,20
             .DC.w 70,59
             .DC.w 3,20
             .REPT 3
             .DC.w 9999,59
             .DC.w 3,20
             .ENDR 
;147
;lp110
             .DC.w 71,60
             .DC.w 8,100
             .DC.w 72,60
             .DC.w 8,100
             .DC.w 73,60
             .DC.w 8,100
             .DC.w 74,60
             .DC.w 8,100
             .DC.w 75,60
             .DC.w 8,100
             .DC.w 76,60
             .DC.w 8,100
             .DC.w 77,60
             .DC.w 8,100
             .DC.w 78,60
             .DC.w 8,100
             .DC.w 79,60
             .DC.w 8,100
             .DC.w 80,60
             .DC.w 8,100

             .DC.w 3122,60
             .DC.w 8,100
             .DC.w 3022,60
             .DC.w 8,100
             .DC.w 3044,60
             .DC.w 8,100
             .DC.w 3088,60
             .DC.w 8,100
             .DC.w 3121,60
             .DC.w 8,100

             .REPT 5
             .DC.w 9999,60
             .DC.w 8,100
             .ENDR 
;167
;fillum12
             .DC.w 81,61
             .DC.w 9,85
             .DC.w 82,61
             .DC.w 9,85
             .DC.w 83,61
             .DC.w 9,85
             .DC.w 84,61
             .DC.w 9,85
             .DC.w 85,61
             .DC.w 9,85
             .DC.w 86,61
             .DC.w 9,85
             .DC.w 87,61
             .DC.w 9,85
             .DC.w 88,61
             .DC.w 9,85
             .DC.w 89,61
             .DC.w 9,85
             .DC.w 90,61
             .DC.w 9,85

             .DC.w 3188,61
             .DC.w 9,85
             .DC.w 3033,61
             .DC.w 9,85
             .DC.w 3017,61
             .DC.w 9,85
             .DC.w 3117,61
             .DC.w 9,85
             .DC.w 3147,61
             .DC.w 9,85

             .REPT 5
             .DC.w 9999,61
             .DC.w 9,85
             .ENDR 
;187
;plas1
             .DC.w 91,62
             .DC.w 9,50
             .DC.w 92,62
             .DC.w 9,50

             .REPT 2
             .DC.w 9999,62
             .DC.w 9,50
             .ENDR 
;191
;lp45
             .DC.w 93,63
             .DC.w 6,20
             .DC.w 94,63
             .DC.w 6,20
             .DC.w 95,63
             .DC.w 6,20

             .REPT 3
             .DC.w 9999,63
             .DC.w 6,20
             .ENDR 
;197
;k2
             .DC.w 96,64
             .DC.w 7,100
             .DC.w 97,64
             .DC.w 7,100

             .REPT 2
             .DC.w 9999,64
             .DC.w 7,100
             .ENDR 
;201
;k1
             .DC.w 98,65
             .DC.w 5,50
             .DC.w 99,65
             .DC.w 5,50
             .DC.w 100,65
             .DC.w 5,50

             .REPT 3
             .DC.w 9999,65
             .DC.w 5,50
             .ENDR 
;207
;chf9
             .DC.w 3000,103
             .DC.w 9,0
             .DC.w 3001,103
             .DC.w 9,0
             .DC.w 3002,103
             .DC.w 9,0
             .DC.w 3003,103
             .DC.w 9,0
             .DC.w 3004,103
             .DC.w 9,0
             .DC.w 3005,103
             .DC.w 9,0
             .DC.w 3006,103
             .DC.w 9,0
             .DC.w 3007,103
             .DC.w 9,0
             .DC.w 3008,103
             .DC.w 9,0
             .DC.w 3009,103
             .DC.w 9,0
             .DC.w 3010,103
             .DC.w 9,0
             .DC.w 3011,103
             .DC.w 9,0
             .DC.w 3012,103
             .DC.w 9,0
             .DC.w 3013,103
             .DC.w 9,0
             .DC.w 3014,103
             .DC.w 9,0
             .DC.w 3015,103
             .DC.w 9,0
             .DC.w 3016,103
             .DC.w 9,0
             .DC.w 3017,103
             .DC.w 9,0
             .DC.w 3018,103
             .DC.w 9,0
             .DC.w 3019,103
             .DC.w 9,0

             .REPT 5
             .DC.w 9999,103
             .DC.w 9,0
             .ENDR 
;232
;chf8
             .DC.w 3089,102
             .DC.w 8,0
             .DC.w 3177,102
             .DC.w 8,0
             .DC.w 3024,102
             .DC.w 8,0
             .DC.w 3166,102
             .DC.w 8,0
             .DC.w 3030,102
             .DC.w 8,0


             .REPT 5
             .DC.w 9999,102
             .DC.w 8,0
             .ENDR 
;242
;chf6
             .DC.w 3202,66
             .DC.w 6,0
             .DC.w 3203,66
             .DC.w 6,0

             .DC.w 3113,66
             .DC.w 6,0
             .DC.w 3046,66
             .DC.w 6,0
             .DC.w 3119,66
             .DC.w 6,0
             .DC.w 3063,66
             .DC.w 6,0
             .DC.w 3190,66
             .DC.w 6,0
             .DC.w 3099,66
             .DC.w 6,0
             .DC.w 3125,66
             .DC.w 6,0
             .DC.w 3052,66
             .DC.w 6,0


             .REPT 5
             .DC.w 9999,66
             .DC.w 6,0
             .ENDR 
;257
;gilet1
             .DC.w 3201,67
             .DC.w 4,0

             .DC.w 3050,67
             .DC.w 4,0
             .DC.w 3198,67
             .DC.w 4,0

             .REPT 2
             .DC.w 9999,67
             .DC.w 4,0
             .ENDR 
;262
;gilet2
             .DC.w 3200,105
             .DC.w 5,0

             .DC.w 3197,105
             .DC.w 5,0

             .DC.w 9999,105
             .DC.w 5,0

;265
;casqued
             .DC.w 3087,68
             .DC.w 4,0
             .DC.w 3028,68
             .DC.w 4,0
             .DC.w 3032,68
             .DC.w 4,0
             .DC.w 3103,68
             .DC.w 4,0
             .DC.w 3104,68
             .DC.w 4,0
             .DC.w 3105,68
             .DC.w 4,0
             .DC.w 3106,68
             .DC.w 4,0
             .DC.w 3107,68
             .DC.w 4,0
             .DC.w 3108,68
             .DC.w 4,0
             .DC.w 3109,68
             .DC.w 4,0
             .DC.w 3110,68
             .DC.w 4,0
             .DC.w 3111,68
             .DC.w 4,0
             .DC.w 3112,68
             .DC.w 4,0
             .DC.w 3113,68
             .DC.w 4,0
             .DC.w 3114,68
             .DC.w 4,0
             .DC.w 3115,68
             .DC.w 4,0
             .DC.w 3116,68
             .DC.w 4,0
             .DC.w 3117,68
             .DC.w 4,0
             .DC.w 3118,68
             .DC.w 4,0
             .DC.w 3119,68
             .DC.w 4,0

             .REPT 5
             .DC.w 9999,68
             .DC.w 4,0
             .ENDR 
;290
;coudiere
             .DC.w 3020,69
             .DC.w 3,0
             .DC.w 3030,69
             .DC.w 3,0


             .REPT 3
             .DC.w 9999,69
             .DC.w 3,0
             .ENDR 
;295
;cuissard
             .DC.w 3031,70
             .DC.w 2,0
             .DC.w 3032,70
             .DC.w 2,0
             .DC.w 3033,70
             .DC.w 2,0

             .REPT 2
             .DC.w 9999,70
             .DC.w 2,0
             .ENDR 
;300
;cuirasse
             .DC.w 3034,71
             .DC.w 7,0
             .DC.w 3035,71
             .DC.w 7,0
             .DC.w 3036,71
             .DC.w 7,0

             .REPT 2
             .DC.w 9999,71
             .DC.w 7,0
             .ENDR 
;305
;scutum
             .REPT 2
             .DC.w 9999,72
             .DC.w 9,0
             .ENDR 
;307
;as
             .DC.w 3037,26
             .DC.w 0,0
             .DC.w 3038,26
             .DC.w 0,0
             .DC.w 3039,26
             .DC.w 0,0
             .DC.w 3040,26
             .DC.w 0,0
             .DC.w 3041,26
             .DC.w 0,0
             .DC.w 3042,26
             .DC.w 0,0
             .DC.w 3043,26
             .DC.w 0,0
             .DC.w 3044,26
             .DC.w 0,0
             .DC.w 3045,26
             .DC.w 0,0
             .DC.w 3046,26
             .DC.w 0,0

             .REPT 90
             .DC.w 9999,26
             .DC.w 0,0
             .ENDR 
;407
;nummus
             .DC.w 3047,92
             .DC.w 0,0
             .DC.w 3048,92
             .DC.w 0,0
             .DC.w 3049,92
             .DC.w 0,0
             .DC.w 3050,92
             .DC.w 0,0
             .DC.w 3051,92
             .DC.w 0,0
             .DC.w 3051,92
             .DC.w 0,0
             .DC.w 3052,92
             .DC.w 0,0
             .DC.w 3053,92
             .DC.w 0,0
             .DC.w 3054,92
             .DC.w 0,0
             .DC.w 3055,92
             .DC.w 0,0

             .REPT 40
             .DC.w 9999,92
             .DC.w 0,0
             .ENDR 
;457
;denarius
             .DC.w 3055,93
             .DC.w 0,0
             .DC.w 3056,93
             .DC.w 0,0
             .DC.w 3057,93
             .DC.w 0,0
             .DC.w 3058,93
             .DC.w 0,0
             .DC.w 3059,93
             .DC.w 0,0

             .REPT 20
             .DC.w 9999,93
             .DC.w 0,0
             .ENDR 
;482
;aureus
             .DC.w 3060,87
             .DC.w 0,0
             .DC.w 3061,87
             .DC.w 0,0

             .REPT 8
             .DC.w 9999,87
             .DC.w 0,0
             .ENDR 
;492
;antiop
             .DC.w 801,73
             .DC.w 1500,0
             .REPT 4
             .DC.w 9999,73
             .DC.w 1500,0
             .ENDR 
;497
;crepe
             .DC.w 801,74
             .DC.w 600,0

             .DC.w 802,74
             .DC.w 600,0
             .DC.w 802,74
             .DC.w 600,0
             .DC.w 803,74
             .DC.w 600,0
             .DC.w 804,74
             .DC.w 600,0


             .REPT 5
             .DC.w 9999,74
             .DC.w 600,0
             .ENDR 
;507
;painroug
             .DC.w 801,75
             .DC.w 200,0

             .REPT 9
             .DC.w 9997,75
             .DC.w 2000,0
             .ENDR 
;517
;vespe
             .DC.w 806,77
             .DC.w 320,0
             .DC.w 807,77
             .DC.w 320,0
             .DC.w 808,77
             .DC.w 320,0

             .REPT 2
             .DC.w 9999,77
             .DC.w 320,0
             .ENDR 
;522
;azmani
             .DC.w 809,78
             .DC.w 1000,0
             .DC.w 810,78
             .DC.w 1000,0
             .DC.w 811,78
             .DC.w 1000,0

             .REPT 2
             .DC.w 9999,78
             .DC.w 1000,0
             .ENDR 
;552
;frites
             .DC.w 800,29
             .DC.w 480,0
             .DC.w 801,29
             .DC.w 480,0
             .DC.w 802,29
             .DC.w 480,0
             .DC.w 803,29
             .DC.w 480,0
             .DC.w 804,29
             .DC.w 480,0
             .DC.w 805,29
             .DC.w 480,0
             .DC.w 806,29
             .DC.w 480,0
             .DC.w 807,29
             .DC.w 480,0
             .DC.w 808,29
             .DC.w 480,0
             .DC.w 809,29
             .DC.w 480,0
             .DC.w 810,29
             .DC.w 480,0
             .DC.w 810,29
             .DC.w 480,0
             .DC.w 811,29
             .DC.w 480,0
             .DC.w 811,29
             .DC.w 480,0
             .DC.w 811,29
             .DC.w 480,0

             .REPT 15
             .DC.w 9999,29
             .DC.w 480,0
             .ENDR 
;567
;hamburge
             .DC.w 820,27
             .DC.w 1500,0
             .DC.w 821,27
             .DC.w 1500,0
             .DC.w 822,27
             .DC.w 1500,0
             .DC.w 823,27
             .DC.w 1500,0
             .DC.w 823,27
             .DC.w 1500,0

             .REPT 10
             .DC.w 9999,27
             .DC.w 1500,0
             .ENDR 
;572
;algue
             .REPT 5
             .DC.w 9999,5
             .DC.w 200,0
             .ENDR 
;577
;pizza
             .REPT 5
             .DC.w 9999,6
             .DC.w 100,0
             .ENDR 
;584
;salade
             .DC.w 3195,31
             .DC.w 70,0
             .REPT 6
             .DC.w 9999,31
             .DC.w 70,0
             .ENDR 
;594
;ppains
             .REPT 10
             .DC.w 9999,79
             .DC.w 50,0
             .ENDR 
;602
;galettes
             .REPT 8
             .DC.w 9999,80
             .DC.w 300,0
             .ENDR 
;607
;poisson
             .REPT 5
             .DC.w 9999,81
             .DC.w 80,0
             .ENDR 
;612
;saucisse
             .DC.w 507,76
             .DC.w 160,0
             .DC.w 508,76
             .DC.w 160,0
             .DC.w 509,76
             .DC.w 160,0
             .DC.w 510,76
             .DC.w 160,0
             .DC.w 511,76
             .DC.w 160,0
             .DC.w 512,76
             .DC.w 160,0
             .DC.w 513,76
             .DC.w 160,0
             .DC.w 514,76
             .DC.w 160,0
             .DC.w 515,76
             .DC.w 160,0
             .DC.w 516,76
             .DC.w 160,0

             .REPT 2
             .DC.w 9999,76
             .DC.w 160,0
             .ENDR 
;624
;gateau
             .REPT 4
             .DC.w 9999,83
             .DC.w 1900,0
             .ENDR 
;628
;vinfaler
             .REPT 8
             .DC.w 9999,39
             .DC.w 500,14
             .ENDR 
;636
;vinmassiq
             .REPT 8
             .DC.w 9999,34
             .DC.w 500,10
             .ENDR 
;644
;vincecub
             .REPT 8
             .DC.w 9999,25
             .DC.w 500,8
             .ENDR 
;652
;vinvert
             .REPT 8
             .DC.w 9999,3
             .DC.w 500,4
             .ENDR 
;660
;doubles
             .REPT 18
             .DC.w 9999,32
             .DC.w 30,16
             .ENDR 
;678
;merluz
             .REPT 10
             .DC.w 9999,101
             .DC.w 30,20
             .ENDR 
;688
;volcano
             .REPT 10
             .DC.w 9999,33
             .DC.w 30,28
             .ENDR 
;698
;cafe
             .REPT 10
             .DC.w 9999,95
             .DC.w 20,0
             .ENDR 
;708
;the
             .REPT 10
             .DC.w 9999,17
             .DC.w 20,0
             .ENDR 
;718
;eau
             .REPT 8
             .DC.w 9999,4
             .DC.w 500,0
             .ENDR 
             .REPT 10
             .DC.w 9997,4                   ;stock prison
             .DC.w 1500,0
             .ENDR 
;736
;video
             .DC.w 9999,84
             .DC.w 1234,1234
             .DC.w 3050,84
             .DC.w 3615,3615
             .DC.w 3000+100,84
             .DC.w 2222,2222
             .DC.w 9999,84
             .DC.w 1515,1515
             .DC.w 9999,84
             .DC.w 5628,5628
             .DC.w 9999,84
             .DC.w 4236,4236
             .DC.w 9999,84
             .DC.w 1825,1825
             .DC.w 9999,84
             .DC.w 7829,7829
;744
;corde
             .DC.w 9999,85
             .DC.w 0,0
             .DC.w 9999,85
             .DC.w 0,0
;746
;bombuzal
             .REPT 5
             .DC.w 9999,12
             .DC.w 0,0
             .ENDR 
;751
;grandsac
             .DC.w 2100,35
             .DC.w 0,0
             .DC.w 751,35
             .DC.w 0,0
             .REPT 18
             .DC.w 9999,35
             .DC.w 0,0
             .ENDR 
;771
;sacoche
             .DC.w 9998,21                  ;sacoche massiglia
             .DC.w 0,0
             .REPT 29
             .DC.w 9999,21
             .DC.w 0,0
             .ENDR 
;801
;sacj
             .DC.w 751,86
             .DC.w 0,0
             .DC.w 2110,86
             .DC.w 0,0
             .DC.w 2115,86
             .DC.w 0,0
             .DC.w 2120,86
             .DC.w 0,0
             .DC.w 2125,86
             .DC.w 0,0
             .REPT 25
             .DC.w 9999,86
             .DC.w 0,0
             .ENDR 
;831
;chemise
             .DC.w 9998,11                  ;chemise massiglia
             .DC.w 0,0

             .REPT 9
             .DC.w 9999,11
             .DC.w 0,0
             .ENDR 
;841
;lunnoct
             .DC.w 9999,82
             .DC.w 0,0
;842
;banderes
             .REPT 5
             .DC.w 9999,10
             .DC.w 0,0
             .ENDR 
;847
;resvocal
             .REPT 3
             .DC.w 9999,20
             .DC.w 0,0
             .ENDR 

;850
;ditroxyl
             .REPT 3
             .DC.w 9999,8
             .DC.w 1000,0
             .ENDR 
;853
;axial
             .REPT 3
             .DC.w 9999,41
             .DC.w 0,0
             .ENDR 
;856
;tablette
             .DC.w 965+13,19                ;tablette->senex
             .DC.w 0,0
;857
;titrepro
             .DC.w 965+16,9                 ;massiglia/50 titres
             .DC.w 50,19000                 ;nombre, prix unitaire
;858
             .DC.w 965+28,9                 ;jugh'ahih/10 titres
             .DC.w 10,1000
;859
             .DC.w 3202,9                   ;attentat welco pere=NUMITOR (evi 202)
             .DC.w 25,1000
;860
             .DC.w 21,9                     ;livre ma vie
             .DC.w 85,1000
;861
             .DC.w 9998,9                   ;cylindre
             .DC.w 100,0
;862
;cartecre
             .REPT 50
             .DC.w 9999,14
             .DC.w 0,0
             .ENDR 
;912
;cc_ma                  cartes credits massiglia->sacoche massiglia
             .REPT 10
             .DC.w 771,88
             .DC.l 100000
             .ENDR 
;922
;cc_jm
             .DC.w 5021,89
argent::     .DC.l 10000
;923
;clehotel
             .REPT 5
             .DC.w 9999,90
             .DC.w 0,0
             .ENDR 
;928
;cle_cite
             .DC.w 965+17,15
             .DC.w 0,0
;929
;cle_mm
             .DC.w 965+0,91
             .DC.w 0,0
;930
;cartecai
             .DC.w 5021,23
             .DC.w 0,0
             .REPT 4
             .DC.w 9999,23
             .DC.w 0,0
             .ENDR 
;935
;lp_a
             .REPT 10
             .DC.w 9999,24
             .DC.w 0,0
             .ENDR 
;945
;lp_ta
             .DC.w 5021,7
             .DC.w 0,0
             .REPT 9
             .DC.w 9999,7
             .DC.w 0,0
             .ENDR 
;955
;lp_rx
             .DC.w 5021,16
             .DC.w 0,0
             .REPT 9
             .DC.w 9999,16
             .DC.w 0,0
             .ENDR 
;965
             .DC.w 5000,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5001,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5002,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5003,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5004,36                  ;stock marchand
             .DC.w 0,0
;970
             .DC.w 5005,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5006,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5007,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5008,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5009,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5010,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5011,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5012,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5013,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5014,36                  ;stock marchand
             .DC.w 0,0
;980
             .DC.w 5015,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5016,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5017,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5018,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5019,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5020,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 9998,36                  ;stock SYLVIA BIDON
             .DC.w 0,0
             .DC.w 5022,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5023,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5024,36                  ;stock marchand
             .DC.w 0,0
;990
             .DC.w 5025,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5026,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5027,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5028,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5029,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5030,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5031,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5032,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5033,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5034,36                  ;stock marchand
             .DC.w 0,0
;1000
             .DC.w 5035,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5036,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5037,36                  ;stock marchand
             .DC.w 0,0
             .DC.w 5038,36                  ;stock marchand
             .DC.w 0,0
;1004
             .DC.w 965+3,106                ;cle_mer
             .DC.w 0,0
;1005 corps libre
             .DC.w 9998,36
             .DC.w 0,0

             .DC.w -1  ;fin !!!!!!!!!!


sujetliste:: 
             .DC.w 1,2,3,4,5,6,7
             .DC.w -1
             .REPT 40
             .DC.w 0
             .ENDR 

stck5008::   .DC.w 7,24,23                  ; agence voyage
stckjournal::          .DC.w -1,-1          ; le 1er -1 est automodifie en 44 (journal)


soifvbl::    .DC.l 0
faimvbl::    .DC.l 0
sommeilvbl:: .DC.l 0
potvievbl::  .DC.l 0
etatvbl::    .DC.l 0
bobconsvbl:: .DC.l 0

soif::       .DC.w 2000
faim::       .DC.w 3000
_sommeil::   .DC.w 12*60

experience:: .DC.w 0
tableexp::   .DC.l 0,0,0,0                  ;128 bits d'experience



savedate::   


             .DCB.b 512,0                   ;tampon pour debordement

             .BSS 
bss:         

evisize      equ 64

;---------------------------------------------------------------
;a sauver (sauver partie)

savebss::    


nocour::     .DS.w 1   ;numero de l'image courante

contvbl::    .DS.l 1
sujetdujour::          .DS.w 1

evi::        .DS.b evisize*250

evicour::    .DS.w 1
codegenetique::        .DS.l 1
ledcoffre::  .DS.l 2
vblkocomb::  .DS.l 1   ;vbl de validite de la combinaison du coffre

feuille::    
             .DS.w viewsheet_maxx*viewsheet_maxy

feuille_end::          




; ----------------------------------------------------------
; Zones de donnees du programme de compilation
; HEADER : il contient les adresses des STARTS
; BODY   : les instructions proprement dites
;          On considere une moyenne de 2 Words
;          par instruction.
header::     
             .DS.l header_max
header_end:: 
;
body::       
             .DS.w body_max
body_end::   
; memoire vide pour la detection de
; programme trop long
             .DS.w 5


; ----------------------------------------------------------
; Zones de donnees du module d'execution
;
tokenlist::  
             .DS.b (header_max*5)*toklong
tokenlfin::  
             .EVEN 

attaqueprem::          
             .DS.l 1   ;contvbl de l'attaque
             .DS.w 1   ;nature de l'attaque 0=welco 1=senex





savebsse::   
             .DS.b 512 ;tempon pour debordements













;---------------------------------------------------------------


