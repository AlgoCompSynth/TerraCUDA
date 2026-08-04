#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/neovim.log

# https://github.com/terralang/terra#building-terra-with-cmake-linux-macos-freebsd
pushd $HOME/Projects > /dev/null
  echo "..Cloning neovim"
  rm --force --recursive neovim
  git clone --quiet https://github.com/neovim/neovim --branch stable 2> /dev/null
  cd neovim
  echo "..Building neovim"
  make CMAKE_BUILD_TYPE=RelWithDebInfo CMAKE_INSTALL_PREFIX=$HOME/.local \
    > $LOGFILE
  echo "..Installing neovim"
  make install \
    >> $LOGFILE
popd > /dev/null

echo "..Creating empty init.lua"
mkdir --parents $HOME/.config/nvim
touch $HOME/.config/nvim/init.lua

echo "..neovim is installed"
