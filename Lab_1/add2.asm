# Author: Brent Kuhn
# Date: 08/31/2018
# add2.asm--A program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
#  $t0 -used to hold th first number.
#  $t1 -used to hold the second number.
#  $t2 -used to hold the sum of the $t1 and $t2.
#  $v0 -syscall parameter and return value.
#  $a0 -syscall parameter.
.data
# Create the newline variable to print later
newline: .asciiz "\n"
.text
main: # Start execution at main
## Get the firs number from user, and put it into $t0
li $v0, 5
syscall
move $t0, $v0

## Get second number from user, put into $t1.
li $v0, 5
syscall
move $t1, $v0

# compute the sum.
add $t2, $t0, $t1

## Print out $t2.
move $a0, $t2 # Move $t2 into $a0 for printing
li $v0, 1 # Print int
syscall

li $v0, 4 # Print string
la $a0, newline # load address of the newline
syscall

## Print out $t2 as hex
move $a0, $t2 # Move $t2 into $a0 for printing
li $v0, 34 # Print hex
syscall

li $v0, 10   # syscall code 10 is for exit.
syscall    # make the syscall.
# end of add2.asm.
