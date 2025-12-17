#!/bin/bash

export DIR=$(pwd)
export INSTALL_SCRIPTS_DIR=$DIR/install-scripts

source "$INSTALL_SCRIPTS_DIR/pacman.sh"
source "$INSTALL_SCRIPTS_DIR/cachyos-repo.sh"
source "$INSTALL_SCRIPTS_DIR/packages.sh"
source "$INSTALL_SCRIPTS_DIR/mime-types.sh"
source "$INSTALL_SCRIPTS_DIR/package-config.sh"

echo "Copying config files to ~/.config"
cp -r $DIR/.config ~/.config

echo "Copying scripts files to ~/.scripts"
cp -r $DIR/.scripts ~/.scripts

echo "Copying etc to /etc"
sudo cp -r $DIR/etc /etc

echo "Copying boot to /boot"
sudo cp -r $DIR/boot /boot
