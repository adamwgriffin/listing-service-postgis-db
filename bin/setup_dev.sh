#!/bin/bash

migrate -database $DATABASE_URL -path migrations up &&
  bin/seed_boundaries.ts &&
  bin/seed_listings.ts
