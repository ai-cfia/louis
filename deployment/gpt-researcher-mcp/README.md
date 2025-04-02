# GPT Researcher MCP Server Deployment

This directory contains the custom Dockerfile for building only the GPT Researcher MCP Server component rather than the full GPT Researcher application.

## What is the MCP Server?

The Machine Conversation Protocol (MCP) server allows AI assistants like Claude and ChatGPT to use GPT Researcher as a tool to conduct web research and generate reports through an API interface.

## Files

- `Dockerfile` - Custom Dockerfile that builds only the MCP server component
- `.env.example` - Example environment variables required for the MCP server

## Usage with Docker Compose

The service is configured in the main `docker-compose.yaml` file in the root of the repository:

```yaml
gpt-researcher-mcp:
  image: ghcr.io/ai-cfia/louis/gpt-researcher-mcp:louis-main
  restart: always
  ports:
    - "8080:8000"
  environment:
    - OPENAI_API_KEY=${OPENAI_API_KEY}
    - TAVILY_API_KEY=${TAVILY_API_KEY}
  networks:
    - ai-network
  depends_on:
    - litellm
```

## Environment Variables

Make sure to set the following environment variables before starting the service:

- `OPENAI_API_KEY` - Your OpenAI API key
- `TAVILY_API_KEY` - Your Tavily API key for web search capabilities

## Building Locally

To build the Docker image locally:

```bash
cd /path/to/louis
docker build -f deployment/gpt-researcher-mcp/Dockerfile -t gpt-researcher-mcp .
```

## Differences from Full GPT Researcher

This build includes only the MCP server component from the GPT Researcher repository, making it:

1. Smaller in size
2. Focused only on the API component for AI assistants 
3. Easier to deploy for specific use cases

The full GPT Researcher includes additional components such as:
- Frontend UI
- Command-line interface
- Multi-agent capabilities
- Local document processing

If you need these features, consider using the full GPT Researcher image instead. 