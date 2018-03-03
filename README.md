# git-url

This package adds two Git commands:
 - **url** – generates so called *giturl* which encodes repository fetch-URL and revision
   (can also hold paths to files); example giturl: `gitu://ҝjȩMżEäḝЃȣϟṈӛŀї` (points to
   `master` branch of this project),
 - **guclone** – clones given giturl, checkouts revision stored in this giturl.

The giturls use 1024 **unicode letters** via base-1024 encoding, and also Huffman codes,
to compress resulting string. Thanks to using glyphs that are **letters** (not symbols)
double clicking on giturl always selects whole string, regardless if it's done in e.g.
Firefox, Chrome, iTerm2, xterm, etc. `git url ...` and `git guclone ...` understand
giturls also without leading `gitu://`, and with leading `//`, so grabbing and using
such url is easy.

Compare length of the above example giturl to the data it stores:

```
ҝjȩMżEäḝЃȣϟṈӛŀї
https://github.com/zdharma/git-urlmaster
```

# Installation

Clone and run `make install`. Default install location is `/usr/local`. Can be overriden
by setting `PREFIX`, e.g. `make install PREFIX=/opt`.

```sh
git clone https://github.com/zdharma/git-url
cd git-url
make install
```

If you use Zshell then there's a nice way of installing – via [Zplugin](https://github.com/zdharma/zplugin):

```zsh
zplugin ice as"program" pick"$ZPFX/bin/git-(url|guclone)" make"install PREFIX=$ZPFX"
zplugin light zdharma/git-url
```

To update, execute `zplugin update zdharma/git-url`. `$ZPFX` is `~/.zplugin/polaris` by default.
