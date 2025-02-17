create table boundary_types (
  id serial PRIMARY key,
  name VARCHAR(50) UNIQUE NOT NULL
);

insert into
  boundary_types (name)
values
  ('neighborhood'),
  ('city'),
  ('zip_code'),
  ('county'),
  ('state'),
  ('country'),
  ('school_district'),
  ('school');
