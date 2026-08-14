#! /usr/bin/env bash

set -eu

echo "* Populate Container *"

source set-host-envars

cp -rp populate-container $CONTAINER_HOME
pushd $CONTAINER_HOME/populate-container > /dev/null

  if [[ "$COMPUTE_MODE" == "CUDA" ]]

  then
    distrobox enter $CONTAINER_NAME -- ./install-cuda.sh

  fi


  echo "..Installing 'resolute' packages"
  distrobox enter $CONTAINER_NAME -- ./0-resolute-packages.sh

  echo "..Installing Homebrew"
  distrobox enter $CONTAINER_NAME -- ./1-install-homebrew.sh

  echo "..Installing command line utilities"
  distrobox enter $CONTAINER_NAME -- ./2-brew-command-line.sh

  echo "..Installing LLVM & Terra"
  distrobox enter $CONTAINER_NAME -- ./3-localbin-terralang.sh

popd > /dev/null

echo ""
podman image list

mkdir --parents $HOME/.local/bin
export ENTRY_SCRIPT=$HOME/.local/bin/$CONTAINER_NAME
echo "..Creating command line entry script $ENTRY_SCRIPT"
echo \
  "distrobox enter $CONTAINER_NAME" \
  > $ENTRY_SCRIPT
chmod +x $ENTRY_SCRIPT

echo "* Finished Populate Container *"
echo ""
