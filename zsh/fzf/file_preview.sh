#! /usr/bin/env sh

mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
    lsd -l --no-user --icon=auto "$1" 2>/dev/null 
elif [ "$category" = text ]; then
    (bat -p --style numbers --color=always "$1" ) 2>/dev/null | head -1000
elif [ "$mime" = application/pdf ]; then 
  pdftotext $1 - | less 
elif [ "$category" = image ]; then 
  (~/.zsh/fzf/img_preview $1) 2>/dev/null 
else 
    echo $1 is a $category file
fi
