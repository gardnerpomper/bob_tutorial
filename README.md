# BoB - docker container to run the tutorial

Once you have docker installed, you can build and run this image to get
a standard environment we can all run in.

## Install docker

This depends on your host OS. Check [Docker Installation](https://docs.docker.com/installation) and follow the directions.

## Steps to build the container

### build the image

Build the image in the directory containing the Dockerfile

    docker build -t bob .

### start the container

it is best to run as a daemon (-d) and connect to it later. Also, the -t is required
to provide the tty which sudo requires.

    cd <directory above 100517_BoB_for_NGIC>
    docker run -dt  --name bob -v $PWD:/vol bob

to confirm it is running:

    docker ps

if you don't see it listed:

    docker logs bob

### connect as the dev user

The "-u dev" logs you in as the dev user, which should now have the same uid as the
owner of the directory on the host. If you leave off the "-u dev", you will be logged
in as the root user inside the container.

    docker exec -it -u dev -v $PWD:/vol bob tcsh

### When done, delete the container

You can connect multiple times to the container. When you are done running, you can
delete the container. When you do that, everything in the container goes away, so
if you have any results you created under the dev users home directory, make sure
you copy them out to /vol first.

    docker stop bob; docker rm bob

## Running the tutorial

If you did the docker exec in the directory that contains the 100517\_BoB\_for\_NGIC subdirectory, you should see a prompt something like this:

    [dev@05be301dd00b /vol]$

The tutorial steps can be followed exactly, until you are supposed to create the example_1 subdirectory of your home directory. For some reason, you will get a permission denied. I haven't been able to figure out why. You can work around it like this:

    [dev@05be301dd00b /vol]$ cd
    [dev@05be301dd00b ~]$ sudo mkdir example_1
    [dev@05be301dd00b ~]$ sudo chown dev:dev example_1
    [dev@05be301dd00b ~]$ cd example_1
    [dev@05be301dd00b ~/example_1]$

This is the only glitch I have found so far where the docker container deviates from expected behaviour

