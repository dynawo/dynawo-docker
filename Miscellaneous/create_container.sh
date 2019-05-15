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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to create a Dynawo container with a shared folder from your host machine.

  where OPTIONS can be one of the following:
    --container-name (-c) mycontainer   container name to be created (default: dynawo).
    --image-name (-i) myimage           image name (default: dynawo)
    --help                         print this message.
"
}

container_name=""
image_name=""

while (($#)); do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --container-name|-c)
      container_name=$2
      shift 2
      ;;
    --image-name|-i)
      image_name=$2
      shift 2
      ;;
    *)
      echo "$1: invalid option."
      usage
      exit 1
      ;;
  esac
done

if [ -z "$image_name" ]; then
  echo -e "\nExisting images:\n"
  docker images --format "{{.Repository}}"
  echo -e "\r"
  read -p "Choose Docker image: " image_name
else
  if ! `image_exists $image_name`; then
    echo "You specified an image name that is not existing."
    echo "List of available images:"
    for name in `docker images --format "{{.Repository}}" | sort | uniq`; do echo "  $name"; done
    exit 1
  fi
fi

if [ -z "$container_name" ]; then
  container_name=$image_name
fi

if ! `container_exists $container_name`; then
  if `image_exists $image_name`; then
    docker run -it -d --name=$container_name \
    $image_name
  else
    echo "You specified an image name that is not existing."
    echo "List of available images:"
    for name in `docker images --format "{{.Repository}}" | sort | uniq`; do echo "  $name"; done
    exit 1
  fi
else
  echo "Container $container_name already exists. You can delete it with: ./delete_container.sh --name $container_name"
  exit 1
fi
