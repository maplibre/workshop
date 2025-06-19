FROM ubuntu:24.04

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      openjdk-21-jre-headless \
      git

RUN curl -L --silent --show-error --fail -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar \
    && curl -L --silent --show-error --fail -o /martin.tar.gz \
      https://github.com/maplibre/martin/releases/download/v0.17.0/martin-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf /martin.tar.gz -C /usr/local/bin \
    && rm /martin.tar.gz \
    && mkdir -p /data/sources

RUN curl -L --silent --show-error --fail -o /data/sources/massachusetts.osm.pbf \
      https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf
RUN curl -L --silent --show-error --fail -o /data/sources/natural_earth_vector.sqlite.zip \
      https://naciscdn.org/naturalearth/packages/natural_earth_vector.sqlite.zip
RUN curl -L --silent --show-error --fail -o /data/sources/water-polygons-split-3857.zip \
      https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip
RUN curl -L --silent --show-error --fail -o /data/sources/lake_centerline.shp.zip \
      https://github.com/acalcutt/osm-lakelines/releases/download/v12/lake_centerline.shp.zip
