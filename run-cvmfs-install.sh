#!/bin/bash

# get the location of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# call the setup script to establish all necessary environment variables
source ${SCRIPT_DIR}/setup.sh

# make the dependencies-common build directory
mkdir -p ${P8DEPBASEDIR}

# copy in the necessary scripts to their final locations
cp ${SCRIPT_DIR}/setup.sh ${P8DEPBASEDIR}/setup.sh
cp ${SCRIPT_DIR}/dependency_urls.txt ${P8DEPBASEDIR}/dependency_urls.txt
cp ${SCRIPT_DIR}/download_pkg.sh ${P8DEPBASEDIR}/download_pkg.sh
cp ${SCRIPT_DIR}/install.sh ${P8DEPBASEDIR}/install.sh

# run the download and install scripts
${P8DEPBASEDIR}/download_pkg.sh
${P8DEPBASEDIR}/install.sh
