#!/usr/bin/env bash

choice=$(echo -e "Programs\nUpdate\nReload\nClear pacman cache" | rofi -dmenu -p "Select option")

case "$choice" in
"Update")
  hyprctl dispatch exec '[float; size 1280 720]' kitty ~/.scripts/update.sh
  ;;
"Clear pacman cache")
  paccache -r
  ;;
"Programs")
  rofi -show drun
  ;;
"Reload")
  ~/.scripts/reload.sh
  ;;
esac
