# Copyright (c) 2020, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
FROM fedora:22
LABEL maintainer Gautier Bureau "gautier.bureau@rte-france.com"

ARG GITHUB_TOKEN

ENV USER "dynawo_distribution"

RUN dnf update -y \
&& dnf install -y \
  git \
  gcc \
  gcc-c++ \
  gcc-gfortran \
  autoconf \
  automake \
  make \
  libtool \
  hwloc \
  java-1.8.0-openjdk-devel \
  blas-devel \
  lapack-devel \
  lpsolve-devel \
  expat-devel \
  glibc-devel \
  sqlite-devel \
  gettext \
  patch \
  wget \
  python-devel \
  ncurses-devel \
  readline-devel \
  unzip \
  perl-Digest-MD5 \
  vim \
  python-pip \
  python-psutil \
  xz \
  rsync \
  python-lxml \
  graphviz \
  libcurl-devel \
  bash-completion \
  zip \
&& curl -L -O https://cmake.org/files/v3.12/cmake-3.12.0-Linux-x86_64.tar.gz \
&& tar -xf cmake-3.12.0-Linux-x86_64.tar.gz && \
&& rm -f cmake-3.12.0-Linux-x86_64.tar.gz

RUN useradd -l -m -d /home/${USER} --user-group ${USER} \
&& chown -R ${USER} /opt

ADD https://api.github.com/repos/dynawo/dynawo/git/refs/heads/master version.json

RUN cat version.json

USER ${USER}

WORKDIR /home/${USER}

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/cmake-3.12.0-Linux-x86_64/bin

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
export DYNAWO_LIBRARY_TYPE=STATIC\n\
export DYNAWO_FORCE_CXX11_ABI=true\n\
\n\
$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh \
&& chmod +x myEnvDynawo.sh \
&& git checkout $(curl -s --request GET https://api.github.com/repos/dynawo/dynawo/releases/latest | grep tag_name | cut -d '"' -f 4) \
&& ./myEnvDynawo.sh build-user \
&& ./myEnvDynawo.sh distrib-headers \
&& version=$(./myEnvDynawo.sh version | cut -f1 -d' ') \
&& export GITHUB_TOKEN=$GITHUB_TOKEN \
&& curl -H "Authorization: token $GITHUB_TOKEN" -H "Content-Type: application/zip" -X POST $(curl -s --request GET https://api.github.com/repos/dynawo/dynawo/releases/latest | grep upload_url | cut -d '"' -f 4 | grep -o ".*assets")?name=Dynawo_Linux_cxx11_v${version}.zip --data-binary @distributions/Dynawo_headers_V${version}.zip

CMD ["/bin/bash"]
