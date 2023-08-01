# Copyright (c) 2022, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM centos:7
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ENV CMAKE_VERSION 3.14.0
ENV CMAKE_VERSION_SHORT 3.14

RUN yum upgrade -y \
&& yum update -y \
&& yum install -y \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  sudo \
  libtool \
  hwloc \
  java-1.8.0-openjdk \
  blas-devel \
  lapack-devel \
  expat-devel \
  glibc-devel \
  xulrunner-devel \
  sqlite-devel \
  doxygen \
  qt-devel \
  gettext \
  patch \
  wget \
  python-devel \
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
  python-lxml \
  epel-release \
&& wget --no-check-certificate https://cmake.org/files/v${CMAKE_VERSION_SHORT}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
&& tar -xf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
&& rm -f cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz \
&& wget --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.29.3.tar.gz \
&& tar xzf git-2.29.3.tar.gz \
&& pushd git-2.29.3 \
&& ./configure \
&& make \
&& make install \
&& popd \
&& rm -rf git-2.29.3 git-2.29.3.tar.gz

RUN yum install -y python-pip python-psutil dpkg bash-completion

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/cmake-${CMAKE_VERSION}-Linux-x86_64/bin

CMD ["/bin/bash"]
