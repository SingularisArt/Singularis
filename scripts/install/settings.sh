#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Executing settings"

log_info "Making zsh default shell"

chsh -s $(which zsh)
