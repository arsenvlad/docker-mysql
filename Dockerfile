ARG MYSQL_VERSION=8.0.19

FROM mysql:${MYSQL_VERSION} AS builder

# Script that will run during container start up to create the databases, tables, views, and users
COPY setup.sql /docker-entrypoint-initdb.d/

