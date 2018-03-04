# git-url

This package adds two Git commands:
 - **url** – generates so called *giturl* which encodes repository fetch-URL and revision
   (can also hold paths to files); example giturl: `gitu://ҝjȩMżEäḝЃȣϟṈӛŀї` (points to
   `master` branch of this project),
 - **guclone** – clones given giturl, checkouts revision stored in this giturl.

In short:
 1. The giturls use 1024 **unicode letters** via base-1024 encoding, and also Huffman codes,
    to compress resulting string.
 2. Thanks to using glyphs that are **letters** (not symbols) double clicking on giturl always
    selects whole string, regardless if it's done in e.g.  Firefox, Chrome, iTerm2, xterm, etc.
 3. `git url ...` and `git guclone ...` understand giturls also without leading `gitu://`, and
    with leading `//`, so grabbing and using such url is easy.

Compare length of the above example giturl to the data it stores:

```
ҝjȩMżEäḝЃȣϟṈӛŀї
https://github.com/zdharma/git-urlmaster
```

## Screenshot

![Screenshot](https://raw.githubusercontent.com/zdharma/git-url/images/git-url.png)

# Installation

Recursively clone and run `make install`. Default install location is `/usr/local`. It
can be overriden by setting `PREFIX`, e.g. `make install PREFIX=/opt`.

```sh
git clone --recursive https://github.com/zdharma/git-url
cd git-url
make install
```

If you use Zshell then there's a nice way of installing – via [Zplugin](https://github.com/zdharma/zplugin):

```zsh
zplugin ice as"program" pick"$ZPFX/bin/git-(url|guclone)" make"install PREFIX=$ZPFX"
zplugin light zdharma/git-url
```

To update, execute `zplugin update zdharma/git-url`. `$ZPFX` is `~/.zplugin/polaris` by default.

The project uses two subprojects, one of them written in C++, second one in Zshell. They are the
computation backends, and any of the two will work (choose with `export GITURL_TOOL=zgiturl` or
`...=cgiturl`).

# Limitations

Only a subset of ASCII is encoded. This is sufficient for typical Github usage, where user and
repository name are required to not use symbols, and where typical project branch names and
file names are simple ASCII. Following characters can appear in input data – in the server,
repository path, user name, revision, file path: [a-zA-Z0-9._~:/-].

# Encoding file paths

Use `-p` option to embed path to file in giturl:

```sh
% git url -p lib/common.sh
Encoding... INPUT is next paragraph:

Protocol:  https
Site:      github.com
Repo:      zdharma/zplugin.git
Revision:  master
File:      lib/common.sh

gitu://ŬϽẝá0ȘéőϞȳƾǱϠѝŌěcḆΚṳȣϟṈӛŀї
```
