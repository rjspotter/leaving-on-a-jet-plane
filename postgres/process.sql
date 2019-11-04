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
  DISTINCT cleaned_tailnum(tailnum)
  AS tail_number
FROM
  flights
WHERE
  cleaned_tailnum(tailnum) IS NOT NULL
AND
  cleaned_tailnum(tailnum) NOT IN (SELECT tail_number FROM dim_planes)
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
  integer_time_convert(crsdeptime) AS crsdeptime,
  integer_time_convert(deptime) AS deptime,
  depdelay,
  taxiout,
  integer_time_convert(wheelsoff) AS wheelsoff,
  integer_time_convert(wheelson) AS wheelson,
  taxiin,
  integer_time_convert(crsarrtime) AS crsarrtime,
  integer_time_convert(arrtime) AS arrtime,
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
    LEFT OUTER JOIN
    dim_planes
  ON
    cleaned_tailnum(tailnum) = dim_planes.tail_number
  LEFT OUTER JOIN dim_airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN dim_airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS FALSE
;


SELECT
  TRANSACTIONID,
  TO_DATE(CAST(FLIGHTDATE AS VARCHAR), 'YYYYMMDD') AS FLIGHTDATE,
  dim_airlines.id AS airline_id,
  dim_planes.id AS plane_id,
  flights.FLIGHTNUM AS flightnumber,
  origin.id AS origin_id,
  destination.id AS destination_id,
  integer_time_convert(crsdeptime) AS crsdeptime,
  integer_time_convert(crsarrtime) AS crsarrtime,
  crselapsedtime,
  CAST(cancelled AS BOOLEAN) AS cancelled,
  CAST(diverted AS BOOLEAN) AS diverted,
  CAST(SPLIT_PART(distance, ' ', '1') AS INTEGER) AS distance,
  SPLIT_PART(distance, ' ', '2') AS distance_unit
FROM
  flights
  LEFT OUTER JOIN dim_airlines ON flights.AIRLINECODE = dim_airlines.CODE
  LEFT OUTER JOIN
    dim_planes
  ON
    cleaned_tailnum(tailnum) = dim_planes.tail_number
  LEFT OUTER JOIN dim_airports AS origin ON origin.code = flights.originairportcode
  LEFT OUTER JOIN dim_airports AS destination ON destination.code = flights.destairportcode
WHERE
  CAST(cancelled AS BOOLEAN) IS TRUE
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
  bucket(distance) AS distancegroup,
  cast((depdelay > 15) AS INTEGER) AS depdelaygt15,
  cast((arrtime < deptime) AS INTEGER) AS nextdayarr
FROM
  dim_flights
WHERE
  transactionid NOT IN (SELECT transactionid FROM fact_flights)
;
