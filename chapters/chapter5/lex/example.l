Ziffer		[0-9]
Buchstabe	[A-Za-z]
%{
	int zaehler;
%}
%%
{Buchstabe}({Buchstabe}|{Ziffer})*	{ zaehler++; printf("Identifier erkannt: %s\n", yytext);}
.
%%
int yywrap(void) {
	return 1;
}

int main(int argc, char *argv[]) {
	yyin = fopen(argv[1], "r");
	if (yyin == NULL)
		return -1;

	yylex();
	printf("Anzahl der erkannten Identifiers = %d\n", zaehler);
	fclose(yyin);

	return 0;
}
