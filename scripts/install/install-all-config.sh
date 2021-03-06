#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing all of my configurations"

for script in $(find "${CONFIG}/" -maxdepth 2 -name "script"); do
  [ -x "${script}" ] && "${script}"
done
