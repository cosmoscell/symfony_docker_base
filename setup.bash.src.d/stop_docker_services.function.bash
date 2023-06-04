function stop_docker_services() {
  echo_section 'Stopping Docker services'
  docker compose down 2> /dev/null
  if [ ${?} -ne 0 ]; then
    echo -e -n "${ANSI_ERROR}"' '
    echo 'Cannot stop Docker services'
    echo ''
    exit 1
  else
    echo -e -n "${ANSI_OK}"' '
    echo 'Docker services stopped'
    echo ''
    return 0
  fi
}
