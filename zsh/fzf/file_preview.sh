#! /usr/bin/env sh
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
  lsd -A --icon=always "$1" 2>/dev/null 
elif [ "$category" = text ]; then
  (bat -p --style numbers --color=always "$1" ) 2>/dev/null | head -1000
elif [ "$category" = image ]; then 
  # (~/.zsh/fzf/img_preview $1) 2>/dev/null 
  chafa "$1"
else 
  echo $1 is a $category file
fi
