#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Generating colorscheme"

log_info "Setting up start-tree"

cd ${THIRD_PARTY_TOOLS}/start-tree
./init.sh
./generate.py

log_info "Setting up GnuPlot"

cd ${THIRD_PARTY_TOOLS}/gnuplot-pywal
sudo bash install.sh

log_info "Setting up everything else"

cd ${THIRD_PARTY_TOOLS}/chameleon
./chameleon.py -i /home/singularis/Singularis/media/wallpapers/0942.jpg
