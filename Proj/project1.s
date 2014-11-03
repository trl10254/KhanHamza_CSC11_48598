@Project 1
@By: Hamza Khan
@*********************************************************************************************
	.data 

message1: 
	.asciz "%c "

message2: 
	.asciz "\n\nPick a letter: "

message3: 
	.asciz "\nThat letter isn't in the word. Try again\n"

message4: 
	.asciz "You have %d guesses left\n"

message5: 
	.asciz "\nYou already used that letter. Try again\n"

format:   
	.asciz " %c" 
@*********************************************************************************************
	.text 
@*********************************************************************************************
	.global main

main: 
    STR lr, [sp,#-4]!            @ Push lr onto the top of the stack 
    SUB sp, sp, #4               @ Make room for one 4 byte integer in the stack 

    MOV R4, #95			             @Cover word with "_" ascii code = 95 
    MOV R5, #95
    MOV R6, #95
    MOV R7, #95
    MOV R8, #95
    MOV R9, #95
    MOV R10, #6			             @Length of the word
    MOV R11, #6			             @Guesses left 

loop:                          @Print the word one character at a time (no arrays yet) 
  MOV R1, R4
  LDR R0, address_of_message1  @Set &message1 as the first parameter of printf 
  BL printf                    @Call printf 

  MOV R1, R5
  LDR R0, address_of_message1
  BL printf 

  MOV R1, R6
  LDR R0, address_of_message1
  BL printf 

  MOV R1, R7
  LDR R0, address_of_message1
  BL printf 

  MOV R1, R8
  LDR R0, address_of_message1
  BL printf 

  MOV R1, R9
  LDR R0, address_of_message1
  BL printf 
    
  LDR R0, address_of_message2
  BL printf 

  LDR R0, address_of_format   @Set &format as the first parameter of scanf 
  MOV R1, sp                  @Set the top of the stack as the second parameter of scanf 
  BL scanf                    @Call scanf 
  LDR R1, [sp]		            @Load character read into r1 

  MOV R12, R1

  CMP R12, #109		            @Letter c, ascii code = 109 
  BEQ letter_m

  CMP R12, #101		            @Letter h, ascii code = 101
  BEQ letter_e

  CMP R12, #114		            @Letter i, ascii code = 114 
  BEQ letter_r

  CMP R12, #105		            @Letter n, ascii code = 105
  BEQ letter_i

  CMP R12, #99			          @Letter c, ascci code = 99
  BEQ letter_c

  CMP R12, #97		            @Letter a, ascii code = 97
  BEQ letter_a
    
  b wrong			                @If none of this, the letter is not in the word 

letter_m:                     @Do this for every single character in the word 
  CMP R12, R4		              @Check if letter is already used in the word 
	BEQ repeated
	MOV R4, R12		              @Replace '_' with the correct letter 
	SUB R10, R10, #1		        @Decrease size of word by one (letter is correct) 
	b test			                @Test the condition to repeat the loop 

letter_e:
	CMP R12, R5
	BEQ repeated
	MOV R5, R12
	SUB R10, R10, #1
	b test

letter_r:		  
	CMP R12, R6
	BEQ repeated
	MOV R6, R12
	SUB R10, R10, #1
	b test

letter_i:
	CMP R12, R7
	BEQ repeated
  MOV R7, R12
	SUB R10, R10, #1
	b test

letter_c:
	CMP R12, R8
	BEQ repeated
	MOV R8, R12
	SUB R10, R10, #1
	b test

letter_a:
	CMP R12, R9
	BEQ repeated
	MOV R9, R12
	SUB R10, R10, #1
	b test

repeated:				                @Letter already used 
	LDR R0, address_of_message5
  BL printf
	b loop
	
wrong:
	SUB R11, R11, #1		          @If wrong decrease guesses left by one
  CMP R11, #0			              @If gueses left = 0, user loses 
  BEQ lose

  LDR R0, address_of_message3
  BL printf 

  MOV R1, R11
  LDR R0, address_of_message4
  BL printf 

test:
  CMP R10, #0		              @if size of word = 0, no more letters to guess (win) 
  BNE loop
    
  MOV R0, #0			            @if win, return 0 
  b end

lose:
  MOV R0, #1			            @if lose return 1 
    
end:
  ADD sp, sp, #4              @Discard the integer read by scanf     
  LDR lr, [sp], #+4           @Pop the top of the stack and put it in lr 
  bx lr                       @Leave main
@********************************************************************************************   
address_of_message1: .word message1
address_of_message2: .word message2 
address_of_message3: .word message3
address_of_message4: .word message4
address_of_message5: .word message5
address_of_format:   .word format
