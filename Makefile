DIRS=$(shell find . -type f -name Makefile | xargs dirname | egrep -v '^\.$$')

.PHONY: all $(DIRS)

all: $(DIRS)

test:
	make -C chapter2 test
	make -C basics test
 
$(DIRS):
	$(MAKE) -C $@
