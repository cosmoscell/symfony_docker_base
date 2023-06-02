FROM php:8.2.1-fpm

LABEL author="Ricardo Ruiz Martínez <richiruizmartinez@gmail.com>"
LABEL version="0.1.0"

ARG TIMEZONE=Europe/Madrid
RUN echo "${TIMEZONE}" > /etc/timezone && \
    rm --force /etc/localtime && \
    dpkg-reconfigure --frontend=noninteractive tzdata
RUN echo -n 'date.timezone = ' > /usr/local/etc/php/conf.d/timezone.ini && \
    echo "${TIMEZONE}" >> /usr/local/etc/php/conf.d/timezone.ini

RUN apt-get update

RUN apt-get --yes install \
        iputils-ping \
        mailutils \
        msmtp \
        msmtp-mta \
        procps

RUN docker-php-ext-install \
        mysqli

RUN apt-get --yes autoremove && \
    apt-get --yes autoclean

RUN rm --force --recursive \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*
