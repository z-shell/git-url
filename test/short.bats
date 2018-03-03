#!/usr/bin/env bats
# vim:ft=sh

export GITURL_TOOL

if [[ -z "$GITURL_TOOL" ]]; then
    echo "You must set GITURL_TOOL to value like ../cgiturl/cgiturl or"
    echo "use Makefile which does this."
    exit 1
fi

@test "Encoding of current git-url repository" {
  run ../git-url -qn
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "gitu://ҝjȩMżEäḝЃȣϟṈӛŀї" ]
}

@test "Decoding of git-url url gitu://ҝjȩMżEäḝЃȣϟṈӛŀї" {
  run ../git-url -qn gitu://ҝjȩMżEäḝЃȣϟṈӛŀї
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "https://github.com/zdharma/git-url /  rev:master" ]
}

@test "Encoding of custom repository data" {
  run ../git-url -qn -u https://github.com/zdharma/git-url.git -p lib/common -r gh-pages
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї" ]
}

@test "Decoding of git-url url gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї" {
  run ../git-url -qn gitu://3Ầȓ1ṙȫК5ǳóŽĤöѝŌĜEäḝЃȣϟṈӛŀї
  [ "$status" -eq 0 ]
  [ "${#lines[@]}" -eq 1 ]
  [ "${lines[0]}" = "https://github.com/zdharma/git-url.git /  rev:gh-pages /  file:lib/common" ]
}
