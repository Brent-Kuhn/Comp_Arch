# Author: Brent Kuhn
# Date: 09/07/2018
# max2.asm--A program that computes and prints the sum
# of two numbers specified at runtime by the user.
# Registers used:
#  $t0 -used to hold the largest number
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
g_quotient: "g_quotient = "
g_remainder: "g_remainder = "
divide: "/"
.text
main: # Start execution at main
## Get the first number from user, and put it into $t1
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

## Find the max of the three integers
bge $t1, $t2, max1	# If t1 is larger than t2 go to max1

bge $t2, $t1, max2 	# If t2 is greater than t1 go to max2

max1: bge $t1, $t3, t1	# If t1 is greater than t3, go to t1
j t3			# Else jump to t3

max2: bge $t2, $t3, t2 	# If t2 is greater than t3, go to t2
j t3			# Else jump to t3

## Store t1, t2, or t3 into t0 depending on which branch is called, and jump to math
t1: add $t0, $t1, 0
j math
t2: add $t0, $t2, 0
j math
t3: add $t0, $t3, 0
j math

math:
## Print out the max value.
#move $a0, $t0 # Move $t3 into $a0 for printing
#li $v0, 1 # Print int
#syscall


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

li $t1, 0	# Create a counter starting from zero in t1
li $t2, 0
add $t2, $t7, 0	# Store t7 in t2

L3: blt $t7, $t0, exit
sub $t7, $t7, $t0
add $t1, $t1, 1
j L3

exit:
la $a0, g_quotient
li $v0, 4
syscall

## Print out the max value.
move $a0, $t1 # Move $t3 into $a0 for printing
li $v0, 1 # Print int
syscall

# Print new line
la $a0, newline
li $v0, 4
syscall

# Print the string for remainder info
la $a0, g_remainder
li $v0, 4
syscall

# Print the numerator of the remainder
move $a0, $t7
li $v0, 1
syscall

# Print the division smybol
la $a0, divide
li $v0, 4
syscall

# Print the denominator of the remainder
move $a0, $t0
li $v0, 1
syscall

li $v0, 10   # syscall code 10 is for exit.
syscall    # make the syscall.
# end of add2.asm.
