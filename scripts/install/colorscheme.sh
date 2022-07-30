#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Generating colorscheme"

cd ${THIRD_PARTY_TOOLS}/start-tree
./init.sh
./generate.py
cd ${THIRD_PARTY_TOOLS}/chameleon
./chameleon.py -i /home/singularis/Singularis/media/wallpapers/0942.jpg
