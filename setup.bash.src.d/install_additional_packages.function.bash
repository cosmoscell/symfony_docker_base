# @todo

echo -e "${ANSI_BOLD}${ANSI_FG_YELLOW}Installing additional packages ...${ANSI_DEFAULT}"
docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require symfony/monolog-bundle && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require symfony/orm-pack && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require --dev symfony/maker-bundle && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer require --dev richirm/qdump && \
  docker exec "${DOCKER_SYMFONY_PROJECT_NAME}_php_fpm" composer update && \
  echo -e -n "${ANSI_OK}"' ' && \
  echo 'Additional packages installed'
  echo ''
