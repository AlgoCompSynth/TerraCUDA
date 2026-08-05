#! /usr/bin/env -S bash -l

set -eu

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
  tree \
  tmux

echo "..Setting configuration files"
mkdir --parents $HOME/.config
cp -rp starship.toml nvim tmux $HOME/.config

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
brew cleanup --prune all --scrub --verbose
