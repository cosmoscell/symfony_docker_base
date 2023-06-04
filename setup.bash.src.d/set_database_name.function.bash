set_database_name() {
  echo_section 'Database name'
  read -p 'Name your database (default: random name as a security measure):'' ' DB_NAME
  DB_NAME=$(clean "${DB_NAME}@" 'a-zA-Z0-9' ${DB_NAME_MAX_LENGTH})
  if [ "${DB_NAME}" = '' ]; then
    DB_NAME=$(get_random_token 'a-zA-Z0-9' ${DB_NAME_MAX_LENGTH})
  fi
  sed -i 's/DOCKER_SYMFONY_DB_NAME=/DOCKER_SYMFONY_DB_NAME='"${DB_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database name "'"${DB_NAME}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Database name "'"${DB_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
