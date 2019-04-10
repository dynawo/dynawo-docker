# Build User image from sources

## Linux, Unix, Docker Toolbox

A user can also build the image from sources and launch the following commands to build it, create the Docker container and connect to it.

``` bash
$> git clone https://github.com/dynawo/dynawo-docker.git dynawo-docker
$> cd dynawo-docker/Users
$> ./build_docker_image.sh
$> ./create_container.sh
$> ./connect_to_container.sh
```

Inside the container you can then launch as before:

``` bash
dynawo_user@contaiderID:dynawo$> dynawo nrt
```

We provide several scripts to handle Docker routines. You can find out more information on those scripts by launching:
``` bash
$> ./script_name.sh --help
```

## Docker Desktop for Windows

Launch a Windows command line interpreter. Clone this repository and go to the `Users` folder. You can build and create a container with the following commands:

``` bash
> docker build -t dynawo --no-cache=true .
> docker run -it dynawo
```
