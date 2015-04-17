#ACHTUNG: alle *.asm u. *.c Dateien im Ordner dieses Makefiles 
#         werden zur ausführbaren Datei "start" zusammengebunden!
MAKE = make 
CC = gcc 
CFLAGS = -m32 -Wall -O0 -g #-pthread, nur für POSIX-Threads notwendig
RM = rm -rf                #rm = Unix-Befehl remove = Dateien löschen 
ASM = nasm 
ASMFLAGS = -f elf32 -O0 -g -F dwarf

NAME = start # Name des Programms/der ausführbaren Datei 

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
