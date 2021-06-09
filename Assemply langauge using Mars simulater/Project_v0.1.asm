.data
	saga:	.byte 1,2,3,1,2			#1 = reserved car //index numbers 0,1,2,3,4
	toyota:	.byte 2,2,3,1,1			#2 = rented car	//index numbers 5,6,7,8,9
	mazda:	.byte 1,1,2,3,3			#3 = available car//index numbers 10,11,12,13,14
	camry:	.byte 1,3,3,2,1			#//index numbers 15,16,17,18,19
	
	modelOne:.asciiz "Saga"
	modelTwo:.asciiz "Toyota"
	modelThree:.asciiz "Mazda"
	modelFour:.asciiz "Camry"

	msg  :.asciiz "Please input 1 for display or 2 for update? "
	msgW :.asciiz "Wrong input please try again. \n"
	msgDisplayOneOrAll:.asciiz "Enter 1 to display one car or 2 to display all: "
	msgEnd:.asciiz "If you wanna repeat enter anynumber except 0: "
	msgShowList:.asciiz "Which list do you wanna display.\n Enter 1 for reserved or 2 for rented or 3 for available: "
	msgReservedId: .asciiz " Model has a reserved car with ID "
	msgRenteddId: .asciiz " Model has a rented car with ID "
	msgAvailableId: .asciiz " Model has a available car with ID "
	msgCarId: .asciiz "Enter the car ID "
	msgPickState: .asciiz "Choose the new state for the car(type the number only)\n1_Reserved\n2_Rented\n3_Available\n"
	resvStat: .asciiz " is reserved. \n" 
	rentStat: .asciiz " is rented. \n"
	availStat: .asciiz " is available.\n"
.text
.globl main
main:

	
displayOne:
	#clear three registers for if-else statements.
	addi $t5,$zero,1
	addi $t6,$zero,2
	addi $t7,$zero,3
	
	#print msg
	li $v0, 4
	la $a0, msgCarId
	syscall
	
	#take carid
	li $v0, 5
	syscall
	move $s0, $v0
	
	#find the car with this id
	blez $s0,idError		#Deny invalid values for 0=> 
	
	slti $t1,$s0,6
	bgtz $t1, sagaId
	
	slti $t1,$s0,11
	bgtz $t1, toyotaId
	
	slti $t1,$s0,16
	bgtz $t1, mazdaId
	
	slti $t1,$s0,21
	bgtz $t1, camryId
	
	
idError:			#deny invalid values for 20< *by default*
	li $v0, 4
	la $a0, msgW
	syscall
	j displayOne

#methods to find correct index for the id and display state
sagaId:
	subi $s0 , $s0,1
	lb $t2 , saga($s0)
	li $v0, 4
	la $a0, modelOne
	syscall
	
	jal printState
	
	bgtz $s3,updateSaga		#check if updating is on 
	
	j END 		#return to the end function

toyotaId:
	subi $s0 , $s0,6
	lb $t2 , toyota($s0)
	li $v0, 4
	la $a0, modelTwo
	syscall
	
	jal printState
	
	bgtz $s3,updateToyota		#check if updating is on 
	
	j END 		#return to the end function
mazdaId:

	subi $s0 , $s0,11
	lb $t2 , mazda($s0)
	
	li $v0, 4
	la $a0, modelThree
	syscall
	
	jal printState
	
	bgtz $s3,updateMazda		#check if updating is on 
	
	j END 		#return to the end function
	
camryId:
	subi $s0 , $s0,16
	lb $t2 , camry($s0)
	li $v0, 4
	la $a0, modelFour
	syscall
	
	jal printState
	
	bgtz $s3,updateCamry		#check if updating is on 
	
	j END 		#return to the end function
	
printState:	#check which state is it 
	beq $t2, $t5 , printresv
	beq $t2, $t6, printrented
	beq $t2, $t7, printavailable
	jr $ra	
printresv:	#print reserved
	li $v0, 4
	la $a0, resvStat
	syscall
	jr $ra	
printrented:	#print rented
	li $v0, 4
	la $a0, rentStat
	syscall
	jr $ra	
printavailable:	#print available
	li $v0, 4
	la $a0, availStat
	syscall
	jr $ra	
	
update:
	addi $s3,$zero,1	#set allow update to on.
	j displayOne

updateSaga:		#set the new state for the Saga car
	jal PickFunc		#display the pick msg
	
	sb $v0,saga($s0)	#save new state
	j END
	
updateToyota:		#set the new state for the Toyota car
	jal PickFunc		#display the pick msg
	
	sb $v0,toyota($s0)	#save new state
	j END
	
updateMazda:		#set the new state for the Mazda car
	jal PickFunc		#display the pick msg
	
	sb $v0,mazda($s0)	#save new state
	
	j END
	
updateCamry:		#set the new state for the Camry car
	jal PickFunc		#display the pick msg
	
	sb $v0,camry($s0)		#save new state
	
	j END
		
PickFunc:	#display the pick msg
	li $v0, 4
	la $a0, msgPickState
	syscall
	
	li $v0, 5		#take new state 
	syscall

	addi $t6,$zero,3	#check if the input is valid
	
	blez $v0 , stateError	
	bgt $v0,$t6,stateError
	
	jr $ra
	
stateError:	#print an error 
	li $v0, 4
	la $a0, msgW
	syscall
	
	j update
END:
	li $v0 ,10
	syscall
	
