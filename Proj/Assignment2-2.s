/* Khan, Hamza - Assignment 2 - 48598 */

	.global _start

_start:
	MOV R1, #13
	MOV R2, #6
	MOV R3, #0  @holds counter(s)
	MOV R4, #1  @for swap
	CMP R1, R2
	BGE Sub
	BLT check

Sub:
	SUB R1, R1, R2 @R1-=R2
	MOV R0, R1
	CMP R1, R2
	BGE Sub
	BLT check

check:
	CMP R4, #0
	BEQ swap
	BNE end

swap:
 	MOV R5, R0
	MOV R0, R3
	MOV R3, R5
	b end
	
end:
	MOV R7, #1
	SWI 0