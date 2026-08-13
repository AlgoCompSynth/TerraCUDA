# Getting Started on the Raspberry Pi 4 / 5 with PiOS

This may work on smaller Raspberry Pi devices but at the moment
I am only testing with Raspberry Pi 4s and 5s with at least 4 GiB
of RAM running the latest Raspberry Pi OS based on Debian `trixie`.

1. You will need to install `git`, `distrobox` and `podman`:

    sudo apt update && sudo apt full-upgrade # reboot if there were upgrades!
    sudo apt install distrobox git podman

2. Clone the project:

    mkdir --parents $HOME/Projects
    cd $HOME/Projects
    git clone https://github.com/AlgoCompSynth/TerraCUDA

3. Build the container:

    cd $HOME/Projects/TerraCUDA
    ./1-re-create-distrobox.sh

After creating the container, the script will stop and ask you to
create a user password so `sudo` will work in the container. Once
you've done that, the script will continue until completion.
