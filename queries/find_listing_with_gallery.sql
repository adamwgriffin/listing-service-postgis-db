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
  jsonb_agg_strict(pgi) AS photo_gallery
FROM
  listings l
  JOIN boundaries b ON ST_Contains(b.geom, l.geom)
  LEFT JOIN photo_galleries pg ON l.id = pg.listing_id
  LEFT JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
WHERE
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI'
GROUP BY
  l.id;

-- This version allows you to get only the specific fields you want without
-- them being returned as empty objects but is quite a bit more verbose
COALESCE(jsonb_agg(json_build_object(
  'url', pgi.url,
  'caption', pgi.caption,
  'position', pgi.position
)) FILTER (WHERE pgi IS NOT NULL), '[]') AS photo_gallery
