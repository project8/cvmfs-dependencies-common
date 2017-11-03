#!/bin/bash

source ${P8DEPBASEDIR}/setup.sh

########################################################################
#
# collect source distributions for all dependencies
#
########################################################################

# get into the parent directory for all the source code and build proucts
cd ${P8DEPBASEDIR}
cd src/
pwd


# download current (on 2015/09/16) versions of all dependencies
echo "Downloading source files"
wget --input-file=${P8DEPBASEDIR}/dependency_urls_set2.txt --output-file=wget_log.txt --tries=3
echo "Download: complete!"
cat wget_log.txt
ls

# unpack, unzip, detar or whatever...
gunzip root_v6.10.06.source.tar.gz    # root
tar -xf root_v6.10.06.source.tar
ln -s root-6.10.06 root
