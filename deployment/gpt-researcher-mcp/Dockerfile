FROM python:3.10-slim

WORKDIR /app

# Install git (needed for pip install from git repositories)
RUN apt-get update && \
    apt-get install -y git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create directories for the application
RUN mkdir -p /app/mcp-server

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

# Expose the port for the MCP server
EXPOSE 8000

# Command to run the MCP server
CMD ["python", "server.py"]
