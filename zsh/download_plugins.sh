#!/usr/bin/env bash

ZSH=$(pwd -P)

set -e

echo ''
echo ' Downloading plugins...'
echo ''

rm -rf $ZSH/plugins
mkdir -p $ZSH/plugins

git clone https://github.com/zdharma-continuum/fast-syntax-highlighting $ZSH/plugins

echo ''
echo ' Finished!'
