#!/usr/bin/bash

source bin/common
source bin/variables

log_info "--all                       Do everything"
log_info "--describe                  Describe an aspect"
log_info "--git                       Update this repo"
log_info "--packages                  Install needed pacman packages"
log_info "--python                    Install needed python libraries"
log_info "--fonts                     Install my system fonts"
log_info "--npm                       Install needed npm packages"
log_info "--themes                    Install my system themes"
log_info "--aspects                   List all aspects"
log_info "--all-aspects               Install only my aspects"
log_info "--not                       Install everything but a specified aspect"
