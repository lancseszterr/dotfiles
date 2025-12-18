#!/bin/bash

sudo systemctl enable ly@tty2.service
sudo systemctl disable getty@tty2.service

sudo ufw default deny incoming
sudo ufw default allow outgoing

# Faster shutdown
sudo mkdir -p /etc/systemd/system.conf.d

cat <<EOF | sudo tee /etc/systemd/system.conf.d/10-faster-shutdown.conf
[Manager]
DefaultTimeoutStopSec=5s
EOF
sudo systemctl daemon-reload

echo "Defaults passwd_tries=5" | sudo tee /etc/sudoers.d/passwd-tries
sudo chmod 440 /etc/sudoers.d/passwd-tries

sudo sed -i 's/^# *deny = .*/deny = 5/' /etc/security/faillock.conf

sudo sed -i 's|^\(auth\s\+required\s\+pam_faillock.so\)\s\+preauth.*$|\1 preauth silent deny=5 unlock_time=120|' "/etc/pam.d/system-auth"
sudo sed -i 's|^\(auth\s\+\[default=die\]\s\+pam_faillock.so\)\s\+authfail.*$|\1 authfail deny=5 unlock_time=120|' "/etc/pam.d/system-auth"

xdg-user-dirs-update

systemctl --user enable pipewire pipewire-pulse wireplumber

touch .config/mimeapps.list
