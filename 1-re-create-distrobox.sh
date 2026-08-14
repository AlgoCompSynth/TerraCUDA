#! /usr/bin/env bash

set -eu

echo "* Re-create Distrobox *"

source set-host-envars

echo "..Building base image"
podman image build \
  --file Containerfile \
  --format docker \
  --squash-all \
  --tag $IMAGE_NAME \
  .

echo ""
podman image list

echo "..Force-removing any existing $CONTAINER_NAME and $CONTAINER_HOME"
distrobox rm --force $CONTAINER_NAME
rm --recursive --force $CONTAINER_HOME

echo "..Re-creating $CONTAINER_NAME"
distrobox assemble create \
  --name $CONTAINER_NAME

echo "..You need to set a '$USER' password to use 'sudo' in the container"
distrobox enter $CONTAINER_NAME -- sudo passwd $USER

echo ""
podman image list

echo "* Finished Re-create Distrobox *"
echo ""
