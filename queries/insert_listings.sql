insert into listings (line1, neighborhood, geom)
values (
  '213A North 39th Street',
  'Fremont',
  ST_SetSRID(ST_MakePoint(-122.35601516553109, 47.65388837211665), 4326) -- (longitude, latitude)
);

-- Use to test if listing is outside viewport bounds
insert into listings (line1, neighborhood, geom)
values (
  '3423 Albion Place North',
  'Fremont',
  ST_SetSRID(ST_MakePoint(-122.34514418290156, 47.64934749510021), 4326) -- (longitude, latitude)
);

insert into listings (line1, neighborhood, geom)
values (
  '2529 34th Avenue West',
  'Magnolia',
  ST_SetSRID(ST_MakePoint(-122.40100824723287, 47.64212579725229), 4326)
);
