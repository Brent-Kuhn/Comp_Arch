# Brent Kuhn --09/21/2018
# To_lowercase.asm--A program that convert uppercase to lowercase
# Registers used:
# That's your turn!!! Put used registers here.

.data
string: .asciiz "HeLlo WoRld"	# We want to lower this string
newline: .asciiz "\n"

.text
main:
	la $t0, string		# Load here the string
	toLowerCase:
		lb $t2, 0($t0)	# Get the first byte pointed by the address
		beqz $t2, end	# if is equal to zero, the string is terminated
		blt $t2, 65, continue	# If (character < 'A'
		# |--------------------------------------||Put your code here ||--------------------------------------|
		ble $t2, 90, upperCaseTest2	# If character <= 'Z' jump to test2
		j continue
	upperCaseTest2:		
		add $t2, $t2, 32
		j isUpperCase
	
	continue:	# Continue the iteration
		addi $t0, $t0, 1	# Increment the address
		j toLowerCase
		
	isUpperCase:		# add 32, so it goes lower case
		#|--------------------------------------||Put your code here ||--------------------------------------|
		sb $t2, 0($t0)	# store it in the string
		j continue	# continue iteration as always
		
	end:
	li $v0, 4		# Print the string
	la $a0, string 
	syscall
	li $v0, 4		# A nice newline
	la $a0, newline
	syscall 	#Exit the program 
	li $v0, 10
	syscall