-- Airlines dim_airlines

SELECT
  DISTINCT AIRLINECODE AS code,
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '1') AS description,
  SPLIT_PART(AIRLINENAME, CONCAT(': ', AIRLINECODE), '2') AS notes
FROM
  flights
WHERE
  flights.airlinecode NOT IN (SELECT code FROM dim_airlines)
;

-- Planes dim_planes

SELECT
  DISTINCT REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]+', '', 'g'), '^N(.*)', '\1')
  AS tail_number
FROM
  flights
WHERE
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') IS NOT NULL
AND
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') NOT IN (SELECT tail_number FROM dim_planes)
;

SELECT
  DISTINCT REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]+', '', 'g'), '^N(.*)', '\1')
  AS tail_number
FROM
  flights
WHERE
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') IS NOT NULL
AND
  REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', '', 'g'), '^N(.*)', '\1') NOT IN (SELECT tail_number FROM dim_planes)
;

-- Airports dim_airports

SELECT
 DISTINCT originairportcode AS code,
 SPLIT_PART(origairportname, ': ', '2') AS "name",
 origincityname AS city,
 originstate AS state,
 originstatename AS state_name
FROM
  flights
WHERE
  originairportcode NOT IN (SELECT DISTINCT code FROM dim_airports)

UNION

SELECT
 DISTINCT destairportcode AS code,
 SPLIT_PART(destairportname, ': ', '2') AS "name",
 destcityname AS city,
 deststate AS state,
 deststatename AS state_name
FROM
  flights
WHERE
  destairportcode NOT IN (SELECT DISTINCT code FROM dim_airports)
;

-- Flights dim_flights

SELECT
  TRANSACTIONID,
  TO_DATE(CAST(FLIGHTDATE AS VARCHAR), 'YYYYMMDD') AS FLIGHTDATE,
  dim_airlines.id AS airline_id,
  dim_planes.id AS plane_id,
  flights.FLIGHTNUM AS flightnumber,
  origin.id AS origin_id,
  destination.id AS destination_id,
  CAST( replace( CAST( round( (crsdeptime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS crsdeptime,
  CAST( replace( CAST( round( (deptime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS deptime,
  depdelay,
  taxiout,
  CAST( replace( CAST( round( (wheelsoff / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS wheelsoff,
  CAST( replace( CAST( round( (wheelson / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS wheelson,
  taxiin,
  CAST( replace( CAST( round( (crsarrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS crsarrtime,
  CAST( replace( CAST( round( (arrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS arrtime,
  arrdelay,
  crselapsedtime,
  actualelapsedtime,
  CAST(cancelled AS BOOLEAN) AS cancelled,
  CAST(diverted AS BOOLEAN) AS diverted,
  CAST(SPLIT_PART(distance, ' ', '1') AS INTEGER) AS distance,
  SPLIT_PART(distance, ' ', '2') AS distnace_unit
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


SELECT
  TRANSACTIONID,
  TO_DATE(CAST(FLIGHTDATE AS VARCHAR), 'YYYYMMDD') AS FLIGHTDATE,
  dim_airlines.id,
  dim_planes.id,
  flights.FLIGHTNUM,
  origin.id,
  destination.id,
  CAST( replace( CAST( round( (crsdeptime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS crsdeptime,
  CAST( replace( CAST( round( (crsarrtime / 100.0), 2) AS TEXT), '.', ':') AS TIME) AS crsarrtime,
  arrdelay,
  crselapsedtime,
  CAST(cancelled AS BOOLEAN) AS cancelled,
  CAST(diverted AS BOOLEAN)AS diverted,
  CAST(SPLIT_PART(distance, ' ', '1') AS INTEGER) AS distance,
  SPLIT_PART(distance, ' ', '2') AS distance_unit
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

--- Facts fact_flights

INSERT INTO  (
  transactionid,
  distancegroup,
  depdelaygt15,
  nextdayarr
)
SELECT
  transactionid,
  distance_groups.label AS distancegroup,
  cast((depdelay > 15) AS INTEGER) AS depdelaygt15,
  cast((arrtime < deptime) AS INTEGER) AS nextdayarr
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
