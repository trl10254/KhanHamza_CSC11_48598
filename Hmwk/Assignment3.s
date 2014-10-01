@Hamza Khan
@Purpose of the program is to calculate a/b and a%b in an efficient manner

	.global main
	
main:
	MOV R2, #222      @a=222
	MOV R3, #5        @b=5
	MOV R4, #0        @swap flag
	MOV R5, #0        @temp
	MOV R6, #0        @present scale
	MOV R7, #0        @scale factor
	MOV R8, #10       @shift factor
	MOV R9, #0        @shift test
	MOV R0, #0        @
	MOV R1, R2
	b divmod1
	
divmod1:
	CMP R1, R3
	BGE scale
	BLT swapchk
	
scale:
	MOV R6, #1
	MUL R7, R3, R6
	MUL R9, R7, R8
	CMP R1, R9
	BGT shift
	BLE divmod2
	
shift:
	MUL R5, R6, R8
	MOV R6, R5
	MUL R7, R3, R6
	MUL R9, R7, R8
	b divmod2
	
divmod2:
	ADD R0, R0, R6
	SUB R1, R1, R7
	CMP R1, R7
	BGE divmod2
	BLT divmodchk
	
divmodchk:
	CMP R6, #1
	BGT scale
	BLT swapchk
	
swapchk:
	CMP R4, #0
	BEQ swap
	BNE end
	
swap:
	MOV R5, R0
	MOV R0, R1
	MOV R1, R5
	b end
	
end:
	bx lr
	
	
