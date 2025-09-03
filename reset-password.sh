#!/bin/bash

# Reset Open WebUI Admin Password Script
# Usage: ./reset-password.sh <email> <new-password>

set -e

# Check if correct number of arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <email> <new-password>"
    echo "Example: $0 j.paye96@gmail.com secret"
    exit 1
fi

EMAIL="$1"
PASSWORD="$2"

echo "Resetting password for: $EMAIL"

# Generate bcrypt hash
echo "Generating password hash..."
HASH=$(htpasswd -bnBC 10 "" "$PASSWORD" | tr -d ':\n')

if [ -z "$HASH" ]; then
    echo "Error: Failed to generate password hash"
    exit 1
fi

# Escape $ characters in hash for Docker command
ESCAPED_HASH=$(echo "$HASH" | sed 's/\$/\\\$/g')

echo "Updating password in Docker container..."

# Update password in Docker
docker run --rm -v llmplay_open-webui:/data alpine \
    sh -c "apk add --no-cache --quiet socat sqlite && echo \"UPDATE auth SET password='$ESCAPED_HASH' WHERE email='$EMAIL'; select changes();\" | sqlite3 /data/webui.db && echo '^ number of rows changed - double check email if 0. valid emails are:' && echo \"select email from auth;\" | sqlite3 /data/webui.db"

