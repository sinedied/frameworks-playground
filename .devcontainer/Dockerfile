# Find the Dockerfile at this URL
# https://github.com/Azure/azure-functions-docker/blob/dev/host/4/bullseye/amd64/python/python39/python39-core-tools.Dockerfile
FROM mcr.microsoft.com/azure-functions/python:4-python3.9-core-tools

ARG NODE_VERSION="16"
ENV PLATFORM_DOCKER=1 \
    NVM_DIR="/usr/local/share/nvm" \
    NVM_SYMLINK_CURRENT=true \
    PATH="${NVM_DIR}/current/bin:/usr/local/bin/flutter/bin:/home/vscode/.cargo/bin${PATH}" \

# Setup Node.js and apt packages
RUN curl -sfL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/node-debian.sh" -o /tmp/node-debian.sh \
    && bash /tmp/node-debian.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" \
    && su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1" \
    && apt-get update \
    && apt-get install -y expect ruby-full hugo \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

USER vscode

# Install flutter
RUN curl https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.4-stable.tar.xz -o /tmp/flutter.tar.xz \
    && tar -xJf /tmp/flutter.tar.xz -C /tmp \
    && rm -rf /tmp/flutter.tar.xz \
    && sudo chown -R vscode /tmp/flutter \
    && sudo mv /tmp/flutter /usr/local/bin/
    && flutter channel stable \
    && flutter upgrade

# Install Elm
RUN curl -L -o /tmp/elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz \
    && gunzip /tmp/elm.gz \
    && rm -rf /tmp/elm.gz \
    && sudo chown -R vscode /tmp/elm \
    && sudo mv /tmp/elm /usr/local/bin/

# Install Meteor
RUN curl https://install.meteor.com/ | sh

# Install npm packages
RUN npm set -g progress=false \
    && npm install --cache /tmp/empty-cache -g npm@latest polymer-cli docsify-cli fuzz-run

# Install Python packages
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir Django mkdocs pelican markdown Lektor

# Install Ruby packages
RUN sudo gem install bundler jekyll middleman

# Install Zola
RUN ZOLA_VERSION=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/barnumbirr/zola-debian/releases/latest) | cut -c2-) \
    && curl -sfL "https://github.com/barnumbirr/zola-debian/releases/download/v${ZOLA_VERSION}/zola_${ZOLA_VERSION}_amd64_bullseye.deb" -o /tmp/zola.deb \
    && sudo dpkg -i /tmp/zola.deb \
    && rm -rf /tmp/zola.deb

# Install Rust and its packages
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && cargo install mdbook \

