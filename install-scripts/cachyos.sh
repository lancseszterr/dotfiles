#! /usr/bin/env bash

cd installed

curl https://mirror.cachyos.org/cachyos-repo.tar.xz -o cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
sudo ./cachyos-repo.sh
cd ..
rm cachyos-repo.tar.xz
rm -rf cachyos-repo

cd ..
