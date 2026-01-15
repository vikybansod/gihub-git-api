# ---------- Stage 1: Builder & Test ----------
FROM python:3.7-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py test_app.py ./
RUN pytest -v


# ---------- Stage 2: Runtime ----------
FROM python:3.7-slim

WORKDIR /app

# Install curl (required for HEALTHCHECK)
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
 && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd -m appuser

# Copy dependencies from builder
COPY --from=builder /usr/local /usr/local

# Copy application code
COPY app.py .

RUN chown -R appuser:appuser /app
USER appuser

EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

# Run app with Gunicorn (foreground)
CMD ["gunicorn", "--workers=2", "--bind=0.0.0.0:8080", "app:app"]