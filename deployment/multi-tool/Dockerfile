FROM python:3.12-bullseye
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# install npx to run stdio clients (npx)
RUN apt-get update && apt-get install -y --no-install-recommends curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y --no-install-recommends nodejs

WORKDIR /app

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

ENV UV_NO_CACHE=1 \
UV_COMPILE_BYTECODE=1

COPY MCP-Bridge/mcp_bridge /app/mcp_bridge
COPY MCP-Bridge/pyproject.toml /app/

# Copy requirements.txt for additional MCP tools
COPY deployment/multi-tool/requirements.txt /app/

RUN ls -la

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync

# Install any extra MCP tools from requirements.txt
RUN uv pip install --no-cache-dir -r /app/requirements.txt

# Set working directory to the MCP server directory
# WORKDIR /app/mcp-server


# Expose the port for the MCPO server
EXPOSE 8000

WORKDIR /app/mcp_bridge
ENTRYPOINT ["uv", "run", "main.py"]
