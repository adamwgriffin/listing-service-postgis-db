-- Include the current open houses in the listing detail. Using a subquery (CTE)
-- prevents results in the jsonb_agg() function from getting duplicated, as they
-- were when we had the aggregate function inside the main SELECT. This was
-- happening because multiple photo gallery image records were returned, which
-- returns a row for each joined image. The jsonb_agg for open_houses was then
-- duplicating the one open house for each row returned.
-- 
-- We're putting the subquery inside of a LEFT JOIN LATERAL because it's
-- supposed to have the best performance. LATERAL allows you to treat the
-- subquery that follows as a table that can be joined with the preceding table
-- (in this case, listings). It allows the subquery to reference columns from
-- the preceding table (like l.id), making it a correlated subquery, but with
-- better performance characteristics.
SELECT
  l.id,
  l.list_price,
  l.sold_price,
  l.listed_date,
  l.sold_date,
  EXTRACT(DAY FROM (NOW() - l.listed_date)) AS days_on_market,
  l.address_line_1,
  l.address_line_2,
  l.city,
  l.state,
  l.zip,
  ST_Y (l.geom) AS latitude,
  ST_X (l.geom) AS longitude,
  l.neighborhood,
  ls.label AS "status",
  pt.label AS property_type,
  l.description,
  l.beds,
  l.baths,
  l.sqft,
  l.lot_size,
  l.year_built,
  l.rental,
  l.waterfront,
  l.view,
  l.fireplace,
  l.basement,
  l.garage,
  l.new_construction,
  l.pool,
  l.air_conditioning,
  COALESCE(pg_agg.photo_gallery, '[]') AS photo_gallery,
  COALESCE(oh_agg.open_houses, '[]') AS open_houses,
  l.property_details
FROM
  listings l
  LEFT JOIN listing_statuses ls ON l.listing_status_id = ls.id
  LEFT JOIN property_types pt ON l.property_type_id = pt.id
  LEFT JOIN LATERAL (
    SELECT
      jsonb_agg(jsonb_build_object('url', pgi.url, 'caption', pgi.caption)) AS photo_gallery
    FROM
      photo_galleries pg
      JOIN photo_gallery_images pgi ON pg.id = pgi.photo_gallery_id
    WHERE
      pg.listing_id = l.id
  ) AS pg_agg ON TRUE
  LEFT JOIN LATERAL (
    SELECT
      jsonb_agg(jsonb_build_object('start', oh.start_time, 'end', oh.end_time, 'comments', oh.comments)) AS open_houses
    FROM
      open_houses oh
    WHERE
      oh.listing_id = l.id
            AND oh.start_time >= CURRENT_DATE
  ) AS oh_agg ON TRUE
WHERE
  l.id = 18;
