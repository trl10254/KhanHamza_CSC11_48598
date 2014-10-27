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
@Problem 2 data
format: 
	.asciz "%d"

list_format: 
	.asciz "\n+----------------+"

list_top: 
	.asciz "\n\n+----------------+\n| Packages       |"

list_choices: 
	.asciz "\n| [1] Package A  |\n| [2] Package B  |\n| [3] Package C  |"

intro: 
	.asciz "\nBill Creator"

package: 
	.asciz "\nPackage:  "

hours: 
	.asciz "Hours Used:  "

error: 
	.asciz "\nERROR: Package %d not recognized\n"

bill: 
	.asciz "Amount Due:  $%d"

test: 
	.asciz "R1 = %d R2 = %d"

package_value: 
	.word 0

hours_value: 
	.word 0
@**********************************************************************
@Problem 3 data
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
@**********************************************************************
	.text
@**********************************************************************
	.global main
@Main Menu
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
@Problem 2
main:
    push {lr}
    push {r0}
    
    LDR R0, addr_intro
    bl printf

    LDR R0, addr_list_top
    bl printf

    LDR R0, addr_list_format
    bl printf

    LDR R0, addr_list_choices
    bl printf

    LDR R0, addr_list_format
    bl printf
  
getpackage:
    LDR R0, addr_package
    bl printf

    LDR R0, addr_format
    LDR R1, addr_package_value
    bl scanf

gethours:
    LDR R0, addr_hours
    bl printf
    LDR R0, addr_format
    LDR R1, addr_hours_value
    bl scanf

    LDR R1, addr_package_value
    LDR R1, [R1]
    LDR R2, addr_hours_value
    LDR R2, [R2]
    
    CMP r1, #1
    BEQ packageA
    CMP r1, #2
    BEQ packageB
    CMP r1, #3
    BEQ packageC
    BAL invalid
  
invalid:
    LDR R0, addr_error
    LDR R1, addr_package_value
    bl printf
    BAL getpackage
  
packageA:
    MOV R0, #30
    CMP R2, #22
    BGT pA_gt_22
    CMP R2, #11
    BGT pA_gt_11
    MOV R2, #0
    BAL pA_end

pA_gt_22:
    SUB R3, R2, #22
    MOV R1, #2
    MUL R3, R1, R3
    ADD R2, R3, #11
    BAL pA_end

pA_gt_11:
    SUB R2, R2, #11
    bal pA_end

pA_end:
    MOV R1, #3
    MUL R3, R2, R1
    BAL output
    
packageB:
    MOV R0, #35
    CMP R2, #44
    BGT pB_gt_44
    CMP R2, #22
    BGT pB_gt_22
    MOV R2, #0
    BAL pB_end

pB_gt_44:
    SUB R3, R2, #44
    MOV R1, #2
    MUL R3, R1, R3
    ADD R2, R3, #22
    BAL pB_end

pB_gt_22:
    SUB R2, R2, #22
    BAL pB_end

pB_end:
    MOV R1, #2
    MUL R3, R2, R1
    BAL output
    
packageC:
    MOV R0, #40
    CMP R2, #66
    BGT pC_gt_66
    CMP R2, #33
    BGT pC_gt_33
    MOV R2, #0
    BAL pC_end

pC_gt_66:
    SUB R3, R2, #66
    MOV R1, #2
    MUL R3, R1, r3
    ADD R2, R3, #33
    BAL pC_end

pC_gt_33:
    SUB R2, R2, #11
    BAL pC_end

pC_end:
    MOV R3, R2
    BAL output
    
output:
    ADD R1, R0, R3
    LDR R0, addr_bill
    bl printf
    BAL end
    
end:
    pop {r0}
    pop {lr}
    bx lr
@**********************************************************************
@Problem 3
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
@**********************************************************************
addr_format: .word format
addr_list_top: .word list_top
addr_list_format: .word list_format
addr_list_choices: .word list_choices
addr_getchoice: .word getchoice
addr_intro: .word intro
addr_payrate: .word payrate
addr_hours: .word hours
addr_error: .word error
addr_pay: .word pay
addr_format: .word format
addr_test: .word test
addr_payrate_value: .word payrate_value
addr_hours_value: .word hours_value
addr_format: .word format
addr_intro: .word intro
addr_package: .word package
addr_hours: .word hours
addr_error: .word error
addr_bill: .word bill
addr_package_value: .word package_value
addr_hours_value: .word hours_value
addr_test: .word test
addr_list_top: .word list_top
addr_list_format: .word list_format
addr_list_choices: .word list_choices
ddr_format: .word format
addr_intro: .word intro
addr_term: .word term
addr_error: .word error
addr_result: .word result
addr_term_value: .word term_value
.global printf
.global scanf