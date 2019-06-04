SUBDIRS = pi maximum mergesort rounding_error strcpy

.PHONY: all test build $(SUBDIRS) $(addprefix test-,$(SUBDIRS)) $(addprefix clean-,$(SUBDIRS))

all: build

build: $(SUBDIRS)

test: $(addprefix test-,$(SUBDIRS))
clean: $(addprefix clean-,$(SUBDIRS))

$(SUBDIRS):
	$(MAKE) -C $@

$(addprefix test-,$(SUBDIRS)): test-%: %
	$(MAKE) -C $* test

$(addprefix clean-,$(SUBDIRS)): clean-%:
	$(MAKE) -C $* clean
