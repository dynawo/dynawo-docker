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

if [ -z "$1" ]; then
  echo -e "\nExisting containers:\n"
  docker ps -a --format "{{.Names}}"
  echo -e "\r"
  read -p "Choose container: " container_name
else
  if `container_exists $1`; then
    container_name=$1
  else
    echo "You specified a container $container_name that is not created."
    echo "List of available containers:"
    for name in `docker ps -a --format "{{.Names}}"`; do echo "  $name"; done
    exit 1
  fi
fi

if `container_exists $container_name`; then
  if `container_is_running $container_name`; then
    while true; do
      if [ ! "$(docker top $container_name | tail -n +2 | grep "entrypoint")" ]; then
        break
      else
        if [ -z "$first_time" ]; then
          echo "Waiting for Docker container $container_name to start."
          first_time=1
        fi
        sleep 2
      fi
    done
  else
    docker start $container_name
  fi
  docker exec -it -u dynawo_user $container_name bash
else
  echo "You specified a container $container_name that is not created."
  echo "List of available containers:"
  for name in `docker ps -a --format "{{.Names}}"`; do echo "  $name"; done
  exit 1
fi
