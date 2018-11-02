#FROM pnnlhep/osg-compute-stable
FROM centos:6.10

RUN yum -y install centos-release-scl-rh &&\
    yum -y --enablerepo=centos-sclo-rh-testing install devtoolset-6-gcc &&\
    yum -y install wget

COPY ./scl_enable /usr/local/src/scl_enable

ENV BASH_ENV=/usr/local/src/scl_enable \
    ENV=/usr/local/src/scl_enable \
    PROMPT_COMMAND=". /usr/local/src/scl_enable"

#RUN yum -y --disableplugin=fastestmirror --enablerepo=extras install centos-release-SCL && \
#    yum -y --disableplugin=fastestmirror --enablerepo=extras install devtoolset-3-gcc-c++ && \
#    yum clean all

RUN mkdir -p /tmp_install

COPY ./setup.sh /tmp_install/setup.sh
COPY ./dependency_urls.txt /tmp_install/dependency_urls.txt
COPY ./download_pkg.sh /tmp_install/download_pkg.sh
COPY ./install.sh /tmp_install/install.sh
COPY ./run-cvmfs-install.sh /tmp_install/run-cvmfs-install.sh
COPY ./cleanup.sh /tmp_install/cleanup.sh

RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    ###
    cd /tmp_install &&\
    # dowload everything
    #wget --input-file=dependency_urls.txt --tries=3 &&\
    ###
    #cd /tmp_install && \
    #ls && \
    ##source /opt/rh/devtoolset-3/enable && \
    ##scl enable devtoolset-6
    #/tmp_install/run-cvmfs-install.sh && \
    #/tmp_install/cleanup.sh && \
    #rm -rf /tmp_install &&\
    /bin/true

RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # Python
    wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tgz &&\
    tar -xvzf Python-3.6.4.tgz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # cmake
    wget http://www.cmake.org/files/v3.4/cmake-3.4.3.tar.gz &&\
    tar -xvzf cmake-3.4.3.tar.gz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # hdf5
    wget https://support.hdfgroup.org/ftp/HDF5/prev-releases/hdf5-1.8/hdf5-1.8.18/src/hdf5-1.8.18.tar.gz &&\
    tar -xvzf hdf5-1.8.18.tar.gz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # fftw3
    wget http://www.fftw.org/fftw-3.3.4.tar.gz &&\
    tar -xvzf fftw-3.3.4.tar.gz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # matio
    wget http://sourceforge.net/projects/matio/files/matio/1.5.2/matio-1.5.2.tar.gz &&\
    tar -xvzf matio-1.5.2.tar.gz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # boost
    wget -O boost-1.59.0.tgz http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz/download &&\
    tar -xvzf boost-1.59.0.tgz &&\
    /bin/true
RUN /bin/true &&\
    source /usr/local/src/scl_enable &&\
    cd /tmp_install &&\
    # root
    wget https://root.cern.ch/download/root_v6.13.02.source.tar.gz &&\
    tar -xvzf root-v6.13.02 &&\
    /bin/true
