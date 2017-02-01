FROM php:7-fpm-alpine
MAINTAINER Mats Jalas <mats.jalas@gmail.com>

RUN apk update && apk add ca-certificates && update-ca-certificates && apk add openssl

RUN mkdir /home/composer
COPY install_composer.sh /home/composer/install_composer.sh
WORKDIR /home/composer
RUN chmod +x install_composer.sh
RUN ./install_composer.sh
RUN mv composer.phar /usr/bin/composer
RUN composer --version

VOLUME ["/app"]
WORKDIR /app

ENTRYPOINT ["/bin/sh", "-c", "composer install;php-fpm;"]
