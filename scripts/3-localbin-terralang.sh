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

echo "..Checking GPU"
if [[ "$ARCH" == "x86_64" \
  && "$(which nvidia-smi 2> /dev/null | wc -l)" > "0" \
  && "$(nvidia-smi --list-gpus 2> /dev/null | wc -l)" > "0" ]]

then
  export COMPUTE_MODE="CUDA"

else
  export COMPUTE_MODE="CPU"

fi

echo "COMPUTE_MODE: $COMPUTE_MODE"

echo "..Checking RAM"
export RAM_KB="$(grep MemTotal: /proc/meminfo | sed 's/MemTotal:  *//' | sed 's/ .*$//')"
echo "RAM_KB: $RAM_KB"
if [[ "$RAM_KB" -lt "3000000" ]]
then
  export MAKE_JOBS=1

else
  export MAKE_JOBS="$(nproc)"

fi

echo "MAKE_JOBS: $MAKE_JOBS"

# https://github.com/terralang/llvm-build
export LLVM_VERSION=22.1.8
export LLVM_TARBALL=clang+llvm-$LLVM_VERSION-$ARCH-linux-gnu.tar.xz
export LLVM_URL=https://github.com/terralang/llvm-build/releases/download/llvm-$LLVM_VERSION/$LLVM_TARBALL
echo "..Installing clang-llvm tarball"
/usr/bin/time curl -sL \
  $LLVM_URL \
  | tar xJf - --directory=$HOME/.local --strip-components=1
echo "..clang-llvm  installed"

# https://github/terralang/terra
if [[ "$MAKE_JOBS" == "1" ]]

then
  echo "..Insufficient RAM - installing pre-compiled Terra binaries"
  export TERRA_RELEASE=1.2.1
  export TERRA_COMMIT=8a0c0f0
  export TERRA_TARBALL=terra-Linux-$ARCH-$TERRA_COMMIT.tar.xz
  export TERRA_URL=https://github.com/terralang/terra/releases/download/release-$TERRA_RELEASE/$TERRA_TARBALL
  /usr/bin/time curl -sL \
    $TERRA_URL \
    | tar xJf - --directory=$HOME/.local --strip-components=1
  echo "..terra installed"

  pushd $HOME/.local/share/terra/tests/ > /dev/null
    echo "..Testing terra"

    if [[ "$COMPUTE_MODE" == "CPU" ]]
    then
      echo "..CPU mode - removing 'cuda*.t'"
      rm --force cuda*.t

    fi

    if [[ "$MAKE_JOBS" == "1" ]]
    then
      echo "..Insufficient RAM - removing 'cconv_fuzz.t'"
      rm --force cconv_fuzz.t

    fi

    /usr/bin/time terra run \
      >> $LOGFILE 2>&1 || true
    echo "..terra tests complete"

  popd

  echo "..Exiting with success"
  exit 0

fi

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
  /usr/bin/time terra run \
    >> $LOGFILE 2>&1 || true

popd > /dev/null

echo "..terra tests complete"
