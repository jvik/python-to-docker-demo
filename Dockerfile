# Use official Python runtime as base image
FROM python:3.11-slim

# Set working directory in container
WORKDIR /app

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# Copy dependency files
COPY pyproject.toml .

# Copy source code
COPY src/ src/

# Install the package and its dependencies using uv
RUN uv pip install --system -e .

# Expose port 5000
EXPOSE 5000

# Run the application
CMD ["python", "-m", "python_flask_demo"]
