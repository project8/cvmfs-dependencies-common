FROM centos:6.10

# get gcc from package manager
RUN yum -y install centos-release-scl-rh &&\
    yum -y --enablerepo=centos-sclo-rh-testing install devtoolset-6-gcc &&\
    yum -y install wget
COPY ./scl_enable /usr/local/src/scl_enable
ENV BASH_ENV=/usr/local/src/scl_enable \
    ENV=/usr/local/src/scl_enable \
    PROMPT_COMMAND=". /usr/local/src/scl_enable"

RUN mkdir -p /tmp_install

COPY ./setup.sh /tmp_install/setup.sh
#COPY ./dependency_urls.txt /tmp_install/dependency_urls.txt
#COPY ./download_pkg.sh /tmp_install/download_pkg.sh
COPY ./install.sh /tmp_install/install.sh
COPY ./run-cvmfs-install.sh /tmp_install/run-cvmfs-install.sh
COPY ./cleanup.sh /tmp_install/cleanup.sh

RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    #cd /tmp_install && \
    ##source /opt/rh/devtoolset-3/enable && \
    ##scl enable devtoolset-6
    #/tmp_install/run-cvmfs-install.sh && \
    #/tmp_install/cleanup.sh && \
    #rm -rf /tmp_install &&\
    /bin/true

# Python
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz &&\
    tar -xvzf Python-3.6.4.tgz &&\
    /bin/true

# cmake
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz &&\
    tar -xvzf cmake-3.4.3.tar.gz &&\
    /bin/true

# hdf5
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.18/src/hdf5-1.8.18.tar.gz &&\
    tar -xvzf hdf5-1.8.18.tar.gz &&\
    /bin/true

# fftw3
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget http://www.fftw.org/fftw-3.3.4.tar.gz &&\
    tar -xvzf fftw-3.3.4.tar.gz &&\
    /bin/true

# matio
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget http://sourceforge.net/projects/matio/files/matio/1.5.2/matio-1.5.2.tar.gz &&\
    tar -xvzf matio-1.5.2.tar.gz &&\
    /bin/true

# boost
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget -O boost-1.59.0.tgz http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz/download &&\
    tar -xvzf boost-1.59.0.tgz &&\
    /bin/true

# root
RUN source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    wget https://root.cern.ch/download/root_v6.13.02.source.tar.gz &&\
    tar -xvzf root_v6.13.02.source.tar.gz &&\
    /bin/true
