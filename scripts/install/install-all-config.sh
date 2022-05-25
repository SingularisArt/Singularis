#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing all of my configurations"

for folder in $(find "${CONFIG}/" -maxdepth 2 -name "script"); do
  script="${folder}"
  [ -x "${script}" ] && "${script}"
done
