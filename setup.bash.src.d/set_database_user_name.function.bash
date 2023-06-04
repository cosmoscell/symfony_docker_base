set_database_user_name() {
  echo_section 'Database user name'
  read -p 'Database username (default: random name as a security measure):'' ' DB_USER_NAME
  if [ "${DB_USER_NAME}" = '' ]; then
    DB_USER_NAME=$(get_random_token 'a-zA-Z0-9' ${DB_USER_NAME_MAX_LENGTH})
  fi
  sed -i 's/DOCKER_SYMFONY_DB_USER_NAME=/DOCKER_SYMFONY_DB_USER_NAME='"${DB_USER_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database username "'"${DB_USER_NAME}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Database username "'"${DB_USER_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
