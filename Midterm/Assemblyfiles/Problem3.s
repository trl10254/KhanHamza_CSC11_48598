@Midterm Problem 3
@By: Hamza Khan
@***********************************************************************
	.data

format3: 
	.asciz "%d"

intro3: 
	.asciz "\nFibonacci Calculator"

term3: 
	.asciz "\nEnter term:  "

error3: 
	.asciz "\nERROR: Invalid term: %d\n"

result3: 
	.asciz "Result:  %d"

term_value3: 
	.asciz "%d"
@***********************************************************************
	.text
@***********************************************************************
	.global main3

main3:
    push {lr}
    push {R0}
    
    LDR R0, addr_intro3
    bl printf
    
getterm3:
    LDR R0, addr_term3
    bl printf
    LDR R0, addr_format3
    LDR R1, addr_term_value3
    bl scanf
    
    LDR R1, addr_term_value3
    LDR R1, [R1]
    CMP R1, #0
    BLE invalid3  
    
valid3:
    cmp r1, #1
    beq term13
    cmp r1, #2
    beq term23
    
    MOV R0, #0
    MOV R2, #0
    MOV R3, #1
    SUB R1, R1, #1
    
calculate3:
    ADD R0, R2, R3
    MOV R2, R3
    MOV R3, R0
    SUB R1, R1, #1
    CMP R1, #1
    BGT calculate3
    BAL print_value3
    
term13:
    MOV r3, #0
    BAL print_value3
    
term23:
    MOV R3, #1
    BAL print_value3
    
invalid3:
    LDR R0, addr_error3
    bl printf
    BAL getterm3
    
print_value3:
    MOV R1, r3
    LDR R0, addr_result3
    bl printf
    
end3:
    pop {r0}
    pop {pc}
    bx lr
@***********************************************************************
addr_format3: .word format3
addr_intro3: .word intro3
addr_term3: .word term3
addr_error3: .word error3
addr_result3: .word result3
addr_term_value3: .word term_value3
.global printf
.global scanf
