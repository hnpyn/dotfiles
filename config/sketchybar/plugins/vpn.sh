#!/usr/bin/env sh

source "$HOME/.config/sketchybar/icons.sh"

PROXY_STATUS=$(scutil --proxy)

if echo "$PROXY_STATUS" | grep -q "HTTPEnable : 1"; then
	ICON="$ICON_VPN"
else
	ICON=
fi

sketchybar --set "$NAME" icon="$ICON"
