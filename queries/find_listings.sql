-- Find Listings Inside a Boundary
SELECT
  l.*
FROM
  listings l
  JOIN boundaries b ON ST_Contains(b.geom, l.geom)
WHERE
  -- Fremont
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI';

-- Find listings within the bounds of the viewport without any boundary.
-- Viewport bounds
-- south: 47.633287
-- west: -122.39988
-- north: 47.670059
-- east: -122.347695
--
-- The ST_MakeEnvelope function creates a rectangular Polygon from the minimum
-- and maximum values for X and Y:
--
-- ST_MakeEnvelope(float xmin, float ymin, float xmax, float ymax, integer
-- srid=unknown)
--
-- How to use our viewport bounds with this function:
--
-- ST_MakeEnvelope(west, south, east, north, srid)
SELECT
  *
FROM
  listings
WHERE
  ST_Contains(
    ST_MakeEnvelope(
      -122.39988,
      47.633287,
      -122.347695,
      47.670059,
      4326
    ),
    geom
  );

-- Find listings within a boundary, excluding the bounds of the viewport
SELECT
  l.*
FROM
  listings l
  JOIN boundaries b ON ST_Contains(b.geom, l.geom)
WHERE
  -- Fremont
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI'
  AND ST_Contains(
    ST_MakeEnvelope(
      -122.39988,
      47.633287,
      -122.347695,
      47.670059,
      4326
    ),
    l.geom
  );
