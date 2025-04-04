.section .text
.global register_add

register_add:
li x10, 10 
li x11, 15 
li x12, 0

add x12, x10, x11

li a7, 10
ecall