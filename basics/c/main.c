#include <stdio.h>
#include <stdlib.h>
#include "cfunc.h"
#include "asmfunc.h"

int main(int argc, char** argv)
{
	/* call example C function */
	cfunc();

	/* call example assembler function */
	asmfunc();

	return 0;
}
