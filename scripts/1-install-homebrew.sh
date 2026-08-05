#! /usr/bin/env -S bash -l

set -eu

echo "..Installing Homebrew"
/bin/bash -c \
  "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "..Adding Homebrew to the command line"
echo "" >> $HOME/.bashrc
echo \
  'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"' \
  >> $HOME/.bashrc

echo "..Homebrew setup is complete"
