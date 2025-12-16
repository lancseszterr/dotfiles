#!/usr/bin/env bash

hyprctl reload

pkill waybar
waybar &

# pkill mako
# mako &
pkill dunst
dunst &

pkill hyprsunset
hyprsunset &
