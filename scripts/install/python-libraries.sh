#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Installing python config"

check_if_installed "python-pip"

while read p; do
  pip3 install $p
done <./python-libraries.txt
