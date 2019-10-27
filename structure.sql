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
  TRANSACTIONID INT NOT NULL,
  FLIGHTDATE INTEGER,
  AIRLINECODE CHARACTER VARYING,
  AIRLINENAME CHARACTER VARYING,
  TAILNUM CHARACTER VARYING,
  FLIGHTNUM INTEGER,
  ORIGINAIRPORTCODE CHARACTER VARYING,
  ORIGAIRPORTNAME CHARACTER VARYING,
  ORIGINCITYNAME CHARACTER VARYING,
  ORIGINSTATE CHARACTER VARYING,
  ORIGINSTATENAME CHARACTER VARYING,
  DESTAIRPORTCODE CHARACTER VARYING,
  DESTAIRPORTNAME CHARACTER VARYING,
  DESTCITYNAME CHARACTER VARYING,
  DESTSTATE CHARACTER VARYING,
  DESTSTATENAME CHARACTER VARYING,
  CRSDEPTIME INTEGER,
  DEPTIME INTEGER,
  DEPDELAY INTEGER,
  TAXIOUT INTEGER,
  WHEELSOFF INTEGER,
  WHEELSON INTEGER,
  TAXIIN INTEGER,
  CRSARRTIME INTEGER,
  ARRTIME INTEGER,
  ARRDELAY INTEGER,
  CRSELAPSEDTIME INTEGER,
  ACTUALELAPSEDTIME INTEGER,
  CANCELLED  CHARACTER VARYING,
  DIVERTED CHARACTER VARYING,
  DISTANCE CHARACTER VARYING
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
  id INTEGER NOT NULL DEFAULT nextval('airlines_id_seq'),
  code CHARACTER VARYING NOT NULL,
  description CHARACTER VARYING NOT NULL,
  notes CHARACTER VARYING
);

ALTER TABLE ONLY public.airlines ADD CONSTRAINT airlines_pkey PRIMARY KEY (id);

INSERT
  INTO public.airlines (
  code,
  description,
  notes)
SELECT
  DISTINCT AIRLINECODE,
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '1'),
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '2')
FROM
  public.flights;


-- Planes

CREATE SEQUENCE public.planes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.planes (
  id INTEGER NOT NULL DEFAULT nextval('planes_id_seq'),
  tail_number CHARACTER VARYING NOT NULL UNIQUE,
  valid BOOLEAN NOT NULL DEFAULT TRUE
);
ALTER TABLE ONLY public.planes ADD CONSTRAINT planes_pkey PRIMARY KEY (id);

INSERT INTO public.planes (tail_number)
SELECT DISTINCT REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1')
FROM flights WHERE REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') IS NOT NULL;


-- Airports
CREATE SEQUENCE public.airports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.airports (
  id INTEGER NOT NULL DEFAULT nextval('airports_id_seq'),
  code CHARACTER VARYING NOT NULL UNIQUE,
  name CHARACTER VARYING NOT NULL,
  city CHARACTER VARYING,
  STATE CHARACTER VARYING,
  state_name CHARACTER VARYING
);
ALTER TABLE ONLY public.airports ADD CONSTRAINT airports_pkey PRIMARY KEY (id);

INSERT
 INTO public.airports(
 code,
 "name",
 city,
 STATE,
 state_name
)
SELECT
 DISTINCT originairportcode,
 SPLIT_PART(origairportname, ': ', '2'),
 origincityname,
 originstate,
 originstatename
FROM
  flights
;

INSERT
 INTO public.airports(
 code,
 NAME,
 city,
 STATE,
 state_name
)
SELECT
 DISTINCT destairportcode,
 SPLIT_PART(destairportname, ': ', '2'),
 destcityname,
 deststate,
 deststatename
FROM
  flights
WHERE
  destairportcode NOT IN
    (SELECT
      DISTINCT code FROM airports)
;

-- Flights Cleaned

CREATE TABLE public.flights_cleaned (
  TRANSACTIONID INT NOT NULL,
  FLIGHTDATE DATE NOT NULL,
  airline_id INTEGER NOT NULL,
  plane_id INTEGER,
  flightnumber INTEGER NOT NULL,
  origin_id INTEGER NOT NULL,
  destination_id INTEGER NOT NULL,
  crsdeptime TIME WITHOUT TIME ZONE NOT NULL,
  deptime TIME WITHOUT TIME ZONE,
  depdelay INTEGER,
  taxiout INTEGER,
  wheelsoff TIME WITHOUT TIME ZONE,
  wheelson TIME WITHOUT TIME ZONE,
  taxiin INTEGER,
  crsarrtime TIME WITHOUT TIME ZONE NOT NULL,
  arrtime TIME WITHOUT TIME ZONE,
  arrdelay INTEGER,
  crselapsedtime INTEGER,
  actualelapsedtime INTEGER,
  cancelled BOOLEAN NOT NULL,
  diverted BOOLEAN NOT NULL,
  distance INTEGER NOT NULL,
  distance_unit VARCHAR NOT NULL
);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_airline FOREIGN KEY (airline_id) REFERENCES public.airlines(id);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_plane FOREIGN KEY (plane_id) REFERENCES public.planes(id);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_origin FOREIGN KEY (origin_id) REFERENCES public.airports(id);

ALTER TABLE ONLY public.flights_cleaned
ADD CONSTRAINT fk_flights_cleaned_destination FOREIGN KEY (destination_id) REFERENCES public.airports(id);

INSERT INTO flights_cleaned(
  TRANSACTIONID,
  FLIGHTDATE,
  airline_id,
  plane_id,
  flightnumber,
  origin_id,
  destination_id,
  crsdeptime,
  deptime,
  depdelay,
  taxiout,
  wheelsoff,
  wheelson,
  taxiin,
  crsarrtime,
  arrtime,
  arrdelay,
  crselapsedtime,
  actualelapsedtime,
  cancelled,
  diverted,
  distance,
  distance_unit)
SELECT
  TRANSACTIONID,
  TO_DATE(CAST(FLIGHTDATE AS VARCHAR), 'YYYYMMDD'),
  airlines.id,
  planes.id,
  flights.FLIGHTNUM,
  origin.id,
  destination.id,
  CAST( replace( CAST( round( (crsdeptime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  CAST( replace( CAST( round( (deptime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  depdelay,
  taxiout,
  CAST( replace( CAST( round( (wheelsoff / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  CAST( replace( CAST( round( (wheelson / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  taxiin,
  CAST( replace( CAST( round( (crsarrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  CAST( replace( CAST( round( (arrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  arrdelay,
  crselapsedtime,
  actualelapsedtime,
  CAST(cancelled AS boolean),
  CAST(diverted AS BOOLEAN),
  CAST(SPLIT_PART(distance, ' ', '1') AS INTEGER),
  SPLIT_PART(distance, ' ', '2')
FROM
  public.flights
  LEFT OUTER JOIN public.airlines ON public.flights.AIRLINECODE = public.airlines.CODE
  LEFT OUTER JOIN public.planes ON REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') = planes.tail_number
  LEFT OUTER JOIN airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS FALSE
;


INSERT INTO flights_cleaned(
  TRANSACTIONID,
  FLIGHTDATE,
  airline_id,
  plane_id,
  flightnumber,
  origin_id,
  destination_id,
  crsdeptime,
  crsarrtime,
  arrdelay,
  crselapsedtime,
  cancelled,
  diverted,
  distance,
  distance_unit)
SELECT
  TRANSACTIONID,
  TO_DATE(CAST(FLIGHTDATE AS VARCHAR), 'YYYYMMDD'),
  airlines.id,
  planes.id,
  flights.FLIGHTNUM,
  origin.id,
  destination.id,
  CAST( replace( CAST( round( (crsdeptime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  CAST( replace( CAST( round( (crsarrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME),
  arrdelay,
  crselapsedtime,
  CAST(cancelled AS boolean),
  CAST(diverted AS BOOLEAN),
  CAST(SPLIT_PART(distance, ' ', '1') AS INTEGER),
  SPLIT_PART(distance, ' ', '2')
FROM
  public.flights
  LEFT OUTER JOIN public.airlines ON public.flights.AIRLINECODE = public.airlines.CODE
  LEFT OUTER JOIN public.planes ON REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') = planes.tail_number
  LEFT OUTER JOIN airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS true
;

