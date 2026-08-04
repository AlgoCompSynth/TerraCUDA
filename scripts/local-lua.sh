#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/lua.log

pushd $HOME/Projects > /dev/null
  export LUA_VERSION=5.5.1
  echo "..Downloading lua-$LUA_VERSION tarball"
  rm --force --recursive lua-$LUA_VERSION*
  wget --quiet https://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz
  tar xf lua-$LUA_VERSION.tar.gz
  cd lua-$LUA_VERSION
  echo "..Compiling lua-$LUA_VERSION"
  make linux \
    > $LOGFILE
  echo "..Installing lua-$LUA_VERSION"
  make install INSTALL_TOP=$HOME/.local \
    >> $LOGFILE
  echo "..lua-$LUA_VERSION is installed"
popd > /dev/null
