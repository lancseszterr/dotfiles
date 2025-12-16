#! /usr/bin/env bash

# Replace #Color with Color
sudo sed -i 's/^#Color/Color/' /etc/pacman.conf

# Add ILoveCandy after Color if not already in
sudo grep -q "ILoveCandy" /etc/pacman.conf || sudo sed -i '/^Color/a ILoveCandy' /etc/pacman.conf

# Delete ParallelDownloads
sudo sed -i '/^ParallelDownloads/d' /etc/pacman.conf

# Add ParallelDownloads
sudo sed -i '/^Color/a ParallelDownloads = 7' /etc/pacman.conf
