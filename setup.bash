#!/usr/bin/env bash

load_configuration() {
  if [ ! -f ${CONFIG_FILE} ]; then
    echo -e -n "\e[1m\e[31mERROR:\e[0m"' '
    echo 'config file '"${CONFIG_FILE}"' does not exists'
    echo ''
    exit 1
  fi
  chmod 644 ${CONFIG_FILE}
  . ${CONFIG_FILE}
  return 0
}

load_functions() {
  # @todo
}

load_configuration
load_functions
intro
usage ${@}
set_environment ${1}
set_ansi_ok_error_tags
regenerate_docker_env_file
set_project_name
set_project_timezone
set_database_name
set_database_root_password
set_database_user_name
set_database_user_password
load_docker_env
stop_docker_services
exit 0
