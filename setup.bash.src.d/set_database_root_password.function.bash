set_database_root_password() {
  echo_section 'Database root password'
  DB_ROOT_PASSWORD=$(get_random_token ${PASSWORD_CHARSET} ${RANDOM_PASSWORD_LENGTH})
  sed -i 's/DOCKER_SYMFONY_DB_ROOT_PASSWORD=/DOCKER_SYMFONY_DB_ROOT_PASSWORD='"${DB_ROOT_PASSWORD}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database root password "'"${DB_ROOT_PASSWORD}"'"'' ''to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Random database root password "'"${DB_ROOT_PASSWORD}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
