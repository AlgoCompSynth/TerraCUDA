#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/localbin-terralang.log
rm --force $LOGFILE

echo "....Activating Homebrew PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

mkdir --parents $HOME/.local/bin

echo "....Installing brew packages"
brew install --yes --quiet \
  cmake \
  lld \
  llvm \
  spirv-cross \
  spirv-headers \
  spirv-llvm-translator \
  spirv-tools \
  >> $LOGFILE 2>&1

echo "....Cleaning up"
brew cleanup --prune all --scrub --quiet \
  >> $LOGFILE 2>&1

pushd $HOME/Projects > /dev/null
  echo "....Cloning terra"
  rm --force --recursive terra
  git clone --quiet https://github.com/terralang/terra.git --branch release-1.2.2
  cd terra/build

  echo "....Configuring terra"
  cmake -Wno-dev -Wno-author -DCMAKE_INSTALL_PREFIX=$HOME/.local .. \
    >> $LOGFILE 2>&1

  echo "....Installing terra"
  /usr/bin/time make install -j$(nproc) \
    >> $LOGFILE 2>&1
  echo "....terra installed"

  echo "....Testing terra"
  cd ../tests
  /usr/bin/time terra run \
    >> $LOGFILE 2>&1 || true
  echo "....terra tests complete"
  tail -n 10 $LOGFILE

popd > /dev/null
