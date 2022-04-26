# Find the Dockerfile at this URL
# https://github.com/Azure/azure-functions-docker/blob/dev/host/4/bullseye/amd64/python/python39/python39-core-tools.Dockerfile
FROM mcr.microsoft.com/azure-functions/python:4-python3.9-core-tools

ARG NODE_VERSION="16"
ENV PLATFORM_DOCKER=1 \
    NVM_DIR="/usr/local/share/nvm" \
    NVM_SYMLINK_CURRENT=true \
    PATH="${NVM_DIR}/current/bin:/usr/local/bin/flutter/bin:/home/vscode/.cargo/bin:/home/vscode/.local/bin:${PATH}"

# Setup Node.js and apt packages
RUN curl -sfL "https://raw.githubusercontent.com/microsoft/vscode-dev-containers/main/script-library/node-debian.sh" -o /tmp/node-debian.sh \
    && bash /tmp/node-debian.sh "${NVM_DIR}" "${NODE_VERSION}" "${USERNAME}" \
    && su vscode -c "umask 0002 && . /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1" \
    && apt-get update \
    && apt-get install -y expect ruby-full hugo \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*

USER vscode

# Install flutter
RUN FLUTTER_ARCHIVE=$(curl https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json | jq -r '[.releases[]|select(.channel=="stable")][0].archive') \
    && curl "https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_ARCHIVE" -o /tmp/flutter.tar.xz \
    && tar -xJf /tmp/flutter.tar.xz -C /tmp \
    && rm -rf /tmp/flutter.tar.xz \
    && sudo chown -R vscode /tmp/flutter \
    && sudo mv /tmp/flutter /usr/local/bin/ \
    && flutter channel stable \
    && flutter upgrade

# Install Zola
RUN ZOLA_VERSION=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/barnumbirr/zola-debian/releases/latest) | cut -c2-) \
    && curl -sfL "https://github.com/barnumbirr/zola-debian/releases/download/v${ZOLA_VERSION}/zola_${ZOLA_VERSION}_amd64_bullseye.deb" -o /tmp/zola.deb \
    && sudo dpkg -i /tmp/zola.deb \
    && rm -rf /tmp/zola.deb

# Install Rust and its packages
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    && cargo install mdbook

# Install Meteor
RUN curl https://install.meteor.com/ | sh

# Install Ruby packages
RUN sudo gem install bundler jekyll middleman

# Install Python packages
RUN python -m pip install --no-cache-dir --upgrade pip \
    && python -m pip install --no-cache-dir Django mkdocs pelican markdown Lektor

# Install npm packages
RUN npm set -g progress=false \
    && npm install --cache /tmp/empty-cache -g npm@latest elm-cli polymer-cli docsify-cli fuzz-run
