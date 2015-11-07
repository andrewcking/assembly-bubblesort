;;
;; Input 10 numbers and output them in ascending order - I am using a bubble sort algorithm
;; Program by Andrew King
;;
int:				dw 10 dup 0 ;this is the place our numbers are stored
num1:				dw 1 ;these are just helpers and aren't totally neccessary
num9:				dw 9
temp:				dw 0 ;this is intermediate storage for swaping numbers
count:			dw 0		;count used 3 times for different purposes
countd:			dw 11 	;countdown used to get correct number of inputs
forcount:		dw 0 		;used to count the outer for loop
forcount2:	dw 9 	;used to count the inner for loop
prompt: 		dw "Enter 10 integers\n"
prompt2:		dw "Integers in ascending order\n"
colsp:			dw ": "
start:	ldc prompt ;display the prompt
				sout
				ldc 1 ;initialize count to 1
				st count
inloop:	dout ;display the count
				ldc colsp ;display the colon and space
				sout
				din	;input into int
				push ;push on to stack for use with std later
				ldc int ;Get address for storing the number
				add count
				sub num1
				sti
				ldc 1	;add 1 to count
				add count
				st count
				sub countd ;check for 10 numbers
				jz reinit ;jump to next if there are 10 numbers
				add countd ;restore ac
				ja inloop ;jump to beginning to accept another number because jz failed
reinit:	ldc 0 ;reinitialize count for another purpose
				st count
				ja for2
for:		ldc 0 ;This is the outer for loop for the bubble sort
				st count
				ld forcount
				add num1
				st forcount
for2:		ldc int ;This is the inner for loop for the bubble sort cont(continued) and switch are sort of part of this loop
				add count
				ldi
				st temp
				ldc int ;check for negative
				add count
				add num1
				ldi
				sub temp
				jn switch ;if negative swap the numbers
cont:		ld count ;increment count
				add num1
				st count
				sub forcount2 ;it will stop if count-10=0
				add forcount
				jz for
				sub num1
				jzop final ;if you hit a positive number you have gone too far - finish out
				ja for2
switch:	add temp ;here we swap the numbers by pushing one into temp and the other on the stack
				push
				ldc int
				add count
				sti
				ld temp
				push
				ldc int
				add count
				add num1
				sti
				ja cont
final:	ldc 0 ; reuse count again - set up for displaying numbers
				st count
				ldc '\n'
				aout
				ldc prompt2
				sout
final2:	ldc int ;the final output reading out int
				add count
				ldi
				dout
				ldc '\n'
				aout
				ld count
				sub num9
				jz end
				add num9
				add num1
				st count
				ja final2
end:		halt
				end start
