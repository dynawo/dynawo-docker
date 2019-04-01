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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to delete a Dynawo container.

  where OPTIONS can be one of the following:
    --name myname      container name to delete (mandatory)
    --help             print this message.
"
}

container_name=""

while (($#)); do
  case "$1" in
    --help)
      usage
      exit 0
      ;;
    --name)
      container_name=$2
      shift 2
      ;;
    *)
      echo "$1: invalid option."
      usage
      exit 1
      ;;
  esac
done

if [ ! -z "$container_name" ]; then
  delete_container $container_name
else
  usage
  exit 1
fi
