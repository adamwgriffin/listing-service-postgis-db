import fs from 'fs';
import path from 'path';
import { Client } from 'pg';
import dotenv from 'dotenv';
import type { ListingData, OpenHouse, PhotoGalleryImage } from '../lib/listing';

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

function listingInsertValues(l: ListingData) {
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
}

function listingInsertQuery(listing: ListingData) {
  return `
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
      ${listingInsertValues(listing)}
    RETURNING
      id;
  `;
}

function photoGalleryInsertQuery(listingId: number) {
  return `
    INSERT INTO
      photo_galleries (listing_id)
    VALUES
      (${listingId})
    RETURNING
      id;
  `;
}

function photoGalleryImageInsertQuery(
  photoGalleryId: number,
  gallery: PhotoGalleryImage[]
) {
  const values = gallery
    .map((image, index) => {
      return `
      (
        ${photoGalleryId},
        '${image.url}',
        '${image.caption}',
        ${index}
      )
    `;
    })
    .join(', ');
  return `
    INSERT INTO
      photo_gallery_images (photo_gallery_id, url, caption, position)
    VALUES
      ${values};
  `;
}

function openHouseInsertQuery(listingId: number, openHouses: OpenHouse[]) {
  const values = openHouses
    .map((o) => {
      return `
      (
        ${listingId},
        '${o.start}',
        '${o.end}',
        ${o.comments ? "'" + o.comments + "'" : 'NULL'}
      )
    `;
    })
    .join(', ');
  return `
    INSERT INTO
      open_houses (listing_id, start_time, end_time, comments)
    VALUES
      ${values};
  `;
}

dotenv.config();

const client = new Client({
  host: 'localhost',
  port: Number(process.env.POSTGRES_PORT),
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB
});

try {
  const filePath = path.join(__dirname, '..', 'data', 'fremont_listings.json');
  const listings: ListingData[] = JSON.parse(fs.readFileSync(filePath, 'utf8'));

  await client.connect();

  for (const listing of listings) {
    const listingRes = await client.query(listingInsertQuery(listing));
    const listingId = listingRes.rows[0].id;
    if (listing.photoGallery) {
      const photoGalleryRes = await client.query(
        photoGalleryInsertQuery(listingId)
      );
      const imageQuery = photoGalleryImageInsertQuery(
        photoGalleryRes.rows[0].id,
        listing.photoGallery
      );
      await client.query(imageQuery);
    }
    if (listing.openHouses?.length) {
      const openHouseQuery = openHouseInsertQuery(
        listingId,
        listing.openHouses
      );
      await client.query(openHouseQuery);
    }
  }
  console.log('Listings seeded successfully.');
} catch (err) {
  console.error('Error seeding listings:', err);
} finally {
  await client.end();
}
