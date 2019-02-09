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

ENV USER "dynawo_user"

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
&& dnf clean all \
&& rm -rf /var/cache/dnf/*

RUN useradd -m -d /home/${USER} --user-group ${USER}

USER ${USER}

WORKDIR /home/${USER}

RUN git clone https://github.com/dynawo/dynawo.git dynawo \
&& cd dynawo \
&& echo $'#!/bin/bash \n\
export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)\n\
\n\
export OPENMODELICA_VERSION=1_9_4\n\
export SRC_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Source\n\
export INSTALL_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Install\n\
\n\
export DYNAWO_LOCALE=en_GB\n\
export USE_ADEPT=YES\n\
export RESULTS_SHOW=false\n\
export BROWSER=xdg-open\n\
\n\
export NB_PROCESSORS_USED=1\n\
\n\
export BUILD_TYPE=Release\n\
export CXX11_ENABLED=YES\n\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& ./myEnvDynawo.sh build-omcDynawo \
&& ./myEnvDynawo.sh build-3rd-party \
&& ./myEnvDynawo.sh build-dynawo \
&& rm -rf OpenModelica/Source \
&& rm -rf build \
&& rm -rf install/3rdParty/gcc8/Debug install/3rdParty/gcc8/Debug-cxx11 install/3rdParty/gcc8/Release \
&& rm -rf OpenModelica/Install/share \
&& rm -f OpenModelica/Install/lib/libipopt.so.0.0.0 \
&& echo "alias dynawo='/home/$(whoami)/dynawo/myEnvDynawo.sh'" >> ~/.bashrc

WORKDIR /home/${USER}/dynawo

CMD ["/bin/bash"]