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

if [ ! -z "$USER_NAME" ]; then
  usermod -aG wheel $USER_NAME
  sed -i 's/#.*\(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers
  exec /usr/local/bin/gosu $USER_NAME "$@"
elif [ ! -z "$(grep dynawo_developer /etc/passwd)" ]; then
  usermod -aG wheel dynawo_developer
  sed -i 's/#.*\(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers
  exec /usr/local/bin/gosu dynawo_developer "$@"
else
  exec "$@"
fi
