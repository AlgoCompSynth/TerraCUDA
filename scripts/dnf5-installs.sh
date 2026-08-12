#! /usr/bin/env -S bash -l

set -eu

echo "..Upgrading"
sudo dnf5 --assumeyes --quiet upgrade
echo "..Installing Terra build dependencies"
sudo dnf5 --assumeyes --quiet install \
  clang-devel \
  cmake \
  gcc \
  gcc-c++ \
  libffi-devel \
  libxml2-devel \
  llvm-bolt \
  llvm-devel \
  make \
  spirv-llvm-translator-devel \
  zlib-ng-compat-devel

echo "..dnf5 installs completed"
