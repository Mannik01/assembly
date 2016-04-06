@ author: Mandip Silwal		@ ID: 1001214877

	.global main
        .func main

main:
	BL  _scanf		@ branch to scanf procedure with return
	MOV R10, R0		@ move return value to R10
	BL  _getchar		@ get character from user
	MOV R8, R0		@ move return value to R8
	BL  _scanf		@ branch to scanf procedure with return
	MOV R9, R0		@ move return value to R9	
	MOV R1, R10		@ move R10 content to R1
	MOV R2, R8		@ move R8 content to R2 
	MOV R3, R9		@ move R9 content to R3 
	BL  _compare		@ branch to compare procedure
	MOV R5, R0		@ move R0 content to R5
	BL  _printf		@ branch to printf procedure
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
	MOV  R4, LR		@ store LR since printf call overwrites
	CMP  R2, #'+'		@ compare against "+" char
	BLEQ _sum		@ branch and link if equal to "+"
	CMP  R2, #'-'		@ compare against "-" char
        BLEQ _dif		@ branch and link if equal to "-"
	CMP  R2, #'*'		@ compare against "*" char
        BLEQ _mult		@ branch and link if equal to "*"
	CMP  R2, #'M'		@ compare against "M" char
        BLEQ _max		@ branch and link if equal to "M"
	MOV  PC, R4		@ return

_sum:
	ADD R0, R1, R3 		@ add R1 and R3 and store in R0
	MOV PC, LR		@ return 

_dif:
        SUB R0, R1, R3		@ sub R1 and R3 and store in R0
        MOV PC, LR		@ return

_mult:
        MUL R0, R1, R3		@ multiply R1 and R3 and store in R0
        MOV PC, LR		@ return

_max:
        CMP   R1, R3		@ compare R1 and R3
        MOVGT R0, R1		@ move R1 to R0 if greater than
	MOVLT R0, R3		@ move R3 to R0 if less than
        MOV PC, LR		@ return

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
