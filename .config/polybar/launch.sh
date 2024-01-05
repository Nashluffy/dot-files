#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

echo "---" | tee -a /tmp/polybar-top.log
polybar top --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar-top.log & disown
#polybar bottom --config=$HOME/.config/polybar/config.ini 2>&1 | tee -a /tmp/polybar-bottom.log & disown

echo "Launched bar"
