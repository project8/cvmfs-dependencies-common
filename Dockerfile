FROM project8/p8compute_bare as gcc-base

# get gcc from package manager
##    yum -y --enablerepo=centos-sclo-rh-testing install \
RUN yum -y install centos-release-scl-rh &&\
    yum -y install \
        devtoolset-7-gcc-c++ \
        zlib-devel \
        perl-devel \
        gettext-devel &&\
    yum -y install wget
#COPY ./scl_enable /usr/local/src/scl_enable
#ENV BASH_ENV=/usr/local/src/scl_enable \
#    ENV=/usr/local/src/scl_enable \
#    PROMPT_COMMAND=". /usr/local/src/scl_enable"


##########################
FROM gcc-base as common

RUN mkdir -p /tmp_install

#COPY ./setup.sh /tmp_install/setup.sh
#COPY ./dependency_urls.txt /tmp_install/dependency_urls.txt
#COPY ./download_pkg.sh /tmp_install/download_pkg.sh
#COPY ./install.sh /tmp_install/install.sh
#COPY ./run-cvmfs-install.sh /tmp_install/run-cvmfs-install.sh
#COPY ./cleanup.sh /tmp_install/cleanup.sh

#RUN /bin/true &&\
#    source /usr/local/src/scl_enable &&\
    #cd /tmp_install && \
    ##source /opt/rh/devtoolset-3/enable && \
    ##scl enable devtoolset-6
    #/tmp_install/run-cvmfs-install.sh && \
    #/tmp_install/cleanup.sh && \
    #rm -rf /tmp_install &&\
#    /bin/true

ENV BUILD_PREFIX=/usr/local/p8/common-2018-11-01
RUN mkdir -p $BUILD_PREFIX && \
    ln -s $BUILD_PREFIX $BUILD_PREFIX/../common

##########################
FROM common as cmake_done

## cmake (install manually because the version in yum is too old, v2.8.12)
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz &&\
    tar -xvzf cmake-3.4.3.tar.gz &&\
    cd cmake-3.4.3 &&\
    ./configure --prefix=$BUILD_PREFIX &&\
    make -j3 install &&\
    /bin/true

##########################
FROM common as git_done

## git (install manually because the version in yum is too old)
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.9.5.tar.gz &&\
    tar -xvzf git-2.9.5.tar.gz &&\
    cd git-2.9.5 &&\
    ./configure --prefix=$BUILD_PREFIX &&\
    make -j3 install &&\
    /bin/true
   
##########################
FROM common as python_done

# Python
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz &&\
    tar -xvzf Python-3.6.4.tgz &&\
    cd Python-3.6.4 &&\
    ./configure --enable-shared --prefix=$BUILD_PREFIX &&\
    make -j3 install &&\
    /bin/true

##########################
FROM common as hdf5_done

## hdf5
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.18/src/hdf5-1.8.18.tar.gz &&\
    tar -xvzf hdf5-1.8.18.tar.gz &&\
    cd hdf5-1.8.18 &&\
    ./configure --prefix=$BUILD_PREFIX &&\
    make -j3 install &&\
    /bin/true

##########################
FROM common as fftw3_done

## fftw3
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget http://www.fftw.org/fftw-3.3.4.tar.gz &&\
    tar -xvzf fftw-3.3.4.tar.gz &&\
    cd fftw-3.3.4 &&\
    ./configure --prefix=$BUILD_PREFIX --enable-shared --enable-threads --with-pic &&\
    make -j3 install &&\
    /bin/true

##########################
FROM hdf5_done as matio_done

COPY --from=hdf5_done $BUILD_PREFIX $BUILD_PREFIX

## matio
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget http://sourceforge.net/projects/matio/files/matio/1.5.2/matio-1.5.2.tar.gz &&\
    tar -xvzf matio-1.5.2.tar.gz &&\
    cd hdf5-1.8.18 &&\
    ./configure --prefix=$BUILD_PREFIX --with-hdf5=$BUILD_PREFIX &&\
    make -j3 install &&\
    /bin/true

##########################
FROM common as boost_done

## boost
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget -O boost-1.59.0.tgz http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz/download &&\
    tar -xvzf boost-1.59.0.tgz &&\
    cd boost_1_59_0 &&\
    ./bootstrap.sh --prefix=$BUILD_PREFIX --with-libraries=date_time,filesystem,program_options,system,thread,chrono &&\
    ./b2 &&\
    ./b2 install &&\
    /bin/true

##########################
FROM common as root_done

COPY --from=cmake_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=python_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=hdf5_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=fftw3_done $BUILD_PREFIX $BUILD_PREFIX

## root
RUN source scl_source enable devtoolset-7 &&\
    cd /tmp_install &&\
    wget https://root.cern.ch/download/root_v6.13.02.source.tar.gz &&\
    tar -xvzf root_v6.13.02.source.tar.gz &&\
    cd root-6.13.02 &&\
    mkdir my_build &&\
    cd my_build &&\
    cmake -D CMAKE_INSTALL_PREFIX:PATH=$BUILD_PREFIX \
            -D PYTHON_EXECUTABLE=${BUILD_PREFIX}/bin/python3 \
            -D gnuinstall=ON -D roofit=ON  -D builtin_gsl=ON .. &&\
    make -j3 install &&\
    /bin/true

########################
FROM gcc-base

ENV BUILD_PREFIX=/usr/local/p8/common-2018-11-01

COPY --from=common $BUILD_PREFIX $BUILD_PREFIX
COPY --from=cmake_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=git_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=python_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=hdf5_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=fftw3_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=matio_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=boost_done $BUILD_PREFIX $BUILD_PREFIX
COPY --from=root_done $BUILD_PREFIX $BUILD_PREFIX

