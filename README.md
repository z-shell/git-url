# `GIT-URL`

---

This package adds two Git commands:

- **url** – generates so called _giturl_ which encodes repository fetch-URL and revision
  (can also hold paths to files); example giturl: `gitu://ҝjȩMżEäḝЃȣϟṈӛŀї` (points to
  `main` branch of this project),
- **guclone** – clones given giturl, checkouts revision stored in this giturl.

In short:

1. The giturls use 1024 **unicode letters** via base-1024 encoding, and also Huffman codes,
   to compress resulting string.
   - **SMALL SIZE**
2. Thanks to using glyphs that are **letters** (not symbols) double clicking on giturl always
   selects whole string, regardless if it's done in e.g. Firefox, Chrome, iTerm2, xterm, etc.
   - **CALM SELECTING**
3. `git url ...` and `git guclone ...` understand giturls also without leading `gitu://`, and
   with leading `//`, so grabbing and using such url is easy.
   - **EASY USE**
4. You can encode path to file in the giturl, to e.g. point someone to a location in project.
   - **PACKED WITH DATA**

Compare length of the above example giturl to the data it stores:

```shell
ҝjȩMżEäḝЃȣϟṈӛŀї
https://github.com/z-shell/git-urlmaster
```

## Screenshot

![Screenshot](https://raw.githubusercontent.com/z-shell/git-url/images/git-url.png)

## Installation

### make install

Recursively clone and run `make install`. Default install location is `/usr/local`. It
can be overriden by setting `PREFIX`, e.g. `make install PREFIX=/opt`.

```sh
git clone --recursive https://github.com/z-shell/git-url
cd git-url
make install
```

## Zinit

If you use Zshell then there's a nice way of installing – via [Zinit](https://github.com/z-shell/zinit):

```zsh
zinit ice as"program" pick"$ZPFX/bin/git-(url|guclone)" make"install PREFIX=$ZPFX"
zinit light z-shell/git-url
```

To update, execute `zinit update z-shell/git-url`. `$ZPFX` is `~/.zinit/polaris` by default.

## Extra info

The project uses two subprojects, one of them written in C++ (compiled with CMake), second
one in Zshell. They are the computation backends, and any of the two will work (choose with
`export GITURL_TOOL=zgiturl` or `...=cgiturl`).

## Limitations

Only a subset of ASCII is encoded. This is sufficient for typical Github usage, where user and
repository name are required to not use symbols, and where typical project branch names and
file names are simple ASCII. Following characters can appear in input data – in the server,
repository path, user name, revision, file path: [a-zA-Z0-9._~:/-].

## Encoding file paths

Use `-p` option to embed path to file in giturl:

```sh
% git url -p lib/common.sh
Encoding... INPUT is next paragraph:

Protocol:  https
Site:      github.com
Repo:      z-shell/zinit.git
Revision:  master
File:      lib/common.sh

gitu://ŬϽẝá0ȘéőϞȳƾǱϠѝŌěcḆΚṳȣϟṈӛŀї
```

Suggested is to use tilde `~` to separate multiple file paths. The project can be easily
extended if this workaround will not suffice, to encode multiple file paths natively.
