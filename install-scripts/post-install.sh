#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit 1
fi

./pacman.sh
if [ $? -ne 0 ]; then
    echo "Failed to change pacman config"
fi

./cachyos-repo.sh
if [ $? -ne 0 ]; then
    echo "Failed to add Cachyos repositories"
    echo "Exiting ..."
    exit 2
fi

./packages.sh
if [ $? -ne 0 ]; then
    echo "Failed to install some packages"
    echo "Exiting ..."
fi

./mime-types.sh
if [ $? -ne 0 ]; then
    echo "Failed to set mime-types"
fi

echo "Copying config files to ~/.config"
cp -r ../.config ~/.config

echo "Copying scripts files to ~/.scripts"
cp -r ../.scripts ~/.scripts
