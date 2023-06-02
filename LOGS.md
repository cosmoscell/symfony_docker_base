# Location of the log files inside the containers

This file is for informational purposes only.

| DOCKER COMPOSE SERVICE    | SERVER           | LOG PATH               |
|---------------------------|------------------|------------------------|
| **mariadb**               | mariadb          | /var/log/mysql/        |
| **nginx**                 | nginx            | /var/log/nginx/        |
| **php_fpm**               | msmtp            | /var/log/msmtp.log     |
| **php_fpm**               | Symfony          | /var/www/html/var/log/ |
