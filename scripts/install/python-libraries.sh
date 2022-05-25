#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing python config"

check_if_installed "pip3"

cat ${INSTALL_SCRIPTS}/python-libraries.txt | xargs pip3 install
