#!/usr/bin/env bats

export GITURL_TOOL

if [[ -z "$GITURL_TOOL" ]]; then
    echo "You must set GITURL_TOOL to value like ../zgiturl/zgiturl or"
    echo "use Makefile which does this."
    exit 1
fi

@test "Encoding of current git-url repository" {
  run ../git-url -qn
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "gitu://3ẦŅϠѝŌĜEäḝЃȯŅǍǴḀї" ]
}

@test "Decoding of git-url url gitu://3ẦŅϠѝŌĜEäḝЃȯŅǍǴḀї" {
  run ../git-url -qn gitu://3ẦŅϠѝŌĜEäḝЃȯŅǍǴḀї
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "https://github.com/z-shell/git-url /  rev:main" ]
}

#@test "Encoding of custom repository data" {
#  run ../git-url -qn -u hhttps://github.com/z-shell/git-url -p lib/common -r gh-pages
#  [ "$status" -eq 0 ]
#  [ "${#lines[@]}" -eq 1 ]
#  [ "${lines[0]}" = "gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї" ]
#}

#@test "Decoding of git-url url gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї" {
#  run ../git-url -qn gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї
#  [ "$status" -eq 0 ]
#  [ "${#lines[@]}" -eq 1 ]
#  [ "${lines[0]}" = "https://github.com/zdharma/git-url.git /  rev:gh-pages /  file:lib/common" ]
#}
