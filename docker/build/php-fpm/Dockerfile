FROM php:8.2.1-fpm

ARG TIMEZONE=Europe/Madrid
RUN echo "${TIMEZONE}" > /etc/timezone && \
    rm --force /etc/localtime && \
    dpkg-reconfigure --frontend=noninteractive tzdata
RUN echo -n 'date.timezone = ' > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "${TIMEZONE}" >> /usr/local/etc/php/conf.d/timezone.ini

RUN apt-get update

RUN apt-get --yes install \
        curl

# Composer
RUN curl --silent --show-error https://getcomposer.org/installer --output /tmp/.composer-setup.php && \
        php /tmp/.composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
        rm /tmp/.composer-setup.php

# Symfony
RUN curl --silent --tlsv1 --location --show-error https://dl.cloudsmith.io/public/symfony/stable/setup.deb.sh | bash

RUN apt-get --yes install \
        git \
        iputils-ping \
        libzip-dev \
        mailutils \
        msmtp \
        msmtp-mta \
        nano \
        procps \
        symfony-cli \
        unzip

RUN docker-php-ext-install \
        mysqli \
        zip

RUN apt-get --yes autoremove && \
    apt-get --yes autoclean

RUN rm --force --recursive \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*
