[org 0x7C00]
KERNEL_OFFSET equ 0x1000

mov ah, 0x0E
mov al, 0x02
int 0x10; makes a happy face

mov [BOOT_DRIVE_LOC], dl ; saves boot drive location
mov bp, 0x9000 ; Create stack
mov sp, bp

mov bx, MSG_REAL_MODE
call print_16
call print_nl_16

call load_kernel
mov bx, MSG_KERNEL_LOADED
call print_16
call print_nl_16
call switch_to_pm

call hang ; Hangs if failed to enter PM

%include "src/boot/boot_inc.asm"
%include "src/boot/boot_gdt.asm"
%include "src/boot/boot_32bit.asm"

[bits 32] ; Move to 32 bit mode
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE_LOC      db 0
MSG_REAL_MODE       db "Started in 16-bit real", 0
MSG_KERNEL_LOADED   db "Kernel Loaded", 0
MSG_PROT_MODE       db "Loaded 32-bit protected mode", 0

times 510-($-$$) db 0 ; padding for rest of boot sector
dw 0xAA55