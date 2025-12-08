# Use the official robotframework-browser base image
FROM ghcr.io/marketsquare/robotframework-browser/rfbrowser-stable:19.12

# Switch to root temporarily to install dependencies
USER root

# Set working directory
WORKDIR /app

# Install Python 3.12
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    gnupg \
    software-properties-common \
    build-essential \
    && add-apt-repository ppa:deadsnakes/ppa -y \
    && apt-get update \
    && apt-get install -y python3.12 python3.12-dev python3.12-distutils python3.12-venv \
    && curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12 \
    && rm -rf /var/lib/apt/lists/*

# Upgrade Node.js to version 20.x (if not already latest)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install additional test dependencies with Python 3.12
# Note: robotframework-browser is already installed in the base image
# We'll install robotframework and requests for Python 3.12
RUN python3.12 -m pip install --no-cache-dir --upgrade pip && \
    python3.12 -m pip install --no-cache-dir \
    robotframework \
    robotframework-browser \
    requests>=2.32.5,<3.0.0

# Initialize Playwright browsers for Python 3.12 (browsers are shared system-wide)
RUN python3.12 -m Browser.entry init || true

# Create Results directory with proper permissions for pwuser
RUN mkdir -p /app/Results && \
    chown -R pwuser:pwuser /app && \
    chmod 755 /app

# Copy project files (as root, then change ownership)
COPY --chown=pwuser:pwuser . /app

# Set up entrypoint script using Python 3.12
RUN echo '#!/bin/bash\n\
set -e\n\
# Ensure Results directory exists\n\
mkdir -p /app/Results\n\
# Run Robot Framework with passed arguments using Python 3.12\n\
exec python3.12 -m robot "$@"' > /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    chown pwuser:pwuser /entrypoint.sh

# Switch back to pwuser (the image's default user)
USER pwuser

ENTRYPOINT ["/entrypoint.sh"]

