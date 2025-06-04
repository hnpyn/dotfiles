source "$HOME/.config/sketchybar/colors.sh"

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12" "13" "14" "15")

for i in "${!SPACE_ICONS[@]}"; do
	sid=$(($i + 1))
	sketchybar --add space space.$sid left \
		--set space.$sid associated_space=$sid \
		icon=${SPACE_ICONS[i]} \
		icon.padding_left=0 \
		icon.padding_right=0 \
		icon.align=center \
		icon.width=22 \
		background.padding_left=4 \
		background.padding_right=4 \
		background.color="$SURFACE" \
		background.corner_radius=15 \
		background.height=21 \
		background.drawing=off \
		label.drawing=off \
		script="$PLUGIN_DIR/space.sh" \
		click_script="yabai -m space --focus $sid" \
		icon.font="$FONT:Light:15.0"
done
