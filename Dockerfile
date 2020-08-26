FROM ubuntu:16.04

ARG ANDROID_TAG=android-10.0.0_r2

# defaults
ENV DOCKER_GID 1000
ENV DOCKER_UID 1000

# this file defines the specific UI an GID as used in docker host PC
# needed for jenkins plugin
ADD docker_uids.def .

RUN . /docker_uids.def && \ 
    echo "Using UID=$DOCKER_UID GID=$DOCKER_GID" && \
    groupadd -f -g $DOCKER_GID buildgroup && \
    useradd -u $DOCKER_UID -s /bin/bash -g $DOCKER_GID -d /jenkins jenkins

RUN mkdir /jenkins ; chown jenkins:buildgroup /jenkins

# prepare environment
ENV HOMEDIR=/home/jenkins
ENV ANDROID_BUILD_TOP=$HOMEDIR/$ANDROID_TAG

RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --allow-unauthenticated \
                       wget \
                       openjdk-8-jdk \
                       git \
                       sed \
                       build-essential \
                       curl \
                       unzip \
                       zip \
                       m4 \
                       libc6:i386 \
                       libncurses5:i386 \
                       libstdc++6:i386 \
                       libxml2-utils \
                       python3 \
                       python3-numpy \
                       python-dev \
                       python-protobuf \
                       protobuf-compiler \
                       python-virtualenv \
                       python-pip \
                       mesa-common-dev \
                       libglu1-mesa-dev \
                       cmake \
                       libgtk2.0-dev \
                       pkg-config \
                       libavcodec-dev \
                       libavformat-dev \
                       libswscale-dev \
                       libprotobuf-dev \
                       libleveldb-dev \
                       libsnappy-dev \
                       libopencv-dev \
                       libhdf5-serial-dev \
                       protobuf-compiler \
                       python-numpy \
                       libopenblas-dev \
                       mesa-common-dev \
                       libglu1-mesa-dev \
                       libopenblas-dev \
                       libgflags-dev \
                       libgoogle-glog-dev \
                       liblmdb-dev \
                       libssl-dev \
                       make \
                       bc \
                       sudo \
                       vim \
                       aapt \
                       bison && \
    apt-get install -y --allow-unauthenticated --no-install-recommends libboost-all-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
