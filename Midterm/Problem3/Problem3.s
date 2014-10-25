Midterm Problem 3
By: Hamza Khan
@***********************************************************************
	.data

format: 
	.asciz "%d"

intro: 
	.asciz "\nFibonacci Calculator"

term: 
	.asciz "\nEnter term:  "

error: 
	.asciz "\nERROR: Invalid term: %d\n"

result: 
	.asciz "Result:  %d"

term_value: 
	.asciz "%d"
@***********************************************************************
	.text
@***********************************************************************
	.global main

main:
    push {lr}
    push {R0}
    
    LDR R0, addr_intro
    bl printf
    
getterm:
    LDR R0, addr_term
    bl printf
    LDR R0, addr_format
    LDR R1, addr_term_value
    bl scanf
    
    LDR R1, addr_term_value
    LDR R1, [R1]
    CMP R1, #0
    BLE invalid    
    
valid:
    cmp r1, #1
    beq term1
    cmp r1, #2
    beq term2
    
    MOV R0, #0
    MOV R2, #0
    MOV R3, #1
    SUB R1, R1, #1
    
calculate:
    ADD R0, R2, R3
    MOV R2, R3
    MOV R3, R0
    SUB R1, R1, #1
    CMP R1, #1
    BGT calculate
    BAL print_value
    
term1:
    MOV r3, #0
    BAL print_value
    
term2:
    MOV R3, #1
    BAL print_value
    
invalid:
    LDR R0, addr_error
    bl printf
    BAL getterm
    
print_value:
    MOV R1, r3
    LDR R0, addr_result
    bl printf
    
end:
    pop {r0}
    pop {pc}
    bx lr
@***********************************************************************
addr_format: .word format
addr_p3intro: .word intro
addr_p3term: .word term
addr_p3error: .word error
addr_p3result: .word result
addr_p3term_value: .word term_value
