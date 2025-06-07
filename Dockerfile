FROM python:latest

WORKDIR /workspace

RUN pip install --no-cache-dir psycopg2-binary