             .DATA 

lie          equ 1
rigide       equ 2
enetat       equ 4
perce        equ 8
unseul       equ 16

paslie       equ 0
pasrigide    equ 0
pasenetat    equ 0
pasperce     equ 0
plusieur     equ 0

;objtypedata

objtypedata::          
             .DC.w 0,paslie+rigide+enetat+pasperce+plusieur,-1        ;0
             .DC.l 4500,3500,100,100,vetpret
             .DC.w 0,0
             .DC.w 1000                     ;type 0

             .DC.w 0,paslie+rigide+enetat+pasperce+plusieur,28        ;1 bidon
             .DC.l 4500,3500,15,30,vetpret
             .DC.w 0,0
             .DC.w 0   ;type 1

             .DC.w 0,paslie+rigide+enetat+pasperce+plusieur,28        ;2 bidon
             .DC.l 4500,3500,15,30,vetpret
             .DC.w 0,0
             .DC.w 0   ;type 2

             .DC.w 3,paslie+rigide+enetat+pasperce+unseul,-1          ;3
             .DC.l 500,600,0,0,vinvert
             .DC.w 500,4
             .DC.w 62  ;type 3

             .DC.w 4,paslie+rigide+enetat+pasperce+unseul,-1          ;4
             .DC.l 500,505,0,0,eau
             .DC.w 1000,0
             .DC.w 4   ;type 4


             .DC.w 5,paslie+rigide+enetat+pasperce+unseul,-1          ;5
             .DC.l 100,30,0,0,algue
             .DC.w 200,0
             .DC.w 44  ;type 5


             .DC.w 6,paslie+rigide+enetat+pasperce+unseul,-1          ;6
             .DC.l 80,50,0,0,pizza
             .DC.w 100,0
             .DC.w 18  ;type 6


             .DC.w 7,paslie+rigide+enetat+pasperce+unseul,-1          ;7
             .DC.l 5,10,0,0,lp_ta
             .DC.w 0,0
             .DC.w 50  ;type 7


             .DC.w 8,paslie+rigide+enetat+pasperce+unseul,-1          ;8
             .DC.l 1000,1000,0,0,ditroxyl
             .DC.w 1000,0
             .DC.w 25  ;type 8


             .DC.w 9,paslie+rigide+enetat+pasperce+unseul,-1          ;9
             .DC.l 20,10,0,0,titrepro
             .DC.w 0,0
             .DC.w 0   ;type 9


             .DC.w 10,paslie+rigide+enetat+pasperce+unseul,-1         ;10
             .DC.l 50,10,0,0,banderes
             .DC.w 0,0
             .DC.w 45  ;type 10


             .DC.w 11,paslie+rigide+enetat+pasperce+plusieur,43       ;11
             .DC.l 600,20,50,50,chemise
             .DC.w 0,0
             .DC.w 2   ;type 11


             .DC.w 12,paslie+rigide+enetat+pasperce+unseul,-1         ;12
             .DC.l 15,25,0,0,bombuzal
             .DC.w 0,0
             .DC.w 240 ;type 12


             .DC.w 12,paslie+rigide+enetat+pasperce+unseul,-1         ;13 bidon
             .DC.l 15,25,0,0,bombuzal
             .DC.w 0,0
             .DC.w 0   ;type 13


             .DC.w 14,paslie+rigide+enetat+pasperce+unseul,-1         ;14
             .DC.l 5,10,0,0,cartecre
             .DC.w 0,0
             .DC.w 5   ;type 14


             .DC.w 15,paslie+rigide+enetat+pasperce+unseul,-1         ;15
             .DC.l 20,200,0,0,cle_cite
             .DC.w 0,0
             .DC.w 100 ;type 15


             .DC.w 16,paslie+rigide+enetat+pasperce+unseul,-1         ;16
             .DC.l 5,10,0,0,lp_rx
             .DC.w 0,0
             .DC.w 50  ;type 16


             .DC.w 17,paslie+rigide+enetat+pasperce+unseul,-1         ;17
             .DC.l 20,25,0,0,the
             .DC.w 20,0
             .DC.w 7   ;type 17


             .DC.w 18,paslie+rigide+enetat+pasperce+plusieur,9        ;18
             .DC.l 1000,1000,100,50,livremem
             .DC.w 0,0
             .DC.w 0   ;type 18


             .DC.w 19,paslie+rigide+enetat+pasperce+unseul,-1         ;19
             .DC.l 20,200,0,0,tablette
             .DC.w 0,0
             .DC.w 5000                     ;type 19


             .DC.w 20,paslie+rigide+enetat+pasperce+unseul,10         ;20
             .DC.l 200,800,50,10,resvocal
             .DC.w 0,0
             .DC.w 800 ;type 20


             .DC.w 21,paslie+rigide+enetat+pasperce+plusieur,-1       ;21
             .DC.l 300,200,5000,20000,sacoche
             .DC.w 0,0
             .DC.w 26  ;type 21


             .DC.w 22,paslie+rigide+enetat+pasperce+unseul,-1         ;22
             .DC.l 1,1,0,0,sdouleu
             .DC.w 0,0
             .DC.w 220 ;type 22


             .DC.w 23,paslie+rigide+enetat+pasperce+unseul,-1         ;23
             .DC.l 5,10,0,0,cartecai
             .DC.w 0,0
             .DC.w 100 ;type 23


             .DC.w 24,paslie+rigide+enetat+pasperce+unseul,-1         ;24
             .DC.l 5,10,0,0,lp_a
             .DC.w 0,0
             .DC.w 50  ;type 24


             .DC.w 25,paslie+rigide+enetat+pasperce+unseul,-1         ;25
             .DC.l 500,600,0,0,vincecub
             .DC.w 500,8
             .DC.w 85  ;type 25


             .DC.w 26,paslie+rigide+enetat+pasperce+unseul,-1         ;26
             .DC.l 3,9,0,0,as
             .DC.w 0,0
             .DC.w 100 ;type 26


             .DC.w 27,paslie+rigide+enetat+pasperce+unseul,-1         ;27
             .DC.l 500,400,0,0,hamburge
             .DC.w 1500,0
             .DC.w 20  ;type 27


             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;28
             .DC.l 5,10,0,0,fc_pret
             .DC.w 0,0
             .DC.w 50  ;type 28


             .DC.w 29,paslie+rigide+enetat+pasperce+unseul,-1         ;29
             .DC.l 400,340,0,0,frites
             .DC.w 480,0
             .DC.w 15  ;type 29


             .DC.w 29,paslie+rigide+enetat+pasperce+unseul,-1         ;30 bidon
             .DC.l 400,340,0,0,frites
             .DC.w 0,0
             .DC.w 0   ;type 30


             .DC.w 31,paslie+rigide+enetat+pasperce+unseul,-1         ;31
             .DC.l 400,230,0,0,salade
             .DC.w 70,0
             .DC.w 31  ;type 31


             .DC.w 32,paslie+rigide+enetat+pasperce+unseul,-1         ;32
             .DC.l 30,40,0,0,doubles
             .DC.w 30,16
             .DC.w 55  ;type 32


             .DC.w 32,paslie+rigide+enetat+pasperce+unseul,-1         ;33
             .DC.l 30,40,0,0,volcano
             .DC.w 30,28
             .DC.w 55  ;type 33


             .DC.w 34,paslie+rigide+enetat+pasperce+unseul,-1         ;34
             .DC.l 500,600,0,0,vinmassiq
             .DC.w 500,10
             .DC.w 100 ;type 34


             .DC.w 35,paslie+rigide+enetat+pasperce+plusieur,-1       ;35
             .DC.l 100,40,25000,50000,grandsac
             .DC.w 0,0
             .DC.w 40  ;type 35


             .DC.w 36,lie+rigide+enetat+pasperce+plusieur,-1          ;36
             .DC.l 0,0,500000,100000,corps
             .DC.w 0,0
             .DC.w 0   ;type 36


             .DC.w 37,lie+rigide+enetat+pasperce+unseul,-1  ;37
             .DC.l 200,150,100000,30000,main_d
             .DC.w 0,0
             .DC.w 0   ;type 37


             .DC.w 38,lie+rigide+enetat+pasperce+unseul,-1  ;38
             .DC.l 200,150,100000,30000,main_g
             .DC.w 0,0
             .DC.w 0   ;type 38


             .DC.w 39,paslie+rigide+enetat+pasperce+unseul,-1         ;39
             .DC.l 500,600,0,0,vinfaler
             .DC.w 500,14
             .DC.w 130 ;type 39


             .DC.w 39,paslie+rigide+enetat+pasperce+unseul,-1         ;40 bidon
             .DC.l 500,600,0,0,vinfaler
             .DC.w 0,0
             .DC.w 0   ;type 40


             .DC.w 41,paslie+rigide+enetat+pasperce+unseul,-1         ;41
             .DC.l 15000,7000,0,0,axial
             .DC.w 0,0
             .DC.w 500 ;type 41


             .DC.w 42,paslie+rigide+enetat+pasperce+unseul,-1         ;42
             .DC.l 1,1,0,0,verrecod
             .DC.w 0,0
             .DC.w 1000                     ;type 42


             .DC.w 43,paslie+rigide+enetat+pasperce+unseul,-1         ;43
             .DC.l 1,1,0,0,ctueur
             .DC.w 0,0
             .DC.w 0   ;type 43


             .DC.w 44,paslie+rigide+enetat+pasperce+unseul,-1         ;44
             .DC.l 3,15,0,0,journal
             .DC.w 0,0
             .DC.w 2   ;type 44


             .DC.w 45,lie+rigide+enetat+pasperce+unseul,19  ;          45
             .DC.l 50,30,20,200,bob
             .DC.w 0,0
             .DC.w 0   ;type 45


             .DC.w 46,paslie+rigide+enetat+pasperce+unseul,56         ;46
             .DC.l 15,15,5,5,voktraso
             .DC.w 80,100
             .DC.w 150 ;type 46


             .DC.w 47,paslie+rigide+enetat+pasperce+unseul,57         ;47
             .DC.l 800,1000,30,350,beckmann
             .DC.w 100,1000                 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
             .DC.w 390 ;type 47


             .DC.w 48,paslie+rigide+enetat+pasperce+unseul,58         ;48
             .DC.l 800,1000,200,500,haas10
             .DC.w 130,1000
             .DC.w 560 ;type 48


             .DC.w 49,paslie+rigide+enetat+pasperce+unseul,59         ;49
             .DC.l 30,50,5,5,gladius
             .DC.w 70,500
             .DC.w 100 ;type 49


             .DC.w 50,paslie+rigide+enetat+pasperce+unseul,60         ;50
             .DC.l 500,4000,100,800,pilumlas
             .DC.w 180,10000
             .DC.w 800 ;type 50


             .DC.w 51,paslie+rigide+enetat+pasperce+unseul,61         ;51
             .DC.l 200,300,50,100,asoa50
             .DC.w 250,200
             .DC.w 1300                     ;type 51


             .DC.w 52,paslie+rigide+enetat+pasperce+unseul,62         ;52
             .DC.l 3000,2200,600,1000,plasma
             .DC.w 90,20000
             .DC.w 1200                     ;type 52


             .DC.w 53,paslie+rigide+enetat+pasperce+unseul,63         ;53
             .DC.l 1000,800,40,300,laskolt
             .DC.w 140,10000
             .DC.w 400 ;type 53


             .DC.w 54,paslie+rigide+enetat+pasperce+unseul,64         ;54
             .DC.l 2500,1500,500,300,hasta2
             .DC.w 220,10000
             .DC.w 600 ;type 54


             .DC.w 55,paslie+rigide+enetat+pasperce+unseul,65         ;55
             .DC.l 1250,750,250,150,hasta1
             .DC.w 110,5000
             .DC.w 400 ;type 55


             .DC.w 56,paslie+rigide+enetat+pasperce+unseul,-1         ;56
             .DC.l 5,5,0,0,lp12
             .DC.w 4,10
             .DC.w 40  ;type 56


             .DC.w 57,paslie+rigide+enetat+pasperce+unseul,-1         ;57
             .DC.l 30,350,0,0,lp57
             .DC.w 5,25
             .DC.w 50  ;type 57


             .DC.w 58,paslie+rigide+enetat+pasperce+unseul,-1         ;58
             .DC.l 200,500,0,0,n29
             .DC.w 5,5
             .DC.w 50  ;type 58


             .DC.w 59,paslie+rigide+enetat+pasperce+unseul,-1         ;59
             .DC.l 5,5,0,0,lp02
             .DC.w 3,20
             .DC.w 30  ;type 59


             .DC.w 60,paslie+rigide+enetat+pasperce+unseul,-1         ;60
             .DC.l 100,800,0,0,lp110
             .DC.w 8,100
             .DC.w 80  ;type 60


             .DC.w 61,paslie+rigide+enetat+pasperce+unseul,-1         ;61
             .DC.l 50,100,0,0,fillum12
             .DC.w 9,85
             .DC.w 90  ;type 61


             .DC.w 62,paslie+rigide+enetat+pasperce+unseul,-1         ;62
             .DC.l 600,1000,0,0,plas1
             .DC.w 9,50
             .DC.w 90  ;type 62


             .DC.w 63,paslie+rigide+enetat+pasperce+unseul,-1         ;63
             .DC.l 40,300,0,0,lp45
             .DC.w 6,20
             .DC.w 60  ;type 63


             .DC.w 64,paslie+rigide+enetat+pasperce+unseul,-1         ;64
             .DC.l 500,300,0,0,k2
             .DC.w 7,100
             .DC.w 70  ;type 64


             .DC.w 65,paslie+rigide+enetat+pasperce+unseul,-1         ;65
             .DC.l 250,150,0,0,k1
             .DC.w 5,50
             .DC.w 50  ;type 65


             .DC.w 66,paslie+rigide+enetat+pasperce+unseul,-1         ;66
             .DC.l 2000,1000,0,0,chf6
             .DC.w 6,0
             .DC.w 600 ;type 66


             .DC.w 67,paslie+rigide+enetat+pasperce+unseul,-1         ;67
             .DC.l 2000,500,0,0,gilet1
             .DC.w 4,0
             .DC.w 500 ;type 67


             .DC.w 68,paslie+rigide+enetat+pasperce+unseul,-1         ;68
             .DC.l 5000,600,0,0,casqued
             .DC.w 4,0
             .DC.w 300 ;type 68


             .DC.w 69,paslie+rigide+enetat+pasperce+unseul,-1         ;69
             .DC.l 1000,200,0,0,coudiere
             .DC.w 3,0
             .DC.w 200 ;type 69


             .DC.w 70,paslie+rigide+enetat+pasperce+unseul,-1         ;70
             .DC.l 1000,200,0,0,cuissard
             .DC.w 2,0
             .DC.w 150 ;type 70


             .DC.w 71,paslie+rigide+enetat+pasperce+unseul,-1         ;71
             .DC.l 10000,2000,0,0,cuirasse
             .DC.w 7,0
             .DC.w 650 ;type 71


             .DC.w 72,paslie+rigide+enetat+pasperce+unseul,-1         ;72
             .DC.l 10000,2000,0,0,scutum
             .DC.w 9,0
             .DC.w 850 ;type 72


             .DC.w 73,paslie+rigide+enetat+pasperce+unseul,-1         ;73
             .DC.l 1000,1000,0,0,antiop
             .DC.w 1500,0
             .DC.w 50  ;type 73


             .DC.w 74,paslie+rigide+enetat+pasperce+unseul,-1         ;74
             .DC.l 200,200,0,0,crepe
             .DC.w 600,0
             .DC.w 10  ;type 74


             .DC.w 75,paslie+rigide+enetat+pasperce+plusieur,76       ;75
             .DC.l 100,25,30*2,20*2,painroug
             .DC.w 200,0
             .DC.w 5   ;type 75


             .DC.w 76,paslie+rigide+enetat+pasperce+unseul,-1         ;76
             .DC.l 30,20,0,0,saucisse
             .DC.w 160,0
             .DC.w 6   ;type 76


             .DC.w 77,paslie+rigide+enetat+pasperce+unseul,-1         ;77
             .DC.l 400,350,0,0,vespe
             .DC.w 320,0
             .DC.w 33  ;type 77


             .DC.w 78,paslie+rigide+enetat+pasperce+unseul,-1         ;78
             .DC.l 300,400,0,0,azmani
             .DC.w 1000,0
             .DC.w 50  ;type 78


             .DC.w 79,paslie+rigide+enetat+pasperce+unseul,-1         ;79
             .DC.l 100,40,0,0,ppains
             .DC.w 50,0
             .DC.w 5   ;type 79


             .DC.w 80,paslie+rigide+enetat+pasperce+unseul,-1         ;80
             .DC.l 150,100,0,0,galettes
             .DC.w 300,0
             .DC.w 14  ;type 80


             .DC.w 81,paslie+rigide+enetat+pasperce+unseul,-1         ;81
             .DC.l 10,20,0,0,poisson
             .DC.w 80,0
             .DC.w 28  ;type 81


             .DC.w 82,paslie+rigide+enetat+pasperce+unseul,-1         ;82
             .DC.l 15,10,0,0,lunnoct
             .DC.w 0,0
             .DC.w 255 ;type 82


             .DC.w 83,paslie+rigide+enetat+pasperce+unseul,-1         ;83
             .DC.l 650,500,0,0,gateau
             .DC.w 1900,0
             .DC.w 37  ;type 83


             .DC.w 84,paslie+rigide+enetat+pasperce+unseul,-1         ;84
             .DC.l 160,300,0,0,video
             .DC.w 0,0
             .DC.w 675 ;type 84


             .DC.w 85,paslie+rigide+enetat+pasperce+unseul,-1         ;85
             .DC.l 7000,3000,0,0,corde
             .DC.w 0,0
             .DC.w 445 ;type 85

             .DC.w 86,paslie+rigide+enetat+pasperce+plusieur,-1       ;86
             .DC.l 10,10,5000,10000,sacj
             .DC.w 0,0
             .DC.w 2

             .DC.w 26,paslie+rigide+enetat+pasperce+unseul,-1         ;87
             .DC.l 12,30,0,0,aureus
             .DC.w 0,0
             .DC.w 40000

             .DC.w 14,paslie+rigide+enetat+pasperce+unseul,-1         ;88
             .DC.l 5,10,0,0,cc_ma
             .DC.l 100000
             .DC.w 0

             .DC.w 14,paslie+rigide+enetat+pasperce+unseul,-1         ;89
             .DC.l 5,10,0,0,cc_jm
             .DC.w 0,0
             .DC.w 0

             .DC.w 15,paslie+rigide+enetat+pasperce+unseul,-1         ;90
             .DC.l 20,200,0,0,clehotel
             .DC.w 0,0
             .DC.w 150

             .DC.w 15,paslie+rigide+enetat+pasperce+unseul,-1         ;91
             .DC.l 20,200,0,0,cle_mm
             .DC.w 0,0
             .DC.w 150

             .DC.w 26,paslie+rigide+enetat+pasperce+unseul,-1         ;92
             .DC.l 3,9,0,0,nummus
             .DC.w 0,0
             .DC.w 400

             .DC.w 26,paslie+rigide+enetat+pasperce+unseul,-1         ;93
             .DC.l 3,9,0,0,denarius
             .DC.w 0,0
             .DC.w 1600

             .DC.w 26,paslie+rigide+enetat+pasperce+unseul,-1         ;bidon
             .DC.l 3,9,0,0,aureus
             .DC.w 0,0
             .DC.w 40000

             .DC.w 17,paslie+rigide+enetat+pasperce+unseul,-1         ;95
             .DC.l 20,25,0,0,cafe
             .DC.w 20,0
             .DC.w 7

             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;96
             .DC.l 5,10,0,0,cp_adelia
             .DC.w 0,0
             .DC.w 0

             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;97
             .DC.l 5,10,0,0,cp_bonum
             .DC.w 0,0
             .DC.w 0

             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;98
             .DC.l 5,10,0,0,cp_siriu
             .DC.w 0,0
             .DC.w 0

             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;99
             .DC.l 5,10,0,0,cp_agam
             .DC.w 0,0
             .DC.w 0

             .DC.w 28,paslie+rigide+enetat+pasperce+unseul,-1         ;100
             .DC.l 5,10,0,0,cp_kubit
             .DC.w 0,0
             .DC.w 0

             .DC.w 32,paslie+rigide+enetat+pasperce+unseul,-1         ;101
             .DC.l 30,40,0,0,merluz
             .DC.w 30,20
             .DC.w 41

             .DC.w 66,paslie+rigide+enetat+pasperce+unseul,-1         ;102
             .DC.l 2000,1000,0,0,chf8
             .DC.w 8,0
             .DC.w 800

             .DC.w 66,paslie+rigide+enetat+pasperce+unseul,-1         ;103
             .DC.l 2000,1000,0,0,chf9
             .DC.w 9,0
             .DC.w 900

             .DC.w 43,paslie+rigide+enetat+pasperce+unseul,-1         ;104
             .DC.l 1,1,0,0,papierma
             .DC.w 0,0
             .DC.w 10

             .DC.w 67,paslie+rigide+enetat+pasperce+unseul,-1         ;105
             .DC.l 2000,500,0,0,gilet2
             .DC.w 5,0
             .DC.w 500

             .DC.w 15,paslie+rigide+enetat+pasperce+unseul,-1         ;106
             .DC.l 20,200,0,0,cle_mer
             .DC.w 0,0
             .DC.w 150







