@Midterm Problem 2
@By: Hamza Khan

@**********************************************************************
	.data

format: 
	.asciz "%d"

list_format: 
	.asciz "\n+----------------+"

list_top: 
	.asciz "\n\n+----------------+\n| Packages       |"

list_choices: 
	.asciz "\n| [1] Package A  |\n| [2] Package B  |\n| [3] Package C  |"

intro: 
	.asciz "\nISP Bill Calculator"

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
	.text
@**********************************************************************
	.global main

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
.global printf
.global scanf