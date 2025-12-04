#!/bin/bash

set -e

IMAGE_NAME="react-nginx-app:latest"
CONTAINER_NAME="react-container"
PORT=80

echo "🧹 Stopping old container (if exists)..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "🔍 Checking if image exists: $IMAGE_NAME"
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "❌ Docker image '$IMAGE_NAME' not found."
  exit 1
fi

echo "🚀 Starting new container from image: $IMAGE_NAME"
docker run -d \
  -p "$PORT:80" \
  --name "$CONTAINER_NAME" \
  "$IMAGE_NAME"

echo "✅ Deployment complete!"
echo "👉 Open in browser: http://localhost:$PORT"
docker ps | grep "$CONTAINER_NAME" || echo "⚠ Container not shown in ps output."
