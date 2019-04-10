# Share folders on Windows

The major drawback of running the official Dyna&omega;o container with the command `docker run -it dynawo/dynawo` is everything you do is inside the container. New test cases created inside would not be shared with your own machine or test cases created own your own machine would not be accessible in the container. In the following we will describe ways to exchange data between the container and your host machine.

## Docker Toolbox

For the legacy version of Docker on Windows: [Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/), launched with **Docker Quickstart Terminal**, to share the folder `C:\Users\myName\MyDynawoTest` inside a container and be able to modify files inside the container and on your own machine you can create the container with the following command:

``` bash
$> docker run -it --name dynawo_container -v /c/Users/myName/MyDynawoTest:/home/dynawo_user/SharedFolder dynawo/dynawo
```

As Docker Toolbox run inside a VM it allows you to directly use the files in and out of the container without any problem.

## Docker Desktop CE for Windows

For the official version of Docker on [Windows](https://docs.docker.com/docker-for-windows/), you can launch a Windows command line interpreter (Windows+R and then execute cmd), to share the folder `C:\Users\myName\MyDynawoTest` you can create the container with the following command:

``` bash
$> docker run -it --name dynawo_container -v c:/Users/myName/MyDynawoTest:/home/dynawo_user/SharedFolder dynawo/dynawo
```

Docker for Windows will ask you to Share your drive, you can follow official instructions [here](https://docs.docker.com/docker-for-windows/#shared-drives-on-demand).
