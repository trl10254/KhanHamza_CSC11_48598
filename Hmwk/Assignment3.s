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
	CMP R6, #1		@scale R6
	MUL R7, R3, R6		@Subtraction factor
	MUL R9, R7, R8		@Next subtracion factor
	b _Second

_Second:
	MUL R6, R6, R8		@Scale factor
	MUL R7, R3, R6		@Subtraction factor
	MUL R9, R7, R8		@Next subtracion factor
	CMP R1, R9
	BGE _Second
	
_Third:
	ADD R0, R0, R6		@Increase by scale
	SUB R1, R1, R7		@Subtract by b*scale
	CMP R1, R7
	BGE _Third
	
_Fourth:
	CMP R6, #1
	BGE _Scale
	
_Swap:
	MOV R4, #0		@Check if R4 is set
	BEQ _end;		@End program is R4 is 0
	MOV R5, R0		@If R4 is set start swapping
	MOV R0, R1
	MOV R1, R5
	
_end:
	MOV R7, #1
	SWI 0
	
	
