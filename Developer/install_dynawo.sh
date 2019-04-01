#!/bin/bash
#
# Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
# See AUTHORS.txt
# All rights reserved.
# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.
# SPDX-License-Identifier: MPL-2.0
#
# This file is part of Dynawo, an hybrid C++/Modelica open source time domain simulation tool for power systems.
#

usage() {
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to install Dynawo in a folder.

  where OPTIONS can be one of the following:
    --prefix mypath        prefix path to install Dynawo (mandatory).
    --help                 print this message.
"
}

install_dynawo() {
  if [ -z "$1" ]; then
    echo "install_dynawo needs a prefix path to install Dynawo in it."
    exit 1
  fi
  local PREFIX_PATH=$1
  if [ ! -d "$PREFIX_PATH" ]; then
    mkdir -p $PREFIX_PATH
  fi
  cd $PREFIX_PATH
  git clone https://github.com/dynawo/dynawo.git dynawo
  cd dynawo
  echo '#!/bin/bash
  export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

  export OPENMODELICA_VERSION=1_9_4
  export SRC_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Source
  export INSTALL_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Install

  export DYNAWO_LOCALE=en_GB
  export RESULTS_SHOW=false
  export BROWSER=xdg-open

  export NB_PROCESSORS_USED=$(($(nproc --all)/2))

  export BUILD_TYPE=Release
  export CXX11_ENABLED=YES

  $DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh
  chmod +x myEnvDynawo.sh
  ./myEnvDynawo.sh build-omcDynawo
  ./myEnvDynawo.sh build-3rd-party-version
  ./myEnvDynawo.sh build-dynawo
  ./myEnvDynawo.sh deploy-autocompletion --deploy
}

MODE=""

while (($#)); do
  case "$1" in
    --prefix)
      MODE=install
      USER_FOLDER=${2%/}
      shift 2
      ;;
    --help)
      usage
      exit 0
      ;;
    *)
      echo "$1: invalid option."
      usage
      exit 1
      ;;
  esac
done

case $MODE in
  install)
    install_dynawo $USER_FOLDER
    ;;
  *)
    echo
    usage
    exit 0
    ;;
esac
