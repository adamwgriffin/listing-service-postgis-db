-- Find a boundary by place_id, return the geometry as GEOJson. Can use
-- jsonb_pretty() to pretty print output if desired
SELECT
  b.id,
  b.place_id,
  b."name",
  bt."name" AS "type",
  ST_AsGeoJSON(geom, 15)::jsonb AS "geometry"
FROM
  boundaries b
  JOIN boundary_types bt ON b.boundary_type_id = bt.id
WHERE
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI' -- Fremont