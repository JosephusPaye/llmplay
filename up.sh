# Exit on error
set -e

# Start services and print URLs
docker-compose up -d \
  && echo "OpenUI: http://localhost:4100" \
  && echo "Kokoro FastAPI web UI: http://localhost:4101/web"
