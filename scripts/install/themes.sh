#!/usr/bin/bash

log_notice "Installing themes"

if [[ -d "${SINGULARIS}/themes/" ]]; then
  ln -sf ${SINGULARIS}/themes/ ~/.themes
fi

if [[ -d "${SINGULARIS}/icons/" ]]; then
  ln -sf ${SINGULARIS}/icons/ ~/.icons
fi
