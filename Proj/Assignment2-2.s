/* Khan, Hamza - Assignment 2 - 48598 */

.global _start

_start:

	MOV R1, #111          @ r1 ? 1
	MOV R2, #5            @ r2 ? 5
	MOV R3, #0            @ Counter
	MOV R4, #1            @ Swap flag 
	CMP R1, R2		      @ update the CPSR
	BGE _Subtract
	BLT _Swapcheck

_Subtract:
	SUB R1, R1, R2       @R1-=R2
	ADD R3, R3, #1        @counter++
	CMP R1, R2            @check a>b again
	BGE _Subtract         @Go through this loop again
	BLT _Swapcheck        @If the check does not pass do this 

_Swapcheck:
	CMP R4, #1
	BEQ end
	BNE _Swap 	          

_Swap:
	MOV R5, R0            @Swaps the function in r0 with r5
	MOV R0, R3            @Swaps the funcion in r3 with r0
	MOV R3, R5            @Swaps the function in r5 with r3
	b end

end:
	MOV R7, #1
	SWI 0 



