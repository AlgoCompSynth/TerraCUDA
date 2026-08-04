#! /usr/bin/env -S bash -l

set -eu

# https://neovim.io/doc/install/#install-from-download
pushd $HOME/.local > /dev/null
  echo "..Installing neovim"
  curl -sL \
    https://github.com/neovim/neovim/releases/latest/download/nvim-linux-arm64.tar.gz \
    | tar xf - --gzip --strip-components=1

popd > /dev/null

echo "..Creating empty init.lua"
mkdir --parents $HOME/.config/nvim
touch $HOME/.config/nvim/init.lua

echo "..neovim is installed"
