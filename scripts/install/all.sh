#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

source_install_script "git.sh"
source_install_script "arch-packages.sh"
source_install_script "python-libraries.sh"
source_install_script "npm-libraries.sh"
source_install_script "install-all-config.sh"
source_install_script "colorscheme.sh"
