#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing all of the needed packages"

check_if_installed "yay"

yay -Syu --noconfirm
cat ${INSTALL_SCRIPTS}/arch-packages.txt | xargs yay -S
