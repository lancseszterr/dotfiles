#!/bin/bash

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root or with sudo"
    exit 1
fi

set -eEo pipefail

export DIR=$(pwd)
export INSTALL_SCRIPTS_DIR=$DIR/install-scripts


echo "Copying etc to /etc"
sudo cp -rf $DIR/etc /etc
sudo chown root:root /etc/ly/config.ini
sudo chown root:root /etc/default/limine

echo "Copying boot to /boot"
sudo cp -rf $DIR/boot /boot
sudo chown root:root /boot/limine.conf


source "$INSTALL_SCRIPTS_DIR/limine.sh"
source "$INSTALL_SCRIPTS_DIR/pacman.sh"
source "$INSTALL_SCRIPTS_DIR/cachyos-repo.sh"
source "$INSTALL_SCRIPTS_DIR/packages.sh"
source "$INSTALL_SCRIPTS_DIR/mime-types.sh"
source "$INSTALL_SCRIPTS_DIR/package-config.sh"


echo "Copying config files to ~/.config"
cp -rf $DIR/.config ~/.config

echo "Copying scripts files to ~/.scripts"
cp -rf $DIR/.scripts ~/.scripts
