#  #Par Jacques Katunga Mukendi
#  .section .text
#     .globl _start

# _start:
# CLRF TRISA

# loop:

#     li PORTA, 1
#     call delay

#     li PORTA, 0
#     call delay

#     j loop

# # Fonction delay
# delay:
#     li t2, 21
    
# delay_loop:
#     nop  
#     addi t2, t2, -1
#     bnez t2, delay_loop 
#     ret

; Programme : clignotement d’une LED sur PORTA.0 avec delay
; Auteur : Jacques Katunga Mukendi

    LIST    P=16F84A
    #include <p16f84a.inc>

    __CONFIG _CP_OFF & _WDT_OFF & _XT_OSC

    org 0x00
    goto start

; ===== Main program =====
start:
    clrf    PORTA       ; Efface le port A
    clrf    PORTB       ; (au cas où)
    movlw   0x00
    tris    PORTA       ; PORTA en sortie

loop:
    bsf     PORTA, 0    ; Allume la LED (RA0 = 1)
    call    delay

    bcf     PORTA, 0    ; Éteint la LED (RA0 = 0)
    call    delay

    goto    loop

; ===== Delay subroutine =====
delay:
    movlw   d'100'      ; Définir la durée du délai
    movwf   count1

delay_loop:
    nop
    decfsz  count1, f
    goto    delay_loop
    return

; ===== Variables =====
    org 0x20
count1:     res 1
