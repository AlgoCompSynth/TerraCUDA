#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** Populate Container ** "

if [[ "$CONTAINER_ID" =~ "CUDA" ]]

then
  ./install-cuda.sh

fi

echo "..Installing Homebrew"
./1-install-homebrew.sh

echo "..Installing command line utilities"
./2-brew-command-line.sh

echo "..Installing LLVM & Terra"
./3-localbin-terralang.sh

echo "** Finished Populate Container ** "
echo ""
