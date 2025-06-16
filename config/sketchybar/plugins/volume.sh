#!/bin/bash

source "$HOME/.config/sketchybar/icons.sh"

if [ "$SENDER" = "volume_change" ]; then
	CURRENT_OUTPUT="$(switchaudiosource -t output -c 2>/dev/null)"
	VOLUME="$INFO"
	case "$VOLUME" in
	[7-9][0-9] | 100)
		if echo "$CURRENT_OUTPUT" | grep -qi "AirPods Pro"; then
			ICON="$ICON_AIRPODSPRO"
		elif echo "$CURRENT_OUTPUT" | grep -qi "MacBook Pro"; then
			ICON="$ICON_VOLUME_100"
		fi
		;;
	[4-6][0-9])
		if echo "$CURRENT_OUTPUT" | grep -qi "AirPods Pro"; then
			ICON="$ICON_AIRPODSPRO"
		elif echo "$CURRENT_OUTPUT" | grep -qi "MacBook Pro"; then
			ICON="$ICON_VOLUME_66"
		fi
		;;
	[2-3][0-9])
		if echo "$CURRENT_OUTPUT" | grep -qi "AirPods Pro"; then
			ICON="$ICON_AIRPODSPRO"
		elif echo "$CURRENT_OUTPUT" | grep -qi "MacBook Pro"; then
			ICON="$ICON_VOLUME_33"
		fi
		;;
	[1-9] | 1[0-9])
		if echo "$CURRENT_OUTPUT" | grep -qi "AirPods Pro"; then
			ICON="$ICON_AIRPODSPRO"
		elif echo "$CURRENT_OUTPUT" | grep -qi "MacBook Pro"; then
			ICON="$ICON_VOLUME_10"
		fi
		;;
	0)
		if echo "$CURRENT_OUTPUT" | grep -qi "AirPods Pro"; then
			ICON="$ICON_AIRPODSPRO"
		else
			ICON="$ICON_VOLUME_0"
		fi
		;;
	*) ICON="$ICON_VOLUME_100" ;;
	esac

	sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%" background.padding_right=8
fi
