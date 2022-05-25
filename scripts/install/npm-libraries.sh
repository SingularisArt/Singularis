#!/usr/bin/bash

source bin/common
source bin/variables

check_if_installed "npm"

log_notice "Installing npm libraries"

cat "${INSTALL_SCRIPTS}/npm-libraries.txt" | xargs sudo npm i -g
