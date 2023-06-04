load_docker_env() {
  echo_section 'Loading Docker environment (from '"${DOCKER_ENVIRONMENT_FILE}"')'
  if [ ! -f ${DOCKER_ENVIRONMENT_FILE} ]; then
      echo -e -n "${ANSI_ERROR}"' '
      echo 'File'' '"${DOCKER_ENVIRONMENT_FILE}"' ''does not exist'
      echo ''
      exit 1
  fi
  source ${DOCKER_ENVIRONMENT_FILE}
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot load file '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo "${DOCKER_ENVIRONMENT_FILE}"' ''file loaded'
    echo ''
    return 0
  fi
}
