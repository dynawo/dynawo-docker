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

if [ -f "/etc/os-release" ]; then
  DOCKER_OS=$(cat /etc/os-release | grep -w ID | cut -d = -f 2 | tr -d '"')
elif [ -f "/etc/system-release" ]; then
  DOCKER_OS=$(cat /etc/system-release | cut -d ' ' -f 1 | tr '[A-Z]' '[a-z]')
else
  echo "We don't know how to determine your Linux distribution."
  echo "We only currently support Centos, Fedora, Debian and Ubuntu Docker."
  exit 1
fi

case $DOCKER_OS in
  centos|fedora)
    usermod -aG wheel dynawo_user
    sed -i 's/#.*\(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers
    ;;
  debian|ubuntu)
    usermod -aG sudo dynawo_user
    sed -i 's/%sudo	ALL=(ALL:ALL) ALL/%sudo	ALL=(ALL:ALL) NOPASSWD:ALL/' /etc/sudoers
    ;;
  *)
    echo "$DOCKER_OS not supported for the moment."
    exit 1
    ;;
esac

chown -R dynawo_user:dynawo_user /home/dynawo_user
chown -R dynawo_user:dynawo_user /opt/install_dynawo.sh

exec /usr/local/bin/gosu dynawo_user "$@"
