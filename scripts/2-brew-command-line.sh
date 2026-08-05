#! /usr/bin/env -S bash -l

set -eu

echo "..Setting up home directory"
mkdir --parents $HOME/.local/bin $HOME/Logfiles $HOME/Projects

echo "..Activating Homebrew PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

echo "..Installing brew packages"
brew install --yes --quiet \
  cmake \
  fennel \
  lua \
  luajit \
  make \
  neovim \
  starship \
  tree

echo "..Setting configuration files"
mkdir --parents $HOME/.config
cp -rp starship.toml nvim $HOME/.config

if [[ "$(grep starship $HOME/.bashrc | wc -l)" == 0 ]]
then
  echo "..Appending starship init to $HOME/.bashrc"
  cat aliases.sh >> $HOME/.bashrc
  echo 'eval "$(starship init bash)"' >> $HOME/.bashrc

fi

if [[ -f $HOME/.zshrc && "$(grep starship $HOME/.zshrc | wc -l)" == 0 ]]
then
  echo "..Appending starship init to $HOME/.zshrc"
  cat aliases.sh >> $HOME/.zshrc
  echo 'eval "$(starship init zsh)"' >> $HOME/.zshrc

fi

echo "..Cleaning up"
brew cleanup --prune all --scrub --quiet
