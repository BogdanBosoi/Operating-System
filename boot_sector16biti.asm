mov [BOOT_DRIVE], dl; 

mov bp, 0x9000
mov sp, bp			;mutam pointerii de baza si de stiva catre 0x9000(4096)

mov bx, 0x9000		;incarcam de la 0 la 4096(0x0000:0x9000, es:bx)(es este deja setat din start din sectorul 2, avand in vedere ca acesta este sectorul 1 si va trebui sa se citeasca de pe urmatorul
mov cl, 2

mov dl, [BOOT_DRIVE] ;incarca de pe BOOT_DRIVE
call disk_load		 ;Cheama functia disk_load


call scrie_sir

jmp $					;pentru a nu rula la infinit disk_load

disk_load:			 ;incarca sectorul 1 in es:bx din dl
push dx
mov ah,0x02			;functie de citire pe 32 de biti
mov al, 1			;citirea sectorului 1
mov ch, 0x00		;cilindrul 0
mov dh, 0x00		;head 0
disk_load_go:
int 0x13
jc disk_error		;Ceva nu merge
pop dx
cmp al, 1			;Compara sectoarele asteptate cu cele care au rezultat
jne disk_error		;Eroare in caz ca sectorul nu e bun
ret

disk_error:
jmp $				;dai de la capat

scrie_sir:
	pusha
	mov ah, 0x0e
scrie_repeta:
	mov al, [bx] ; [] = bx ia rol de pointer
	cmp al, 0
	je terminare_scriere
	int 0x10
	add bx, 1
	jmp scrie_repeta
terminare_scriere:
	popa
	ret 
	
	BOOT_DRIVE: db 0
	
times 510 -($-$$) db 0  ;pune 510 biti de 0
dw 0xaa55				;baga la final in ultimii 2 biti pe aa si pe 55(scrise invers,little endian)

db "Sectorul 2!", 0 	;Am ajuns in sectorul 2, deci inseamna ca disc-ul a fost accesat cum trebuie