;---------------------------------------------------------------
;
; dcpti    15/01/91
;
; decompactage
;
; a0 adresse fichier
; a1 adresse ecran
; la taille de l'image decompactee doit etre un multiple de 32 octets
;

dcpti::      
             moveq.l   #0,d1
             moveq.l   #0,d2
             move.w    (a0)+,d0             ;taille fichier decompacte
             addi.w    #31,d0
             lsr.w     #5,d0                ;/32
             move.w    (a0)+,d1             ;taille 1ere passe
             move.w    (a0)+,d2             ;taille 2eme passe
             movea.l   a0,a2                ;[a2] pointe sur zone 1ere passe
             movea.l   a0,a3
             adda.l    d1,a3                ;[a3] pointe sur zone 2eme passe
             movea.l   a3,a4
             adda.l    d2,a4                ;[a4] pointe sur donnees
             subq.w    #1,d0

             move.l    (a2)+,d4             ;1ere zone
             move.l    (a3)+,d5             ;2eme zone
             moveq.l   #31,d3               ;[d3] no bit dans long mot

             moveq.l   #0,d6
             moveq.l   #-1,d7

boucle2:     
             add.l     d4,d4                ;              btst     d2,d4
             bcs       bit31_1              ;              bne    bit1
             move.b    (a4)+,(a1)+
bit30:       
             add.l     d4,d4
             bcs       bit30_1
             move.b    (a4)+,(a1)+

bit29:       
             add.l     d4,d4
             bcs       bit29_1
             move.b    (a4)+,(a1)+

bit28:       
             add.l     d4,d4
             bcs       bit28_1
             move.b    (a4)+,(a1)+

bit27:       
             add.l     d4,d4
             bcs       bit27_1
             move.b    (a4)+,(a1)+

bit26:       
             add.l     d4,d4
             bcs       bit26_1
             move.b    (a4)+,(a1)+

bit25:       
             add.l     d4,d4
             bcs       bit25_1
             move.b    (a4)+,(a1)+

bit24:       
             add.l     d4,d4
             bcs       bit24_1
             move.b    (a4)+,(a1)+

bit23:       
             add.l     d4,d4
             bcs       bit23_1
             move.b    (a4)+,(a1)+

bit22:       
             add.l     d4,d4
             bcs       bit22_1
             move.b    (a4)+,(a1)+

bit21:       
             add.l     d4,d4
             bcs       bit21_1
             move.b    (a4)+,(a1)+

bit20:       
             add.l     d4,d4
             bcs       bit20_1
             move.b    (a4)+,(a1)+

bit19:       
             add.l     d4,d4
             bcs       bit19_1
             move.b    (a4)+,(a1)+

bit18:       
             add.l     d4,d4
             bcs       bit18_1
             move.b    (a4)+,(a1)+

bit17:       
             add.l     d4,d4
             bcs       bit17_1
             move.b    (a4)+,(a1)+

bit16:       
             add.l     d4,d4
             bcs       bit16_1
             move.b    (a4)+,(a1)+

bit15:       
             add.l     d4,d4
             bcs       bit15_1
             move.b    (a4)+,(a1)+

bit14:       
             add.l     d4,d4
             bcs       bit14_1
             move.b    (a4)+,(a1)+

bit13:       
             add.l     d4,d4
             bcs       bit13_1
             move.b    (a4)+,(a1)+

bit12:       
             add.l     d4,d4
             bcs       bit12_1
             move.b    (a4)+,(a1)+

bit11:       
             add.l     d4,d4
             bcs       bit11_1
             move.b    (a4)+,(a1)+

bit10:       
             add.l     d4,d4
             bcs       bit10_1
             move.b    (a4)+,(a1)+

bit09:       
             add.l     d4,d4
             bcs       bit09_1
             move.b    (a4)+,(a1)+

bit08:       
             add.l     d4,d4
             bcs       bit08_1
             move.b    (a4)+,(a1)+

bit07:       
             add.l     d4,d4
             bcs       bit07_1
             move.b    (a4)+,(a1)+

bit06:       
             add.l     d4,d4
             bcs       bit06_1
             move.b    (a4)+,(a1)+

bit05:       
             add.l     d4,d4
             bcs       bit05_1
             move.b    (a4)+,(a1)+

bit04:       
             add.l     d4,d4
             bcs       bit04_1
             move.b    (a4)+,(a1)+

bit03:       
             add.l     d4,d4
             bcs       bit03_1
             move.b    (a4)+,(a1)+

bit02:       
             add.l     d4,d4
             bcs       bit02_1
             move.b    (a4)+,(a1)+

bit01:       
             add.l     d4,d4
             bcs       bit01_1
             move.b    (a4)+,(a1)+

bit00:       
             add.l     d4,d4
             bcs       bit00_1
             move.b    (a4)+,(a1)+

             move.l    (a2)+,d4
             dbra      d0,boucle2
             rts       

bit31_1:     
             btst      d3,d5
             bne       bit31_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit30
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit30

bit31_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit30
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit30

bit30_1:     
             btst      d3,d5
             bne       bit30_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit29
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit29

bit30_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit29
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit29
bit29_1:     
             btst      d3,d5
             bne       bit29_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit28
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit28

bit29_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit28
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit28
bit28_1:     
             btst      d3,d5
             bne       bit28_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit27
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit27

bit28_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit27
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit27
bit27_1:     
             btst      d3,d5
             bne       bit27_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit26
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit26

bit27_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit26
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit26
bit26_1:     
             btst      d3,d5
             bne       bit26_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit25
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit25

bit26_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit25
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit25
bit25_1:     
             btst      d3,d5
             bne       bit25_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit24
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit24

bit25_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit24
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit24
bit24_1:     
             btst      d3,d5
             bne       bit24_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit23
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit23

bit24_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit23
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit23
bit23_1:     
             btst      d3,d5
             bne       bit23_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit22
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit22

bit23_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit22
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit22
bit22_1:     
             btst      d3,d5
             bne       bit22_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit21
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit21

bit22_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit21
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit21
bit21_1:     
             btst      d3,d5
             bne       bit21_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit20
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit20

bit21_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit20
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit20
bit20_1:     
             btst      d3,d5
             bne       bit20_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit19
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit19

bit20_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit19
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit19
bit19_1:     
             btst      d3,d5
             bne       bit19_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit18
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit18

bit19_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit18
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit18
bit18_1:     
             btst      d3,d5
             bne       bit18_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit17
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit17

bit18_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit17
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit17
bit17_1:     
             btst      d3,d5
             bne       bit17_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit16
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit16

bit17_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit16
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit16
bit16_1:     
             btst      d3,d5
             bne       bit16_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit15
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit15

bit16_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit15
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit15
bit15_1:     
             btst      d3,d5
             bne       bit15_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit14
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit14

bit15_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit14
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit14
bit14_1:     
             btst      d3,d5
             bne       bit14_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit13
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit13

bit14_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit13
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit13
bit13_1:     
             btst      d3,d5
             bne       bit13_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit12
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit12

bit13_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit12
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit12
bit12_1:     
             btst      d3,d5
             bne       bit12_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit11
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit11

bit12_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit11
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit11
bit11_1:     
             btst      d3,d5
             bne       bit11_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit10
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit10

bit11_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit10
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit10
bit10_1:     
             btst      d3,d5
             bne       bit10_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit09
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit09

bit10_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit09
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit09
bit09_1:     
             btst      d3,d5
             bne       bit09_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit08
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit08

bit09_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit08
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit08
bit08_1:     
             btst      d3,d5
             bne       bit08_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit07
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit07

bit08_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit07
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit07
bit07_1:     
             btst      d3,d5
             bne       bit07_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit06
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit06

bit07_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit06
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit06
bit06_1:     
             btst      d3,d5
             bne       bit06_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit05
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit05

bit06_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit05
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit05
bit05_1:     
             btst      d3,d5
             bne       bit05_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit04
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit04

bit05_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit04
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit04
bit04_1:     
             btst      d3,d5
             bne       bit04_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit03
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit03

bit04_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit03
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit03
bit03_1:     
             btst      d3,d5
             bne       bit03_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit02
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit02

bit03_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit02
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit02
bit02_1:     
             btst      d3,d5
             bne       bit02_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit01
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit01

bit02_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit01
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit01
bit01_1:     
             btst      d3,d5
             bne       bit01_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge       bit00
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit00

bit01_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge       bit00
             moveq.l   #31,d3
             move.l    (a3)+,d5
             bra       bit00
bit00_1:     
             btst      d3,d5
             bne       bit00_2
             move.b    d6,(a1)+
             subq.w    #1,d3
             bge.s     bitend
             moveq.l   #31,d3
             move.l    (a3)+,d5
bitend:      
             move.l    (a2)+,d4
             dbra      d0,boucle2
             rts       


bit00_2:     
             move.b    d7,(a1)+
             subq.w    #1,d3
             bge.s     bitend
             moveq.l   #31,d3
             move.l    (a3)+,d5

             move.l    (a2)+,d4
             dbra      d0,boucle2
             rts       

