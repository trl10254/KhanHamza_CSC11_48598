@Array Function
@*********************************************************************************************************************
	.data
.balign 4
intOut: 
	.asciz "%d "

.balign 4
newLine: 
	.asciz "\n"

@this array holds the value of the 52 cards in the deck */
@card =  2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A */
.balign 4
cardVal:
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
@*********************************************************************************************************************
	.text
@fill array function 
@number of elements passed as R0 
@array is passed as R1 
	.global fillArray
fillArray:
    push {R4 - R8, lr}
    @push {R4, R5, R6, R7, R8, lr}        @R8 is unused 

    MOV R4, R0                           @R4 holds the numbmer of elements
    MOV R5, R1                           @R5 holds the array
    MOV R7, #0                           @start counting from zero

fillLoop:
    STR R7, [R5, R7, lsl#2]
    ADD R7, R7, #1                    @increment loop counter 
    CMP R7, R4
    BNE fillLoop

   pop {R4 - R8, lr}
   @pop {R4, R5, R6, R7, R8, lr}
   bx lr
@*********************************************************************************************************************
@Print the elements of an array
@R0 = number of elements
@R1 = input array
	.global printArray	
printArray:
    push {R4, R5, R6, lr}
    MOV R4, R0                             @R4 holds the number of elements
    MOV R5, R1                             @R5 holds the array
    MOV R6, #0                             @R6 holds the loop counter
	
printLoop:
    LDR R1, [R5, R6, lsl #2]            @get the element
    LDR R0, adr_intOut
    BL printf

    ADD R6, R6, #1                     @increment and check if looping is complete
    CMP R4, R6
    BNE printLoop
	
    LDR R0, adr_newLine
    BL printf

    POP {R4, R5, R6, lr}
    bx lr

@Shuffle an array
@R0 = number of elements
@R1 = input array
	.global shuffle
shuffle:
    push {r4-r10, lr}
    @push {r4, r5, r6, r7, r8, r9, r10, lr}

    MOV R4, R0                              @save the number of elements
    MOV R5, R1                              @and the array 

    @shuffle 7 times
    MOV R6, #0                              @R6 holds number of times shuffled
 
shuffleLoop:
    @swap elements 
    MOV R7, #0                          @R7 holds counter for shuffleLoop

swapLoop:
    MOV R0, #0                      @min for random
    MOV R1, R4                      @max, for random 
    BL random                       @get the index of the number to swap, in R0 

    MOV R3, R0                      @save the index returned from random 
    LDR R1, [R5, R3, lsl #2]        @save array[i] 
    LDR R2, [R5, R7, lsl #2]        @save array[random]
    
    STR R1, [R5, R7, lsl #2]        @swap the values  
    STR R2, [R5, R3, lsl #2]
	
    ADD R7, R7, #1
    CMP R7, R4
    BNE swapLoop
   
    ADD R6, R6, #1              
    CMP R6, #7
    BNE shuffleLoop

    pop {R4 - R10, lr}
    bx lr

@Function gets a card
@index where next card is                  R0
@get index from shuffled array passed in   R1
@get card from card value array in         R2

	.global getCard
getCard:
    push {R4, R5, R6, lr}
    
    MOV R4, R0
    MOV R5, R1
    MOV R6, R2
    LDR R4, [R5, R4, lsl #2]     @grab card from 

    LDR R4, [R6, R4, lsl#2] 

    MOV R0, R4

    pop {R4, R5, R6, lr}
    bx lr

@Function deals the initial two cards to player and dealer
@index of next card passed in        R0
@array holding cards passed in       R1
@array where cards are placed is in  R2
@index where to place card           R3

	.global deal
deal:
    push {R4 - R8, lr}     

    MOV R4, R0                      @index 
    MOV R5, R1                      @card array 
    MOV R6, R2                      @output array 
    MOV R7, R3

    MOV R0, R4
    MOV R1, R5
    LDR R2, adr_cardVal
    BL getCard                  @getCard returns a card in R0 

    STR R0, [R6, R7, lsl #2]

    pop {R4 - R8, lr}
    bx lr

@Function adds the values of the cards in a hand
@checks for aces and changes their value from 11 to 1
@if they would cause player to bust
  
@pass the number of elements in                  R0
@pass the array in                               R1
@pass stop condition in(21=player, 17=dealer) in R2
@return the sum in                               R0
 
	.global sumArray
sumArray:
    push {R4 - R10,  lr}

    MOV R4, R0                @save num elements 
    MOV R5, R1                @save the array 
    MOV R9, R2
    MOV R6, #0                @initialize the sum 
    MOV R7, #0                @Initialize the num of aces
    MOV R8, #0                @initialize loop counter

sumLoop:
    LDR R0, [R5, R8, lsl #2]
    ADD R6, R6, R0
    CMP R0, #11
    ADDEQ R7,R7, #1

    ADD R8, R8, #1
    CMP R8, R4
    BNE sumLoop

aceLoop:                   @keep aces from resulting in bust 
    CMP R7, #0             @if no aces dealt, Exit 
    BEQ exit
    CMP R6, R9             @hand with aces != bust, Exit 
    BLE exit
    SUB R6, R6, #10        @otherwise change value of ace to 1, sub 10 from hand 
    SUB R7, R7, #1
    b aceLoop

exit: 
    MOV R0, R6                @return the sum in r0 

    pop {R4-R10,  lr}
    bx lr
@*********************************************************************************************************************
adr_newLine: .word newLine
adr_intOut: .word intOut
adr_cardVal: .word cardVal