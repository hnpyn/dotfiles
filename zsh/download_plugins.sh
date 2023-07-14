#!/usr/bin/env bash

ZSH=$(pwd -P)

set -e

echo ''
echo ' Downloading plugins...'
echo ''

rm -rf $ZSH/plugins
mkdir -p $ZSH/plugins

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH/plugins/fast-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/plugins/zsh-autosuggestions
git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH/plugins/zsh-vi-mode
git clone https://github.com/wting/autojump.git $ZSH/plugins/autojump

cd $ZSH/plugins/autojump
./install.py
cd $ZSH

echo ''
echo ' Finished!'
