#!/usr/bin/bash

source bin/common
source bin/variables

check_if_installed "npm"

for npm_package in `cat ${INSTALL_SCRIPTS}/npm-packages.txt`; do
  sudo npm i -g ${npm_package}
done
