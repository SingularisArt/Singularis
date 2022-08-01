#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Installing all of the needed packages"

OS="$(uname -s)"

case "$OS" in
  Linux)
    if [ -f "/etc/arch-release" ] || [ -f "/etc/artix-release" ]; then
      check_if_installed "yay"

      yay -Syu
      while read p; do
        yay -S $p --noconfirm
      done <$INSTALL_SCRIPTS/arch-packages.txt
      yay -Syu
    else
      log_error "Sorry. You aren't on an Arch Distro, so you're going to have to manually install the packages.
      Here's the package list.
      NOTE: The packages may be named something different since you're on a different distro."
      cat "$INSTALL_SCRIPTS"/arch-packages.txt | less
    fi
    ;;
  *)
    log_error "Sorry. You aren't on Linux, so you're going to have to manually install the packages.
    Here's the package list.
    NOTE: The packages may be named something different since you're on a different distro."
    cat "$INSTALL_SCRIPTS"/arch-packages.txt | less
    ;;
esac
