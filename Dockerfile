# Use official UV image with Python 3.11
FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim

# Set working directory in container
WORKDIR /app

# Copy dependency files first for better caching
COPY pyproject.toml uv.lock ./

# Install dependencies (creates .venv by default)
RUN uv sync --frozen --no-dev

# Copy source code
COPY src/ src/

# Expose port 5000
EXPOSE 5000

# Run the application using uv run
CMD ["uv", "run", "flask-demo"]
