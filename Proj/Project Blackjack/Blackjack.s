@Pirate Blackjack
@By: Hamza Khan
@*********************************************************************************************************************
	.data 
@Output messages
.balign 4
mess: 
	.asciz "Value is: %d\n"

.balign 4
shwPlyr: 
	.asciz "You have:   "

.balign 4
shwDlr: 
	.asciz "Blackbeard: Well looks like I have: "

.balign 4
bjMess: 
	.asciz "High Seas Blackjack!\n"

.balign 4
hitStand: 
	.asciz "Blackbeard: Oy mate! Are you gonna sit there all day or are you gonna hit(h) or stay(s): "

.balign 4
plyrBst: 
	.asciz "You: Damn I went over\n"

.balign 4
dlrBst: 
	.asciz "Blackbeard: Curses! I went over.\n"

.balign 4
plyrWins: 
	.asciz "You: Cough up the loot Blackbeard. I won.\n"

.balign 4
dlrWins:  
	.asciz "Blackbeard: Seems like your loot is now mine. HaHaHa.\n"

.balign 4
push: 
	.asciz "Push\n"

.balign 4
betMsg: 
	.asciz "Blackbeard: Well How much loot are you willing to part with mate: "

.balign 4
prntBal: .asciz "The amount of loot you have is  $%f\n"

.balign 4
playMsg: 
	.asciz "Blackbeard: Well do you want to play again(y) mate? Maybe next time we up the stakes."

.balign 4
brkMsg: 
	.asciz "You: NOOOOOOOOOO! I can't be broke!\n"
@Format of the game
hsFormat: 
	.asciz " %c"
betForm: 
	.asciz "%f"
@Data
.balign 4
plyrScr: 
	.word 0
.balign 4
dlrScr: 
	.word 0
.balign 4
hsChoice: 
	.word 0
.balign 4
playAns: 
	.word 0
.balign 4
balance: 
	.float 100.00
.balign 4
betAmnt: 
	.float 0
@blackjack win payout 3:2 
.balign 4
bjPay: 
	.float 1.5
@arrays holding the hand of the player and dealer 
@array padded with room for three more cards
 
 .balign 4
dlrHnd: 
	.skip 56
.balign 4
plyrHnd: 	
	.skip 56
.balign 4
spltHnd: 
	.skip 56
@this array holds the value of the 52 cards in the deck 
@card =  2, 3, 4, 5, 6, 7, 8, 9, 10, J,  Q,  K,  A
.balign 4
cardVal: 
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
    .word 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10, 11
@This array will hold the index of which card to draw next
shflIndx: 
	.skip 56
@this array holds the index of the next card to be dealt 
.balign 4
shuflIndx: 
	.skip 220
@the index of the next card to be dealt 
.balign 4
cIndx: .word 0
@Total number of cards in the deck. 
nCard: 
	.word 52
.balign 4
newLine: 
	.asciz "\n" 
@********************************************************************************************************************
	.text
@********************************************************************************************************************
	.global main
main:
    push {lr}
    SUB sp,sp, #4
    @seed random number generator 
    MOV R0, #0
    BL time
    BL srand
    LDR R0, adr_nCard       @initialize index with 0-51 
    LDR R0, [r0]
    LDR R1, adr_shflIndx
    BL fillArray
	LDR R0, adr_nCard       @Shuffle the index
	LDR R0, [r0]
    LDR R1, adr_shflIndx
    BL shuffle
	
	MOV R5, #0				@r5 holds number of cards that are dealt
@Start the game here	
play:
    LDR R0, adr_newLine
    BL printf
    LDR R0, adr_balance
    VLDR s10, [r0]
    VCVT.f64.f32 d0, s10
    VMOV R2, R3, d0
    LDR R0, adr_prntBal
    BL printf
    LDR R0, adr_betMsg
    BL printf
    LDR R0, adr_betForm
    LDR R1, adr_betAmnt
    BL scanf
    LDR R0, adr_newLine
    BL printf
 
    MOV R6, #0                    @R6 holds number of cards player has been dealt 
    MOV R7, #0                    @R7 holds number of cards dealer has been dealt 
	
dealPlyr:
    MOV R0, R5
    LDR R1, adr_shflIndx
    LDR R2, adr_plyrHnd
    MOV R3, R6
    BL deal
    ADD R5, R5, #1    
    ADD R6, R6, #1                @increment num  cards dealt to player 
    CMP R6, #2
    BNE	dealPlyr
dealDlr:
    LDR R1, adr_shflIndx
    LDR R2, adr_dlrHnd
    MOV R3, R7
    BL deal
    ADD R5, R5, #1    
    ADD R7, R7, #1                @increment num cards dealt to dealer 
    CMP	R7, #2
    BNE	dealDlr
    LDR R0, adr_shwDlr
    BL printf
    MOV R0, #1                    @don't show dealer hole card 
    LDR R1, adr_dlrHnd
    BL printArray

    LDR R0, adr_shwPlyr          @show player what they've got
    BL printf
	
    MOV R0, R6
    LDR R1, adr_plyrHnd
    BL printArray
    @Check if player has blackjack  only after initial cards are dealt 
    MOV R0, R6                @sum the total 
    LDR R1, adr_plyrHnd
    BL sumArray               @returns sum in r0
    CMP R0, #21 
    BEQ bjWin
plyrCont:
    LDR R0, adr_newLine
    BL printf
    LDR R0, adr_hitStand
    BL printf
	
    LDR R0, adr_hsFormat
    LDR R1, adr_hsChoice
    BL scanf
    LDR R1, adr_hsChoice              @get user choice read by scanf
    LDR R1, [r1]
    CMP	R1, #'h' 
    BEQ choiceH 
    b choiceS                         @anything other than 'h' is stay   
choiceH:                          @player choose to get another card
	LDR R0, adr_newLine
	BL printf
	
    MOV R0, R5
    LDR R1, adr_shflIndx
    LDR R2, adr_plyrHnd
    MOV R3, R6
    BL deal
    ADD R5, R5, #1
    ADD R6, R6, #1
    LDR r0, adr_shwPlyr            @show player what they've got 
    BL printf
	
    MOV r0, r6
    LDR r1, adr_plyrHnd
    BL printArray

    @after card has been dealt check if player has busted 
    MOV R0, R6                @sum the total
    LDR R1, adr_plyrHnd
    MOV R2, #21
    BL sumArray               @returns sum in r0 

    CMP	R0, #21 
    BGT plyrBstd

    LDR R1, adr_plyrScr      @if player has not busted save the score 
    STR	R0, [r1]  

    b plyrCont

choiceS:                        @player stays. 

    LDR R0, adr_newLine
    BL printf

dealNext:
    MOV R0, R5
    LDR R1, adr_shflIndx
    LDR R2, adr_dlrHnd
    MOV R3, R7
    BL deal
    ADD R5, R5, #1
    ADD R7, R7, #1

    LDR R0, adr_shwDlr            @show player what dealer has 
    BL printf
    MOV R0, R7
    LDR R1, adr_dlrHnd
    BL printArray

    @after card has been dealt check if dealer has 
    MOV R0, R7                @sum the total
    LDR R1, adr_dlrHnd
    MOV R2, #17               @dealer hits on soft 17 
    BL sumArray               @returns sum in r0 

    CMP R0, #21              @dealer has busted 
    BGT dlrBstd
	
    CMP R0, #17              @dealer no longer hits
    BGE checkWinner 
    b dealNext
 
checkWinner:
    LDR R1, adr_plyrScr
    LDR R1, [R1]
    CMP R1, R0                   @dealer hand in r0, player hand in r1
    BEQ pushWon
    BGT plyrWon
    BLT dlrWon

pushWon:
    LDR R0, =push
    BL printf
    b playAgain
	
plyrWon:
	LDR R0, adr_newLine
	BL printf
    LDR R0, =plyrWins
    BL printf

    @add bet to player balance 
    LDR R0, adr_balance
    VLDR s10, [R0]
    LDR R1, adr_betAmnt
    VLDR s11, [R1]
    VADD.f32 s10, s10, s11
    VSTR s10, [R0]                   @save the new balance 
    VCVT.f64.f32 d0, s10             @print the  new balance 
    VMOV R2, R3, d0
    LDR R0, adr_prntBal 
    BL printf

    b playAgain

dlrWon:
	LDR R0, adr_newLine
	BL printf
    LDR R0, =dlrWins
    BL printf

    @subtract bet amount from player
    LDR R0, adr_balance
    VLDR s10, [R0]
    LDR R1, adr_betAmnt
    VLDR s11, [R1]
    VSUB.f32 s10, s10, s11
    VSTR s10, [R0]                   @save the new balance 
    VCVT.f64.f32 d0, s10
    VMOV R2, R3, d0
    LDR R0, adr_prntBal 
    BL printf

    b playAgain

plyrBstd:
    LDR R0, adr_plyrBst
    BL printf

    @subtract bet amount from player 
    LDR R0, adr_balance
    VLDR s10, [R0]
    LDR R1, adr_betAmnt
    VLDR s11, [R1]
    VSUB.f32 s10, s10, s11
    VSTR s10, [R0]                   @save the new balance 
    VCVT.f64.f32 d0, s10
    VMOV R2, R3, d0
    LDR R0, adr_prntBal 
    BL printf

    b playAgain

dlrBstd:
    @add bet amount from player
	LDR R0, adr_newLine
	BL printf
	
    LDR R0, adr_dlrBst
    BL printf

    @add bet to player balance 
    LDR R0, adr_balance
    VLDR s10, [R0]
    LDR R1, adr_betAmnt
    VLDR s11, [R1]
    VADD.f32 s10, s10, s11
    VSTR s10, [R0]                   @save the new balance 

    VCVT.f64.f32 d0, s10
    VMOV R2, R3, d0
    LDR R0, adr_prntBal 
    BL printf

    b playAgain

bjWin:
    LDR R0, adr_bjMess
    BL printf

    @add bet to player balance 
    LDR R0, adr_balance
    VLDR s10, [R0]
    LDR R1, adr_betAmnt
    VLDR s11, [R1]

    LDR R0, adr_bjPay
    VLDR s12, [R0]
    
    VMUL.f32 s11, s12, s11        @increase original bet amount to 3:2 

    VADD.f32 s10, s10, s11
    VSTR s10, [R0]
    VCVT.f64.f32 d0, s10
    VMOV R2, R3, d0
    LDR R0, adr_prntBal 
    BL printf
    
    b playAgain

playAgain:
    @check if player is broke
    LDR R0, adr_balance
    VLDR s10, [R0]
    VCVT.s32.f32 s10, s10
    VMOV R2, s10
	MOV R1, #0
	CMP R2, R1
	BLE broke

    LDR R0, adr_newLine
    BL printf

    LDR R0, adr_playMsg
    BL printf

    LDR R0, adr_hsFormat                     @re-use hsFormat to read in char
    LDR R1, adr_playAns 
    BL scanf
   
    LDR R0, adr_playAns
    LDR R0, [r0]
    CMP R0, #'y'
    BEQ play        

broke:                                        @player has no money remaining
    LDR R0, adr_brkMsg
    BL printf
    
exit:
    ADD sp, sp, #4
    pop {lr}
    bx lr
@*********************************************************************************************************************
adr_cardVal: .word cardVal
adr_shflIndx: .word shflIndx
adr_nCard: .word nCard
adr_newLine: .word newLine
adr_plyrHnd: .word plyrHnd
adr_dlrHnd: .word dlrHnd
adr_cIndx: .word cIndx
adr_shwDlr: .word shwDlr
adr_shwPlyr: .word shwPlyr
adr_bjMess: .word bjMess
adr_hitStand: .word hitStand
adr_hsFormat: .word hsFormat
adr_hsChoice: .word hsChoice
adr_dlrBst: .word dlrBst
adr_plyrBst: .word plyrBst
adr_plyrScr: .word plyrScr
adr_betMsg: .word betMsg
adr_betForm: .word betForm
adr_betAmnt: .word betAmnt
adr_prntBal: .word prntBal
adr_balance: .word balance
adr_bjPay: .word bjPay
adr_playMsg: .word playMsg
adr_playAns: .word playAns
adr_brkMsg: .word brkMsg
