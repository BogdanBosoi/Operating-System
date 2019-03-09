KERNEL_LOC equ 0x1000

[org 0x7c00]		;spune compilerului unde isi ruleaza bios-ul cod-ul
[bits 16]
mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp
call incarca_kernel
call switch_to_pm
jmp $

%include 'gdt.asm'
%include 'disk.asm'

switch_to_pm:
cli									;Dezactiveaza interrupts
lgdt [gdt_descriptor]				;Incarca GDT(Global Descriptor Table)
mov eax, cr0
or eax, 0x1
mov cr0, eax
jmp KERNEL_CODE_SEG:pm_switched		;Merge la codul pe 32 de biti

incarca_kernel:
mov bx, KERNEL_LOC					;Incarca in KERNEL_LOC
mov cl, 2							;Incepe din sectorul 2
call incarca_disk
ret

[bits 32]							;Tot ce este mai jos e pe 32 de biti

pm_switched:
mov ax, KERNEL_DATA_SEG
mov ds, ax
mov ss, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ebp, 0x90000					;Muta stiva altundeva
mov esp, ebp
call KERNEL_LOC
jmp $								;Pauza

times 510-($-$$ ) db 0
dw 0xaa55

