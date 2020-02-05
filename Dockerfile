FROM debian:buster

RUN apt-get update && apt-get install -y nginx mariadb-server \
	wget php-fpm php-mysql

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz && \
	tar -zxvf phpMyAdmin-4.9.0.1-all-languages.tar.gz

RUN rm -rf phpMyAdmin-4.9.0.1-all-languages.tar.gz && \
	mv phpMyAdmin-4.9.0.1-all-languages /usr/share/phpMyAdmin

COPY /srcs/phpmyadmin/config.inc.php /usr/share/phpMyAdmin/

RUN chown -R www-data:www-data /usr/share/phpMyAdmin

EXPOSE 80

CMD service nginx restart && \
	service mysql start && \
	service php7.3-fpm start && sleep infinity & wait