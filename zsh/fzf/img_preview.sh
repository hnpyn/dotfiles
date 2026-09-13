#!/bin/sh
# image preview for fzf; keep this a single argv so wrapped pastes still work
file=$1
w=${FZF_PREVIEW_COLUMNS:-80}
h=${FZF_PREVIEW_LINES:-24}
# delete previous kitty/sixel images in this terminal
printf '\033_Ga=d\033\\'
exec chafa --animate=off -s "${w}x${h}" "$file"
