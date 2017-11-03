FROM project8/cvmfs-dependencies-set1:build-2017-10-18

ADD ./dependency_urls.txt /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/dependency_urls_set2.txt
ADD ./download_pkg.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg_set2.sh
ADD ./install.sh /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install_set2.sh

RUN source /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/setup.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/download_pkg_set2.sh && \
    /cvmfs/hep.pnnl.gov/project8/dependencies/${P8DEPBUILD}/install_set2.sh
