FROM python:3.11-slim

WORKDIR /app

# Set environment variables to avoid issues
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install git (needed for pip install from git repositories)
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for the application
RUN mkdir -p /app/mcp-server

# Upgrade pip
RUN pip install --no-cache-dir --upgrade pip

# Copy requirements file and install dependencies
COPY gpt-researcher/mcp-server/requirements.txt /app/mcp-server/
RUN pip install --no-cache-dir -r /app/mcp-server/requirements.txt

# Copy only the MCP server files
COPY gpt-researcher/mcp-server/*.py /app/mcp-server/
COPY gpt-researcher/mcp-server/run.sh /app/mcp-server/

# Set working directory to the MCP server directory
WORKDIR /app/mcp-server

# Make the run script executable
RUN chmod +x /app/mcp-server/run.sh

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expose the port for the MCP server
EXPOSE 8000

# Environment variables will be provided at runtime via docker-compose or docker run
# Do not include API keys or secrets in the Dockerfile

# Command to run the MCP server
CMD ["python", "server.py"]
