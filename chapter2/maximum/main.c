#include <stdio.h>
#include <stdlib.h>

int maximum(int a, int b);

int main(void){
	int a = 2;
	int b = 42;

	printf("maximum(%d, %d) = %d\n", a, b, maximum(a, b));

	return 0;
}

