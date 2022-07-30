#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

for arg in "${@}"; do
  for folder in $(ls ${CONFIG_LOCATION}); do
    if [[ "${arg}" != "${folder}" ]]; then
      script="${CONFIG}/${folder}/script"
      [ -x "${script}" ] && "${script}"
    fi
  done
done
