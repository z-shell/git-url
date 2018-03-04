# This Makefile is to convert supplied Asciidoc files into
# other formats like man.

all: man

# MANUALS
# Converted with a2x from asciidoc package

man: git-url.1 git-guclone.1

git-url.1: git-url.adoc
	a2x --verbose -L --doctype manpage --format manpage git-url.adoc

git-guclone.1: git-guclone.adoc
	a2x --verbose -L --doctype manpage --format manpage git-guclone.adoc

# PDFS
# Uses asciidoctor not a2x (i.e. not asciidoc)

pdf: git-url.pdf

git-url.pdf: git-url.adoc
	asciidoctor -a reproducible -b pdf -r asciidoctor-pdf git-url.adoc

clean:
	rm -f *.1 *.pdf

.PHONY: man pdf clean

# vim:noet:sts=8:ts=8
