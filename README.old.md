# workshop

See the [slide deck](https://docs.google.com/presentation/d/1H0FPzIV7tJMvrr5d2S_W9IA7LUEw10AqGhDKLTrtaW4)

## Pre-reqs
* Docker and Docker Compose
* Download the data from [Geofabrik](https://download.geofabrik.de/), e.g. `estonia-latest.osm.pbf` from [this page](https://download.geofabrik.de/europe/estonia.html) into `data/` directory. ([mirror](https://maplibre-tiles-workshop-07-2024.s3.eu-central-1.amazonaws.com/estonia-latest.osm.pbf))
* Download latest [martin release](https://github.com/maplibre/martin/releases)
* Prefetch needed docker images


```bash
# You may need to use the older `docker-compose` command instead
docker compose -f dc-simple.yml pull
docker compose -f dc-with-db.yml pull
```

# Run Planetiler to generate tiles

```bash
docker run \
    -e JAVA_TOOL_OPTIONS="-Xmx2g" \
    -v "${PWD}/data":/data \
    ghcr.io/onthegomap/planetiler \
    --download --area=estonia --minzoom=0 --maxzoom=14 \
    --osm_path=/data/estonia-latest.osm.pbf
    
# Fix permissions
sudo chown -R $USER:$USER data

# Rename output file for our demo
mv data/output.mbtiles data/estonia.mbtiles
```

### On Windows (using powershell)

```bash
docker run `
    -e JAVA_TOOL_OPTIONS="-Xmx2g"   `
    -v "${PWD}/data:/data"   `
    ghcr.io/onthegomap/planetiler   `
    --download --area=estionia --minzoom=0 --maxzoom=14   `
    --osm_path=/data/estonia-latest.osm.pbf
```

# Serve tiles locally with Martin

```bash
martin data/estonia.mbtiles
```

Run Martin locally, and see if you can access the catalog and source info:
* http://localhost:3000/catalog
* http://localhost:3000/estonia

## View Tiles with Maputnik
* Open https://maplibre.org/maputnik/
* Click `Open` in the upper right corner, and click `Empty` (white square)
* Click `Data Sources` at the top
  * At the bottom,  set Source ID to `openmaptiles` and URL to `https://localhost:3000/estonia`, click `Add Source` and `Close`
* Click `inspect` - you should see the "x-ray mode" of your data

# Run Martin with Docker Compose

Start Nginx proxy at port 8080, Martin, and Maputnik with Docker Compose.  View it at http://localhost:8080

```bash
docker-compose -f dc-simple.yml up
```

## Import data with osm2pgsql

```bash
docker network create dbnet
# shell 1
docker-compose -f dc-with-db.yml up db
# shell 2
docker-compose -f dc-with-db.yml up osm2pgsql
docker-compose -f dc-with-db.yml up
 
 
osm2pgsql -d postgresql://postgres:password@db/mostar -O flex -S /scripts/bicycle_parking.lua /data/mostar.osm.pbf
```

Add `http://localhost:8080/tiles/bicycle_parking` data source to Maputnik.
