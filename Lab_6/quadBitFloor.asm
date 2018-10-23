# Brent Kuhn --10/19/2018
# quadBitFloor.asm -- accepts two unsigned inputs and returns the smaller of the two
# Registers used:

.data
prompt1: .asciiz "Please input an unsigned integer:\n"
prompt2: .asciiz "Please input a second unsigned integer:\n"
resultOuput: .asciiz "QuadBitFloor = "
newLine: .asciiz "\n"

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
	#pull the return address from the stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra  #return to the jal + 4 instruction
