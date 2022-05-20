#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing my python config"

check_if_installed "python3.10"
check_if_installed "pip3"

cat ${INSTALL_SCRIPTS}/python-libraries.txt | xargs python3.10 -m pip install
