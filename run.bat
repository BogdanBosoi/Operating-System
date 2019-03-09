i686-elf-gcc -c kmain.c -o kmain.o -ffreestanding -std=gnu99
i686-elf-ld -o kernel.bin -Ttext 0x1000 kernel_exec.o kmain.o --oformat binary
type boot_sector.bin kernel.bin > os_image.bin
qemu-system-i386 os_image.bin
PAUSE