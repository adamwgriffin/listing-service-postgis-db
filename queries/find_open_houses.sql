-- Only find listings that have a current open house
SELECT
  l.*,
  jsonb_agg_strict(pgi) AS photo_gallery
FROM
  listings l
  JOIN boundaries b ON ST_Contains(b.geom, l.geom)
  JOIN open_houses oh ON l.id = oh.listing_id
  LEFT JOIN photo_galleries pg ON l.id = pg.listing_id
  LEFT JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
WHERE
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI'
  AND oh.start_time >= CURRENT_DATE
GROUP BY
  l.id;

-- Using the LEFT JOIN LATERAL join for photo galleries
SELECT
  l.*,
  COALESCE(pg_agg.photo_gallery, '[]') AS photo_gallery
FROM
  listings l
  JOIN boundaries b ON ST_Contains(b.geom, l.geom)
  JOIN open_houses oh ON l.id = oh.listing_id
  LEFT JOIN LATERAL (
    SELECT
      jsonb_agg (pgi) AS photo_gallery
    FROM
      photo_galleries pg
      JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
    WHERE
      pg.listing_id = l.id
  ) AS pg_agg ON TRUE
WHERE
  b.place_id = 'ChIJ1WmlZawVkFQRmE1TlcKlxaI'
  AND oh.start_time >= CURRENT_DATE
GROUP BY
  l.id, pg_agg.photo_gallery;
