#! /usr/bin/env -S bash -l

set -eu

# https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Fedora&target_version=44
echo "..Installing CUDA toolkit"
sudo dnf5 --assumeyes --quiet config-manager addrepo --overwrite \
  --from-repofile https://developer.download.nvidia.com/compute/cuda/repos/fedora44/x86_64/cuda-fedora44.repo
sudo dnf5 --quiet clean all
sudo dnf5 --assumeyes --quiet install cuda-toolkit
echo "..CUDA toolkit is installed"
