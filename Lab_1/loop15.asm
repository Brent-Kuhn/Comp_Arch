# Author: Brent Kuhn
# Date: 08/31/2018
# loop15.asm--A program that loops from 0 to 15
# Registers used:
#  $t1 -used to hold th couting number.
#  $t2 -used to hold the exit number.
#  $v0 -syscall parameter and return value.
#  $a0 -syscall parameter.
.data
# Create the newline variable to print later
newline: .asciiz "\n"
.text
main: # Start execution at main
li $t1, 0
li $t2, 16
# Create the loop starting from $t1 to $t2
L1: bge $t1, $t2, exit

## Print out $t2 as decimal
move $a0, $t1 # Move $t2 into $a0 for printing
li $v0, 1 # Print int
syscall

li $v0, 4 # Print string
la $a0, newline # load address of the newline
syscall

## Print out $t2 as hex
move $a0, $t1 # Move $t2 into $a0 for printing
li $v0, 34 # Print hex
syscall

li $v0, 4 # Print string
la $a0, newline # load address of the newline
syscall
add $t1, $t1, 1
j L1
exit:
li $v0, 10   # syscall code 10 is for exit.
syscall    # make the syscall.
# end of loop15.asm.
