#!/usr/bin/env sh

cd "$1"
yes | sudo -Eu builduser makepkg -crs --noconfirm
