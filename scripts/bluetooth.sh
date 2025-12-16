#! /usr/bin/env bash

bluetui

if [ $? -ne 0 ]; then
  sudo rfkill unblock bluetooth
  bluetui
fi
