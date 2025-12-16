#!/bin/bash

sudo systemctl enable ly@tty2.service
sudo systemctl disable getty@tty2.service
