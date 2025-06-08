import fs from 'fs';
import path from 'path';
import { Client } from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const filePath = path.join(__dirname, '..', 'data', 'boundaries.json');

const boundaries = JSON.parse(fs.readFileSync(filePath, 'utf8'));

const values = boundaries
  .map((boundary: any) => {
    const geometry = JSON.stringify(boundary.geometry);
    return `('${boundary.placeId}', '${boundary.name}', 1, ST_GeomFromGeoJSON('${geometry}'))`;
  })
  .join(',');

const sql = `INSERT INTO boundaries (place_id, name, boundary_type_id, geom) VALUES ${values};`;

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
  console.log('Boundaries seeded successfully.');
} catch (err) {
  console.error('Error seeding boundaries:', err);
} finally {
  await client.end();
}
