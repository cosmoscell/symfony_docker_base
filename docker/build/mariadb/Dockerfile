FROM mariadb

LABEL author="Ricardo Ruiz Martínez <richiruizmartinez@gmail.com>"
LABEL version="0.1.0"

RUN apt-get update

RUN apt-get --yes autoremove && \
    apt-get --yes autoclean

RUN rm --force --recursive \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*
