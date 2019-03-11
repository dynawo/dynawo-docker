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

# In: $1: name of the container
# Out: return code 0 -> True
#      return code 1 -> False
container_is_running() {
  if [ -z "$1" ]; then
    echo "container_is_running needs a name of container as argument."
    exit 1
  fi
  local test_container_name=$(docker ps --format "{{.Names}}" | grep -w "${1}$")
  if [ ! -z "$test_container_name" ]; then
    return 0
  else
    return 1
  fi
}

# In: $1: name of the container
# Out: return code 0 -> True
#      return code 1 -> False
container_exists() {
  if [ -z "$1" ]; then
    echo "container_exists needs a name of container as argument."
    exit 1
  fi
  local test_container_name=$(docker ps -a --format "{{.Names}}" | grep -w "${1}$")
  if [ "$test_container_name" ]; then
    return 0
  else
    return 1
  fi
}

# In: $1: name of the image
# Out: return code 0 -> True
#      return code 1 -> False
image_exists() {
  if [ -z "$1" ]; then
    echo "image_exists needs a name of image as argument."
    exit 1
  fi
  local test_image_name=$(docker images --format "{{.Repository}}" | sort | uniq  | grep -w "${1}$")
  if [ "$test_image_name" ]; then
    return 0
  else
    return 1
  fi
}

# In: $1: name of the image
# Out: list of containers
list_of_containers_using_image() {
  if [ -z "$1" ]; then
    echo "list_of_container_using_image needs a name of image as argument."
    exit 1
  fi
  echo "$(docker ps -a --filter ancestor=$1 --format "{{.Names}}")"
}

# In: $1: name of the image
# Out: return code 0 -> True
#      return code 1 -> False
container_exists_for_image() {
  if [ -z "$1" ]; then
    echo "container_exists_for_image needs a name of image as argument."
    exit 1
  fi
  local test_image_name=$(list_of_containers_using_image $1)
  if [ "$test_image_name" ]; then
    return 0
  else
    return 1
  fi
}

user_identity() {
  USER_NAME=$(whoami)
  USER_ID=$(id -u $USER_NAME)
  GROUP_ID=$(id -g $USER_NAME)
  GROUP_NAME=$(id -gn $USER_NAME)
  USER_HOME=$(eval echo "~$USER_NAME")
}

connect_to_container_as_root() {
  if [ -z "$1" ]; then
    echo "connect_to_container_as_root needs a name of container as argument."
    exit 1
  fi
  local container_name=$1
  if `container_exists $container_name`; then
    if `container_is_running $container_name`; then
      docker exec -it $container_name bash
    else
      docker start $container_name
      docker exec -it $container_name bash
    fi
  else
    echo "You specified a container $container_name that is not created."
    echo "List of available containers:"
    for name in `docker ps -a --format "{{.Names}}"`; do echo "  $name"; done
    exit 1
  fi
}

delete_image() {
  if [ -z "$1" ]; then
    echo "delete_image needs a name of image as argument."
    exit 1
  fi
  if `image_exists $image_name`; then
    local image_name=$1
    if ! `container_exists_for_image $image_name`; then
      docker rmi $image_name
    else
      echo "Some containers are still using the image:"
      for name in `list_of_containers_using_image $image_name`; do echo "  $name"; done
      echo "You can delete them with ./delete_container.sh --name name1"
      exit 0
    fi
  else
    echo "You specified an image name that is not existing."
    echo "List of available images:"
    for name in `docker images --format "{{.Repository}}" | sort | uniq`; do echo "  $name"; done
    exit 1
  fi
}


delete_container() {
  if [ -z "$1" ]; then
    echo "delete_container needs a name of container as argument."
    exit 1
  fi
  local container_name=$1
  if `container_is_running $container_name`; then
    docker stop $container_name
    docker rm $container_name
  elif `container_exists $container_name`; then
    docker rm $container_name
  else
    echo "Container does not exist. Nothing to do."
    exit 0
  fi
}
