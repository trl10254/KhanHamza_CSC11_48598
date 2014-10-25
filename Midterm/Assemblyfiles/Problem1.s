@Midterm Problem 1
@By: Hamza Khan
@*********************************************************************
    .data

format: 
    .asciz "%d"

intro: 
    .asciz "\nPaycheck Calculator"

payrate: 
    .asciz "\nPayrate:  "

hours: 
    .asciz "Hours Worked:  "

error: 
    .asciz "\nERROR: Hours cannot exceed 60 per week\n"

pay: 
    .asciz "Gross Pay:  $%d\n"

payrate_value: 
    .word 0

hours_value: 
    .word 0

test: 
    .asciz "R1 = %d R2 = %d R3 = %d R4 = %d"
@**********************************************************************
    .text
@**********************************************************************
    .global main

main:
    push {lr}
    push {r0}
    
    LDR R0, addr_intro
    bl printf
  
    LDR R0, addr_payrate
    bl printf
    LDR R0, addr_format
    LDR R1, addr_payrate_value
    bl scanf

gethours:
    LDR R0, addr_hours
    bl printf
    LDR R0, addr_format
    LDR R1, addr_hours_value
    bl scanf
    
    LDR R1, addr_payrate_value
    LDR R1, [R1]
    LDR R2, addr_hours_value
    LDR R2, [R2]
    
    CMP R2, #60
    BGT invalid
    BAL valid
    
invalid:
    LDR r0, addr_error
    bl printf
    BAL gethours

valid:
    CMP R2, #40
    BGE tripleOT
    CMP R2, #20
    BGE doubleOT
    BAL outputPay
  
tripleOT:
    SUB R3, R2, #40
    MOV r0, #3
    MUL R3, R0, R3
    ADD R2, R3, #60
    BAL outputPay

doubleOT:
    SUB R3, R2, #20
    MOV R0, #2
    MUL R3, R0, R3
    ADD R2, R3, #20
    BAL outputPay

outputPay:
    MUL R1, R2, R1
    LDR R0, addr_pay
    BL printf
    
end:
    pop {r0}
    pop {pc}
    bx lr
@**********************************************************************
addr_p1intro: .word intro
addr_p1payrate: .word payrate
addr_p1hours: .word hours
addr_p1error: .word error
addr_p1pay: .word p1pay
addr_format: .word format
addr_p1test: .word test
addr_p1payrate_value: .word payrate_value
addr_p1hours_value: .word hours_value
.global printf
.global scanf