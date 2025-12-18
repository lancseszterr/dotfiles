#!/bin/bash

sudo pacman -Sy

# No fricking idea what is needed for AMD, dont't even know if the above will even work XDDD needs testing T.T

mapfile -t packages_base < <(grep -v '^#' "$INSTALL_SCRIPTS_DIR/.packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages_base[@]}"



if lspci | grep VGA | grep Intel; then
    mapfile -t packages_intel < <(grep -v '^#' "$INSTALL_SCRIPTS_DIR/.packages-intel" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_intel[@]}"
fi

if lspci | grep VGA | grep Nvidia; then
    mapfile -t packages_nvidia < <(grep -v '^#' "$INSTALL_SCRIPTS_DIR/.packages-nvidia" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_nvidia[@]}"
fi



if ls /sys/class/bluetooth/ > /dev/null 2>&1; then
    mapfile -t packages_bluetooth < <(grep -v '^#' "$INSTALL_SCRIPTS_DIR/.packages-bluetooth" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_bluetooth[@]}"
fi


if cat /proc/net/wireless > /dev/null 2>&1; then
    mapfile -t packages_wifi < <(grep -v '^#' "$INSTALL_SCRIPTS_DIR/.packages-wifi" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_wifi[@]}"
fi
