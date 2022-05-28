[bits 32]
[extern main]
call main           ; starts kernel
jmp $               ; hangs if call fails