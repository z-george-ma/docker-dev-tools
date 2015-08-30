FROM php:5.6-apache

RUN apt-get update && apt-get install -y git && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin

RUN docker-php-ext-install bcmath mbstring mysql

VOLUME /var/www/html
#ADD . /var/www/html/
