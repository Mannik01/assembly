/************************************
                                    Author: Mandip Silwal
                                    Program: Assembly program to count number of partitions
                                                                                        **********************************/

    .global main
    .func main

main:
    BL  _scanf              @ branch to scan procedure with return
    MOV R4, R0              @ store n in R4
    MOV R1, R0              @ pass n to partition partition    
    BL  _scanf              @ branch to scan procedure with return
    MOV R5, R0              @ store m in R5
    MOV R2, R0              @ pass m to partition procedure    
    BL  _partition          @ branch to partition procedure with return
    MOV R2, R4              @ pass n to printf procedure
    MOV R3, R5              @ pass n to printf procedure
    MOV R1, R0              @ pass result to printf procedure
    BL  _printf             @ branch to print procedure with return
    B   main                @ branch to exit procedure with no return


_printf:
    PUSH {LR}               @ store the return address
    LDR R0, =printf_str     @ R0 contains formatted string address
    @MOV R1, R1             @ R1 contains printf argument 1 (redundant line)
    @MOV R2, R2             @ R2 contains printf argument 2 (redundant line)
    BL printf               @ call printf
    POP {PC}                @ restore the stack pointer and return

_scanf:
    PUSH {LR}               @ store the return address
    PUSH {R1}               @ backup regsiter value
    LDR R0, =format_str     @ R0 contains address of format string
    SUB SP, SP, #4          @ make room on stack
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ remove value from stack
    POP {R1}                @ restore register value
    POP {PC}                @ restore the stack pointer and return

_partition:
    PUSH {LR}               @ store the return address

    CMP R1, #0              @ compare the input argument to 1
    MOVEQ R0, #1            @ set return value to 1 if equal
    POPEQ {PC}              @ restore stack pointer and return if equal

    CMP R1, #0              @ compare the input argument to 0
    MOVLT R0, #0            @ set return value to 0 if equal
    POPLT {PC}              @ restore stack pointer and return if equal

    CMP R2, #0              @ compare the input argument to 0
    MOVEQ R0, #0            @ set return value to 0 if equal
    POPEQ {PC}              @ restore stack pointer and return if equal


    PUSH {R1}               @ backup n
    PUSH {R2} 		    @ backup m
    MOV  R0, R2 	    @ m into R0
    MOV  R2, R1		    @ n into R2
    SUB R1, R2, R0          @ decrement the input argument
    MOV R2, R0              @ R0 into R2
    BL _partition           @ make recursive call

    
    POP {R2}                @ restore input argument n
    POP {R1}                @ restore input argument m
    PUSH {R0}               @ push R0 to stack
    SUB R2, R2, #1          @ subtract 1 from second argument
    BL _partition           @ make recursive call

    MOV R10, R0             @ move R0 to R10
    POP {R0}                @ get R0 value
    ADD R0, R0, R10         @ sum the two branches 
    POP  {PC}               @ restore the stack pointer and return

.data
number:         .word       0
format_str:     .asciz      "%d"
printf_str:     .asciz      "There are %d partitions of %d using integers upto %d\n"

