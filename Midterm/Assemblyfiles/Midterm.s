@Midterm
@By: Hamza Khan

@**********************************************************************
    .data
@Menu data
format: 
    .asciz "%d"

list_format: 
    .asciz "\n+--------------------------+"

list_top: 
    .asciz "\n\n+--------------------------+\n| Midterm                  |"

list_choices: 
    .asciz "\n| 1. Paycheck Creator     |\n| 2. Bill Creator     |\n| 3. Fibonacci Calculator |"

getchoice: 
    .asciz "\nEnter choice:  "
@**********************************************************************
@Problem 1 data
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
@Problem 2 data
format2: 
    .asciz "%d"

list_format2: 
    .asciz "\n+----------------+"

list_top2: 
    .asciz "\n\n+----------------+\n| Packages       |"

list_choices2: 
    .asciz "\n| [1] Package A  |\n| [2] Package B  |\n| [3] Package C  |"

intro2: 
    .asciz "\nBill Creator"

package2: 
    .asciz "\nPackage:  "

hours2: 
    .asciz "Hours Used:  "

error2: 
    .asciz "\nERROR: Package %d not recognized\n"

bill2: 
    .asciz "Amount Due:  $%d"

test2: 
    .asciz "R1 = %d R2 = %d"

package_value2: 
    .word 0

hours_value2: 
    .word 0
@**********************************************************************
@Problem 3 data
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
@**********************************************************************
    .text
@**********************************************************************
@Main Menu
    .global main

main:
    push {lr}
    
    LDR R0, addr_list_top
    bl printf

    LDR R0, addr_list_format
    bl printf

    LDR R0, addr_list_choices
    bl printf

    LDR R0, addr_list_format
    bl printf

    LDR R0, addr_getchoice
    bl printf

    SUB sp, sp, #4 /*make room*/
    LDR R0, addr_format
    MOV R1, SP
    bl scanf
    ldr R0, [sp]
    
    ADD sp, sp, #+4
    pop {lr} 
    bx lr
@**********************************************************************
@Problem 1
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
    BAL valid1
    
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
    BAL outputPay1

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
    
end1:
    pop {r0}
    pop {pc}
    bx lr
@**********************************************************************
@Problem 2
    .global main2

main2:
    push {lr}
    push {r0}
    
    LDR R0, addr_intro2
    bl printf

    LDR R0, addr_list_top2
    bl printf

    LDR R0, addr_list_format2
    bl printf

    LDR R0, addr_list_choices2
    bl printf

    LDR R0, addr_list_format2
    bl printf
  
getpackage2:
    LDR R0, addr_package2
    bl printf

    LDR R0, addr_format2
    LDR R1, addr_package_value2
    bl scanf

gethours2:
    LDR R0, addr_hours2
    bl printf2
    LDR R0, addr_format2
    LDR R1, addr_hours_value2
    bl scanf

    LDR R1, addr_package_value2
    LDR R1, [R1]
    LDR R2, addr_hours_value2
    LDR R2, [R2]
    
    CMP r1, #1
    BEQ packageA2
    CMP r1, #2
    BEQ packageB2
    CMP r1, #3
    BEQ packageC2
    BAL invalid2
  
invalid2:
    LDR R0, addr_error2
    LDR R1, addr_package_value2
    bl printf
    BAL getpackage2
  
packageA2:
    MOV R0, #30
    CMP R2, #22
    BGT pA_gt_222
    CMP R2, #11
    BGT pA_gt_112
    MOV R2, #0
    BAL pA_end2

pA_gt_222:
    SUB R3, R2, #22
    MOV R1, #2
    MUL R3, R1, R3
    ADD R2, R3, #11
    BAL pA_end2

pA_gt_112:
    SUB R2, R2, #11
    bal pA_end2

pA_end2:
    MOV R1, #3
    MUL R3, R2, R1
    BAL output2
    
packageB2:
    MOV R0, #35
    CMP R2, #44
    BGT pB_gt_442
    CMP R2, #22
    BGT pB_gt_222
    MOV R2, #0
    BAL pB_end2

pB_gt_442:
    SUB R3, R2, #44
    MOV R1, #2
    MUL R3, R1, R3
    ADD R2, R3, #22
    BAL pB_end2

pB_gt_222:
    SUB R2, R2, #22
    BAL pB_end2

pB_end2:
    MOV R1, #2
    MUL R3, R2, R1
    BAL output2
    
packageC2:
    MOV R0, #40
    CMP R2, #66
    BGT pC_gt_662
    CMP R2, #33
    BGT pC_gt_332
    MOV R2, #0
    BAL pC_end

pC_gt_662:
    SUB R3, R2, #66
    MOV R1, #2
    MUL R3, R1, r3
    ADD R2, R3, #33
    BAL pC_end2

pC_gt_332:
    SUB R2, R2, #11
    BAL pC_end2

pC_end2:
    MOV R3, R2
    BAL output2
    
output2:
    ADD R1, R0, R3
    LDR R0, addr_bill2
    bl printf
    BAL end2
    
end2:
    pop {r0}
    pop {lr}
    bx lr
@**********************************************************************
@Problem 3
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
@**********************************************************************
addr_format: .word format
addr_list_top: .word list_top
addr_list_format: .word list_format
addr_list_choices: .word list_choices
addr_getchoice: .word getchoice
addr_intro1: .word intro1
addr_payrate1: .word payrate1
addr_hours1: .word hours1
addr_error1: .word error1
addr_pay1: .word pay1
addr_format1: .word format1
addr_test1: .word test1
addr_payrate_value1: .word payrate_value1
addr_hours_value1: .word hours_value1
addr_format2: .word format2
addr_intro2: .word intro2
addr_package2: .word package2
addr_hours2: .word hours2
addr_error2: .word error2
addr_bill2: .word bill2
addr_package_value2: .word package_value2
addr_hours_value2: .word hours_value2
addr_test2: .word test2
addr_list_top2: .word list_top2
addr_list_format2: .word list_format2
addr_list_choices2: .word list_choices2
addr_format3: .word format3
addr_intro3: .word intro3
addr_term3: .word term3
addr_error3: .word error3
addr_result3: .word result3
addr_term_value3: .word term_value3
.global printf
.global scanf