# How to use snippet Dockerfile?
# Copy selection divided by 
# --------------------------------
# and paste it into your Dockerfile.
# There may be some issues with compatibility.

FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:0-16-bullseye

# --------------------------------

ARG MONGO_TOOLS_VERSION=5.0

# Install MongoDB command line tools if on buster and x86_64 (arm64 not supported)
# Install MongoDB Command Line Tools
# Only if you're using buster and x86_64
# NOT SUPPORTED ON ARM64

RUN . /etc/os-release \
    && if [ "${VERSION_CODENAME}" = "buster" ] && [ "$(dpkg --print-architecture)" = "amd64" ]; then \
    curl -sSL "https://www.mongodb.org/static/pgp/server-${MONGO_TOOLS_VERSION}.asc" | gpg --dearmor > /usr/share/keyrings/mongodb-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/mongodb-archive-keyring.gpg] http://repo.mongodb.org/apt/debian $(lsb_release -cs)/mongodb-org/${MONGO_TOOLS_VERSION} main" | tee /etc/apt/sources.list.d/mongodb-org-${MONGO_TOOLS_VERSION}.list \
    && apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y mongodb-database-tools mongodb-mongosh \
    && apt-get clean -y && rm -rf /var/lib/apt/lists/*; \
    fi

# --------------------------------
