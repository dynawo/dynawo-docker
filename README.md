<!--
    Copyright (c) 2015-2019, RTE (http://www.rte-france.com)
    See AUTHORS.txt
    All rights reserved.
    This Source Code Form is subject to the terms of the Mozilla Public
    License, v. 2.0. If a copy of the MPL was not distributed with this
    file, you can obtain one at http://mozilla.org/MPL/2.0/.
    SPDX-License-Identifier: MPL-2.0

    This file is part of Dynawo, an hybrid C++/Modelica open source time domain
    simulation tool for power systems.
-->
# Dyna&omega;o - An hybrid C++/Modelica suite of simulation tools for power systems - Docker Images
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

[https://hub.docker.com/r/dynawo/dynawo](https://hub.docker.com/r/dynawo/dynawo)

This repository contains Dyna&omega;o's Docker images.

## Table of Contents

- [About this repository](#about)
- [Get involved!](#contributions)
- [User image](#users)
- [Developers Image](#developer)
- [License](#license)
- [Maintainers](#maintainers)
- [Links](#links)

<a name="about"></a>
## About this repository

**Dyna&omega;o is an hybrid C++/Modelica open source suite of simulation tools for power systems. It aims at providing power system stakeholders with a transparent, flexible, interoperable and robust suite of simulation tools that could ease collaboration and cooperation in the power system community.**
To achieve this goal, Dyna&omega;o is based on two mains principles: the use of a high-level modeling language Modelica and a strict separation between modeling and solving parts.

We provide this repository to ease users with [Dyna&omega;o' installation](https://github.com/dynawo/dynawo#build) and provide a quick way to try the simulation tool.

<a name="contributions"></a>
## Get involved!

Dyna&omega;o-docker is an open-source project and as such, questions, discussions, feedbacks and more generally any form of contribution are very welcome and greatly appreciated!

For further informations about contributing guidelines, please refers to the [contributing documentation](https://github.com/dynawo/.github/blob/master/CONTRIBUTING.md).

<a name="users"></a>
## User image

### From Docker Hub

Under the [Users](https://github.com/dynawo/dynawo-docker/tree/master/Users) folder we provide a Dockerfile to build an image integrating the latest Dyna&omega;o version. This image is available on [Docker Hub](https://hub.docker.com/r/dynawo/dynawo). Then if you already have docker installed on your machine you can directly execute the following command:
``` bash
$> docker run -it dynawo/dynawo
```

The previous command is a very basic one to just test Dyna&omega;o very quickly. **We recommend** you to create a container by sharing a folder of your host machine so that you can access it inside and outside the container to create your own test cases. You can launch the following command (**`FOLDER_PATH` needs to be modified with appropriate value**):

#### For Linux, Unix and Windows Docker Toolbox (with Docker Quickstart Terminal)

``` bash
$> docker run -it -e LOCAL_USER_ID=`id -u $USER` -e LOCAL_GROUP_ID=`id -g $USER` -v FOLDER_PATH:/home/dynawo_user/SharedFolder dynawo/dynawo
```

#### For Windows Docker Desktop CE

``` bash
> docker run -it -v FOLDER_PATH:/home/dynawo_user/SharedFolder dynawo/dynawo
```

For `FOLDER_PATH` syntax on Windows you can find help [here](https://github.com/dynawo/dynawo-docker/blob/master/Users/ShareFoldersWindows.md).

Once inside the container the user can use the `dynawo` alias and launch:
``` bash
dynawo_user@contaiderID:dynawo$> dynawo nrt
```

### From sources

You can also build your image from sources by following [these instructions](https://github.com/dynawo/dynawo-docker/blob/master/Users/BuildFromSources.md).

<a name="developer"></a>
## Developers Image

Under the [Developers](https://github.com/dynawo/dynawo-docker/tree/master/Developers) folder we provide a Dockerfile to build an image containing all necessary tools to compile Dyna&omega;o. This time the approach is to store the sources on your machine, so that you can use your favorite IDE to develop, and use the container to compile the code.

### Linux, Unix and Windows Toolbox (with Docker Quickstart Terminal)

First you have to build an image with the following commands:

``` bash
$> git clone https://github.com/dynawo/dynawo-docker.git dynawo-docker
$> cd dynawo-docker/Developers
$> ./build_docker_image.sh
```

Then you need to create the container, this time we create a mirror user of you inside the container to be able to access files inside and outside the container. We **share your entire HOME inside the container as the HOME of the mirror user in the container**. We also provide this account with `sudo` privileges.

``` bash
$> ./create_container.sh
```

Now you can connect to the newly created container with:

``` bash
$> ./connect_to_container.sh
```

You can now download and install Dyna&omega;o were you want to on your system, your home folder has been shared inside the container as the home folder of the user in the container (user with the same name uid and gid as you). For this you can use the script provided in the container and launch, we call MY_DYNAWO_PATH the path were you want to install Dyna&omega;o on your machine:

``` bash
your_user_name@contaiderID:~$> /opt/install_dynawo.sh --prefix MY_DYNAWO_PATH
```

At the end of the script Dyna&omega;o source code is available on your machine and has been fully compiled, you can then launch:

``` bash
your_user_name@contaiderID:MY_DYNAWO_PATH/dynawo$> dynawo nrt
your_user_name@contaiderID:MY_DYNAWO_PATH/dynawo$> dynawo help
```

### From Docker Hub

The Developers image is built on Docker Hub and you can use it like this (replace MY_FOLDER below):

``` bash
$> docker run -it -d --name=dynawo-dev -v MY_FOLDER:/home/dynawo_developer/dynawo dynawo/dynawo-dev
$> LOCAL_USER_ID=`id -u $USER`
$> LOCAL_GROUP_ID=`id -g $USER`
$> docker exec dynawo-dev usermod -u $LOCAL_USER_ID dynawo_developer
$> docker exec dynawo groupmod -o -g $LOCAL_GROUP_ID dynawo_developer || usermod -g $LOCAL_GROUP_ID dynawo_developer || usermod -a -G $LOCAL_GROUP_ID dynawo_developer
$> docker exec dynawo-dev chown -R dynawo_developer:dynawo_developer /home/dynawo_developer
$> docker exec -u dynawo_developer -it dynawo-dev bash
dynawo_developer@dynawo-dev $> /opt/install_dynawo.sh --prefix /home/dynawo_developer/dynawo
```

### Windows Desktop CE for Windows

This time you need to launch a Windows command line interpreter. You also need to have [Git for Windows](https://git-scm.com/download/win) installed to first checkout this repository. Then execute the following commands to create the image and a container:

``` bash
> cd PATH_TO_THIS_REPOSITORY/Developers
> docker build docker build -t dynawo-dev --no-cache .
> docker run -it --name=dynawo-dev -v c:/Users/myName:/home/dynawo_developer dynawo-dev
```

You need to enable sharing of your C drive, follow official instructions [here](https://docs.docker.com/docker-for-windows/#shared-drives-on-demand). Inside the container we created a user named dynawo_developer. You can then install Dyna&omega;o inside the container with the following command:

``` bash
dynawo_developer@contaiderID:~$> /opt/install_dynawo.sh --prefix MY_DYNAWO_PATH
```

For **MacOS** or **Windows** users we recommend using this solution as no toolchain is provided to compile Dyna&omega;o natively on those OS. In this approach the Docker container is used as a substitute bash, with Linux compiler, to compile the code while still being able to edit Dyna&omega;o source code natively on your machine with your favorite IDE. We also warn about the resources you allowed to the Docker deamon as it could result in very slow compilation or even failures, if it occurs we recommend to increase CPU and RAM allowed to Docker in the settings.

<a name="license"></a>
## License

Dyna&omega;o is licensed under the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, you can obtain one at http://mozilla.org/MPL/2.0. You can also see the [LICENSE](https://github.com/dynawo/dynawo-docker/blob/master/LICENSE.txt) file for more information.

See [here](https://github.com/dynawo/dynawo#license) for external libraries licenses.

<a name="maintainers"></a>
## Maintainers

Dyna&omega;o is currently maintained by people at RTE, in case of questions or issues, you can also send an e-mail to [rte-dynawo@rte-france.com](mailto:rte-dynawo@rte-france.com).

<a name="links"></a>
## Links

For more information about Dyna&omega;o:

* Consult [Dyna&omega;o website](http://dynawo.org)
* Contact us at [rte-dynawo@rte-france.com](mailto:rte-dynawo@rte-france.com)
