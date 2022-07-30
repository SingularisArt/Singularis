#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Dealing with git"

check_if_installed "git"

git pull
git submodule update --init --recursive
