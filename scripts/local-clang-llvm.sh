#! /usr/bin/env -S bash -l

set -eu

export ARCH="$(uname --machine)"
if [[ "$ARCH" != "aarch64" && "$ARCH" != "x86_64" ]]
then
  echo "Unsupported architecture!"
  exit -255

fi

# https://github.com/terralang/llvm-build
export LLVM_VERSION=22.1.8
export TARBALL=clang+llvm-$LLVM_VERSION-$ARCH-linux-gnu.tar.xz
export TARBALL_URL=https://github.com/terralang/llvm-build/releases/download/llvm-$LLVM_VERSION/$TARBALL
echo "..Installing clang-llvm tarball"
curl -sL \
  $TARBALL_URL \
  | tar xJf - --directory=$HOME/.local --strip-components=1
echo "..clang-llvm  installed"
