.data
	message: .asciz "Hello, World!\n"  

.global cond_and_jump, cond

cond_and_jump:
	li x10, 10 
	li x11, 15 
	mul x11, x10, cond

   	li a7, 10
    	ecall

cond:
    	li a7, 4 
    	la a0, message 
    	j cond_and_jump