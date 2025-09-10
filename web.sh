#! /bin/bash
apt update
apt install apache2 wget unzip -y
systemctl start apache2
systemctl enable apache2
cd /tmp/
wget https://www.tooplate.com/zip-templates/2119_gymso_fitness.zip
unzip -o 2119_gymso_fitness.zip
cp -r 2119_gymso_fitness/* /var/www/html/
systemctl restart apache2