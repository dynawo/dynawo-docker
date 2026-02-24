# Copyright (c) 2022, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM oraclelinux:8
LABEL maintainer Florentine Rosiere "florentine.rosiere@rte-france.com"

RUN dnf config-manager --set-enabled ol8_codeready_builder \
&& dnf install -y \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  sudo \
  libtool \
  hwloc \
  lapack-devel \
  blas-devel \
  doxygen \
  java-1.8.0-openjdk \
  expat-devel \
  glibc-devel \
  sqlite-devel \
  gettext \
  patch \
  wget \
  python3-devel \
  ncurses-devel \
  readline-devel \
  unzip \
  perl-Digest-MD5 \
  vim \
  libcurl-devel \
  curl \
  flex \
  bison \
  chrpath \
  sed \
  tar \
  xz \
  python3-lxml \
  python3 \
  epel-release \
  git \
  lapack \
&& curl -LO https://github.com/Kitware/CMake/releases/download/v3.12.0/cmake-3.12.0-Linux-x86_64.tar.gz \
&& tar xzf cmake-3.12.0-Linux-x86_64.tar.gz \
&& rm -f cmake-3.12.0-Linux-x86_64.tar.gz

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/cmake-3.12.0-Linux-x86_64/bin
