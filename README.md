# Listing Service Database

Putting together a database and some queries for a Listing Service using
PostGIS.

## Setup

1. Save .env.example as .env and change the credentials for Postgres as needed.

2. Run `docker compose up`.

3. Run `docker compose run --rm runner bin/setup_dev.sh`

## Migrations

Run `docker compose run --rm runner bin/migrate_create.sh` to create a new migration.

Run `docker compose run --rm runner bin/migrate_up.sh` to run all migrations.

Run `docker compose run --rm runner bin/migrate_down.sh` to drop all migrations.
