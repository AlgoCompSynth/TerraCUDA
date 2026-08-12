FROM docker.io/library/ubuntu:resolute
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@algocompsynth.com>"

ARG DEBIAN_FRONTEND=noninteractive
RUN userdel --remove ubuntu \
  && apt-get update -qq \
  && apt-get full-upgrade -qqy \
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
  && echo "y" | unminimize
