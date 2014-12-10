@arrayInt
@By: Hamza Khan

	.data

.balign 4
tempArray: .skip 1024

.balign 4
val: .asciz "%d "                          /* equivalent to tempArray[i] */

.balign 4
newLine: .asciz "\n"

	.text
	.global main

/* fill array function */
/* number of elements passed as r0
/* array is passed as r1 */
fillArray:
    push {r4, r5, r6, r7, r8, lr}

    mov r4, r0      /* r4 holds the numbmer of elements */
    mov r5, r1      /* r5 holds the array */

    mov r7, #0   /* start counting from zero */
    mov r8, #32  /* initial temperature is 32 F */
    fillLoop:
       str r8, [r5, r7, lsl#2] 
       add r7, r7, #1           /* increment loop counter */
       add r8, r8, #5           /* increment temp in 5 degree increments */
       cmp r7, r4
       bne fillLoop
    
    pop {r4, r5, r6,r7, r8, lr}
    bx lr

/* Print the elements of an array
 * r0 = number of elements
 * r1 = the array
 */
printArray:
    push {r4, r5, r6, lr}

    mov r4, r0              /* r4 holds the number of elements */
    mov r5, r1              /* r5 holds the array */

    mov r6, #0              /* r6 holds the loop counter */
    printLoop:
        ldr r1, [r5, r6, lsl#2]    /* get the element */
        ldr r0, =val
        bl printf

        add r6, r6, #1      /* increment and check if looping is complete */
        cmp r4, r6
        bne printLoop        

        /* print a new line */
        ldr r0, =newLine
        bl printf

    pop {r4, r5, r6, lr}
    bx lr
  
/* coverts temperature from farenheit to celcius
 * r1 = initial temperature
 */
FtoC:
    push {lr}
    sub sp, sp, #4
   
    ldr r2, =0x8E38F       /* 20 bits    >>20 */ 
    sub r1, r1, #32        /* r1 = (Temp-32) */
    mul r1, r2, r1          /* r1 = r1 * (5/9)<<20 */ 
    mov r1, r1, lsr#20    /* r1 >> 20 */ 
    
    add sp, sp, #4
    pop {lr}
    bx lr

/* convert  array function */
/* number of elements passed as r0
/* array is passed as r1 */
convArray:
    push {r4, r5, r6, r7, r8, lr}

    mov r4, r0      /* r4 holds the numbmer of elements */
    mov r5, r1      /* r5 holds the array */

    mov r7, #0   /* start counting from zero */
    mov r8, #32  /* initial temperature is 32 F */
    convLoop:
       mov r1, r8
       bl FtoC                  /* FtoC returns temp in r1 */
              
       str r1, [r5, r7, lsl#2] 
       add r7, r7, #1           /* increment loop counter */
       add r8, r8, #5           /* increment temp in 5 degree increments */
       cmp r7, r4
       bne convLoop
    
    pop {r4, r5, r6,r7, r8, lr}
    bx lr


main:
    push {lr}
    sub sp, sp, #4      /* keep stack 8-byte aligned */

    mov r0, #199
    ldr r1, =tempArray
    bl fillArray

    mov r0, #199
    ldr r1, =tempArray
    bl printArray

    ldr r0, =newLine
    bl printf

    mov r0, #199
    ldr r1, =tempArray
    bl convArray

    mov r0, #199
    ldr r1, =tempArray
    bl printArray

           /* program complete. Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr