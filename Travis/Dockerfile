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

ENV USER "dynawo_travis"

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

RUN useradd -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt

USER ${USER}

WORKDIR /home/${USER}

RUN git clone https://github.com/dynawo/dynawo.git dynawo \
&& cd dynawo \
&& echo $'#!/bin/bash \n\
export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)\n\
\n\
export OPENMODELICA_VERSION=1_9_4\n\
export SRC_OPENMODELICA=/opt/OpenModelica/Source\n\
export INSTALL_OPENMODELICA=/opt/OpenModelica/Install\n\
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
&& rm -rf /opt/OpenModelica/Source \
&& rm -rf /opt/OpenModelica/Install/share \
&& cd .. \
&& rm -rf dynawo

WORKDIR /home/${USER}/dynawo

CMD ["/bin/bash"]

FROM fedora:29
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ENV USER "dynawo_travis"
ENV ADEPT_VERSION "1.1"
ENV SUITE_SPARSE_VERSION "4.5.4"
ENV SUNDIALS_VERSION "2.7.0"
ENV XERCESC_VERSION "3.2.2"
ENV XERCESC_VERSION_SHORT "3"
ENV CPPLINT_VERSION "1.3.0"
ENV JQUERY_VERSION "1.3.2"
ENV FLOT_VERSION "0.6.0"

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
&& dnf clean all \
&& rm -rf /var/cache/dnf/* \
&& wget http://www.met.reading.ac.uk/clouds/adept/adept-${ADEPT_VERSION}.tar.gz -P /opt \
&& wget https://computation.llnl.gov/projects/sundials/download/sundials-${SUNDIALS_VERSION}.tar.gz -P /opt \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITE_SPARSE_VERSION}.tar.gz -P /opt \
&& wget https://github.com/jquery/jquery/archive/${JQUERY_VERSION}.tar.gz -P /opt \
&& wget https://github.com/flot/flot/archive/v${FLOT_VERSION}.tar.gz -P /opt \
&& wget https://github.com/cpplint/cpplint/archive/${CPPLINT_VERSION}.tar.gz -P /opt \
&& wget http://archive.apache.org/dist/xerces/c/${XERCESC_VERSION_SHORT}/sources/xerces-c-${XERCESC_VERSION}.tar.gz -P /opt

RUN useradd -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt \
&& gem install coveralls-lcov

COPY --from=builder /opt/OpenModelica /opt/OpenModelica

USER ${USER}

WORKDIR /home/${USER}
