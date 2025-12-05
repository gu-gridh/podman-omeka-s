#!/bin/bash

# Generate database configuration file
echo "Creating database.ini in /var/www/html/config/ ..."
rm -f /var/www/html/config/database.ini
echo "user     = \"${MARIADB_USER}\"" > /var/www/html/config/database.ini
echo "password = \"$(cat ${MARIADB_PASSWORD_FILE})\"" >> /var/www/html/config/database.ini
echo "dbname   = \"${MARIADB_DATABASE}\"" >> /var/www/html/config/database.ini
echo "host     = \"${MARIADB_HOST}\"" >> /var/www/html/config/database.ini
echo "Done creating database.ini !"

while ! nc -z "${MARIADB_HOST}" "3306"; do
  echo "Waiting for database connection at ${MARIADB_HOST}:3306..."
  sleep 1
done

echo "Database is up and running!"

service apache2 start

tail -F /var/www/html/logs/application.log \
        /var/www/html/logs/sql.log \
        /var/log/apache2/access.log \
        /var/log/apache2/error.log