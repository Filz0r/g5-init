#!/usr/bin/env bash
# Changes the volume level of an audio track
# Signals an update in polybar for the volume module

current=$(pactl info | grep "Default Sink: " | cut -d" " -f3)

if [ "$1" = "output-vol" ]; then
  pactl set-sink-mute "$current" false
  pactl set-sink-volume "$current" "$2"
  polybar-msg hook volume 1
elif [ "$1" = "output-mute" ]; then
  pactl set-sink-mute "$current" toggle
  polybar-msg hook volume 1
fi

# Updates volume in bar
polybar-msg hook volume 1
