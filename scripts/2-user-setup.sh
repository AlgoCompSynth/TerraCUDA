#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** User Setup **"

mkdir --parents $HOME/Logfiles
mkdir --parents $HOME/Projects
mkdir --parents $HOME/.local/bin

export LOGFILE=$HOME/Logfiles/local-setup.log
rm --force $LOGFILE

for script in \
  local-lua-5.1.5.sh \
  local-luajit.sh \
  local-luarocks.sh \
  local-neovim.sh \
  local-terralang.sh \
  local-nodejs.sh \
  nerd-fonts.sh \
  starship.sh

do
  ./$script

done

echo "** Finished User Setup **"
echo ""
