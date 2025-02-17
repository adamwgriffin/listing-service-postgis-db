CREATE TABLE listings (
  id SERIAL PRIMARY KEY,
  place_id TEXT,
  slug VARCHAR(800) UNIQUE NOT NULL,
  address_line_1 VARCHAR(255) NOT NULL,
  address_line_2 VARCHAR(255),
  city VARCHAR(255) NOT NULL,
  state CHAR(2) NOT NULL,
  zip VARCHAR(30) NOT NULL,
  geom GEOMETRY(POINT, 4326) NOT NULL,
  neighborhood VARCHAR(255),
  list_price INTEGER NOT NULL,
  sold_price INTEGER,
  listed_date TIMESTAMP WITH TIME ZONE NOT NULL,
  sold_date TIMESTAMP WITH TIME ZONE,
  property_type_id INTEGER NOT NULL,
  listing_status_id INTEGER NOT NULL,
  description VARCHAR(5000),
  beds INTEGER NOT NULL DEFAULT 0,
  baths INTEGER NOT NULL DEFAULT 0,
  sqft INTEGER,
  lot_size INTEGER,
  year_built INTEGER,
  rental BOOLEAN NOT NULL DEFAULT false,
  waterfront BOOLEAN NOT NULL DEFAULT false,
  view BOOLEAN NOT NULL DEFAULT false,
  fireplace BOOLEAN NOT NULL DEFAULT false,
  basement BOOLEAN NOT NULL DEFAULT false,
  garage BOOLEAN NOT NULL DEFAULT false,
  new_construction BOOLEAN NOT NULL DEFAULT false,
  pool BOOLEAN NOT NULL DEFAULT false,
  air_conditioning BOOLEAN NOT NULL DEFAULT false,
  FOREIGN KEY (property_type_id) REFERENCES property_types(id),
  FOREIGN KEY (listing_status_id) REFERENCES listing_statuses(id)
);

COMMENT ON COLUMN listings.place_id IS 'The Google Maps geocoder place_id.';

COMMENT ON COLUMN listings.geom IS 'The lat/lng for the listing. Using SRID 4326 ensures compatibility with GeoJSON (WGS 84)';

CREATE INDEX listings_geom_idx ON listings USING GIST(geom);

CREATE INDEX listings_place_id_idx ON listings(place_id);