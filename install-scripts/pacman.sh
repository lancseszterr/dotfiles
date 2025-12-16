#! /usr/bin/env bash

# Replace #Color with Color
sed -i 's/^#Color/Color/' /etc/pacman.conf

# Add ILoveCandy after Color if not already in
grep -q "ILoveCandy" /etc/pacman.conf || sed -i '/^Color/a ILoveCandy' /etc/pacman.conf

# Delete ParallelDownloads
sed -i '/^ParallelDownloads/d' /etc/pacman.conf

# Add ParallelDownloads
sed -i '/^Color/a ParallelDownloads = 7' /etc/pacman.conf
