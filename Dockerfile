# Consignes : 
#     - Un seul container
#     - Tourne sur Debian Buster avec Nginx
#     - Plusieurs services : phpMyAdmin/SQL(MariaDB)
#     - Utiliser le protocole SSL quand possible
#     - Selon, l'URL tapé, renvoyer vers le bon site
#     - Tourne avec un index automatique qui doit pouvoir être désactivable 

# $ docker build -t name .
# $ docker run -it -p 80:80 -p 443:443 name

FROM debian:buster

RUN mkdir install-config && apt-get update && apt-get -y upgrade
RUN apt-get install -y nginx mariadb-server mariadb-client wget \
        php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli  \
        php7.3-common php7.3-json php7.3-opcache php7.3-readline openssl

ADD ./srcs ./install-config

RUN mkdir -p ./var/www/config_domain/ \
&& mv ./install-config/config_domain /etc/nginx/sites-available/localhost \
&& ln -s /etc/nginx/sites-available/localhost /etc/nginx/sites-enabled/localhost \
&& service mysql start \
&& mysql -u root < ./install-config/mysql-config.sql

RUN mkdir -p ./var/www/config_domain/ \
&& wget https://fr.wordpress.org/latest-fr_FR.tar.gz -P /tmp \
&& tar xzf /tmp/latest-fr_FR.tar.gz -C /var/www/config_domain \
&& cp ./install-config/wp-config.php /var/www/config_domain/wordpress/wp-config.php \
&& chown -R www-data:www-data /var/www/config_domain/wordpress/ \
&& chmod 755 -R /var/www/config_domain/wordpress/

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.3/phpMyAdmin-4.9.3-english.tar.gz -P /tmp \
&& tar xzf /tmp/phpMyAdmin-4.9.3-english.tar.gz -C /var/www/config_domain/ \
&& cp /var/www/config_domain/phpMyAdmin-4.9.3-english/config.sample.inc.php /var/www/config_domain/phpMyAdmin-4.9.3-english/config.inc.php \
&& mv /var/www/config_domain/phpMyAdmin-4.9.3-english /var/www/config_domain/phpmyadmin 

RUN mkdir -p /etc/ssl/certs && mkdir -p /etc/ssl/private \
&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj '/C=FR/ST=75/L=Paris/O=42/CN=localhost' \
-keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt

RUN nginx -t

EXPOSE 80 443

CMD service nginx start \
 && service mysql start \
&& service php7.3-fpm start \
&& sleep infinity & wait
