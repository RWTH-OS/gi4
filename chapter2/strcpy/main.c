#include <stdio.h>
#include <stdlib.h>

void string_copy(char*,char*);

int main(void){
	char string[100]="Hal";  // string muss gross genug sein fuer "Hallo Welt"

	printf("%s \n",string);
		string_copy(string,"Hallo Welt");
	printf("%s \n",string);

return 0;
}

