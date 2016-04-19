
@ author: Mandip Silwal		@ ID: 1001214877


	.global main
        .func main

main:
	BL  _scanf
	MOV R10, R0
	BL  _getchar
	MOV R8, R0
	BL  _scanf
	MOV R9, R0
	MOV R1, R10
	MOV R2, R8
	MOV R3, R9
	BL  _compare
	MOV R5, R0
	BL  _printf
	B   main

_scanf:
	MOV R4, LR              @ store LR since scanf call overwrites
    	SUB SP, SP, #4          @ make room on stack
    	LDR R0, =format_num     @ R0 contains address of format num
    	MOV R1, SP              @ move SP to R1 to store entry on stack
    	BL  scanf                @ call scanf
    	LDR R0, [SP]            @ load value at SP into R0
    	ADD SP, SP, #4          @ restore the stack pointer
    	MOV PC, R4              @ return

_getchar:
    	MOV R7, #3              @ write syscall, 3
    	MOV R0, #0              @ input stream from monitor, 0
    	MOV R2, #1              @ read a single character
    	LDR R1, =read_char      @ store the character in data memory
    	SWI 0                   @ execute the system call
    	LDR R0, [R1]            @ move the character to the return register
    	AND R0, #0xFF           @ mask out all but the lowest 8 bits
    	MOV PC, LR              @ return

_compare:
	MOV  R4, LR
	CMP  R2, #'+'
	BLEQ _sum
	CMP  R2, #'-'
        BLEQ _dif
	CMP  R2, #'*'
        BLEQ _mult
	CMP  R2, #'M'
        BLEQ _max
	MOV  PC, R4

_sum:
	ADD R0, R1, R3
	MOV PC, LR

_dif:
        SUB R0, R1, R3
        MOV PC, LR

_mult:
        MUL R0, R1, R3
        MOV PC, LR

_max:
        CMP   R1, R3
        MOVGT R0, R1
	MOVLT R0, R3
        MOV PC, LR

_printf:
	MOV R4, LR              @ store LR since printf call overwrites
    	LDR R0, =printf_str     @ R0 contains formatted string address
	MOV R1, R5              @ R1 contains printf argument (redundant li$
    	BL  printf              @ call printf
    	MOV PC, R4              @ return

.data
format_num:	.asciz		"%d"
read_char:      .ascii          " "
printf_str:     .asciz          "%d\n"
