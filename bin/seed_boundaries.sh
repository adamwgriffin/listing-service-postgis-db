#!/bin/bash

SCRIPT_DIR="$(dirname "$0")"
BOUNDARIES_FILE="$SCRIPT_DIR/../data/boundaries.json"
POSTGRES_USER="root"
POSTGRES_PASSWORD="password"
POSTGRES_DB="listing_service"
DB_HOST="localhost"

VALUES=""
while read -r boundary; do
  # jq -r to extracts fields without quotes
  PLACE_ID=$(echo "$boundary" | jq -r '.placeId')
  NAME=$(echo "$boundary" | jq -r '.name' | sed "s/'/''/g")  # Escape single quotes
  TYPE=$(echo "$boundary" | jq -r '.type')
  # jq -c ensures that each JSON object is output as a single line
  GEOMETRY=$(echo "$boundary" | jq -c '.geometry')
  VALUES+="('$PLACE_ID', '$NAME', '$TYPE', ST_GeomFromGeoJSON('$GEOMETRY')),"
  # Redirecting the input this way avoids issues where the subshell created in
  # the loop doesn't have access to the VALUES variable after the loop exits
done < <(jq -c '.[]' "$BOUNDARIES_FILE")

# ${VALUES%,} removes the trailing comma
SQL="INSERT INTO boundaries (place_id, name, type, geom) VALUES ${VALUES%,};"

PGPASSWORD="$POSTGRES_PASSWORD" psql -d "$POSTGRES_DB" -U "$POSTGRES_USER" -h "$DB_HOST" -c "$SQL"
