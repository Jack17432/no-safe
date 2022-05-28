nasm src/boot/boot_sector.asm -o bin/boot_sector
timeout 1
qemu bin/boot_sector