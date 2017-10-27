FROM pnnlhep/osg-compute-stable

ENV P8DEPBUILD=build-2017-10-18

RUN yum -y --disableplugin=fastestmirror --enablerepo=extras install centos-release-SCL && \
    yum -y --disableplugin=fastestmirror --enablerepo=extras install devtoolset-3-gcc-c++ && \
    yum -y --disableplugin=fastestmirror --enablerepo=extras install libpng-devel && \
    yum clean all
## libpng-devel is required by matplotlib

RUN mkdir -p /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD} && \
    rm -f /cvmfs/hep.pnnl.gov/project8/dependencies/latest && \
    ln -s /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD} /cvmfs/hep.pnnl.gov/project8/dependencies/latest

ADD ./setup.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh
ADD ./dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/dependency_urls.txt
ADD ./download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh
ADD ./install.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh

# sleep for 1s added to avoid weird "text file busy" error when building on docker hub
RUN chmod +x /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh && \
    chmod +x /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh && \
    sleep 1s && \
    source /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install.sh
