#!/usr/bin/env sh

source $HOME/.config/sketchybar/icons.sh

if [[ $(defaults read -g AppleInterfaceStyle 2>/dev/null) == "Dark" ]]; then
	sketchybar -m --set appearance icon="$ICON_DARK_MODE_OFF"
else
	sketchybar -m --set appearance icon="$ICON_DARK_MODE_ON"
fi
