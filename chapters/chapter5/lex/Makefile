CC=gcc
CFLAGS=-Wall -O2
LEX=lex
LEXFLAGS=

default:
	make varcounter

lex.yy.c: example.l
	$(LEX) $(LEXFLAGS) $<

varcounter: lex.yy.o
	$(CC) $(CFLAGS) -o $@ lex.yy.o

clean:
	rm -rf varcounter *.o lex.yy.c lex.yy.h

test:
