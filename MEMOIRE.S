
             .TEXT 

chipsize     equ 256000                     ;+512000
fastsize     equ 0


             .DATA 

memlongfast::          .DC.l fastsize
memlongchip::          .DC.l chipsize
memadrfast:: .DC.l fast
memadrchip:: .DC.l chip

             .BSS 


chip::       .DS.b chipsize
fast::       .DS.b fastsize



