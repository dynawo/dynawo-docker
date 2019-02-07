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

This repository contains Dyna&omega;o's Docker images.

## Table of Contents

- [About this repository](#about)
- [Users image](#users)
- [Soon available](#soon)
- [License](#license)
- [Maintainers](#maintainers)
- [Links](#links)

<a name="about"></a>
## About this repository

**Dyna&omega;o is an open source time domain simulation tool for power systems using the Modelica language. It aims at providing power system stakeholders with a transparent, flexible, interoperable and robust simulation tool that could ease collaboration and cooperation in the power system community**.
To achieve this goal, Dyna&omega;o is based on two mains principles: the use of a high-level modeling language Modelica and a strict separation between modeling and solving parts.

We provide this repository to ease users with [Dyna&omega;o' installation](https://github.com/dynawo/dynawo#build) and provide a quick way to try the simulation tool.

<a name="users"></a>
## Users image

Under the [Users](Users) folder we provide a Dockerfile to build an image integrating the latest Dyna&omega;o version. The user can launch the following commands to build the image, create the Docker container and connect to it.

``` bash
$> git clone https://github.com/dynawo/dynawo-docker.git dynawo-docker
$> cd Users
$> ./build_image.sh
$> ./create_container.sh
$> ./connect_to_container.sh
```

On inside the user can use the `dynawo` alias inside the container and launch:

``` bash
$> dynawo nrt
```

This image will soon be available on [Docker Hub](https://hub.docker.com).

<a name="soon"></a>
## Soon available

We will soon provide an image for developers, especially those on **MacOS** or **Windows** not enabled to compile the code on their machine for the moment. This image will provide developers a way to have a complete environment to compile the code 

<a name="license"></a>
## License

Dyna&omega;o is licensed under the terms of the Mozilla Public License, v. 2.0. If a copy of the MPL was not distributed with this file, you can obtain one at http://mozilla.org/MPL/2.0. You can also see the [LICENSE](LICENSE.txt) file for more information.

See [here](https://github.com/dynawo/dynawo#license) for external libraries licenses.

<a name="maintainers"></a>
## Maintainers

Dyna&omega;o is currently maintained by people at RTE, in case of questions or issues, you can also send an e-mail to [rte-des-simulation-dynamique@rte-france.com](mailto:rte-des-simulation-dynamique@rte-france.com).

<a name="links"></a>
## Links

For more information about Dyna&omega;o:

* Consult [Dyna&omega;o website](https://dynawo.github.io/)
* Contact us at [rte-des-simulation-dynamique@rte-france.com](mailto:rte-des-simulation-dynamique@rte-france.com)
