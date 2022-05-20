#!/usr/bin/bash

source bin/common
source bin/variables

if [[ $# == 0 ]]; then
  log_error "Need argument."
  log_error "Run ./install --aspects to see what you can describe"
fi

for arg in $@ ; do
  for aspect in `ls ${ASPECTS}`; do
    if [[ ${arg} == ${aspect} ]]; then
      if [[ ! -e ${ASPECTS}/${aspect}/describe.txt ]]; then
        touch ${ASPECTS}/${aspect}/describe.txt
      fi

      if [[ `cat ${ASPECTS}/${aspect}/describe.txt | wc -l` == 0 ]]; then
        log_error "${aspect} has no description"
      elif [[ `cat ${ASPECTS}/${aspect}/describe.txt | wc -l` > 0 ]]; then
        figlet "${arg}" | lolcat
        cat ${ASPECTS}/${aspect}/describe.txt
      fi
    fi
  done
done

