#!/bin/bash

# specify the version of dependencies
#export P8DEPBUILD=build-2018-04-12

# get the location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# call the setup script to establish all necessary environment variables
source ${SCRIPT_DIR}/setup.sh

# make the dependencies-common build directory
mkdir -p /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}

# copy in the necessary scripts to their final locations
cp ${SCRIPT_DIR}/setup.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/setup.sh
cp ${SCRIPT_DIR}/dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/dependency_urls.txt
cp ${SCRIPT_DIR}/download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/download_pkg.sh
cp ${SCRIPT_DIR}/install.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/install.sh

# run the download and install scripts
/cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/download_pkg.sh
/cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/install.sh
