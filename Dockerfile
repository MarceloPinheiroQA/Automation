# Use the official robotframework-browser base image
FROM ghcr.io/marketsquare/robotframework-browser/rfbrowser-stable:19.12

# Switch to root temporarily to install dependencies
USER root

# Set working directory
WORKDIR /app

# Install Poetry
ENV POETRY_HOME="/opt/poetry"
ENV PATH="$POETRY_HOME/bin:$PATH"

RUN pip install --no-cache-dir poetry

# Configure Poetry to not create virtual environments (install to system Python)
RUN poetry config virtualenvs.create false

# Configure Poetry environment variables
ENV POETRY_NO_INTERACTION=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

# Copy dependency files first (better Docker layer caching)
COPY pyproject.toml poetry.lock* /app/

# Install dependencies using Poetry (uses base image's Python)
RUN poetry install --no-root --no-interaction && rm -rf $POETRY_CACHE_DIR

# Copy the rest of the project
COPY . /app

# Initialize Playwright browsers using Poetry
RUN poetry run rfbrowser init

# Create Results directory with proper permissions for pwuser
RUN mkdir -p /app/Results && \
    chown -R pwuser:pwuser /app && \
    chmod 755 /app

# Set up entrypoint script using Poetry
RUN echo '#!/bin/bash\n\
set -e\n\
mkdir -p /app/Results\n\
exec poetry run robot "$@"' > /entrypoint.sh && \
    chmod +x /entrypoint.sh && \
    chown pwuser:pwuser /entrypoint.sh

# Switch back to pwuser (the image's default user)
USER pwuser

ENTRYPOINT ["/entrypoint.sh"]

