;---------------------------------------------------------------
;
; iff                  17/07/90
;
; lecture d'un fichier image iff
;
; entree:     a0 adresse du coprs du fichier iff (BODY)
;             a1 adresse du buffer
;

iff:         
             movea.l   a1,a2                ;              lea.l    64000(a1),a2   ;adresse fin de buffer
             adda.l    #64000,a2
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
             rts       



