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
export DYNAWO_SRC_OPENMODELICA=/opt/OpenModelica/Source\n\
export DYNAWO_INSTALL_OPENMODELICA=/opt/OpenModelica/Install\n\
\n\
export DYNAWO_LOCALE=en_GB\n\
export DYNAWO_RESULTS_SHOW=false\n\
export DYNAWO_BROWSER=xdg-open\n\
\n\
export DYNAWO_NB_PROCESSORS_USED=1\n\
\n\
export DYNAWO_BUILD_TYPE=Debug\n\
export DYNAWO_CXX11_ENABLED=YES\n\
\n\
export DYNAWO_THIRD_PARTY_INSTALL_DIR=/opt/dynawo/3rParty\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& ./myEnvDynawo.sh build-omcDynawo \
&& rm -rf /opt/OpenModelica/Source \
&& rm -rf /opt/OpenModelica/Install/share \
&& ./myEnvDynawo.sh build-3rd-party \
&& cd .. \
&& rm -rf dynawo

WORKDIR /home/${USER}/dynawo

CMD ["/bin/bash"]

FROM fedora:29
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ENV USER "dynawo_travis"
ENV ADEPT_VERSION "2.0.5"
ENV SUITE_SPARSE_VERSION "4.5.4"
ENV SUNDIALS_VERSION "4.1.0"
ENV SUITE_SPARSE_VERSION2 "5.3.0"
ENV SUNDIALS_VERSION2 "5.0.0"
ENV XERCESC_VERSION "3.2.2"
ENV XERCESC_VERSION_SHORT "3"
ENV CPPLINT_VERSION "1.4.4"
ENV JQUERY_VERSION "1.3.2"
ENV FLOT_VERSION "0.6.0"
ENV BOOST_VERSION "1.64.0"
ENV LIBARCHIVE_VERSION "2.8.0"
ENV ZLIB_VERSION "1.2.11"

RUN dnf upgrade -y \
&& dnf update -y \
&& dnf install -y \
  blas-devel \
  lapack-devel \
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
&& dnf clean all \
&& rm -rf /var/cache/dnf/* \
&& wget http://www.met.reading.ac.uk/clouds/adept/adept-${ADEPT_VERSION}.tar.gz -P /opt \
&& wget https://github.com/LLNL/sundials/releases/download/v${SUNDIALS_VERSION}/sundials-${SUNDIALS_VERSION}.tar.gz -P /opt \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITE_SPARSE_VERSION}.tar.gz -P /opt \
&& wget https://github.com/LLNL/sundials/releases/download/v${SUNDIALS_VERSION2}/sundials-${SUNDIALS_VERSION2}.tar.gz -P /opt \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITE_SPARSE_VERSION2}.tar.gz -P /opt \
&& wget https://github.com/jquery/jquery/archive/${JQUERY_VERSION}.tar.gz -P /opt \
&& wget https://github.com/flot/flot/archive/v${FLOT_VERSION}.tar.gz -P /opt \
&& wget http://archive.apache.org/dist/xerces/c/${XERCESC_VERSION_SHORT}/sources/xerces-c-${XERCESC_VERSION}.tar.gz -P /opt \
&& mkdir -p /opt/3/sources/ && mv /opt/xerces-c-${XERCESC_VERSION}.tar.gz /opt/3/sources/ \
&& wget https://github.com/cpplint/cpplint/archive/${CPPLINT_VERSION}.tar.gz -P /opt \
&& wget https://github.com/libarchive/libarchive/archive/v${LIBARCHIVE_VERSION}.tar.gz -P /opt \
&& wget https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION//./_}.tar.gz -P /opt \
&& wget https://sourceforge.net/projects/libpng/files/zlib/${ZLIB_VERSION}/zlib-${ZLIB_VERSION}.tar.gz -P /opt \
&& mkdir -p /opt/sonar \
&& wget https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip -P /opt \
&& unzip /opt/build-wrapper-linux-x86.zip -d /opt/sonar \
&& cp /opt/sonar/build-wrapper-linux-x86/libinterceptor-x86_64.so /opt/sonar/build-wrapper-linux-x86/libinterceptor-haswell.so \
&& wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.3.0.1492-linux.zip -P /opt \
&& unzip /opt/sonar-scanner-cli-3.3.0.1492-linux.zip -d /opt/sonar \
&& pip install coverage

RUN useradd -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt \
&& gem install coveralls-lcov

COPY --from=builder /opt/OpenModelica /opt/OpenModelica
COPY --from=builder /opt/dynawo/3rParty /opt/dynawo/3rParty

USER ${USER}

WORKDIR /home/${USER}
