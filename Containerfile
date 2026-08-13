FROM docker.io/library/ubuntu:resolute
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@algocompsynth.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN userdel --remove ubuntu 2>/dev/null \
  && apt-get update -qq >/dev/null \
  && apt-get full-upgrade -qqy >/dev/null \
  && apt-get install -qqy --no-install-recommends \
    apt-file \
    build-essential \
    cmake \
    file \
    git \
    libpam-systemd \
    libzstd-dev \
    man-db \
    plocate \
    systemd \
    time \
    unminimize \
    zlib1g-dev \
    >/dev/null \
  && echo "y" | unminimize >/dev/null
