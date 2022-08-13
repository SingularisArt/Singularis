#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Installing fonts"

if [[ -d "${THIRD_PARTY_TOOLS}/fonts" ]]; then
  ln -sf ${THIRD_PARTY_TOOLS}/fonts ~/.fonts
fi
