FROM nginx

RUN apt-get update

RUN apt-get --yes install \
        iputils-ping \
        libfcgi0ldbl

RUN apt-get --yes autoremove && \
    apt-get --yes autoclean

RUN rm --force --recursive \
       /tmp/* \
       /var/lib/apt/lists/* \
       /var/tmp/*
