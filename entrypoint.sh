#!/bin/bash
set -e

# Paths
DATAPACKS_DIR="/data/world/datapacks"
RESOURCEPACKS_DIR="/data/resourcepacks"
WORLD_DIR="/data/world"

# Dropbox links (direct download)
DATAPACKS_URL="https://www.dropbox.com/scl/fo/2vs2l7ajjl04qyec9grxi/AJKiIw7v4yEvv0VtBDLs2I4?rlkey=exlyx72f5021t8eys0u1wssn4&st=b3ylgpbc&dl=0"
RESOURCEPACK_URL="https://www.dropbox.com/scl/fi/6e956wuhn3l4xvod9adm3/resourcepack.zip?rlkey=em7l8oz1ecm8q76tgjvlt2z6p&st=75vdite1&dl=0"


# SHA1 of resource pack (replace with your actual SHA1 checksum)
RESOURCE_PACK_SHA1="e359659dd297dfaf087f5e293df7c362aff06c68"

# Create directories if not exist
mkdir -p "$DATAPACKS_DIR" "$RESOURCEPACKS_DIR" "$WORLD_DIR"

# Download datapacks only if datapacks folder is empty (first-run)
if [ -z "$(ls -A "$DATAPACKS_DIR")" ]; then
    echo "Downloading datapacks..."
    curl -L -o /tmp/datapacks.zip "$DATAPACKS_URL"
    unzip -o /tmp/datapacks.zip -d /tmp/dp_unpack
    mv /tmp/dp_unpack/* "$DATAPACKS_DIR"
    rm -rf /tmp/datapacks.zip /tmp/dp_unpack
else
    echo "Datapacks already present, skipping download."
fi

# Download resource pack only if not present
if [ ! -f "$RESOURCEPACKS_DIR/resourcepack.zip" ]; then
    echo "Downloading resource pack..."
    curl -L -o "$RESOURCEPACKS_DIR/resourcepack.zip" "$RESOURCEPACK_URL"
    unzip -o "$RESOURCEPACKS_DIR/resourcepack.zip" -d "$RESOURCEPACKS_DIR"
else
    echo "Resource pack already present, skipping download."
fi

# Set resource pack URL and sha1 in server.properties to enable client prompt
SERVER_PROPERTIES="$WORLD_DIR/server.properties"
RESOURCE_PACK_URL="$RESOURCEPACK_URL"

if ! grep -q "^resource-pack=" "$SERVER_PROPERTIES" 2>/dev/null; then
  echo "resource-pack=$RESOURCE_PACK_URL" >> "$SERVER_PROPERTIES"
else
  sed -i "s|^resource-pack=.*|resource-pack=$RESOURCE_PACK_URL|" "$SERVER_PROPERTIES"
fi

if ! grep -q "^resource-pack-sha1=" "$SERVER_PROPERTIES" 2>/dev/null; then
  echo "resource-pack-sha1=$RESOURCE_PACK_SHA1" >> "$SERVER_PROPERTIES"
else
  sed -i "s|^resource-pack-sha1=.*|resource-pack-sha1=$RESOURCE_PACK_SHA1|" "$SERVER_PROPERTIES"
fi

echo "Starting Minecraft server..."
exec /image/scripts/start
