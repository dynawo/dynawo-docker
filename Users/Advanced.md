The major drawback of running the official Dyna&omega;o container with the command `docker run -it dynawo/dynawo` is everything you do is inside the container. New test cases created inside would not be shared with your own machine or test cases created own your own machine would not be accessible in the container. In the following we will describe multiple ways to exchange data between the container and your host machine.

# Docker cp

Docker provides a native way to copy back and forth folders from your host machine to a docker container. Remember that inside the container your are logged by default as `dynawo_user`. You can run the following commands:
``` bash
$> docker run -it -d --name dynawo_container dynawo/dynawo
$> docker cp MyFolder dynawo_container:/home/dynawo_user/
$> docker cp dynawo_container:/home/dynawo_user/MyFolder ~
```

Then inside the container:
``` bash
$> docker exec -it dynawo_container bash
dynawo_user@contaiderID:dynawo$> ls ~
dynawo MyFolder
```

And on your host machine:
``` bash
$> ls ~
... MyFolder ...
```

# Partial solution to see folders inside container

A simple solution to see directly folders of your host machine inside your Docker container:

``` bash
$> docker run -it -v $PWD:/home/dynawo_user/dynawo/SharedFolder -e USERID=$UID --name dynawo_container dynawo/dynawo
dynawo_user@contaiderID:dynawo$> ls

AUTHORS.txt  CODE_OF_CONDUCT  cpplint  CPPLINT.cfg  dynawo  install  LICENSE.txt  myEnvDynawo.sh  nrt  OpenModelica  README.md SharedFolder util

dynawo_user@contaiderID:dynawo$> cd SharedFolder
dynawo_user@contaiderID:dynawo$> ls

... what is inside your folder ...
```

The drawback of this solution is that you can see the files of your host machine but not modify them or create new files in the folder because `dynawo_user` does not have the same UID as your account on your own machine (or if it has it would be luck). Then you can copy the folder inside the container at another location and this time you can modify it:

``` bash
dynawo_user@contaiderID:dynawo$> cp SharedFolder ~
dynawo_user@contaiderID:dynawo$> cd ~
dynawo_user@contaiderID:~$> ls

dynawo SharedFolder
```
This SharedFolder at the root of your container can now be modified inside the container.

# Full solution to see and modify files inside and outside container

This time we will first create the container in a detached mode with the `root` user while sharing your folder inside the `dynawo_user` folder. Then we update the UID and GID of `dynawo_user` to be able to see and modify files of your host machine inside the container.

``` bash
$> docker run -u root -it -d -v $PWD:/home/dynawo_user/dynawo/SharedFolder --name dynawo_container dynawo/dynawo
$> docker exec -u root dynawo_container bash -c "usermod -u $UID dynawo_user"
$> docker exec -u root dynawo_container bash -c "groupmod -g $GID dynawo_user"
$> docker exec -it -u dynawo_user dynawo_container bash
dynawo_user@contaiderID:dynawo$> ls
... SharedFolder ...
```

And this time the files in SharedFolder can directly be modified inside the container and you can even create new ones. The new files will also be available on your host machine and from your machine you will have the right to modify them because they were created this time with the same UID and GID as your account on your machine.

**Warning** The reason why we provide `dynawo_user` inside the container is that for safety reasons Docker advise to never run a container as the `root` user.

You can always log as the `root` user in the container to install new packages for example:

``` bash
$> docker exec -u root -it dynawo_container bash
root@contaiderID:dynawo#> dnf install ...
```

# Scp solution in container

In the container you can also you use scp to send files to your host machine:
``` bash
$> ip a | grep -w inet | grep -v 127.0.0.1
...
inet 192.168.0.10  netmask 255.255.255.0 broadcast 192.168.0.255
...
$> docker exec -it -u dynawo_user dynawo_container bash
dynawo_user@contaiderID:dynawo$> scp test.txt my_user_name@192.168.0.10:/home/my_user_name/
```
