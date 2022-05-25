#!/usr/bin/bash

source bin/common
source bin/variables

source_install_script "git.sh"
source_install_script "arch-packages.sh"
source_install_script "python-libraries.sh"
source_install_script "npm-libraries.sh"
source_install_script "install-all-config.sh"
