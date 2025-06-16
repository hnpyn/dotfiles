#!/usr/bin/env sh

export CURRENT_WIFI="$(ipconfig getsummary en0)"
export SSID="$(echo "$CURRENT_WIFI" | grep -o "SSID : .*" | sed 's/^SSID: //' | tail -n 1)"

sketchybar --set $NAME label="󰜷 KB/s 󰜮 KB/s"
