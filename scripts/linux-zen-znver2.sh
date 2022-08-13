#!/usr/bin/env sh

asp export linux-zen

KERNEL_COMPILER_PATCH_URL='https://github.com/graysky2/kernel_compiler_patch/raw/master/more-uarches-for-kernel-5.17%2B.patch'
KERNEL_COMPILER_PATCH_SHA256='dea86a521603414a8c7bf9cf1f41090d5d6f8035ce31407449e25964befb1e50'

sed \
  -e "s|^source=(|&'$KERNEL_COMPILER_PATCH_URL'\n|" \
  -e "s|^sha256sums=(|&'$KERNEL_COMPILER_PATCH_SHA256'\n|" \
  -e "/make olddefconfig/ a\scripts/config -e CONFIG_MZEN2" \
  -i linux-zen/PKGBUILD
