# Brent Kuhn --09/21/2018
# check_hex.asm -- check to see if a word is composed of hex chars
# Registers used:


.data
string: .asciiz "Your string: "
newline: .asciiz "\n"
userString: .space 200

.text
main:
	li $v0, 8 		#take in input
	la $a0, userString 	#load byte space into address
	addi $a1, $zero, 200
	syscall

	move $s1, $a0		# Save the string to $s1

	la $a0, string 		#load and print "you wrote" string
	li $v0, 4
	syscall

	#li $v0, 4         
	#la $a0, ($s1) 		#load and print your string ==> can replace ($t1) with userString
        #syscall
	
	la $t1, userString	#load the base address of the string into t1
	
	#move $a0, $t2
	#li $v0, 11		#print the current character
	#syscall
	
	
checkWord:
	lb $t2, ($t1)		#load the first byte of the string
	lb $t3, ($t1)		#load the first byte of the string for incramenting
	li $t4, 1 		#assume the word is a hex word
	li $t5, 0		#start a counter for the length of the substring
	countWord:
		beq $t3, '.', continue	#if t3 is a period, then the word is over, and check for state
		beq $t3, ' ', continue	#if t3 is a space, then the word is over, and check for state
		ble $t3, 'F', continue	#if t3 is a hex, keep checking
		li $t4, 0		#if t3 is not a hex, change the flag to zero for a not hex word
		
	
	continue:
		beq $t4, 0, keepWord	#if t4 is zero then it was not a hex word
		beq $t4, 1, replaceWord	#if t4 is one then it was a hex word
		beq $t2, '.', exit	#if t2 is a period, then exit
		add $t3, $t3, 1		#increase t3 by one byte

keepWord:
	#load the byte of the start of the word
	#print the word out by looping until space or period is found
	#incrament t3
	j checkWord


replaceWord:
	#load the byte of the start of the word
	#print the word out by looping until space or period is found while convertint to hex
	j checkWord
	
	
exit:
	#Exit the program 
	li $v0, 10
	syscall
