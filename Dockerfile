FROM python:3.9-slim-buster

ARG VERSION="0.0.1"
ARG SBFC_VERSION="1.3.7"

# metadata
LABEL \
    org.opencontainers.image.title="BioModels-QC" \
    org.opencontainers.image.version="${VERSION}" \
    org.opencontainers.image.description="Utilities for quality controlling the BioModels database" \
    org.opencontainers.image.url="https://github.com/biosimulations/biomodels-qc/" \
    org.opencontainers.image.documentation="https://github.com/biosimulations/biomodels-qc/" \
    org.opencontainers.image.source="https://github.com/biosimulations/biomodels-qc/" \
    org.opencontainers.image.authors="BioSimulations Team <info@biosimulations.org>" \
    org.opencontainers.image.vendor="BioSimulations Team" \
    org.opencontainers.image.licenses="MIT" \
    \
    base_image="python:3.9-slim-buster" \
    version="${VERSION}" \
    software="biomodels-qc" \
    software.version="${VERSION}" \
    about.summary="Utilities for quality controlling the BioModels database" \
    about.home="https://github.com/biosimulations/biomodels-qc/" \
    about.documentation="https://github.com/biosimulations/biomodels-qc/" \
    about.license_file="https://github.com/biosimulations/biomodels-qc/blob/main/LICENSE" \
    about.license="SPDX:MIT" \
    about.tags="BioModels,kinetic modeling,dynamical simulation,systems biology,biochemical networks,SBML,SED-ML,COMBINE,OMEX" \
    maintainer="BioSimulations Team <info@biosimulations.org>"

# Install Systems Biology Format Converter (SBFC)
RUN mkdir -p /usr/share/man/man1/ \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        openjdk-11-jre-headless \
        unzip \
        wget \
    \
    && cd /tmp \
    && wget https://sourceforge.net/projects/sbfc/files/sbfc/sbfc-${SBFC_VERSION}.zip/download -O sbfc-${SBFC_VERSION}.zip \
    && unzip sbfc-${SBFC_VERSION}.zip \
    && mv sbfc-${SBFC_VERSION} /opt/ \
    \
    && rm sbfc-${SBFC_VERSION}.zip \
    && apt-get remove -y \
        unzip \
        wget \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*
ENV PATH /opt/sbfc-${SBFC_VERSION}:$PATH

# Install Octave
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        octave \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install Scilab
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        scilab \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install XPP
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libc6-dev \
        libx11-6 \
        libc6 \
        xppaut \
    \
    && apt-get autoremove -y

# Install SVGLint
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        curl \
        build-essential \
    \
    && curl -fsSL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y  --no-install-recommends \
        nodejs \
    && npm install -g svglint \
    \
    && apt-get remove -y \
        curl \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Install Cython for better Owlready2 performance
RUN pip install cython

# fonts for matplotlib
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends libfreetype6 \
    && rm -rf /var/lib/apt/lists/*

# Install Docker
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        gnupg \
        lsb-release \
    && $(curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg) \
    && $(echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null) \
    \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        docker-ce \
        docker-ce-cli \
        containerd.io \
    \
    && apt-get remove -y \
        curl \
        gnupg \
        lsb-release \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# Copy code for package into image and install it
COPY . /root/biomodels_qc
RUN pip install /root/biomodels_qc \
    && rm -rf /root/biomodels_qc

# Entrypoint
ENTRYPOINT ["biomodels-qc"]
CMD []
