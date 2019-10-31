FROM postgres:11.5

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD simple
ENV POSTGRES_DB warehouse

COPY bootstrap.sql /docker-entrypoint-initdb.d/000_bootstrap.sql
COPY structure.sql /docker-entrypoint-initdb.d/001_structure.sql

