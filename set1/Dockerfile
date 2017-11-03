FROM pnnlhep/osg-compute-stable

ENV P8DEPBUILD=build-2017-10-18

RUN yum -y --disableplugin=fastestmirror --enablerepo=extras install centos-release-SCL && \
    yum -y --disableplugin=fastestmirror --enablerepo=extras install devtoolset-3-gcc-c++ && \
    yum clean all

RUN mkdir -p /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}

ADD ./setup.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh
ADD ./dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/dependency_urls_set1.txt
ADD ./download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg_set1.sh
ADD ./install.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install_set1.sh

RUN source /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg_set1.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install_set1.sh
