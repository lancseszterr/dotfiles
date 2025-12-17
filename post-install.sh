#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root or with sudo"
    exit 1
fi


export DIR=$(pwd)
export INSTALL_SCRIPTS_DIR=$DIR/install-scripts


echo "Copying etc to /etc"
sudo cp -r $DIR/etc /etc

echo "Copying boot to /boot"
sudo cp -r $DIR/boot /boot

source "$INSTALL_SCRIPTS_DIR/limine.sh"
source "$INSTALL_SCRIPTS_DIR/pacman.sh"
source "$INSTALL_SCRIPTS_DIR/cachyos-repo.sh"
source "$INSTALL_SCRIPTS_DIR/packages.sh"
source "$INSTALL_SCRIPTS_DIR/mime-types.sh"
source "$INSTALL_SCRIPTS_DIR/package-config.sh"

echo "Copying config files to ~/.config"
cp -r $DIR/.config ~/.config

echo "Copying scripts files to ~/.scripts"
cp -r $DIR/.scripts ~/.scripts
