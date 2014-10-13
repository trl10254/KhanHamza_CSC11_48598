@Pupose: Efficient technique for calculating a/b and a%b
@Created by Hamza Khan

	.data
@First message	
.balign 4
message1 : .asciz "Hey, type a number as numerator:"

@Second message
.balign 4
message2 : .asciz "Now, type a number as denominator:"

@Thrid message
.balign 4
message3 : .asciz "%d divide by %d is %d\n"

@Fourth message
.balign 4
message4 : .asciz "The remainder is %d\n"

@Format pattern for scanf
.balign 4
scan_pattern : .asciz "%d"

@Where scanf will store the numberator
.balign 4
number_read1 : .word 0

@Where scanf will store the denominator
.balign 4
number_read2 : .word 0

.balign 4
return : .word 0

.balign 4
return2 : .word 0

	.text
	
division:
	LDR R1, address_of_return2
	STR lr, [R1]

        MOV R0, #0
        MOV R4, #1
        MOV R5, R3
        MOV R1, R2
        
divMod:
        CMP R1, R3
        BEQ case_equal
        BMI end 		@end it if R1<R3
        
scaleLeft:
        MOV R4, R4, LSL#1 	@division counter
        MOV R5, R5, LSL#1 	@Mod/Remainder subtraction
        CMP R1, R5
        BGE scaleLeft
	MOV R4, R4, LSR#1
	MOV R5, R5, LSR#1
	
addSub:
        ADD R0, R0, R4
        SUB R1, R1, R5
        
scaleRight:
        MOV R4, R4, LSR#1
        MOV R5, R5, LSR#1
        CMP R1, R5
        BMI scaleRight
        CMP R4, #1
        BGE addSub
        
end:
	LDR lr, address_of_return2
	LDR lr, [lr]
	bx lr
	
address_of_return2 : .word return2

case_equal:
        MOV R0, #1
        b end

.global main
main:
	LDR R1, address_of_return
	STR lr, [R1]

	LDR R0, address_of_message1
	BL printf

	LDR R0, address_of_scan_pattern
	LDR R1, address_of_number_read1
	BL scanf

	LDR R0, address_of_message2
	BL printf

	LDR R0, address_of_scan_pattern
	LDR R1, address_of_number_read2
	BL scanf

	LDR R0, address_of_number_read1
	LDR R2, [R0]
	LDR R0, address_of_number_read2
	LDR R3, [R0]
	BL division

	MOV R3, R0
	MOV R6, R1
	LDR R1, address_of_number_read1
	LDR R1, [R1]
	LDR R2, address_of_number_read2
	LDR R2, [R2]
	LDR R0, address_of_message3
	BL printf

	MOV R1, R6
	LDR R0, address_of_message4
	BL printf

	LDR lr, address_of_return
	LDR lr, [lr]
	bx lr
	
address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_message4 : .word message4
address_of_scan_pattern : .word scan_pattern
address_of_number_read1 : .word number_read1
address_of_number_read2 : .word number_read2
address_of_return :.word return

@External
.global printf
.global scanf
