FROM ubuntu:24.04

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      curl \
      openjdk-21 \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data \
 && curl -L -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar \
 && chmod +x /planetiler.jar \
 && curl -L -o /data/massachusetts-latest.osm.pbf \
      https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf