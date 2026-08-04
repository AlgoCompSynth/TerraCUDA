#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** User Setup **"

mkdir --parents $HOME/Logfiles
mkdir --parents $HOME/Projects
mkdir --parents $HOME/.local/bin
mkdir --parents $HOME/.config/nvim
touch $HOME/.config/nvim/init.lua

export LOGFILE=$HOME/Logfiles/local-setup.log
rm --force $LOGFILE

for script in \
  nerd-fonts.sh \
  starship.sh \
  local-lua.sh \
  local-luajit.sh \
  local-luarocks.sh \
  local-neovim.sh \
  local-terralang.sh \
  local-nodejs.sh

do
  /usr/bin/time ./$script

done

echo "** Finished User Setup **"
echo ""
