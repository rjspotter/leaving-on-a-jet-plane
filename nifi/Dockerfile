FROM apache/nifi:1.9.2

USER root
RUN apt-get update
RUN apt-get install -yq libpostgresql-jdbc-java libpostgis-java libmysql-java

USER nifi
