#!/bin/bash

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Please install Docker first."
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose first."
    exit 1
fi

# Make sure submodules are initialized and updated
git submodule update --init --recursive

# Copy example env file if it doesn't exist
if [ ! -f .env ]; then
    if [ -f open-webui/.env.example ]; then
        cp open-webui/.env.example .env
        echo "Created .env file from example"
    else
        echo "Warning: Could not find .env.example in the Open WebUI submodule"
    fi
fi

# Start the services
echo "Starting services with Docker Compose..."
docker-compose up -d

echo "Setup complete! Open WebUI should be available at http://localhost:3000" 