CREATE TABLE listings (
  id SERIAL PRIMARY KEY,
  place_id TEXT,
  line1 TEXT NOT NULL,
  geom GEOMETRY(POINT, 4326) NOT NULL,
  neighborhood TEXT,
  view BOOLEAN NOT NULL DEFAULT false,
  waterfront BOOLEAN NOT NULL DEFAULT false
);

CREATE INDEX listings_geom_idx ON listings USING GIST(geom);

CREATE INDEX boundaries_place_id_idx ON boundaries(place_id);
