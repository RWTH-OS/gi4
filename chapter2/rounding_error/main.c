#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv)
{
	float a = 1.0f;
	float b = 100000000.0f;
	float c = -100000000.0f;
	float erg1, erg2;

	erg1 = (a + b);
	erg1 += c;
	erg2 = (b + c);
	erg2 += a;

	printf("erg1 = %.10f\n", erg1);
	printf("erg2 = %.10f\n", erg2);
	printf("(a + b) + c = %.10f\n", (a + b) + c);
	printf("a + (b + c) = %.10f\n", a + (b + c));
	
	return 0;
}
