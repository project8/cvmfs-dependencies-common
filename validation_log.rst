Validation Log
==============

Guidelines
----------

* All new features incorporated into a tagged release should have their validation documented.
  * Document the new feature.
  * Perform tests to validate the new feature.
  * If the feature is slated for incorporation into an official analysis, perform tests to show that the overall analysis works and benefits from this feature.
  * Indicate in this log where to find documentation of the new feature.
  * Indicate in this log what tests were performed, and where to find a writeup of the results.
* Fixes to existing features should also be validated.
  * Perform tests to show that the fix solves the problem that had been indicated.
  * Perform tests to shwo that the fix does not cause other problems.
  * Indicate in this log what tests were performed and how you know the problem was fixed.
  
Template
--------

Version: 
~~~~~~~~

Release Date: 
'''''''''''''

New Features:
'''''''''''''

* Feature 1
    * Details
* Feature 2
    * Details
  
Fixes:
''''''

* Fix 1
    * Details
* Fix 2
    * Details
  
Log
---

Version: build-2018-04-19
~~~~~~~~~~~~~~~~~~~~~~~~~

Release Date: Apr 12 2018
'''''''''''''''''''''''''

New Features:
'''''''''''''

* Updated ROOT to v6.13.02
* Use run-cvmfs-install.sh in the Docker build
* Build date now only specified in setup.sh
* Added ability to turn off builds for debugging purposes

Fixes:
''''''

* Boost build directory set to P8DEPBASEDIR
* Removed sourcing of devtools enable script in setup.sh

Version: build-2018-04-12
~~~~~~~~~~~~~~~~~~~~~~~~~

Release Date: Apr 12 2018
'''''''''''''''''''''''''

New Features:
'''''''''''''

* Adding Boost as a global dependency (needed by mermithid).
* Using run-cvmfs-install in Docker.

Version: build-2018-04-09
~~~~~~~~~~~~~~~~~~~~~~~~~

Release Date: Apr 09 2018
'''''''''''''''''''''''''

New Features:
'''''''''''''

* Switching to python 3.
* Adding this Validation Log and a software version table.

Version: build-2017-10-18
~~~~~~~~~~~~~~~~~~~~~~~~~

Release Date: Nov 8 2017
''''''''''''''''''''''''

New Features:
'''''''''''''

* First time installation
