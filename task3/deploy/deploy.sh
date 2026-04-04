#!/usr/bin/env bash
set -euo pipefail

ENVIRONMENT="${1:?Environment is required: dev or release}"
IMAGE_NAME="${2:?Image name is required}"

DEPLOY_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ "$ENVIRONMENT" = "dev" ]; then
  docker rm -f devops-exam-dev devops-exam-dev-app-1 2>/dev/null || true
  docker ps -aq --filter "publish=8002" | xargs -r docker rm -f
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" down || true
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" pull
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-dev -f "${DEPLOY_DIR}/docker-compose.dev.yml" up -d
elif [ "$ENVIRONMENT" = "release" ]; then
  docker rm -f devops-exam-release devops-exam-release-app-1 2>/dev/null || true
  docker ps -aq --filter "publish=8003" | xargs -r docker rm -f
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" down || true
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" pull
  IMAGE_NAME="$IMAGE_NAME" docker compose -p devops-exam-release -f "${DEPLOY_DIR}/docker-compose.release.yml" up -d
else
  echo "Unknown environment: $ENVIRONMENT"
  exit 1
fi