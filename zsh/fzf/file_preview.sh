#! /usr/bin/env sh
mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
if [ -d "$1" ]; then
  ls -A "$1" 2>/dev/null 
elif [ "$category" = text ]; then
  cat "$1" 2>/dev/null | head -1000
elif [ "$category" = image ]; then
  exec sh "${0%/*}/img_preview.sh" "$1"
else 
  echo $1 is a $category file
fi
