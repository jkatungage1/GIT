.data
	message: .asciz "Hello, World!\n"  
    
.global decrement, fin

decrement:
	li x10, 10 
	li x11, 0
	
	sub x10, x10, 1
	add x11, x11, 1
	
	BLT 1, x10, fin
	j decrement
	
fin: 
	li a7, 10
    	ecall
	