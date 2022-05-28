all: run

bin/kernel.bin: bin/boot_kernel.o bin/kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

bin/kernel_entry.o: bin/boot_kernel.asm
	nasm $< -f elf -o $@

bin/kernel.o: src/kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

bin/kernel.dis: bin/kernel.bin
	ndisasm -b 32 $< > $@

bin/bootsect.bin: src/boot/boot_sector.asm
	nasm $< -f bin -o $@

bin/os-image.bin: bin/boot_sector.bin bin/kernel.bin
	type $^ > $@

run: bin/os-image.bin
	qemu-system-i386 -fda $<

clean:
	rm *.bin *.o *.dis