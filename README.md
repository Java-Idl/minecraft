# Minecraft Paper Server Docker Setup

This repository contains a Dockerized setup for running a Minecraft Paper server with automated datapack and resource pack management.

## Overview

This project leverages the [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) Docker image to run a Minecraft Paper server. It features native integration for downloading datapacks and resource packs directly via environment variables, eliminating the need for custom entrypoint scripts.

## Repository Contents

- `docker-compose.yml`: Defines the Minecraft Paper service, environment variables, volume mounts, and container runtime settings.
- `start.sh`: A simple helper script to start or attach to the Minecraft server container using Docker Compose.

## Prerequisites

- Docker installed on your system.
- Docker Compose installed.

## Usage

### Starting the Server

Run the following command to start or attach to the Minecraft server container:

```bash
./start.sh
```

- If the container does not exist/is stopped, it will start it.
- If the container is already running, it will attach your terminal to the server console.

### Environment Configuration

The Minecraft server configuration is managed entirely in `docker-compose.yml`.

**Core Settings:**
- `EULA`: Must be "TRUE".
- `TYPE`: "PAPER"
- `VERSION`: "1.21.4"
- `MEMORY`: "4G"
- `ONLINE_MODE`: "FALSE" (Update to TRUE for secure, authenticated servers)

**Content Management:**
- `DATAPACKS`: A comma-separated list of URLs to datapack zip files. These are automatically downloaded by the container.
- `RESOURCE_PACK` & `RESOURCE_PACK_SHA1`: Configures the server resource pack URL and hash directly in `server.properties`.

## Data Persistence

- World data and configurations are persisted in the `./data` directory on the host.

## License

This setup is provided as-is under the MIT License.

---

Enjoy your Minecraft Paper server with automated setup and easy management using Docker!
