FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      openjdk-21-jre-headless \
    && rm -rf /var/lib/apt/lists/* \
    && mkdir -p /data/sources \
    && curl -L -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar \
    && curl -L -o /data/sources/massachusetts.osm.pbf \
      https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf \
    && curl -L -o /data/sources/natural_earth_vector.sqlite.zip \
      https://naciscdn.org/naturalearth/packages/natural_earth_vector.sqlite.zip \
    && curl -L -o /data/sources/water-polygons-split-3857.zip \
      https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip \
    && curl -L -o /data/sources/lake_centerline.shp.zip \
      https://github.com/acalcutt/osm-lakelines/releases/download/v12/lake_centerline.shp.zip
