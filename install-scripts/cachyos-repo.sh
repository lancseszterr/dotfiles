#!/bin/bash

# https://wiki.cachyos.org/features/optimized_repos/

curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz
sudo $DIR/cachyos-repo/cachyos-repo.sh
