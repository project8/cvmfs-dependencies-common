# Project 8 CVMFS Dependencies

This repository can be used in two ways:

1. To install on the actual CVMFS system, use the `run-cvmfs-install.sh` script
1. To use the docker mockup CVMFS system, use the Dockerfile

When updating the dependencies build on GitHub, please make sure that both `run-cvmfs-install.sh` and `Dockerfile` get updated.  When a new official build is ready, tag it with the build name (the same as the build directory)

## Information

This repository provides the basic dependencies for Project 8 software installations on the CVMFS system used on the PNNL HEP cluster.

It's based on the PNNL HEP osg-compute-stable image (https://hub.docker.com/r/pnnlhep/osg-compute-stable), which is based on CentOS 6.7 (as of this writing).

Project 8 software is installed in the `/cvmfs/hep.pnnl.gov/project8` directory.  From there, installed dependencies go in the `dependencies-common` subdirectory.  For any images based on this image, their software should go in their own directories to avoid issues with directory names that change as builds are updated.  For example:

```
/cvmfs/hep.pnnl.gov/project8
   |
   +- dependencies-common
   |     |
   |     +- build-04-10-2017
   |           |
   |           +- bin, lib, include, . . .
   |
   +- dependencies-katydid
   |
   +- dependencies-morpho
   |
   +- katydid
   |
   +- morpho
   . . .
```

## Installing on the actual CVMFS system

1. Clone the `cmvfs-dependencies-common` repo
1. Make sure the dependency build version in `run-cvmfs-install.sh` (variable `P8DEPBUILD`) is set correctly
1. Comment out the command `source /opt/rh/devtoolset-3/enable` in the `setup.sh` file (used in Docker)
1. Execute `run-cvmfs-install.sh`

## Using the Docker mockup of the CVMFS system

1. Clone the `cmvfs-dependencies-common` repo
1. Make sure the dependency build version in `Dockerfile` and `setup.sh` (variable `P8DEPBUILD`) is set correctly
1. Execute `docker build -t project8/cvmfs-dependencies-common .`

### Updating a dependency

Your situation: There's a new version of a dependency (e.g. boost) out that we need to use for one of our packages.  Here's how to update this image with the new dependency information and rebuild the container.

1. Update the URL with the new dependency version in dependency_urls.txt
1. Update the corresponding file and directory names in download_pkg.sh
1. Update the build date in Dockerfile (environment variable `P8DEPBUILD`)
1. Test the build locally
1. If the build works, push the changes to the CVMFS-dependencies-common repo
1. As this image is very long to build, use the instructions [here](https://ropenscilabs.github.io/r-docker-tutorial/04-Dockerhub.html) to push the newly created image to Docker Hub.
    1. Get the image hash using `docker images`
    1. Tag the new image: `docker tag <image_hash> project8/cvmfs-dependencies-common:build-<yyyy>-<mm>-<dd>`
    1. Push the image: `docker project8/cvmfs-dependencies-common`
