#!/bin/sh
# Outputs the pulse volume level formatted to be shown in polybar
current=$(pactl info | grep "Default Sink: " | cut -d" " -f3)
device=$(~/scripts/pulseaudio/pulsedevices.sh | grep "$current" -A 2)

mute=$(echo "$device" | grep "Mute" | awk '{ print $2 }')
vol=$(echo "$device" | grep "front-left" | awk '{ print $5 }')

if [ "$mute" = "yes" ]; then
  echo "🔇 mute"
elif [ "$(echo "$vol" | tr -d "%")" -gt 60 ]; then
  echo "🔊 $vol"
elif [ "$(echo "$vol" | tr -d "%")" -gt 35 ]; then
  echo "🔉 $vol"
else
  echo "🔈 $vol"
fi
#echo "$vol"
