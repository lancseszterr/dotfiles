#!/bin/bash

sudo pacman -Sy

# No fricking idea what is needed for AMD, dont't even know if the above will even work XDDD needs testing T.T

mapfile -t packages < <(grep -v '^#' ".packages" | grep -v '^$')
sudo pacman -S --noconfirm --needed "${packages[@]}"



if lspci | grep VGA | grep Intel; then
    mapfile -t packages_intel < <(grep -v '^#' ".packages-intel" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_intel[@]}"
fi

if lspci | grep VGA | grep Nvidia; then
    mapfile -t packages_nvidia < <(grep -v '^#' ".packages-nvidia" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages_nvidia[@]}"
fi



if lspci | grep Bluetooth; then
    mapfile -t packages-bluetooth < <(grep -v '^#' ".packages-bluetooth" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${bluetooth[@]}"
fi


if lspci | grep VGA | grep Nvidia; then
    mapfile -t packages-wifi < <(grep -v '^#' ".packages-wifi" | grep -v '^$')
    sudo pacman -S --noconfirm --needed "${packages-wifi[@]}"
fi
