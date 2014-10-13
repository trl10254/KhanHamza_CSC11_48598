<<<<<<< HEAD
@Pupose: Efficient technique for calculating a/b and a%b
@Created by Hamza Khan

	.data

@First Message
.balign 4
messgae1: .asciz "Enter a numerator and denominator: "

@Second Message
.balign 4
message2: .asciz "%d / %d is %d\n"

@Third Message
.balign 4
message3: .asciz "Reminder is %d\n"

@Format pattern for scanf
.balign 4
scan_pattern: .asciz "%d %d"

@Where scanf will store the numerator
.balign 4
number_read: .word 0

@Where scanf wills tore the denominator
.balign 4
number_read2: .word 0

.balign 4
return: .word 0

	.text
	.global main
main:
	LDR R1, address_of_return
	STR LR, [R1]

	LDR R0, address_of_message1
	BL printf

	LDR R0, address_of_scan_pattern
	LDR R1, address_of_number_read
	LDR R2, address_of_number_read2
	BL scanf

	LDR R2, address_of_number_read    
	LDR R2, [R2]
	LDR R3, address_of_number_read2
	LDR R3, [R3]                      
	MOV R4, #1     @scale factor*/
	MOV R5, R3     @subtraction factor*/
	MOV R0, #0     @counter*/
	MOV R1, R2     @remainder*/

	CMP R2, R3
	BLT output

scale_left:
	MOV R4, R4, LSR #1
	MOV R5, R5, LSL #1
	CMP R1, R5
	BGE scale_left
	MOV R4, R4, LSR #1
	MOV R5, R5, LSR #1

addSub:
	ADD R0, R0, R4
	SUB	R1, R1, R5
	b scale_right

scale_right: 
	MOV R4, R4, LSR #1
	MOV R5, R5, LSR #1
	CMP R1, R5
	BLT scale_right
	CMP R4, #1
	BGE addSub

output:
	MOV R3, R0
	MOV R4, R1
	LDR R1, address_of_number_read
	LDR R1, [R1]
	LDR R2, address_of_number_read2
	LDR R2, [R2]
	LDR R0, address_of_message2
	BL printf

	MOV R1, R4
	LDR R0, address_of_message3
	BL printf

end:
	LDR lr, address_of_return 
	LDR lr, [lr]
	bx lr

address_of_message1 : .word message1
address_of_message2 : .word message2
address_of_message3 : .word message3
address_of_scan_pattern : .word scan_pattern
address_of_number_read : .word number_read
address_of_number_read2 : .word number_read2
address_of_return : .word return
 
@External 
.global printf
.global scanf

