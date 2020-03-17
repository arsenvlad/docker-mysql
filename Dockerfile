ARG MYSQL_VERSION=8.0.19

FROM mysql:${MYSQL_VERSION} AS builder

# Scripts that will run during container start up to create the databases, tables, views, and users
COPY 01_create_three_simple_dbs.sql /docker-entrypoint-initdb.d/
COPY 02_create_ecommerce_db.sql /docker-entrypoint-initdb.d/

