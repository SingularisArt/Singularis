#!/bin/sh

echo "$(mpc | sed "/^volume:/d;s/\\&/&amp;/g;s/\\[paused\\].*/⏸/g;/\\[playing\\].*/d;/^ERROR/Q" | paste -sd ' ') ($(mpc status | grep '%)' | awk '{ print $3 }'))"
