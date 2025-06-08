import type { Point } from "geojson";

export const PropertyTypes = [
  'single-family',
  'condo',
  'townhouse',
  'manufactured',
  'land',
  'multi-family'
] as const;

export const PropertyStatuses = ['active', 'pending', 'sold'] as const;

export const RentalPropertyStatuses = ['active', 'rented'] as const;

export const AllPropertyStatuses = [...PropertyStatuses, 'rented'] as const;

export type PropertyType = (typeof PropertyTypes)[number];

export type PropertyStatus = (typeof AllPropertyStatuses)[number];

export interface ListingAddress {
  line1: string;
  line2?: string;
  city: string;
  state: string;
  zip: string;
}

export interface PhotoGalleryImage {
  url: string;
  caption?: string;
}

export interface PropertDetail {
  name: string;
  details: string[];
}

export interface PropertDetailsSection {
  name: string;
  description?: string;
  details: PropertDetail[];
}

export interface OpenHouse {
  start: Date;
  end: Date;
  comments?: string;
}

export interface ListingAmenities {
  waterfront?: boolean;
  view?: boolean;
  fireplace?: boolean;
  basement?: boolean;
  garage?: boolean;
  newConstruction?: boolean;
  pool?: boolean;
  airConditioning?: boolean;
}

export interface IListing extends ListingAmenities {
  listPrice: number;
  soldPrice?: number;
  listedDate: Date;
  soldDate?: Date;
  address: ListingAddress;
  slug: string;
  geometry: Point;
  placeId?: string;
  neighborhood: string;
  propertyType: PropertyType;
  status: PropertyStatus;
  description?: string;
  beds: number;
  baths: number;
  sqft: number;
  lotSize: number;
  yearBuilt: number;
  rental?: boolean;
  photoGallery?: PhotoGalleryImage[];
  propertyDetails?: PropertDetailsSection[];
  openHouses?: OpenHouse[];
}

export type ListingData = Omit<IListing, "slug">;
