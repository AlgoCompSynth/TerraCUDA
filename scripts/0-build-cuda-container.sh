#! /usr/bin/env -S bash -l

set -eu

echo ""
echo "** Build CUDA Container ** "

echo "..Remove any existing container/home"
set -v
distrobox rm --force TerraCUDA
rm --force --recursive $HOME/TerraCUDA
set +v

echo "..Creating container"
distrobox assemble create

echo "..You need to set a password for $USER to install Homebrew in the container"
distrobox enter TerraCUDA -- sudo passwd $USER

echo "..Installing Homebrew"
distrobox enter TerraCUDA -- ./1-install-homebrew.sh

echo "..Installing command line utilities"
distrobox enter TerraCUDA -- ./2-brew-command-line.sh

echo "..Installing Terra"
distrobox enter TerraCUDA -- ./3-localbin-terralang.sh

echo "** Finished Build CUDA Container ** "
echo ""
