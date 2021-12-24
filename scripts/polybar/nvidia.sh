#!/usr/bin/env bash




if [ "$1" = "load" ]; then
    nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits | awk -F ", " '{print $1"%"}'
elif [ "$1" = "notif" ]; then
    message=$(nvidia-smi --query-gpu=temperature.gpu,memory.used,utilization.gpu --format=csv,noheader,nounits | awk -F ", " '{print "Temp:", ""$1"","C | Mem:", ""$2"", "MiB | Load:", ""$3"", "%"}')
    notify-send --icon=video-display Info "$message"
fi
