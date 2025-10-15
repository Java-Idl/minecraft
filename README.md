# Minecraft Paper Server Docker Setup

This repository contains a Dockerized Minecraft Paper server with automated datapack and resource pack setup. It uses the itzg/minecraft-server base image with a custom entrypoint script to download and install datapacks and resource packs from Dropbox links on first run.

## Features

- Runs Paper Minecraft server version 1.21.8 by default, configurable via environment variables
- Automatically downloads and installs custom datapacks and resource packs into the world folder
- Persists world data and configuration in a Docker volume for data durability
- Configurable server properties such as seed, difficulty, memory allocation, and online mode
- Uses Docker Compose for easy setup and orchestration
- Custom entrypoint script ensures resource pack is set in server.properties with SHA1 hash for client prompt

## Files

- `docker-compose.yaml`: Defines the Minecraft Paper server service with environment variables and volume mounts.
- `Dockerfile`: Based on itzg/minecraft-server image; adds the custom entrypoint script.
- `entrypoint.sh`: Script that runs at container start to:
  - Create necessary directories
  - Download datapacks and resource pack if not already present
  - Extract datapacks and resource pack into appropriate folders
  - Update `server.properties` to enable resource pack prompt with SHA1 checksum
  - Start the Minecraft server

- `.gitattributes`: Ensures proper line endings for shell scripts and Dockerfile.

## How to Start the Server

### Initial Setup and Start

1. Build the Docker image and start the server containers:

   ```
   docker compose build
   docker compose up -d
   ```

2. Attach to the running Minecraft server container to see logs and interact with the server console:

   ```
   docker attach minecraft-paper
   ```

### Subsequent Starts

After the initial setup, you can start and attach to the server container without rebuilding:

```
docker start minecraft-paper
docker attach minecraft-paper
```

This will resume the Minecraft server in the existing container with preserved world data and settings.

## Configuration

You can configure the server behavior via environment variables in `docker-compose.yaml`:

- `EULA`: Must be `TRUE` to accept Minecraft EULA and run the server.
- `TYPE`: Server type, default is `PAPER`.
- `VERSION`: Minecraft version, default is `1.21.8`.
- `MEMORY`: RAM allocated to the server (e.g., `4G`).
- `VIEW_DISTANCE`: Minecraft view distance.
- `SERVER_NAME`: Optional server name.
- `SEED`: Optional world seed.
- `DIFFICULTY`: Game difficulty (`easy`, `normal`, `hard`, etc.).
- `ONLINE_MODE`: Enable or disable online authentication (`TRUE` or `FALSE`).

## Usage

1. Clone this repository:

   ```
   git clone <repo-url>
   cd <repo-directory>
   ```

2. Modify environment variables in `docker-compose.yaml` as needed.

3. Start the Minecraft server with Docker Compose:

   ```
   docker compose up -d
   ```

4. The Minecraft server will start, downloading datapacks and resource pack on first run. World data and config files are persisted in the `./data` folder.

5. Connect to the server on port `25565`.

## License

This project is provided as-is without warranty. Modify and use it freely for personal or server hosting purposes.
