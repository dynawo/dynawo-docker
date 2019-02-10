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
# Dyna&omega;o - An hybrid C++/Modelica time-domain simulation tool for power systems - Docker Images
[![MPL-2.0 License](https://img.shields.io/badge/license-MPL_2.0-blue.svg)](https://www.mozilla.org/en-US/MPL/2.0/)

This repository contains Dyna&omega;o's Docker images.

## Table of Contents

- [About this repository](#about)
- [User image](#users)
- [Developer Image](#developer)
- [License](#license)
- [Maintainers](#maintainers)
- [Links](#links)

<a name="about"></a>
## About this repository

**Dyna&omega;o is an open source time domain simulation tool for power systems using the Modelica language. It aims at providing power system stakeholders with a transparent, flexible, interoperable and robust simulation tool that could ease collaboration and cooperation in the power system community**.
To achieve this goal, Dyna&omega;o is based on two mains principles: the use of a high-level modeling language Modelica and a strict separation between modeling and solving parts.

We provide this repository to ease users with [Dyna&omega;o' installation](https://github.com/dynawo/dynawo#build) and provide a quick way to try the simulation tool.

<a name="users"></a>
## User image

Under the [Users](https://github.com/dynawo/dynawo-docker/tree/master/Users) folder we provide a Dockerfile to build an image integrating the latest Dyna&omega;o version. The user can launch the following commands to build the image, create the Docker container and connect to it.

``` bash
$> git clone https://github.com/dynawo/dynawo-docker.git dynawo-docker
$> cd dynawo-docker/Users
$> ./build_image.sh
$> ./create_container.sh
$> ./connect_to_container.sh
```

Once inside the container the user can use the `dynawo` alias and launch:

``` bash
$> dynawo nrt
```

This image is also available on [Docker Hub](https://hub.docker.com/r/dynawo/dynawo). Then if you already have docker installed on your machine you can directly execute the following command:
``` bash
docker run -it dynawo/dynawo
```

If you want to share your current directory you can launch:
``` bash
docker run -it -v $PWD:/home/dynawo_user/dynawo/SharedFolder dynawo/dynawo
```

**Warning** You will be able to see the files in SharedFolder but not modify them or create new one from inside the container. If you want to create or modify files you should do it from your own machine. You can then use `cp -r SharedFolder ~` in the container to use it. The reason is that inside the container you are connected as dynawo_user which would not have the same Linux ID as you hence not the right to read your files. If you want you can always connect as root in the container you created with:

```bash
docker exec -it -u root CONTAINER_NAME bash
```

Inside the container you can then launch as before:
``` bash
$> dynawo nrt
```

<a name="developer"></a>
## Developer Image

Under the [Developer](https://github.com/dynawo/dynawo-docker/tree/master/Developer) folder we provide a Dockerfile to build an image containing all necessary tools to compile Dyna&omega;o. This time the approach is to store the sources on your machine, so that you can use your favorite IDE to develop, and use the container to compile the code. First you have to build an image with the following commands:

``` bash
$> git clone https://github.com/dynawo/dynawo-docker.git dynawo-docker
$> cd dynawo-docker/Developer
$> ./build_image.sh
```

Then you need to create the container, this time we create a mirror user of you inside the container to be able to access files inside and outside the container. We also provide this account with `sudo` privileges.

``` bash
$> ./create_container.sh
```

Now you can connect to the newly created container with:

``` bash
$> ./connect_to_container.sh
```

You can now download and install Dyna&omega;o were you want to on your system, your home folder has been shared inside the container as the home folder of the user in the container (user with the same name uid and gid as you). For this you can use the script provided in the container and launch:

``` bash
$> cd /path/on/your/system/where/you/want/dynawo
$> /opt/install_dynawo.sh
```

At the end of the script Dyna&omega;o source code is available on your machine and has been fully compiled, you can then launch:

``` bash
$> ./myEnvDynawo.sh nrt
$> ./myEnvDynawo.sh help
```

For **MacOS** or **Windows** users we recommend using this solution as no toolchain is provided to compile Dyna&omega;o natively on those OS. In this approach the Docker container is used as a substitute bash, with Linux compiler, to compile the code while still being able to edit Dyna&omega;o source code natively on your machine with your favorite IDE.

<a name="license"></a>
## License

Dyna&omega;o is licensed under the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, you can obtain one at http://mozilla.org/MPL/2.0. You can also see the [LICENSE](https://github.com/dynawo/dynawo-docker/blob/master/LICENSE.txt) file for more information.

See [here](https://github.com/dynawo/dynawo#license) for external libraries licenses.

<a name="maintainers"></a>
## Maintainers

Dyna&omega;o is currently maintained by people at RTE, in case of questions or issues, you can also send an e-mail to [rte-des-simulation-dynamique@rte-france.com](mailto:rte-des-simulation-dynamique@rte-france.com).

<a name="links"></a>
## Links

For more information about Dyna&omega;o:

* Consult [Dyna&omega;o website](https://dynawo.github.io/)
* Contact us at [rte-des-simulation-dynamique@rte-france.com](mailto:rte-des-simulation-dynamique@rte-france.com)
