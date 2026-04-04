#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:?Environment is required: dev or release}"
IMAGE_NAME="${2:?Image name is required}"
IMAGE_TAG="${3:?Image tag is required}"

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$ENVIRONMENT" = "dev" ]; then
  docker ps -aq --filter "publish=8002" | xargs -r docker rm -f
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" down || true
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" pull
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" up -d

elif [ "$ENVIRONMENT" = "release" ]; then
  docker ps -aq --filter "publish=8003" | xargs -r docker rm -f
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" down || true
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" pull
  IMAGE_NAME="$IMAGE_NAME" IMAGE_TAG="$IMAGE_TAG" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" up -d

else
  echo "Unknown environment: $ENVIRONMENT"
  exit 1
fi