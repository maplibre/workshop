FROM ubuntu:24.04

RUN apt-get update

RUN apt-get install -y --no-install-recommends \
      curl \
      openjdk-21

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /data

RUN curl -L -o /planetiler.jar \
      https://github.com/onthegomap/planetiler/releases/download/v0.9.0/planetiler.jar

RUN chmod +x /planetiler.jar

RUN curl -L -o /data/massachusetts-latest.osm.pbf \
      https://download.geofabrik.de/north-america/us/massachusetts-latest.osm.pbf
