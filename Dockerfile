FROM php:7-fpm-alpine
MAINTAINER Mats Jalas <mats.jalas@gmail.com>

RUN apk update && \
    apk add ca-certificates && \
    update-ca-certificates && \
    apk add openssl vim

RUN mkdir /home/composer
COPY install_composer.sh /home/composer/install_composer.sh
WORKDIR /home/composer
RUN chmod +x install_composer.sh && \
    ./install_composer.sh && \
    mv composer.phar /usr/bin/composer && \
    composer --version

WORKDIR /
RUN mkdir app && \
    chown -R root:www-data app/

ENTRYPOINT ["/bin/sh", "-c", "composer install;php-fpm;"]
