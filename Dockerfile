FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y install wget
RUN apt-get -y install nginx
RUN apt-get -y install vim
RUN apt-get -y install mariadb-server
RUN apt-get -y install php7.3 php-mysql php-fpm php-pdo php-gd php-cli php-mbstring
RUN mkdir /var/www/localhost

#nginx
COPY ./srcs/nginx.conf etc/nginx/sites-available/
RUN	ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf
RUN rm /etc/nginx/sites-enabled/default && rm /etc/nginx/sites-available/default

#phpmyadmin
WORKDIR /var/www/localhost/
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.1/phpMyAdmin-5.0.1-all-languages.tar.gz
RUN tar -xf phpMyAdmin-5.0.1-all-languages.tar.gz && rm -rf phpMyAdmin-5.0.1-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.1-all-languages phpmyadmin
RUN mv phpmyadmin/config.sample.inc.php phpmyadmin/config.inc.php
COPY ./srcs/config.inc.php phpmyadmin

#wordpress
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xvzf latest.tar.gz && rm -rf latest.tar.gz
COPY ./srcs/wp-config.php wordpress

#ssl
RUN openssl req -x509 -nodes -days 365 -subj "/C=RU/ST=Moscow/L=Moscow/O=SCHOOL21/OU=42moscow/" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;

RUN chown -R www-data:www-data *
RUN chmod -R 755 /var/www/*

COPY ./srcs/script.sh ../../../
COPY srcs/autoindex_change.sh ../../../

EXPOSE 80 443

CMD ["bash", "/script.sh"]
