#!/bin/bash

su -l $1

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root or with sudo"
    exit 1
fi

set -eEo pipefail

export DIR=$(pwd)
export INSTALL_SCRIPTS_DIR=$DIR/install-scripts

sudo mkdir -p /etc/{ly,default,initcpio,initcpio/post}
echo "Copying etc to /etc"
sudo cp -r $DIR/etc/* /etc

sudo chown root:root /etc/ly/config.ini
sudo chmod 600 /etc/ly/config.ini

sudo chown root:root /etc/initcpio/post/kernel-sbctl
sudo chmod 700 /etc/initcpio/post/kernel-sbctl


echo "Copying boot to /boot"
sudo cp -r $DIR/boot/* /boot
sudo chown root:root /boot/limine.conf


source "$INSTALL_SCRIPTS_DIR/secure-boot.sh"
source "$INSTALL_SCRIPTS_DIR/limine.sh"
source "$INSTALL_SCRIPTS_DIR/pacman.sh"
source "$INSTALL_SCRIPTS_DIR/cachyos-repo.sh"
source "$INSTALL_SCRIPTS_DIR/packages.sh"
source "$INSTALL_SCRIPTS_DIR/package-config.sh"
source "$INSTALL_SCRIPTS_DIR/mime-types.sh"


mkdir -p .config/{btop,cava,dunst,hypr,kitty,qt6ct,vesktop,waybar,wlogout,zed}
echo "Copying config files to $HOME/.config"
cp -r $DIR/.config/* $HOME/.config

mkdir -p ~/.scripts
echo "Copying scripts files to $HOME/.scripts"
cp -r $DIR/.scripts/* $HOME/.scripts

echo "Copying user specific files to $HOME"
cp -r $DIR/home $HOME
