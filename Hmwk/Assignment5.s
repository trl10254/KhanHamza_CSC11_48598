Pupose: Efficient technique for calculating a/b and a%b
Created by Hamza Khan

	.data
 
message1: .asciz "Type a number: "
format:   .asciz "%d"
message2: .asciz "The factorial of %d is %d\n"
 
	.text
 
factorial:
    STR lr, [sp,#-4]!  @Push lr onto the top of the stack 
    STR R0, [sp,#-4]!  @ Push R0 onto the top of the stack 

                       @Note that after that, sp is 8 byte aligned 
    CMP R0, #0         @compare R0 and 0 
    BNE is_nonzero     @if R0 != 0 then branch 
    MOV R0, #1         @R0 ? 1. This is the return 
    b end

is_nonzero:
                       @Prepare the call to factorial(n-1) 
    SUB R0, R0, #1     @R0 ? R0 - 1 
    bl factorial
                       @ After the call R0 contains factorial(n-1) 
                       @Load R0 (that we kept in th stack) into R1 
    LDR R1, [sp]       @R1 ? *sp 
    MUL R0, R1, R0     @R0 ? R0 * R1 
 
end:
    ADD sp, sp, #+4    @Discard the R0 we kept in the stack 
    LDR lr, [sp], #+4  @Pop the top of the stack and put it in lr 
    bx lr              @Leave factorial 
 
	.globl main

main:
    STR lr, [sp, #-4]!           @Push lr onto the top of the stack 
    SUB sp, sp, #4               @Make room for one 4 byte integer
    							 @in the stack 
                                 @In these 4 bytes we will keep the number 
                                 @entered by the user 
                                 @Note that after that the stack is 8-byte aligned 

    LDR R0, address_of_message1  @Set &message1 as the first parameter 
    							 @of printf 

    bl printf                    @Call printf 
 
    LDR R0, address_of_format    @Set &format as the first parameter 
    							 @of scanf 

    MOV R1, sp                   @Set the top of the stack as the 
    							 @second parameter 

                                 @of scanf 
    bl scanf                     @Call scanf 
 
    LDR R0, [sp]                 @Load the integer read by scanf into 
    							 @R0 
                                 @So we set it as the first parameter of factorial 

    bl factorial                 @Call factorial 
 
    MOV R2, R0                   @Get the result of factorial and move 
    							 @into R2 
                                 @ So we set it as the third parameter of printf 

    LDR R1, [sp]                 @Load the integer read by scanf into 
    							 @R1 
                                 @ So we set it as the second parameter of printf 

    LDR R0, address_of_message2  @ Set &message2 as the first parameter 
    							 @of printf 

    bl printf                    @ Call printf 
 
 
    ADD sp, sp, #+4              @Discard the integer read by scanf 
    LDR lr, [sp], #+4            @Pop the top of the stack and put it 
    							 @in lr

    bx lr                        @Leave main 

 
address_of_message1: .word message1
address_of_message2: .word message2
address_of_format: .word format