@Hamza Khan
@Purpose of the program is to calculate a/b and a%b in an efficient manner

	.global _start

_start:
	MOV R2, #111
	MOV R3, #5
	MOV R4, #0
	MOV R5, #0
	MOV R6, #0
	MOV R7, #0
	MOV R8, #10
	MOV R9, #0
	MOV R0, #0
	MOV R1, R2
	CMP R1, R3
	BLT _Swap
	
_Scale:
	MOV R6, #1
	MUL R7, R3, R6
	MUL R9, R7, R8
	CMP R1, R9
	MUL R6, R8, R8
	MUL R7, R3, R6
	MUL R9, R7, R8
	
_Subtract:
	BEQ _Scale
	ADD R0, R0, R6
	SUB R1, R1, R7
	CMP R1, R7
	BGE _Subtract
	CMP R6, #1
_Swap:
	MOV R4, #0
	BEQ end;
	MOV R5, R0
	MOV R0, R1
	MOV R1, R5
	
end:
	bx lr
	
	