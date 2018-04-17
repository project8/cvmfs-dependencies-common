#!/bin/bash

source /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/setup.sh

# set some variables to control what gets built
print_env_then_exit=false
install_python=true
install_cmake=true
install_boost=true
install_fftw=true
install_hdf5=true
install_matio=true
install_root=true

cd ${P8DEPBASEDIR}/src/
pwd

#echo "Environment variables:"
#env
echo "where are we?"
pwd

echo "Environment variables before installing python3:"
env
echo `which python3`
echo `python3 -V`
echo `gcc --version`
echo `python3 --version`
echo `which cc`
echo `which g++`
echo `which ld`
echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
echo "LIBRARY_PATH: $LIBRARY_PATH"
echo "LIBDIR: $LIBDIR"
echo "PYTHONPATH: $PYTHONPATH"
echo "Library search path:"
echo `ldconfig -v 2>/dev/null | grep -v ^$'\t'`

if [ "$print_env_then_exit" = true ] ; then
    exit 0
fi

#######################################################################
#
# build all dependencies from source
#
########################################################################

# python3.6.4
if [ "$install_python" = true ] ; then
    echo "python"
    cd python
    ls
    ./configure --enable-shared --prefix=${P8DEPBASEDIR} | tee config_log.txt
    make -j3                                             | tee make_log.txt
    make -j3 install                                     | tee make_install_log.txt
    cd ..

    echo "Environment variables after installing python3:"
    env
    echo `which python3`
    echo `python3 -V`
    echo `gcc --version`
    echo `python3 --version`
    echo `which cc`
    echo `which g++`
    echo `which ld`
    echo "LD_LIBRARY_PATH: $LD_LIBRARY_PATH"
    echo "LIBRARY_PATH: $LIBRARY_PATH"
    echo "LIBDIR: $LIBDIR"
    echo "PYTHONPATH: $PYTHONPATH"
    echo "Library search path:"
    echo `ldconfig -v 2>/dev/null | grep -v ^$'\t'`
fi

# libpng
# echo "libpng"
# cd libpng
# ./configure --enable-shared --prefix=${P8DEPBASEDIR} | tee config_log.txt
# make -j3                                             | tee make_log.txt
# make -j3 install                                     | tee make_install_log.txt
# cd ..

# cmake
if [ "$install_cmake" = true ] ; then
    echo "cmake"
    cd cmake/
    ls
    ./configure --prefix=${P8DEPBASEDIR}      | tee config_log.txt
    make -j3                             | tee make_log.txt
    make -j3 install                     | tee make_install_log.txt
    cd ..
fi

# Boost
if [ "$install_boost" = true ] ; then
    echo 'Boost'
    cd boost/
    ./bootstrap.sh --prefix=${P8DEPKATYDIDBASEDIR} --with-libraries=date_time,filesystem,program_options,system,thread | tee bootstrap_log.txt
    ./b2                             | tee b2_log.txt
    ./b2 install                     | tee b2_install_log.txt
    cd ..
fi

# HDF5
if [ "$install_hdf5" = true ] ; then
    echo 'HDF5'
    cd hdf5/
    ./configure --prefix=${P8DEPBASEDIR} --enable-cxx --enable-shared  | tee config_log.txt
    make -j3                                                         | tee make_log.txt
    make -j3 test                                                    | tee make_test_log.txt
    make -j3 install                                                 | tee make_install_log.txt
    cd ..
fi

# FFTW
if [ "$install_fftw" = true ] ; then
    echo 'fftw'
    cd fftw/
    ./configure --prefix=${P8DEPBASEDIR} --enable-shared --enable-threads --with-pic  | tee config_log.txt
    make -j3                                                                          | tee make_log.txt
    make -j3 install                                                                  | tee make_install_log.txt
    cd ..
fi

# MATIO
if [ "$install_matio" = true ] ; then
    echo 'MATIO'
    cd matio/
    ./configure --prefix=${P8DEPBASEDIR} --with-hdf5=${P8DEPBASEDIR}  | tee config_log.txt
    make -j3                                                          | tee make_log.txt
    make -j3 install                                                  | tee make_install_log.txt
    cd ..
fi

# ROOT
if [ "$install_root" = true ] ; then
    echo 'ROOT'
    cd root/
    mkdir -p my_build
    cd my_build
    cmake -D CMAKE_INSTALL_PREFIX:PATH=${P8DEPBASEDIR} -D CMAKE_INSTALL_BINDIR:PATH=${P8DEPBASEDIR}/bin \
            -D CMAKE_INSTALL_LIBDIR:PATH=${P8DEPBASEDIR}/lib -D CMAKE_INSTALL_INCLUDEDIR:PATH=${P8DEPBASEDIR}/include \
            -D PYTHON_EXECUTABLE=${P8DEPBASEDIR}/bin/python3 \
            -D gnuinstall=ON -D roofit=ON  -D builtin_gsl=ON ..  | tee config_log.txt
    make -j3                            | tee make_log.txt
    make -j3                            | tee make_log.txt
    make -j3                            | tee make_log.txt
    make -j3 install                    | tee make_install_log.txt
    cd ../..
fi

# Clean up the source directory
pwd
rm -rf *
