[bits 16]
switch_to_pm:
    cli                     ; Disable interrupts
    lgdt [gdt_descriptor]   ; Load the gdt descriptor
    mov eax, cr0            ; Get value from control register
    or  eax, 0x1            ; Set last bit (32 bit mode) to 1
    mov cr0, eax            ; Set new value to control register
    jmp CODE_SEG:init_pm    ; Jump to 32 bit land and initialise protected mode

[bits 32]
init_pm:                    ; Initialise protected mode with 32 bit instructions
    mov ax, DATA_SEG        ; Update segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000        ; Put the stack in free space
    mov esp, ebp

    call BEGIN_PM