#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing python config"

check_if_installed "python-pip"

cat ${INSTALL_SCRIPTS}/python-libraries.txt | xargs pip3 install
