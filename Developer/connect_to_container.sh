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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to connect to a Dynawo container.

  where OPTIONS can be one of the following:
    --name myname      container name to connect to (default: dynawo-dev)
    --help             print this message.
"
}

connect_to_container() {
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
    docker exec -it -u $USER_NAME $container_name bash
  else
    echo "You specified a container $container_name that is not created."
    echo "List of available containers:"
    for name in `docker ps -a --format "{{.Names}}"`; do echo "  $name"; done
    exit 1
  fi
}

user_identity

container_name=dynawo-dev

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

connect_to_container
