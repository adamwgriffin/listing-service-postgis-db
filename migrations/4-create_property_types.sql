CREATE TABLE property_types (
  id SERIAL PRIMARY KEY,
  name TEXT UNIQUE NOT NULL,
  label TEXT NOT NULL
);

INSERT INTO
  property_types (name, label)
VALUES
  ('single-family', 'House'),
  ('condo', 'Condo'),
  ('townhouse', 'Townhouse'),
  ('manufactured', 'Manufactured'),
  ('land', 'Land'),
  ('multi-family', 'Multi-Family');
