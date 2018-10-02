# Brent Kuhn --09/20/2018
# strlength.asm--A program that determine the length of a null terminated string
# Registers used:
#  $t0 -used to hold the loop counter
#  $a0 -used to hold the address of string 
#  $v0 -syscall parameter and return value

.data 
	str: .asciiz "The fierce winds of Hurricane Florence are weakening as it creeps closer to North Carolina but the impact of the immense storm will still be catastrophic for millions of people."

.text
	# Load address of string into a0
	la $a0, str		# Load address into a0

strlen:
	li $t0, 0		# initialize the count to zero
loop:
	lb $t1, 0($a0)		# load the next character into t1
	beqz $t1, exit		# check for the null character
	add $t0, $t0, 1		# increase the value of the counter by 1
	add $a0, $a0, 1
	j loop

exit:
	li $v0, 1
	move $a0, $t0
	syscall
	li $v0, 10
	syscall