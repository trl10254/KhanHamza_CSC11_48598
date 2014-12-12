.data 
   
message1: .asciz "\nIn problem 1\n"
message2: .asciz "\nI have a number between 1 and 1000\nCan you guess my number? You will be\ngiven a maximum of 10 guesses.\nPlease type your first guess: "
message3: .asciz "\nCongratulations, You guessed the number!"
message4: .asciz "Too low. Try again. "
message5: .asciz "Too high. Try again. "
message6: .asciz "\nToo many tries."
message7: .asciz "\nWould you like to play again(y or n)?: "
message8: .asciz "\nThe number was: %d\n"


.balign 4
format:   .asciz "%d"
format1:   .asciz " %c" 
number: .word 0
  
.text 

scaleRight: 
 	push {lr}
	
loop0:     
 	MOV R3, R3, ASR #1
 	MOV R2, R2, ASR #1 
 	CMP R1, R2 
 	BLT loop0 
 	pop {lr}
    bx lr
  
addSub: 
 	push {lr}
	
loop2: 
 	ADD r0,r0,r3 
 	SUB r1,r1,r2 
 	BL scaleRight 
 	CMP r3,#1 
 	BGE loop2 
    pop {lr} 
    bx lr 

scaleLeft: 
 	push {lr}
	
loop3:   
 	MOV R3, R3, LSL #1 
 	MOV R2, R2, LSL #1 
 	CMP R1, R2 
 	BGE loop3 
 	MOV R3, R3, ASR #1  
 	MOV R2, R2, ASR #1   
 	pop {lr}  
    bx lr  
  
divMod: 
 	push {lr}  
 	MOV R0, #0 
 	MOV R3, #1 
 	CMP R1, R2 
 	BLT end_div 
 	BL scaleLeft 
 	BL addSub
	
end_div: 
 	pop {lr}  
    bx lr 


	.global problem1 

problem1: 
    STR lr, [sp,#-4]!            
    SUB sp, sp, #4 

    LDR R0, =message1            /* Set &message1 as the first parameter of printf */ 
    BL printf                    /* Call printf */ 
     
loop:
    MOV R0, #0
    BL time
    BL srand
    BL rand
    MOV R1, R0, ASR #1
    MOV r2, #1000
    BL divMod
    ADD R1, #1
    MOV R4, R1

    MOV R5, #10		  /*counter (guesses)*/
     
    LDR R0, =message2            /* Set &message2 as the first parameter of printf */ 
    BL printf                    /* Call printf */
   
loop_game:
    LDR R0, =format              /* Set format as the first parameter of scanf */ 
    LDR R1, address_of_number                  
    BL scanf                     /* Call scanf */ 
   
    LDR R1, address_of_number
    LDR R2, [R1]

    CMP r2, r4
    BEQ win
    BGT high
    BLT low

    b end

win:
    LDR R0, =message3
	BL printf
	b end
     
high:
	LDR R0, =message5
	BL printf
	b test

low:
	LDR R0, =message4
	BL printf
	
test:
	SUB R5, R5, #1
	CMP R5, #0
	BEQ lose
	b loop_game

lose:
	LDR R0, =message6
	BL printf
	     
end:
	LDR R0, =message8
    MOV R1, R4
	BL printf
	
	LDR R0, =message7
	BL printf

    LDR R0, =format1             /* Set format as the first parameter of scanf */ 
    MOV R1, sp                  
	BL scanf                     /* Call scanf */ 
	LDR R11, [sp]                 /* Load the character read by scanf into r4 */

	CMP R11, #121
    BEQ loop 

    ADD sp, sp, #4               /* Discard the integer read by scanf */ 
    LDR lr, [sp], #+4            /* Pop the top of the stack and put it in lr */ 
    bx lr                        /* Leave problem1 */ 

address_of_message1: .word message1 
address_of_message2: .word message2
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_message6: .word message6
address_of_message7: .word message7
address_of_message8: .word message8
address_of_format:   .word format 
address_of_format1:  .word format1
address_of_number:	 .word number 