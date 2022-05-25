#!/usr/bin/bash

source bin/common
source bin/variables

# Checking if the user passed any config to describe.
# If not, we will tell them that we need a config name.
# We also suggest to them to use the --list-configs parameter
# to view all available configs.
if [[ "${#}" = 0 ]]; then
  log_error "${0} needs an argument."
  log_error "Run ./install --list-configs to see what you can describe."
  exit
fi

for arg in "${@:1}"; do
  check_if_arg_is_a_command "${arg}"
  found=false

  for current_config in `ls ${CONFIG}`; do
    config_loc="${CONFIG}/${current_config}"
    describe_txt_loc="${config_loc}/describe.txt"

    if [[ "${arg}" = "${current_config}" ]]; then
      found=true
      if [[ ! -e "${describe_txt_loc}" ]]; then
        touch "${describe_txt_loc}"
      else
        figlet "${arg}" | lolcat
        cat "${describe_txt_loc}"
      fi
    fi
  done

  if [[ "${found}" = false ]]; then
    log_error "Couldn't find any config with the name ${arg}"
  fi
done
