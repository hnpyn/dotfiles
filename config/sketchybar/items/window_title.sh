#!/usr/bin/env sh

sketchybar --add item space_separator left \
	--set space_separator icon="" \
	label.drawing=off \
	background.padding_right=0 \
	\
	--add item window_title left \
	--set window_title script="$PLUGIN_DIR/window_title.sh" \
	icon.drawing=off \
	label.font="$FONT:Semibold:15.0" \
	label.padding_left=0 \
	--subscribe window_title front_app_switched
