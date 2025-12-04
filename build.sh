#!/bin/bash

set -e

IMAGE_NAME="react-nginx-app"
TAG=$(date +%Y%m%d%H%M)
FULL_IMAGE="$IMAGE_NAME:$TAG"

echo "📁 Checking build folder..."
if [ ! -d "./build" ]; then
  echo "❌ build/ folder not found. Make sure your React app is built."
  exit 1
fi

echo "📦 Building Docker image: $FULL_IMAGE"
docker build -t "$FULL_IMAGE" .

echo "🔖 Tagging image as latest: $IMAGE_NAME:latest"
docker tag "$FULL_IMAGE" "$IMAGE_NAME:latest"

echo "✅ Build complete!"
echo "   Created images:"
echo "   - $FULL_IMAGE"
echo "   - $IMAGE_NAME:latest"
