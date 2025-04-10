FROM python:3.11-slim
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

ENV UV_NO_CACHE=1 \
UV_COMPILE_BYTECODE=1

# Create directories for the application
RUN mkdir -p /app/mcp-server

# Copy only the MCP server files
COPY gpt-researcher/mcp-server/* /app/mcp-server/
COPY deployment/mcpo-gptr/uv.lock /app/
COPY deployment/mcpo-gptr/pyproject.toml /app/

RUN ls -la
# RUN pip install --no-cache-dir -r /app/mcp-server/requirements.txt    
# RUN uv init --no-workspace && uv venv && uv pip install -r /app/requirements.txt
RUN --mount=type=cache,target=/root/.cache/uv \
    # --mount=type=bind,source=deployment/mcpo-gptr/uv.lock,target=/app/uv.lock \
    # --mount=type=bind,source=deployment/mcpo-gptr/pyproject.toml,target=/app/pyproject.toml \
    uv sync --frozen --no-install-project

RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --frozen

# Set working directory to the MCP server directory
# WORKDIR /app/mcp-server


# Expose the port for the MCPO server
EXPOSE 8000

# Command will be provided via docker-compose
# uvx mcpo --port 8000 -- uv run --with mcp mcp run server.py
ENTRYPOINT ["uv", "run", "mcpo", "--port", "8000", "--", "uv", "run", "mcp", "run", "/app/mcp-server/server.py"]
