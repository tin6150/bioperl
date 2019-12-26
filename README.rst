BioPerl
-------

This project 
( https://github.com/tin6150/bioperl.git )
is the containerization of BioPerl (from cpan)
Mostly to serve as base for other project needing bioperl (eg Metabolic).

Two versions are available

  - Centos 8.x base   + CPAN BioPerl
  - Ubuntu 19.04 base + CPAN BioPerl

Available as docker container and Singularity 3.2 container.


Starting the container
======================

::

	singularity pull --name bioperl.sif shub://tin6150/bioperl
	./bioperl.sif
	-or-
	sudo docker run  -it -v $HOME:/home tin6150/bioperl

The above commands will drop you into a shell inside the container, 
whereby perl programs needing bioperl cpan modules can be run.
Host system need to have Singularity 3.2 installed.

REMEMBER: content stored INSIDE the container is ephemeral and lost when container is restarted.  Save your data to a mounted volume shared with the host, eg $HOME



Container links
===============

* https://hub.docker.com/repository/docker/tin6150/bioperl-centos-8 # cloud build
* https://hub.docker.com/repository/docker/tin6150/bioperl          # local build + push
* https://singularity-hub.org/collections/3948                      # only centos-8 version for now


Build Commands
==============

::

        docker build -t tin6150/bioperl-ubuntu-1904 -t tin6150/bioperl  -f Dockerfile.bioperl-ubuntu-1904 .  | tee LOG.bioperl-ubuntu-1905.txt
        docker build -t tin6150/bioperl-centos-8                        -f Dockerfile.bioperl-centos-8    .  | tee LOG.bioperl-centos-8.txt
        docker build -t tin6150/bioperl-centos-7                        -f Dockerfile.bioperl-centos-7    .  | tee LOG.bioperl-centos-7.txt

        THEN
        sudo singularity build --writable bioperl-centos-8.sif Singularity 2>&1  | tee LOG.singularity_build.txt



Debug runs/tests
================

::

        docker run  -it -v $HOME:/home/tin tin6150/bioperl
        docker exec -it uranus_hertz bash                   # additional terminal into existing running container


