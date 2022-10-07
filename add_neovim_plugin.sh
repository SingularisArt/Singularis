#!/usr/bin/env bash

base_name=$(echo "$1" | sed "s/https:\/\/github.com\///")
url="https://github.com/$base_name"
path="aspects/nvim/files/.config/nvim/pack/plugins/opt"

echo "$url" >> ~/....f

user=$(cut -d "/" -f 4 ~/....f)
plugin=$(cut -d "/" -f 5 ~/....f)

git submodule add --name "$plugin" "$url" "$path/$plugin"

rm -rf ~/....f
