#!/bin/bash
#
# Copyright (c) 2024, RTE (http://www.rte-france.com)
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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to create a Dynawo container.

  where OPTIONS can be one of the following:
    --container-name (-n) mycontainer   container name created (default: dynawo-distribution)
    --image-name (-i) myimage           image name (default: dynawo-distribution)
    --help (-h)                         print this message.
"
}

create_container() {
  if ! `container_exists $container_name`; then
    if `image_exists $image_name`; then
      docker run -it -d -u "$(id -u):$(id -g)" --name=$container_name \
        -v $(pwd):/fedora \
        -w /fedora \
        $image_name bash
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
}

container_name=dynawo-distribution
image_name=dynawo-distribution

while (($#)); do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --container-name|-n)
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

create_container
