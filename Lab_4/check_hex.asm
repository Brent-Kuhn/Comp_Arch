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
	la $t2, userString
	#move $a0, $t2
	#li $v0, 11		#print the current character
	#syscall
	
	
checkWord:
	li $s2, 1 		#assume the word is a hex word
	
	countWord:
		lb $t3, 0($t2)		#load the first byte of the string
		beq $t3, 0, exit	#if zero is found in the register, you are out of the string, so exit
		beq $t3, '.', continue	#if t3 is a period, then the word is over, and check for state
		beq $t3, ' ', continue	#if t3 is a space, then the word is over, and check for state
		bgt $t3, 'F', notHex	#if t3 is not a hex, flip the flag and keep counting
		add $t2, $t2, 1		#incrament t2 for the next letter
		j countWord		#jump back to countWord to finish checking the current word
	
		notHex:
			li $s2, 0		#if t3 is not a hex, change the flag to zero for a not hex word
			add $t2, $t2, 1		#incrament t2 for the next letter
			j countWord
		
	
	continue:
		lb $t3, 0($t1)		#load byte of the first char in the previously read string
		beq $t3, '.', exit	#if t2 is a period, then exit
		add $t2, $t2, 1		#incrament t2 to avoid circular logic of spaces
		beq $s2, 0, keepWord	#if t5 is zero then it was not a hex word
		beq $s2, 1, replaceWord	#if t5 is one then it was a hex word
		
		#add $t3, $t3, 1		#increase t3 by one byte

keepWord:
	beq $t1, $t2, checkWord	#return to checking letters
	#print the word out by looping until space or period is found
	move $a0, $t3
	li $v0, 11	#print the current character
	syscall
	add $t1, $t1, 1	#incrament t1
	lb $t3, 0($t1)	#load the next byte
	j keepWord	#else keep printint the letters


replaceWord:
	beq $t3, ' ', printHex
	beq $t3, '.', printHex
	bge $t3, 'A', convertHexChar
	subi $t3, $t3, 48	#convert to an integer value from ascii value
	j storeHex
	
	convertHexChar:
		subi $t3, $t3, 55	#convert to 
		storeHex:
			sll $t4, $t4, 4		#move the bytes over to place hex values in the proper place
			add $t4, $t4, $t3	#Save the hex value in t4
			addi $t1, $t1, 1	#incrament t1
			lb $t3, 0($t1)		#load the next byte into t3
			j replaceWord		#return to replace word
	printHex:
		move $a0, $t4
		li $v0, 1		#print as an int
		syscall
		
		ble $t4, $s3, noNewMax
		move $s3, $t4
		
		noNewHex:
			li $t4, 0		#clean out t4
			addi $t1, $t1, 1	#move t1 to the next byte
			li $v0, 11		#print the space or period
			move $a0, $t3
			syscall
			j countWord		#start checking the next word
exit:
	#branch if the conditions are met for string printing
	#print the proper string
	#Exit the program 
	li $v0, 10
	syscall
