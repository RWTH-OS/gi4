#ACHTUNG: alle *.asm u. *.c Dateien im Ordner dieses Makefiles
#         werden zur ausführbaren Datei "start" zusammengebunden!
UNAME := $(shell uname)
MAKE = make 
CC = gcc 
CFLAGS = -Wall -O0 -g #-pthread, nur für POSIX-Threads notwendig
RM = rm -rf                #rm = Unix-Befehl remove = Dateien löschen 
ASM = nasm 
ifeq ($(UNAME), Darwin)
ASMFLAGS = -f macho64 -O0 -g --prefix _
LDFLAGS =
else
ASMFLAGS = -f elf64 -O0 -g -F dwarf
LDFLAGS = -static
endif

NAME = start # Name des Programms/der ausführbaren Datei

# Objekt-Datei-Liste generieren aus Quell-Datei-Listen
OBJS  = $(patsubst %.c, %.o, $(wildcard *.c))
OBJS += $(patsubst %.asm, %.o, $(wildcard *.asm))
SRC = $(wildcard *.c)

.PHONY: clean

# Erzeugung von Objektdateien (*.o) aus den Quellcodedateien (*.c u. *.asm)
%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

all:
	$(MAKE) $(NAME)

$(NAME): $(OBJS)
	$(CC) $(LDFLAGS) $(CFLAGS) -o $(NAME) $(OBJS)

clean:
	$(RM) *.o $(NAME)

depend: .depend

.depend: $(SRC)
	$(CC) $(CFLAGS) -MM $^ > .depend;

include .depend
