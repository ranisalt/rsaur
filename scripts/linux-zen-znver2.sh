#!/usr/bin/env sh

config=(
  --disable LTO_NONE
  --enable LTO
  --enable LTO_CLANG
  --enable ARCH_SUPPORTS_LTO_CLANG
  --enable ARCH_SUPPORTS_LTO_CLANG_THIN
  --enable HAS_LTO_CLANG
  --enable LTO_CLANG_THIN
  --enable HAVE_GCC_PLUGINS
  --disable DEBUG_INFO
  --disable DEBUG_INFO_BTF
  --disable DEBUG_INFO_DWARF4
  --disable PAHOLE_HAS_SPLIT_BTF
  --disable DEBUG_INFO_BTF_MODULES
  --enable MZEN2
)

function join { local IFS=" "; echo "$*"; }

asp export linux-zen

CLEARLINUX_URL='clearlinux::git+https://github.com/clearlinux-pkgs/linux.git#tag=6.1.3-1240'
CLEARLINUX_SHA256='SKIP'

CLEARLINUX_PATCH="for i in \$(grep '^Patch' \$srcdir/clearlinux/linux.spec | grep -Ev '^Patch0132|^Patch0118|^Patch0402|^Patch0113' | sed -n 's/.*: //p'); do echo \"Applying patch \$i...\"; patch -Np1 -i \"\$srcdir/clearlinux/\$i\"; done"

KERNEL_COMPILER_PATCH_URL='https://github.com/graysky2/kernel_compiler_patch/raw/master/more-uarches-for-kernel-5.17%2B.patch'
KERNEL_COMPILER_PATCH_SHA256='81ad663925a0aa5b5332a69bae7227393664bb81ee2e57a283e7f16e9ff75efe'

sed \
  -e "s|^pkgbase=.*|&-znver2|" \
  -e 's|^makedepends=(|&clang llvm lld python |' \
  -e "s|^source=(|&'$KERNEL_COMPILER_PATCH_URL' '$CLEARLINUX_URL' |" \
  -e 's|?signed||' \
  -e "s|^sha256sums=(|&'$KERNEL_COMPILER_PATCH_SHA256' '$CLEARLINUX_SHA256' |" \
  -e "/local src$/ i\\$CLEARLINUX_PATCH\n" \
  -e "/make olddefconfig/ a\\scripts/config $(join ${config[@]})" \
  -i linux-zen/PKGBUILD
