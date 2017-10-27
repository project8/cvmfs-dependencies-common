
export P8BASEDIR=/cvmfs/hep.pnnl.gov/project8
export P8DEPBASEDIR=${P8BASEDIR}/dependencies/${P8DEPBUILD}

export PATH=${P8DEPBASEDIR}/bin:${PATH}
export INCLUDE_PATH=${P8DEPBASEDIR}/include:${INCLUDE_PATH}
export LIBRARY_PATH=${P8DEPBASEDIR}/lib:${LIBRARY_PATH}
export LIBRARY_PATH=${P8DEPBASEDIR}/lib64:${LIBRARY_PATH}
export LD_LIBRARY_PATH=${P8DEPBASEDIR}/lib:${LIBRARY_PATH}
export LD_LIBRARY_PATH=${P8DEPBASEDIR}/lib64:${LIBRARY_PATH}

export LIBDIR=${LD_LIBRARY_PATH}:${LIBDIR}

source /opt/rh/devtoolset-3/enable

export MANPATH=${P8DEPBASEDIR}/share/man/man1:${MANPATH}
export PKG_CONFIG_PATH=${P8DEPBASEDIR}/lib/pkgconfig:${PKG_CONFIG_PATH}

export PYTHONPATH=${P8DEPBASEDIR}/lib/root:${P8DEPBASEDIR}/lib:${P8DEPBASEDIR}:${PYTHONPATH}
export XDG_DATA_DIRS=${P8DEPBASEDIR}/share:${XDG_DATA_DIRS}

export CC=`which cc`
export CXX=`which g++`
export LD=`which ld`

if [ -e ${P8DEPBASEDIR}/bin/thisroot.sh ]; then
	source ${P8DEPBASEDIR}/bin/thisroot.sh
fi
