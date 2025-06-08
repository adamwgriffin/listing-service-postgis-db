CREATE TABLE
  boundary_types (id serial PRIMARY KEY, NAME TEXT UNIQUE NOT NULL);

INSERT INTO
  boundary_types (NAME)
VALUES
  ('neighborhood'),
  ('city'),
  ('zip_code'),
  ('county'),
  ('state'),
  ('country'),
  ('school_district'),
  ('school');
