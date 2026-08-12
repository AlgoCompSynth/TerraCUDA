FROM docker.io/library/fedora:44
LABEL maintainer="M. Edward (Ed) Borasky <znmeb@algocompsynth.com>"

RUN dnf5 --assumeyes --quiet upgrade \
  && dnf5 --assumeyes --quiet install \
  git \
  time
