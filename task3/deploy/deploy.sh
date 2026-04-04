#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:?Environment is required: dev or release}"
IMAGE_NAME="${2:?Image name is required}"

if [ "$ENVIRONMENT" = "dev" ]; then
  docker compose -f task3/deploy/docker-compose.dev.yml down || true
  IMAGE_NAME="$IMAGE_NAME" docker compose -f task3/deploy/docker-compose.dev.yml pull
  IMAGE_NAME="$IMAGE_NAME" docker compose -f task3/deploy/docker-compose.dev.yml up -d
elif [ "$ENVIRONMENT" = "release" ]; then
  docker compose -f task3/deploy/docker-compose.release.yml down || true
  IMAGE_NAME="$IMAGE_NAME" docker compose -f task3/deploy/docker-compose.release.yml pull
  IMAGE_NAME="$IMAGE_NAME" docker compose -f task3/deploy/docker-compose.release.yml up -d
else
  echo "Unknown environment: $ENVIRONMENT"
  exit 1
fi