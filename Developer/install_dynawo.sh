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

git clone https://github.com/dynawo/dynawo.git dynawo
cd dynawo
echo '#!/bin/bash
export DYNAWO_HOME=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

export OPENMODELICA_VERSION=1_9_4
export SRC_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Source
export INSTALL_OPENMODELICA=$DYNAWO_HOME/OpenModelica/Install

export DYNAWO_LOCALE=en_GB
export USE_ADEPT=YES
export RESULTS_SHOW=false
export BROWSER=xdg-open

export NB_PROCESSORS_USED=$(($(nproc --all)/2))

export BUILD_TYPE=Release
export CXX11_ENABLED=YES

$DYNAWO_HOME/util/envDynawo.sh $@' > myEnvDynawo.sh
chmod +x myEnvDynawo.sh
./myEnvDynawo.sh build-omcDynawo
./myEnvDynawo.sh build-all
