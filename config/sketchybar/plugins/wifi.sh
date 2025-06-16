#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

WIFI=$(ipconfig getsummary en0 | awk -F ' SSID : ' '/ SSID : / {print $2}')
HOTSPOT=$(ipconfig getsummary en0 | grep sname | awk '{print $3}')

if [[ $HOTSPOT != "" ]]; then
	ICON="$ICON_HOTSPOT"
	LABEL="$HOTSPOT"
elif [[ $WIFI != "" ]]; then
	ICON="$ICON_WIFI"
	LABEL="$WIFI"
fi

sketchybar --set "$NAME" icon="$ICON"
