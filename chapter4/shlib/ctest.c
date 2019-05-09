#include <stdio.h>
#include <stdlib.h>

static void __attribute__ ((constructor)) _init(void);
static void __attribute__ ((destructor)) _fini(void);

static void _init(void)
{
	printf("Library initialized\n");
}

static void _fini(void)
{
	printf("Library finalized\n");
}

void ctest1(int arg)
{
	printf("ctest1 got arg %d\n", arg);
}

void ctest2(int arg)
{
	printf("ctest2 got arg %d\n", arg);
}
