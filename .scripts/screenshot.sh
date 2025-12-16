#!/usr/bin/env bash

region_flag=false
screen_flag=false

while getopts "rs" opt; do
  case $opt in
  r) region_flag=true ;;
  s) screen_flag=true ;;
  esac
done

if [ "$region_flag" = true ] && [ "$screen_flag" = true ]; then
  exit 1
fi

if [ "$region_flag" = true ]; then
  hyprshot -m region | wl-copy -p
elif [ "$screen_flag" = true ]; then
  hyprshot -m output | wl-copy -p
fi
