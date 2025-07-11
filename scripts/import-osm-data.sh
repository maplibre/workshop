#!/bin/bash
# Script to import OSM data into PostgreSQL using osm2pgsql

set -e

echo "🚀 Starting OSM data import to PostgreSQL..."

# Wait for database to be ready
echo "⏳ Waiting for PostgreSQL to be ready..."
docker compose exec db pg_isready -U postgres -d estonia || sleep 5

# Start the osm2pgsql service to import data
docker compose --profile import up osm2pgsql

echo "✅ OSM data import complete!"
echo ""
echo "🔍 To verify the import:"
echo "   docker compose exec db psql -U postgres -d estonia -c \"SELECT COUNT(*) FROM bicycle_parking;\""
echo ""
echo "🎯 The imported data includes:"
echo "   - Bicycle parking locations from Boston OSM data"
echo "   - Data is available in PostgreSQL for Martin to serve as vector tiles"