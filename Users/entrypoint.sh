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

if [ ! -z "$LOCAL_USER_ID" ]; then
  usermod -u $LOCAL_USER_ID dynawo_user
fi
if [ ! -z "$LOCAL_GROUP_ID" ]; then
  # Try to modify the gid of dynawo_user or add dynawo_user to existing gid group or add secondary group to dynawo_user
  groupmod -o -g $LOCAL_GROUP_ID dynawo_user || usermod -g $LOCAL_GROUP_ID dynawo_user || usermod -a -G $LOCAL_GROUP_ID dynawo_user
fi
# groupmod -o --new-name NEW_GROUP_NAME OLD_GROUP_NAME

chown -R dynawo_user:dynawo_user /home/dynawo_user

exec /usr/local/bin/gosu dynawo_user "$@"
