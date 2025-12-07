# Use Python 3.13 slim image as base
FROM python:3.13-slim

# Set working directory
WORKDIR /app

# Install system dependencies required for Robot Framework Browser (Playwright)
# Node.js is required because Playwright is built on Node.js
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    ca-certificates \
    gnupg \
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
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies directly with pip (no Poetry needed in Docker)
RUN pip install --no-cache-dir \
    robotframework \
    robotframework-browser>=19.6.0,<20.0.0 \
    requests>=2.32.5,<3.0.0

# Initialize Robot Framework Browser (Playwright browsers)
# Using python -m is more reliable than rfbrowser command
RUN python -m Browser.entry init

# Copy project files
COPY . .

# Create Results directory with proper permissions
RUN mkdir -p Results && chmod 777 Results

# Set up entrypoint script
RUN echo '#!/bin/bash\n\
set -e\n\
# Ensure Results directory exists\n\
mkdir -p Results\n\
# Run Robot Framework with passed arguments\n\
exec robot "$@"' > /entrypoint.sh && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

