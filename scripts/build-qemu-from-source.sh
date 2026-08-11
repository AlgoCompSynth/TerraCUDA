#! /usr/bin/env -S bash -l

set -eu

export QEMU_VERSION=11.0.3
export QEMU_DIRECTORY=qemu
export QEMU_URL=https://gitlab.com/qemu-project/qemu.git/

export DEBIAN_FRONTEND=noninteractive

echo "Installing Linux dependencies"
sudo apt-get update -qq
sudo apt-get full-upgrade -qqy
sudo apt-get install -qqy \
  apt-file \
  bison \
  flex \
  libasound2-dev \
  libglib2.0-dev \
  libpipewire-0.3-dev \
  man-db \
  neovim \
  ninja-build \
  pkgconf \
  plocate \
  python3-sphinx-rtd-theme \
  python3-venv \
  time \
  tree

cd $HOME
rm -fr qemu*

echo "Cloning $QEMU_URL"
git clone --quiet $QEMU_URL --branch v$QEMU_VERSION
cd $QEMU_DIRECTORY

echo "Fetching submodules"
/usr/bin/time git submodule update --init --recursive \
  > ~/submodules.log 2>&1

echo "Configuring QEMU"
/usr/bin/time ./configure \
  --prefix=$HOME/.local \
  --enable-alsa \
  --enable-pipewire \
  --static \
  --disable-system \
  --enable-linux-user \
  > ~/configure.log

echo "Installing QEMU"
/usr/bin/time make install -j$(nproc) \
  > ~/make.log

echo "Renaming executables"
pushd $HOME/.local/bin
  for i in *

  do
    mv $i $i-static
    echo $i-static

  done

popd
