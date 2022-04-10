;---------------------------------------------------------------
;
; iff                  17/07/90
;
; lecture d'un fichier image iff
;
; entree:     a0 adresse du corps du fichier iff (BODY)
;             a1 adresse du buffer
;

iff:         
             lea.l     32000(a1),a2         ;adresse fin de buffer
             movea.l   a1,a3

boucle:      
             cmpa.l    a2,a1
             bge.s     passe2
             moveq.l   #0,d0
             move.b    (a0)+,d0
             cmpi.w    #128,d0
             beq.s     boucle
             bgt.s     sup128
binf128:     
             move.b    (a0)+,(a1)+
             dbra      d0,binf128
             bra.s     boucle

sup128:      
             moveq.l   #0,d1
             move.b    (a0)+,d1             ;motif a repeter
             neg.w     d0
             addi.w    #256,d0
bsup128:     
             move.b    d1,(a1)+
             dbra      d0,bsup128
             bra.s     boucle

passe2:      

             move.w    #199,d7
b2:          
             lea.l     bufligne(pc),a4

             moveq.l   #39,d0
b:           
             move.l    (a3)+,(a4)+
             dbra      d0,b

             lea.l     -160(a3),a3
             lea.l     -160(a4),a4

             moveq.l   #19,d0
b3:          
             move.w    (a4),(a3)+
             move.w    40(a4),(a3)+
             move.w    80(a4),(a3)+
             move.w    120(a4),(a3)+
             addq.l    #2,a4
             dbra      d0,b3

             dbra      d7,b2
             rts       

             .BSS 

