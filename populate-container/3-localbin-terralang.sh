#! /usr/bin/env -S bash -l

set -eu

echo "..Activating Homebrew PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/terralang.log
rm --force $LOGFILE

pushd $HOME/Projects > /dev/null
  echo "..Cloning terra"
  rm --force --recursive terra
  git clone --quiet https://github.com/terralang/terra.git
  cd terra/build

  echo "..Configuring terra"
  cmake -Wno-dev -Wno-author -DCMAKE_INSTALL_PREFIX=$HOME/.local .. \
    >> $LOGFILE

  echo "..Installing terra"
  /usr/bin/time make install -j$(nproc) \
    >> $LOGFILE 2>&1
  echo "..terra installed"

  echo "..Testing terra"
  cd ../tests
  /usr/bin/time terra run \
    >> $LOGFILE 2>&1 || true
  echo "..terra tests complete"

  echo "..Exporting terra binary"
  distrobox-export --bin $HOME/.local/bin/terra

popd > /dev/null
echo "..successful exit"
