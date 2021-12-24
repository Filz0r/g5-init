#!/bin/sh
xrandr --output HDMI-0 --off \
    --output DP-0 --off \
    --output DP-1 --off \
    --output eDP-1-1 --mode 1920x1080 --pos 0x0 --rotate normal --refresh 144 \
    --output DP-1-1 --off \
    --output HDMI-1-1 --off \
    --output HDMI-1-2 --off \
    --output DP-1-2 --off \
    --output HDMI-1-3 --off
