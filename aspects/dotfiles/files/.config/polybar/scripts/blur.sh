#!/usr/bin/sh

if [[ $1 == "check" ]]; then
  if [[ $(ps aux | grep 'picom' | wc -l) > 1 ]]; then
    pkill -9 picom
    notify-send "Blur Disabled"
  else
    picom -b --experimental-backends --backend glx --blur-method dual_kawase &
    notify-send "Blur Enabled"
  fi
fi

if [[ $(ps aux | grep 'picom' | wc -l) > 1 ]]; then
  echo ""
else
  echo ""
fi
