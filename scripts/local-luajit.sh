#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/luajit.log

# https://luajit.org/download.html
pushd $HOME/Projects > /dev/null
  echo "..Cloning luajit"
  rm --force --recursive luajit
  git clone --quiet https://luajit.org/git/luajit.git --branch v2.1
  cd luajit
  echo "..Compiling luajit"
  make PREFIX=$HOME/.local \
    > $LOGFILE
  echo "..Installing luajit"
  make install PREFIX=$HOME/.local \
    >> $LOGFILE
  echo "..luajit is installed"
popd > /dev/null
