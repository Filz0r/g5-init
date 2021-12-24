#!/usr/bin/env bash
set -euo pipefail

#process_check=$(pgrep volumeicon)


if [ -z $(pgrep volumeicon) ]; then
   echo "not running starting it"
    volumeicon &
    exit 1
else
    echo "running"
    kill $process_check
    sleep 1
    volumeicon
    exit 1
fi
