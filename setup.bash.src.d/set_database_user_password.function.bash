set_database_user_password() {
  echo_section 'Database user password'
  DB_USER_PASSWORD=$(get_random_token ${PASSWORD_CHARSET} ${RANDOM_PASSWORD_LENGTH})
  sed -i 's/DOCKER_SYMFONY_DB_USER_PASSWORD=/DOCKER_SYMFONY_DB_USER_PASSWORD='"${DB_USER_PASSWORD}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the database user password "'"${DB_USER_PASSWORD}"'" to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Random database user password "'"${DB_USER_PASSWORD}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
