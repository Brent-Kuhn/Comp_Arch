# Brent Kuhn --10/12/2018
# wordCounter.asm -- cout how frequent a word occurs in a string
# Registers used:

.data
string: .asciiz "Florida has teams in all of the major league sports — National Football League, Major League Baseball, National Basketball Association, National Hockey League, and Major League Soccer. In the early 1980s, Florida had major league teams in only the NFL. Florida has since added two NBA teams in the late 1980s. Florida added two NHL teams in the 1990s as part of the NHL's expansion into the south, and two MLB teams in the 1990s. Florida's most recent major-league team, Orlando City, began play in MLS in 2015."
word1: .space 10
word2: .space 10
prompt1: "Please input word 1: \n"
prompt2: "Please input word 2: \n"

.text
main:
	#prompt the user for the first string
	la $a0, prompt1
	li $v0, 4
	syscall
	
	#get the user input for word1
	li $v0, 8
	la $a0, word1
	li $a1, 10
	syscall
	
	#prompt the user for the second string
	la $a0, prompt2
	li $v0, 4
	syscall
	
	#get the user input for word2
	li $v0, 8
	la $a0, word2
	li $a1, 10
	syscall
	
	la $t0, word1
	stripN1:
		lb $t1, 0($t0)
		beqz $t1, endStrip1
		bne $t1, '\n', nextLetter1
			sb $0, 0($t0)
		nextLetter1:
			addi $t0, $t0, 1
			j stripN1
	
	endStrip1: 		
	la $t0, word2
	stripN2:
		lb $t1, 0($t0)
		beqz $t1, endStrip2
		bne $t1, '\n', nextLetter2
			sb $0, 0($t0)
		nextLetter2:
			addi $t0, $t0, 1
			j stripN2
			
	endStrip2:
		#load the paragraph and words into save registers
		la $s0, string
		la $s1, word1
		la $s2, word2
		
		#set flags for word checking
		li $s3, 1
		li $s4, 1
		li $t0, 1
		
		readWord:
			beqz $t0, checkDone	#exit loop if the word is null terminated
			lb $t0, 0($s0)		#load the byte from the string
			bne $t0, ' ', checkLetter
			beqz $s3, notWord1
			addi $s5, $s5, 1	#incrament the counter for word1
			notWord1:
			beqz $s4, notWord2
			addi $s6, $s6, 1	#incrament the counter for word2
			notWord2:
			la $s1, word1		#reset the address of s1
			la $s2, word2		#reset the address of s2
			#set flags for word checking
			li $s3, 1
			li $s4, 1
			j wordDone
			
		checkLetter:
		beqz $s3, skipWord1 	#if word one flag is zero, there is no need to check the next letter
		lb $t1, 0($s1)
		beq $t1, $t0, skipWord1
		blt $t1, 'a', word1Caps
		subi $t1, $t1, 32
		beq $t1, $t0, skipWord1
		j word1Done
		word1Caps:
			addi $t1, $t1, 32
			beq $t1, $t0, skipWord1
		word1Done:
			li $s3, 0
		
		skipWord1:
		beqz $s4, skipWord2 	#if word one flag is zero, there is no need to check the next letter
		lb $t2, 0($s2)
		beq $t2, $t0, skipWord2
		blt $t2, 'a', word2Caps
		subi $t2, $t2, 32
		beq $t2, $t0, skipWord2
		j word2Done
		word2Caps:
			addi $t2, $t2, 32
			beq $t2, $t0, skipWord2
		word2Done:
			li $s4, 0
		
		skipWord2:
			addi $s1, $s1, 1
			addi $s2, $s2, 1
			wordDone:
				addi $s0, $s0, 1
				j readWord
		
			checkDone:
				beqz $s3, notWord1Done
				addi $s5, $s5, 1
				notWord1Done:
					beqz $s4, notWord2Done
					addi $s6, $s6, 1
				notWord2Done:
					li $v0, 4
					la $a0, word1
					syscall
					
					li $v0, 11
					li $a0, ':'
					syscall
					
					li $v0, 1
					move $a0, $s5
					syscall
					
					li $v0, 11
					li $a0, '\n'
					syscall
					
					li $v0, 4
					la $a0, word2
					syscall
					
					li $v0, 11
					li $a0, ':'
					syscall
					
					li $v0, 1
					move $a0, $s6
					syscall
					
					li $v0, 11
					li $a0, '\n'
					syscall
					
		
exit:	
li $v0, 10
syscall
