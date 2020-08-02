# This Dockerfile creates an Ubuntu 20.04 image to generate al
# Pull base image.
FROM ubuntu:20.04

LABEL maintainer="jensamberg@mail.de"

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Berlin

# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y curl git htop man unzip vim wget cmake && \  
  apt-get install -y mercurial make binutils gcc g++ patch bc file rsync unzip cpio tar && \
  apt-get install -y gcc-multilib g++-multilib libncurses5-dev python3
