@Blackjack
@Created by: Hamza Khan
@******************************************************************************************************************************
	.date

message:  
	.asciz "Welcome to Pirates Blackjack\n"
	
message1: 
	.asciz "In your wallet you have %d dabbollons\n"

message2: 
	.asciz "Dealer: How much loot are you willing to part with \n"
	
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
	push {lr} 						
    doWhile_r1_lt_r2: 			    
	MOV R3,R3,ASR #1; 		        
    MOV R2,R2,ASR #1 		        
	CMP r1,r2
	BLT doWhile_R1_lt_R2
	pop {lr} 						
	bx lr 							


addSub:
	push {lr} 						
	doWhile_r3_ge_1:
	ADD R0, R0, R3
	SUB R1, R1, R2
	BL scaleRight
	CMP R3, #1
	BGE doWhile_R3_ge_1
	pop {lr}					    
	bx lr 							 

	
scaleLeft:
	push {lr} 						
	doWhile_r1_ge_r2: 			    
	MOV R3, R3, LSL #1 		        
	MOV R2, R2,LSL #1 		        
	CMP R1, R2
	BGE doWhile_R1_ge_R2 	        
	MOV R3, R3, ASR #1 				
	MOV R2, R2, ASR #1 				
	pop {lr} 						
	bx lr							

	
division:
	push {lr} 													
	MOV R0, #0
	MOV R3, #1
	CMP R1, R2
	BLT end
	BL scaleLeft
	BL addSub

end:
	pop {lr} 						
	bx lr	
	
@*******************************************************************************************************************************
	.global main

	
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
