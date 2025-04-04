FROM python:3.12-bullseye

WORKDIR /app

# install uv to run stdio clients (uvx)
RUN pip install --no-cache-dir uv

# install npx to run stdio clients (npx)
RUN apt-get update && apt-get install -y --no-install-recommends curl
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y --no-install-recommends nodejs

# Clone the MCP-Bridge repository
RUN git clone https://github.com/SecretiveShell/MCP-Bridge.git .

# Copy necessary files from the repo (similar to the official Dockerfile)
# This step is not needed if we're cloning the repo directly, but added for clarity
# COPY pyproject.toml .
# COPY mcp_bridge/__init__.py mcp_bridge/__init__.py
# COPY README.md README.md

# Sync dependencies with uv
RUN uv sync

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expose the port for the MCP-Bridge server
EXPOSE 8000

# Set working directory and entrypoint
WORKDIR /app/mcp_bridge
ENTRYPOINT ["uv", "run", "main.py"] 