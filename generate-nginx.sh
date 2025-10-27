#!/bin/bash
# Generate NGINX config based on ACTIVE_POOL env

source .env

if [ "$ACTIVE_POOL" = "blue" ]; then
  sed 's/backup=off/backup=on/g; s/backup=on/backup=off/g' nginx.conf.template > nginx.conf
  echo "✅ Blue active, Green backup"
elif [ "$ACTIVE_POOL" = "green" ]; then
  sed 's/backup=off/backup=on/g; s/backup=on/backup=off/g' nginx.conf.template > nginx.conf
  echo "✅ Green active, Blue backup"
else
  echo "❌ ACTIVE_POOL must be 'blue' or 'green'"
  exit 1
fi

echo "Generated nginx.conf for $ACTIVE_POOL pool"
