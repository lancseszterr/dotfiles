#!/bin/bash


sudo ./pacman.sh
if [ $? -ne 0 ]; then
    echo "Failed to change pacman config"
fi

sudo ./cachyos-repo.sh
if [ $? -ne 0 ]; then
    echo "Failed to add Cachyos repositories"
    echo "Exiting ..."
    exit 2
fi

sudo ./packages.sh
if [ $? -ne 0 ]; then
    echo "Failed to install some packages"
    echo "Exiting ..."
fi

./mime-types.sh
if [ $? -ne 0 ]; then
    echo "Failed to set some mime-types"
fi

./package-config.sh
if [ $? -ne 0 ]; then
    echo "Failed configure some packages"
fi

echo "Copying config files to ~/.config"
cp -r ../.config ~/.config

echo "Copying scripts files to ~/.scripts"
cp -r ../.scripts ~/.scripts
