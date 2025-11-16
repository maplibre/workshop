#!/bin/bash
set -e

# NOTE: This script should be updated whenever the workshop location changes.
# Update the bounding box coordinates below.

# Bounding box coordinates (format: min_lon,min_lat,max_lon,max_lat)
MIN_LON=174.219297
MIN_LAT=-37.068435
MAX_LON=175.254758
MAX_LAT=-36.575944

OUTPUT_FILE="/data/sources/workshop.osm.pbf"
mkdir -p "$(dirname "${OUTPUT_FILE}")"

echo "Requesting OSM slice for bounding box..."
echo "BBox: ${MIN_LON},${MIN_LAT},${MAX_LON},${MAX_LAT}"

# Create GeoJSON polygon from bounding box
# Coordinates: [min_lon,min_lat], [max_lon,min_lat], [max_lon,max_lat], [min_lon,max_lat], [min_lon,min_lat]
GEOJSON_DATA=$(cat <<EOF
{
  "Name": "workshop-location",
  "RegionType": "geojson",
  "RegionData": {
    "type": "Polygon",
    "coordinates": [[
      [${MIN_LON},${MIN_LAT}],
      [${MAX_LON},${MIN_LAT}],
      [${MAX_LON},${MAX_LAT}],
      [${MIN_LON},${MAX_LAT}],
      [${MIN_LON},${MIN_LAT}]
    ]]
  }
}
EOF
)

# Submit the request
echo "Submitting request to OSM slice API..."
RESPONSE=$(curl -s -X POST https://slice.openstreetmap.us/api/ \
  -H "Content-Type: application/json" \
  -d "${GEOJSON_DATA}")

# Extract the job ID from the response
JOB_ID=$(echo "${RESPONSE}" | grep -o '[a-f0-9-]\{36\}' | head -1)

if [ -z "${JOB_ID}" ]; then
  echo "Error: Failed to get job ID from response:"
  echo "${RESPONSE}"
  exit 1
fi

echo "Job ID: ${JOB_ID}"
echo "Waiting for slice to be ready..."

# Poll the API until Complete is true
MAX_ATTEMPTS=60
ATTEMPT=0
while [ ${ATTEMPT} -lt ${MAX_ATTEMPTS} ]; do
  STATUS=$(curl -s "https://slice.openstreetmap.us/api/${JOB_ID}")
  
  if echo "${STATUS}" | grep -q '"Complete":true'; then
    echo "Slice is ready!"
    break
  fi
  
  if echo "${STATUS}" | grep -q '"Complete":false'; then
    ATTEMPT=$((ATTEMPT + 1))
    echo "Waiting... (attempt ${ATTEMPT}/${MAX_ATTEMPTS})"
    sleep 5
  else
    echo "Error: Unexpected response:"
    echo "${STATUS}"
    exit 1
  fi
done

if [ ${ATTEMPT} -ge ${MAX_ATTEMPTS} ]; then
  echo "Error: Timeout waiting for slice to complete"
  exit 1
fi

# Download the file
echo "Downloading slice to ${OUTPUT_FILE}..."
curl -s "https://slice.openstreetmap.us/files/${JOB_ID}.osm.pbf" -o "${OUTPUT_FILE}"

if [ ! -f "${OUTPUT_FILE}" ] || [ ! -s "${OUTPUT_FILE}" ]; then
  echo "Error: Failed to download file or file is empty"
  exit 1
fi

echo "Successfully downloaded ${OUTPUT_FILE}"
ls -lh "${OUTPUT_FILE}"
