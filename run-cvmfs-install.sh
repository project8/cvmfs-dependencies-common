#!/bin/bash

# specify the version of dependencies
export P8DEPBUILD=build-2017-10-18

# get the location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

mkdir -p /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}
rm -f /cvmfs/hep.pnnl.gov/project8/dependencies/latest
ln -s /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD} /cvmfs/hep.pnnl.gov/project8/dependencies/latest

cp ${SCRIPT_DIR}/setup.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh
cp ${SCRIPT_DIR}/dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/dependency_urls.txt
cp ${SCRIPT_DIR}/download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh
cp ${SCRIPT_DIR}/install.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh

# sleep for 1s added to avoid weird "text file busy" error when building on docker hub
chmod +x /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh
chmod +x /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh
source /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh
/cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh
/cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh
