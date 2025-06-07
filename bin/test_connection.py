#!/usr/bin/env python3

import os
import psycopg2

try:
  conn = psycopg2.connect(
      dbname=os.environ.get("POSTGRES_DB"),
      user=os.environ.get("POSTGRES_USER"),
      password=os.environ.get("POSTGRES_PASSWORD"),
      host=os.environ.get("POSTGRES_HOST"),
      port=os.environ.get("POSTGRES_PORT"),
  )
  print("Connection to PostgreSQL was successful!")
  conn.close()
except Exception as e:
  print("Failed to connect to PostgreSQL:", e)
