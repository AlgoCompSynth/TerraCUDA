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
  byobu \
  clang-22 \
  clang-22-doc \
  cmake \
  cpanminus \
  ghostty \
  git \
  libclang-22-dev \
  libcrypt-dev \
  libllvmspirvlib-22-dev \
  libomp-22-dev \
  libomp-22-doc \
  libpolly-22-dev \
  libreadline-dev \
  libzstd-dev \
  llvm-22-dev \
  llvm-22-doc \
  openssh-client \
  plocate \
  python3-pynvim \
  time \
  tmux \
  tree \
  ripgrep \
  ruby-neovim \
  unzip \
  vim-nox \
  xdg-utils \
  zip \
  >> $LOGFILE

echo "..Update locate database"
sudo updatedb \
  >> $LOGFILE
echo "..Update apt-file database"
sudo apt-file update \
  >> $LOGFILE

echo "** Finished System Setup **"
