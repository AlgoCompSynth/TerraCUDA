FROM docker.io/library/ubuntu:resolute
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@algocompsynth.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN userdel --remove ubuntu 2>/dev/null \
  && apt-get update -qq >/dev/null \
  && apt-get full-upgrade -qqy >/dev/null \
  && apt-get install -qqy --no-install-recommends \
    apt-file \
    build-essential \
    file \
    git \
    libpam-systemd \
    man-db \
    plocate \
    systemd \
    time \
    unminimize \
    >/dev/null \
  && echo "y" | unminimize >/dev/null
