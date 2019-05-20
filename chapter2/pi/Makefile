default:
	$(MAKE) all

all:
	$(MAKE) -C v1 all
	$(MAKE) -C v2 all
	$(MAKE) -C v3 all
	$(MAKE) -C v4 all
	$(MAKE) -C v5 all
	$(MAKE) -C v6 all
	$(MAKE) -C v7 all
	$(MAKE) -C fpu64 all

clean:
	$(MAKE) -C v1 clean
	$(MAKE) -C v2 clean
	$(MAKE) -C v3 clean
	$(MAKE) -C v4 clean
	$(MAKE) -C v5 clean
	$(MAKE) -C v6 clean
	$(MAKE) -C v7 clean
	$(MAKE) -C fpu64 clean

test:
	$(MAKE) -C v1 test
	$(MAKE) -C v2 test
	$(MAKE) -C v3 test
	$(MAKE) -C v4 test
	$(MAKE) -C v5 test
	$(MAKE) -C v6 test
	#$(MAKE) -C v7 test
	$(MAKE) -C fpu64 test

depend:
	$(MAKE) -C v1 depend
	$(MAKE) -C v2 depend
	$(MAKE) -C v3 depend
	$(MAKE) -C v4 depend
	$(MAKE) -C v5 depend
	$(MAKE) -C v6 depend
	$(MAKE) -C v7 depend
	$(MAKE) -C fpu64 depend

