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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to create a Dynawo container.

  where OPTIONS can be one of the following:
    --name -(n)        fedora or bionic (mandatory).
    --help (-h)        print this message.
"
}

create_container() {
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
}

while (($#)); do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --name|-n)
      if [ "$2" = "fedora" -o "$2" = "bionic" ]; then
        distrib_name=$2
        shift 2
      else
        echo "$2: invalid option for name."
        usage
        exit 1
      fi
      ;;
    *)
      echo "$1: invalid option."
      usage
      exit 1
      ;;
  esac
done

if [ -z "$distrib_name" ]; then
  echo "--name (-n) option is mandatory, with fedora or bionic."
  exit 1
fi

container_name=dynawo-travis-nightly-$distrib_name
image_name=dynawo-travis-nightly-$distrib_name

create_container
