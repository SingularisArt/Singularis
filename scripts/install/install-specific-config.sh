#!/usr/bin/bash

source bin/common
source bin/variables

log_notice "Installing all of my configurations"

if [[ ${1} == 'backup' ]]; then
  ./aspects/script
  exit
fi
for arg in "${@}" ; do
  for config in $(ls ${CONFIG}) ; do
    if [[ "${arg}" == "${config}" ]]; then
      script="${CONFIG}/${config}/script"
      [ -x "${script}" ] && "${script}"
    fi
  done
done
