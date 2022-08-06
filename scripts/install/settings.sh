#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Executing settings"

log_info "Making zsh default shell"

chsh -s $(which zsh)

log_info "Enabling touchpad"

mkdir /etc/X11/xorg.conf.d/
sudo cp -r $BIN/touchpad /etc/X11/xorg.conf.d/70-synaptics.conf
