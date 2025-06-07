#!/usr/bin/env python3

import os
import json
import psycopg2

script_dir = os.path.dirname(os.path.abspath(__file__))
boundaries_file = os.path.join(script_dir, "../data/boundaries.json")
db_host = "localhost"
db_name = "listing_service"
db_user = "root"
db_password = "password"

with open(boundaries_file, "r") as f:
  boundaries = json.load(f)

values = []
for boundary in boundaries:
  place_id = boundary["placeId"]
  # Escape single quotes for SQL
  name = boundary["name"].replace("'", "''")
  geometry = json.dumps(boundary["geometry"])
  values.append(
      f"('{place_id}', '{name}', 1, ST_GeomFromGeoJSON('{geometry}'))")

values_sql = ", ".join(values)
sql = f"INSERT INTO boundaries (place_id, name, boundary_type_id, geom) VALUES {values_sql};"

conn = psycopg2.connect(
    dbname=os.environ.get("POSTGRES_DB"),
    user=os.environ.get("POSTGRES_USER"),
    password=os.environ.get("POSTGRES_PASSWORD"),
    host=os.environ.get("POSTGRES_HOST"),
    port=os.environ.get("POSTGRES_PORT"),
)

with conn:
  with conn.cursor() as cur:
    cur.execute(sql)
    print("Boundaries seeded successfully.")

conn.close()
