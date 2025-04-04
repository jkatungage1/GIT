.globl register_swap 

register_swap:
li x10, 10
li x11, 15
li x12, 0

mv x12, x10
mv x10, x11
mv x11, x12

