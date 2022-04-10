;---------------------------------------------------------------
;
; echcol
;
; echange de 2 couleurs dans une image
;
; entree:  a0 adresse de l'image
;          d0 nombre de mots/4
;          d1 couleur 1
;          d2 couleur 2
;

echcol::     
             subq.w    #1,d0

             lea.l     auto1(pc),a1
             lea.l     zero(pc),a2
             lea.l     makezero(pc),a3
             move.w    d1,d7
             mulu.w    #20,d7
             adda.l    d7,a2
             moveq.l   #0,d6
             move.w    d2,d6
             lsl.w     #3,d6
             adda.l    d6,a3
             .REPT 5
             move.l    (a2)+,(a1)+
             .ENDR 
             addq.l    #8,a1
             move.l    (a3)+,(a1)+
             move.l    (a3)+,(a1)+

             lea.l     auto2(pc),a1
             lea.l     zero(pc),a2
             lea.l     makezero(pc),a3
             move.w    d2,d7
             mulu.w    #20,d7
             adda.l    d7,a2
             moveq.l   #0,d6
             move.w    d1,d6
             lsl.w     #3,d6
             adda.l    d6,a3
             .REPT 5
             move.l    (a2)+,(a1)+
             .ENDR 
             addq.l    #8,a1
             move.l    (a3)+,(a1)+
             move.l    (a3)+,(a1)+



b:           
             move.w    (a0),d1
             move.w    2(a0),d2
             move.w    4(a0),d3
             move.w    6(a0),d4

             move.w    d1,d7
             swap.w    d1
             move.w    d7,d1
             move.w    d2,d7
             swap.w    d2
             move.w    d7,d2
             move.w    d3,d7
             swap.w    d3
             move.w    d7,d3
             move.w    d4,d7
             swap.w    d4
             move.w    d7,d4

auto1:       
             .DS.w 10

             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4

             .DS.w 4

             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4

auto2:       
             .DS.w 10

             swap.w    d1
             swap.w    d2
             swap.w    d3
             swap.w    d4

             .DS.w 4

             move.w    d1,(a0)+
             move.w    d2,(a0)+
             move.w    d3,(a0)+
             move.w    d4,(a0)+


             dbra      d0,b
             rts       

makezero:    
             and.w     d6,d1
             and.w     d6,d2
             and.w     d6,d3
             and.w     d6,d4

             or.w      d7,d1
             and.w     d6,d2
             and.w     d6,d3
             and.w     d6,d4

             and.w     d6,d1
             or.w      d7,d2
             and.w     d6,d3
             and.w     d6,d4

             or.w      d7,d1
             or.w      d7,d2
             and.w     d6,d3
             and.w     d6,d4

             and.w     d6,d1
             and.w     d6,d2
             or.w      d7,d3
             and.w     d6,d4

             or.w      d7,d1
             and.w     d6,d2
             or.w      d7,d3
             and.w     d6,d4

             and.w     d6,d1
             or.w      d7,d2
             or.w      d7,d3
             and.w     d6,d4

             or.w      d7,d1
             or.w      d7,d2
             or.w      d7,d3
             and.w     d6,d4

             and.w     d6,d1
             and.w     d6,d2
             and.w     d6,d3
             or.w      d7,d4

             or.w      d7,d1
             and.w     d6,d2
             and.w     d6,d3
             or.w      d7,d4

             and.w     d6,d1
             or.w      d7,d2
             and.w     d6,d3
             or.w      d7,d4

             or.w      d7,d1
             or.w      d7,d2
             and.w     d6,d3
             or.w      d7,d4

             and.w     d6,d1
             and.w     d6,d2
             or.w      d7,d3
             or.w      d7,d4

             or.w      d7,d1
             and.w     d6,d2
             or.w      d7,d3
             or.w      d7,d4

             and.w     d6,d1
             or.w      d7,d2
             or.w      d7,d3
             or.w      d7,d4

             or.w      d7,d1
             or.w      d7,d2
             or.w      d7,d3
             or.w      d7,d4

zero:        
             move.w    d1,d7
             or.w      d2,d7
             or.w      d3,d7
             or.w      d4,d7

             move.w    d7,d6
             not.w     d7
             nop       
             nop       
             nop       
             nop       

;1---------------------------------------------------------------
             not.w     d1

             move.w    d1,d7
             or.w      d2,d7
             or.w      d3,d7
             or.w      d4,d7

             not.w     d1

             move.w    d7,d6
             not.w     d7
             nop       
             nop       

;2---------------------------------------------------------------
             not.w     d2

             move.w    d1,d7
             or.w      d2,d7
             or.w      d3,d7
             or.w      d4,d7

             not.w     d2

             move.w    d7,d6
             not.w     d7
             nop       
             nop       

;3---------------------------------------------------------------
             not.w     d3
             not.w     d4

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             not.w     d3
             not.w     d4

             move.w    d7,d6
             not.w     d6

;4---------------------------------------------------------------
             not.w     d3

             move.w    d1,d7
             or.w      d2,d7
             or.w      d3,d7
             or.w      d4,d7

             not.w     d3

             move.w    d7,d6
             not.w     d7
             nop       
             nop       

;5---------------------------------------------------------------
             not.w     d2
             not.w     d4

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             not.w     d2
             not.w     d4

             move.w    d7,d6
             not.w     d6

;6---------------------------------------------------------------
             not.w     d1
             not.w     d4

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             not.w     d1
             not.w     d4

             move.w    d7,d6
             not.w     d6

;7---------------------------------------------------------------

             not.w     d4

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d4
             nop       
             nop       

;8---------------------------------------------------------------

             not.w     d4

             move.w    d1,d7
             or.w      d2,d7
             or.w      d3,d7
             or.w      d4,d7

             move.w    d7,d6
             not.w     d7

             not.w     d4
             nop       
             nop       
;9---------------------------------------------------------------

             not.w     d2
             not.w     d3

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d2
             not.w     d3

;10---------------------------------------------------------------

             not.w     d1
             not.w     d3

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d1
             not.w     d3

;11---------------------------------------------------------------

             not.w     d3

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d3
             nop       
             nop       

;12---------------------------------------------------------------

             not.w     d1
             not.w     d2

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d1
             not.w     d2

;13---------------------------------------------------------------

             not.w     d2

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d2
             nop       
             nop       

;14---------------------------------------------------------------

             not.w     d1

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6

             not.w     d1
             nop       
             nop       

;15---------------------------------------------------------------

             move.w    d1,d7
             and.w     d2,d7
             and.w     d3,d7
             and.w     d4,d7

             move.w    d7,d6
             not.w     d6
             nop       
             nop       
             nop       
             nop       







