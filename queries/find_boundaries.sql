-- Find a boundary by place_id, return the geometry as GEOJson. Can use
-- jsonb_pretty() to pretty print output if desired
SELECT
  id,
  place_id,
  name,
  type,
  ST_AsGeoJSON (geom, 15)::jsonb AS "geometry"
FROM
  boundaries
WHERE
  place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI' -- Fremont
