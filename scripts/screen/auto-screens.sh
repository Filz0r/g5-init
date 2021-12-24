#!/usr/bin/env bash
set -euo pipefail

# Simple script that automates the screen layouts whenever I restart/reload i3
# this way I can just unplug my monitors from my laptop and reload i3 whenever
# I want to use my computer outside of the desk.

CONNECTIONS=$(xrandr | grep " connected " | awk '{ print $1}' | wc -l)

if [[ $CONNECTIONS == 3 ]]; then
    xrandr --output DP-0 --off \
        --output DP-1 --off \
        --output DP-2 --off \
        --output HDMI-0 --mode 1920x1080 --pos 2560x0 --rotate left  \
        --output DP-3 --primary --mode 2560x1080 --refresh 75 --pos 0x595 --rotate normal \
        --output DP-4 --off
elif [[ $CONNECTIONS == 1 ]]; then
    xrandr --output DP-0 --off \
        --output DP-1 --off \
        --output DP-2 --primary --mode 1920x1080 --pos 0x0 --rotate normal \
        --output HDMI-0 --off \
        --output DP-3 --off \
        --output DP-4 --off
fi
