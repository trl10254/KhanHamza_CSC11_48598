Midterm Menu
By: Hamza Khan
@***********************************************************************
	.data

format: 
	.asciz "%d"

list_format: 
	.asciz "\n+--------------------------+"

list_top: 
	.asciz "\n\n+--------------------------+\n| Midterm                  |"

list_choices: 
	.asciz "\n| [1] Paycheck Creator  |\n| [2] ISP Bill Creator  |\n| [3] Fibonacci Calculator |"

getchoice: 
	.asciz "\nEnter choice:  "
@***********************************************************************
	.text
@***********************************************************************
	.global menu

menu:
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
@***********************************************************************
addr_format: .word format
addr_list_top: .word list_top
addr_list_format: .word list_format
addr_list_choices: .word list_choices
addr_getchoice: .word getchoice