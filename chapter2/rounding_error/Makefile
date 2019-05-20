CC = gcc

CFLAGS = -O0 -Wall
LDFLAGS =

all: 	main

main:	main.o
	$(CC) $(LDFLAGS) $(CFLAGS) main.o -o main

main.o:	main.c
	$(CC) -c $(CFLAGS) main.c -o main.o

test:
	./main

clean:
	rm -f main.o main

depend:
	
