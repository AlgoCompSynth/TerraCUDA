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
  clang-21 \
  clang-21-doc \
  cmake \
  git \
  libclang-21-dev \
  libcrypt-dev \
  libllvmspirvlib-21-dev \
  libomp-21-dev \
  libomp-21-doc \
  libpolly-21-dev \
  libreadline-dev \
  llvm-21-dev \
  llvm-21-doc \
  openssh-client \
  plocate \
  python3-pynvim \
  ripgrep \
  ruby-neovim \
  unzip \
  vim-nox \
  wl-clipboard \
  >> $LOGFILE
echo "..Update locate database"
sudo updatedb \
  >> $LOGFILE
echo "..Update apt-file database"
sudo apt-file update \
  >> $LOGFILE

echo "** Finished System Setup **"
