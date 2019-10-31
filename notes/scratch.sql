select distinct REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^([^N].*)', 'N\1')
from flights order by REGEXP_REPLACE(REGEXP_REPLACE(UPPER(TAILNUM), '[^A-Z0-9]', ''), '^([^N].*)', 'N\1')
limit 10;


INSERT INTO public.flights (transactionid, flightdate, airlinecode, airlinename, tailnum, flightnum, originairportcode, origairportname, origincityname, originstate, originstatename, destairportcode, destairportname, destcityname, deststate, deststatename, crsdeptime, deptime, depdelay, taxiout, wheelsoff, wheelson, taxiin, crsarrtime, arrtime, arrdelay, crselapsedtime, actualelapsedtime, cancelled, diverted, distance) VALUES (54548800,20020101,'WN','Southwest Airlines Co.: WN','N103@@',1425,'ABQ','AlbuquerqueNM: Albuquerque International Sunport','Albuquerque','NM','New Mexico','DAL','DallasTX: Dallas Love Field','Dallas','TX','Texas',1425,1425,0,8,1433,1648,4,1655,1652,-3,90,87,'F','False','580 miles') ;
