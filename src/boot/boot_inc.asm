[bits 16]

print_16:
    pusha           ; saves state to stack

print_start_16:
    mov al, [bx]    ; gets first value from string at bx
    cmp al, 0
    je print_done_16   ; checks if char is null terminator

    mov ah, 0x0E
    int 0x10        ; prints

    add bx, 1       ; moves to next char in str
    jmp print_start_16 ; loops

print_done_16:
    popa            ; restores state from stack
    ret

disk_load:
    pusha           ; saves state to the stack
    push dx         ; save to check for disk read error | bios will change dx so we need to save it for later and since it its the
                    ; third value on the stack we dont want to mess up popa

    mov ah, 0x02    ; set mode of bios interupt to read
    mov al, dh      ; al number of sectors read
    mov cl, 0x02    ; start sector (first sector is boot sector so start at 2)
    mov ch, 0x00    ; cylinder number
    mov dh, 0x00    ; head number
    
    int 0x13        ; read interupt
    jc disk_read_error ; jump if carry bit (error bit) is set

    pop dx
    cmp al, dh      ; Check if al (number of disk spaces read) to dh (number of disk spaces wanted to read)
    jne sectors_error

    popa ; restores to org from the stack
    ret

disk_read_error:
    mov bx, DISK_ERROR
    call print_16
    jmp hang

sectors_error:
    mov bx, SECTORS_ERROR
    call print_16
    jmp hang

hang: jmp $

DISK_ERROR: db "Disk read error", 0
SECTORS_ERROR: db "Incorrect number of sectors read", 0

[bits 32]                   ; 32 bit mode

VIDEO_MEMORY equ 0xb8000    ; Address of video memory

print:
    pusha                   ; Saves state to stack
    mov edx, VIDEO_MEMORY   ; Set a variable for the position in video memory
    add edx, 1440

print_loop:
    mov al, [ebx]           ; Get the character to print
    mov ah, 0x0f            ; Set the print colour to black on white

    cmp al, 0               ; Check if we've reached the null terminator
    je print_done           ; If we've reached the null terminator end

    mov [edx], ax           ; Store the character in video memory
    add ebx, 1              ; Move the current data position
    add edx, 2              ; Move the current video memory position
    
    jmp print_loop          ; Loop

print_done:
    popa                    ; Restore registers
    ret                     ; Return to code