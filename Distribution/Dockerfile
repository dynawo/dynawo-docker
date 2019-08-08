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

ARG GITHUB_TOKEN

ENV USER "dynawo_distribution"

RUN yum upgrade -y \
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
  curl \
  flex \
  bison \
  chrpath \
  epel-release

RUN yum install -y python-pip python-psutil dpkg

ENV BOOST_VERSION 1_64_0

RUN cd /tmp \
&& wget https://sourceforge.net/projects/boost/files/boost/${BOOST_VERSION//_/.}/boost_${BOOST_VERSION}.tar.gz \
&& tar -xzvf boost_${BOOST_VERSION}.tar.gz \
&& cd boost_${BOOST_VERSION} \
&& ./bootstrap.sh --prefix=/opt/boost --without-icu --with-libraries=filesystem,program_options,serialization,system,log,iostreams,atomic \
&& ./b2 -s NO_BZIP2=1 --disable-icu boost.locale.icu=off cxxflags="-fPIC" link=static variant=release install \
&& rm -f /tmp/boost_${BOOST_VERSION}.tar.gz \
&& cd ~ \
&& rm -rf /tmp/boost_${BOOST_VERSION}*

ENV ZLIB_VERSION 1.2.11

RUN cd /tmp \
&& wget https://zlib.net/zlib-${ZLIB_VERSION}.tar.gz \
&& tar xzf zlib-${ZLIB_VERSION}.tar.gz \
&& cd zlib-${ZLIB_VERSION} \
&& CFLAGS="-fPIC" ./configure --static --prefix=/opt/zlib \
&& make \
&& make install \
&& rm -f /tmp/zlib-${ZLIB_VERSION}.tar.gz \
&& cd ~ \
&& rm -rf /tmp/zlib-${ZLIB_VERSION}*

ENV CMAKE_VERSION 3.9.6
ENV CMAKE_VERSION_SHORT 3.9

RUN cd /tmp \
&& wget https://cmake.org/files/v${CMAKE_VERSION_SHORT}/cmake-${CMAKE_VERSION}.tar.gz \
&& tar xzf cmake-${CMAKE_VERSION}.tar.gz \
&& cd cmake-${CMAKE_VERSION} \
&& ./bootstrap \
&& make \
&& make install \
&& rm -f /tmp/cmake-${CMAKE_VERSION}.tar.gz  \
&& cd ~ \
&& rm -rf /tmp/cmake-${CMAKE_VERSION}*

ENV LIBARCHIVE_VERSION 3.3.3

RUN cd /tmp \
&& wget https://libarchive.org/downloads/libarchive-${LIBARCHIVE_VERSION}.tar.gz \
&& tar xzf libarchive-${LIBARCHIVE_VERSION}.tar.gz \
&& cd libarchive-${LIBARCHIVE_VERSION} \
&& mkdir build-cmake \
&& cd build-cmake \
&& CFLAGS="-fPIC" cmake .. -DCMAKE_INSTALL_PREFIX=/opt/libarchive -DCMAKE_BUILD_TYPE=Release -DENABLE_BZip2=OFF -DENABLE_LZ4=OFF -DENABLE_LZMA=OFF -DENABLE_NETTLE=OFF -DENABLE_OPENSSL=OFF -DENABLE_EXPAT=OFF -DCMAKE_PREFIX_PATH=/opt/zlib \
&& make \
&& make install \
&& rm -f /opt/libarchive/lib/*.so* \
&& rm -f /tmp/libarchive-${LIBARCHIVE_VERSION}.tar.gz \
&& cd ~ \
&& rm -rf /tmp/libarchive-${LIBARCHIVE_VERSION}*

RUN useradd -l -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt

ADD https://api.github.com/repos/dynawo/dynawo/git/refs/heads/master version.json

RUN cat version.json

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
export DYNAWO_CXX11_ENABLED=NO\n\
export DYNAWO_LIBRARY_TYPE=STATIC\n\
\n\
export DYNAWO_BOOST_HOME=/opt/boost\n\
export DYNAWO_LIBARCHIVE_HOME=/opt/libarchive\n\
export DYNAWO_ZLIB_HOME=/opt/zlib\n\
\n\
export DYNAWO_BOOST_USE_STATIC=ON\n\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& git checkout $(curl -s --request GET https://api.github.com/repos/dynawo/dynawo/releases/latest | grep tag_name | cut -d '"' -f 4) \
&& ./myEnvDynawo.sh build-user \
&& ./myEnvDynawo.sh distrib-omc \
&& version=$(./myEnvDynawo.sh version | cut -f1 -d' ') \
&& export GITHUB_TOKEN=$GITHUB_TOKEN \
&& curl -H "Authorization: token $GITHUB_TOKEN" -H "Content-Type: application/zip" -X POST $(curl -s --request GET https://api.github.com/repos/dynawo/dynawo/releases/latest | grep upload_url | cut -d '"' -f 4 | grep -o ".*assets")?name=Dynawo_omc_V${version}.zip --data-binary @distributions/Dynawo_omc_V${version}.zip

CMD ["/bin/bash"]
