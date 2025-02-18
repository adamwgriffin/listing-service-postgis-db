CREATE TABLE open_houses (
  id SERIAL PRIMARY KEY,
  listing_id INTEGER NOT NULL,
  start_time TIMESTAMP WITH TIME ZONE,
  end_time TIMESTAMP WITH TIME ZONE,
  comments VARCHAR(255),
  FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);
