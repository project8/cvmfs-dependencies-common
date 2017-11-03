#!/bin/bash

source ${P8DEPBASEDIR}/setup.sh

cd ${P8DEPBASEDIR}/src/
pwd

#echo "Environment variables:"
#env
echo "where are we?"
pwd

#######################################################################
#
# build all dependencies from source
#
########################################################################


echo "Environment variables after installing python:"
env
echo `which python`
echo `python -V`
echo `gcc --version`
echo `python --version`
echo `which cc`
echo `which g++`
echo `which ld`
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo "LIBRARY_PATH: $LIBRARY_PATH"
echo "LIBDIR: $LIBDIR"
echo "PYTHONPATH: $PYTHONPATH"
echo "Library search path:"
echo `ldconfig -v 2>/dev/null | grep -v ^$'\t'`

# ROOT
echo 'ROOT'
cd root/
mkdir -p my_build
cd my_build
cmake -D CMAKE_INSTALL_PREFIX:PATH=${P8DEPBASEDIR} -D CMAKE_INSTALL_BINDIR:PATH=${P8DEPBASEDIR}/bin -D CMAKE_INSTALL_LIBDIR:PATH=${P8DEPBASEDIR}/lib -D CMAKE_INSTALL_INCLUDEDIR:PATH=${P8DEPBASEDIR}/include -D gnuinstall=ON -D roofit=ON  -D builtin_gsl=ON ..  | tee config_log.txt
make -j3                            | tee make_log.txt
make -j3 install                    | tee make_install_log.txt
cd ../..

# Clean up the source directory
pwd
rm -rf *
