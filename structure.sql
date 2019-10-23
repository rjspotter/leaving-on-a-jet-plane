/*
SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

-- CREATE SCHEMA ingress;

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA public;

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

SET default_tablespace = '';

SET default_with_oids = false;
*/
CREATE TABLE public.flights (
  TRANSACTIONID int NOT NULL,
  FLIGHTDATE integer,
  AIRLINECODE character varying,
  AIRLINENAME character varying,
  TAILNUM character varying,
  FLIGHTNUM integer,
  ORIGINAIRPORTCODE character varying,
  ORIGAIRPORTNAME character varying,
  ORIGINCITYNAME character varying,
  ORIGINSTATE character varying,
  ORIGINSTATENAME character varying,
  DESTAIRPORTCODE character varying,
  DESTAIRPORTNAME character varying,
  DESTCITYNAME character varying,
  DESTSTATE character varying,
  DESTSTATENAME character varying,
  CRSDEPTIME integer,
  DEPTIME integer,
  DEPDELAY integer,
  TAXIOUT integer,
  WHEELSOFF integer,
  WHEELSON integer,
  TAXIIN integer,
  CRSARRTIME integer,
  ARRTIME integer,
  ARRDELAY integer,
  CRSELAPSEDTIME integer,
  ACTUALELAPSEDTIME integer,
  CANCELLED  character varying,
  DIVERTED character varying,
  DISTANCE character varying
);
ALTER TABLE ONLY public.flights ADD CONSTRAINT flights_pkey PRIMARY KEY (TRANSACTIONID);

-- Airlines
CREATE SEQUENCE public.airlines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.airlines (
  id integer not null default nextval('airlines_id_seq'),
  code character varying NOT NULL,
  description character varying NOT NULL
);

ALTER TABLE ONLY public.airlines ADD CONSTRAINT airlines_pkey PRIMARY KEY (id);

insert into public.airlines (code, description) select distinct AIRLINECODE, AIRLINENAME from public.flights;


-- Planes

CREATE SEQUENCE public.planes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.planes (
  id integer not null default nextval('planes_id_seq'),
  tail_number character varying NOT NULL UNIQUE,
  valid boolean not null default true
);
ALTER TABLE ONLY public.planes ADD CONSTRAINT planes_pkey PRIMARY KEY (id);

insert into public.planes (tail_number)
select distinct REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1')
from flights where REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') is not null;

-- Flights Cleaned

CREATE TABLE public.flights_cleaned (
  TRANSACTIONID int NOT NULL,
  FLIGHTDATE date,
  airline_id integer NOT NULL,
  plane_id integer
);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_airline FOREIGN KEY (airline_id) REFERENCES public.airlines(id);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_plane FOREIGN KEY (plane_id) REFERENCES public.planes(id);


insert into flights_cleaned SELECT
    TRANSACTIONID,
    TO_DATE(CAST(FLIGHTDATE as varchar), 'YYYYMMDD'),
    airlines.id,
    planes.id
  from public.flights
  left outer join public.airlines on public.flights.AIRLINECODE = public.airlines.CODE
  left outer join public.planes on REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') = planes.tail_number;
