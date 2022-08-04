#!/usr/bin/env sh

asp export nvidia
sed \
  -e '/pkgname=/ s/nvidia/nvidia-zen/' \
  -e '/depends=/ s/linux/linux-zen/' \
  -e '/pkgdesc=/ s/linux/linux-zen/' \
  -e '/kernver=/ s/linux/linux-zen/' \
  -i nvidia/PKGBUILD

chown -R builduser nvidia
