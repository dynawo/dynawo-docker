# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM fedora:29 as builder
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

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
  lcov \
  python-pip \
  python-psutil \
  boost-devel \
  gtest-devel \
  gmock-devel \
  xz \
  rsync \
  python-lxml \
&& dnf clean all \
&& rm -rf /var/cache/dnf/*

RUN git clone https://github.com/dynawo/dynawo.git dynawo \
&& cd dynawo \
&& echo $'#!/bin/bash \n\
export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)\n\
\n\
export DYNAWO_SRC_OPENMODELICA=/opt/OpenModelica/Source\n\
export DYNAWO_INSTALL_OPENMODELICA=/opt/OpenModelica/Install\n\
\n\
export DYNAWO_LOCALE=en_GB\n\
export DYNAWO_RESULTS_SHOW=false\n\
export DYNAWO_BROWSER=xdg-open\n\
\n\
export DYNAWO_NB_PROCESSORS_USED=2\n\
\n\
export DYNAWO_BUILD_TYPE=Debug\n\
\n\
export DYNAWO_THIRD_PARTY_INSTALL_DIR=/opt/dynawo/3rParty\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& ./myEnvDynawo.sh build-omcDynawo \
&& rm -rf /opt/OpenModelica/Source \
&& rm -rf /opt/OpenModelica/Install/share \
&& ./myEnvDynawo.sh build-3rd-party \
&& sed -i 's/Debug/Release/' myEnvDynawo.sh \
&& sed -i 's/3rParty/3rPartyRelease/' myEnvDynawo.sh \
&& ./myEnvDynawo.sh build-3rd-party \
&& cd .. \
&& rm -rf dynawo

CMD ["/bin/bash"]

FROM fedora:29
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

RUN dnf upgrade -y \
&& dnf update -y \
&& dnf install -y \
  blas \
  lapack \
  lpsolve \
  git \
  cmake \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  make \
  libarchive-devel \
  gtest-devel \
  gmock-devel \
  patch \
  wget \
  boost-devel \
  python \
  python-lxml \
  binutils \
  python-psutil \
  autoconf \
  automake \
  python-devel \
  zlib-devel \
  lcov \
  gem \
  unzip \
  gcovr \
  bash-completion \
  libtool \
  vim \
  gdb \
  mpich-devel \
  gperftools-devel \
  doxygen \
  doxygen-latex \
&& dnf clean all \
&& rm -rf /var/cache/dnf/* \
&& pip install coverage

COPY --from=builder /opt/OpenModelica /opt/OpenModelica
COPY --from=builder /opt/dynawo/3rParty /opt/dynawo/3rParty
COPY --from=builder /opt/dynawo/3rParty /opt/dynawo/3rPartyRelease
