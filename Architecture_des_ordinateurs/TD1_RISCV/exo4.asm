.data
	message: .asciz "Hello, World!\n"  
    
.global multiply

multiply:
	li x10, 10 
	li x11, 15 
	li x12, 0
	mul x12, x11, x10

   	li a7, 10
    	ecall