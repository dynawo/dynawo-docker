# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM ubuntu:bionic as builder
MAINTAINER Gautier Bureau "gautier.bureau@rte-france.com"

ENV USER "dynawo_travis"

ENV TZ=Europe/Paris \
DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get upgrade -y -q \
&& apt-get install -y git \
  gcc \
  g++ \
  gfortran \
  autoconf \
  pkgconf \
  automake \
  make \
  sudo \
  libtool \
  cmake \
  hwloc \
  openjdk-8-jdk \
  libblas-dev \
  liblpsolve55-dev \
  libarchive-dev \
  doxygen \
  liblapack-dev \
  libexpat1-dev \
  libsqlite3-dev \
  zlib1g-dev \
  gettext \
  patch \
  python-pip \
  libncurses5-dev \
  libreadline-dev \
  libdigest-perl-md5-perl \
  unzip \
  lcov \
  libboost-all-dev \
  qt4-qmake \
  qt4-dev-tools \
  lsb-release \
  libxml2-utils \
  python-lxml \
  python-psutil \
  vim \
  wget \
  rsync \
  libcurl4-openssl-dev \
  curl \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

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
export DYNAWO_BUILD_TYPE=Release\n\
export DYNAWO_CXX11_ENABLED=YES\n\
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

FROM ubuntu:bionic
MAINTAINER Gautier Bureau "gautier.bureau@rte-france.com"

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
ENV BOOST_VERSION_ "1_64_0"
ENV LIBARCHIVE_VERSION "2.8.0"
ENV ZLIB_VERSION "1.2.11"

ENV TZ=Europe/Paris \
DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
&& apt-get upgrade -y -q \
&& apt-get install -y git \
  gcc \
  g++ \
  gfortran \
  autoconf \
  pkgconf \
  automake \
  make \
  sudo \
  libtool \
  cmake \
  hwloc \
  openjdk-8-jdk \
  libblas-dev \
  liblpsolve55-dev \
  libarchive-dev \
  doxygen \
  liblapack-dev \
  libexpat1-dev \
  libsqlite3-dev \
  zlib1g-dev \
  gettext \
  patch \
  python-pip \
  libncurses5-dev \
  libreadline-dev \
  libdigest-perl-md5-perl \
  unzip \
  lcov \
  libboost-all-dev \
  qt4-qmake \
  qt4-dev-tools \
  lsb-release \
  libxml2-utils \
  python-lxml \
  python-psutil \
  vim \
  wget \
  rsync \
  libcurl4-openssl-dev \
  curl \
  bash-completion \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
&& wget http://www.met.reading.ac.uk/clouds/adept/adept-${ADEPT_VERSION}.tar.gz -P /opt \
&& wget https://github.com/LLNL/sundials/releases/download/v${SUNDIALS_VERSION}/sundials-${SUNDIALS_VERSION}.tar.gz -P /opt \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITE_SPARSE_VERSION}.tar.gz -P /opt \
&& wget https://github.com/LLNL/sundials/releases/download/v${SUNDIALS_VERSION2}/sundials-${SUNDIALS_VERSION2}.tar.gz -P /opt \
&& wget http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITE_SPARSE_VERSION2}.tar.gz -P /opt \
&& wget https://github.com/jquery/jquery/archive/${JQUERY_VERSION}.tar.gz -P /opt \
&& wget https://github.com/flot/flot/archive/v${FLOT_VERSION}.tar.gz -P /opt \
&& wget https://github.com/cpplint/cpplint/archive/${CPPLINT_VERSION}.tar.gz -P /opt \
&& wget http://archive.apache.org/dist/xerces/c/${XERCESC_VERSION_SHORT}/sources/xerces-c-${XERCESC_VERSION}.tar.gz -P /opt \
&& mkdir -p /opt/3/sources/ && mv /opt/xerces-c-${XERCESC_VERSION}.tar.gz /opt/3/sources/ \
&& wget https://github.com/libarchive/libarchive/archive/v${LIBARCHIVE_VERSION}.tar.gz -P /opt \
&& wget https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION}/boost_${BOOST_VERSION_}.tar.gz -P /opt \
&& wget https://sourceforge.net/projects/libpng/files/zlib/${ZLIB_VERSION}/zlib-${ZLIB_VERSION}.tar.gz -P /opt

RUN useradd -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt

COPY --from=builder /opt/OpenModelica /opt/OpenModelica

USER ${USER}

WORKDIR /home/${USER}
