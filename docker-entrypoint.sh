#!/bin/sh
set -e

# Check if config file exists, if not create from example
if [ ! -f "/app/config/targetprocess.json" ]; then
    echo "No config file found, creating from example..."
    cp /app/config/targetprocess.example.json /app/config/targetprocess.json
    
    # Replace placeholders with environment variables if provided
    if [ ! -z "$TP_DOMAIN" ]; then
        sed -i "s/your-domain.tpondemand.com/$TP_DOMAIN/g" /app/config/targetprocess.json
    fi
    if [ ! -z "$TP_USERNAME" ]; then
        sed -i "s/your-username/$TP_USERNAME/g" /app/config/targetprocess.json
    fi
    if [ ! -z "$TP_PASSWORD" ]; then
        sed -i "s/your-password/$TP_PASSWORD/g" /app/config/targetprocess.json
    fi
fi

# Start the MCP server
exec node build/index.js
