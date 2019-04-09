DIRS=$(shell find . -type f -name Makefile | xargs dirname | egrep -v '^\.$$')

.PHONY: all $(DIRS)

all: $(DIRS)

$(DIRS):
	$(MAKE) -C $@
