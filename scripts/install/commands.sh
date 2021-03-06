#!/usr/bin/bash

source bin/common
source bin/variables

log_info "--all                 -a        Installs everything"
log_info "--describe param      -d param  Describes the parameter"
log_info "--packages            -p        Installs all the needed packages"
log_info "--python              -y        Installs all the needed python libraries"
log_info "--npm                 -n        Installs all the needed npm libraries"
log_info "--list-configs        -l        List all available con config"
log_info "--install-all-config  -l        Install all configs"
log_info "--not-config          -t        Install everything except what you pass"
log_info "--install             -i        Install whatever you pass"
log_info "--help                -h        Shows this page"
log_info "cmd --help        cmd -h        Get more information on a command"
