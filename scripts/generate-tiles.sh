#!/bin/bash
# Script to generate tiles using Planetiler

set -e

echo "🚀 Starting tile generation with Planetiler..."

# Start the planetiler service to generate tiles
docker compose --profile setup up planetiler

echo "✅ Tile generation complete!"
echo "📁 Generated files:"
echo "   - data/output.mbtiles (base map)"
echo "   - data/benches.mbtiles (bench overlay)"
echo ""
echo "🎯 Next steps:"
echo "   1. Run './scripts/start-workshop.sh' to start all services"
echo "   2. Open http://localhost:8080 to access the workshop"