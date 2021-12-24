#!/usr/bin/env bash
set -euo pipefail

systemctl --user stop spotify-listener
sleep 5;
systemctl --user start spotify-listener
