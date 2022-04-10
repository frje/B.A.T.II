;---------------------------------------------------------------
;
; remap
;
; changement de couleurs dans une image (remap)
;
; entree:  a0 adresse de l'image source
;          a1 adresse destination (eventuellement egale a la source)
;          a2 adresse de la table de conversion de couleurs
;          d0 nombre de mots/4 (paire)
;

remap::      
             addq.w    #1,d0
             lsr.w     #1,d0
             movea.w   d0,a6

             lea.l     tableauto,a3
             moveq.l   #15,d7
bautom:      
             move.w    (a2)+,d1             ;couleur destination
             movea.l   (a3)+,a4             ;adresse auto
             moveq.l   #3,d6
ba2:         
             btst      d6,d1
             bne.s     ba2b

             move.w    d6,d5
             addq.w    #3,d5
             lsl.w     #8,d5
             lsl.w     #1,d5
             ori.w     #$c087,d5

             move.w    d5,(a4)+             ;and.l d7,d6 a and.l d7,d3
ba2b:        
             dbra      d6,ba2

             move.w    #$4687,(a4)+         ; not.l d7

             moveq.l   #3,d6
ba3:         
             btst      d6,d1
             beq.s     ba3b

             move.w    d6,d5
             addq.w    #3,d5
             lsl.w     #8,d5
             lsl.w     #1,d5
             ori.w     #$8087,d5

             move.w    d5,(a4)+             ;or.l d7,d6 a or.l d7,d3
ba3b:        
             dbra      d6,ba3

             dbra      d7,bautom

bremap:      
             movem.w   (a0)+,d0-d7
             swap.w    d0
             swap.w    d1
             swap.w    d2
             swap.w    d3
             move.w    d4,d0
             move.w    d5,d1
             move.w    d6,d2
             move.w    d7,d3

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7

             exg.l     d3,a3

             moveq.l   #0,d3
             moveq.l   #0,d4
             moveq.l   #0,d5
             moveq.l   #0,d6

automod0:    
             and.l     d7,d6                ;couleur 0
             and.l     d7,d3
             and.l     d7,d4
             and.l     d7,d5
             not.l     d7

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7

             exg.l     d3,a3

automod1:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5


             exg.l     d3,a3

             not.l     d1

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7

             exg.l     d3,a3

automod3:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod2:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d2

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod6:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod7:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d1

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod5:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod4:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d3

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod12:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod13:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d1

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod15:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod14:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d2

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod10:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod11:   
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d1

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7





             exg.l     d3,a3

automod9:    
             not.l     d7
             or.l      d7,d6
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5

             exg.l     d3,a3

             not.l     d0

             move.l    d0,d7
             or.l      d1,d7
             or.l      d2,d7
             or.l      d3,d7



             exg.l     d3,a3

automod8:    
             not.l     d7
             or.l      d7,d3
             or.l      d7,d4
             or.l      d7,d5
             or.l      d7,d6

             lea.l     16(a1),a1
             movem.w   d3-d6,-(a1)

             swap.w    d3
             swap.w    d4
             swap.w    d5
             swap.w    d6

             movem.w   d3-d6,-(a1)

             lea.l     16(a1),a1

;              lea.l    16(a0),a0

             subq.w    #1,a6
             cmpa.w    #0,a6
             bne       bremap
             rts       


             .DATA 

tableauto:   .DC.l automod0,automod1,automod2,automod3,automod4,automod5
             .DC.l automod6,automod7,automod8,automod9,automod10
             .DC.l automod11,automod12,automod13,automod14,automod15




