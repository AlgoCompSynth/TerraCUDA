#! /usr/bin/env -S bash -l

set -eu

mkdir --parents $HOME/Logfiles
export LOGFILE=$HOME/Logfiles/llama-cpp.log
rm --force $LOGFILE

mkdir --parents $HOME/.local/bin

# https://github.com/ggml-org/llama.cpp/blob/master/docs/build.md
export LLAMA_CPP_VERSION=b10448
export LLAMA_CPP_REPO=https://github.com/ggml-org/llama.cpp
export CUDACXX=/usr/local/cuda-13.3/bin/nvcc
mkdir --parents $HOME/Projects
pushd $HOME/Projects > /dev/null
  echo "....Cloning llama.cpp $LLAMA_CPP_VERSION"
  rm --force --recursive llama.cpp
  git clone --quiet --branch $LLAMA_CPP_VERSION $LLAMA_CPP_REPO 2>/dev/null
  cd llama.cpp

  echo "....Configuring llama.cpp"
  cmake -B build -DGGML_CUDA=ON
    >> $LOGFILE 2>&1

  echo "....Compiling llama.cpp"
  /usr/bin/time cmake --build build --config Release -j$(nproc) \
  /usr/bin/time make install -j$(nproc) \
  echo "....Installing llama.cpp"
  sudo cmake --install build
  echo "....llama.cpp installed"

popd > /dev/null
