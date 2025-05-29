 #Par Jacques Katunga Mukendi
 .section .text
    .globl _start

_start:
CLRF TRISA

loop:

    li PORTA, 1
    call delay

    li PORTA, 0
    call delay

    j loop

# Fonction delay
delay:
    li t2, 21
    
delay_loop:
    nop  
    addi t2, t2, -1
    bnez t2, delay_loop 
    ret