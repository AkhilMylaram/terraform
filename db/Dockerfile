FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=vprodbpass
ENV MYSQL_DATABASE=accounts

COPY db_backup.sql /docker-entrypoint-initdb.d/

EXPOSE 3306