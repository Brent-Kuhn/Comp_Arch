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
	
	li $t5, 1 		#assume the word is a hex word
	
checkWord:
	lb $t3, 0($t2)		#load the first byte of the string
	#lb $t4, ($t1)		#load the first byte of the string for incramenting
	
	li $t6, 0		#start a counter for the length of the substring
	countWord:
		beq $t3, '.', continue	#if t3 is a period, then the word is over, and check for state
		beq $t3, ' ', continue	#if t3 is a space, then the word is over, and check for state
		bgt $t3, 'F', notHex	#if t3 is not a hex, flip the flag and keep counting
		add $t2, $t2, 1		#incrament t2 for the next letter
		j countWord		#jump back to countWord to finish checking the current word
	
		notHex:
			li $t5, 0		#if t3 is not a hex, change the flag to zero for a not hex word
			add $t2, $t2, 1		#incrament t2 for the next letter
			j countWord
		
	
	continue:
		beq $t3, '.', exit	#if t2 is a period, then exit
		add $t2, $t2, 1		#incrament t3
		beq $t5, 0, keepWord	#if t5 is zero then it was not a hex word
		beq $t5, 1, replaceWord	#if t5 is one then it was a hex word
		
		#add $t3, $t3, 1		#increase t3 by one byte

keepWord:
	beq $t1, $t2, checkWord	#return to checking letters
	lb $t7, ($t1)	#load the byte of the start of the word
	#print the word out by looping until space or period is found
	move $a0, $t7
	li $v0, 11	#print the current character
	syscall
	add $t1, $t1, 1	#incrament t1
	li $t5, 1 	#reset the assumption that the word is a hex word
	j keepWord	#else keep printint the letters


replaceWord:
	beq $t1, $t2, countWord	#return to checking letters
	lb $t7, ($t1)	#load the byte of the start of the word
	sub $t6, $t6, 1	#decrament t6 by one
	li $t8, 0
	bge $t7, 65, makeInt
	#print the word out by looping until space or period is found
	
	
	add $t1, $t1, 1	#incrament t1
	
	j replaceWord	#else keep printint the letters
	
	#possibly branch to print this?
	move $a0, $t7
	li $v0, 1	#print the current int
	syscall
	
	makeInt:
		sub $t7, $t7, 54	#make an intger equal to the hex value for this letter
		ble $t8, $t6, baseSixteen #create the multiplier for the current number
		
	
		add $t1, $t1, 1	#incrament t1
		beq $t1, $t2, countWord	#return to checking letters
		j replaceWord	#else keep printint the letters
		
		baseSixteen:
			#loop through t8 to t6
			#multiply 16 by its self that many times
	
exit:
	#Exit the program 
	li $v0, 10
	syscall
