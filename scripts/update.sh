#!/usr/bin/env bash

check_pacman_state() {
  # Check for database lock
  if [ -f /var/lib/pacman/db.lck ]; then
    echo "Pacman database is locked!"
    read -p "Remove lock file? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      sudo rm -f /var/lib/pacman/db.lck
      echo "Lock file removed"
    fi
  fi
}

pacman_update() {
  echo "Updating pacman packages..."

  sudo pacman -Syu
  if [ $? -eq 0 ]; then
    echo "Update completed successfully!"
  else
    echo "Update failed or was interrupted!"
    check_pacman_state
    exit 1
  fi
}

flatpak_update() {
  echo "Updating flatpaks..."

  flatpak update
  if [ $? -eq 0 ]; then
    echo "Update completed successfully!"
  else
    echo "Update failed or was interrupted!"
    exit 1
  fi
}

cleanup() {
  echo -e "\n\nInterrupt received! Cleaning up..."
  echo "Note: Partial package installation might need manual cleanup"
  echo "Run 'sudo pacman -Syu' to complete any partial updates"
  exit 1
}

finish() {
  for i in {5..1}; do
    if [ $i -gt 1 ]; then
      printf "\rExiting in %d seconds" $i
      sleep 1
    else
      printf "\rExiting in %d second " $i
      sleep 1
    fi
  done

  echo -e "\033[2K"
  echo "Bye bye"

  exit
}

trap cleanup INT TERM

pacman_update
clear
flatpak_update

finish
