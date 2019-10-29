CREATE FUNCTION dimensionalize_flights()
RETURNS TRIGGER AS
$BODY$
BEGIN

-- Airlines

INSERT
  INTO dim_airlines (
  code,
  description,
  notes)
SELECT
  DISTINCT AIRLINECODE,
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '1'),
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '2')
FROM
  flights
WHERE
  flights.airlinecode NOT IN (SELECT code FROM dim_airlines)
;

-- Planes

INSERT
  INTO dim_planes (tail_number)
SELECT
  DISTINCT REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]+', '', 'g'), '^N(.*)', '\1')
FROM
  flights
WHERE
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') IS NOT NULL
AND
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') NOT IN (SELECT tail_number FROM dim_planes)
;

-- Airports

INSERT
 INTO dim_airports(
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
WHERE
  originairportcode NOT IN (SELECT DISTINCT code FROM dim_airports)
;

INSERT
 INTO dim_airports(
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
  destairportcode NOT IN (SELECT DISTINCT code FROM dim_airports)
;

-- Flights

INSERT INTO dim_flights(
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
  dim_airlines.id,
  dim_planes.id,
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
  flights
  LEFT OUTER JOIN dim_airlines ON flights.AIRLINECODE = dim_airlines.CODE
  LEFT OUTER JOIN dim_planes ON REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') = dim_planes.tail_number
  LEFT OUTER JOIN dim_airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN dim_airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS FALSE
AND
  transactionid NOT IN (SELECT transactionid FROM dim_flights)
;


INSERT INTO dim_flights(
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
  dim_airlines.id,
  dim_planes.id,
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
  flights
  LEFT OUTER JOIN dim_airlines ON flights.AIRLINECODE = dim_airlines.CODE
  LEFT OUTER JOIN dim_planes ON REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^N(.*)', '\1') = dim_planes.tail_number
  LEFT OUTER JOIN dim_airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN dim_airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS TRUE
AND
  transactionid NOT IN (SELECT transactionid FROM dim_flights)
;

--- Facts

INSERT INTO fact_flights (
  transactionid,
  distancegroup,
  depdelaygt15,
  nextdayarr
)
SELECT
  transactionid,
  distance_groups.label,
  cast((depdelay > 15) AS INTEGER),
  cast((arrtime < deptime) AS INTEGER)
FROM
  dim_flights
INNER JOIN
  distance_groups
  ON
    distance_groups.MIN <= dim_flights.distance
  AND
    distance_groups.MAX >= dim_flights.distance
WHERE
  transactionid NOT IN (SELECT transactionid FROM fact_flights)
;

RETURN NULL;
END;
$BODY$
LANGUAGE 'plpgsql'
;

CREATE TRIGGER new_flights
AFTER INSERT ON flights
FOR EACH STATEMENT
EXECUTE PROCEDURE dimensionalize_flights()
;
