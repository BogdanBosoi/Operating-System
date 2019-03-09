incarca_disk:			 ;incarca sectorul 1 in es:bx din dl
push dx
mov ah,0x02			;functie de citire pe 32 de biti
mov al, 1			;citirea sectorului 1
mov ch, 0x00		;cilindrul 0
mov dh, 0x00		;head 0
incarca_disk_go:
int 0x13
jc eroare_disk		;Ceva nu merge
pop dx
cmp al, 1			;Compara sectoarele asteptate cu cele care au rezultat
jne eroare_disk		;Eroare in caz ca sectorul nu e bun
ret

eroare_disk:
jmp $				;dai de la capat

BOOT_DRIVE db 0