# Brent Kuhn --10/19/2018
# quadBitFloor.asm -- accepts two unsigned inputs and returns the smaller of the two
# Registers used:

.data
prompt1: .asciiz "Please input an unsigned integer:\n"
prompt2: .asciiz "Please input a second unsigned integer:\n"
resultOuput: .asciiz "QuadBitFloor = "
newLine: .asciiz "\n"
array: .space 16	#delcare a 16bit array

.text
main:
#prompt for the first number
li $v0, 4
la $a0, prompt1
syscall
#get the first number
li $v0, 5
syscall
addu $s0, $v0, $zero
#prompt for the second number
li $v0, 4
la $a0, prompt2
syscall
#get the second number
li $v0, 5
syscall
addu $s1, $v0, $zero

#move the saved numbers into a0 and a1
move $a0, $s0
move $a1, $s1

jal QuadBitFloor #Jump and link to QuadBitFloor

move $s2, $v0	#save the results from QuadBitFloor into $s2

#print the results from QuadBitFloor
la $a0, resultOuput
li $v0, 4
syscall

#print the result from QuadBitFloor
move $a0, $s2
li $v0, 34
syscall

la $a0, newLine
li $v0, 4
syscall

#move the result from QuadBitFloor into a0
move $a0, $s0
move $a1, $s1
jal PackedDigitCipher

li $v0, 10
syscall

QuadBitFloor:
	#push to the stack the return address
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t0, 0xf	#initialize bitmask for anding
	li $v0, 0	#load zero into v0 to avoid memory leaks
	whileQBF:
	beqz $t0, exitStack
		and $t1, $t0, $a0
		and $t2, $t0, $a1
		blt $t2, $t1, skipT2		#if t2 is less than t1, skip the move
			move $t2, $t1		#move t1 into t2
			skipT2:
			add $v0, $v0, $t2	#move the value in t2 into v0
			sll $t0, $t0, 4
		j whileQBF
	
	exitStack:
	#pop the return address from the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra  #return to the jal + 4 instruction

PackedDigitCipher:
	#push to the stack the return address
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	#call QuadBitFloor
	jal QuadBitFloor
	move $t0, $v0	#move the result from QuadBitFloor into t0
	
	li $t1, 0xf	#initialize bitmask for anding
	li $t2, 0 	#initialize a counter variable for shifting amount
	whilePDC:
	beqz $t1, exitPDCStack
		and $t3, $t0, $t1		#and with the bitmask and store it into t3
		srlv $t3, $t3, $t2		#shift t3 right by t2's value
		la $t4, array			#load the base address of the array
		add $t4, $t4, $t3		#calculate the location of the address which needs its count updated
		lb $t5, 0($t4)			#load the number already in the address
		addi $t5, $t5, 1		#add one to the value in the array
		sb $t5, 0($t4)			#store the 
		sll $t1, $t1, 4			#move the bitmask
		addi $t2, $t2, 4			#update the counter by 4 for shifting in the next iteration
		j whilePDC
	
	exitPDCStack:
	#create a loop that prints the values starting with base location +15 to the zero-th location
	li $t2, 16
	whilePrint:
	beqz $t2, exitPrint
		addi $t2, $t2, -1	#reduce the value of t2 by 1 every loop
		#srlv $t3, $t3, $t2		#shift t3 right by t2's value
		la $t4, array			#load the base address of the array
		add $t4, $t4, $t2		#calculate the location of the address which needs its count updated
		lb $t5, 0($t4)			#load the number already in the address
		
		li $v0, 1
		move $a0, $t5
		syscall
		
		j whilePrint
		
		
	
	exitPrint:
	#pull the return address from the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra  #return to the jal + 4 instruction
	
