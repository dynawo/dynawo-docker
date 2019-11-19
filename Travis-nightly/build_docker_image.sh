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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to create a Dynawo image.

  where OPTIONS can be one of the following:
    --name (-n)       fedora or bionic (mandatory)
    --help (-h)       print this message.
"
}

build_image() {
  if ! `image_exists $image_name`; then
    docker build -t $image_name --no-cache=true -f Dockerfile.$distrib_name .
  else
    echo "Image $image_name already exists. You can delete it with: ./delete_image.sh --name $image_name"
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

image_name=dynawo-travis-nightly-$distrib_name

build_image
