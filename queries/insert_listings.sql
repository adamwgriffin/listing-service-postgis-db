INSERT INTO
  listings (
    place_id,
    address_line_1,
    city,
    "state",
    zip,
    neighborhood,
    list_price,
    listed_date,
    property_type_id,
    listing_status_id,
    "description",
    beds,
    baths,
    sqft,
    lot_size,
    year_built,
    view,
    waterfront,
    geom
  )
VALUES
  (
    'ChIJN8s8bakVkFQROOxDzEy1P_I',
    '213A North 39th Street',
    'Seattle',
    'WA',
    '98103',
    'Fremont',
    478000,
    '2024-11-11T14:10:50.675Z',
    5,
    1,
    'Tondeo thorax amiculum angustus. Adhaero sono sponte surculus ventus cribro auditor. Auctor vito custodia acies.',
    0,
    0,
    1600,
    2700,
    1992,
    true,
    false,
    ST_SetSRID(
      ST_MakePoint(-122.35601516553109, 47.65388837211665),
      4326
    ) -- (longitude, latitude)
  )
RETURNING
  id;

-- Create a gallery for it
INSERT INTO
  photo_galleries (listing_id)
VALUES
  (1)
RETURNING
  id;

-- Add an image to it
INSERT INTO
  photo_gallery_images (photo_gallery_id, url, caption, position)
VALUES
  (
    5,
    '/gallery/J8uh5DvjaZy5/0.jpg',
    'Quisquam calculus conspergo cena stultus',
    0
  );

-- Add open houses
INSERT INTO
  open_houses (listing_id, start_time, end_time, comments)
  VALUES
    (
      10,
      '2024-12-18T12:39:09.452Z',
      '2024-12-18T14:39:09.452Z',
      'Terga color ver impedit civis clementia ab numquam.'
    ),
    (
      10,
      '2025-02-04T01:42:51.607Z',
      '2025-02-04T07:42:51.607Z',
      'Ad toties usitas trepide campana beatae synagoga.'
    ),
    (
      10,
      '2025-02-28T15:37:39.947Z',
      '2025-02-28T20:37:39.947Z',
      'Cito terror admitto iure tamquam accusator.'
    ),
    (
      10,
      '2025-03-02T17:13:25.587Z',
      '2025-03-02T20:13:25.587Z',
      'Tibi adiuvo audio occaecati.'
    );

-- Fremont - Use to test if listing is outside viewport bounds
INSERT INTO
  listings (
    place_id,
    address_line_1,
    city,
    "state",
    zip,
    neighborhood,
    list_price,
    listed_date,
    property_type_id,
    listing_status_id,
    "description",
    beds,
    baths,
    sqft,
    lot_size,
    year_built,
    view,
    waterfront,
    geom
  )
VALUES
  (
    'ChIJlZZrbAEVkFQRZgs3nJ58EYk',
    '3423 Albion Place North',
    'Seattle',
    'WA',
    '98103',
    'Fremont',
    386000,
    '2024-08-30T21:25:23.613Z',
    4,
    1,
    'Coepi nulla surculus viridis sapiente dicta adeptio nobis dolor.',
    4,
    2,
    1400,
    1300,
    1943,
    false,
    false,
    ST_SetSRID(
      ST_MakePoint(-122.34514418290156, 47.64934749510021),
      4326
    ) -- (longitude, latitude)
  );

INSERT INTO
  photo_galleries (listing_id)
VALUES
  (12);

INSERT INTO
  photo_gallery_images (photo_gallery_id, url, caption, position)
VALUES
  (
    6,
    '/gallery/M7H-uAeIqRtr/0.jpg',
    'Bellum suppono vel delego vita aedificium',
    0
  ),
  (
    6,
    '/gallery/M7H-uAeIqRtr/1.jpg',
    'Beneficium surgo verus ascisco deinde confugo ustulo deduco',
    1
  ),
  (
    6,
    '/gallery/M7H-uAeIqRtr/2.jpg',
    'Suffragium creptio auditor turpis patria',
    2
  );

INSERT INTO
  open_houses (listing_id, start_time, end_time, comments)
  VALUES
    (
      12,
      '2024-12-12T12:46:32.978Z',
      '2024-12-12T16:46:32.978Z',
      'Conqueror ventus solvo urbs depono quasi dignissimos auditor temperantia.'
    );


-- Magnolia
INSERT INTO
  listings (
    place_id,
    line1,
    neighborhood,
    view,
    waterfront,
    geom
  )
VALUES
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

INSERT INTO
  photo_galleries (listing_id)
VALUES
  (2);

INSERT INTO
  photo_gallery_images (photo_gallery_id, url, caption, position)
VALUES
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
