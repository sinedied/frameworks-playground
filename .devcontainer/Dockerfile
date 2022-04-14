# Find the Dockerfile at this URL
# https://github.com/Azure/azure-functions-docker/blob/dev/host/4/bullseye/amd64/python/python39/python39-core-tools.Dockerfile
FROM mcr.microsoft.com/azure-functions/python:4-python3.9-core-tools

ARG NODE_VERSION="16"
ARG CORE_TOOLS_VERSION="4"
ENV NVM_DIR="/usr/local/share/nvm" \
    NVM_SYMLINK_CURRENT=true \
    PATH="${NVM_DIR}/current/bin:${PATH}" \
    PATH="/usr/local/bin/flutter/bin:${PATH}"

# Install flutter
RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.4-stable.tar.xz -o /tmp/flutter.tar.xz \
    && tar -xJf /tmp/flutter.tar.xz -C /tmp \
    && rm -rf /tmp/flutter.tar.xz \
    && mv /tmp/flutter /usr/local/bin/ \
    && flutter channel stable \
    && flutter upgrade 

# Setup apt packages
RUN apt-get update \
    && if [ $CORE_TOOLS_VERSION != "4" ]; then apt-get remove -y azure-functions-core-tools-4 &&  apt-get install -y "azure-functions-core-tools-${CORE_TOOLS_VERSION}"; fi \
    && apt-get install -y expect hugo \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Setup Node.js and npm packages
RUN curl -sfL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/node-debian.sh" -o /tmp/node-debian.sh && bash /tmp/node-debian.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" \
    && su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1" \
    && su vscode -c "umask 0002 && npm set -g progress=false && npm install --cache /tmp/empty-cache -g npm@latest polymer-cli" \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

# Install Elm
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip elm.gz \
    && rm -rf elm.gz \
    && chmod +x elm \
    && mv elm /usr/local/bin/

# Install Django
RUN python -m pip install --no-cache-dir Django

# Install Meteor
RUN curl https://install.meteor.com/ | sh
