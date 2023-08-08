

PCIrdw: ; ax = bus,
		; bx = slot,
		; cx = func
		; dx = offset
	push eax ; push bus
	mov eax, PCIrdw_SLOT ; eax = &SLOT
	mov dword [eax], bx  ; *eax = slot
	pop ebx ; ebx = bus

	mov eax, PCIrdw_BUS ; eax = &BUS
	mov dword [eax], bx ; *eax = bus
	
	mov eax, PCIrdw_FUNC ; eax = &FUNC
	mov dword [eax], cx ; *eax = func
	
	; PCIrdw_bus <<= 16
	mov eax, PCIrdw_BUS
	shl [eax], 16
	
	; PCIrdw_slot <<= 11
	mov eax, PCIrdw_SLOT
	shl [eax], 11

	; PCIrdw_func <<= 8
	mov eax, PCIrdw_FUNC
	shl [eax], 8

	; PCIrdw_temp = offset & 0xfc
	mov eax, PCIrdw_temp
	mov dword [eax], dx
	and [eax], 0xfc

	; address = bus | slot | func | temp | 0x80000000
	mov eax, PCI_ADDR
	mov [eax], [PCIrdw_BUS]
	or [eax], [PCIrdw_SLOT]
	or [eax], [PCIrdw_FUNC]
	or [eax], [PCIrdw_temp]
	or [eax], 0x80000000

	
	

	ret
PCIrdw_BUS:  resd 1
PCIrdw_ADDR: resd 1
PCIrdw_SLOT: resd 1
PCIrdw_FUNC: resd 1
PCIrdw_temp: resw 0

PCICFGADDR: dw 0xCF8
PCICFGDATA: dw 0xCFC
