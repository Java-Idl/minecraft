# Minecraft Paper Server Docker Setup

This repository contains a Dockerized setup for running a Minecraft Paper server with automated datapack and resource pack management.

## Overview

This project leverages the [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) Docker image to run a Minecraft Paper server with configurable environment variables, persistent data storage, and auto-download of custom datapacks and resource packs from Google Drive.

## Repository Contents

- `.gitattributes`: Git configuration for consistent line endings.
- `docker-compose.yaml`: Defines the Minecraft Paper service with ports, environment variables, volume mounts, and container runtime settings.
- `Dockerfile`: Custom Docker image setup that extends itzg/minecraft-server to add an entrypoint script.
- `entrypoint.sh`: Shell script that sets up required directories, downloads datapacks and a resource pack from Google Drive if not already present, updates server properties, and starts the server.
- `start.sh`: Script to build, start, or attach to the Minecraft server container easily using Docker Compose.

## Prerequisites

- Docker installed on your system.
- Docker Compose installed.
- Appropriate permissions to run Docker commands.

## Usage

### Starting the Server

Run the following command to start or attach to the Minecraft server container:

```
./start.sh
```

- If the container does not exist, it will build and start it using Docker Compose.
- If the container exists but is stopped, it will start the container.
- If the container is already running, it will directly attach your terminal to the server console.

### Environment Configuration

The Minecraft server configuration is controlled via environment variables in `docker-compose.yaml`. Key variables include:

- `EULA`: Must be "TRUE" to accept Minecraft's EULA.
- `TYPE`: Specifies the server type, here set to "PAPER".
- `VERSION`: Minecraft server version (default: "1.21.8").
- `MEMORY`: RAM allocated to the server (e.g., "4G").
- `VIEW_DISTANCE`: Minecraft view distance setting.
- `SERVER_NAME`: Optional server name.
- `SEED`: Optional world seed.
- `DIFFICULTY`: Game difficulty (e.g., "hard").
- `ONLINE_MODE`: Set to "FALSE" to disable authentication (useful for offline mode).

Adjust these variables in `docker-compose.yaml` as needed before starting the server.

### Data Persistence

- Server data, worlds, and configurations are persisted in the `./data` folder on the host, mapped to `/data` inside the container.
- This ensures all game progress and settings are retained between container restarts.

### Datapacks and Resource Packs

- The `entrypoint.sh` script automatically downloads a collection of datapacks and a single resource pack from Google Drive URLs defined in the script, but only if they are not already present.
- The resource pack's URL and SHA1 checksum are updated in the `server.properties` to prompt clients to download the resource pack automatically.

## Customization

- To add or change datapacks, update the URLs array in `entrypoint.sh`.
- Change the resource pack URL and SHA1 checksum as needed.
- Modify Minecraft server options via environment variables in the docker-compose file.

## Notes

- The container uses `tty` and `stdin_open` to allow interactive console attachment.
- The server runs with offline mode enabled by default (`ONLINE_MODE=FALSE`), which can be changed based on your use case.
- The EULA must be accepted (`EULA=TRUE`) for the server to run correctly.

## Troubleshooting

- Make sure Docker and Docker Compose are correctly installed and running.
- Check logs using `docker logs minecraft-paper` if there are server startup issues.
- Verify correct permissions to write to the `./data` directory.

## License

This setup is provided as-is under the MIT License. Adjust and use it freely for personal or private servers.

---

Enjoy your Minecraft Paper server with automated setup and easy management using Docker!
