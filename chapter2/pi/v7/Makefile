MAKE = make
CC = gcc
CXX = g++
# optimzation flags
#CFLAGS = -Wall -O3
# flags for debugging
CFLAGS = -m32 -Wall -O0 -g -pthread
CXXFLAGS = $(CFLAGS)
LDFLAGS = 
RM = rm -rf
ASM = nasm
ASMFLAGS = -f elf32 -O0 -g -F dwarf
#ASMFLAGS = -f macho32 -O0 -g --prefix _
NAME = pi_v7
C_source = main.c
CPP_source =
ASM_source = calcPi_SSE_thread.asm
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

$(NAME): $(OBJS)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(LDFLAGS)

clean:
	$(RM) *.o $(NAME)

depend:
	$(CC) -MM $(CFLAGS) $(C_source) $(CPP_source) > Makefile.dep

-include Makefile.dep
# DO NOT DELETE


