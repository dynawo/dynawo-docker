# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM ubuntu:20.04
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ENV DYNAWO_ADEPT_DOWNLOAD_URL=https://github.com/dynawo/dynawo/files/13817152

ARG USER_NAME=dynawo_developer
ARG USER_ID=1000
ARG GROUP_ID=1000
ARG GROUP_NAME=dynawo_developer

ENV TZ=Europe/Paris \
DEBIAN_FRONTEND=noninteractive

RUN apt update \
&& apt upgrade -y -q \
&& apt install -y git \
  gcc \
  g++ \
  gfortran \
  autoconf \
  pkgconf \
  automake \
  make \
  libtool \
  cmake \
  hwloc \
  openjdk-8-jdk \
  libblas-dev \
  liblpsolve55-dev \
  libarchive-dev \
  doxygen \
  doxygen-latex \
  liblapack-dev \
  libexpat1-dev \
  libsqlite3-dev \
  zlib1g-dev \
  gettext \
  patch \
  clang \
  python3-pip \
  libncurses5-dev \
  libreadline-dev \
  libdigest-perl-md5-perl \
  unzip \
  gcovr \
  lcov \
  libboost-all-dev \
  qt5-default \
  lsb-release \
  libxml2-utils \
  python-lxml \
  python-psutil \
  wget \
  libcurl4-openssl-dev \
  rsync \
  libopenblas-openmp-dev \
  curl \
  sudo \
  vim \
  ninja-build \
  gdb \
  gdbserver \
  libsecret-1-0 \
  bash-completion \
  lynx \
  libgoogle-perftools4 \
&& apt -y remove libopenmpi3 \
&& apt -y install mpich \
&& apt clean \
&& rm -rf /var/lib/apt/lists/*

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN groupadd -f ${GROUP_NAME} -g ${GROUP_ID}

RUN useradd -l -m -d /home/${USER_NAME} ${USER_NAME} -g ${GROUP_ID} -u ${USER_ID}

USER ${USER_NAME}

COPY install_dynawo.sh /opt

WORKDIR /home/${USER_NAME}

USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
