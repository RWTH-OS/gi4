CC = gcc
CFLAGS = -Wall -O2

default: libctest.so prog

ctest.o: ctest.c ctest.h
	$(CC) -c -fPIC $(CFLAGS) -o ctest.o ctest.c

libctest.so: ctest.o
	$(CC) -shared -Wl,-soname,libctest.so -fPIC $(CFLAGS) ctest.o -o libctest.so

prog: prog.c
	$(CC) $(CFLAGS) -g -rdynamic -o prog prog.c -ldl

clean:
	rm -rf prog libctest.so *.o

test:
