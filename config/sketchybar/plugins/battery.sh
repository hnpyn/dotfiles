#!/usr/bin/env sh

source $HOME/.config/sketchybar/icons.sh
source $HOME/.config/sketchybar/colors.sh

PERCENTAGE=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')

if [ $PERCENTAGE = "" ]; then
	exit 0
fi

ICON_COLOR=$FORGROUND

case ${PERCENTAGE} in
9[0-9] | 100)
	ICON="$ICON_BATTERY_100"
	;;
[6-8][0-9])
	ICON="$ICON_BATTERY_75"
	;;
[3-5][0-9])
	ICON="$ICON_BATTERY_50"
	;;
[1-2][0-9])
	ICON="$ICON_BATTERY_25"
	;;
*)
	ICON="$ICON_BATTERY_10"
	ICON_COLOR="$RED"
	;;
esac

if [[ $CHARGING != "" ]]; then
	ICON="$ICON_BATTERY_CHARGING"
	ICON_COLOR="$GREEN"
fi

sketchybar --set "$NAME" icon="$ICON" icon.color="$ICON_COLOR" label="${PERCENTAGE}%"
