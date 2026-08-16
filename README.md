# Minecraft Paper Server

This project runs a Minecraft Java Edition server with Docker.

## What this setup includes

The stack in `docker-compose.yml` starts four services:

- `minecraft-paper` — game server (`itzg/minecraft-server`, Paper)
- `websockify` — TCP-to-WebSocket bridge
- `nginx` — HTTP endpoint for the WebSocket tunnel (`/minecraft-tunnel`)
- `mumble-server` — voice chat server (port `64738`)

Current game settings:

| Setting       | Value   |
|---------------|---------|
| Type          | Paper   |
| Version       | 26.2    |
| Memory        | 4G      |
| Server port   | 25575   |
| Online mode   | FALSE   |
| Difficulty    | hard    |

## Folder layout

```
.
├── docker-compose.yml     # service definitions
├── nginx.conf             # WebSocket tunnel proxy config
├── minecraft_data/        # world data, server properties, plugins (gitignored)
└── mumble_data/           # Mumble DB & config (gitignored)
```

## Requirements

Create a `.env` file in the project root before starting:

```env
MUMBLE_SUPERUSER_PASSWORD=your_password_here
```

## Start and stop

```bash
docker compose up -d --force-recreate
```

Stop everything:

```bash
docker compose down
```

## Check server status

Container state:

```bash
docker compose ps
```

Live server logs:

```bash
docker compose logs -f minecraft-paper
```

You should eventually see:

```
Done (...s)! For help, type "help"
```

## Connect with Minecraft Java (direct)

```
127.0.0.1:25575
```

From another device on your LAN:

```
<your-lan-ip>:25575
```

## WebSocket tunnel

Run `websocat` in a separate terminal to unwrap the tunnel locally:

```powershell
websocat.exe -b -E tcp-l:127.0.0.1:25576 ws://127.0.0.1:80/minecraft-tunnel
```

Then connect Minecraft to `127.0.0.1:25576`.

> **Note:** Do not bind `websocat` to port `25575` — Docker already owns that port.

## Voice chat (Mumble)

Connect any Mumble client to:

```
127.0.0.1:64738
```

The superuser password is set via `MUMBLE_SUPERUSER_PASSWORD` in your `.env` file.

## Quick troubleshooting

```bash
# Check all containers
docker compose ps

# Check listening ports (Windows)
Test-NetConnection -ComputerName 127.0.0.1 -Port 25575
Test-NetConnection -ComputerName 127.0.0.1 -Port 80
Test-NetConnection -ComputerName 127.0.0.1 -Port 64738

# Review startup logs
docker compose logs --tail 200 minecraft-paper nginx websockify mumble-server
```

## Data and plugins

- World and server files: `minecraft_data/`
- Plugins: `minecraft_data/plugins/`
- Mumble config and DB: `mumble_data/`
