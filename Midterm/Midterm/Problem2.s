@Midterm Problem 2
@By: Hamza Khan

@**********************************************************************
	.data

format2: 
	.asciz "%d"

list_format2: 
	.asciz "\n+----------------+"

list_top2: 
	.asciz "\n\n+----------------+\n| Packages       |"

list_choices2: 
	.asciz "\n| 1. Package A  |\n| 2. Package B  |\n| 3. Package C  |"

intro2: 
	.asciz "\nBill Creator"

package2: 
	.asciz "\nEnter in what package you have:  "

hours2: 
	.asciz "How many hours were used:  "

error2: 
	.asciz "\nERROR: Package %d not recognized\n"

bill2: 
	.asciz "The amount due is:  $%d"

test2: 
	.asciz "R1 = %d R2 = %d"

package_value2: 
	.word 0

hours_value2: 
	.word 0
@**********************************************************************
	.text
@**********************************************************************
	.global problem2

problem2:
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
    BL printf
    LDR R0, addr_format2
    LDR R1, addr_hours_value2
	BL scanf

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
    BAL pC_end2

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
    pop {pc}
    mov pc, lr
@**********************************************************************
addr_format2: .word format2
addr_intr2: .word intro2
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
.global printf
.global scanf