#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/terralang.log

echo "..Listing installed dependencies"
dpkg-query --list | egrep -i 'CUDA|nvidia|llvm|clang' || true \
  > $LOGFILE

# https://github.com/terralang/terra#building-terra-with-cmake-linux-macos-freebsd
pushd $HOME/Projects > /dev/null
  echo "..Cloning terra"
  rm --force --recursive terra
  git clone --quiet https://github.com/terralang/terra.git
  cd terra/build

  echo "..Configuring terra"
  cmake -Wno-dev -DCMAKE_INSTALL_PREFIX=$HOME/.local .. \
    >> $LOGFILE

  echo "..Installing terra"
  make install -j$(nproc) \
    >> $LOGFILE 2>&1

  echo "..Testing terra"
  cd ../tests
  terra run \
    >> $LOGFILE 2>&1 || true

popd > /dev/null

echo "..terra is installed"
