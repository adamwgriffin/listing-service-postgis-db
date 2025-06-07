CREATE TABLE listing_statuses (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  label TEXT NOT NULL
);

INSERT INTO
  listing_statuses (name, label)
VALUES
  ('active', 'Active'),
  ('pending', 'Pending'),
  ('sold', 'Sold'),
  ('rented', 'Rented');
