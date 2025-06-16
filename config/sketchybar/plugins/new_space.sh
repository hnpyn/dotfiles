#!/usr/bin/env sh

yabai -m space --create

INDEX="$(yabai -m query --spaces --display | jq 'map(select(."is-native-fullscreen" == false))[-1].index')"

yabai -m space --focus "$INDEX"
