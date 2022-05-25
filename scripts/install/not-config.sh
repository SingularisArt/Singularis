#!/usr/bin/bash

source bin/common
source bin/variables

for arg in "${@}"; do
  for folder in $(ls ${CONFIG_LOCATION}); do
    if [[ "${arg}" != "${folder}" ]]; then
      script="${CONFIG}/${folder}/script"
      [ -x "${script}" ] && "${script}"
    fi
  done
done
