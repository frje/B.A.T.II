             clr.l     -(sp)                ;passer en superviseur
             move.w    #$20,-(sp)
             trap      #1
             addq.l    #6,sp
             move.l    d0,ex_pile

             move.w    #$2700,sr
             move.b    #14,$ff8800

loop:        
             bclr      #4,$ff8802           ;DTR +12V

             move.w    #5000,d0             ;           move.w   #26,d0
b000:        
             nop                            ;le condensateur se charge
             dbra      d0,b000

             move.b    $fffa01,d7
             andi.w    #%1000110,d7
             cmpi.w    #%1000100,d7
             bne       rouge

             bset      #4,$ff8802           ;le condensateur se decharge

             nop       
             nop       
             nop       
             nop       
             nop       


             move.b    $fffa01,d6
             andi.w    #%1000110,d6
             cmp.w     d6,d7
             bne       vert

             move.w    #$0007,$ff8240

exit:        
             move.l    ex_pile,-(sp)        ;user
             move.w    #$20,-(sp)
             trap      #1
             addq.l    #6,sp

             clr.w     -(sp)
             trap      #1                   ;fin


rouge:       
             move.w    #$700,$ff8240
             bra       exit
vert:        
             move.w    #$0070,$ff8240
             bra       exit

             .BSS 


