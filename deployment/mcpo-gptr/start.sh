#!/bin/bash

sed -i "s|os.environ/BRAVE_API_KEY|${BRAVE_API_KEY}|g" config.json
sed -i "s|os.environ/TAVILY_API_KEY|${TAVILY_API_KEY}|g" config.json

uv run mcp run /app/mcp-server/server.py &
uv run mcpo --port 8000 --config /app/mcpo-gptr/config.json
