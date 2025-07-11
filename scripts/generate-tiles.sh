#!/bin/bash
# Script to generate tiles using Planetiler

set -e

echo "🚀 Starting tile generation with Planetiler..."

# Check if tiles already exist
if [[ -f "data/output.mbtiles" && -f "data/benches.mbtiles" ]]; then
    echo "✅ Tiles already exist!"
    echo "📁 Found files:"
    echo "   - data/output.mbtiles ($(du -h data/output.mbtiles | cut -f1))"
    echo "   - data/benches.mbtiles ($(du -h data/benches.mbtiles | cut -f1))"
    echo ""
    echo "💡 To regenerate tiles, delete these files first:"
    echo "   rm data/*.mbtiles"
    echo ""
    echo "🎯 Next steps:"
    echo "   1. Run './scripts/start-workshop.sh' to start all services"
    echo "   2. Open http://localhost:8080 to access the workshop"
    exit 0
fi

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