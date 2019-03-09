gdt_start

gdt_null:		;Orice GDT are nevoie de asa ceva, este doar un entry
dd 0x0
dd 0x0

gdt_cod_kernel:
dw 0xffff		;Limita(din RAM)
dw 0x0			;Bitii de baza 0-15
db 0x0			;Bitii de baza 16-24
db 10011010b	;Byte de Access(Ring 0(Kernel), Cod)
db 11001111b	;Flags (32 bit, 4KiB granularitate (valoarea 1 in GR))
db 0x0			;Bitii de baza 25-31

gdt_data_kernel:
dw 0xffff		;Limita(din RAM)
dw 0x0			;Bitii de baza 0-15
db 0x0			;Bitii de baza 16-24
db 10010010b	;Byte de Access(Ring 0(Kernel), Data) acelasi ca la gdt_cod_kernel, ambele entries vor folosi aceeasi zona de memorie
db 11001111b	;Flags (32 bit, 4KiB granularitate (valoarea 1 in GR))
db 0x0			;Bitii de baza 25-31

gdt_sfarsit:

gdt_descriptor:
dw gdt_sfarsit - gdt_start - 1
dd gdt_start

KERNEL_CODE_SEG equ gdt_cod_kernel - gdt_start
KERNEL_DATA_SEG equ gdt_data_kernel - gdt_start