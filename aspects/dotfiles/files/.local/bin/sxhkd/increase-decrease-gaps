#!/usr/bin/env bash

if [[ $1 -eq "plus" ]]; then
  current_gap=$(bspc config window_gap)
  new_gap=$((current_gap + 1))
  bspc config window_gap $new_gap
elif [[ $1 -eq "minus" ]]; then
  current_gap=$(bspc config window_gap)
  new_gap=$((current_gap - 1))
  bspc config window_gap $new_gap
fi
