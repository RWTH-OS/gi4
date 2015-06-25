#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <dlfcn.h>
#include "ctest.h"

int main(int argc, char **argv) 
{
	void *lib_handle;
	void (*fn)(int);
	char *error;

	/*
	 * RTLD_LAZY: If specified, Linux is not concerned about
	 *            unresolved symbols until they are referenced. 
	 * RTLD_NOW: All unresolved symbols resolved when dlopen() is called. 
	 * RTLD_GLOBAL: Make symbol libraries visible.
	 */
	lib_handle = dlopen("libctest.so", RTLD_LAZY);
	if (!lib_handle) 
	{
		fprintf(stderr, "%s\n", dlerror());
		exit(1);
	}

	fn = dlsym(lib_handle, "ctest1");
	if ((error = dlerror()) != NULL)  
	{
		fprintf(stderr, "%s\n", error);
		exit(1);
	}

	(*fn)(42);

	fn = dlsym(lib_handle, "ctest2");
	if ((error = dlerror()) != NULL)
	{
		fprintf(stderr, "%s\n", error);
		exit(1);
	}

	(*fn)(24);

	dlclose(lib_handle);
	return 0;
}
