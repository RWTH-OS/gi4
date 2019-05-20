#ACHTUNG: alle *.asm u. *.c Dateien im Ordner dieses Makefiles
#         werden zur ausführbaren Datei "start" zusammengebunden!
UNAME := $(shell uname)
MAKE = make
CC = gcc
CXX = g++
ifeq ($(UNAME), Darwin)
CFLAGS = -Wall -O0 -g -march=native -mtune=native -pthread
ASMFLAGS = -f macho64 -O0 -g --prefix _
LDFLAGS =
else
CFLAGS = -Wall -O0 -g -march=native -mtune=native -mfpmath=sse,387 -pthread
ASMFLAGS = -f elf64 -O0 -g -F dwarf
LDFLAGS =
endif
RM = rm -rf                #rm = Unix-Befehl remove = Dateien löschen
ASM = nasm

NAME = maximum # Name des Programms/der ausführbaren Datei

# Objekt-Datei-Liste generieren aus Quell-Datei-Listen
OBJS  = $(patsubst %.c, %.o, $(wildcard *.c))
OBJS += $(patsubst %.asm, %.o, $(wildcard *.asm))

.PHONY: clean

# Erzeugung von Objektdateien (*.o) aus den Quellcodedateien (*.c u. *.asm)
%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

all:
	$(MAKE) $(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS)

clean:
	$(RM) *.o $(NAME)
