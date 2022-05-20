#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Dealing with git"

check_if_installed "git"

git pull

git submodule update --init --recursive

