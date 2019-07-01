#include <stdio.h>
#include <stdlib.h>

/*
 * Der Linker definiert diese Symbole, deren Adressen der Beginn
 * des BSS- & Data-Segements repräsentieren.
 */
extern void __bss_start;
extern void __data_start;

int main(int argc, char** argv)
{
	size_t rsp;
	int* heap = (void*) malloc(sizeof(int));

	asm volatile("mov %%rsp, %0" : "=r"(rsp));

	printf("Main:\t%p\n", main);
	printf("Stack:\t0x%zx\n", rsp);
	printf("Data:\t%p\n", &__data_start);
	printf("Heap:\t%p\n", heap);
	printf("BSS:\t%p\n", &__bss_start);
	printf("printf\t%p\n", printf);

	return 0;
}
