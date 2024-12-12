#!/bin/bash

set -ex

source .env # Inportamos el contenido de variables de entorno

sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/apache2/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/cli/php.ini

rm -rf  /tmp/v4.5.1.zip

wget https://github.com/moodle/moodle/archive/refs/tags/v4.5.1.zip -P /tmp

apt install unzip

rm -rf /tmp/moodle-4.5.1

unzip /tmp/v4.5.1.zip -d /tmp

rm -rf /var/www/html/*

mv /tmp/moodle-4.5.1/* /var/www/html/

mkdir -p /var/www/moodledata/

chown -R www-data:www-data /var/www/moodledata

sudo -u www-data php /var/www/html/admin/cli/install.php \
    --lang=$MOODLE_LANG \
    --wwwroot=$MOODLE_WWWROOT \
    --dataroot=$MOODLE_DAAROOT \
    --dbtype=$MOODLE_DB_TYPE \
    --dbhost=$MOODLE_DB_HOST \
    --dbname=$MOODLE_DB_NAME \
    --dbuser=$MOODLE_DB_USER \
    --dbpass=$MOODLE_DB_PASS \
    --fullname="$MOODLE_FULLNAME" \
    --shortname="$MOODLE_SHORTNAME" \
    --summary="$MOODLE_SUMARY" \
    --adminuser=$MOODLE_ADMIN_USER \
    --adminpass=$MOODLE_ADMIN_PASS \
    --adminemail=$MOODLE_ADMIN_EMAIL \
    --non-interactive \
    --agree-license
