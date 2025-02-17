insert into
  listings (
    place_id,
    line1,
    neighborhood,
    view,
    waterfront,
    geom
  )
values
  (
    'ChIJN8s8bakVkFQROOxDzEy1P_I',
    '213A North 39th Street',
    'Fremont',
    true,
    false,
    ST_SetSRID(
      ST_MakePoint(-122.35601516553109, 47.65388837211665),
      4326
    ) -- (longitude, latitude)
  );

-- Create a gallery for it
insert into
  photo_galleries (listing_id)
values
  (1);

-- Add an image to it
insert into
  photo_gallery_images (photo_gallery_id, url, caption, position)
values
  (
    1,
    '/gallery/J8uh5DvjaZy5/0.jpg',
    'Quisquam calculus conspergo cena stultus',
    0
  );

-- Use to test if listing is outside viewport bounds
insert into
  listings (
    place_id,
    line1,
    neighborhood,
    view,
    waterfront,
    geom
  )
values
  (
    'ChIJlZZrbAEVkFQRZgs3nJ58EYk',
    '3423 Albion Place North',
    'Fremont',
    false,
    false,
    ST_SetSRID(
      ST_MakePoint(-122.34514418290156, 47.64934749510021),
      4326
    ) -- (longitude, latitude)
  );

insert into
  photo_galleries (listing_id)
values
  (3);

insert into
  photo_gallery_images (photo_gallery_id, url, caption, position)
values
  (
    2,
    '/gallery/M7H-uAeIqRtr/0.jpg',
    'Bellum suppono vel delego vita aedificium',
    0
  ),
  (
    2,
    '/gallery/M7H-uAeIqRtr/1.jpg',
    'Beneficium surgo verus ascisco deinde confugo ustulo deduco',
    1
  ),
  (
    2,
    '/gallery/M7H-uAeIqRtr/2.jpg',
    'Suffragium creptio auditor turpis patria',
    2
  );

-- Magnolia
insert into
  listings (
    place_id,
    line1,
    neighborhood,
    view,
    waterfront,
    geom
  )
values
  (
    'EicyNTI5IDM0dGggQXZlIFcsIFNlYXR0bGUsIFdBIDk4MTk5LCBVU0EiGxIZChQKEgnBHeEohxWQVBHV_Cvk5OV0ZhDhEw',
    '2529 34th Avenue West',
    'Magnolia',
    false,
    true,
    ST_SetSRID(
      ST_MakePoint(-122.40100824723287, 47.64212579725229),
      4326
    )
  );

insert into
  photo_galleries (listing_id)
values
  (2);

insert into
  photo_gallery_images (photo_gallery_id, url, caption, position)
values
  (
    4,
    '/gallery/uXWM0AqqO2An/0.jpg',
    'Ducimus absque somnus summopere suus tenuis',
    0
  ),
  (
    4,
    '/gallery/uXWM0AqqO2An/1.jpg',
    'Reiciendis tamisium currus vel speculum subiungo',
    1
  );
