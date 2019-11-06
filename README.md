## Getting Started / How-to

start with `docker-compose up`
you should then be able to see the ETL flow in Nifi at http://localhost:8080/nifi

The flow across the top unpacks the zipfile and the rest processes it into the database

to kick off just copy the zipfile to NiFi `docker cp flights.zip nifi:/data/`
you should then be able to watch the data flow through the system.  NiFi only seems
to update every 30s so watch the in/out byte counts

Once that's complete you can do exploration with Superset
`http://data-drone:8088/login/`
```
u: admin
p: simple
```

I haven't built any dashboards or charts successfully yet but, you can Use the
SQL lab to poke around

The database you want to look at is called 'warehouse' you can ignore 'main' and 'example'
## Notes

Not all the tail numbers are valid
removed the N because all FAA tail numbers start with N, since 1949 anyway
(in fact they're called N codes)

I auto-removed any non-valid characters from the tail numbers
in the view I coerce null into UNKNOWN for tailnum, it seems like that is used many times to mean the same thing


Flight Designations are mutable https://en.wikipedia.org/wiki/Flight_number
I looked at breaking them out but there are 926327
distinct on AIRLINECODE, FLIGHTNUM, ORIGINAIRPORTCODE, DESTAIRPORTCODE, CRSDEPTIME, CRSARRTIME, CRSELAPSEDTIME
out of 1191805; 77.6% so I didn't think with this data it warranted a separate dimension

The fact_flights table has the nextdayarr but, may not be 100% accurate because
I don't have timezone data available in this set.

the distance unit seemed to always be miles or null so, I defaulted to miles

## Presentation
https://docs.google.com/presentation/d/18x8XFtYZwyxg4O4rBM9He34Lz5S6_cMciXX0XEf1ZCQ/edit?usp=sharing
