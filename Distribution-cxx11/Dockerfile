# Copyright (c) 2020, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM fedora:22
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

RUN dnf update -y \
&& dnf install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  libtool \
  hwloc \
  java-1.8.0-openjdk-devel \
  blas-devel \
  lapack-devel \
  lpsolve-devel \
  expat-devel \
  glibc-devel \
  sqlite-devel \
  gettext \
  patch \
  wget \
  python-devel \
  ncurses-devel \
  readline-devel \
  unzip \
  perl-Digest-MD5 \
  vim \
  python-pip \
  python-psutil \
  xz \
  rsync \
  python-lxml \
  graphviz \
  libcurl-devel \
  bash-completion \
  zip  \
&& dnf clean all \
&& rm -rf /var/cache/dnf/* \
&& curl -L -O https://cmake.org/files/v3.12/cmake-3.12.0-Linux-x86_64.tar.gz \
&& tar -xf cmake-3.12.0-Linux-x86_64.tar.gz \
&& rm -f cmake-3.12.0-Linux-x86_64.tar.gz

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/cmake-3.12.0-Linux-x86_64/bin

CMD ["/bin/bash"]
