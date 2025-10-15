#!/bin/bash
set -e

CONTAINER_NAME="minecraft-paper"

# Check if the container exists
if ! docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then # Container does not exist
  echo "Container ${CONTAINER_NAME} not found. Building and starting with docker compose..." # Build and start the container
  docker compose build # Build the container
  docker compose up -d # Start the container in detached mode
else
  # Container exists, check if it's running
  if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then # Not running
    echo "Starting existing container ${CONTAINER_NAME}..." # Start the container
    docker start "${CONTAINER_NAME}" # Start the container
  else
    echo "Container ${CONTAINER_NAME} is already running." # Already running
  fi
fi

echo "Attaching to container ${CONTAINER_NAME}..."
docker attach "${CONTAINER_NAME}" # Attach to the container