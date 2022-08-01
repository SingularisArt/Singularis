#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

check_if_installed "npm"

log_notice "Installing npm libraries"

while read p; do
  sudo npm -i -g $p
done <$INSTALL_SCRIPTS/npm-libraries.txt
