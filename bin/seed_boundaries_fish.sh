#!/usr/bin/env fish

set script_dir (dirname (status --current-filename))
set boundaries_file "$script_dir/../data/boundaries.json"
# set db_host "database"
set db_host "localhost"
set values ""

for boundary in (jq -c '.[]' $boundaries_file)
  # jq -r to extracts fields without quotes
  set place_id (echo $boundary | jq -r '.placeId')
  # Escape single quotes with sed
  set name (echo $boundary | jq -r '.name' | sed "s/'/''/g")
  set type (echo $boundary | jq -r '.type')
  # jq -c ensures that each JSON object is output as a single line
  set geometry (echo $boundary | jq -c '.geometry')
  set values "$values ('$place_id', '$name', '$type', ST_GeomFromGeoJSON('$geometry')),"
end

set values (string trim --chars ',' $values)
set sql "INSERT INTO boundaries (place_id, name, type, geom) VALUES $values;"

# env PGPASSWORD=$POSTGRES_PASSWORD psql -d $POSTGRES_DB -U $POSTGRES_USER -h $db_host -c $sql
env PGPASSWORD=password psql -d listing_service -U root -h $db_host -c $sql
