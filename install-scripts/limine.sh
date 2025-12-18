#!/bin/bash

cat <<EOF | sudo tee /etc/default/limine
TARGET_OS_NAME="Arch Linux"
ESP_PATH="/boot"
BOOT_ORDER="*, *fallback, Snapshots"
ENABLE_SORT=no
FIND_BOOTLOADERS=yes
QUIET_MODE=yes
EOF

sudo chown root:root /etc/default/limine
