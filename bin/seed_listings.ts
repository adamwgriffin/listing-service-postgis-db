import fs from 'fs';
import path from 'path';
import { Client } from 'pg';
import dotenv from 'dotenv';
import type { ListingData } from '../lib/listing';

dotenv.config();

const filePath = path.join(__dirname, '..', 'data', 'fremont_listings.json');

const listings: ListingData[] = JSON.parse(fs.readFileSync(filePath, 'utf8'));

const propertyTypeMapping = {
  'single-family': 1,
  condo: 2,
  townhouse: 3,
  manufactured: 4,
  land: 5,
  'multi-family': 6
};

const propertyStatusMapping = {
  active: 1,
  pending: 2,
  sold: 3,
  rented: 4
};

const values = listings
  .map((l: ListingData) => {
    return `
    (
      '${l.placeId}',
      '${l.address.line1}',
      '${l.address.city}',
      'WA',
      '${l.address.zip}',
      ST_SetSRID(
        ST_MakePoint(
          ${l.geometry.coordinates[0]},
          ${l.geometry.coordinates[1]}
        ),
        4326
      ),
      '${l.neighborhood}',
      ${l.listPrice},
      ${l.soldPrice ?? 'NULL'},
      '${l.listedDate}',
      ${l.soldDate ? "'" + l.soldDate + "'" : 'NULL'},
      '${l.description}',
      ${l.beds},
      ${l.baths},
      ${l.sqft},
      ${l.lotSize},
      ${l.yearBuilt},
      ${Boolean(l.rental)},
      ${Boolean(l.waterfront)},
      ${Boolean(l.view)},
      ${Boolean(l.fireplace)},
      ${Boolean(l.basement)},
      ${Boolean(l.garage)},
      ${Boolean(l.newConstruction)},
      ${Boolean(l.pool)},
      ${Boolean(l.airConditioning)},
      ${
        propertyTypeMapping[l.propertyType as keyof typeof propertyTypeMapping]
      },
      ${propertyStatusMapping[l.status as keyof typeof propertyStatusMapping]},
      '${JSON.stringify(l.propertyDetails)}'::jsonb
    )
    `;
  })
  .join(', ');

const sql = `
  INSERT INTO
    listings (
      place_id,
      address_line_1,
      city,
      "state",
      zip,
      geom,
      neighborhood,
      list_price,
      sold_price,
      listed_date,
      sold_date,
      "description",
      beds,
      baths,
      sqft,
      lot_size,
      year_built,
      rental,
      waterfront,
      view,
      fireplace,
      basement,
      garage,
      new_construction,
      "pool",
      air_conditioning,
      property_type_id,
      listing_status_id,
      property_details
    )
  VALUES
    ${values};
`;

function createListingQuery(l: any) {}

const client = new Client({
  host: 'localhost',
  port: Number(process.env.POSTGRES_PORT),
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB
});

try {
  await client.connect();
  await client.query(sql);
  console.log('Listings seeded successfully.');
} catch (err) {
  console.error('Error seeding listings:', err);
} finally {
  await client.end();
}
