#!/usr/bin/env sh

asp export nvidia

NVIDIA_PKGREL=$(egrep -o '^pkgrel=.*' nvidia/PKGBUILD | cut -c8-)
ZEN_PKGREL=$(pacman -Ss linux-zen-headers | cut -d' ' -f2 | cut -d'-' -f2)

sed \
  -e '/pkgname=/ s/nvidia/nvidia-zen/' \
  -e '/depends=/ s/linux/linux-zen/' \
  -e '/pkgdesc=/ s/linux/linux-zen/' \
  -e '/kernver=/ s/linux/linux-zen/' \
  -e "/pkgrel=/ s/$NVIDIA_PKGREL/$(($NVIDIA_PKGREL + $ZEN_PKGREL))/" \
  -i nvidia/PKGBUILD
