#! /usr/bin/env bash

echo "* Re-create Distrobox *"

source set-host-envars

echo "..Force-removing any existing $CONTAINER_NAME and $CONTAINER_HOME"
distrobox rm --force $CONTAINER_NAME
rm --recursive --force $CONTAINER_HOME

echo "..Re-creating $CONTAINER_NAME"
distrobox assemble create \
  --name $CONTAINER_NAME

#echo "..Copying 'populate-container' into $CONTAINER_HOME"
#cp -rp populate-container $CONTAINER_HOME

#echo "..Populating container"
#pushd $CONTAINER_HOME/populate-container/
  #distrobox enter $CONTAINER_NAME -- ./1-system-setup.sh
#popd

mkdir --parents $HOME/.local/bin
export ENTRY_SCRIPT=$HOME/.local/bin/$CONTAINER_NAME
echo "..Creating command line entry script $ENTRY_SCRIPT"
echo \
  "distrobox enter $CONTAINER_NAME" \
  > $ENTRY_SCRIPT

chmod +x $ENTRY_SCRIPT

echo "* Finished Re-create Distrobox *"
echo ""
