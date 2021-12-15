NAME=git-url

INSTALL?=install -c
PREFIX?=/usr/local
BIN_DIR?=$(DESTDIR)$(PREFIX)/bin
SHARE_DIR?=$(DESTDIR)$(PREFIX)/share/$(NAME)
DOC_DIR?=$(DESTDIR)$(PREFIX)/share/doc/$(NAME)
MAN_DIR?=$(DESTDIR)$(PREFIX)/share/man/man1

#cgiturl/cgiturl
all: giturl/zgiturl git-url git-guclone

test:
	@make -C test

giturl/zgiturl: giturl/giturl.main giturl/lib/codes_huffman giturl/lib/coding_functions giturl/lib/math_functions \
giturl/lib/script_preamble giturl/lib/script_vars giturl/lib/sites_urls
	@echo "[32m== Building zgiturl (Zsh) ==[0m" || true
	@make -C giturl || true

#cgiturl/cgiturl: cgiturl/main.cpp cgiturl/math_functions.cpp cgiturl/math_functions.h \
#cgiturl/util.cpp cgiturl/util.h cgiturl/coding_functions.cpp cgiturl/coding_functions.h \
#cgiturl/optionparser.h
#	@[ x"${GITURL_NO_CGITURL}" = x ] && echo "[32m== Building cgiturl (C++, CMake) ==[0m" || true
#	@cd cgiturl && [ x"${GITURL_NO_CGITURL}" = x ] && cmake -DCMAKE_INSTALL_PREFIX=$(PREFIX) . || true
#	[ x"${GITURL_NO_CGITURL}" = x ] && make -C cgiturl || true

git-url: lib/script_preamble lib/common git-url.main
	@echo "[32m== Building main script: git-url (Bash) ==[0m" || true
	cat lib/script_preamble > git-url
	cat lib/common git-url.main | egrep -v '(# vim|# -)' >> git-url
	chmod a+x git-url

git-guclone: lib/script_preamble2 lib/common git-guclone.main
	@echo "[32m== Building main script: git-guclone (Bash) ==[0m" || true
	cat lib/script_preamble2 > git-guclone
	cat lib/common git-guclone.main | egrep -v '(# vim|# -)' >> git-guclone
	chmod a+x git-guclone

# cgiturl/cgiturl
install: giturl/zgiturl git-url git-guclone
	@echo "[32m== Installing zgiturl ==[0m" || true
	@make -C giturl install PREFIX=$(PREFIX) || true
#	@[ x"${GITURL_NO_CGITURL}" = x ] && echo "[32m== Installing cgiturl ==[0m" || true
#	[ x"${GITURL_NO_CGITURL}" = x ] && make -C cgiturl install || true
	@echo "[32m== Installing main scripts (git-url, git-guclone) ==[0m" || true
	$(INSTALL) -d $(BIN_DIR)
	$(INSTALL) -d $(SHARE_DIR)
	$(INSTALL) -d $(DOC_DIR)
	$(INSTALL) -d $(MAN_DIR)
	cp git-url git-guclone $(BIN_DIR)
	cp docs/README.md LICENSE doc/git-url.adoc doc/git-guclone.adoc $(DOC_DIR)
	cp doc/git-url.1 doc/git-guclone.1 $(MAN_DIR)

uninstall:
	@echo "[32m== Unstalling zgiturl ==[0m" || true
	@make -C giturl uninstall || true
#	@echo "[32m== Unstalling cgiturl ==[0m" || true
#	@make -C cgiturl uninstall || true
	@echo "[32m== Unstalling main scripts (git-url, git-guclone) ==[0m" || true
	rm -f $(BIN_DIR)/git-url $(BIN_DIR)/git-guclone
	rm -f $(DOC_DIR)/README.md $(DOC_DIR)/LICENSE $(DOC_DIR)/git-url.adoc $(DOC_DIR)/git-guclone.adoc
	rm -f $(MAN_DIR)/git-url.1 $(MAN_DIR)/git-guclone.1
	[ -d $(DOC_DIR) ] && rmdir $(DOC_DIR) || true
	rm -f $(SHARE_DIR)/*
	[ -d $(SHARE_DIR) ] && rmdir $(SHARE_DIR) || true

#	make -C cgiturl clean || true
clean:
	make -C giturl clean || true
	rm -f git-url git-guclone

.PHONY: all install uninstall test clean
