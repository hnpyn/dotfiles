sketchybar --add item wifi right \
	--set wifi script="$PLUGIN_DIR/wifi.sh" \
	click_script='open "x-apple.systempreferences:com.apple.preference.network"' \
	--subscribe wifi wifi_change
