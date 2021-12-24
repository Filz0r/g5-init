#!/bin/bash
sleep 10
rclone sync --filter-from /home/filipe/.mySettings/filter.txt /home/filipe/drive-settings/ Drive:Manjaro --copy-links --log-level INFO --log-file=/home/filipe/.mySettings/logs/rclone/log-config-$(date "+%Y.%m.%d-%H.%M.%S").log
