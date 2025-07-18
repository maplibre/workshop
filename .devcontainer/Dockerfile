FROM ubuntu:25.10 AS builder

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      openjdk-21-jre-headless \
      postgresql-client \
      git \
      osm2pgsql

RUN curl -L --silent --show-error --fail -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar \
    && curl -L --silent --show-error --fail -o /martin.tar.gz \
      https://github.com/maplibre/martin/releases/download/v0.17.0/martin-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf /martin.tar.gz -C /usr/local/bin \
    && rm /martin.tar.gz \
    && mkdir -p /data/sources

RUN curl -L --silent --show-error --fail -o /data/sources/mostar.osm.pbf \
      https://github.com/maplibre/workshop/raw/de829f0696c42f4d8553be1e068213b4b53116ac/data/mostar-bosnia.osm.pbf
RUN curl -L --silent --show-error --fail -o /data/sources/natural_earth_vector.sqlite.zip \
      https://naciscdn.org/naturalearth/packages/natural_earth_vector.sqlite.zip
RUN curl -L --silent --show-error --fail -o /data/sources/water-polygons-split-3857.zip \
      https://osmdata.openstreetmap.de/download/water-polygons-split-3857.zip
RUN curl -L --silent --show-error --fail -o /data/sources/lake_centerline.shp.zip \
      https://github.com/acalcutt/osm-lakelines/releases/download/v12/lake_centerline.shp.zip

RUN java -jar /planetiler.jar --download_dir=/data/sources --minzoom=0 --maxzoom=14 --osm_path=/data/sources/mostar.osm.pbf --output=/data/pre-built-mostar.mbtiles

FROM ubuntu:25.10

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      curl \
      openjdk-21-jre-headless \
      postgresql-client \
      git \
      osm2pgsql

RUN curl -L --silent --show-error --fail -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar \
    && curl -L --silent --show-error --fail -o /martin.tar.gz \
      https://github.com/maplibre/martin/releases/download/v0.17.0/martin-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf /martin.tar.gz -C /usr/local/bin \
    && rm /martin.tar.gz \
    && mkdir -p /data/sources

COPY --from=builder /data/pre-built-mostar.mbtiles /data/pre-built-mostar.mbtiles
