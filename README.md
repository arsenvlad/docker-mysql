# Docker MySQL

Example of docker-compose creating a MySQL server with a few simple databases, tables, views, and users.

## Prerequisite

- docker
- docker-compose

## Build

```bash
docker-compose -f docker-compose.yml build
```

## Start

```bash
docker-compose -f docker-compose.yml up -d
```

## Stop

```bash
docker-compose -f docker-compose.yml down --volumes --remove-orphans
```

## Use

Open <http://localhost:8183/> to see the "adminer" user interface and login with username "root" and password "my-secure-pw"
