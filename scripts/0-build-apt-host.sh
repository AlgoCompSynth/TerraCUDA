#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** Build "apt" Host ** "

echo "Installing host dependencies"
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update -qq
sudo apt-get upgrade -qqy
sudo apt-get install -qqy build-essential git

echo "..Installing Homebrew"
./1-install-homebrew.sh

echo "..Installing command line utilities"
./2-brew-command-line.sh

echo "..Installing LLVM & Terra"
./3-localbin-terralang.sh

echo "** Finished Build "apt" Host ** "
echo ""
