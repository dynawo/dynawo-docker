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
  usermod -aG sudo $USER_NAME
  sed -i -e 's/%sudo\s\+ALL=(ALL:ALL) ALL/%sudo	ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
  echo 'Defaults    env_keep += "http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY"' >> /etc/sudoers
  exec /usr/local/bin/gosu $USER_NAME "$@"
elif [ ! -z "$(grep dynawo_developer /etc/passwd)" ]; then
  usermod -aG sudo dynawo_developer
  sed -i -e 's/%sudo\s\+ALL=(ALL:ALL) ALL/%sudo	ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
  echo 'Defaults    env_keep += "http_proxy https_proxy ftp_proxy HTTP_PROXY HTTPS_PROXY no_proxy NO_PROXY"' >> /etc/sudoers
  exec /usr/local/bin/gosu dynawo_developer "$@"
else
  exec "$@"
fi
