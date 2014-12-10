@Divmod
@********************************************************************************************************************
	.text
@********************************************************************************************************************	
	.global scaleRight
	
scaleRight:
	push {lr}             @Push lr onto the stack 	
	doWhile_r1_lt_r2:     @Shift right until just under the remainder 
	MOV R3, R3, ASR #1;     @Division counter 
	MOV R2, R2, ASR #1      @Mod/Remainder subtraction 
	CMP R1,R2
	BLT doWhile_r1_lt_r2
	pop {lr}              @Pop lr from the stack 
    bx lr                 @Leave scaleRight 

	.global addSub
	
addSub:
	push {lr}       @Push lr onto the stack 
	doWhile_r3_ge_1:
	ADD R0, R0, R3
	SUB R1, R1, R2
	BL scaleRight
	CMP R3, #1
	BGE doWhile_r3_ge_1
    pop {lr}       @Pop lr from the stack 
    bx lr          @Leave addSub 

	.global scaleLeft
	
scaleLeft:
	push {lr}             @Push lr onto the stack 
	doWhile_r1_ge_r2:     @Scale left till overshoot with remainder 
	MOV R3, R3, LSL #1    @scale factor 
    MOV R2, R2, LSL #1    @subtraction factor 
    CMP R1, R2
	BGE doWhile_r1_ge_r2  @End loop at overshoot 
	MOV R3, R3, ASR #1    @Scale factor back 
	MOV R2, R2, ASR #1    @Scale subtraction factor back 
	pop {lr}              @Pop lr from the stack 
    bx lr                 @Leave addSub 

	.global divMod
	
divMod:
	push {lr}       @Push lr onto the stack
	
	@Determine the quotient and remainder 
	MOV R0, #0
	MOV R3, #1
	CMP R1, R2
	BLT end
	BL scaleLeft
	BL addSub
	
end:
	pop {lr}       @Pop lr from the stack
    bx lr          @Leave addSub