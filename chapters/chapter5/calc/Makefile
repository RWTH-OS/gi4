all: calc

calc: y.tab.o lex.yy.o
	gcc -o $@ $^

y.tab.c y.tab.h: calc.yacc
	yacc -d $^

lex.yy.c: calc.lex
	lex $^

clean:
	rm -f lex.yy.c y.tab.c y.tab.h calc

test: calc
	test "$$(echo '(2*4)+3' | ./calc)" -eq 11
