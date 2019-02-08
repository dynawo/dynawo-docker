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

. util.sh

user_identity

image_name=dynawo-dev
container_name=dynawo_container_dev

docker run -it -d --name=$container_name -v $USER_HOME:/home/$USER_NAME $image_name
docker exec -it -u root $container_name usermod -aG wheel $USER_NAME
docker exec -it -u root $container_name bash -c "sed -i 's/#.*\(%wheel.*NOPASSWD.*\)/\1/' /etc/sudoers"
