#!/bin/bash

mkdir -p /release/tags/default/docs
mkdir -p /release/data
ln -snf /release/current/ /release/tags/default

sudo apt update -y
sudo apt install -y php php-cli php-fpm php-json php-common php-mysql php-zip php-gd php-mbstring php-curl php-xml php-pear php-bcmath
sudo apt install -y apache2
sudo groupadd ubuntu
chmod 777 release/
chmod 777 release/tags/
chmod 777 release/data/

cat > /etc/apache2/sites-available/000-default.conf<<EOF
<VirtualHost *:80>
    ServerAdmin support@trackthis.nl
    ServerName trackinsight.nl
    ServerAlias *.trackinsight.nl

    Options -Indexes
    DocumentRoot /release/current/docs
    AllowEncodedSlashes NoDecode

    <Directory /release/current>
        Order allow,deny
        Allow from all
        Require all granted
        Options Indexes FollowSymLinks 
        AllowOverride All
    </Directory>

    CustomLog /var/log/apache2/trackinsight.nl-access.log combined
    ErrorLog /var/log/apache2/trackinsight.nl-error.log
</VirtualHost>
EOF