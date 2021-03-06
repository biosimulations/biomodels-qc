[![Latest release](https://img.shields.io/github/v/release/biosimulations/biomodels-qc)](https://github.com/biosimulations/biomodels-qc/releases)
[![PyPI](https://img.shields.io/pypi/v/biomodels-qc)](https://pypi.org/project/biomodels-qc/)
[![CI status](https://github.com/biosimulations/biomodels-qc/actions/workflows/ci.yml/badge.svg)](https://github.com/biosimulations/biomodels-qc/actions/workflows/ci.yml)
[![Test coverage](https://codecov.io/gh/biosimulations/biomodels-qc/branch/dev/graph/badge.svg)](https://codecov.io/gh/biosimulations/biomodels-qc)

# BioModels-QC
Command-line application for quality controlling entries in the [BioModels database](https://www.ebi.ac.uk/biomodels/) and converting the primary files for entries in the database into additional formats such as BioPAX, MATLAB/Octave, and XPP.

The application can be installed locally or executed as a Docker image.

This application is intended to be used in conjuction with the best practices recommended [here](best-practices-for-curating-biomodels.md).

## Local installation

### Requirements
* [Python](https://python.org) 3.9.0+
* [pip](https://pip.pypa.io/) >= 19.3
* [Systems Biology Format Converter](http://sbfc.sourceforge.net/mediawiki/index.php/Main_Page)
    * [Java](https://www.java.com/)
* [Octave](https://www.gnu.org/software/octave/)
    * [Mac OS installer](https://www.gnu.org/software/octave/download)
    * Ubuntu: `apt-get install octave`
    * [Windows installer](https://www.gnu.org/software/octave/download)
* [Scilab](https://www.scilab.org/)
    * [Mac OS installer](https://www.scilab.org/download/)
    * Ubuntu: `apt-get install scilab`
    * [Windows installer](https://www.scilab.org/download/)
* [SVGLint](https://www.npmjs.com/package/svglint)
    * [Node.js](https://nodejs.org/en/)
        * [Mac OS installer](https://nodejs.org/en/download/)
        * [Ubuntu instructions](https://github.com/nodesource/distributions/blob/master/README.md)
        * [Windows installer](https://nodejs.org/en/download/)
* [XPP](http://www.math.pitt.edu/~bard/xpp/xpp.html)
    * [Mac OS instructions](http://www.math.pitt.edu/~bard/xpp/installonmac.html)
    * Ubuntu: `apt-get install xppaut`
    * [Windows instructions](http://www.math.pitt.edu/~bard/xpp/installonwindows.html)

After installing the packages above, the following must be added to your system path:
* `sbfConverter.sh` (Linux/Mac OS) or `sbfConverter.bat` (Windows)
* `svglint`
* `xppaut`

### Installation
Run the following command to install the package.
```
pip install biomodels-qc
```

## Docker image
Run the following command to pull the Docker image
```
docker pull ghcr.io/biosimulations/biomodels_qc
```

## Tutorial

### Convert the files for an entry to additional formats
Run the following command to convert the files for an entry to additional formats such as BioPAX, MATLAB/Octave, and XPP.
```
ENTRY_DIR=/path/to/directory-for-entry
biomodels-qc convert "$ENTRY_DIR"
```

### Validate an entry
Run the following command to validate an entry of the BioModels database:
```
ENTRY_DIR=/path/to/directory-for-entry
biomodels-qc validate "$ENTRY_DIR"
```

### Using the Docker image
Run the following commands to use the BioModels-QC Docker image to execute the same conversion and validation operations.

#### Convert the files for an entry to additional formats
```
ENTRY_DIR=/path/to/directory-for-entry\
docker run \
    --mount type=bind,source="$ENTRY_DIR",target=/biomodels-entry \
    --interactive \
    --tty \
    --rm \
    ghcr.io/biosimulations/biomodels_qc \
        convert \
            /biomodels-entry
```

#### Validate an entry
```
ENTRY_DIR=/path/to/directory-for-entry
CONTAINER_TEMP_DIR=$(mktemp --directory)
docker run \
    --mount type=bind,source="$ENTRY_DIR",target=/biomodels-entry \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    --mount type=bind,source="$CONTAINER_TEMP_DIR",target=/tmp \
    --env TEMP_DIR_HOST_PATH=$CONTAINER_TEMP_DIR \
    --interactive \
    --tty \
    --rm \
    ghcr.io/biosimulations/biomodels_qc \
        validate \
            /biomodels-entry
```

## Documentation
Documentation for the command-line program is available inline.

Run the following command to obtain the help.
```
biomodels-qc --help
```

### Using the Docker image
Run the following command to use the BioModels-QC Docker image to obtain the help.
```
docker run \
    --interactive \
    --tty \
    --rm \
    ghcr.io/biosimulations/biomodels_qc \
        --help
```

## API documentation
API documentation is available [here](https://biosimulations.github.io/biomodels-qc/).

## License
This package is released under the [MIT license](LICENSE).

## Development team
This package was developed by the [Karr Lab](https://karrlab.org) at the Icahn School of Medicine at Mount Sinai and the [Center for Reproducible Biomedical Modeling](http://reproduciblebiomodels.org).

## Contributing to BioModels-QC
We enthusiastically welcome contributions! Please see the [guide to contributing](CONTRIBUTING.md) and the [developer's code of conduct](CODE_OF_CONDUCT.md).

## Acknowledgements
This work was supported by National Institutes of Health award P41EB023912.

## Questions and comments
Please contact the [BioSimulations Team](mailto:info@biosimulations.org) with any questions or comments.
