# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM centos:6.6
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

RUN sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-Base.repo \
&& sed -i 's/#baseurl/baseurl/' /etc/yum.repos.d/CentOS-Base.repo \
&& sed -i 's|mirror.centos.org/centos|vault.centos.org|' /etc/yum.repos.d/CentOS-Base.repo \
&& sed -i 's/$releasever/6.6/' /etc/yum.repos.d/CentOS-Base.repo \
&& yum upgrade -y \
&& yum update -y \
&& yum install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  sudo \
  libtool \
  cmake \
  hwloc \
  java-1.8.0-openjdk \
  blas-devel \
  lapack-devel \
  expat-devel \
  glibc-devel \
  xulrunner-devel \
  sqlite-devel \
  gettext \
  patch \
  wget \
  python-devel \
  ncurses-devel \
  readline-devel \
  unzip \
  vim \
  tar \
  xz \
  python-lxml \
  curl-devel \
  flex \
  bison \
  chrpath \
  sed \
  epel-release \
&& dnf clean all \
&& rm -rf /var/cache/dnf/*

RUN yum install -y python-pip python-psutil dpkg

ENV CMAKE_VERSION 3.9.6
ENV CMAKE_VERSION_SHORT 3.9

RUN cd /tmp \
&& wget https://cmake.org/files/v${CMAKE_VERSION_SHORT}/cmake-${CMAKE_VERSION}.tar.gz \
&& tar xzf cmake-${CMAKE_VERSION}.tar.gz \
&& cd cmake-${CMAKE_VERSION} \
&& ./bootstrap --system-curl \
&& make \
&& make install \
&& rm -f /tmp/cmake-${CMAKE_VERSION}.tar.gz  \
&& cd ~ \
&& rm -rf /tmp/cmake-${CMAKE_VERSION}*

CMD ["/bin/bash"]
