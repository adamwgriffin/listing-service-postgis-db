SELECT
  jsonb_agg(
    json_build_object(
      'url', pgi.url,
      'caption', pgi.caption,
      'position', pgi.position
    )
  ) AS photo_gallery
FROM
  listings l
  JOIN photo_galleries pg ON l.id = pg.listing_id
  JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
WHERE
  l.id = 3
GROUP BY
  l.id,
  pg.id;

-- inside boundary
SELECT
  l.*,
  jsonb_agg(
    json_build_object(
      'url', pgi.url,
      'caption', pgi.caption,
      'position', pgi.position
    )
  ) AS photo_gallery
FROM
  listings l
  JOIN boundaries b ON ST_Contains (b.geom, l.geom)
  JOIN photo_galleries pg ON l.id = pg.listing_id
  JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
WHERE
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI'
GROUP BY
  l.id,
  pg.id;