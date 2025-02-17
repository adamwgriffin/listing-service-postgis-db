CREATE TABLE photo_galleries (
  id SERIAL PRIMARY KEY,
  listing_id INT NOT NULL UNIQUE,
  FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);
