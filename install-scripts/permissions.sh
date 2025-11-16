#! /usr/bin/env bash

mkdir $HOME/.ssh
chmod 700 $HOME/.ssh

chmod -R 600 $HOME/.ssh/.

chmod 700 $HOME/Documents

setfacl -d -m u::rwx,g::r,o::- "$HOME"
