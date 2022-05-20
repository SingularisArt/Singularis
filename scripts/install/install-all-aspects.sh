#!/usr/bin/bash

source bin/common
source bin/variables

for folder in `ls aspects/`; do
  if [[ -d "aspects/${folder}" ]]; then
    "./aspects/${folder}/script"
  fi
done
