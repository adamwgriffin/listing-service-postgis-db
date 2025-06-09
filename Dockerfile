FROM oven/bun:latest

WORKDIR /workspace

COPY . .

RUN apt-get update && apt-get install curl -y

RUN curl -L https://github.com/golang-migrate/migrate/releases/download/v4.18.3/migrate.linux-amd64.tar.gz \
    | tar xvz -C /usr/local/bin migrate

RUN bun install
