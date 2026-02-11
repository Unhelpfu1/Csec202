.386					;Specify System Architecture
.model flat, stdcall	;Dictate calling conventions
.stack 4096				;Stack size of 4k

;Two library files we'll need most of the time
includelib libcmt.lib
includelib legacy_stdio_definitions.lib

ExitProcess PROTO, dwExitCode:DWORD		;This is a function prototype
										;Exitprocess -> Name of the function
										;PROTO -> Prototype
										;dwExitCode -> name of the parameter to the ExitProcess function
										;DWORD is the datatype of dwExitCode

extern printf:NEAR		;Indicates that printf is defined in one of the library files
extern scanf:NEAR

.data
	;greeting BYTE "Hello World!", 10, 0	;This will create a character array called greeting
											;The ", 0" at the end of the line adds a null byte to end the string
	
	hours_prompt BYTE "Hours Worked: ", 0

	pay_prompt BYTE "Pay Rate: $", 0

	final_pay_string BYTE "Final Pay: $%f", 10, 0


	digit_format byte "%d", 0		;to be pushed as format string for scanf

	float_format byte "%f", 0		;other format string for scanf

.code

CalculatePay PROC c		;Expects hours, pay, then multiplier to be pushed as args
	push ebp			;prologue
	mov ebp, esp
	sub esp, 0			;no local variables stored

	;[ebp+8] is hours
	;[ebp+12] is pay
	;[ebp+16] is multiplier


								;load floats and ints using x87
	fld DWORD PTR [ebp+16]		;eax is hours
	fmul DWORD PTR [ebp+12]		;ebx is pay

	fimul DWORD PTR [ebp+8]		;multiplier applied to pay*hours
								
								;return value is gotten from fstp instead of eax

	add esp, 0			;cleanup

	mov esp, ebp		;epilogue
	pop ebp
	ret
CalculatePay endp



main PROC c			;Where the main functions starts, c -> denotes that the c standard is in use

	LOCAL hours_input:DWORD
	LOCAL pay_input:DWORD

	push offset hours_prompt		;"offset" fetches the memory address of greeting
	call printf
	add esp, 4						;Add 4 to esp to "remove" the argument to printf
	
	lea eax, hours_input			;get address of hours_input variable in eax
	push eax
	push offset digit_format		;push string formatting for scanf
	call scanf
	add esp, 8						;save user response to hours_prompt

	
	push offset pay_prompt
	call printf
	add esp, 4

	lea eax, pay_input
	push eax
	push offset float_format		
	call scanf						;the exact same thing as hours
	add esp, 8						;with a new variable name



	cmp [hours_input], 40
	jg LessThan50				;if hours > 40, skip body

LessThan40:
	push 3F800000h			;1.0 in IEEE 754
	push [pay_input]
	push [hours_input]				;push the value of each stored variable
	call CalculatePay
	add esp, 12						;clean up input
	jmp AfterIf				;skip other sections

LessThan50:

	cmp [hours_input], 50
	jg Over50					;skip body if hours > 50

	push 3FC00000h			;1.0 in IEEE 754
	push [pay_input]
	push [hours_input]				;push the value of each stored variable
	call CalculatePay
	add esp, 12						;clean up input
	jmp AfterIf				;skip other sections

Over50:

	cmp [hours_input], 50
	jle ElseStatement			;if somehow >50 and <=50, skip body

	push 40000000h			;1.0 in IEEE 754
	push [pay_input]
	push [hours_input]				;push the value of each stored variable
	call CalculatePay
	add esp, 12						;clean up input
	jmp AfterIf				;skip other sections

ElseStatement:
	mov eax, 0				;0 if not any previous option

AfterIf:

;	push DWORD PTR [hours_input]	;DEBUG
;	push offset digit_format
;	call printf
;	add esp, 8

;	fld pay_input
;	sub esp, 8
;	fstp QWORD PTR [esp]		;DEBUG
;	push offset float_format
;	call printf
;	add esp, 12


	sub esp, 8
	fstp QWORD PTR [esp]			;push return value of CalculatePay
	push offset final_pay_string	;string formatting
	call printf
	add esp, 12						;function clean up


	INVOKE ExitProcess,0			;This will call ExitProcess function with an argument of 0
main endp			;Denotes where the main function ends
end					;Denotes the end of the program
