FROM pnnlhep/osg-compute-stable

ENV P8DEPBUILD=build-2018-03-29

RUN yum -y --disableplugin=fastestmirror --enablerepo=extras install centos-release-SCL && \
    yum -y --disableplugin=fastestmirror --enablerepo=extras install devtoolset-3-gcc-c++ && \
    yum clean all

RUN mkdir -p /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}

ADD ./setup.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/setup.sh
ADD ./dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/dependency_urls.txt
ADD ./download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/download_pkg.sh
ADD ./install.sh /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/install.sh

RUN source /opt/rh/devtoolset-3/enable && \
    source /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/setup.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/download_pkg.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies-common/${P8DEPBUILD}/install.sh
