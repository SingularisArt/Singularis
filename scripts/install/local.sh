#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

ln -sf $LOCAL/bin/* $HOME/.local/bin/
ln -sf $LOCAL/share/* $HOME/.local/share/
