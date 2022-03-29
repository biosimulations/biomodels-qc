Installation
==================


Local installation
------------------

First, install the following requirements:

* Python 3.9.0+
* pip >= 19.3
* `Systems Biology Format Converter <http://sbfc.sourceforge.net/mediawiki/index.php/Main_Page>`_

    * Java

* `Octave <https://www.gnu.org/software/octave/>`_

    * `Mac OS installer <https://www.gnu.org/software/octave/download>`_
    * Ubuntu: ``apt-get install octave``
    * `Windows installer <https://www.gnu.org/software/octave/download>`_

* `Scilab <https://www.scilab.org/>`_

    * `Mac OS installer <https://www.scilab.org/download/>`_
    * Ubuntu: ``apt-get install scilab``
    * `Windows installer <https://www.scilab.org/download/>`_

* `SVGLint <https://www.npmjs.com/package/svglint>`_

    * `Node.js <https://nodejs.org/en/>`_

        * `Mac OS installer <https://nodejs.org/en/download/>`_
        * `Ubuntu instructions <https://github.com/nodesource/distributions/blob/master/README.md>`_
        * `Windows installer <https://nodejs.org/en/download/>`_

* `XPP <http://www.math.pitt.edu/~bard/xpp/xpp.html>`_

    * `Mac OS instructions <http://www.math.pitt.edu/~bard/xpp/installonmac.html>`_
    * Ubuntu: ``apt-get install xppaut``
    * `Windows instructions <http://www.math.pitt.edu/~bard/xpp/installonwindows.html>`_

Second, add paths to the following to your system path:

* ``sbfConverter.sh`` (Linux/Mac OS) or ``sbfConverter.bat`` (Windows)
* ``svglint``
* ``xppaut``

Third, run the following command to install this package::

    pip install biomodels-qc


Docker image
------------

Run the following command to pull the Docker image::

    docker pull ghcr.io/biosimulations/biomodels_qc
