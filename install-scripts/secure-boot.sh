#!/bin/bash

sudo pacman -Sy sbctl

sudo sbctl create-keys
sudo sbctl enroll-keys -m
sudo sbctl status
sudo sbctl verify
