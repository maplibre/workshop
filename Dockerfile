FROM ghcr.io/onthegomap/planetiler:0.9.1-snapshot

USER root
RUN apk add --no-cache curl \
    && mkdir -p /data \
    && curl -sSL \
      https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf \
      -o /data/massachusetts-latest.osm.pbf

VOLUME /data