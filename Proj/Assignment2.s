/* Khan, Hamza - Assignment 2 - 48598 */

	.global _start

_start:

	MOV R1,  #111    /* Puts 111 into R1 */
	MOV R2,  #5	  /* Puts 5 into R2 */
	CMP R1, R2		 
	BGE branch_equal /* branch to branch only if Z>=5

branch_different:
	MOV R0, #4 	  /* R0 < 5 */
	SWI 0

branch_equal:
	MOV R0, #5	  /* R0 >= 5 */
	MOV PC, R0	  /* Put R0 into R15 */
	SWI 0 



