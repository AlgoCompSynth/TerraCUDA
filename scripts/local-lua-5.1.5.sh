#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/lua-5.1.5.log

pushd $HOME/Projects > /dev/null
  echo "..Downloading lua-5.1.5 tarball"
  rm --force --recursive lua-5.1.5*
  wget --quiet https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar xf lua-5.1.5.tar.gz
  cd lua-5.1.5
  echo "..Compiling lua-5.1.5"
  make linux \
    > $LOGFILE
  echo "..Installing lua-5.1.5"
  make install INSTALL_TOP=$HOME/.local \
    >> $LOGFILE
  echo "..lua-5.1.5 is installed"
popd > /dev/null
