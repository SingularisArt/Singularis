#!/usr/bin/bash

source bin/common
source bin/variables

for aspect in `ls aspects/`; do
  log_info "${aspect}"
done

