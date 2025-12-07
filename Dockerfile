# Use Python 3.13 slim image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install system dependencies required for Robot Framework Browser (Playwright)
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    xvfb \
    fonts-liberation \
    libasound2 \
    libatk-bridge2.0-0 \
    libatk1.0-0 \
    libatspi2.0-0 \
    libcups2 \
    libdbus-1-3 \
    libdrm2 \
    libgbm1 \
    libgtk-3-0 \
    libnspr4 \
    libnss3 \
    libwayland-client0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxkbcommon0 \
    libxrandr2 \
    xdg-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Poetry
RUN pip install --no-cache-dir poetry

# Configure Poetry settings
ENV POETRY_NO_INTERACTION=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

# Copy dependency files
COPY pyproject.toml poetry.lock ./

# Configure Poetry to use in-project virtual environment and install dependencies
RUN poetry config virtualenvs.in-project true && \
    poetry config virtualenvs.create true && \
    poetry env use python && \
    poetry install --no-root --sync && \
    rm -rf $POETRY_CACHE_DIR

# Initialize Robot Framework Browser (Playwright browsers)
RUN .venv/bin/rfbrowser init

# Copy project files
COPY . .

# Create Results directory with proper permissions
RUN mkdir -p Results && chmod 777 Results

# Set up entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
# Activate Poetry environment\n\
export PATH="/app/.venv/bin:$PATH"\n\
# Ensure Results directory exists\n\
mkdir -p Results\n\
# Run Robot Framework with passed arguments\n\
exec robot "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

