# @todo

echo -e "\e[1;33mInstalling Symfony ...\e[0m"
docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global --add safe.directory /var/www/html && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global user.email "user@localhost" && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" git config --global user.name "user" && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" symfony new . && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Symfony installed!'
  echo ''
