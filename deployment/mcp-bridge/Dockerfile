FROM python:3.12-bullseye

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install git for cloning the repository
RUN apt-get update && apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Clone the MCP-Bridge repository
RUN git clone https://github.com/SecretiveShell/MCP-Bridge.git .

# Install dependencies
RUN pip install --no-cache-dir -e .

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expose the port for the MCP-Bridge server
EXPOSE 8080

# Command will be provided via docker-compose
ENTRYPOINT ["python", "-m", "mcp_bridge.main"] 