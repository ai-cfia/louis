FROM python:3.11-slim

WORKDIR /app

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

# Install mcpo
RUN pip install --no-cache-dir mcpo

# Create a non-root user to run the application
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser /app
USER appuser

# Expose the port for the MCPO server
EXPOSE 8080

# Command will be provided via docker-compose
ENTRYPOINT ["mcpo", "--host", "0.0.0.0"]
CMD ["--port", "8080"]
