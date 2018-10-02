# Author: Brent Kuhn
# Date: 09/07/2018
# max2.asm--A program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
#  $t1 -used to hold the first number.
#  $t2 -used to hold the second number.
#  $t3 -used to hold the larger number of $t1 and $t2.
#  $t4 -used to count loops
#  $t5 -used to save integers during the loop
#  $t6 -used to save integers during the second loop
#  $t7 -used to store the sum of all the products
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

## Get third number from user, put into $t3.
li $v0, 5
syscall
move $t3, $v0

li $t4, 1	# Load 1 into t4 for incramenting the loop
move $t5, $t1	# move the first value into t5 for incramented looping
# Create the loop to calculate a*b
L1: bge $t4, $t2, second
add $t4, $t4, 1
add $t5, $t5, $t1

j L1

second:
li $t4, 1	# Load 1 into t4 for incramenting the loop
move $t6, $t5	# move the result from the first loop into t6 for incramented looping
# Create the loop to calculate a*b*c
L2: bge $t4, $t3, third
add $t4, $t4, 1
add $t6, $t6, $t5

j L2

third:
add $t7, $t1, $t5
add $t7, $t7, $t6

exit:
## Print out the max value.
move $a0, $t7 # Move $t3 into $a0 for printing
li $v0, 1 # Print int
syscall

li $v0, 10   # syscall code 10 is for exit.
syscall    # make the syscall.
# end of add2.asm.
