.data
	#Arrays:
	saga:	.byte 1,2,3,1,2			#1 = reserved car
	toyota:	.byte 2,2,3,1,1			#2 = rented car
	mazda:	.byte 1,1,2,3,3			#3 = available car
	camry:	.byte 1,3,3,2,1

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
msgRentedId: .asciiz " Model has a rented car with ID "
msgAvailableId: .asciiz " Model has a available car with ID "
msgCarId: .asciiz "Enter the car ID "
msgPickState: .asciiz "Choose the new state for the car(type the number only)\n1_Reserved\n2_Rented\n3_Available\n"
resvStat: .asciiz " is reserved. \n" 
rentStat: .asciiz " is rented. \n"
availStat: .asciiz " is available.\n"
ID_user: 	.asciiz "admin\n"
Psw_user: 	.asciiz "car1234\n"
askID_msg: 	.asciiz "Please enter your username ID: "
askPsw_msg: 	.asciiz "Please enter your password: "
wrongInput_msg: .asciiz "Please enter the correct username or password.\n"
correctInput_msg: .asciiz "Succesful!\n"
input_ID: 	.space 10
input_Psw: 	.space 10

.text
.globl main
main:
	j logIn  #jmp to login line 362
loop: 	
	jal setRegisterToZero	# to reset all registers if we are reusing the program without terminating it.
	li $v0, 4	  
	la $a0, msg
	syscall		  # display msg
	li $v0, 5	  
	syscall		  # store an integer 1 or 2 other than that loop back
	bne  $v0,2,choose # jmp to line 99

update:
	addi $s3,$zero,1	#set allow update to on.
	j displayOne # line 109

updateSaga:		#set the new state for the Saga car
	jal PickFunc		#display the pick msg #line 77
	
	sb $v0,saga($s0)	#save new state
	j endFunc #line 326
	
updateToyota:		#set the new state for the Toyota car
	jal PickFunc		#display the pick msg #line 77
	
	sb $v0,toyota($s0)	#save new state
	j endFunc	#line 326
	
updateMazda:		#set the new state for the Mazda car
	jal PickFunc		#display the pick msg #line 77
	
	sb $v0,mazda($s0)	#save new state
	
	j endFunc 	#line 326
	
updateCamry:		#set the new state for the Camry car
	jal PickFunc		#display the pick msg #line 77
	
	sb $v0,camry($s0)		#save new state
	
	j endFunc	#line 326
		
PickFunc:	#display the pick msg
	li $v0, 4
	la $a0, msgPickState
	syscall
	
	li $v0, 5		#take new state 
	syscall

	addi $t6,$zero,3	#check if the input is valid
	
	blez $v0 , stateError	
	bgt $v0,$t6,stateError
	
	jr $ra	# jmp back to the address registered
	
stateError:	#print an error 
	li $v0, 4
	la $a0, msgW
	syscall
	
	j update

choose:
	bne  $v0,1,displayWrongMsg1	# line 176
	
displayFunc:
	li $v0, 4	  
	la $a0, msgDisplayOneOrAll
	syscall		  # display msg
	li $v0, 5	  
	syscall		  # store an integer 1 or 2 other than that loop back
	bne  $v0,1,displayAll	# jmp to line 220
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
	bgtz $t1, sagaId  # line 146
	
	slti $t1,$s0,11
	bgtz $t1, toyotaId # line 159
	
	slti $t1,$s0,16
	bgtz $t1, mazdaId	# line 171
	
	slti $t1,$s0,21
	bgtz $t1, camryId	# line 186

idError:			#deny invalid values for 20< *by default*
	li $v0, 4
	la $a0, msgW
	syscall
	j displayOne	#line 109

sagaId:
	subi $s0 , $s0,1
	lb $t2 , saga($s0)
	li $v0, 4
	la $a0, modelOne
	syscall
	
	jal printState	#line 199
	
	bgtz $s3,updateSaga		#check if updating is on line 51 
	
	j endFunc		#return to the end function line 326

toyotaId:
	subi $s0 , $s0,6
	lb $t2 , toyota($s0)
	li $v0, 4
	la $a0, modelTwo
	syscall
	
	jal printState	#line 199
	
	bgtz $s3,updateToyota		#check if updating is on line 57
	
	j endFunc		#return to the end function line 326
mazdaId:

	subi $s0 , $s0,11
	lb $t2 , mazda($s0)
	
	li $v0, 4
	la $a0, modelThree
	syscall
	
	jal printState	#line 199
	
	bgtz $s3,updateMazda		#check if updating is on line 63
	
	j endFunc 		#return to the end function line 326
	
camryId:
	subi $s0 , $s0,16
	lb $t2 , camry($s0)
	li $v0, 4
	la $a0, modelFour
	syscall
	
	jal printState	#line 199
	
	bgtz $s3,updateCamry		#check if updating is on line  70
	
	j endFunc 		#return to the end function line 326
	
printState:	#check which state is it 
	beq $t2, $t5 , printresv # line 204
	beq $t2, $t6, printrented # line 209
	beq $t2, $t7, printavailable # line 214
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

displayAll:
	bne  $v0,2,displayWrongMsg2  #if not equal 2 print wrong msg and ask user to enter again. jmp to line 314
displayAllCon:
	li $v0, 4	  
	la $a0, msgShowList
	syscall		  # display msg
	li $v0, 5	  
	syscall		  # store an integer 1 or 2 or 3 other than that loop back
	or   $t7,$v0,$t7  # to choose list will be displayed
	bne  $t7,1,list2  # jmp to list 2 if the number is not 1 jmp to line 233
	li $s0, 1	  # this is for reserved cars
	j check 	  # jmp to check to print cars in reserved states line 240
	
list2:
	bne  $t7,2,list3  # jmp to list 3 if number is not 2 jmp to line 237
	li $s0, 2	  # this is for available cars
	j check		  # jmp to check to print cars in availabe states 240
list3:	
	bne  $t7,3,displayWrongMsg3	#jmp to line 320 if number is not 3 
	li $s0, 3	  # This is for rented cars
check:
	la $s1,saga #take the first address of the data
	la $s6,camry+5 #take the address after the last car data
	li $t2, 1	# used to determine the car model in later part.
repeat:
	beq $s1,$s6,endFunc #if the counter reach to the last address go to the ending of the program jmp line 326
	lb $s2,($s1) #load byte which contain the states of the car
	xor $s3,$s0,$s2 # get a result
	beqz $s3, print # check if the result is 0 so we print this one jmp line 253
	addi $t2,$t2,1	# increase model counter to understand check line from 90 to 97
	addi $s1,$s1,1	# increase memory counter to understand check line 81
	j repeat	# keep repeating until all cars have been viewed line 244

print:
	li $t1, 5
	bleu $t2,$t1,Saga   #print a msg for Saga if counter between 0 and 4 jmp line 273
	li $t1, 10
	bleu $t2,$t1,Toyota	#print a msg for Toyota if counter between 5 and 9 jmp line 278
	li $t1, 15
	bleu $t2,$t1,Mazda	#print a msg for Mazda if counter between 10 and 14 jmp line 283
	li $t1, 20
	bleu $t2,$t1,Camry 	#print a msg for camry if counter between 15 and 19 jmp line 288
printCon:
	li $v0, 1     # prpare to print integer  
	la $a0, ($t2) # put the value to be printed
	syscall
	li $v0, 11      
	li $a0, 10  #print new line
	syscall
	addi $t2,$t2,1	# increase model counter to understand check line from 90 to 97
	addi $s1,$s1,1	# increase memory counter to understand check line 81
	j repeat # jmp line 244

Saga:
	li $v0, 4
	la $a0, modelOne	#print msg
	syscall
	j printMsg #jmp line 293
Toyota:
	li $v0, 4
	la $a0, modelTwo	#print msg
	syscall
	j printMsg #jmp line 293
Mazda:
	li $v0, 4
	la $a0, modelThree	#print msg
	syscall
	j printMsg #jmp line 293
Camry:
	li $v0, 4
	la $a0, modelFour	#print msg
	syscall

printMsg:
	bne  $t7,1,rentedCarsList # jmp line 300 if the value is not 1 which means not reserved cars list.
	li $v0, 4 
	la $a0, msgReservedId		#print msg Id
	syscall 
	j printCon #jmp line 262

rentedCarsList:
	bne  $t7,2,availableCarsList #jmp line 307 if value is not 2 which means it is not available cars list.
	li $v0, 4
	la $a0, msgRentedId		#print msg Id
	syscall 
	j printCon #jmp line 262
	
availableCarsList:	
	li $v0, 4
	la $a0, msgAvailableId		#print msg Id
	syscall 
	j printCon #jmp line 262


displayWrongMsg2:
	li $v0, 4
	la $a0, msgW	#print msg
	syscall
	j displayFunc	# jmp back to countinue execution line 106

displayWrongMsg3:
	li $v0, 4
	la $a0, msgW	#print msg
	syscall
	j displayAllCon # jmp to line 222

endFunc:
	li $v0, 4	  
	la $a0, msgEnd
	syscall		  # display msg
	
	li $v0, 5	  
	syscall		  # get integer input which is 0 to end the program
	
	bnez  $v0, loop	  # if not 0 repeat the program if 0 continue
	li $v0, 10	  # End program
	syscall

displayWrongMsg1:
	li $v0, 4
	la $a0, msgW	#print msg
	syscall
	j loop	# jmp back to countinue execution back to line 39
	
setRegisterToZero:
	and $t0,$t0,$0
	and $t1,$t1,$0
	and $t2,$t2,$0
	and $t3,$t3,$0
	and $t4,$t4,$0
	and $t5,$t5,$0
	and $t6,$t6,$0
	and $t7,$t7,$0
	and $s0,$s0,$0
	and $s1,$s1,$0
	and $s2,$s2,$0
	and $s3,$s3,$0
	and $s4,$s4,$0
	and $s5,$s5,$0
	and $s6,$s6,$0
	and $s7,$s7,$0
	jr $ra
logIn: 
prompt_ID:
    la		$s2, input_ID
    la		$s3, ID_user
    li 		$t8, 0		#loop control
    move 	$t1, $s2

    #prompt message for ID
    la 		$a0, askID_msg
    li 		$v0, 4
    syscall

    #read ID
    move 	$a0, $t1
    li 		$a1, 10
    li		 $v0, 8
    syscall
    jal strcmp 			#compare input

    #prompt password
    prompt_Psw:
    la 		$s2, input_Psw
    la 		$s3, Psw_user
    li 		$t8, 1
    move $t1, $s2

    #prompt message for password
    la 		$a0, askPsw_msg
    li		$v0, 4
    syscall

    #read password
    move 	$a0, $t1
    li 		$a1, 10
    li 		$v0, 8
    syscall
    jal strcmp			#compare input

    #compare every character
    strcmp:
    lb 		$t2,($s2)
    lb 		$t3,($s3)
    bne 	$t2, $t3, compareNE	#when not equal
    beq 	$t2, $zero, compareEq	#when equal
    addi 	$s2, $s2,1 		#next character
    addi 	$s3, $s3,1
    j 		strcmp

    #equal
    compareEq:
    beq 	$t8, $zero, prompt_Psw	#get to the prompt password after getting through prompt username
    j loop	#get to end when both creditentials are correct

    #not equal
    compareNE:
    la $a0, wrongInput_msg
    li $v0, 4
    syscall
    beq $t8, $zero, prompt_ID		#for ID label
    beq $t8, 1, prompt_Psw		#for password label
