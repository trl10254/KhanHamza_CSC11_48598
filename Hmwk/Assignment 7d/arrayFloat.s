@arrayFloat
@By: Hamza Khan

	.data

.balign 4
tempArray: .skip 2048

.balign 4
floatArray: .skip 2048

.balign 4
valOut: .asciz "%f " 

.balign 4
intOut: .asciz "%d "
.balign 4
newLine: .asciz "\n"

.balign 4
initial: .float 32.0

.balign 4
thirtyTwo: .float 32.0
.balign 4
five: .float 5.0
.balign 4
nine: .float 9.0

/* hold the converted farenheit temperature */
.balign 4
converted: .float 0

/* this is to test. Delete later */
testInt: .word 212

.balign 4
tstMess: .asciz "In conversion\n"

.balign 4
tstMess2: .asciz "working\n"


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

/* Print the elements of an int array
 * r0 = number of elements
 * r1 = the array
 */
printInts:
    push {r4, r5, r6, lr}

    mov r4, r0                           /* r4 holds the number of elements */
    mov r5, r1                           /* r5 holds the array */

    mov r6, #0                           /* r6 holds the loop counter */
    intsLoop:
        ldr r1, [r5, r6, lsl#2]          /* get the element */
        ldr r0, =intOut
        bl printf

        add r6, r6, #1                    /* increment and check if looping is complete */
        cmp r4, r6
        bne intsLoop        

        /* print a new line */
        ldr r0, =newLine
        bl printf

    pop {r4, r5, r6, lr}
    bx lr

/* Print the elements of an float array
 * r0 = number of elements
 * r1 = the array
 */
printFloats:
    push {r4, r5, r6,  lr}

    mov r4, r0                           /* r4 holds the number of elements */
    mov r5, r1                           /* r5 holds the array */

    mov r6, #0                           /* r6 holds the loop counter */
    floatsLoop:
@        ldr r2, =testInt                /* DELETE: This is for testing */
        ldr r2, [r5, r6, lsl#2]          /* get the element */

@         mov r1, r2
@         bl FtoC                        /* Convert the number */

@        ldr r1, =converted
@        vldr s0, [r1]

        vcvt.f64.f32 d2, s0              /* convert to double for printing */
        ldr r0, =valOut
        vmov r2, r3, d2
        bl printf
    
        add r6, r6, #1                   /* increment and check if looping is complete */
        cmp r4, r6
        bne floatsLoop        

        /* print a new line */
        ldr r0, =newLine
        bl printf

    pop {r4, r5, r6, lr}
    bx lr

  
/* coverts temperature from farenheit to celcius
 * takes int argument returns a float (f32)
 * r1 = initial temperature
 * new temp in s0
 */
FtoC:
    push {r4, lr}
    sub sp, sp, #8 

    vldr s0, [r1]                  
    vcvt.f32.s32 s0, s0            /* r1 held an int convert it to float */ 

    ldr r1, =thirtyTwo             /* Get registers ready to put into floaing point */
    ldr r2, =five
    ldr r3, =nine

    vldr s1, [r1]                  /* Load the registers */
    vldr s2, [r2]
    vldr s3, [r3]

    vsub.f32 s0, s0, s1         /* This is (F-32) as part of conversion */
    vmul.f32 s0, s0, s2         /* This is (f-32)*5 */
    vdiv.f32 s0, s0, s3         /* This is ((f-32)*5)/9 */

    /* Save the converted temperature for later use  
    ldr r0, ad_converted
    vmov r1,s3
    str r1,[r0]
    */

    add sp, sp, #8
    pop {r4, lr}
    bx lr

    ad_converted: .word converted

/* convert  array function */
/* number of elements passed as r0
/* input array is r1 */
/* destination is r2 */
convArray:
    push {r4, r5, r6, r7, r8, lr}

    mov r4, r0                    /* r4 holds the numbmer of elements */
    mov r5, r1                    /* r5 holds the input array */
    mov r6, r2                    /* r6 holds the destination array */

    ldr r0, =tstMess2
    bl printf

    mov r7, #0                    /* start counting from zero */
    convLoop:
       ldr r1, [r5, r7, lsl#2]
       bl FtoC                    /* FtoC returns temp in s0 */

       vmov r8, s0 
       str r8, [r6, r7, lsl#2]
       add r7, r7, #1             /* increment loop counter */
       cmp r7, r4
       bne convLoop
    
    pop {r4, r5, r6,r7, r8, lr}
    bx lr

main:
    push {lr}
    sub sp, sp, #4                /* keep stack 8-byte aligned */

    mov r0, #199                 /* fill array with integers */
    ldr r1, =tempArray
    bl fillArray

    mov r0, #199                 /* print the integer array */
    ldr r1, =tempArray
    bl printInts

    ldr r0, =newLine             /* seperate the printed arrays */
    bl printf

    ldr r0, =tstMess        /* test DELETE */
    bl printf
   
    mov r0, #199                /* convert the array */
    ldr r1, =tempArray
    ldr r2, =floatArray
    bl convArray

    ldr r0, =tstMess        /* test Delete */
    bl printf

    mov r0, #199                 /* print an array of float */
    ldr r1, =floatArray
    bl printFloats

/*
    ldr r0, =newLine
    bl printf
    mov r0, #199
    ldr r1, =tempArray
    bl printArray
*/

           /* program complete. Exit stage right */
    add sp, sp, #4
    pop {lr}
    bx lr