Tutorial
========

Convert the files for an entry to additional formats
----------------------------------------------------
Run the following command to convert the files for an entry to additional formats such as BioPAX, MATLAB/Octave, and XPP::

    ENTRY_DIR=/path/to/directory-for-entry
    biomodels-qc convert "$ENTRY_DIR"


Validate an entry
----------------------------------------------------
Run the following command to validate an entry of the BioModels database::

    ENTRY_DIR=/path/to/directory-for-entry
    biomodels-qc validate "$ENTRY_DIR"


Using the Docker image
----------------------------------------------------
Run the following commands to use the BioModels-QC Docker image to execute the same conversion and validation operations.

Convert the files for an entry to additional formats::

    ENTRY_DIR=/path/to/directory-for-entry
    docker run \
        --mount type=bind,source="$ENTRY_DIR",target=/biomodels-entry \
        --interactive \
        --tty \
        --rm \
        ghcr.io/biosimulations/biomodels_qc \
            convert \
                /biomodels-entry

Validate an entry::

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
