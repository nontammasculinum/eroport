
main:
	call clearscr
	mov esi, [MESSAGE]
	mov ecx, 0x0F00
	call putstr
	ret

clearscr:
	mov edx, 0
	clearscr__loop:
		mov ebx, " "
		mov ecx, 0x0F00
		call putch
		inc edx
		add dword [POSITION], 2
		cmp edx, 999
		jne clearscr__loop
	mov ebx, " "
	mov ecx, 0x0F00
	call putch
	mov dword [POSITION], 0x0
	ret

putstr: ; esi = string, ecx = color
	;;; WORK HERE
	;;; PUTSTR TAKES A STRING IN ESI AND A COLOR IN ECX
	;;; AND THEN PUTS THESE ONTO THE SCREEN
	ret

putch:
	or ebx, ecx
	mov eax, [STDOUT]
	add eax, [POSITION]
	mov word [eax], bx
	ret

MESSAGE: db "Hello world!", 0
POSITION: dd 0x0
STDOUT: dd 0x0B8000
