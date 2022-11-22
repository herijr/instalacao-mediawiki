#!/bin/bash
apt update
echo "Atualizando pacotes"
apt upgrade -y
echo "OK."
sudo su
echo "Instalando pacotes do apache e php"
apt install -y php php-apcu php-intl php-mbstring php-xml php-mysql php-calendar php-gd apache2 unzip
echo "OK."
echo "Instalando mediawiki"
wget https://releases.wikimedia.org/mediawiki/1.38/mediawiki-1.38.4.tar.gz
tar -zxvf mediawiki-1.38.4.tar.gz
sudo mv mediawiki-1.38.4 /var/www/mediawiki
sudo chown -R www-data:www-data /var/www/mediawiki
echo "Copia finalizada."
rm -f mediawiki-1.38.4.tar.gz
wget http://conf-g3-mediawiki.s3-website-us-east-1.amazonaws.com/site.conf
mv site.conf /etc/apache2/sites-available
a2ensite site.conf
a2dissite 000-default.conf
a2enmod rewrite
service apache2 restart
echo "Apache reiniciado"