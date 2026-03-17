#!/bin/bash

while ! nc -z "${MARIADB_HOST}" "3306"; do
  echo "Waiting for database connection at ${MARIADB_HOST}:3306..."
  sleep 1
done

echo "Database is up and running!"

exec apache2-foreground

tail -F /var/www/html/logs/application.log \
        /var/www/html/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log
