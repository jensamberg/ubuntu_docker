# This Dockerfile creates an Ubuntu 20.04 image

# Pull base image.
FROM ubuntu:20.04

LABEL maintainer="jensamberg@mail.de"

# Setup environment
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Europe/Berlin

RUN dpkg --add-architecture i386 &&\
    apt-get update -y
# Install.
RUN \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential sed mtools python && \
  apt-get install -y curl git htop man unzip vim wget cmake && \
  apt-get install -y mercurial make binutils gcc g++ patch bc file rsync unzip cpio tar && \
  apt-get install -y gcc-multilib g++-multilib libncurses5-dev python3 && \
  apt-get install -y libgl-dev sqlite python3-pip sqlite3 sshpass libasound2-dev mingw-w64 libgl1-mesa-dev && \
  apt-get -y autoremove && \
  apt-get -y clean


# Set the locale
RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8


RUN useradd -ms /bin/bash br-user && \
    chown -R br-user:br-user /home/br-user

USER br-user
WORKDIR /home/br-user
ENV HOME /home/br-user
ENV LC_ALL en_US.UTF-8

# Add Qt 5.12.5 an generate cross compiler for linux
RUN wget http://download.qt.io/archive/qt/5.12/5.12.5/single/qt-everywhere-src-5.12.5.tar.xz
RUN tar xJf qt-everywhere-src-5.12.5.tar.xz
RUN cd qt-everywhere-src-5.12.5 && ./configure -opensource -confirm-license -xplatform linux-g++ -no-compile-examples -prefix /opt/Qt5.12.5/5.12.5/gcc_64
RUN cd qt-everywhere-src-5.12.5 && make
RUN cd qt-everywhere-src-5.12.5 && make install

# Add Qt 5.12.5 an generate cross compiler for for windows
RUN rm -rf qt-everywhere-src-5.12.5
RUN tar xJf qt-everywhere-src-5.12.5.tar.xz
RUN cd qt-everywhere-src-5.12.5 && ./configure -opensource -confirm-license -xplatform win32-g++ -device-option CROSS_COMPILE=/usr/bin/x86_64-w64-mingw32- -prefix /opt/Qt5.12.5/5.12.5/mingw_64 -debug-and-release -no-compile-examples -opengl desktop -skip qtactiveqt -skip qtcharts -skip qtdoc -skip qtlocation -skip qtremoteobjects -skip qtserialbus -skip qtwebchannel -skip qtwebview -skip qtandroidextras -skip qtconnectivity -skip qtgamepad -skip qtmacextras -skip qtpurchasing -skip qtwinextras -skip qtdatavis3d -skip qtmultimedia -skip qtscxml -skip qtspeech -skip qtvirtualkeyboard -skip qtwebglplugin -skip qtx11extras -skip qt3d -skip qtcanvas3d -skip qtnetworkauth -skip qtsensors -skip qtwayland -skip qtwebsockets
RUN cd qt-everywhere-src-5.12.5 && make
RUN cd qt-everywhere-src-5.12.5 && make install
