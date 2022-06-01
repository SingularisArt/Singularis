#!/usr/bin/env bash

source ~/.config/zsh/exports.zsh

cd ~/Documents/notes/school-setup/

if [[ $1 == "end" ]]; then
  ./main.py --calendar --end
else
  python3.10 -u main.py --calendar
fi
