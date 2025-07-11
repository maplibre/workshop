#!/bin/bash
# Script to start the complete workshop environment

set -e

echo "🚀 Starting MapLibre Workshop environment..."

# Start all main services
docker compose up -d

echo "⏳ Waiting for services to be ready..."
sleep 10

echo "✅ Workshop environment is ready!"
echo ""
echo "🌐 Access points:"
echo "   📖 Main workshop page: http://localhost:8080"
echo "   🎨 Maputnik editor: http://localhost:8080/maputnik/"
echo "   🗺️  Martin tile server: http://localhost:8080/tiles/"
echo "   🐘 PostgreSQL database: localhost:5432"
echo ""
echo "📋 Available commands:"
echo "   - './scripts/import-osm-data.sh' - Import OSM data to PostgreSQL"
echo "   - 'docker compose logs martin' - View Martin logs"
echo "   - 'docker compose logs maputnik' - View Maputnik logs"
echo "   - 'docker compose down' - Stop all services"