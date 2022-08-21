#!/usr/bin/env bash

if [[ $(bspc config window_gap) -eq 0 ]]; then
  bspc config window_gap 10
else
  bspc config window_gap 0
fi
