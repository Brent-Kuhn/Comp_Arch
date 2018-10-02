# Author: Brent Kuhn
# Date: 09/07/2018
# max2.asm--A program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
#  $t1 -used to hold th first number.
#  $t2 -used to hold the second number.
#  $t3 -used to hold the larger number of $t1 and $t2.
#  $v0 -syscall parameter and return value.
#  $a0 -syscall parameter.
.data
# Create the newline variable to print later
newline: .asciiz "\n"
.text
main: # Start execution at main
## Get the firs number from user, and put it into $t1
li $v0, 5
syscall
move $t1, $v0

## Get second number from user, put into $t2.
li $v0, 5
syscall
move $t2, $v0

# Check to see which is bigger and move it to t3
beq $t1, $t2, equal_values	# Branch if $t1 == $t2
blt $t1, $t2, t2_bigger		# Branch if $t1 < $t2
bgt $t1, $t2, t1_bigger		# If $t1 > $t2, branch to t0_bigger

equal_values: 
move $t3, $t1	# Move t1 to t3
j exit		# Jump to exit
t2_bigger: 
move $t3, $t2	# Move t2 to t3
j exit		# Jump to exit
t1_bigger: 
move $t3, $t1	# Move t1 to t3
j exit		# Jump to exit

exit:
## Print out the max value.
move $a0, $t3 # Move $t3 into $a0 for printing
li $v0, 1 # Print int
syscall

li $v0, 4 # Print string
la $a0, newline # load address of the newline
syscall

## Print out $t2 as hex
move $a0, $t3 # Move $t2 into $a0 for printing
li $v0, 34 # Print hex
syscall

li $v0, 10   # syscall code 10 is for exit.
syscall    # make the syscall.
# end of add2.asm.
