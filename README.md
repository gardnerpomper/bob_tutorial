# BoB - docker container to run the tutorial

Once you have docker installed, you can build and run this image to get
a standard environment we can all run in.

## Install docker

This depends on your host OS. Check [Docker Installation](https://docs.docker.com/installation) and follow the directions.

## Get the docker image

As an experiment, I posted the image I built to [Docker
Hub](https://hub.docker.com) Getting the docker container running
means either downloading the pre-built image, or just building the
image yourself. Both are pretty easy, so I don't know which is
actually better.

### Pull the docker image from docker hub

I am not sure how this works because I have not had anyone else try to
pull one of my images yet, but in theory, you just have to do this:

    docker pull gardnerpomper/bob_tutorial

If that does not work, then follow the instructions under building the image.

### Build the image

Build the image in the directory containing the Dockerfile

    docker build -t gardnerpomper/bob_tutorial .

## Get logged into the docker container

Once you have the image, you need to run it to create the
"container". Then you can log into the container and have a terminal
session that is pre-configured for the BoB tutorial.

### Create the container (i.e. run the image)

it is best to run as a daemon (-d) and connect to it later. Also, the -t is required
to provide the tty which sudo requires.

    cd <directory above 100517_BoB_for_NGIC>
    docker run -dt  --name bob -v $PWD:/vol gardnerpomper/bob_tutorial

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

