@Random Function

	.global random
	
random:
    push {R4, R5, R6, lr}

    MOV R4,R0                         @Save min in R4 
    MOV R5, R1                        @Save max in R5 

    BL rand                           @Call rand 
    
    MOV R1, R0, asr #1                @In case random return is negative 
    MOV R2, R5
    BL divMod                         @Call divMod function to get remainder 
                                      @divmod returns in R1, R1 

    MOV R0, R1                        @return result in R0 
    ADD R0, R0, R4

    POP {R4, R5, R6, lr}              @Pop the top of the stack and put it in lr 
    bx lr                             @Leave main 