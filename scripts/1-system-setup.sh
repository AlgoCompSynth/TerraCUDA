#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** System Setup **"

mkdir --parents $HOME/Logfiles

export LOGFILE=$HOME/Logfiles/system-setup.log
rm --force $LOGFILE

export DEBIAN_FRONTEND=noninteractive
echo "..Sync repos"
sudo apt-get update \
  >> $LOGFILE
echo "..Full upgrade"
sudo apt-get full-upgrade -y \
  >> $LOGFILE
echo "..Install packages"
sudo apt-get install -y \
  apt-file \
  build-essential \
  cmake \
  git \
  libcrypt-dev \
  libreadline-dev \
  libzstd-dev \
  neovim \
  openssh-client \
  plocate \
  python3-pynvim \
  snapd \
  time \
  tmux \
  tree \
  ripgrep \
  unzip \
  vim-nox \
  xdg-utils \
  zip \
  >> $LOGFILE

echo "..Install ghostty"
sudo snap install ghostty --classic

echo "..Update locate database"
sudo updatedb \
  >> $LOGFILE
echo "..Update apt-file database"
sudo apt-file update \
  >> $LOGFILE

echo "** Finished System Setup **"
