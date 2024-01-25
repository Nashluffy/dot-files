#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar


if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar-top.log & disown
  done
else
  polybar top --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar-top.log & disown
fi

