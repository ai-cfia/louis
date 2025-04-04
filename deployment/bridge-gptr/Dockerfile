FROM python:3.12-bullseye

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install git and required packages
RUN apt-get update && \
    apt-get install -y git curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install uv to run stdio clients (uvx)
RUN pip install --no-cache-dir uv

# Install npx to run stdio clients (npx)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get update && apt-get install -y --no-install-recommends nodejs

# Create directories for both services
RUN mkdir -p /app/mcp-bridge /app/gpt-researcher

# Clone and set up MCP-Bridge
RUN git clone https://github.com/SecretiveShell/MCP-Bridge.git /app/mcp-bridge
WORKDIR /app/mcp-bridge
RUN uv sync

# Set up GPT-Researcher
WORKDIR /app/gpt-researcher
RUN mkdir -p /app/gpt-researcher/mcp-server

# Install GPT-Researcher MCP dependencies
COPY gpt-researcher/mcp-server/requirements.txt /app/gpt-researcher/mcp-server/
RUN pip install --no-cache-dir -r /app/gpt-researcher/mcp-server/requirements.txt

# Copy GPT-Researcher MCP files
COPY gpt-researcher/mcp-server/*.py /app/gpt-researcher/mcp-server/
COPY gpt-researcher/mcp-server/run.sh /app/gpt-researcher/mcp-server/
RUN chmod +x /app/gpt-researcher/mcp-server/run.sh

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Set up working directory
WORKDIR /app

# Copy startup script and config
COPY deployment/bridge-gptr/start.sh /app/
# COPY config.json /app/mcp-bridge/
RUN chmod +x /app/start.sh

# Expose ports for both services
EXPOSE 8000 8080

# Start both services using the startup script
CMD ["/app/start.sh"]
 