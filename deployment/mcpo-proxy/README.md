# MCPO Proxy for GPT Researcher

This service provides an OpenAPI-compatible HTTP proxy for the GPT Researcher MCP server, making it accessible to Open WebUI.

We are using MCP Bridge instead since MCPO Proxy only works with stdio

## Overview

MCPO (Model Context Protocol to OpenAPI) is a proxy that converts MCP servers to OpenAPI-compatible HTTP servers. This allows Open WebUI to interact with MCP-based services like GPT Researcher.

## Configuration

The service exposes the following environment variables:

- `MCP_TARGET_URL`: URL of the MCP server to proxy (default: `http://gpt-researcher-mcp:8000`)
- `PORT`: Port on which the MCPO server listens (default: `8080`)

## Usage

The MCPO proxy makes the GPT Researcher accessible at:

- API Endpoint: `http://mcpo-proxy:8080`
- OpenAPI Documentation: `http://mcpo-proxy:8080/docs`

## Integration with Open WebUI

To integrate with Open WebUI, add this service as a custom API endpoint in the Open WebUI settings:

1. Go to Open WebUI Settings
2. Navigate to "API Endpoints"
3. Add a new endpoint with:
   - Name: `GPT Researcher`
   - API Base URL: `http://mcpo-proxy:8080`
   - API Key: (leave empty)

## Building and Deploying

The MCPO proxy is built as part of the overall project. See the main project README for deployment instructions.

```bash
# Build the image manually if needed
docker build -t mcpo-proxy:latest ./deployment/mcpo-proxy
```
