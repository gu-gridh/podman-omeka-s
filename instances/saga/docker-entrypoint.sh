#!/bin/bash

# Generate database configuration file
echo "Creating database.ini in /var/www/html/config/ ..."
rm -f /var/www/html/config/database.ini
echo "user     = \"${MYSQL_USER}\"" > /var/www/html/config/database.ini
echo "password = \"${MYSQL_PASSWORD}\"" >> /var/www/html/config/database.ini
echo "dbname   = \"${MYSQL_DATABASE}\"" >> /var/www/html/config/database.ini
echo "host     = \"${MYSQL_HOST}\"" >> /var/www/html/config/database.ini
echo "Done creating database.ini !"

while ! nc -z "${MYSQL_HOST}" "3306"; do
  echo "Waiting for database connection at ${MYSQL_HOST}:3306..."
  sleep 1
done

echo "Database is up and running!"

service apache2 start

tail -F /var/www/html/logs/application.log \
        /var/www/html/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log