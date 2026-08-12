#! /usr/bin/env -S bash

set -eu

echo ""
echo "* Build Image *"

source set-host-envars
mkdir --parents $HOME/Logfiles

echo "..Starting build - logfile is $HOME/Logfiles/build-image.log"
podman image build \
  --file Containerfile \
  --format docker \
  --squash-all \
  --tag $IMAGE_NAME \
  . \
  > $HOME/Logfiles/build-image.log 2>&1

echo ""
podman image list

echo "* Finished Build Image *"
echo ""
