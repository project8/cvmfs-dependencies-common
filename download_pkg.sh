#!/bin/bash

source /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/setup.sh

########################################################################
#
# collect source distributions for all dependencies
#
########################################################################

# get into the parent directory for all the source code and build proucts
cd ${P8DEPBASEDIR}
mkdir src
cd src/
pwd


# download current (on 2015/09/16) versions of all dependencies
echo "Downloading source files"
wget --input-file=${P8DEPBASEDIR}/dependency_urls.txt --output-file=wget_log.txt --tries=3
echo "Download: complete!"
cat wget_log.txt
ls

# unpack, unzip, detar or whatever...
tar -xf Python-3.6.4.tgz             # python
ln -s Python-3.6.4 python

gunzip cmake-3.4.3.tar.gz             # cmake
tar -xf cmake-3.4.3.tar
ln -s cmake-3.4.3 cmake

gunzip hdf5-1.8.18.tar.gz             # hdf5
tar -xf hdf5-1.8.18.tar
ln -s hdf5-1.8.18 hdf5

gunzip fftw-3.3.4.tar.gz              # fftw
tar -xf fftw-3.3.4.tar
ln -s fftw-3.3.4 fftw

gunzip matio-1.5.2.tar.gz             # matio
tar -xf matio-1.5.2.tar
ln -s matio-1.5.2 matio

mv download boost_1_59_0.tar.gz       # boost
gunzip boost_1_59_0.tar.gz
tar -xf boost_1_59_0.tar
ln -s boost_1_59_0 boost

gunzip root_v6.13.02.source.tar.gz    # root
tar -xf root_v6.13.02.source.tar
ln -s root-6.13.02 root
