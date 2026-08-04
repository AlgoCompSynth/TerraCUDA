#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/luarocks.log

# https://luarocks.org/download.html
pushd $HOME/Projects > /dev/null
  echo "..Cloning luarocks"
  rm --force --recursive luarocks
  git clone --quiet https://github.com/luarocks/luarocks.git --branch v3.13.0 2> /dev/null
  cd luarocks
  echo "..Configuring luarocks"
  ./configure --prefix=$HOME/.local \
    > $LOGFILE
  echo "..Compiling luarocks"
  make -j$(nproc) \
    >> $LOGFILE
  echo "..Installing luarocks"
  make install \
    >> $LOGFILE
  echo "..luarocks is installed"
popd > /dev/null

echo "..installing bit32 Lua package"
luarocks install bit32 \
  >> $LOGFILE
echo "..bit32 is installed"

echo "..installing luaposix Lua package"
luarocks install luaposix \
  >> $LOGFILE
echo "..luaposix is installed"

echo "..installing readline Lua package"
luarocks install readline \
  >> $LOGFILE
echo "..readline is installed"

echo "..installing fennel"
luarocks install fennel \
  >> $LOGFILE
echo "..fennel is installed"
