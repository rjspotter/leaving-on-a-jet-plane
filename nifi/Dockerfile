FROM apache/nifi:1.9.2

USER root
RUN apt-get update
RUN apt-get install -yq libpostgresql-jdbc-java libpostgis-java libmysql-java

COPY --chown=nifi:nifi bootstrap.conf /opt/nifi/nifi-1.9.2/conf/
COPY --chown=nifi:nifi flow.xml.gz /opt/nifi/nifi-1.9.2/conf/

USER nifi
