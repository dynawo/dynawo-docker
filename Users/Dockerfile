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
  ca-certificates \
  gpg \
  curl \
  libcurl-devel \
  dpkg \
  bash-completion \
&& dnf clean all \
&& rm -rf /var/cache/dnf/*

RUN curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
&& chmod +x /usr/local/bin/gosu

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN useradd -l -m -d /home/${USER} --user-group ${USER}

ADD https://api.github.com/repos/dynawo/dynawo/git/refs/heads/master version.json

RUN cat version.json

USER ${USER}

WORKDIR /home/${USER}

RUN git clone https://github.com/dynawo/dynawo.git dynawo \
&& cd dynawo \
&& echo $'#!/bin/bash \n\
export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)\n\
\n\
export DYNAWO_SRC_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Source\n\
export DYNAWO_INSTALL_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Install\n\
\n\
export DYNAWO_LOCALE=en_GB\n\
export DYNAWO_RESULTS_SHOW=false\n\
export DYNAWO_BROWSER=xdg-open\n\
\n\
export DYNAWO_NB_PROCESSORS_USED=1\n\
\n\
export DYNAWO_BUILD_TYPE=Release\n\
export DYNAWO_CXX11_ENABLED=YES\n\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& ./myEnvDynawo.sh build-omcDynawo \
&& ./myEnvDynawo.sh build-3rd-party \
&& ./myEnvDynawo.sh build-dynawo \
&& ./myEnvDynawo.sh deploy-autocompletion --deploy \
&& rm -rf OpenModelica/Source \
&& rm -rf build \
&& rm -rf OpenModelica/Install/share \
&& rm -f OpenModelica/Install/lib/libipopt.so.0.0.0

WORKDIR /home/${USER}/dynawo

USER root

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/bin/bash"]
