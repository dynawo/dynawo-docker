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
  echo -e "\nAvailable Dockerfiles:\n"
  for file in $(find . -maxdepth 1 -name "*Dockerfile*"); do
    echo -e "\t- $file"
  done
  echo -e "\r"
  read -p "Choose Dockerfile: " dockerfile_name
else
  if [ -f "$1" ]; then
    dockerfile_name=$1
  else
    echo "$1 does not exist."
    exit 1
  fi
fi

image_name=dynawo-$(echo $(basename ${dockerfile_name}) | sed 's/Dockerfile.//' | tr '[A-Z]' '[a-z]')

if ! `image_exists $image_name`; then
  docker build -f $dockerfile_name -t $image_name --no-cache=true .
else
  echo "Image $image_name already exists. You can delete it with: ./delete_image.sh --name $image_name"
  exit 1
fi
