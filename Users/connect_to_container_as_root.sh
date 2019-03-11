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

source ../Helper/helper.sh

usage() {
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to connect to a Dynawo container as root.

  where OPTIONS can be one of the following:
    --name             container name to connect to (default: dynawo)
    --help             print this message.
"
}

container_name=dynawo

opts=`getopt -o '' --long "help,name:" -n 'connect_to_container_as_root' -- "$@"`
if [ $? -ne 0 ]; then usage; exit 1; fi
eval set -- "$opts"
while true; do
  case "$1" in
    --help)
      usage
      exit 0
      ;;
    --name)
      container_name=$2
      shift 2
      ;;
    --)
      shift
      break
      ;;
    *)
      break
      ;;
  esac
done

connect_to_container_as_root $container_name
