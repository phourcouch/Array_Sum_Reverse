.data

prompt: .asciiz "Enter the number of elements\n"


equal_signs: .asciiz "==================================================================================="

negative_prompt: .asciiz "Error array can't have less than 2 elements, try again\n"

over10_prompt: .asciiz "Error array can't have more than 10 elements, try again\n"


print_high: .asciiz "The sum of the array is: "

text: .asciiz "\nThe content of array in reverse order is:\n"


newline: .asciiz "\n"

enterNum: .asciiz "\nEnter number "


collon: .asciiz ":\t"

myArray: .word 0

.text 
main:

la $s2,myArray
addi $t4, $0, 11
addi $t6, $0, 2
li $s5,0

li $v0,4
la $a0,prompt
syscall 

userInput: 
li $v0,5
syscall

add $t0,$v0,$0
#add $t6,$t0,$0 #copy

blt  $t0,$t6,negatvieError
bge $t0,$t4, over10Error


equal: li $v0, 4
la $a0,equal_signs
syscall

add $a1,$t0,$0 #n
add $a2,$s2,$0#pointer
jal FillArray

add $a1,$t0,$0 #n
add $a2,$s2,$0#pointer
jal AddElement

add $s5,$v1,$0
#return addresss

li $v0, 4
la $a0,print_high
syscall


li $v0,1
add $a0,$s5,$0
syscall

li $v0,10
syscall

##################################################################################### 

FillArray: 

add $t0,$a1,$0#n
add $t7,$a2,$0#pointer

li $t3,0
li $t5,1

loop: bge  $t3,$t0,goMain
 
 li $v0, 4
la $a0,enterNum
syscall
 
  li $v0, 1
add $a0, $t5,$0
syscall


 li $v0, 4
la $a0,collon
syscall

li $v0,5
syscall

sw $v0,0($t7)

addi $t7,$t7,4
addi $t3,$t3,1
addi $t5,$t5,1
j loop

goMain:
jr $ra

############################################################################################

AddElement:

add $t0,$a1,$0#n
add $t7,$a2,$0#pointer

li $t3,0
li $t9,0 #gettig array value
li $s7,0 #sum

loop1: bge  $t3,$t0,goMain1
 
lw $t9,($t7)
add $s7,$s7,$t9


addi $t7,$t7,4
 addi $t3,$t3,1
 
j loop1

goMain1:

add $v1,$s7,$0
jr $ra

#######################################################################
over10Error: 

li $v0, 4
la $a0,over10_prompt
syscall
j userInput

negatvieError: 

li $v0, 4
la $a0,negative_prompt
syscall
j userInput
