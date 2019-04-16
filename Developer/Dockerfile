# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM fedora:29
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ARG USER_NAME
ARG USER_ID
ARG GROUP_ID
ARG GROUP_NAME

RUN dnf upgrade -y \
&& dnf update -y \
&& dnf install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  libtool \
  sudo \
  passwd \
  cmake \
  hwloc \
  java-1.8.0-openjdk-devel \
  blas-devel \
  lapack-devel \
  lpsolve-devel \
  expat-devel \
  glibc-devel \
  sqlite-devel \
  libarchive-devel \
  zlib-devel \
  doxygen \
  doxygen-latex \
  qt-devel \
  gettext \
  patch \
  wget \
  python-devel \
  clang \
  llvm-devel \
  ncurses-devel \
  readline-devel \
  unzip \
  perl-Digest-MD5 \
  vim \
  gcovr \
  python-pip \
  python-psutil \
  boost-devel \
  lcov \
  gtest-devel \
  gmock-devel \
  xz \
  rsync \
  python-lxml \
  graphviz \
  gpg \
  curl \
  dpkg \
  libcurl-devel \
&& dnf clean all \
&& rm -rf /var/cache/dnf/*

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
  && chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN groupadd ${GROUP_NAME} -g ${GROUP_ID}

RUN useradd -l -m -d /home/${USER_NAME} ${USER_NAME} -g ${GROUP_ID} -u ${USER_ID}

USER ${USER_NAME}

COPY install_dynawo.sh /opt

WORKDIR /home/${USER_NAME}

USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
