# Brent Kuhn --10/12/2018
# letterCount.asm -- cout how frequent the letters f, l, o, r, i, d, a, p, and y appear in a string
# Registers used:

.data
string: .asciiz "It was the game of Humans vs. Zombies, a highly imaginative version of tag played by groups across the globe, and the Clearwater, Florida, native is one of those responsible for bringing it to Florida Poly’s campus.  Human players must remain vigilant and defend themselves with socks and dart blasters to avoid being tagged by a growing zombie horde."
newLine: .asciiz "\n"
f: .asciiz "F: "
l: .asciiz "L: "
o: .asciiz "O: "
r: .asciiz "R: "
i: .asciiz "I: "
d: .asciiz "D: "
a: .asciiz "A: "
p: .asciiz "P: "
y: .asciiz "Y: "

.text

la $s0, string	#load the base address of the string into s0
main:
lb $s1, 0($s0)		#load the first byte of the string
beq $s1, 0, printString	#if zero is found in the register, you are out of the string, so exit
beq $s1, 'F', F
beq $s1, 'f', F
beq $s1, 'L', L
beq $s1, 'l', L
beq $s1, 'O', O
beq $s1, 'o', O
beq $s1, 'R', R
beq $s1, 'r', R
beq $s1, 'I', I
beq $s1, 'i', I
beq $s1, 'D', D
beq $s1, 'd', D
beq $s1, 'A', A
beq $s1, 'a', A
beq $s1, 'P', P
beq $s1, 'p', P
beq $s1, 'Y', Y
beq $s1, 'y', Y
addi $s0, $s0, 1	#move to the next letter
j main			#check the next letter

	F:
		addi $t0, $t0, 1
		addi $s0, $s0, 1
		j main
	
	L:
		addi $t1, $t1, 1
		addi $s0, $s0, 1
		j main
	
	O:
		addi $t2, $t2, 1
		addi $s0, $s0, 1
		j main
	
	R:
		addi $t3, $t3, 1
		addi $s0, $s0, 1
		j main
	
	I:
		addi $t4, $t4, 1
		addi $s0, $s0, 1
		j main
	
	D:
		addi $t5, $t5, 1
		addi $s0, $s0, 1
		j main
	
	A:
		addi $t6, $t6, 1
		addi $s0, $s0, 1
		j main
	
	P:
		addi $t7, $t7, 1
		addi $s0, $s0, 1
		j main
	
	Y:
		addi $t8, $t8, 1
		addi $s0, $s0, 1
		j main
	
	printString:
		fBranch:
		la $a0, f
		li $v0, 4
		syscall
		
		histF:
		beq $t0, 0, lBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t0, $t0, 1
		j histF
		
		lBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, l
		li $v0, 4
		syscall
		
		histL:
		beq $t1, 0, oBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t1, $t1, 1
		j histL
		
		oBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, o
		li $v0, 4
		syscall
		
		histO:
		beq $t2, 0, rBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t2, $t2, 1
		j histO
		
		rBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, r
		li $v0, 4
		syscall
		
		histR:
		beq $t3, 0, iBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t3, $t3, 1
		j histR
		
		iBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, i
		li $v0, 4
		syscall
		
		histI:
		beq $t4, 0, dBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t4, $t4, 1
		j histI
		
		dBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, d
		li $v0, 4
		syscall
		
		histD:
		beq $t5, 0, aBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t5, $t5, 1
		j histD
		
		aBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, a
		li $v0, 4
		syscall
		
		histA:
		beq $t6, 0, pBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t6, $t6, 1
		j histA
		
		pBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, p
		li $v0, 4
		syscall
		
		histP:
		beq $t7, 0, yBranch
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t7, $t7, 1
		j histP
		
		yBranch:
		la $a0, newLine
		li $v0, 4
		syscall
		
		la $a0, y
		li $v0, 4
		syscall
		
		histY:
		beq $t8, 0, exit
		li $a0, '#'
		li $v0, 11
		syscall
		subi $t8, $t8, 1
		j histY
		
		la $a0, newLine
		li $v0, 4
		syscall
		
	exit:
		#Exit the program 
		li $v0, 10
		syscall
