
//void kmain(){
//	int k = 2;
//	char* screen = (char*)0xb8000;
//	screen[0] = 'l';
//	char* screen2 = (char*)0xb8002;
//	screen2[0] = 's';
//	}

#define WHITE_TXT 0xFC // define la culoare, sa nu te doara capul

void k_clear_screen();
unsigned int k_printf(char *message, unsigned int line);


void kmain() // functia main
{
	k_clear_screen();
	k_printf("Bun venit!\n", 0);
};

void k_clear_screen() // sterge ecran
{
	char *vidmem = (char *) 0xb8000;
	unsigned int i=0;
	while(i < (80*25*2))
	{
		vidmem[i]=' ';
		i++;
		vidmem[i]=WHITE_TXT;
		i++;
	};
};

unsigned int k_printf(char *message, unsigned int line) // tiparirea
{
	char *vidmem = (char *) 0xb8000;
	unsigned int i=0;

	i=(line*80*2);

	while(*message!=0)
	{
		if(*message=='\n') //linie noua
		{
			line++;
			i=(line*80*2);
			*message++;
		} else {
			vidmem[i]=*message;
			*message++;
			i++;
			vidmem[i]=WHITE_TXT;
			i++;
		};
	};

	return(1);
};

