# Project 8 CVMFS Dependencies

## Information

This repository provides the basic dependencies for Project 8 software installations on the CVMFS system used on the PNNL HEP cluster.

It's based on the PNNL HEP osg-comput-stable image, which is based on CentOS 6.7 (as of this writing).

Project 8 software is installed in the `/cvmfs/hep.pnnl.gov/project8` directory.  From there, installed dependencies go in the `dependencies` subdirectory.  For any images based on this image, their software should go in their own directories to avoid issues with directory names that change as builds are updated.  For example:

```
/cvmfs/hep.pnnl.gov/project8
   |
   +- dependencies
   |     |
   |     +- latest --> build-04-10-2017
   |     |
   |     +- build-04-10-2017
   |           |
   |           +- bin, lib, include, . . .
   |           |
   |           +- cmake-3.4.3
   |           . . .
   |
   +- dependencies-py
   |
   +- katydid
   |
   +- morpho
   . . .
```

## Updating a dependency

Your situation: There's a new version of a dependency (e.g. boost) out that we need to use for one of our packages.  Here's how to update this image with the new dependency information and rebuild the container.

1. Update the URL with the new dependency version in dependency_urls.txt
1. Update the corresponding file and directory names in download_pkg.sh
1. Update the build date in Dockerfile (environment variable `P8DEPBUILD`)
1. Test the build locally
1. If the build works, push the changes to the Ladybug repo
1. On the Docker Hub page for the `project8/cvmfs-dependencies` image, go to Build Settings
1. Update the date in the Docker Tag Name column of the second container build
1. Trigger a rebuild of both containers (`latest` and `build-[date]`)
1. If the rebuild works, and the rebuild of anything that depends on this image works, notify the DIRAC team of the changes that need to be pushed to CVMFS, providing them with the appropriate tag name
1. Proceed with updating any downstream images that use the `cvmfs-dependencies` image
