#!/bin/bash

# Start GPT-Researcher MCP server in the background
cd /app/gpt-researcher/mcp-server
python server.py &
GPTR_PID=$!
echo "Started GPT-Researcher MCP server with PID: $GPTR_PID"

# Wait a moment to ensure the server is up
sleep 5

# Start MCP-Bridge in the foreground
cd /app/mcp-bridge
uv run main.py

# If MCP-Bridge exits, also kill the GPT-Researcher server
kill $GPTR_PID
 