# Apple Logo
sketchybar -m \
	--add item apple.logo left \
	--set apple.logo icon=$ICON_APPLE \
	icon.font="$FONT:Heavy:16.0" \
	label.drawing=off \
	icon.padding_right=10 \
	click_script='osascript -e "tell application \"System Settings\" to activate"'
