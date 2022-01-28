#!/bin/bash
#
# Copyright (c) 2022, RTE (http://www.rte-france.com)
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
  echo -e "Usage: `basename $0` [OPTIONS]\tprogram to delete a Dynawo image.

  where OPTIONS can be one of the following:
    --name (-n) myname     image name to delete (default: dynawo-distribution-centos7)
    --help (-h)            print this message.
"
}

image_name=dynawo-distribution-centos7

while (($#)); do
  case "$1" in
    --help|-h)
      usage
      exit 0
      ;;
    --name|-n)
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

delete_image $image_name
