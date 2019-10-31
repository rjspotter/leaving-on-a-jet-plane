CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA public;

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
  distance_unit VARCHAR DEFAULT 'miles'
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


-- Distance Groups

CREATE SEQUENCE public.distance_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.distance_groups (
  id INTEGER NOT NULL DEFAULT nextval('distance_groups_id_seq'),
  MIN INTEGER NOT NULL,
  MAX INTEGER NOT NULL,
  label VARCHAR NOT NULL
);
ALTER TABLE ONLY public.distance_groups ADD CONSTRAINT distance_groups_pkey PRIMARY KEY (id);

INSERT INTO distance_groups (MIN, MAX, label) VALUES (0, 100, '0-100');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (101, 200, '101-200');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (201, 300, '201-300');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (301, 400, '301-400');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (401, 500, '401-500');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (501, 600, '501-600');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (601, 700, '601-700');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (701, 800, '701-800');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (801, 900, '801-900');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (901, 1000, '901-1000');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1001, 1100, '1001-1100');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1101, 1200, '1101-1200');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1201, 1300, '1201-1300');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1301, 1400, '1301-1400');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1401, 1500, '1401-1500');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1501, 1600, '1501-1600');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1601, 1700, '1601-1700');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1701, 1800, '1701-1800');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1801, 1900, '1801-1900');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (1901, 2000, '1901-2000');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2001, 2100, '2001-2100');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2101, 2200, '2101-2200');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2201, 2300, '2201-2300');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2301, 2400, '2301-2400');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2401, 2500, '2401-2500');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2501, 2600, '2501-2600');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2601, 2700, '2601-2700');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2701, 2800, '2701-2800');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2801, 2900, '2801-2900');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (2901, 3000, '2901-3000');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3001, 3100, '3001-3100');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3101, 3200, '3101-3200');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3201, 3300, '3201-3300');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3301, 3400, '3301-3400');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3401, 3500, '3401-3500');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3501, 3600, '3501-3600');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3601, 3700, '3601-3700');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3701, 3800, '3701-3800');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3801, 3900, '3801-3900');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (3901, 4000, '3901-4000');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4001, 4100, '4001-4100');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4101, 4200, '4101-4200');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4201, 4300, '4201-4300');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4301, 4400, '4301-4400');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4401, 4500, '4401-4500');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4501, 4600, '4501-4600');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4601, 4700, '4601-4700');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4701, 4800, '4701-4800');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4801, 4900, '4801-4900');
INSERT INTO distance_groups (MIN, MAX, label) VALUES (4901, 5000, '4901-5000');

-- Flight Facts

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
