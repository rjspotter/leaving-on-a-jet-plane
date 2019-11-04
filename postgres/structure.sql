CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA PUBLIC;

--
-- Common Functions
--

CREATE OR REPLACE FUNCTION
  integer_time_convert(time_integer INTEGER)
RETURNS
  TIME
AS
  $$
    select CAST( replace( CAST( round( ($1 / 100.0), 2) AS TEXT), '.', ':') AS TIME);
  $$
LANGUAGE SQL;


-- upcase
-- remove anything NOT alpha NUMERIC
-- strip N OFF the front
-- replace O & I WITH 0 & 1 respectively
CREATE OR REPLACE FUNCTION
  cleaned_tailnum(tailnum_string VARCHAR)
RETURNS
  VARCHAR
AS
$$
SELECT REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(REGEXP_REPLACE(UPPER($1), '[^A-Z0-9]+', '', 'g'), '^N(.*)', '\1'), 'O', '0', 'g'), 'I', '1', 'g');
$$
LANGUAGE SQL;



-- flights lake

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
CREATE SEQUENCE public.dim_airlines_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.dim_airlines (
  id INTEGER NOT NULL DEFAULT nextval('dim_airlines_id_seq'),
  code CHARACTER VARYING NOT NULL,
  description CHARACTER VARYING NOT NULL,
  notes CHARACTER VARYING
);

ALTER TABLE ONLY public.dim_airlines ADD CONSTRAINT dim_airlines_pkey PRIMARY KEY (id);
CREATE INDEX code_of_dim_airlines ON public.dim_airlines USING btree (code);

-- Planes

CREATE SEQUENCE public.dim_planes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.dim_planes (
  id INTEGER NOT NULL DEFAULT nextval('dim_planes_id_seq'),
  tail_number CHARACTER VARYING NOT NULL UNIQUE,
  valid BOOLEAN NOT NULL DEFAULT TRUE
);
ALTER TABLE ONLY public.dim_planes ADD CONSTRAINT dim_planes_pkey PRIMARY KEY (id);

-- Airports

CREATE SEQUENCE public.dim_airports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.dim_airports (
  id INTEGER NOT NULL DEFAULT nextval('dim_airports_id_seq'),
  code CHARACTER VARYING NOT NULL UNIQUE,
  name CHARACTER VARYING NOT NULL,
  city CHARACTER VARYING,
  STATE CHARACTER VARYING,
  state_name CHARACTER VARYING
);
ALTER TABLE ONLY public.dim_airports ADD CONSTRAINT dim_airports_pkey PRIMARY KEY (id);
CREATE INDEX code_of_dim_airports ON public.dim_airports USING btree (code);

-- Flights Cleaned

CREATE TABLE public.dim_flights (
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
  distance_unit VARCHAR NOT NULL DEFAULT 'miles'
);

ALTER TABLE ONLY public.dim_flights ADD CONSTRAINT dim_flights_pkey PRIMARY KEY (transactionid);

ALTER TABLE ONLY public.dim_flights
ADD CONSTRAINT fk_dim_flights_airline FOREIGN KEY (airline_id) REFERENCES public.dim_airlines(id);

ALTER TABLE ONLY public.dim_flights
ADD CONSTRAINT fk_dim_flights_plane FOREIGN KEY (plane_id) REFERENCES public.dim_planes(id);

ALTER TABLE ONLY public.dim_flights
ADD CONSTRAINT fk_dim_flights_origin FOREIGN KEY (origin_id) REFERENCES public.dim_airports(id);

ALTER TABLE ONLY public.dim_flights
ADD CONSTRAINT fk_dim_flights_destination FOREIGN KEY (destination_id) REFERENCES public.dim_airports(id);

-- Flight Facts

CREATE OR REPLACE FUNCTION
  bucket(val INTEGER)
RETURNS
  VARCHAR
AS
  $$
  WITH
    coersion
  AS
    (SELECT CAST(CAST(($1 - 1) AS DECIMAL) / 100 AS INTEGER) * 100 AS bucket_int)
  SELECT
    concat(CAST((coersion.bucket_int + 1) AS VARCHAR), '-', CAST((coersion.bucket_int + 100) AS VARCHAR))
  FROM
    coersion
  $$
LANGUAGE SQL;


CREATE TABLE public.fact_flights (
  transactionid INTEGER NOT NULL,
  distancegroup VARCHAR NOT NULL,
  depdelaygt15 INT4,
  nextdayarr INT4
);
ALTER TABLE ONLY public.fact_flights ADD CONSTRAINT fact_flights_pkey PRIMARY KEY (transactionid);

-- final view

CREATE VIEW
  vw_flights
AS
SELECT
  dim_flights.transactionid,
  fact_flights.distancegroup,
  COALESCE(fact_flights.DEPDELAYGT15, 0) AS DEPDELAYGT15,
  COALESCE(fact_flights.NEXTDAYARR, 0) AS NEXTDAYARR,
  dim_airlines.description AS AIRLINENAME,
  origin.NAME AS ORIGAIRPORTNAME,
  destination.NAME AS DESTAIRPORTNAME,
  concat('N', COALESCE(dim_planes.tail_number, 'UNKNOWN')) AS TAILNUM,
  COALESCE(taxiout, 0) AS taxiout,
  COALESCE(taxiin, 0) AS taxiin,
  crsdeptime,
  deptime,
  crsarrtime,
  arrtime,
  distance,
  distance_unit
FROM
  dim_flights
INNER JOIN
  fact_flights ON dim_flights.transactionid = fact_flights.transactionid
LEFT JOIN
  dim_airlines ON dim_flights.airline_id = dim_airlines.id
LEFT JOIN
  dim_planes ON dim_flights.plane_id = dim_planes.id
LEFT JOIN
  dim_airports AS origin  ON dim_flights.origin_id = origin.id
LEFT JOIN
  dim_airports AS destination  ON dim_flights.destination_id = destination.id
;
