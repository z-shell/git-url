NAME=git-url

INSTALL?=install -c
PREFIX?=/usr/local
BIN_DIR?=$(DESTDIR)$(PREFIX)/bin
SHARE_DIR?=$(DESTDIR)$(PREFIX)/share/$(NAME)
DOC_DIR?=$(DESTDIR)$(PREFIX)/share/doc/$(NAME)
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man/man1

all: zgiturl cgiturl git-url git-guclone

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

git-guclone: lib/script_preamble2 lib/common git-guclone.main
	cat lib/script_preamble2 > git-guclone
	cat lib/common git-guclone.main | egrep -v '(# vim|# -)' >> git-guclone
	chmod a+x git-guclone

install: zgiturl cgiturl git-url git-guclone
	make -C cgiturl install
	make -C giturl install PREFIX=$(PREFIX)
	$(INSTALL) -d $(SHARE_DIR)
	$(INSTALL) -d $(DOC_DIR)
	$(INSTALL) -d $(MAN_DIR)
	cp git-url git-guclone $(BIN_DIR)
	cp README.md LICENSE doc/git-url.adoc doc/git-guclone.adoc $(DOC_DIR)
	cp doc/git-url.1 doc/git-guclone.1 $(MAN_DIR)

uninstall:
	make -C cgiturl uninstall
	make -C giturl uninstall
	rm -f $(BIN_DIR)/git-url $(BIN_DIR)/git-guclone
	rm -f $(DOC_DIR)/README.md $(DOC_DIR)/LICENSE $(DOC_DIR)/git-url.adoc $(DOC_DIR)/git-guclone.adoc
	rm -f $(MAN_DIR)/git-url.1 $(MAN_DIR)/git-guclone.1
	[ -d $(DOC_DIR) ] && rmdir $(DOC_DIR) || true
	rm -f $(SHARE_DIR)/*
	[ -d $(SHARE_DIR) ] && rmdir $(SHARE_DIR) || true

clean:
	rm -f git-url git-guclone

.PHONY: all install uninstall zgiturl cgiturl test
