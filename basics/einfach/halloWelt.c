#include <stdio.h>
#define STR_END '\0'

int main()
{
  /* das einfachste Programm - um mal das Makefile und den DDD zu testen */
  int index = -1;
  char lokalesArray[30] = "Hello World!!!!";
  char* zeigerAufZeichenkettenkonst = "Hallo Welt!";
  
  printf("%s\n", lokalesArray);
  
  for (index = 0; *zeigerAufZeichenkettenkonst != STR_END; index++)
    lokalesArray[index] = *zeigerAufZeichenkettenkonst++;
  
  lokalesArray[index] = STR_END;

  printf("\noder...\n\n%s\n", lokalesArray);
  
	return 0;
}
