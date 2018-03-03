NAME=git-url

INSTALL?=install -c
PREFIX?=/usr/local
BIN_DIR?=$(DESTDIR)$(PREFIX)/bin
SHARE_DIR?=$(DESTDIR)$(PREFIX)/share/$(NAME)
DOC_DIR?=$(DESTDIR)$(PREFIX)/share/doc/$(NAME)

all: zgiturl cgiturl git-url

zgiturl:
	make -C giturl

cgiturl:
	cd cgiturl && cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) .
	make -C cgiturl

git-url:
	@echo Hello World

install: zgiturl cgiturl git-url
	make -C cgiturl install
	make -C giturl install PREFIX=$(PREFIX)
	$(INSTALL) -d $(SHARE_DIR)
	$(INSTALL) -d $(DOC_DIR)
	cp git-url $(BIN_DIR)
	cp README.md LICENSE $(DOC_DIR)

uninstall:
	make -C cgiturl uninstall
	make -C giturl uninstall
	rm -f $(BIN_DIR)/git-url
	rm -f $(DOC_DIR)/README.md $(DOC_DIR)/LICENSE
	[ -d $(DOC_DIR) ] && rmdir $(DOC_DIR) || true
	rm -f $(SHARE_DIR)/*
	[ -d $(SHARE_DIR) ] && rmdir $(SHARE_DIR) || true

.PHONY: all install uninstall zgiturl cgiturl
