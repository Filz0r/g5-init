#!/usr/bin/env bash

# THIS SCRIPT IS NOT POSIX COMPLIANT!
# it uses bash text replacement to filter out the active sink from the other available sinks
# Please do notice that this script was written to work with only 2 available sinks, one being
# $builtin and the other is the $external that is filtered from line 22 to line 26
# you need to find the name of your built in audio sink and change the value of $builtin
# in order for the script to work properly

# These first two variables should not be changed as they are the direct ouputs
# of the pactl command, they just get cleaned up by grep and cut in order to
# become simple strings that can be used.
sinks=$(pactl list sinks | grep "Name" | cut -d" " -f2)
current=$(pactl info | grep "Default Sink: " | cut -d" " -f3)

# However you need to find out the name of your built in audio sink, this one
# has not changed on me after reboots but my external sink name has changed
# between boots, this is why I wrote this script.
builtin="alsa_output.pci-0000_00_1f.3.analog-stereo"

# filters the audio sinks looking for the one that can change names and position
temp=${sinks%"$builtin"}
if [ "$temp" = "$sinks" ]; then
   temp=${sinks#"$builtin"}
fi

external=$(echo "$temp" | sed '/^$/d')

# swaps the default sinks
if [ "$current" = "$builtin" ]; then
    pactl set-default-sink "$external"
else
    pactl set-default-sink "$builtin"
fi

# Updates volume in bar
polybar-msg hook volume 1
