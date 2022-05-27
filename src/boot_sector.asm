[org 0x7C00]

mov ah, 0x0E
mov al, 0x02
int 0x10; makes a happy face

mov bx, MSG_REAL_MODE
call print_16

call switch_to_pm

jmp $ ; loop

%include "src/boot_inc.asm"
%include "src/boot_gdt.asm"
%include "src/boot_32bit.asm"

[bits 32] ; Move to 32 bit mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print
    jmp $

MSG_REAL_MODE db "Started in 16-bit real mode", 0
MSG_PROT_MODE db "Loaded 32-bit protected mode", 0

times 510-($-$$) db 0
dw 0xAA55