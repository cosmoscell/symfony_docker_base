set_project_name() {
  echo_section 'Project name'
  read -p 'Name your project (default: "'"${PROJECT_NAME_DEFAULT}"'"):'' ' PROJECT_NAME
  PROJECT_NAME=$(clean "${PROJECT_NAME}@" 'a-zA-Z0-9_' ${PROJECT_NAME_MAX_LENGTH})
  if [ "${PROJECT_NAME}" = '' ]; then
    PROJECT_NAME=${PROJECT_NAME_DEFAULT}
  fi
  sed -i 's/DOCKER_SYMFONY_PROJECT_NAME=/DOCKER_SYMFONY_PROJECT_NAME='"${PROJECT_NAME}"'/' ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot write the project name '"${PROJECT_NAME}"' to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Project name "'"${PROJECT_NAME}"'" written to'' '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    return 0
  fi
}
