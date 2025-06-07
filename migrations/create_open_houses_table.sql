CREATE TABLE open_houses (
  id SERIAL PRIMARY KEY,
  listing_id INTEGER NOT NULL,
  start_time TIMESTAMP WITH TIME ZONE,
  end_time TIMESTAMP WITH TIME ZONE,
  comments TEXT,
  FOREIGN KEY (listing_id) REFERENCES listings(id) ON DELETE CASCADE
);
