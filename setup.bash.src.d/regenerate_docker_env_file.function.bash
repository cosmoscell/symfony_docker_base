regenerate_docker_env_file() {
  echo_section 'Regenerating Docker environment ('"${DOCKER_ENVIRONMENT_FILE}"')'
  chmod 644 ${DOCKER_ENVIRONMENT_FILE} ${DOCKER_ENVIRONMENT_DIST_FILE} 2> /dev/null
  cp ${DOCKER_ENVIRONMENT_DIST_FILE} ${DOCKER_ENVIRONMENT_FILE} 2> /dev/null
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot regenerate file '"${DOCKER_ENVIRONMENT_FILE}"
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo "${DOCKER_ENVIRONMENT_FILE}"' ''file regenerated from template'' '"${DOCKER_ENVIRONMENT_DIST_FILE}"
    echo ''
    return 0
  fi
}
