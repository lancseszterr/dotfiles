#!/bin/bash

sudo pacman -Syu limine limine-mkinitcpio-hook

sudo pacman -Sy hyprland hyprsunset hyprlock hyprshot swww wl-clipboard wlogout rofi \
    linux-cachyos-bore-lto linux-cachyos-bore-lto-headers ly

sudo pacman -Sy zed zsh vlc neovim unzip ufw brave dolphin powertop git fzf gimp kvantum \
    qt6ct ristretto ark pipewire-jack \

lspci | grep VGA | grep Intel
if [ $? -e 0 ]; then
    sudo pacman -Sy intel-media-driver intel-gpu-tools vulkan-intel

lspci | grep VGA | grep Nvidia
if [ $? -e 0 ]; then
    sudo pacman -Sy nvidia-dkms nvidia-utils nvtop opencl-nvidia linux-cachyos-bore-lto-nvidia

# No fricking idea what is needed for AMD, dont't even know if the above will even work XDDD needs testing T.T
