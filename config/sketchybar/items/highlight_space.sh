sketchybar --add item highlight_space left \
	--set highlight_space width=22 \
	background.color=$BLUE \
	background.height=21 \
	background.corner_radius=11 \
	script="$PLUGIN_DIR/highlight_space.sh" \
	--subscribe highlight_space space_change
