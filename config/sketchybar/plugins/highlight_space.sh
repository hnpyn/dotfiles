#!/usr/bin/env sh

CURRENT_DISPLAY_ID=$(yabai -m query --displays --display | jq '.id')
CURRENT_SPACE_ID=$(yabai -m query --spaces --space | jq '.id')

DISPLAY_SPACES=$(yabai -m query --displays | jq --argjson did "$CURRENT_DISPLAY_ID" \
	'.[] | select(.id == $did) | .spaces')

INDEX_IN_DISPLAY=$(echo "$DISPLAY_SPACES" | jq --argjson sid "$CURRENT_SPACE_ID" 'index($sid)')

ICON_WIDTH=30
PADDING_OFFSET=7

PADDING_LEFT=$((INDEX_IN_DISPLAY * ICON_WIDTH + PADDING_OFFSET))

echo $INDEX_IN_DISPLAY
echo $PADDING_LEFT

sketchybar --animate tanh 20 \
	--set highlight_space background.padding_left=$PADDING_LEFT
