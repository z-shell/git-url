<p align="center">
<a href="https://github.com/z-shell/git-url">
<img src="https://github.com/z-shell/git-url/raw/images/z-git-url.png"/>
</a>
</p>

[![Test Git-URL](https://github.com/z-shell/git-url/actions/workflows/makefile.yml/badge.svg?branch=main)](https://github.com/z-shell/git-url/actions/workflows/makefile.yml)

> **Note:** `cgiturl` backend temporary disabled due to deprecation, `however` zgiturl backend tested and is fully functional.

- [Introduction](#introduction)
  - [This package adds two Git commands](#this-package-adds-two-git-commands)
  - [In short](#in-short)
- [Installation](#installation)
  - [Install with `make`](#install-with-make)
  - [ZI](#zi)
- [Extra info](#extra-info)
  - [Known limitations](#known-limitations)
  - [Encoding the file paths](#encoding-the-file-paths)

## Introduction

### This package adds two Git commands

- `url` – generates so called _giturl_ which encodes repository fetch-URL and revision
  (can also hold paths to files); example giturl: `gitu://ҝjȩMżEäḝЃȣϟṈӛŀї` (points to `main` branch of this project),
- `guclone` – clones given giturl, checkouts revision stored in this giturl.

### In short

1. The giturls use 1024 **unicode letters** via base-1024 encoding, and also Huffman codes, to compress resulting string.
   - **SMALL SIZE**
2. Thanks to using glyphs that are **letters** (not symbols) double clicking on giturl always selects whole string, regardless if it's done in e.g. Firefox, Chrome, iTerm2, xterm, etc.
   - **CALM SELECTING**
3. `git url ...` and `git guclone ...` understand giturls also without leading `gitu://`, and with leading `//`, so grabbing and using such url is easy.
   - **EASY USE**
4. You can encode path to file in the giturl, to e.g. point someone to a location in project.
   - **PACKED WITH DATA**

Compare length of the above example giturl to the data it stores:

```zsh
ҝjȩMżEäḝЃȣϟṈӛŀї
https://github.com/z-shell/git-url
```

## Installation

### Install with `make`

Recursively clone and run `make install`. Default install location is `/usr/local`. It can be overriden by setting `PREFIX`, e.g. `make install PREFIX=/opt`.

```zsh
git clone --recursive https://github.com/z-shell/git-url
cd git-url
make install
```

### [ZI](https://github.com/z-shell/zi)

If you use [ZI](https://github.com/z-shell/zi), then there's a nice way of installing:

```zsh
zi ice as"program" pick"$ZPFX/bin/git-(url|guclone)" make"install PREFIX=$ZPFX"
zi light z-shell/git-url
```

To update, execute `zi update z-shell/git-url`. `$ZPFX` is `~/.zi/polaris` by default.

## Extra info

The project uses two subprojects, one of them written in **C++** (compiled with CMake), second one in **Zshell**.
They are the computation backends, and any of the two will work (choose with `export GITURL_TOOL=zgiturl` or `...=cgiturl`).

### Known limitations

Only a subset of **ASCII** is encoded. This is sufficient for typical Github usage, where user and
repository name are required to not use symbols, and where typical project branch names and
file names are simple **ASCII**. Following characters can appear in input data – in the server,
repository path, user name, revision, file path: `[a-zA-Z0-9._~:/-]`.

### Encoding the file paths

Use `-p` option to embed path to file in giturl:

```zsh
❯ git-url
Encoding... INPUT is next paragraph:

Protocol: ssh
User:     git
Site:     github.com
Repo:     z-shell/git-url.git
Revision: main

gitu://VъöчŅϠѝŌĜEäḝЃȯŅǍǴḀЧ
❯ git clone gitu://VъöчŅϠѝŌĜEäḝЃȯŅǍǴḀЧ
```

Suggested is to use tilde `~` to separate multiple file paths. The project can be easily
extended if this workaround will not suffice, to encode multiple file paths natively.
