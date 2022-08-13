#!/usr/bin/bash

source "$HOME/Singularis/bin/common"
source "$HOME/Singularis/bin/variables"

log_notice "Installing all of my configurations"

for arg in "${@}" ; do
#   [[ "${arg:0:1}" == "^" ]] && not=true || not=false
#   echo $not
#   # if [[ "${arg}" == "${config}" ]]; then
#   #   script="${CONFIG}/${config}/script"
#   #   [ -x "${script}" ] && "${script}"
#   # fi
  echo $arg
done

# source_install_script "not-config.sh" "${@:command_num}"
