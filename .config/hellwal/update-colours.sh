#!/bin/bash

hellwal --theme-folder ~/.config/hellwal/themes/ --random
source ~/.cache/hellwal/env.sh
mv ~/.cache/hellwal/rofi.rasi ~/.config/rofi/config.rasi
$HOME/.config/polybar/launch.sh
