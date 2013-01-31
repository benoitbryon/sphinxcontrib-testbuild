ROOT_DIR = $(shell pwd)
BIN_DIR = $(ROOT_DIR)/bin
BUILDOUT_DIR = $(ROOT_DIR)/lib/buildout
BUILDOUT = $(BIN_DIR)/buildout
PYTHON = python
NOSE = $(BIN_DIR)/nosetests


develop: buildout


buildout:
	if [ ! -d $(BUILDOUT_DIR)/downloads ]; then \
		mkdir -p $(BUILDOUT_DIR)/downloads; \
	fi
	if [ ! -f $(BUILDOUT_DIR)/bootstrap.py ]; then \
		wget -O $(BUILDOUT_DIR)/bootstrap.py https://raw.github.com/buildout/buildout/1.7.0/bootstrap/bootstrap.py; \
	fi
	if [ ! -x $(BUILDOUT) ]; then \
		$(PYTHON) $(BUILDOUT_DIR)/bootstrap.py --distribute -c etc/buildout.cfg buildout:directory=$(ROOT_DIR); \
	fi
	$(BUILDOUT) -N -c etc/buildout.cfg buildout:directory=$(ROOT_DIR)


maintainer-clean:
	rm -r bin/ lib/


release:
	bin/fullrelease


documentation:
	mkdir -p docs/_static
	mkdir -p $(ROOT_DIR)/var/docs
	make --directory=docs clean html doctest


test:
	$(NOSE) --config=etc/nose.cfg
