;---------------------------------------------------------------
;
; 256to16
;
; transforme une image 256 couleurs vga en 16 niveau de gris atari
;
; entree:     a0 adresse de l'image
;             a1 adresse de la destination
;             a2 adresse de la table de couleur
;             (256 octets couleur vga->couleur st)
;

256to16:     
             move.w    #64000/16-1,d2
             moveq.l   #0,d0
mainloop:    
             moveq.l   #15,d7               ;numero du bit courant


             moveq.l   #0,d3                ;poids faible
             moveq.l   #0,d4
             moveq.l   #0,d5
             moveq.l   #0,d6                ;poids fort

bouclemot:   
             move.b    (a0)+,d0
             move.b    0(a2,d0.w),d1        ;couleur atari
             btst      #0,d1
             beq.s     bit0zero
             bset      d7,d3
bit0zero:    
             btst      #1,d1
             beq.s     bit1zero
             bset      d7,d4
bit1zero:    
             btst      #2,d1
             beq.s     bit2zero
             bset      d7,d5
bit2zero:    
             btst      #3,d1
             beq.s     bit3zero
             bset      d7,d6
bit3zero:    
             dbra      d7,bouclemot

;              move.w   d3,(a1)+
;             move.w   d4,(a1)+
;            move.w   d5,(a1)+
;           move.w   d6,(a1)+
             movem.w   d3-d6,(a1)
             addq.l    #8,a1
             dbra      d2,mainloop
             rts       









