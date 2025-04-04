# Combined MCP-Bridge and GPT-Researcher Deployment

This folder contains a combined deployment of MCP-Bridge and GPT-Researcher MCP in a single Docker image.

## Overview

This deployment runs both MCP-Bridge and GPT-Researcher's MCP server in the same container:

- **MCP-Bridge** runs on port 8080 (using the official repository and uv runner)
- **GPT-Researcher MCP** runs on port 8000

The MCP-Bridge is configured to connect directly to the local GPT-Researcher MCP server using the standard MCP protocol endpoint at `/mcp`.

## Implementation Details

- Uses the official [MCP-Bridge repository](https://github.com/SecretiveShell/MCP-Bridge) from GitHub
- Utilizes `uv` for running MCP-Bridge (aligned with the official repository's approach)
- Runs the GPT-Researcher MCP server in the same container for simpler deployment
- Both services communicate internally, reducing network overhead

## Setup

1. Create a `.env` file based on `.env.example` with your API keys.
2. Build the Docker image:
   ```
   docker build -t bridge-gptr .
   ```

## Running

```
docker run -p 8080:8080 -p 8000:8000 -v $(pwd)/.env:/app/gpt-researcher/mcp-server/.env bridge-gptr
```

Note: The config.json is now copied directly into the image during build for simpler deployment.

## Docker Compose Example

```yaml
version: '3'

services:
  bridge-gptr:
    build: .
    ports:
      - "8080:8080"
      - "8000:8000"
    volumes:
      - ./.env:/app/gpt-researcher/mcp-server/.env
    depends_on:
      - litellm

  litellm:
    image: ghcr.io/berriai/litellm:main-latest
    ports:
      - "8000:8000"
    env_file:
      - ./litellm.env
```

## Advantages

- Simplified deployment - single container for both services
- Direct internal communication between MCP-Bridge and GPT-Researcher
- Reduced network overhead and latency
- Easier management of the combined system
- Uses the official MCP-Bridge repository and configuration approach 
