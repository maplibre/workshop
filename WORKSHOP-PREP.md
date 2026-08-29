# Steps for Workshop Presenters

* Update bbox in `.devcontainer/download_osm_slice.sh`
* Update the tag (after the ':' symbol) in the `image` field in `.devcontainer/docker-compose.yml` for `ghcr.io/maplibre/workshop:...` value
* Push as a new branch
* Open https://github.com/maplibre/workshop/actions/workflows/docker-ghcr-push.yml
* Click "Run workflow", select your branch, and use a descriptive name for the docker image.  Only use `latest` if you push your changes to the `main` branch later. 
