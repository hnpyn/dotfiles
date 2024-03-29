#!/usr/bin/env bash

ZSH=$(pwd -P)

set -e

echo ''
echo ' Downloading plugins...'
echo ''

rm -rf $ZSH/plugins
mkdir -p $ZSH/plugins

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH/plugins/powerlevel10k
echo ''
git clone https://github.com/Aloxaf/fzf-tab $ZSH/plugins/fzf-tab
echo ''
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH/plugins/fast-syntax-highlighting
echo ''
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH/plugins/zsh-autosuggestions
echo ''
git clone https://github.com/jeffreytse/zsh-vi-mode.git $ZSH/plugins/zsh-vi-mode

echo ''
echo ' Finished!'
