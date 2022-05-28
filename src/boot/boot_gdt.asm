gdt_start:                      ; GDT starts with null 8 bytes
    dd 0x00
    dd 0x00

gdt_code:                       ; GDT for the code segment
    dw 0xffff                   ; segment length            (bits 0-15)
    dw 0x0000                   ; segment base              (bits 0-15)
    db 0x00                     ; segment base              (bits 16-23)
    db 0b10011010               ; flags                     (bits 0-7)
    db 0b11001111               ; flags + segment length    (bits 8-15 and 16-19)
    db 0x00                     ; segment base              (bits 24-31)

gdt_data:                       ; GDT for data segment same as code segment except some flags
    dw 0xffff
    dw 0x0
    db 0x0
    db 10010010b
    db 11001111b
    db 0x0

gdt_end:                        ; GDT ends

gdt_descriptor:                 ; Describes the GDT
    dw gdt_end - gdt_start - 1  ; Length of GDT
    dd gdt_start                ; Start address of GDT

CODE_SEG equ gdt_code - gdt_start ; Constant for location of code segment in GDT
DATA_SEG equ gdt_data - gdt_start ; Constant for location of data segment in GDT