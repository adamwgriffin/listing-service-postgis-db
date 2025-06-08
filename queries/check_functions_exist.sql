SELECT
  EXISTS (
    SELECT
      1
    FROM
      pg_proc
    WHERE
      proname = 'set_updated_at'
  );

SELECT
  EXISTS (
    SELECT
      1
    FROM
      pg_extension
    WHERE
      extname = 'unaccent'
  );

SELECT
  EXISTS (
    SELECT
      1
    FROM
      pg_proc
    WHERE
      proname = 'generate_unique_slug'
  );

SELECT
  EXISTS (
    SELECT
      1
    FROM
      pg_proc
    WHERE
      proname = 'generate_slug_trigger_function'
  );
