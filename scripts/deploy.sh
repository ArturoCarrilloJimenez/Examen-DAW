#!/bin/bash

set -ex

source .env # Inportamos el contenido de variables de entorno

sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/apache2/php.ini
sed -i "s/;max_input_vars = 1000/max_input_vars = 5000/" /etc/php/8.3/cli/php.ini

rm -rf  /tmp/v4.5.1.zip

wget https://github.com/moodle/moodle/archive/refs/tags/v4.5.1.zip -P /tmp

apt install unzip

unzip /tmp/v4.5.1.zip -d /tmp

rm -rf /var/www/html/*

mv -f /tmp/moodle-4.5.1/* /var/www/html


