#!/usr/bin/env sh
#  
# # Terminate already running bar instances
# killall -q polybar
#  
# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#  
# # Launch bar
# polybar main &
#  
# echo "Bar launched"

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config="$XDG_CONFIG_HOME/polybar/config.ini" --reload main &
  done
else
  polybar --config="$XDG_CONFIG_HOME/polybar/config.ini" --reload main &
fi
