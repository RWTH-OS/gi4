UNAME := $(shell uname)
MAKE = make
CC = gcc
CXX = g++
RM = rm -rf
ASM = nasm
ifeq ($(UNAME), Darwin)
CFLAGS = -Wall -O3 -g -march=native -mtune=native
ASMFLAGS = -f macho64 -O0 -g --prefix _
LDFLAGS =
else
CFLAGS = -Wall -O3 -g -march=native -mtune=native -mfpmath=sse,387
ASMFLAGS = -f elf64 -O0 -g -F dwarf
LDFLAGS =
endif
CXXFLAGS = $(CFLAGS)
NAME = start
C_source = main.c
CPP_source =
ASM_source = string_copy.asm
# extend this for other object files
OBJS += $(patsubst %.cpp, %.o, $(filter %.cpp, $(CPP_source)))
OBJS += $(patsubst %.c, %.o, $(filter %.c, $(C_source)))
OBJS += $(patsubst %.asm, %.o, $(filter %.asm, $(ASM_source)))

# other implicit rules
%.o : %.c
	$(CC) -c $(CFLAGS) -o $@ $<

%.o : %.cpp
	$(CXX) -c $(CXXFLAGS) -o $@ $<

%.o : %.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

default:
	$(MAKE) $(NAME)

all:
	$(MAKE) $(NAME)

test: $(NAME)
	./$(NAME)

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(LDFLAGS)

clean:
	$(RM) *.o $(NAME)

depend:
	$(CC) -MM $(CFLAGS) $(C_source) $(CPP_source) > Makefile.dep

-include Makefile.dep
# DO NOT DELETE


