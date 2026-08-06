#! /usr/bin/env -S bash -l

set -eu

echo "..Activating Homebrew PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/terralang.log
rm --force $LOGFILE

echo "..Checking architecture"
export ARCH="$(uname --machine)"
echo "ARCH: $ARCH"
if [[ "$ARCH" != "aarch64" && "$ARCH" != "x86_64" ]]
then
  echo "Unsupported architecture!"
  exit -255

fi

echo "..Checking RAM"
export RAM_KB="$(grep MemTotal: /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')"
echo "RAM_KB: $RAM_KB"
if [[ "$RAM_KB" -lt "3750000" ]]
then
  export MAKE_JOBS=1

else
  export MAKE_JOBS="$(nproc)"

fi

echo "MAKE_JOBS: $MAKE_JOBS"

# https://github.com/terralang/llvm-build
export LLVM_VERSION=22.1.8
export TARBALL=clang+llvm-$LLVM_VERSION-$ARCH-linux-gnu.tar.xz
export TARBALL_URL=https://github.com/terralang/llvm-build/releases/download/llvm-$LLVM_VERSION/$TARBALL
echo "..Installing clang-llvm tarball"
curl -sL \
  $TARBALL_URL \
  | tar xJf - --directory=$HOME/.local --strip-components=1
echo "..clang-llvm  installed"

# https://github.com/terralang/terra#building-terra-with-cmake-linux-macos-freebsd
pushd $HOME/Projects > /dev/null
  echo "..Cloning terra"
  rm --force --recursive terra
  git clone --quiet https://github.com/terralang/terra.git
  cd terra/build

  echo "..Configuring terra"
  cmake -Wno-dev -Wno-author -DCMAKE_INSTALL_PREFIX=$HOME/.local .. \
    >> $LOGFILE

  echo "..Installing terra"
  /usr/bin/time make install -j$MAKE_JOBS \
    >> $LOGFILE 2>&1

  echo "..Testing terra"
  cd ../tests
  terra run \
    >> $LOGFILE 2>&1 || true

popd > /dev/null

echo "..terra is installed"
