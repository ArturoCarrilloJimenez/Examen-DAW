#!/bin/bash

# x muestra los comandos que se realizan
# e en caso de fallar detiene la ejecucion
set -ex

# Actualiza la lista de paquetes
apt update

# Actualizamos paquetes de sistema operativo
apt upgrade -y # -y respuesta yes

apt install apache2 -y

# Copiamos archivo conf
cp ../conf/000-default.conf /etc/apache2/sites-available

sudo apt install php libapache2-mod-php php-mysql php-xml php-mbstring php-curl php-zip php-gb php-intl php-soap -y

# Habiltamos el modelo rewite de apache
a2enmod rewrite

# Reiniciar apache
systemctl restart apache2

# Copio el archivo php a el directorio donde esta los elementos de la web
cp ../php/index.php /var/www/html

# Modificar propietario de /var/www/html
chown -R www-data:www-data /var/www/html