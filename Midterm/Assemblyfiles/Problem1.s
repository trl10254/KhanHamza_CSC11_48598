@Midterm Problem 1
@By: Hamza Khan
@*********************************************************************
    .data

format1: 
    .asciz "%d"

intro1: 
    .asciz "\nPaycheck Calculator"

payrate1: 
    .asciz "\nPayrate:  "

hours1: 
    .asciz "Hours Worked:  "

error1: 
    .asciz "\nERROR: Hours cannot exceed 60 per week\n"

pay1: 
    .asciz "Gross Pay:  $%d\n"

payrate_value1: 
    .word 0

hours_value1: 
    .word 0

test1: 
    .asciz "R1 = %d R2 = %d R3 = %d R4 = %d"
@**********************************************************************
    .text
@**********************************************************************
    .global main1

main1:
    push {lr}
    push {r0}
    
    LDR R0, addr_intro1
    bl printf
  
    LDR R0, addr_payrate1
    bl printf
    LDR R0, addr_format1
    LDR R1, addr_payrate_value1
    bl scanf

gethours1:
    LDR R0, addr_hours1
    bl printf
    LDR R0, addr_format1
    LDR R1, addr_hours_value1
    bl scanf
    
    LDR R1, addr_payrate_value1
    LDR R1, [R1]
    LDR R2, addr_hours_value1
    LDR R2, [R2]
    
    CMP R2, #60
    BGT invalid1
    BAL valid
    
invalid1:
    LDR r0, addr_error1
    bl printf
    BAL gethours1

valid1:
    CMP R2, #40
    BGE tripleOT1
    CMP R2, #20
    BGE doubleOT1
    BAL outputPay1
  
tripleOT1:
    SUB R3, R2, #40
    MOV r0, #3
    MUL R3, R0, R3
    ADD R2, R3, #60
    BAL outputPay

doubleOT1:
    SUB R3, R2, #20
    MOV R0, #2
    MUL R3, R0, R3
    ADD R2, R3, #20
    BAL outputPay1

outputPay1:
    MUL R1, R2, R1
    LDR R0, addr_pay1
    BL printf
    
end:
    pop {r0}
    pop {pc}
    bx lr
@**********************************************************************
addr_intro1: .word intro1
addr_payrate1: .word payrate1
addr_hours1: .word hours1
addr_error1: .word error1
addr_pay1: .word pay1
addr_format1: .word format1
addr_test1: .word test1
addr_payrate_value1: .word payrate_value1
addr_hours_value1: .word hours_value1
.global printf
.global scanf