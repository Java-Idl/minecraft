# Minecraft Paper Server

This project runs a Minecraft Java server with Docker.

## What this setup includes

The stack in `docker-compose.yml` starts three services:

- `minecraft-paper`: the game server (`itzg/minecraft-server`)
- `websockify`: TCP-to-WebSocket bridge
- `nginx`: HTTP endpoint for the tunnel (`/minecraft-tunnel`)

Current game settings in Compose:

- Server type: Paper
- Version: `1.21.11`
- Memory: `4G`
- Server port: `25575`
- Online mode: `FALSE`

This setup is Java Edition only.

## Folder layout

- `docker-compose.yml`: service definitions
- `nginx.conf`: tunnel proxy configuration
- `minecraft_data/`: world data, server properties, plugins, logs

## Start and stop

From this folder, run:

```bash
docker compose up -d --force-recreate
```

Stop everything:

```bash
docker compose down
```

## Check server status

See container state:

```bash
docker compose ps
```

See server logs:

```bash
docker compose logs -f minecraft-paper
```

You should eventually see:

`Done (...s)! For help, type "help"`

## Connect with Minecraft Java (direct)

Use this server address in the game client:

`127.0.0.1:25575`

For another device on your home network, use your PC LAN IP:

`<your-lan-ip>:25575`

## Test the WebSocket tunnel client

Run `websocat` in a separate terminal:

```powershell
websocat.exe -b -E tcp-l:127.0.0.1:25576 ws://127.0.0.1:80/minecraft-tunnel
```

Then connect Minecraft Java to:

`127.0.0.1:25576`

Important notes:

- Do not use `ws://0.0.0.0:80/...` as a destination.
- `0.0.0.0` is for listening, not dialing.
- Do not bind `websocat` to `25575` because Docker already uses that port.

## Quick troubleshooting

If the game client cannot connect:

1. Check containers:

	```bash
	docker compose ps
	```

	`minecraft-paper` should become `healthy`.

2. Check listening ports on Windows:

	```powershell
	Test-NetConnection -ComputerName 127.0.0.1 -Port 25575
	Test-NetConnection -ComputerName 127.0.0.1 -Port 80
	```

3. If using `websocat`, also check:

	```powershell
	Test-NetConnection -ComputerName 127.0.0.1 -Port 25576
	```

4. Review logs for startup errors:

	```bash
	docker compose logs --tail 200 minecraft-paper nginx websockify
	```

## Data and plugins

- World and server files are stored in `minecraft_data/`.
- Plugins are loaded from `minecraft_data/plugins/`.
- Geyser and Floodgate were removed from this setup.
