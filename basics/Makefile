.PHONY: all depend clean test

all:
	make -C c all
	make -C asm all
	make -C simple all

test:
	make -C c test
	make -C asm test
	make -C simple test
 
clean:
	make -C c clean
	make -C asm clean
	make -C simple clean

depend:
	make -C c depend
	make -C asm depend
	make -C simple depend
