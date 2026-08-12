#! /usr/bin/env -S bash -l

set -eu

# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu
echo "..Installing CUDA toolkit"
pushd /tmp
  rm --force *.deb
  wget --quiet \
    https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2604/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb >/dev/null
  sudo apt-get update >/dev/null
  sudo apt-get -y install cuda-toolkit-13-3 >/dev/null

popd
echo "..CUDA toolkit is installed"
