#!/bin/bash

alpha='dd'
background='#282a36'
selection='#44475a'
comment='#6272a4'

yellow='#f1fa8c'
orange='#ffb86c'
red='#ff5555'
magenta='#ff79c6'
blue='#6272a4'
cyan='#8be9fd'
green='50fa7b'

# define blur radius
sigma=30

# create temporary file for screenshot
tmp=$(mktemp -d) || exit
trap 'rm -rf "$tmp"' EXIT

# take screenshot of root window and blur it
if maim --hidecursor "${tmp}/in.png"; then
    if ffmpeg -loglevel 0 -i "${tmp}/in.png" -vf "gblur=sigma=$sigma" "$tmp"/out.png; then
        i3lock_options+=(--image="$tmp"/out.png)
    fi
fi

# setting fully-transparent default bg prevents white flash while i3lock-color renders image
i3lock \
  -c 00000000 \
  --insidever-color=$selection$alpha \
  --insidewrong-color=$selection$alpha \
  --inside-color=$selection$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ringver-color=$green$alpha \
  --ringwrong-color=$red$alpha \
  --ring-color=$blue$alpha \
  --line-uses-ring \
  --keyhl-color=$magenta$alpha \
  --bshl-color=$orange$alpha \
  --separator-color=$selection$alpha \
  --verif-color=$green \
  --wrong-color=$red \
  --modif-color=$red \
  --layout-color=$blue \
  --date-color=$blue \
  --time-color=$blue \
  --screen 1 \
  --clock \
  --indicator \
  --time-str="%H:%M:%S" \
  --date-str="%A %e %B %Y" \
  --verif-text="Checking..." \
  --wrong-text="Wrong pswd" \
  --noinput="No Input" \
  --lock-text="Locking..." \
  --lockfailed="Lock Failed" \
  --radius=120 \
  --ring-width=10 \
  --pass-media-keys \
  --pass-screen-keys \
  --pass-volume-keys \
  $i3lock_options
