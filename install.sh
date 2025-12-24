#!/bin/bash

# Check to be sure
if [ "$EUID" -eq 0 ]; then
    echo "Please don't run as root or with sudo"
    exit 1
fi

set -eEo pipefail

if [ -d /sys/firmware/efi ]; then
    echo Detected UEFI system
else
    echo Detected BIOS system
    echo BIOS not yet supported, aborting...
    exit 1
fi


export INSTALL_DISK=""

while [[ ! -b "$INSTALL_DISK" ]]; do
    lsblk -o NAME,SIZE,TYPE,MODEL | column -t
    read -p "Choose disk (ex.: /dev/sda): " INSTALL_DISK

    if [[ ! -b "$INSTALL_DISK" ]]; then
        echo "Please enter a valid disk in the format given"
        echo "######################################################################"
        echo ""
    fi
done

read -p "All data on the disk will be wiped, proceed ? (yes/no): " PROCEED_DATA_WIPE
if [ "$PROCEED_DATA_WIPE" -eq "yes" ]; then
    echo "Continuing..."
else
    ehco "Aborting..."
    exit 1
fi

read -p  "A / and a /boot partition will be made, proceed ? (yes/no): " PROCEED_PARTITIONS
if [ "$PROCEED_PARTITIONS" -eq "yes" ]; then
    echo "Continuing..."
else
    ehco "Aborting..."
    exit 1
fi

# Timezone
export TIMEZONE=""

while [ ! -f /usr/share/zoneinfo/$TIMEZONE ]; do
    read -p "Enter a timezone: " TIMEZONE
    if [ ! -f /usr/share/zoneinfo/$TIMEZONE ]; then
        echo "Please choose a valid timezone"
        echo "See all timezones at https://en.wikipedia.org/wiki/List_of_tz_database_time_zones"
        echo "######################################################################"
        echo ""
    fi
done

# User config
# export ROOT_PASS="try"
# export ROOT_PASS_REPEAT="it"

# echo "PASSWORD IS HIDDEN FOR PRIVACY REASONS!!!"

# while [ "$ROOT_PASS" -ne "$ROOT_PASS_REPEAT" ]; do
#     read -s -p "Enter root password: " ROOT_PASS
#     read -s -p "Re-enter root password: " ROOT_PASS_REPEAT
#     if [ "$ROOT_PASS" -ne "$ROOT_PASS_REPEAT" ]; then
#         echo "Passwords don't match, please re-enter them"
#         echo "######################################################################"
#         echo ""
#     fi
# done

# export USER_PASS="try"
# export USER_PASS_REPEAT="it"

read -p "Enter a username: " USERNAME

# while [ "$USER_PASS" -ne "$USER_PASS_REPEAT" ]; do
#     read -s -p "Enter user password: " USER_PASS
#     read -s -p "Re-enter user password: " USER_PASS_REPEAT
#     if [ "$USER_PASS" -ne "$USER_PASS_REPEAT" ]; then
#         echo "Passwords don't match, please re-enter them"
#         echo "######################################################################"
#         echo ""
#     fi
# done

# Create partitions
parted -s $INSTALL_DISK mklabel gpt
parted -s $INSTALL_DISK mkpart "EFI" fat32 1MiB 1GiB
parted -s $INSTALL_DISK set 1 esp on
parted -s $INSTALL_DISK mkpart "root" ext4 1GiB 100%

# Format partiions
mkfs.fat -F 32 "${INSTALL_DISK}1"
mkfs.ext4 "${INSTALL_DISK}2"

mount "${INSTALL_DISK}2" /mnt
mkdir /mnt/boot
mount "${INSTALL_DISK}1" /mnt/boot

pacstrap -K /mnt base linux linux-firmware sudo
genfstab -U /mnt >> /mnt/etc/fstab

if [ ! -f "$(pwd)/install-scripts" && ! -f "$(pwd)/.config" && ! -f "$(pwd)/.scripts" && ! -f "$(pwd)/boot" && ! -f "$(pwd)/etc" && ! -f "$(pwd)/home" ]; then
    echo "Couldn't find necessary files for installation, aborting..."
    exit 2
fi

cp -r "$(pwd)/" "/mnt/root/scripts/installation/"

arch-chroot "/mnt" /root/scripts/installation/create-user.sh $USERNAME
arch-chroot "/mnt" /root/scripts/installation/post-install.sh $USERNAME
