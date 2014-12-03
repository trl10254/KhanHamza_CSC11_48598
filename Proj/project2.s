@Blackjack
@Created by: Hamza Khan
@******************************************************************************************************************************
	.date

message:  
	.asciz "Welcome to Pirates Blackjack\n"
	
message1: 
	.asciz "In your wallet you have 100 dabbollons\n"

message2: 
	.asciz "Dealer: How much loot are you willing to part with %d\n\n"
	
message3: 
	.asciz "Dealer: Get ready to lose your loot mate.\n"
	
message4: 
	.asciz "Dealer: Here's your first card you landluber %d\n"
	
message5: 
	.asciz "Dealer: Here's your second card %d\n"
	
message6:
	.asciz "Your card total is %d\n\n"

message7:
	.asciz "Dealer: Oy mate! Are you gonna stay or hit. Enter 1 to hit anything else to exit\n"
	
message8:
	.asciz "Dealer: Here's your third card %d\n"
	
message9:
	.asciz "Your card total is %d\n\n"
	
message10:
	.asciz "Dealer: My first card is a %d \n"
	
message11:
	.asciz "Dealer: My second card is a %d \n\n"
	
message12:
	.asciz "The dealers total is %d\n\n"
	
message13:
	.asciz "Dealer: I'm gonna hit\n"
	
message14:
	.asciz "Dealer: My third card is a %d\n"
	
message15:
	.asciz "The dealers total is %d\n\n"
	
message16:
	.asciz "Dealer: Looks like I won mate. Are you ready to go to Davy Jones Locker. HaHaHaHa. \n"

message17:
	.asciz "Dealer: Damn you! I lost! Beginner's luck I say mate.\n"
	
format:
	.asciz "%d"

scan_pattern:
	.word 0
	
number_read:
	.word 0
@******************************************************************************************************************************
	.text
	
scaleRight:
	push {lr} 						@ Push lr onto the stack
    doWhile_r1_lt_r2: 			    @ Shift right until just under the remainder
	mov r3,r3,ASR #1; 		        @ Division counter
    mov r2,r2,ASR #1 		        @ Mod/Remainder subtraction
	cmp r1,r2
	blt doWhile_r1_lt_r2
	pop {lr} 						@ Pop lr from the stack
	bx lr 							


addSub:
	push {lr} 						@ Push lr onto the stack
	doWhile_r3_ge_1:
	add r0,r0,r3
	sub r1,r1,r2
	bl scaleRight
	cmp r3,#1
	bge doWhile_r3_ge_1
	pop {lr}						@ Pop lr from the stack
	bx lr 							 

	
scaleLeft:
	push {lr} 						@ Push lr onto the stack
	doWhile_r1_ge_r2: 			    @ Scale left till overshoot with remainder
	mov r3,r3,LSL #1 		        @ scale factor
	mov r2,r2,LSL #1 		        @ subtraction factor
	cmp r1,r2
	bge doWhile_r1_ge_r2 	        @ End loop at overshoot
	mov r3,r3,ASR #1 				@ Scale factor back
	mov r2,r2,ASR #1 				@ Scale subtraction factor back
	pop {lr} 						@ Pop lr from the stack
	bx lr							

	
division:
	push {lr} 						@ Push lr onto the stack
									@ Determine the quotient and remainder
	mov r0,#0
	mov r3,#1
	cmp r1,r2
	blt end
	bl scaleLeft
	bl addSub

end:
	pop {lr} 						@ Pop lr from the stack
	bx lr

bet:
	str lr, [sp,#4]
	sub sp, sp, #4
	ldr r0, address_of_message0
	bl printf
	ldr r0, address_of_format		@Store the input from the user
	mov r1, sp
	bl scanf
		
	add r1, sp, #4
	ldr r1, [sp]
	bl money

money:
	mov r11, #100
	ldr r0, address_of_message01
	bl printf
	bl mtotal

mtotal:
	sub r1, r11, r1
	mov r11, r1
	ldr r0, address_of_message02
	bl printf
	bl card1
@*******************************************************************************************************************************
	.global main

main:
	push {lr}	 					 @ Push lr onto the top of the stack	
	mov r0,#0 						 @Set time(0)
	bl time 						 @ Call time 
	bl srand 						 @ Call srand
	
	mov r4,#0 						 @ Setup loop counter
	
	ldr r0, address_of_message
	bl printf
	bl bet
	

	.global card1
card1:	 							 @ Create a random number
	bl rand 						 @ Call rand
	mov r1, r0, asr #1 				 @ In case random return is negative
	mov r2, #11 					 @ Move 11 to r2
									 @ We want rand()%11+1 so cal division function with rand()%11
	bl division						 @ Call division function to get remainder
	add r1, #1 						 @ Remainder in r1 so add 1 giving between 1 and 11
	mov r5, r1
	ldr r0, address_of_message4		 @ Set message4 as the first parameter of printf
	bl printf 						 @ Call printf	
	bl card2

	.global card2
card2:	 							 @ Create a random number
	bl rand 						 @ Call rand
	mov r1, r0, asr #1 				 @ In case random return is negative
	mov r2, #11 				     @ Move 11 to r2
									 @ We want rand()%11+1 so cal division function with rand()%11
	bl division						 @ Call division function to get remainder
	add r1, #1 						 @ Remainder in r1 so add 1 giving between 1 and 11
	mov r6, r1
	ldr r0, address_of_message5		 @ Set message2 as the first parameter of printf
	bl printf	                     @ Call printf

	.global total

total:
	add r6, r6, r5				     @Add R6 and R5
	mov r1, r6
	ldr r0, address_of_message6      @Display total
	bl printf
	cmp r6, #21					     @Check to see if the user total is 21
	beq Win						     @If so the user wins
	bl ncard					     @If not prompt the user to choose whether or not hit or stay
	
	.global ncard

ncard:
	str lr, [sp,#4]
	sub sp, sp, #4
	ldr r0, address_of_message7		@Prompt the user to hit or stay
	bl printf
	ldr r0, address_of_format		@Store the input from the user
	mov r1, sp
	bl scanf
	
	add r1, sp, #4
	ldr r1, [sp]
	cmp r1, #1						@If the user inputs 1 brach to card3
	beq card3
	bl Dealers_card1
	
	.global card3
	
card3:
	bl rand 						@ Call rand
	mov r1,r0,asr #1 				@ In case random return is negative
	mov r2,#11 						@ Move 11 to r2
									@ We want rand()%11+1 so cal division function with rand()%11
	bl division						@ Call division function to get remainder
	add r1,#1 						@ Remainder in r1 so add 1 giving between 1 and 11
	mov r7, r1
	ldr r0, address_of_message7		@ Set message7 as the first parameter of printf
	bl printf 						@ Call printf
	bl ntotal

ntotal:
	add r7, r7, r6					@Add r7 and r6
	mov r1, r7						
	ldr r0, address_of_message9		@Output the user total
	bl printf
	cmp r7, #21
	beq Win
	cmp r7, #21
	bgt Lose
	bl Dealers_card1
	
Dealers_card1:
	bl rand 						@ Call rand
	mov r1,r0,asr #1 				@ In case random return is negative
	mov r2,#11 						@ Move 11 to r2
									@ We want rand()%11+1 so cal division function with rand()%11
	bl division						@ Call division function to get remainder
	add r1,#1 						@ Remainder in r1 so add 1 giving between 1 and 11
	mov r8, r1
	ldr r0, address_of_message10	@ Set message7 as the first parameter of printf
	bl printf 						@ Call printf	
	bl Dealers_card2

	.global Dealers_card2

Dealers_card2:
	bl rand 						   @ Call rand
	mov r1, r0, asr #1 				   @ In case random return is negative
	mov r2, #11 					   @ Move 11 to r2
									   @ We want rand()%11+1 so cal division function with rand()%11
	bl division						   @ Call division function to get remainder
	add r1, #1 						   @ Remainder in r1 so add 1 giving between 1 and 11
	mov r9, r1
	ldr r0, address_of_message11	   @ Set message8 as the first parameter of printf
	bl printf 			
	bl Dealers_Total

	.global Dealers_Total

Dealers_Total:
	add r8, r8, r9				        @Add r8 and r9
	mov r1, r8
	ldr r0, address_of_message12	    @Output the users total
	bl printf					
	cmp r8, #14
	ble Dealers_card3

	.global Dealers_card3

Dealers_card3:
	bl rand
	mov r1, r0, asr #1
	mov r2, #11
	
	bl division
	add r1, #1
	mov r10, r1
	ldr r0, address_of_message14
	bl printf
	bl Dealers_ftotal
	
Dealers_ftotal:
	add r8, r8, r10
	mov r1, r8
	ldr r0, address_of_message15
	bl printf
	bl check
	

check:
	cmp r7, #21
	bgt Lose
	cmp r8, #21
	bgt Win
	cmp r7, r8						@Compare the results
	bgt Win							@Declare who wins
	blt Lose						@Declare who losses
	

Win:
	ldr r0, address_of_message17	@Output the results
	bl printf
	bal end						    @End the game

Lose:
	ldr r0, address_of_message16	@Output the results
	bl printf
	bal end						    @End the game
	
end:
	pop {lr} 						
	bx lr 							
@*******************************************************************************************************************************
 address_of_message:   .word message
 address_of_message1:  .word message1
 address_of_message2:  .word message2
 address_of_message3:  .word message3
 address_of_message4:  .word message4
 address_of_message5:  .word message5
 address_of_message6:  .word message6
 address_of_message7:  .word message7
 address_of_message8:  .word message8
 address_of_message9:  .word message9
 address_of_message10: .word message10
 address_of_message11: .word message11
 address_of_message12: .word message12
 address_of_message13: .word message13
 address_of_message14: .word message14
 address_of_message15: .word message15
 address_of_message16: .word message16
 address_of_message17: .word message17
 address_of_format: .word format