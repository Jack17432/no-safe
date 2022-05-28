@REM nasm src/boot/boot_kernel.asm -f elf -o bin/boot_kernel.o   & :: Compiles kernel entry file
@REM i386-elf-gcc -ffreestanding -c src/kernel.c -o bin/kernel.o & :: Compiles kernel to obj

@REM make -f scripts/Makefile bin/kernel.bin

nasm src/boot/boot_kernel.asm -f elf -o bin/boot_kernel.o
i386-elf-gcc -ffreestanding -c src/kernel.c -o bin/kernel.o
i386-elf-ld -o bin/kernel.bin -Ttext 0x1000 bin/boot_kernel.o bin/kernel.o --oformat binary

nasm src/boot/boot_sector.asm -f bin -o bin/boot_sector.bin
type "bin\boot_sector.bin" "bin\kernel.bin" > "bin\os-image.bin"