NAME=git-url

INSTALL?=install -c
PREFIX?=/usr/local
BIN_DIR?=$(DESTDIR)$(PREFIX)/bin
SHARE_DIR?=$(DESTDIR)$(PREFIX)/share/$(NAME)
DOC_DIR?=$(DESTDIR)$(PREFIX)/share/doc/$(NAME)

all: zgiturl cgiturl git-url git-uclone

test:
	@make -C test

zgiturl:
	make -C giturl

cgiturl:
	cd cgiturl && cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) .
	make -C cgiturl

git-url: lib/script_preamble lib/common git-url.main
	cat lib/script_preamble > git-url
	cat lib/common git-url.main | egrep -v '(# vim|# -)' >> git-url
	chmod a+x git-url

git-uclone: lib/script_preamble2 lib/common git-uclone.main
	cat lib/script_preamble2 > git-uclone
	cat lib/common git-uclone.main | egrep -v '(# vim|# -)' >> git-uclone
	chmod a+x git-uclone

install: zgiturl cgiturl git-url git-uclone
	make -C cgiturl install
	make -C giturl install PREFIX=$(PREFIX)
	$(INSTALL) -d $(SHARE_DIR)
	$(INSTALL) -d $(DOC_DIR)
	cp git-url git-uclone $(BIN_DIR)
	cp README.md LICENSE $(DOC_DIR)

uninstall:
	make -C cgiturl uninstall
	make -C giturl uninstall
	rm -f $(BIN_DIR)/git-url $(BIN_DIR)/git-uclone
	rm -f $(DOC_DIR)/README.md $(DOC_DIR)/LICENSE
	[ -d $(DOC_DIR) ] && rmdir $(DOC_DIR) || true
	rm -f $(SHARE_DIR)/*
	[ -d $(SHARE_DIR) ] && rmdir $(SHARE_DIR) || true

clean:
	rm -f git-url git-uclone

.PHONY: all install uninstall zgiturl cgiturl test
