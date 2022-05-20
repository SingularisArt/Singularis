#!/usr/bin/bash

log_notice "Installing fonts"

if [[ -d "${THIRD_PARTY_TOOLS}/fonts" ]]; then
  ln -sf ${THIRD_PARTY_TOOLS}/fonts ~/.fonts
fi
