# Build Stage
FROM python:3.11-slim@sha256:d8c56e3bdde4ac60955... AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .

# Final Stage (Distroless for minimized attack surface)
FROM gcr.io/distroless/python3
WORKDIR /app
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=builder /app /app

# Run as non-root user
USER 1000:1000
EXPOSE 8080
ENV PYTHONPATH=/usr/local/lib/python3.11/site-packages
CMD ["main.py"]
